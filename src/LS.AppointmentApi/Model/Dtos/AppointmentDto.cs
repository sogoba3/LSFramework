using System;
using LS.AppointmentApi.Model.Entities;

namespace LS.AppointmentApi.Model.Dtos;

public class AppointmentDto
{
    public Appointment Appointment { get; set; }

    public AppointmentDto(Appointment appointment)
    {
        Appointment = appointment;
    }
}
