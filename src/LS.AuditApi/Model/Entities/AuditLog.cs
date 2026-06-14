using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using LS.Model.Entities.Shared;

namespace LS.AuditApi.Model.Entities;

public class AuditLog : MultiTenantEntity
{
    [Key]
    public int LogID { get; set; }
    [Required]
    public int LafiyaSiraID { get; set; }
    public string Action { get; set; } = string.Empty;
    [Required]
    [MaxLength(100)]
    public string TableName { get; set; } = string.Empty;
    public int? RecordId { get; set; }
    [Required]
    public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    [MaxLength(2000)]
    public string? Details { get; set; }

    public enum AuditAction
    {
        [Description("Created")]
        Created = 0,
        [Description("Updated")]
        Updated = 1,
        [Description("Deleted")]
        Deleted = 2,
        [Description("Viewed")]
        Viewed = 3,
        [Description("Login")]
        Login = 4,
        [Description("Logout")]
        Logout = 5,
        [Description("Other")]
        Other = 6,
    }
}
