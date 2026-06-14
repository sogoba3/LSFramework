using Amazon.CognitoIdentityProvider;
using AutoMapper;
using LS.AuditApi.Model.Entities;
using LS.AuditApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.AuditApi.Controllers
{
    [Route(PATH_AUDIT_LOG)]
    [ApiController]
    public class AuditLogController : ControllerBase
    {
        private const string PATH_AUDIT_LOG = "audit-log";
        private readonly IAuditLogRepository _auditLogRepository;
        private ResultDto _result;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;


        public AuditLogController(IAuditLogRepository auditLogRepository, IAmazonCognitoIdentityProvider cognitoClient,IMapper mapper, IOptions<AwsSettings> awsSettings)
        {
            _auditLogRepository = auditLogRepository;
            _result = new ResultDto();
            _cognitoClient = cognitoClient;
            _mapper = mapper;
            if (string.IsNullOrWhiteSpace(awsSettings.Value.UserPoolId))
            {
                throw new ArgumentNullException(nameof(awsSettings.Value.UserPoolId),
                    " Cognito UserPoolId is missing from AwsSettings. Check appsettings.json.");
            }
            _userPoolId = awsSettings.Value.UserPoolId;
            _clientId = awsSettings.Value.ClientId;
        }

        /// <summary>
        /// Get all audit logs for the current tenant
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AuditLog>>> GetAll()
        {
            var logs = _auditLogRepository.GetAll();
            return Ok(logs.OrderByDescending(l => l.Timestamp));
        }

        /// <summary>
        /// Get all logs for a specific user (within current tenant)
        /// </summary>
        [HttpGet("user/{lafiyaSiraId:int}")]
        public async Task<ActionResult<IEnumerable<AuditLog>>> GetByUser(int lafiyaSiraId)
        {
            var logs = await _auditLogRepository.GetByUserAsync(lafiyaSiraId);
            if (logs == null || !logs.Any())
                return NotFound($"No logs found for user ID {lafiyaSiraId}");

            return Ok(logs);
        }

        /// <summary>
        /// Get all logs for a specific action type (e.g., Created, Updated)
        /// </summary>
        [HttpGet("action/{actionName}")]
        public async Task<ActionResult<IEnumerable<AuditLog>>> GetByAction(string actionName)
        {
            if (!Enum.TryParse<AuditLog.AuditAction>(actionName, true, out var parsedAction))
                return BadRequest("Invalid action type");

            var logs = await _auditLogRepository
                .FindAsync(a => a.Action == parsedAction.ToString());

            if (logs == null || !logs.Any())
                return NotFound($"No logs found for action {actionName}");

            return Ok(logs.OrderByDescending(a => a.Timestamp));
        }

        /// <summary>
        /// Add a new audit log entry
        /// </summary>
        [HttpPost]
        public async Task<ActionResult<AuditLog>> Create([FromBody] AuditLog auditLog)
        {
            if (auditLog == null)
                return BadRequest("Invalid audit log data");

            // Ensure timestamp and action fields are correctly set
            auditLog.Timestamp = DateTime.UtcNow;

            await _auditLogRepository.AddAsync(auditLog);
            //await _auditLogRepository.SaveChangesAsync();

            return CreatedAtAction(nameof(GetAll), new { id = auditLog.LogID }, auditLog);
        }

        /// <summary>
        /// Delete a specific audit log by ID
        /// </summary>
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var existing = await _auditLogRepository.GetByIdAsync(id);
            if (existing == null)
                return NotFound("Log not found");

            await _auditLogRepository.DeleteAsync(existing);
            //await _auditLogRepository.SaveChangesAsync();

            return NoContent();
        }
    
    }
}
