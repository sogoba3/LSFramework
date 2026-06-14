using System;
using AutoMapper;
using LS.AuthUserApi.Model.Dtos;
using LS.AuthUserApi.Model.Entities;

namespace LS.AuthUserApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<LafiyaSiraUser, LafiyaSiraUserDto>().ReverseMap();
        CreateMap<LafiyaSiraGuest, LafiyaSiraGuestDto>().ReverseMap();
    }
    
//     public static MapperConfiguration RegisterMaps()
//     {
//         var mappingConfig = new MapperConfiguration(config =>
//         {
//             config.CreateMap<ApplicationUserDto, ApplicationUser>();
//             config.CreateMap<ApplicationUser, ApplicationUserDto>();
//         });
//         return mappingConfig;
//     }
}
