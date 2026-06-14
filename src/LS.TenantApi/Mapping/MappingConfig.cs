using System;
using AutoMapper;
using LS.TenantApi.Model.Dtos;
using LS.TenantApi.Model.Entities;

namespace LS.TenantApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Tenant, TenantDto>().ReverseMap();
    }
}
