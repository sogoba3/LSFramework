using System;
using LS.AppointmentApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.AppointmentApi.Data;

public class AppointmentDBContext : DbContext
{
    public AppointmentDBContext(DbContextOptions<AppointmentDBContext> options) : base(options)
    {

    }
    public DbSet<Appointment> Appointments { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

    }
}
