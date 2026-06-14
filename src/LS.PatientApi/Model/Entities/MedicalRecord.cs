using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.PatientApi.Contstants;

namespace LS.PatientApi.Model.Entities;

[Table(PatientConstant.PATIENT_API + "MedicalRecord")]
public class MedicalRecord
{
    [Key]
    public int MedicalRecordID { get; set; }
    [Required]
    public int PatientId { get; set; }
    // Navigation
    public Patient Patient { get; set; } = null!;
    [Required,MaxLength(500)]
    public string Diagnosis { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public ICollection<Prescription> Prescriptions { get; set; } = new List<Prescription>(); // Could be JSON or linked to separate table
    public ICollection<LabResult> LabResults { get; set; } = new List<LabResult>();// File path or JSON
    [Required]
    public DateTime CreationDate { get; set; } = DateTime.UtcNow;
}
