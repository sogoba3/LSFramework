var builder = WebApplication.CreateBuilder(args);

// Logging
builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.SetMinimumLevel(LogLevel.Debug);

// Load ReverseProxy config from appsettings.json
builder.Services.AddReverseProxy()
    .LoadFromConfig(builder.Configuration.GetSection("ReverseProxy"));

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

builder.Services.AddHealthChecks();
var app = builder.Build();

// Request Logging Middleware
app.Use(async (context, next) =>
{
    var logger = app.Logger;

    logger.LogInformation(
        "Incoming Request: {Method} {Path}",
        context.Request.Method,
        context.Request.Path);

    await next();

    logger.LogInformation(
        "Response: {StatusCode}",
        context.Response.StatusCode);
});

app.MapHealthChecks("/health");
// Use CORS
// app.UseCors("AllowFrontend");
app.UseCors("AllowAll");

app.MapReverseProxy();

app.Run();