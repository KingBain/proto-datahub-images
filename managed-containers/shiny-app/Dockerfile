FROM rocker/shiny:4


ENV BLOB_ACCOUNT_NAME BLOB_ACCOUNT_KEY BLOB_CONTAINER_NAME=datahub APP_FOLDER=shiny

# Install Azure CLI for file download
RUN apt update && apt install -y curl && curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

RUN R -e "install.packages(c('leaflet','sp','RgoogleMaps','AzureStor','AzureRMR'))"
RUN mkdir -p /srv/shiny-server/sample
COPY app.R /srv/shiny-server/sample

COPY entrypoint.sh /run
ENTRYPOINT [ "/bin/bash", "/run/entrypoint.sh" ]