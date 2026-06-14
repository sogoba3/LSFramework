FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4488

ENV ASPNETCORE_URLS=http://+:4488
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.AuditApi/LS.AuditApi.csproj", "src/LS.AuditApi/"]
RUN dotnet restore "src/LS.AuditApi/LS.AuditApi.csproj"
COPY . .
WORKDIR "/src/src/LS.AuditApi"
RUN dotnet build "LS.AuditApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.AuditApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.AuditApi.dll"]
