FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4420

ENV ASPNETCORE_URLS=http://+:4420
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.FileServiceApi/LS.FileServiceApi.csproj", "src/LS.FileServiceApi/"]
RUN dotnet restore "src/LS.FileServiceApi/LS.FileServiceApi.csproj"
COPY . .
WORKDIR "/src/src/LS.FileServiceApi"
RUN dotnet build "LS.FileServiceApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.FileServiceApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.FileServiceApi.dll"]
