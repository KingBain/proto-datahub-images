az config set extension.use_dynamic_install=yes_without_prompt
az storage blob directory download -c ${BLOB_CONTAINER_NAME} --account-name ${BLOB_ACCOUNT_NAME} --account-key ${BLOB_ACCOUNT_KEY} -s "${APP_FOLDER}" -d /srv/shiny-server/ --recursive
/init