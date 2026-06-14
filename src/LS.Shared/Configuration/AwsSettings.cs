using System;

namespace LS.Shared.Configuration;

public class AwsSettings
{
    public string Region { get; set; } = string.Empty;
    public string UserPoolId { get; set; } = string.Empty;
    public string ClientId { get; set; } = string.Empty;

    public SnsSettings SNS { get; set; } = new();
    public SqsSettings SQS { get; set; } = new();
    public S3Settings S3 { get; set; } = new();
}

public class SnsSettings
{
    public string TenantAdminSignedUpTopicArn { get; set; } = string.Empty;

    //Audit log
    public string AuditLogArn { get; set; } = string.Empty;
}

public class SqsSettings
{
    public string TenantAdminSignedUpQueueUrl { get; set; } = string.Empty;
}

public class S3Settings
{
    public string BucketName { get; set; } = string.Empty;
}
