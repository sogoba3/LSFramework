using System;
using LS.AuditApi.Data;
using LS.AuditApi.Model.Entities;
using LS.AuditApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace LS.AuditApi.Services;

public class AuditLogRepository : BaseRepository<AuditLog>, IAuditLogRepository
{
    private readonly AuditLogDbContext _auditLogDbContext;
    private readonly int _tenantId;
    private ResultDto _result;

    public AuditLogRepository(AuditLogDbContext auditLogDbContext, ITenantProvider tenantProvider) : base(auditLogDbContext, tenantProvider)
    {
        _auditLogDbContext = auditLogDbContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }

    public async Task<IEnumerable<AuditLog>> GetByUserAsync(int lafiyaSiraId)
    {
        return await _dbSet
            .Where(a => a.LafiyaSiraID == lafiyaSiraId && a.TenantID == CurrentTenantId)
            .OrderByDescending(a => a.Timestamp)
            .ToListAsync();
    }
}
