using System;
using LS.AuthUserApi.Model.Entities;

namespace LS.AuthUserApi.Model.Dtos;

public class LafiyaSiraStaffDto
{
    public LafiyaSiraUser? LafiyaSiraUser { get; set; }
    public string StaffRole { get; set; } = string.Empty;
}
