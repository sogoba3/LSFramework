using Amazon.CognitoIdentityProvider;
using Amazon.CognitoIdentityProvider.Model;
using AutoMapper;
using LS.Shared;
using LS.Shared.Configuration;
using LS.Shared.Interfaces;
using LS.Shared.Model.Dtos;
using LS.TenantApi.Data;
using LS.TenantApi.Events.Publisher;
using LS.TenantApi.Model.Dtos;
using LS.TenantApi.Model.Entities;
using LS.TenantApi.Services.IServices;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.TenantApi.Controllers
{
    [Route("api/tenant")]
    [ApiController]
    public class TenantController : ControllerBase
    {
        // private const string PATH_TENANT = "api/tenant";
        //private readonly TenantDbContext _tenantDbContext;
        private ITenantRepository _tenantRepository;
        private ResultDto _result;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;
        private readonly TenantEventPublisher _tenantEventPublisher;
        // private readonly IAuditLogPublisher _auditLogPublisher;


        public TenantController(ITenantRepository tenantRepository, IAmazonCognitoIdentityProvider cognitoClient, IMapper mapper, IOptions<AwsSettings> awsSettings, TenantEventPublisher tenantEventPublisher, IAuditLogPublisher auditLogPublisher)
        {
            _tenantRepository = tenantRepository;
             _result = new ResultDto();
            _cognitoClient = cognitoClient;
            _mapper = mapper;
            if (string.IsNullOrWhiteSpace(awsSettings.Value.UserPoolId))
            {
                throw new ArgumentNullException(nameof(awsSettings.Value.UserPoolId),
                    "Cognito UserPoolId is missing from AwsSettings. Check appsettings.json.");
            }
            _userPoolId = awsSettings.Value.UserPoolId;
            _clientId = awsSettings.Value.ClientId;
            _tenantEventPublisher = tenantEventPublisher;
            // _auditLogPublisher = auditLogPublisher;
        }

        [HttpGet("get-tenant-subdomain/{subdomain}")]
        public async Task<IActionResult> GetTenantBySubdomain(string subdomain)
        {
            var tenant = await _tenantRepository.GetTenantBySubdomain(subdomain);

            if (tenant == null)
                return NotFound();

            return Ok(tenant);
        }

        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [HttpPost("admin-signup")]
        public async Task<IActionResult> AdminSignup([FromForm] TenantAdminSignupDto tenantAdminSignupDto)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            byte[]? logoBytes = null;
            string? logoFileName = null;
            //using var transaction = await _lafiyaSiraDbContext.Database.BeginTransactionAsync();
            try
            {
                if (tenantAdminSignupDto.LogoFile != null && tenantAdminSignupDto.LogoFile.Length > 0)
                {
                    using var ms = new MemoryStream();
                    await tenantAdminSignupDto.LogoFile.CopyToAsync(ms);
                    logoBytes = ms.ToArray();
                    logoFileName = tenantAdminSignupDto.LogoFile?.FileName;
                }

                // Create Tenant
                var subdomain = tenantAdminSignupDto.TenantName.Replace(" ", "").ToLower(); // simple slug
                var tenant = new Tenant
                {
                    Name = tenantAdminSignupDto.TenantName,
                    Subdomain = subdomain,
                    Logo = logoBytes,
                    LogoFileName = logoFileName,
                    CreationDate = DateTime.UtcNow
                };

                //_lafiyaSiraDbContext.Tenants.Add(tenant);
                //await _lafiyaSiraDbContext.SaveChangesAsync();
                await _tenantRepository.AddAsync(tenant);


                // Create Admin in Cognito
                // var tempPassword = PasswordGeneratorDto.GenerateTemporaryPassword();
                // var username = tenantAdminSignupDto.AdminFirstName[..1] + tenantAdminSignupDto.AdminLastName + Guid.NewGuid().ToString("N")[..6];

                // var createUserRequest = new AdminCreateUserRequest
                var signUpRequest = new SignUpRequest
                {
                    ClientId = _clientId,
                    Username = tenantAdminSignupDto.AdminUsername,
                    Password = tenantAdminSignupDto.AdminPassword,
                    // TemporaryPassword = tempPassword,
                    UserAttributes = new List<AttributeType>
                    {
                        new AttributeType { Name = "email", Value = tenantAdminSignupDto.AdminEmail },
                        new AttributeType { Name = "phone_number", Value = tenantAdminSignupDto.AdminPhoneNumber },
                        new AttributeType { Name = "given_name", Value = tenantAdminSignupDto.AdminFirstName },
                        new AttributeType { Name = "family_name", Value = tenantAdminSignupDto.AdminLastName },
                        new AttributeType { Name = "gender", Value = tenantAdminSignupDto.AdminGender },
                        new AttributeType { Name = "custom:tenant_id", Value = tenant.TenantID.ToString() }
                    }
                };
                var signUpResponse = await _cognitoClient.SignUpAsync(signUpRequest);
                // Auto-confirm admin user (so they don’t need verification)
                var confirmRequest = new AdminConfirmSignUpRequest
                {
                    UserPoolId = _userPoolId,
                    Username = tenantAdminSignupDto.AdminUsername
                };
                await _cognitoClient.AdminConfirmSignUpAsync(confirmRequest);

                // Add the user to the patient Cognito Group
                var cognitoGroupName = "Tenant_LafiyaSira";

                var addUserToGroupRequest = new AdminAddUserToGroupRequest
                {
                    UserPoolId = _userPoolId,
                    Username = tenantAdminSignupDto.AdminUsername,
                    GroupName = cognitoGroupName
                };
                await _cognitoClient.AdminAddUserToGroupAsync(addUserToGroupRequest);

                // Publish tenant admin signup event to SNS
                await _tenantEventPublisher.PublishTenantAdminSignedUpTopic(tenantAdminSignupDto,signUpResponse,tenant);

                var groupRequest = new AdminAddUserToGroupRequest
                {
                    GroupName = cognitoGroupName,
                    Username = tenantAdminSignupDto.AdminUsername, // Cognito username
                    UserPoolId = _userPoolId
                };
                await _cognitoClient.AdminAddUserToGroupAsync(groupRequest);

                //audit log
                // await _auditLogPublisher.PublishAuditLogEvent(new AuditLogEventDto
                // {
                    
                // });

                //await transaction.CommitAsync();

                _result.Message = "Tenant admin user has been created successfully!";
                return Ok(new
                {
                    Message = "Tenant and admin created successfully!",
                    TenantSubdomain = tenant.Subdomain,
                    Admin = tenantAdminSignupDto.AdminEmail, // adminUser.Email
                });


            }
            catch (Exception ex)
            {
                _result.HasError = true;
                _result.Message = $"Error creating Tenant admin user: {ex.Message}";
                return StatusCode(500, _result);
            }
        }

        // GET: api/tenants/{tenantId}/logo
        [HttpGet("get-logo/{tenantId}")]
        public async Task<IActionResult> GetLogo(int tenantId)
        {
            var tenant = await _tenantRepository.GetByIdAsync(tenantId);
            // await _lafiyaSiraDbContext.Tenants.FindAsync(tenantId);
            if (tenant?.Logo == null)
                return NotFound("Logo not found");

            return File(tenant.Logo, "image/png"); // you can store MIME type too if needed
        }

    }
    
}
