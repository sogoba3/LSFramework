using System;
using LS.TenantApi.Model.Entities;

namespace LS.TenantApi.Services.IServices;

public interface ITenantRepository
{
    Task<Tenant?> GetByIdAsync(int tenantId);
    Task<List<Tenant>> GetAllAsync();
    Task AddAsync(Tenant tenant);
    Task UpdateAsync(Tenant tenant);
    Task DeleteAsync(Tenant tenant);
        
    Task<Tenant?> GetTenantBySubdomain(string subdomain);
}
