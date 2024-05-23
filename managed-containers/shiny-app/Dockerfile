# Use the official Rocker Shiny image as the base image
FROM rocker/shiny:latest

# Remove the default index.html and sample apps
RUN rm -fr /srv/shiny-server/*

# Copy the Shiny app files to the server directory
COPY ./scripts/ /srv/shiny-server/

# Expose the port Shiny Server runs on
EXPOSE 3838

# Switch to the 'docker' user
USER shiny

# Start Shiny Server
CMD ["/usr/bin/shiny-server"]