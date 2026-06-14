using System;
using AutoMapper;
using LS.AppointmentApi.Model.Dtos;
using LS.AppointmentApi.Model.Entities;

namespace LS.AppointmentApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Appointment, AppointmentDto>().ReverseMap();
    }
}
