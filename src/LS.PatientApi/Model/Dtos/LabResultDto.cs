using System;
using LS.PatientApi.Model.Entities;

namespace LS.PatientApi.Model.Dtos;

public class LabResultDto
{
    public LabResult LabResult { get; set; }

    public LabResultDto(LabResult result)
    {
        LabResult = result;
    }

}
