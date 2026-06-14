using System;
using LS.TenantApi.Model.Entities;

namespace LS.TenantApi.Model.Dtos;

public class TenantDto
{
    public Tenant Tenant { get; set; }
    public TenantDto(Tenant tenant)
    {
        Tenant = tenant;
    }
}
