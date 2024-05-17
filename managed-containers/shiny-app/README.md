# Generic Docker image for Shiny app

This generic Docker image is used to run a Shiny app as a containerized app on Azure App Service. It connects to one Azure Storage Account. During startup, it pulls the Shiny app code from a specific folder from the storage account. An example file structure may look like the following in the storage account
```
Azure Storage Account
|
└───datahub
│   │   data1.csv
│   │   data2.json
│   │
│   └───subfolder1
│       │   data1.csv
│       │   data2.json
│       │   ...
│   
└───shiny
    │   app.R
    │   ui.R
    |   server.R
```

# Settings in Azure App Service
- Create a Linux based Azure App Service Plan with desirable size
- Create a Docker based Azure App Service with the following settings
  - BLOB_ACCOUNT_NAME
  - BLOB_ACCOUNT_KEY
  - BLOB_CONTAINER_NAME (Default: `datahub`)
  - APP_FOLDER (Default: `shiny`)

# Test locally
- Build Docker:`docker build -t fsdh-shiny .`

- From this directory, run `docker run --name my-shiny -d --network host -v $PWD:/srv/shiny-server/sample fsdh-shiny`
- To access Azure Datalake Gen 2, run `ocker run --name myshiny -d --network host -e BLOB_ACCOUNT_NAME=mystorageacct  -e BLOB_ACCOUNT_KEY="myaccountkey" -e BLOB_CONTAINER_NAME=mycontainer -e BLOB_FILE_NAME="sample.csv" -v $PWD:/srv/shiny-server/sample fsdh-shiny`
- Browse to the sample app: http://localhost:3838/sample

# Sample code for accessing storage account

```
library(shiny)
library(AzureStor)

# Define the Azure Storage Account details
storage_account_name <- Sys.getenv("BLOB_ACCOUNT_NAME")
storage_account_key <- Sys.getenv("BLOB_ACCOUNT_KEY")
container_name <- Sys.getenv("BLOB_CONTAINER_NAME")

# Function to read the CSV file from Azure Blob Storage

read_azure_csv <- function() {
  bl_endp_key <- storage_endpoint(paste("https://", storage_account_name, ".blob.core.windows.net", sep = ""), key=storage_account_key)
  cont <- storage_container(bl_endp_key, "datahub")
  list_storage_files(cont)
  list_blob_containers(bl_endp_key)
  data <- storage_read_csv(cont, "sample.csv", stringsAsFactors=TRUE)
  return(data)
}

# UI
ui <- fluidPage(
  titlePanel("FSDH Azure Storage Data Presentation"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      tableOutput("data_table")
    )
  )
)

# Server
server <- function(input, output) {
  data <- reactive({
    read_azure_csv()
  })

  output$data_table <- renderTable({
    data()
  })
}

# Run the Shiny App
shinyApp(ui = ui, server = server)
```