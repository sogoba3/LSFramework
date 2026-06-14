using System;
using LS.AuthUserApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.AuthUserApi.Data;

public class AuthUserDbContext : DbContext
{
    public AuthUserDbContext(DbContextOptions<AuthUserDbContext> options) : base(options)
    {

    }

    public DbSet<LafiyaSiraUser> LafiyaSiraUsers { get; set; }
    public DbSet<LafiyaSiraGuest> LafiyaSiraGuests { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

    }

}
