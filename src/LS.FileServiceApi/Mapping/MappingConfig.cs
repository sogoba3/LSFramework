using System;
using AutoMapper;
using LS.FileServiceApi.Models.Dtos;
using LS.FileServiceApi.Models.Entities;

namespace LS.FileServiceApi.Mapping;

public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<FileMetadata, FileMetadataDto>().ReverseMap();
    }
}
