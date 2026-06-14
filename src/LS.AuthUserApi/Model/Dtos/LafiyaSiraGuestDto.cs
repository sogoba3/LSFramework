using System;
using LS.AuthUserApi.Model.Entities;

namespace LS.AuthUserApi.Model.Dtos;

public class LafiyaSiraGuestDto
{
    public LafiyaSiraGuest LafiyaSiraGuest { get; set; }
    public LafiyaSiraGuestDto(LafiyaSiraGuest lafiyaSiraGuest)
    {
        LafiyaSiraGuest = lafiyaSiraGuest;
    }
}
