using System;
using LS.AuditApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.AuditApi.Data;

public class AuditLogDbContext : DbContext
{
    public AuditLogDbContext(DbContextOptions<AuditLogDbContext> options) : base(options) { }

    public DbSet<AuditLog> AuditLogs { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<AuditLog>().HasKey(a => a.LogID);
        modelBuilder.Entity<AuditLog>().Property(a => a.Timestamp).HasDefaultValueSql("GETUTCDATE()");
        modelBuilder.Entity<AuditLog>().HasIndex(a => a.TenantID);
    }
}
