using System;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.TenantApi.Data;
using LS.TenantApi.Model.Entities;
using LS.TenantApi.Services.IServices;
using Microsoft.EntityFrameworkCore;

namespace LS.TenantApi.Services;

public class TenantRepository : ITenantRepository
{
    private TenantDbContext _tenantDbContext;
    private ResultDto _result;
    public TenantRepository(TenantDbContext tenantDbContext)
    {
        _tenantDbContext = tenantDbContext;
        _result = new ResultDto();
    }
    public async Task<Tenant?> GetByIdAsync(int tenantId)
    {
        return await _tenantDbContext.Tenants.FindAsync(tenantId);
    }

    public async Task<List<Tenant>> GetAllAsync()
    {
        return await _tenantDbContext.Tenants.ToListAsync();
    }

    public async Task AddAsync(Tenant tenant)
    {
        _tenantDbContext.Tenants.Add(tenant);
        await _tenantDbContext.SaveChangesAsync();
    }

    public async Task UpdateAsync(Tenant tenant)
    {
        _tenantDbContext.Tenants.Update(tenant);
        await _tenantDbContext.SaveChangesAsync();
    }

    public async Task DeleteAsync(Tenant tenant)
    {
        _tenantDbContext.Tenants.Remove(tenant);
        await _tenantDbContext.SaveChangesAsync();
    }
        
    public async Task<Tenant?> GetTenantBySubdomain(string tenantCode)
    {
        if (string.IsNullOrWhiteSpace(tenantCode))
            return null;

        // 
        return await _tenantDbContext.Tenants
            .AsNoTracking()
            .FirstOrDefaultAsync(t => t.Subdomain.ToLower() == tenantCode.ToLower());
    }
}
