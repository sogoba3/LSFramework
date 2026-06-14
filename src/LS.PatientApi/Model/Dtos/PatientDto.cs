using System;
using LS.PatientApi.Model.Entities;

namespace LS.PatientApi.Model.Dtos;

public class PatientDto
{
    public Patient Patient { get; set; }

    public PatientDto(){}
    public PatientDto(Patient patient)
    {
        Patient = patient;
    }
}
