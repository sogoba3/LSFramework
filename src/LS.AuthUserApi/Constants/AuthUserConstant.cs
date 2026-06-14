using System;
using System.ComponentModel;
using System.Reflection;

namespace LS.AuthUserApi.Constants;

public static class AuthUserConstant
{
    //API Name
    public const string AUTH_USER_API = "AuthUserAPI_";
    //Roles strings
    public const string BASIC_USER = "Basic User";

    public const string ADMINISTRATOR = "Administrator";
    public const string DOCTOR = "Doctor";
    public const string Nurse = "Nurse";
    public const string RECEPTIONIST = "Receptionist";
    public const string PATIENT = "Patient";

    // User Status
    public const string ACTIVE = "Active";
    public const string ARCHIVED = "Archived";
    
}
