using System;
using System.ComponentModel;
using System.Reflection;

namespace LS.Shared;

public static class CommonContstant
{
    public static string GetDescription(this Enum value)
    {
        if (value == null)
        {
            throw new ArgumentNullException("value");
        }
        string description = value.ToString();
        FieldInfo? fieldInfo = value.GetType().GetField(description);
        if (fieldInfo == null)
        {
            throw new ArgumentNullException("value");
        }
        DescriptionAttribute[] attributes = (DescriptionAttribute[])fieldInfo.GetCustomAttributes(typeof(DescriptionAttribute), false);
        if (attributes != null && attributes.Length > 0)
        {
            description = attributes[0].Description;
        }
        return description;
    }
}
