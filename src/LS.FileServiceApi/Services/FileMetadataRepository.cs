

using LS.FileServiceApi.Data;
using LS.FileServiceApi.Models.Entities;
using LS.FileServiceApi.Services.IServices;
using LS.Shared;
using LS.Shared.CommonRepository;
using LS.Shared.Interfaces;

namespace LS.FileServiceApi.Services;

public class FileMetadataRepository : BaseRepository<FileMetadata>, IFileMetadataRepository
{
    private readonly FileMetadataDbContext _fileMetadataDbContext;
    private readonly int _tenantId;
    private ResultDto _result;
    
    public FileMetadataRepository(FileMetadataDbContext fileMetadataDbContext, ITenantProvider tenantProvider) : base(fileMetadataDbContext, tenantProvider)
    {
        _fileMetadataDbContext = fileMetadataDbContext;
        _result = new ResultDto();
        _tenantId = tenantProvider.GetTenantId();
    }
}
