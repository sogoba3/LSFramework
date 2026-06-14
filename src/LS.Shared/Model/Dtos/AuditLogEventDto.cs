using System;

namespace LS.Shared.Model.Dtos;

public class AuditLogEventDto
{
    public int EventID { get; set; }
    public int TenantID { get; set; }
    public int? LafiyaSiraID { get; set; }
    public string Action { get; set; } = string.Empty; // Created/Updated/Deleted/Login/Logout/Other
    public string TableName { get; set; } = string.Empty;
    public int? RecordID { get; set; }
    public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    public string? Details { get; set; }            // redact PHI if required
    public string SourceService { get; set; } = string.Empty; // e.g., "PatientApi"
    public string? CorrelationId { get; set; }      // trace id
    public string? IpAddress { get; set; }
    public string? UserAgent { get; set; }
    public string? IdempotencyKey { get; set; }
}
