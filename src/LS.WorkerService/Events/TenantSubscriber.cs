using System;
using System.Text.Json;
using Amazon.SQS;
using Amazon.SQS.Model;
using LS.AuthUserApi.Data;
using LS.AuthUserApi.Model.Entities;
using LS.AuthUserApi.Services;
using LS.AuthUserApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using LS.Shared.Interfaces;
using LS.WorkerService.EventsDto.AuthEventsDto;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using static LS.AuthUserApi.Model.Entities.LafiyaSiraUser;

namespace LS.WorkerService.Events;

public class TenantSubscriber : BackgroundService
{
    private readonly IAmazonSQS _sqsClient;
    private readonly IServiceProvider _serviceProvider;
    //private readonly string _tenantAdminSignedUpQueueUrl;
    private readonly AwsSettings _awsSettings;

    public TenantSubscriber(IAmazonSQS sqsClient, IServiceProvider serviceProvider, IOptions<AwsSettings> awsSettings)
    {
        _sqsClient = sqsClient;
        _serviceProvider = serviceProvider;
        _awsSettings = awsSettings.Value;
        //_tenantAdminSignedUpQueueUrl = configuration["AwsSettings:SQS:TenantAdminSignedUpQueueUrl"];
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        //_logger.LogInformation("AuthUserSubscriber started. Listening for multiple event types...");
        Console.WriteLine("TenantSubscriber started and listening for messages...");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await ProcessTenantAdminSignedUpMessages(stoppingToken);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[Subscriber Error] {ex}");
            }

            await Task.Delay(TimeSpan.FromSeconds(5), stoppingToken);
        }
    }

    /// <summary>
    /// Tenant Admin Signup Messages
    /// </summary>
    /// <param name="stoppingToken"></param>
    /// <returns></returns>
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    private async Task ProcessTenantAdminSignedUpMessages(CancellationToken stoppingToken)
    {
        var queueUrl = _awsSettings.SQS?.TenantAdminSignedUpQueueUrl;

        if (string.IsNullOrEmpty(queueUrl))
        {
            Console.WriteLine("[Warning] Queue URL not configured in AwsSettings.");
            return;
        }

        var request = new ReceiveMessageRequest
        {
            QueueUrl = queueUrl,
            MaxNumberOfMessages = 5,
            WaitTimeSeconds = 20
        };
        ReceiveMessageResponse response;
        try
        {
            response = await _sqsClient.ReceiveMessageAsync(request, stoppingToken);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[SQS Error] Failed to receive messages: {ex.Message}");
            return;
        }
        if (response.Messages == null || response.Messages.Count == 0)
            return;

        foreach (var message in response.Messages)
        {
            try
            {
                var eventData = JsonSerializer.Deserialize<TenantAdminSignUpEventDto>(message.Body);
                if (eventData == null)
                {
                    Console.WriteLine("[Warning] Received empty or invalid message body.");
                    continue;
                }

                //Create a DI scope for each message
                using var scope = _serviceProvider.CreateScope();

                // Resolve the tenant provider from DI and set tenant ID dynamically
                var tenantProvider = scope.ServiceProvider.GetRequiredService<ITenantProvider>();
                tenantProvider.SetTenantId(eventData.TenantID);

                // Resolve repository normally — it will automatically use tenantProvider
                var authUserRepository = scope.ServiceProvider.GetRequiredService<IAuthUserRepository>();

                var adminUser = new LafiyaSiraUser
                {
                    Username = eventData.Username,
                    CognitoId = eventData.CognitoId,
                    FirstName = eventData.FirstName,
                    LastName = eventData.LastName,
                    Email = eventData.Email,
                    PhoneNumber = eventData.PhoneNumber,
                    Gender = eventData.Gender,
                    Role = RoleEnum.Administrator.GetDescription(),
                    TenantID = eventData.TenantID,
                    CreationDate = DateTime.UtcNow
                };

                await authUserRepository.AddAsync(adminUser);

                Console.WriteLine($"[Info] Tenant admin created for TenantID={eventData.TenantID}");

                await _sqsClient.DeleteMessageAsync(queueUrl, message.ReceiptHandle, stoppingToken);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[Message Processing Error] {ex}");
            }
        }

    }

}
