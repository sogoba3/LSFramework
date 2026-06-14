using System;
using AutoMapper;
using LS.DoctorApi.Model.Dtos;
using LS.DoctorApi.Model.Entities;

namespace LS.DoctorApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Doctor, DoctorDto>().ReverseMap();
    }
}
