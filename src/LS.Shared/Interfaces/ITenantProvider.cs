using System;

namespace LS.Shared.Interfaces;

public interface ITenantProvider
{
    int GetTenantId();
    void SetTenantId(int tenantId);
    Task<int?> ResolveTenantIdBySubdomainAsync(string tenantCode);
}
