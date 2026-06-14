using System;
using LS.PatientApi.Model.Entities;

namespace LS.PatientApi.Model.Dtos;

public class MedicalRecordDto
{
    public MedicalRecord MedicalRecord { get; set; }

    public MedicalRecordDto(MedicalRecord record)
    {
        MedicalRecord = record;
    }
}
