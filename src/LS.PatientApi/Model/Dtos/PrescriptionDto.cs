using System;
using LS.PatientApi.Model.Entities;

namespace LS.PatientApi.Model.Dtos;

public class PrescriptionDto
{
    public Prescription Prescription { get; set; }
    public PrescriptionDto(Prescription prescription)
    {
        Prescription = prescription;
    }
}
