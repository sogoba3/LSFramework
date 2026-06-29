using System;

namespace LS.AuthUserApi.Model.Dtos;

public class LafiyaSiraUserLoginDto
{
    // this is tenant subdomain
    public string TenantCode { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    // public string TenantSubdomain { get; set; } = string.Empty;
}
