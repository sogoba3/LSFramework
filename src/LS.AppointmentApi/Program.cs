using Amazon;
using Amazon.CognitoIdentityProvider;
using Amazon.SimpleNotificationService;
using Amazon.SQS;
using LS.AppointmentApi.Data;
using LS.AppointmentApi.Mapping;
using LS.AppointmentApi.Services;
using LS.AppointmentApi.Services.IServices;
using LS.Shared.Configuration;
using LS.Shared.Events;
using LS.Shared.Interfaces;
using LS.Shared.Middleware;
using LS.Shared.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppointmentDBContext>(option =>
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

// Bind AwsSettings from config
builder.Services.Configure<AwsSettings>(
    builder.Configuration.GetSection("AwsSettings")
);
// Read AWS settings
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
builder.Services.AddScoped<IAppointmentRepository, AppointmentRepository>();

// Publishers
builder.Services.AddScoped<AuditLogPublisher>();

// Mapping
builder.Services.AddAutoMapper(typeof(MappingConfig));


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

var app = builder.Build();

// Use CORS
// app.UseCors("AllowFrontend");
app.UseCors("AllowAll");

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
