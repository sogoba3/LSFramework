using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.TenantApi.Constants;

namespace LS.TenantApi.Model.Entities;

[Table(TenantConstant.Tenant_API + "Tenant")]
public class Tenant
{
    [Key]
    public int TenantID { get; set; }

    [Required, MaxLength(200)]
    public string Name { get; set; } = string.Empty;
    [Required, MaxLength(200)]
    public string Subdomain { get; set; } = string.Empty;      // "hospitalA"
    public byte[]? Logo { get; set; }
    public string? LogoFileName { get; set; }
    public DateTime CreationDate { get; set; } = DateTime.UtcNow;
}
