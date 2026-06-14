using System;

namespace LS.AppointmentApi.Contstants;

public static class AppointmentConstant
{
    public const string APPOINTMENT_API = "AppointmentAPI_";

    //Appointment workflow status
    public const string SCHEDULED = "Scheduled";
    public const string COMPLETED = "Completed";
    public const string CANCELLED = "Cancelled";

    //Reason for visit statuses
    public const string GENERAL = "General";
    public const string ILLNESS = "Illness";
    public const string CHRONIC_CONDITIONS = "Chronic Conditions";
    public const string EMERGENCY = "Emergency";
    public const string WOMEN_HEALTH = "Women’s Health";
    public const string CHILDREN_HEALTH = "Children’s Health";
    public const string MENTAL_HEALTH = "Mental Health";
    public const string OTHER = "Other";
}
