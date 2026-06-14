FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4404

ENV ASPNETCORE_URLS=http://+:4404
ENV ASPNETCORE_ENVIRONMENT=Development
#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src

COPY ["src/LS.AuthUserApi/LS.AuthUserApi.csproj", "src/LS.AuthUserApi/"]
RUN dotnet restore "src/LS.AuthUserApi/LS.AuthUserApi.csproj"

COPY . .
WORKDIR "/src/src/LS.AuthUserApi"

RUN dotnet build "LS.AuthUserApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.AuthUserApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "LS.AuthUserApi.dll"]
