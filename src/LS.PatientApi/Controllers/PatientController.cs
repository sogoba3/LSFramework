using Amazon.CognitoIdentityProvider;
using AutoMapper;
using LS.PatientApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.PatientApi.Controllers
{
    [Route(PATH_PATIENT)]
    [ApiController]
    public class PatientController : ControllerBase
    {
        private const string PATH_PATIENT = "patient";

        private ResultDto _result;
        //private AuthUserDbContext _authUserDbContext;
        private IPatientRepository _patientRepository;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;

        public PatientController(IPatientRepository patientRepository, IAmazonCognitoIdentityProvider cognitoClient,IMapper mapper, IOptions<AwsSettings> awsSettings)
        {
            _result = new ResultDto();
            _patientRepository = patientRepository;
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
