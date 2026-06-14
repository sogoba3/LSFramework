using Amazon.CognitoIdentityProvider;
using AutoMapper;
using LS.AppointmentApi.Services.IServices;
using LS.Shared;
using LS.Shared.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace LS.AppointmentApi.Controllers
{
    [Route(PATH_APPOINTMENT)]
    [ApiController]
    public class AppointmentController : ControllerBase
    {
        private const string PATH_APPOINTMENT = "appointment";

        private ResultDto _result;
        private IAppointmentRepository _appointmentRepository;
        private readonly IAmazonCognitoIdentityProvider _cognitoClient;
        private readonly string _userPoolId;
        private readonly string _clientId;
        private IMapper _mapper;

        public AppointmentController(IAppointmentRepository appointmentRepository, IAmazonCognitoIdentityProvider cognitoClient,IMapper mapper, IOptions<AwsSettings> awsSettings)
        {
            _result = new ResultDto();
            _appointmentRepository = appointmentRepository;
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
