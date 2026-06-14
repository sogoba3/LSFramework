using Amazon.CognitoIdentityProvider;
using AutoMapper;
using LS.DoctorApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.DoctorApi.Controllers
{
    [Route(PATH_DOCTOR)]
    [ApiController]
    public class DoctorController : ControllerBase
    {
        private const string PATH_DOCTOR = "doctor";

        private ResultDto _result;
        private IDoctorRepository _doctorRepository;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;

        public DoctorController(IDoctorRepository doctorRepository, IAmazonCognitoIdentityProvider cognitoClient,IMapper mapper, IOptions<AwsSettings> awsSettings)
        {
            _result = new ResultDto();
            _doctorRepository = doctorRepository;
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
