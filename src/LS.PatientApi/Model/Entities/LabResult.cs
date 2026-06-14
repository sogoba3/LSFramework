using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.Model.Entities.Shared;
using LS.PatientApi.Contstants;

namespace LS.PatientApi.Model.Entities;

[Table(PatientConstant.PATIENT_API + "LabResult")]
public class LabResult : MultiTenantEntity
{
    [Key]
    public int LabResultID { get; set; }
    [Required]
    public int PatientID { get; set; }
    [Required,MaxLength(200)]
    public string TestName { get; set; } = string.Empty;
    public string? ResultSummary { get; set; }
    public string? FilePath { get; set; } // Path to PDF/image/etc.
    public DateTime CreationDate { get; set; }

    // Navigation
    public Patient Patient { get; set; } = null!;
}
