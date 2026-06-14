using System;
using LS.TenantApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.TenantApi.Data;

public class TenantDbContext : DbContext
{
    public TenantDbContext(DbContextOptions options) : base(options) { }
    
    public DbSet<Tenant> Tenants { get; set; }
}
