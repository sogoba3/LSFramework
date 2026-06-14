using Amazon.CognitoIdentityProvider;
using AutoMapper;
using LS.NotificationApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.NotificationApi.Controllers
{
    [Route(PATH_NOTIFICATION)]
    [ApiController]
    public class NotificationController : ControllerBase
    {
        private const string PATH_NOTIFICATION = "notification";

        private ResultDto _result;
        private INotificationRepository _notificationRepository;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;
    
        public NotificationController(INotificationRepository notificationRepository, IAmazonCognitoIdentityProvider cognitoClient,IMapper mapper, IOptions<AwsSettings> awsSettings)
        {
            _result = new ResultDto();
            _notificationRepository = notificationRepository;
            _cognitoClient = cognitoClient;
            _mapper = mapper;
            if (string.IsNullOrWhiteSpace(awsSettings.Value.UserPoolId))
            {
                throw new ArgumentNullException(nameof(awsSettings.Value.UserPoolId),
                    "❌ Cognito UserPoolId is missing from AwsSettings. Check appsettings.json.");
            }
            _userPoolId = awsSettings.Value.UserPoolId;
            _clientId = awsSettings.Value.ClientId;
        
        }
    }
}
