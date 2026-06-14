using System;
using LS.DoctorApi.Model.Entities;

namespace LS.DoctorApi.Model.Dtos;

public class DoctorDto
{
    public Doctor Doctor { get; set; }
    public DoctorDto(Doctor doctor)
    {
        Doctor = doctor;
    }
}
