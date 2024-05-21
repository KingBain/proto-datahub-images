#!/bin/bash

# Export variables from .env file
export $(grep -v '^#' .env | xargs)

# Build the Docker image with the environment variables as build arguments
docker build --build-arg BLOB_ACCOUNT_NAME=$BLOB_ACCOUNT_NAME \
             --build-arg BLOB_ACCOUNT_KEY=$BLOB_ACCOUNT_KEY \
             --build-arg BLOB_CONTAINER_NAME=$BLOB_CONTAINER_NAME \
             --build-arg APP_FOLDER=$APP_FOLDER \
             -t myapp:latest .
