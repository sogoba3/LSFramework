using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.DoctorApi.Constants;
using LS.Model.Entities.Shared;

namespace LS.DoctorApi.Model.Entities;

[Table(DoctorConstant.DOCTOR_API + "Doctor")]
public class Doctor : MultiTenantEntity
{
    [Key]
    public int DoctorID { get; set; }
    [Required]
    public int LafiyaSiraID { get; set; }
    [Required, Range(0, 100)]
    public int YearsOfExperience { get; set; }
    [MaxLength(500)]
    public string? AvailableHours { get; set; }

    // Navigation
    //public IEnumerable<Appointment> Appointments { get; set; } = new List<Appointment>();
    //public IEnumerable<MedicalRecord> MedicalRecords { get; set; } = new List<MedicalRecord>();
    
    public string Qualification { get; set; } = string.Empty;
    public enum DoctorQualificationStatus
    {
        [Description("General Medical Degree")]
        MBBS = 0,
        [Description("Doctor of Medicine")]
        MD = 1,
        [Description("GP without specialization")]
        GeneralPractitioner = 2,
        [Description("Early career doctor")]
        MedicalOfficer = 3,
        [Description("Surgeons")]
        FWACS = 4,
        [Description("Physicians")]
        FWACP = 5,
        [Description("Diploma Child Health")]
        DiplomaChildHealth = 6,
        [Description("Diploma Obstetrics Gynecology")]
        DiplomaObstetricsGynecology = 7,
        [Description("Diploma Tropical Medicine")]
        DiplomaTropicalMedicine = 8,
        [Description("Nurse Practitioner")]
        NursePractitioner = 9,
        [Description("Physician Assistant")]
        PhysicianAssistant = 10,
        [Description("Community Health Officer")]
        CommunityHealthOfficer = 11,
    }
    public string Specialization { get; set; } = string.Empty;
    public enum DoctorSpecializationStatus
    {
        [Description("General Practice")]
        GeneralPractice = 0,
        [Description("Pediatrics")]
        Pediatrics = 1,
        [Description("Obstetrics Gynecology")]
        ObstetricsGynecology = 2,
        [Description("Internal Medicine")]
        InternalMedicine = 3,
        [Description("General Surgery")]
        GeneralSurgery = 4,
        [Description("Dentistry")]
        Dentistry = 5,
        [Description("Ophthalmology")]
        Ophthalmology = 6,
        [Description("ENT")]
        ENT = 7, //(Ear, Nose, Throat / Otolaryngology)
        [Description("Dermatology")]
        Dermatology = 8,
        [Description("Psychiatry")]
        Psychiatry = 9,
        [Description("Orthopedics")]
        Orthopedics = 10,
        [Description("Cardiology")]
        Cardiology = 11,
        [Description("Radiology")]
        Radiology = 12,
        [Description("Emergency Medicine")]
        EmergencyMedicine = 13,
    }
}
