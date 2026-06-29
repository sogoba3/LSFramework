using System;
using System.Net.Http.Json;
using LS.Shared.Interfaces;
using LS.Shared.Model.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace LS.Shared.Services;

public class TenantProvider : ITenantProvider
{
    private readonly IHttpContextAccessor _contextAccessor;
    private readonly HttpClient _httpClient;
    private readonly ILogger<TenantProvider> _logger;
    private int? _tenantId;


    public TenantProvider(IHttpContextAccessor contextAccessor, IHttpClientFactory httpClientFactory, ILogger<TenantProvider> logger)
    {
        _contextAccessor = contextAccessor;
        _httpClient = httpClientFactory.CreateClient("LS.TenantApi");
        _logger = logger;
    }

    public int GetTenantId()
    {
        if (_tenantId.HasValue)
            return _tenantId.Value;

        var context = _contextAccessor.HttpContext;
        if (context?.Items["TenantID"] is int tenantId)
            return tenantId;

        return -1;
    }

    public void SetTenantId(int tenantId)
    {
        _tenantId = tenantId;
        _contextAccessor.HttpContext!.Items["TenantID"] = tenantId;
    }

    public async Task<int?> ResolveTenantIdBySubdomainAsync(string tenantCode)
    {
        try
        {
            var response = await _httpClient.GetAsync($"/api/tenant/get-tenant-subdomain/{tenantCode}");
            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning(
                "Tenant lookup failed for {Subdomain}. Status={Status}",
                tenantCode,
                response.StatusCode);
                return null;
            }
                

            var tenant = await response.Content.ReadFromJsonAsync<TenantDto>();
            return tenant?.TenantID;
        }
        catch(Exception ex)
        {
            _logger.LogError(ex,
            "Unable to resolve tenant {Subdomain}",
            tenantCode);
            return null;
        }
    }
}
