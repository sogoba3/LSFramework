using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LS.FileServiceApi.Constants;
using LS.Model.Entities.Shared;

namespace LS.FileServiceApi.Models.Entities;

[Table(FileConstant.FILE_SERVICE_API + "FileMetadata")]
public class FileMetadata : MultiTenantEntity
{
    [Key]
    public int FileMetadataID { get; set; }
    [Required, MaxLength(200)]
    public string FileName { get; set; } = string.Empty;
    [Required, MaxLength(500)]
    public string FileKey { get; set; } = string.Empty;
    [MaxLength(50)]
    public string? ContentType { get; set; }
    public DateTime UploadedAt { get; set; } = DateTime.UtcNow;
    public int UploadedBy { get; set; } // User ID
}
