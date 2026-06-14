using System;
using LS.AuthUserApi.Model.Entities;

namespace LS.AuthUserApi.Model.Dtos;

public class LafiyaSiraUserDto
{
    public LafiyaSiraUser LafiyaSiraUser { get; set; }
    // Required by ASP.NET Core model binding
    public LafiyaSiraUserDto() { }
    public LafiyaSiraUserDto(LafiyaSiraUser lafiyaSiraUser)
    {
        LafiyaSiraUser = lafiyaSiraUser;
    }
}
