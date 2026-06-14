using System;
using System.Text.Json;
using Amazon.SimpleNotificationService;
using LS.Shared.Configuration;
using LS.Shared.Interfaces;
using LS.Shared.Model.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace LS.Shared.Events;

public class AuditLogPublisher : IAuditLogPublisher
{
    private readonly IAmazonSimpleNotificationService _snsClient;
    private readonly AwsSettings _awsSettings;
    private readonly ILogger<AuditLogPublisher> _logger;
    private readonly ITenantProvider _tenantProvider;
    private readonly IHttpContextAccessor _http;

    public AuditLogPublisher(IAmazonSimpleNotificationService snsClient, IOptions<AwsSettings> awsSettings, IHttpContextAccessor http, ITenantProvider tenantProvider, ILogger<AuditLogPublisher> logger)
    {
        _snsClient = snsClient;
        _awsSettings = awsSettings.Value;
        _tenantProvider = tenantProvider;
        _logger = logger;
        _http = http;
    }

    public async Task PublishAuditLogEvent(AuditLogEventDto auditLogEventDto)
    {
        try
        {
            // Enrich audit info
            auditLogEventDto.TenantID = _tenantProvider.GetTenantId();
            auditLogEventDto.Timestamp = DateTime.UtcNow;
            auditLogEventDto.CorrelationId ??= _http.HttpContext?.TraceIdentifier;
            auditLogEventDto.IpAddress ??= _http.HttpContext?.Connection.RemoteIpAddress?.ToString();
            auditLogEventDto.UserAgent ??= _http.HttpContext?.Request.Headers["User-Agent"].ToString();
            auditLogEventDto.IdempotencyKey ??= $"{auditLogEventDto.SourceService}:{auditLogEventDto.TableName}:{auditLogEventDto.RecordID}:{auditLogEventDto.EventID}";

            // var json = JsonSerializer.Serialize(auditLogEventDto, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase });

            // Publish message to SNS topic
            var messageJson = JsonSerializer.Serialize(auditLogEventDto);
            await _snsClient.PublishAsync(_awsSettings.SNS.AuditLogArn, messageJson);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to publish audit log event {EventID}", auditLogEventDto.EventID);
            // optionally: fallback to local buffer (file or DB)
        }
    }
}
