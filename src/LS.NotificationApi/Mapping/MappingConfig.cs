using System;
using AutoMapper;
using LS.NotificationApi.Model.Dtos;
using LS.NotificationApi.Model.Entities;

namespace LS.NotificationApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Notification, NotificationDto>().ReverseMap();
    }
}
