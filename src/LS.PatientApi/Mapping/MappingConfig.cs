using System;
using AutoMapper;
using LS.PatientApi.Model.Dtos;
using LS.PatientApi.Model.Entities;

namespace LS.PatientApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Patient, PatientDto>().ReverseMap();
        CreateMap<MedicalRecord, MedicalRecordDto>().ReverseMap();
        CreateMap<LabResult, LabResultDto>().ReverseMap();
        CreateMap<ContactInformation, ContactInformationDto>().ReverseMap();
        CreateMap<Prescription, PrescriptionDto>().ReverseMap();
    }
}
