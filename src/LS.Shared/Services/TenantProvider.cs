using System;
using System.Net.Http.Json;
using LS.Shared.Interfaces;
using LS.Shared.Model.Dtos;
using Microsoft.AspNetCore.Http;

namespace LS.Shared.Services;

public class TenantProvider : ITenantProvider
{
    private readonly IHttpContextAccessor _contextAccessor;
    private readonly HttpClient _httpClient;
    private int? _tenantId;


    public TenantProvider(IHttpContextAccessor contextAccessor, IHttpClientFactory httpClientFactory)
    {
        _contextAccessor = contextAccessor;
        _httpClient = httpClientFactory.CreateClient("LS.TenantApi");
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

    public async Task<int?> ResolveTenantIdBySubdomainAsync(string subdomain)
    {
        try
        {
            var response = await _httpClient.GetAsync($"/tenant/get-tenant-subdomain/{subdomain}");
            if (!response.IsSuccessStatusCode)
                return null;

            var tenant = await response.Content.ReadFromJsonAsync<TenantDto>();
            return tenant?.TenantID;
        }
        catch
        {
            return null;
        }
    }
}
