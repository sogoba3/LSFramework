using System;
using LS.DoctorApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.DoctorApi.Data;

public class DoctorDbContext : DbContext
{
    public DoctorDbContext(DbContextOptions<DoctorDbContext> options) : base(options)
    {

    }

    public DbSet<Doctor> Doctors { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

    }
}
