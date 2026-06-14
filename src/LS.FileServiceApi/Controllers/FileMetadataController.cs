using Amazon.CognitoIdentityProvider;
using Amazon.S3;
using Amazon.S3.Model;
using AutoMapper;
using LS.FileServiceApi.Models.Dtos;
using LS.FileServiceApi.Models.Entities;
using LS.FileServiceApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using LS.Shared.Events;
using LS.Shared.Interfaces;
using LS.Shared.Model.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.FileServiceApi.Controllers
{
    [Route(PATH_FILE_METADATA)]
    [ApiController]
    public class FileMetadataController : ControllerBase
    {
        private const string PATH_FILE_METADATA = "file-metadata";

        private ResultDto _result;
        private readonly IFileMetadataRepository _fileMetadataRepository;
        private readonly ITenantProvider _tenantProvider;
        private readonly IAmazonS3 _s3Client;
        private readonly string _bucketName;
        private IMapper _mapper;
        AuditLogPublisher _auditLogPublisher;

        public FileMetadataController(IFileMetadataRepository fileMetadataRepository, ITenantProvider tenantProvider, IAmazonS3 s3Client, IMapper mapper, IOptions<AwsSettings> awsSettings, AuditLogPublisher auditLogPublisher)
        {
            _result = new ResultDto();
            _mapper = mapper;
            _fileMetadataRepository = fileMetadataRepository;
            _tenantProvider = tenantProvider;
            _s3Client = s3Client;
            _bucketName = awsSettings.Value.S3.BucketName;
            _auditLogPublisher = auditLogPublisher;

        }
        
        /// <summary>
        /// Get pre-signed S3 upload URL
        /// </summary>
        [HttpPost("upload-url")]
        public IActionResult GetUploadUrl([FromQuery] string fileName)
        {
            var tenantId = _tenantProvider.GetTenantId();
            if (tenantId <= 0) return Unauthorized("Tenant not found");

            var fileKey = $"tenant-{tenantId}/{Guid.NewGuid()}_{fileName}";

            var request = new GetPreSignedUrlRequest
            {
                BucketName = _bucketName,
                Key = fileKey,
                Verb = HttpVerb.PUT,
                Expires = DateTime.UtcNow.AddMinutes(10)
            };

            var uploadUrl = _s3Client.GetPreSignedURL(request);

            return Ok(new { uploadUrl, fileKey });
        }

        /// <summary>
        /// Save file metadata after upload
        /// </summary>
        [HttpPost("save-metadata")]
        public async Task<IActionResult> SaveMetadata([FromBody] SaveFileMetadataDto dto)
        {
            var tenantId = _tenantProvider.GetTenantId();
            if (tenantId <= 0) return Unauthorized("Tenant not found");

            var fileMetadata = new FileMetadata
            {
                FileKey = dto.FileKey,
                FileName = dto.FileName,
                ContentType = dto.ContentType
            };

            await _fileMetadataRepository.AddAsync(fileMetadata);

            // _auditLogPublisher.PublishAuditLogEvent(new AuditLogEventDto
            // {
            //     TenantID = tenantId,

            // });

            return Ok(fileMetadata);
        }

        /// <summary>
        /// Get pre-signed S3 download URL
        /// </summary>
        [HttpGet("download-url")]
        public IActionResult GetDownloadUrl([FromQuery] string fileKey)
        {
            var tenantId = _tenantProvider.GetTenantId();
            if (tenantId <= 0) return Unauthorized("Tenant not found");

            if (!fileKey.StartsWith($"tenant-{tenantId}/"))
                return Unauthorized("Access denied");

            var request = new GetPreSignedUrlRequest
            {
                BucketName = _bucketName,
                Key = fileKey,
                Verb = HttpVerb.GET,
                Expires = DateTime.UtcNow.AddMinutes(10)
            };

            var downloadUrl = _s3Client.GetPreSignedURL(request);
            return Ok(new { downloadUrl });
        }

        /// <summary>
        /// List all files for current tenant
        /// </summary>
        [HttpGet("list")]
        public async Task<IActionResult> GetFiles()
        {
            var files = _fileMetadataRepository.GetAll();
            return Ok(files);
        }
    
    }
}
