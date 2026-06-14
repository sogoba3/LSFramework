using System;

namespace LS.AuthUserApi.Model.Dtos;

public class LafiyaSiraUserLoginDto
{
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string TenantSubdomain { get; set; } = string.Empty;
}
