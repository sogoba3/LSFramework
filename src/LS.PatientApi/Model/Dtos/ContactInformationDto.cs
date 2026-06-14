using System;
using LS.PatientApi.Model.Entities;

namespace LS.PatientApi.Model.Dtos;

public class ContactInformationDto
{
    public ContactInformation ContactInformation { get; set; }

    public ContactInformationDto(ContactInformation contactInformation)
    {
        ContactInformation = contactInformation;
    }
}
