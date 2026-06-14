FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 4408

ENV ASPNETCORE_URLS=http://+:4408
ENV ASPNETCORE_ENVIRONMENT=Development

#USER app
# --platform=$BUILDPLATFORM 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/LS.BillingApi/LS.BillingApi.csproj", "src/LS.BillingApi/"]
RUN dotnet restore "src/LS.BillingApi/LS.BillingApi.csproj"
COPY . .
WORKDIR "/src/src/LS.BillingApi"
RUN dotnet build "LS.BillingApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "LS.BillingApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LS.BillingApi.dll"]
