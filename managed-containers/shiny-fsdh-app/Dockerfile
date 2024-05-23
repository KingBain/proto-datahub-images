# Use the official Rocker Shiny image as the base image
FROM rocker/shiny:latest

# Define build arguments
ARG BLOB_ACCOUNT_NAME
ARG BLOB_ACCOUNT_KEY
ARG BLOB_CONTAINER_NAME
ARG APP_FOLDER

# Set environment variables using build arguments
ENV BLOB_ACCOUNT_NAME=${BLOB_ACCOUNT_NAME} \
    BLOB_ACCOUNT_KEY=${BLOB_ACCOUNT_KEY} \
    BLOB_CONTAINER_NAME=${BLOB_CONTAINER_NAME} \
    APP_FOLDER=${APP_FOLDER}

# Install Azure CLI for file download and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove the default index.html and sample apps
RUN rm -rf /srv/shiny-server/*

# Copy the Shiny app files to the server directory
COPY ./scripts/ /srv/shiny-server/

# Copy the entrypoint script
COPY entrypoint.sh /run

# Expose the port Shiny Server runs on
EXPOSE 3838

# Add a health check
HEALTHCHECK CMD curl --fail http://localhost:3838 || exit 1

# Switch to the 'shiny' user
USER shiny

# Start Shiny Server
ENTRYPOINT [ "/bin/bash", "/run/entrypoint.sh" ]