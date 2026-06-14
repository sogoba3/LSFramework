using System;
using LS.PatientApi.Model.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.PatientApi.Data;

public class PatientDbContext : DbContext
{
    public PatientDbContext(DbContextOptions<PatientDbContext> options) : base(options)
    {

    }

    public DbSet<Patient> Patients { get; set; }
    public DbSet<ContactInformation> ContactInformation { get; set; }
    public DbSet<LabResult> LabResults { get; set; }
    public DbSet<MedicalRecord> MedicalRecords { get; set; }
    public DbSet<Prescription> Prescriptions { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

    }
}
