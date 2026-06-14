FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.WorkerService/LS.WorkerService.csproj", "src/LS.WorkerService/"]
RUN dotnet restore "src/LS.WorkerService/LS.WorkerService.csproj"
COPY . .
WORKDIR "/src/src/LS.WorkerService"
RUN dotnet build "LS.WorkerService.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.WorkerService.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.WorkerService.dll"]
