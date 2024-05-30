# Shiny App Docker Image

This repository contains the Docker configuration for a Shiny app using the official Rocker Shiny image as the base. This setup ensures a robust and consistent environment for running Shiny applications.

## Dockerfile Details

The Dockerfile used in this repository performs the following steps:

1. **Base Image**: Uses the official Rocker Shiny image.
   ```dockerfile
   FROM rocker/shiny:latest

    Cleanup: Removes the default index.html and sample apps from the Shiny server directory.

    dockerfile

RUN rm -fr /srv/shiny-server/*

Copy App Files: Copies the Shiny app files from the scripts directory in the local machine to the Shiny server directory in the container.

dockerfile

COPY ./scripts/ /srv/shiny-server/

Expose Port: Exposes port 3838, which is the default port that Shiny Server runs on.

dockerfile

EXPOSE 3838

User: Switches to the shiny user to run the Shiny server.

dockerfile

USER shiny

Start Shiny Server: Starts the Shiny server using the default command.

dockerfile

    CMD ["/usr/bin/shiny-server"]

Usage
Building the Image

To build the Docker image, run the following command in the root of the repository:

sh

docker build -t your-image-name:latest .

Running the Container

To run the Docker container, use the following command:

sh

docker run -p 3838:3838 your-image-name:latest

This command maps port 3838 of the container to port 3838 on your local machine, allowing you to access the Shiny app in your browser at http://localhost:3838.
Pushing to GitHub Container Registry

To push the built image to GitHub Container Registry, use the following commands:

sh

# Tag the image with GitHub Container Registry
docker tag your-image-name:latest ghcr.io/your-github-username/your-image-name:latest

# Push the image
docker push ghcr.io/your-github-username/your-image-name:latest

Files and Directories

    Dockerfile: The configuration file containing instructions to build the Docker image.
    scripts/: Directory containing the Shiny app files to be served by the Shiny server.

License

This project is licensed under the MIT License. See the LICENSE file for details.
Acknowledgements

    Rocker Project for providing the base Shiny image.
    Shiny for the web application framework for R.