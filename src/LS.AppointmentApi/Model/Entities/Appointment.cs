using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.AppointmentApi.Contstants;
using LS.Model.Entities.Shared;

namespace LS.AppointmentApi.Model.Entities;

[Table(AppointmentConstant.APPOINTMENT_API + "Appointment")]
public class Appointment : MultiTenantEntity
{
    [Key]
    public int AppointmentID { get; set; }
    [Required]
    public int PatientId { get; set; }
    [Required]
    public int DoctorId { get; set; }
    public DateTime ScheduledDate { get; set; }

    public string CurrentAppointmentState { get; set; } = string.Empty;
    public enum AppointmentWorkflowState
    {
        [Description(AppointmentConstant.SCHEDULED)]
        Scheduled = 0,

        [Description(AppointmentConstant.COMPLETED)]
        Completed = 1,

        [Description(AppointmentConstant.CANCELLED)]
        Cancelled = 2,
    }
    public string VisitStatus { get; set; } = ReasonForVisitStatus.General.ToString();
    public enum ReasonForVisitStatus
    {
        [Description(AppointmentConstant.GENERAL)]
        General = 0,

        [Description(AppointmentConstant.ILLNESS)]
        Illness = 1,

        [Description(AppointmentConstant.CHRONIC_CONDITIONS)]
        ChronicConditions = 2,

        [Description(AppointmentConstant.EMERGENCY)]
        Emergency = 3,

        [Description(AppointmentConstant.WOMEN_HEALTH)]
        WomenHealth = 4,

        [Description(AppointmentConstant.CHILDREN_HEALTH)]
        ChildrenHealth = 5,

        [Description(AppointmentConstant.MENTAL_HEALTH)]
        MentalHealth = 6,

        [Description(AppointmentConstant.OTHER)]
        Other = 7,
    }
}
