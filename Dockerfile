# 1️⃣ Etapa de build (compilación)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiamos el csproj y restauramos dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiamos el resto del código
COPY . ./
RUN dotnet publish -c Release -o out

# 2️⃣ Etapa de runtime (ejecución)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copiamos solo el resultado final
COPY --from=build /app/out .

# Indicamos el puerto
EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

# Arrancamos la API
ENTRYPOINT ["dotnet", "MiApi.dll"]