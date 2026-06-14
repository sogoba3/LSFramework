using System;

namespace LS.FileServiceApi.Models.Dtos;

public class SaveFileMetadataDto
{
    public string FileKey { get; set; } = string.Empty;
    public string FileName { get; set; } = string.Empty;
    public string? ContentType { get; set; }
}
