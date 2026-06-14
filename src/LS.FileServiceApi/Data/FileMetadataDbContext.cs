using System;
using LS.FileServiceApi.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace LS.FileServiceApi.Data;

public class FileMetadataDbContext : DbContext
{
    public FileMetadataDbContext(DbContextOptions<FileMetadataDbContext> options) : base(options)
    {

    }

    public DbSet<FileMetadata> FileMetadata { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
                

    }
}
