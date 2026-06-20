using Amazon;
using Amazon.CognitoIdentityProvider;
using Amazon.SimpleNotificationService;
using Amazon.SQS;
using LS.AuthUserApi.Data;
using LS.AuthUserApi.Events.Publisher;
using LS.AuthUserApi.Mapping;
using LS.AuthUserApi.Services;
using LS.AuthUserApi.Services.IServices;
using LS.Shared.Configuration;
using LS.Shared.Events;
using LS.Shared.Interfaces;
using LS.Shared.Middleware;
using LS.Shared.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AuthUserDbContext>(option =>
{
  option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
});

// Add CORS services
// builder.Services.AddCors(options =>
// {
//     options.AddPolicy("AllowFrontend", policy =>
//     {
//         policy.WithOrigins("http://localhost:5173") // my frontend URL
//               .AllowAnyHeader()
//               .AllowAnyMethod()
//               .AllowCredentials(); // if sending cookies/auth
//     });
// });
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

//Using aws cognito for sign in / sign up objectives
// var clientId = "70q2ap1l18gl8eno8ask5415r8";
var awsSettings = builder.Configuration.GetSection("AwsSettings").Get<AwsSettings>() ?? throw new Exception("AwsSettings missing");
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
  .AddJwtBearer(options =>
  {
    options.Authority = "https://cognito-idp.{awsSettings.Region}.amazonaws.com/{awsSettings.UserPoolId}";
    options.Audience = awsSettings.ClientId;
    // clientId;
    options.TokenValidationParameters = new TokenValidationParameters
    {
      ValidateIssuer = true,
      ValidateAudience = true,
      ValidateLifetime = true,

      // Tell ASP.NET Core to treat cognito:groups as roles
      RoleClaimType = "cognito:groups"
    };
  });

// Bind AwsSettings from config
builder.Services.Configure<AwsSettings>(
    builder.Configuration.GetSection("AwsSettings")
);
// Read AWS settings
// var awsOptions = builder.Configuration.GetSection("AwsSettings");
// var region = RegionEndpoint.GetBySystemName(awsOptions["Region"]);

var regionName =
    builder.Configuration["AwsSettings:Region"];

if (string.IsNullOrWhiteSpace(regionName))
{
    throw new Exception("AwsSettings:Region is missing from configuration.");
}

var region = RegionEndpoint.GetBySystemName(regionName);
// Register Cognito client
builder.Services.AddDefaultAWSOptions(builder.Configuration.GetAWSOptions());
builder.Services.AddAWSService<IAmazonCognitoIdentityProvider>(
  new Amazon.Extensions.NETCore.Setup.AWSOptions
  {
    Region = region ?? Amazon.RegionEndpoint.USEast2
  }
);

//SQS
builder.Services.AddSingleton<IAmazonSQS>(sp =>
    new AmazonSQSClient(region));
//SNS
builder.Services.AddSingleton<IAmazonSimpleNotificationService>(sp =>
    new AmazonSimpleNotificationServiceClient(region));

builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<ITenantProvider, TenantProvider>();
builder.Services.AddScoped<IAuthUserRepository, AuthUserRepository>();

// Publisher
builder.Services.AddScoped<AuditLogPublisher>();
builder.Services.AddScoped<AuthUserEventPublisher>();

// AutoMapper
builder.Services.AddAutoMapper(typeof(MappingConfig));

// HttpClient for external services
builder.Services.AddHttpClient("LS.TenantApi", client =>
{
    var baseUrl = builder.Configuration["Services:TenantApiBaseUrl"]
        ?? throw new InvalidOperationException(
            "Services:TenantApiBaseUrl is not configured.");

    client.BaseAddress = new Uri(baseUrl);
});

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddAuthorization();
builder.Services.AddControllers();

Console.WriteLine($"UserPoolId={builder.Configuration["AwsSettings:UserPoolId"]}");

Console.WriteLine($"ClientId={builder.Configuration["AwsSettings:ClientId"]}");

Console.WriteLine($"TenantApiBaseUrl={builder.Configuration["Services:TenantApiBaseUrl"]}");

var app = builder.Build();

// Use CORS
// app.UseCors("AllowFrontend");
app.UseCors("AllowAll");

// app.UseExceptionHandler(errorApp =>
// {
//   errorApp.Run(async context =>
//   {
//     var exceptionHandlerPathfeature = context.Features.Get<IExceptionHandlerPathFeature>();
//     var exception = exceptionHandlerPathfeature?.Error;
    
//   });
// });

// Configure the HTTP request pipeline.
if (!app.Environment.IsProduction())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
if (!app.Environment.IsDevelopment())
{
  app.UseHttpsRedirection();
}


app.UseAuthentication();
app.UseAuthorization();

// Tenant Middleware must run after authentication
app.UseMiddleware<TenantMiddleware>();

app.MapControllers();

app.Run();
