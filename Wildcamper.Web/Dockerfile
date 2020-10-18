#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["Wildcamper.Web/Wildcamper.Web.fsproj", "Wildcamper.Web/"]
RUN dotnet restore "Wildcamper.Web/Wildcamper.Web.fsproj"
COPY . .
WORKDIR "/src/Wildcamper.Web"
RUN dotnet build "Wildcamper.Web.fsproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Wildcamper.Web.fsproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Wildcamper.Web.dll"]