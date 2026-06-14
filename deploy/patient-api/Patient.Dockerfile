FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4442

ENV ASPNETCORE_URLS=http://+:4442
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.PatientApi/LS.PatientApi.csproj", "src/LS.PatientApi/"]
RUN dotnet restore "src/LS.PatientApi/LS.PatientApi.csproj"
COPY . .
WORKDIR "/src/src/LS.PatientApi"
RUN dotnet build "LS.PatientApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.PatientApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.PatientApi.dll"]
