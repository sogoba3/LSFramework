using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.AuthUserApi.Constants;
using LS.AuthUserApi.Model.Interfaces;
using LS.Model.Entities.Shared;
using LS.Shared;

namespace LS.AuthUserApi.Model.Entities;

[Table(AuthUserConstant.AUTH_USER_API + "LafiyaSiraUser")]
public class LafiyaSiraUser : MultiTenantEntity, ILafiyaSiraUser
{
    [Key]
    public int LafiyaSiraUserID { get; set; }
    public string? CognitoId { get; set; }

    [Required, MaxLength(50)]
    public string Username { get; set; } = string.Empty;

    [Required, Phone, MaxLength(20), ConcurrencyCheck]
    public string PhoneNumber { get; set; } = string.Empty;

    [EmailAddress, ConcurrencyCheck]
    public string? Email { get; set; }

    [Required, MaxLength(100)]
    public string FirstName { get; set; } = string.Empty;

    [Required, MaxLength(100)]
    public string LastName { get; set; } = string.Empty;

    public string? MiddleName { get; set; }

    [Required]
    public string Gender { get; set; } = string.Empty;

    [MaxLength(50)]
    public string? Suffix { get; set; }
    [Required]
    public DateTime CreationDate { get; set; } = DateTime.UtcNow;

    public string MiddleInitial
    {
        get
        {
            if (string.IsNullOrEmpty(MiddleName))
            {
                return "";
            }
            return MiddleName[..1];
        }
    }
    public string FormattedName
    {
        get
        {
            string name = $"{LastName}, {FirstName}{(!string.IsNullOrWhiteSpace(MiddleInitial) ? " " + MiddleInitial : "")}";
            return name;
        }
    }
    //public string DefaultRole { get; set; } = RoleEnum.BasicUser.GetDescription();
    public string Role { get; set; } = RoleEnum.BasicUser.GetDescription();
    public string Status { get; set; } = UserStatus.Active.GetDescription();

    public enum RoleEnum
    {
        [Description(AuthUserConstant.BASIC_USER)]
        BasicUser = 0,

        [Description(AuthUserConstant.ADMINISTRATOR)]
        Administrator = 1,

        [Description(AuthUserConstant.DOCTOR)]
        Doctor = 2,

        [Description(AuthUserConstant.Nurse)]
        Nurse = 3,

        [Description(AuthUserConstant.RECEPTIONIST)]
        Receptionist = 4,

        [Description(AuthUserConstant.PATIENT)]
        Patient = 5
    }

    public enum UserStatus
    {
        [Description(AuthUserConstant.ACTIVE)]
        Active = 0,
        [Description(AuthUserConstant.ARCHIVED)]
        Archived = 1
    }

    public enum GenderStatus
    {
        [Description("Mâle")]
        Male = 0,
        [Description("Femelle")]
        Female = 1,
        [Description("Unknown")]
        UnknownOther = 2,
        [Description("Autre")]
        Other = 3,
    }
    
}
