using System;
using AutoMapper;
using LS.BillingApi.Model.Dtos;
using LS.BillingApi.Model.Entities;

namespace LS.BillingApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Bill, BillDto>().ReverseMap();
        CreateMap<Payment, PaymentDto>().ReverseMap();
    }
}
