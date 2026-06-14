using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.Model.Entities.Shared;
using LS.PatientApi.Contstants;

namespace LS.PatientApi.Model.Entities;

[Table(PatientConstant.PATIENT_API + "Prescription")]
public class Prescription : MultiTenantEntity
{
    [Key]
    public int PrescriptionID { get; set; }
    public int PatientID { get; set; }

    public string? Medication { get; set; }
    public string? Dosage { get; set; }
    public string? Instructions { get; set; }
    public DateTime IssuedDate { get; set; }
}
