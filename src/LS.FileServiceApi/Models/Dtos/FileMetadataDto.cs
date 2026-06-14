using System;
using LS.FileServiceApi.Models.Entities;

namespace LS.FileServiceApi.Models.Dtos;

public class FileMetadataDto
{
    public FileMetadata FileMetadata { get; set; }

    public FileMetadataDto(FileMetadata fileMetadata)
    {
        FileMetadata = fileMetadata;
    }
}
