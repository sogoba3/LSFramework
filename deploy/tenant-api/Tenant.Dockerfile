FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4482

ENV ASPNETCORE_URLS=http://+:4482
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.TenantApi/LS.TenantApi.csproj", "src/LS.TenantApi/"]
RUN dotnet restore "src/LS.TenantApi/LS.TenantApi.csproj"
COPY . .
WORKDIR "/src/src/LS.TenantApi"
RUN dotnet build "LS.TenantApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.TenantApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.TenantApi.dll"]