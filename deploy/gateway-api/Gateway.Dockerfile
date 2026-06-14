FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4400

ENV ASPNETCORE_URLS=http://+:4400

#USER app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.Gateway/LS.Gateway.csproj", "src/LS.Gateway/"]
RUN dotnet restore "src/LS.Gateway/LS.Gateway.csproj"
COPY . .
WORKDIR "/src/src/LS.Gateway"
RUN dotnet build "LS.Gateway.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.Gateway.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.Gateway.dll"]
