FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4428

ENV ASPNETCORE_URLS=http://+:4428
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.NotificationApi/LS.NotificationApi.csproj", "src/LS.NotificationApi/"]
RUN dotnet restore "src/LS.NotificationApi/LS.NotificationApi.csproj"
COPY . .
WORKDIR "/src/src/LS.NotificationApi"
RUN dotnet build "LS.NotificationApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.NotificationApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.NotificationApi.dll"]
