# setup build environment
FROM microsoft/aspnetcore-build:latest AS build-env
WORKDIR /app

# copy everything and build the project
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out ./
ENV ASPNETCORE_URLS http://+:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "dotnetserve.dll"]