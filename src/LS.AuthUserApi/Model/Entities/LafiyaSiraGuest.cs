using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.AuthUserApi.Constants;
using LS.AuthUserApi.Model.Interfaces;
using LS.Model.Entities.Shared;

namespace LS.AuthUserApi.Model.Entities;

[Table(AuthUserConstant.AUTH_USER_API + "LafiyaSiraGuest")]
public class LafiyaSiraGuest : MultiTenantEntity, ILafiyaSiraUser
{
    [Key]
    public int LafiyaSiraGuestID { get; set; }
    [Required, MaxLength(50)]
    public string Username { get; set; } = string.Empty;
    [Required,Phone,MaxLength(20)]
    public string PhoneNumber { get; set; } = string.Empty;
    public string? Email { get; set; }
    [Required,MaxLength(100)]
    public string FirstName { get; set; } = string.Empty;
    [Required,MaxLength(100)]
    public string LastName { get; set; } = string.Empty;
    [MaxLength(100)]
    public string? MiddleName { get; set; }
    [MaxLength(50)]
    public string? Suffix { get; set; }
    [Required]
    public DateTime CreationDate { get; set; } = DateTime.UtcNow;
}
