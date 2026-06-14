FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4440

ENV ASPNETCORE_URLS=http://+:4440
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.DoctorApi/LS.DoctorApi.csproj", "src/LS.DoctorApi/"]
RUN dotnet restore "src/LS.DoctorApi/LS.DoctorApi.csproj"
COPY . .
WORKDIR "/src/src/LS.DoctorApi"
RUN dotnet build "LS.DoctorApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.DoctorApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.DoctorApi.dll"]
