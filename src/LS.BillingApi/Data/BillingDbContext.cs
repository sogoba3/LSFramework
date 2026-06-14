using System;
using LS.BillingApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.BillingApi.Data;

public class BillingDbContext : DbContext
{
    public BillingDbContext(DbContextOptions<BillingDbContext> options) : base(options)
    {

    }

    public DbSet<Bill> Bills { get; set; }
    public DbSet<Payment> Payments { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

    }
}
