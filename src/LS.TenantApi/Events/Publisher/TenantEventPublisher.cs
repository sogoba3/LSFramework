using System;
using System.Text.Json;
using Amazon.CognitoIdentityProvider.Model;
using Amazon.SimpleNotificationService;
using LS.Shared.Configuration;
using LS.Shared.Model.Dtos;
using LS.TenantApi.Model.Dtos;
using LS.TenantApi.Model.Entities;
using Microsoft.Extensions.Options;

namespace LS.TenantApi.Events.Publisher;

public class TenantEventPublisher
{
    private readonly IAmazonSimpleNotificationService _snsClient;
    private readonly AwsSettings _awsSettings;

    public TenantEventPublisher(IAmazonSimpleNotificationService snsClient, IOptions<AwsSettings> awsSettings)
    {
        _snsClient = snsClient;
        _awsSettings = awsSettings.Value;
    }

    public async Task PublishTenantAdminSignedUpTopic(TenantAdminSignupDto tenantAdminSignupDto, SignUpResponse signUpResponse, Tenant tenant)
    {
        // Create message payload for Auth User API
        var tenantSignupEvent = new
        {
            Username = tenantAdminSignupDto.AdminUsername,
            CognitoId = signUpResponse.UserSub,
            FirstName = tenantAdminSignupDto.AdminFirstName,
            LastName = tenantAdminSignupDto.AdminLastName,
            Email = tenantAdminSignupDto.AdminEmail,
            PhoneNumber = tenantAdminSignupDto.AdminPhoneNumber,
            Gender = tenantAdminSignupDto.AdminGender,
            TenantID = tenant.TenantID,
            CreationDate = DateTime.UtcNow
        };

        // Publish message to SNS topic
        var messageJson = JsonSerializer.Serialize(tenantSignupEvent);
        await _snsClient.PublishAsync(_awsSettings.SNS.TenantAdminSignedUpTopicArn, messageJson);
    }
}
