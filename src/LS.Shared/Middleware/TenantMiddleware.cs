using System;
using LS.Shared.Interfaces;
using Microsoft.AspNetCore.Http;

namespace LS.Shared.Middleware;

public class TenantMiddleware
{
    private readonly RequestDelegate _next;

    public TenantMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context, ITenantProvider tenantProvider)
    {
         //
        // Bootstrap endpoints.
        // These MUST NOT resolve a tenant.
        //
        if (context.Request.Path.StartsWithSegments("/tenant/get-tenant-subdomain") ||
            context.Request.Path.StartsWithSegments("/api/tenant/admin-signup") ||
            context.Request.Path.StartsWithSegments("/api/tenant/get-tenant-subdomain") ||
            context.Request.Path.StartsWithSegments("/api/auth-user/login") ||
            context.Request.Path.StartsWithSegments("/api/auth-user/signup"))
        {
            await _next(context);
            return;
        }

        // Resolve your scoped service from the current request scope
        //var tenantRepo = serviceProvider.GetRequiredService<ITenantRepo>();
        int? tenantId = null;
        // 1 Try to get tenant from authenticated user claims JWT
        if (context.User.Identity?.IsAuthenticated == true)
        {
            var tenantIdClaim = context.User.FindFirst("custom:tenant_id");
            if (tenantIdClaim != null && int.TryParse(tenantIdClaim.Value, out var claimTenantId))
            {
                tenantId = claimTenantId;
            }
        }


        // 2️ If not found, fallback to subdomain
        if (tenantId == null || !tenantId.HasValue)
        {
            var host = context.Request.Host.Host; // e.g. "clinic.lafiyasira.com"
            //for local testing
            if (host == "localhost")
            {
                // fallback tenant for local testing
                tenantId = 15;
            }
            else
            {
                var parts = host.Split('.');
                if (parts.Length > 2)
                {
                    var subdomain = parts[0];
                    tenantId = await tenantProvider.ResolveTenantIdBySubdomainAsync(subdomain);
                }
            }
        
        }

        // 3️ Store tenantId in HttpContext.Items
        if (tenantId.HasValue)
        {
            // context.Items["TenantID"] = tenantId.Value;
            tenantProvider.SetTenantId(tenantId.Value);
        }

        await _next(context);
    }
    
}
