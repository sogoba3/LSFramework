using System.Collections;
using Amazon;
using Amazon.SimpleNotificationService;
using Amazon.SQS;
using LS.AppointmentApi.Data;
using LS.AppointmentApi.Services;
using LS.AppointmentApi.Services.IServices;
using LS.AuditApi.Events.Publisher;
using LS.AuthUserApi.Data;
using LS.AuthUserApi.Services;
using LS.AuthUserApi.Services.IServices;
using LS.BillingApi.Data;
using LS.BillingApi.Services;
using LS.BillingApi.Services.IServices;
using LS.DoctorApi.Data;
using LS.DoctorApi.Services;
using LS.DoctorApi.Services.IServices;
using LS.NotificationApi.Data;
using LS.NotificationApi.Services;
using LS.NotificationApi.Services.IServices;
using LS.PatientApi.Data;
using LS.PatientApi.Services;
using LS.PatientApi.Services.IServices;
using LS.Shared.Configuration;
using LS.Shared.Interfaces;
using LS.Shared.Services;
using LS.TenantApi.Data;
using LS.TenantApi.Services;
using LS.TenantApi.Services.IServices;
using LS.WorkerService;
using Microsoft.EntityFrameworkCore;
using static LS.WorkerService.Events.TenantSubscriber;

IHost host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        var configuration = context.Configuration;

        // Configure AWS
        services.Configure<AwsSettings>(configuration.GetSection("AwsSettings"));
        var regionName = configuration["AwsSettings:Region"] ?? "us-east-2";
        var region = RegionEndpoint.GetBySystemName(regionName);

        // AWS Clients
        services.AddSingleton<IAmazonSQS>(_ => new AmazonSQSClient(region));
        services.AddSingleton<IAmazonSimpleNotificationService>(_ => new AmazonSimpleNotificationServiceClient(region));

        // Databases (use correct DbContext type for each)
        services.AddDbContext<AuthUserDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddDbContext<AppointmentDBContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddDbContext<BillingDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddDbContext<DoctorDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddDbContext<NotificationDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddDbContext<PatientDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddDbContext<TenantDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        // Replace normal TenantProvider with WorkerTenantProvider
        services.AddScoped<ITenantProvider, WorkerTenantProvider>();
        
        // Repositories
        services.AddScoped<IAuthUserRepository, AuthUserRepository>();
        services.AddScoped<IAppointmentRepository, AppointmentRepository>();
        services.AddScoped<IBillingRepository, BillingRepository>();
        services.AddScoped<IDoctorRepository, DoctorRepository>();
        services.AddScoped<INotificationRepository, NotificationRepository>();
        services.AddScoped<IPatientRepository, PatientRepository>();
        services.AddScoped<ITenantRepository, TenantRepository>();

        // Publushers
        services.AddScoped<AuditLogPublisher>();

        // Hosted Service
        services.AddHostedService<LS.WorkerService.Events.TenantSubscriber>();

        
    })
    .Build();

await host.RunAsync();

