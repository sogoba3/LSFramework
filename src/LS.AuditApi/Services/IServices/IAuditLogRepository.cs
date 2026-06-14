using System;
using LS.AuditApi.Model.Entities;
using LS.Shared.CommonRepository;

namespace LS.AuditApi.Services.IServices;

public interface IAuditLogRepository : IBaseRepository<AuditLog>
{
    Task<IEnumerable<AuditLog>> GetByUserAsync(int lafiyaSiraId);
}
