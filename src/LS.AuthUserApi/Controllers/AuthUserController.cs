using Amazon.CognitoIdentityProvider;
using Amazon.CognitoIdentityProvider.Model;
using AutoMapper;
using LS.AuthUserApi.Controllers.Errors;
using LS.AuthUserApi.Data;
using LS.AuthUserApi.Model.Dtos;
using LS.AuthUserApi.Model.Entities;
using LS.AuthUserApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using LS.Shared.Interfaces;
using LS.Shared.Model.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.AuthUserApi.Controllers
{
    [Route("api/auth-user")]
    [ApiController]
    public class AuthUserController : ControllerBase
    {
        // private const string PATH_AUTH_USER = "api/auth-user";
        private const string PATH_GET_USERS = "get-users";
        private ResultDto _result;
        private IAuthUserRepository _authUserRepository;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;
        private readonly ITenantProvider _tenantProvider;

        public AuthUserController(IAuthUserRepository authUserRepository, IAmazonCognitoIdentityProvider cognitoClient, IMapper mapper, IOptions<AwsSettings> awsSettings, ITenantProvider tenantProvider)
        {
            _result = new ResultDto();
            _authUserRepository = authUserRepository;
            _cognitoClient = cognitoClient;
            _mapper = mapper;
            if (string.IsNullOrWhiteSpace(awsSettings.Value.UserPoolId))
            {
                throw new ArgumentNullException(nameof(awsSettings.Value.UserPoolId),
                    "Cognito UserPoolId is missing from AwsSettings. Check appsettings.json.");
            }
            _userPoolId = awsSettings.Value.UserPoolId;
            _clientId = awsSettings.Value.ClientId;
            _tenantProvider = tenantProvider;

        }

        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [HttpPost("login")]
        public async Task<ResultDto> LoginUser([FromForm] LafiyaSiraUserLoginDto lafiyaSiraUserLoginDto)
        {
            if (lafiyaSiraUserLoginDto == null)
            {
                _result.Message = AuthUserApiControllerError.GetUserError;
            }
            //using var transaction = await _lafiyaSiraDbContext.Database.BeginTransactionAsync();
            try
            {
                 // Step 1: Resolve tenant ID from subdomain (sent from frontend)
                var tenantId = await _tenantProvider.ResolveTenantIdBySubdomainAsync(lafiyaSiraUserLoginDto.TenantCode);
                if (tenantId == null)
                {
                    _result.HasError = true;
                    _result.Message = "Tenant not found";
                    _result.Result = tenantId;
                    return _result;
                }

                // Step 2: Tell TenantProvider to remember this tenant for current request
                _tenantProvider.SetTenantId(tenantId.Value);
        
                var authRequest = new AdminInitiateAuthRequest
                {
                    UserPoolId = _userPoolId,
                    ClientId = _clientId,
                    AuthFlow = AuthFlowType.ADMIN_NO_SRP_AUTH,
                    AuthParameters = new Dictionary<string, string>()
                };
                authRequest.AuthParameters.Add("USERNAME", lafiyaSiraUserLoginDto.Username);
                authRequest.AuthParameters.Add("PASSWORD", lafiyaSiraUserLoginDto.Password);
                var response = await _cognitoClient.AdminInitiateAuthAsync(authRequest);

                //await transaction.CommitAsync();
                var returnDto = new
                {
                    accessToken = response.AuthenticationResult.AccessToken,
                    idToken = response.AuthenticationResult.IdToken,
                    refreshToken = response.AuthenticationResult.RefreshToken,
                    tenantId = tenantId.Value
                };
                _result.Result = returnDto;
                return _result;

            }
            catch (Exception ex)
            {
                //await transaction.RollbackAsync();
                _result.HasError = true;
                _result.Message = $"Failed to login: {ex.Message}";
                _result.Errors.Add(_result.Message);
                return _result;
            }
        }


        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [HttpPost("signup")]
        public async Task<IActionResult> CreateUser([FromForm] LafiyaSiraUserSignupDto lafiyaSiraUserSignupDto)
        {
            if (lafiyaSiraUserSignupDto == null) return BadRequest("DTO is null.");
            if (!ModelState.IsValid) return BadRequest(ModelState);

            // resolve tenant ID once
            var tenantId = _tenantProvider.GetTenantId();
            if (tenantId <= 0)
            {
                // optionally resolve from subdomain if not already set
                tenantId = (await _tenantProvider.ResolveTenantIdBySubdomainAsync(lafiyaSiraUserSignupDto.TenantCode)) ?? -1;
                if (tenantId > 0)
                    _tenantProvider.SetTenantId(tenantId);
            }

            if (tenantId <= 0)
                return BadRequest(new { Message = "Tenant not found" });

            try
            {
                // Cognito signup
                var signUpRequest = new SignUpRequest
                {
                    ClientId = _clientId,
                    Username = lafiyaSiraUserSignupDto.Username,
                    Password = lafiyaSiraUserSignupDto.Password,
                    UserAttributes = new List<AttributeType>
                    {
                        new() { Name = "email", Value = lafiyaSiraUserSignupDto.Email ?? "" },
                        new() { Name = "phone_number", Value = lafiyaSiraUserSignupDto.PhoneNumber ?? "" },
                        new() { Name = "given_name", Value = lafiyaSiraUserSignupDto.FirstName },
                        new() { Name = "family_name", Value = lafiyaSiraUserSignupDto.LastName },
                        new() { Name = "gender", Value = lafiyaSiraUserSignupDto.Gender },
                        new() { Name = "custom:tenant_id", Value = tenantId.ToString() }
                    }
                };

                var signUpResponse = await _cognitoClient.SignUpAsync(signUpRequest);

                // Auto-confirm signup
                await _cognitoClient.AdminConfirmSignUpAsync(new AdminConfirmSignUpRequest
                {
                    UserPoolId = _userPoolId,
                    Username = lafiyaSiraUserSignupDto.Username
                });

                //Add user to Cognito group
                await _cognitoClient.AdminAddUserToGroupAsync(new AdminAddUserToGroupRequest
                {
                    UserPoolId = _userPoolId,
                    Username = lafiyaSiraUserSignupDto.Username,
                    GroupName = "Patient_LafiyaSira"
                });

                //Save to local Auth DB
                var user = new LafiyaSiraUser
                {
                    Username = lafiyaSiraUserSignupDto.Username,
                    CognitoId = signUpResponse.UserSub,
                    PhoneNumber = lafiyaSiraUserSignupDto.PhoneNumber ?? "",
                    FirstName = lafiyaSiraUserSignupDto.FirstName,
                    LastName = lafiyaSiraUserSignupDto.LastName,
                    Email = lafiyaSiraUserSignupDto.Email,
                    Gender = lafiyaSiraUserSignupDto.Gender,
                    TenantID = tenantId,
                    Role = LafiyaSiraUser.RoleEnum.Patient.GetDescription(),
                    CreationDate = DateTime.UtcNow
                };

                await _authUserRepository.AddAsync(user);

                _result.Result = _mapper.Map<LafiyaSiraUserDto>(user);
                _result.Message = "User has been saved successfully!";
                return Ok(_result);
            }
            catch (Exception ex)
            {
                _result.HasError = true;
                _result.Message = $"Error syncing user: {ex.Message}";
                return StatusCode(500, _result);
            }

        }

        /// <summary>
        /// Create LafiyaSira Personnel into LafiyaSira app.
        /// </summary>
        /// <param name="lafiyaSiraStaffDto">User data used to create LafiyaSira Staff</param>
        /// <returns></returns>
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [HttpPost("create-staff")]
        public async Task<IActionResult> CreateLafiyaSiraStaff([FromBody] LafiyaSiraStaffDto lafiyaSiraStaffDto)
        {
            if (lafiyaSiraStaffDto.LafiyaSiraUser == null || string.IsNullOrEmpty(lafiyaSiraStaffDto.StaffRole))
            {
                return BadRequest("Staff user and role are required.");
            }

            // resolve tenant ID once
            var tenantId = _tenantProvider.GetTenantId();
            if (tenantId == 0)
                return Unauthorized("Tenant not found in token.");

            //using var transaction = await _lafiyaSiraDbContext.Database.BeginTransactionAsync();
            try
            {
                var staff = lafiyaSiraStaffDto.LafiyaSiraUser;

                // Step 1: Create Cognito User
                var tempPassword = PasswordGeneratorDto.GenerateTemporaryPassword();
                var createUserRequest = new AdminCreateUserRequest
                {
                    UserPoolId = _userPoolId,
                    Username = staff.FirstName[..1] + staff.LastName + Guid.NewGuid().ToString("N")[..6],
                    TemporaryPassword = tempPassword,
                    UserAttributes = new List<AttributeType>
                {
                    new AttributeType { Name = "email", Value = staff.Email ?? "" },
                    new AttributeType { Name = "phone_number", Value = staff.PhoneNumber ?? "" },
                    new AttributeType { Name = "given_name", Value = staff.FirstName },
                    new AttributeType { Name = "family_name", Value = staff.LastName },
                    new AttributeType { Name = "gender", Value = staff.Gender },
                    new AttributeType { Name = "custom:tenant_id", Value = tenantId.ToString() }

                }
                };

                var createUserResponse = await _cognitoClient.AdminCreateUserAsync(createUserRequest);
                string cognitoUsername = createUserResponse.User.Username;

                // Step 2: Fetch Cognito "sub"
                var getUserResponse = await _cognitoClient.AdminGetUserAsync(new AdminGetUserRequest
                {
                    Username = cognitoUsername,
                    UserPoolId = _userPoolId
                });

                string? cognitoSub = getUserResponse.UserAttributes
                    .FirstOrDefault(a => a.Name == "sub")?.Value;

                // Step 3: Save to DB
                staff.CreationDate = DateTime.UtcNow;
                staff.Role = lafiyaSiraStaffDto.StaffRole;
                staff.CognitoId = cognitoSub;
                staff.Username = cognitoUsername;
                staff.TenantID = tenantId;

                //_lafiyaSiraDbContext.LafiyaSiraUsers.Add(staff);
                //await _lafiyaSiraDbContext.SaveChangesAsync();
                 await _authUserRepository.AddAsync(staff);

                _result.Result = _mapper.Map<LafiyaSiraUserDto>(staff);
                if (_result.Result == null)
                {
                    _result.HasError = true;
                    _result.Message = $"Failed to create staff with the {lafiyaSiraStaffDto.StaffRole} role";
                    return StatusCode(500, _result);
                }

                // Step 4: Add to StaffGroup
                var groupRequest = new AdminAddUserToGroupRequest
                {
                    GroupName = "Personnel_LafiyaSira",
                    Username = staff.Username, // Cognito username
                    UserPoolId = _userPoolId
                };
                await _cognitoClient.AdminAddUserToGroupAsync(groupRequest);

                //await transaction.CommitAsync();

                _result.Message = "User has been created successfully!";
                return Ok(new
                {
                    Staff = _result,
                    TemporaryPassword = tempPassword // return temp pw so admin can share it
                });
            }
            catch (Exception ex)
            {
                //await transaction.RollbackAsync();
                _result.HasError = true;
                _result.Message = $"Failed to create staff: {ex.Message}";
                return StatusCode(500, _result);
            }
        }

    }
}
