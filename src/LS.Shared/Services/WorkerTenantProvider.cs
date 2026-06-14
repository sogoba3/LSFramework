using System;
using LS.Shared.Interfaces;

namespace LS.Shared.Services;

// Lightweight tenant provider for background workers (no HttpContext)
public class WorkerTenantProvider : ITenantProvider
{
    private int _tenantId;
    private string? _tenantSubdomain;

    public int GetTenantId() => _tenantId;

    public string GetTenantSubdomain() => _tenantSubdomain ?? "Trnant not found";

    public void SetTenantId(int tenantId) => _tenantId = tenantId;

    public void SetTenantSubdomain(string subdomain) => _tenantSubdomain = subdomain;

    // Background services won’t resolve tenants via HTTP
    // You can implement SQS message-based tenant mapping here if needed
    public Task<int?> ResolveTenantIdBySubdomainAsync(string subdomain)
    {
        // In a worker, you typically receive subdomain from the message payload
        return Task.FromResult<int?>(null);
    }
        
}
