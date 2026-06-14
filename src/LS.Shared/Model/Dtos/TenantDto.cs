using System;

namespace LS.Shared.Model.Dtos;

public class TenantDto
{
    public int TenantID { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Subdomain { get; set; } = string.Empty;      // "hospitalA"
    public byte[]? Logo { get; set; }
    public string? LogoFileName { get; set; }
}
