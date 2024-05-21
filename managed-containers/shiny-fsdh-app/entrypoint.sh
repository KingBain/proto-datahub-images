#!/bin/bash

# Enable dynamic installation of Azure CLI extensions without prompting
az config set extension.use_dynamic_install=yes_without_prompt

# Download the directory from Azure Blob Storage to the Shiny server directory
az storage blob directory download -c ${BLOB_CONTAINER_NAME} --account-name ${BLOB_ACCOUNT_NAME} --account-key ${BLOB_ACCOUNT_KEY} -s "${APP_FOLDER}" -d /srv/shiny-server/ --recursive

# Start the Shiny server
/init
