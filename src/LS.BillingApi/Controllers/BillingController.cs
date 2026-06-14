using Amazon.CognitoIdentityProvider;
using AutoMapper;
using LS.BillingApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.BillingApi.Controllers
{
    [Route(PATH_BILLING)]
    [ApiController]
    public class BillingController : ControllerBase
    {
        private const string PATH_BILLING = "billing";

        private ResultDto _result;
        private IBillingRepository _billingRepository;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;

        public BillingController(IBillingRepository billingRepository, IAmazonCognitoIdentityProvider cognitoClient,IMapper mapper, IOptions<AwsSettings> awsSettings)
        {
            _result = new ResultDto();
            _billingRepository = billingRepository;
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
