var builder = WebApplication.CreateBuilder(args);

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

app.MapHealthChecks("/health");
// Use CORS
// app.UseCors("AllowFrontend");
app.UseCors("AllowAll");

app.MapReverseProxy();

app.Run();