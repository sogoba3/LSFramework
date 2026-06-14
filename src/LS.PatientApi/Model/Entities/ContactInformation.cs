using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.PatientApi.Contstants;

namespace LS.PatientApi.Model.Entities;

[Table(PatientConstant.PATIENT_API + "PatientContactInfo")]
public class ContactInformation
{
    [Key]
    public int ContactInformationId { get; set; }
    public string PhoneNumber { get; set; } = null!;
    public string? AlternatePhoneNumber { get; set; }
    public string? Email { get; set; }
    public string? StreetAddress { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? PostalCode { get; set; }
    public string? Country { get; set; }

    // Emergency contact
    public string? EmergencyContactName { get; set; }
    public string? EmergencyContactRelationship { get; set; }
    public string? EmergencyContactPhone { get; set; }

    public bool CanReceiveSms { get; set; } = true;
    public bool CanReceiveEmail { get; set; } = true;

    // FK back to Patient
    public int? PatientID { get; set; }
    public Patient? Patient { get; set; } = null!;
    
}
