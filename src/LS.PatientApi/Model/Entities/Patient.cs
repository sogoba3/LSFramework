using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.Model.Entities.Shared;
using LS.PatientApi.Contstants;

namespace LS.PatientApi.Model.Entities;

[Table(PatientConstant.PATIENT_API + "Patient")]
public class Patient : MultiTenantEntity
{
    [Key]
    public int PatientID { get; set; }
    public int? LafiyaSiraUserID { get; set; }
    public int? GuestID { get; set; }
    [Required, MaxLength(100)]
    public string FirstName { get; set; } = string.Empty;
    [Required, MaxLength(100)]
    public string LastName { get; set; } = string.Empty;
    [Required]
    public DateTime DateOfBirth { get; set; }
    [Required]
    public string Gender { get; set; } = string.Empty;
    public ContactInformation? ContactInformation { get; set; }
    [Required]
    public DateTime CreationDate { get; set; } = DateTime.UtcNow;

    // Navigation
    //public IEnumerable<Appointment> Appointments { get; set; } = new List<Appointment>();
    public IEnumerable<MedicalRecord> MedicalRecords { get; set; } = new List<MedicalRecord>();
    //public IEnumerable<Bill> Bills { get; set; } = new List<Bill>();

    //assurance maladie obligatoire
    public string? AssuranceMaladieObligatoire { get; set; }

    public enum GenderStatus
    {
        [Description("Male")]
        Male = 0,
        [Description("Female")]
        Female = 1,
        [Description("Unknown")]
        UnknownOther = 2,
        [Description("Other")]
        Other = 3,
    }
    
}
