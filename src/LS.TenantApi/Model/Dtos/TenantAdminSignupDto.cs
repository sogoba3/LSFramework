using System;

namespace LS.TenantApi.Model.Dtos;

public class TenantAdminSignupDto
{
    public string TenantName { get; set; } = string.Empty;
    public string AdminUsername { get; set; } = string.Empty;
    public string AdminPassword { get; set; } = string.Empty;
    public string? AdminEmail { get; set; } = string.Empty;
    public string AdminPhoneNumber { get; set; } = string.Empty;
    public string AdminFirstName { get; set; } = string.Empty;
    public string AdminLastName { get; set; } = string.Empty;
    public string AdminGender { get; set; } = string.Empty;
     public IFormFile? LogoFile { get; set; } // <- receives the uploaded logo
}
