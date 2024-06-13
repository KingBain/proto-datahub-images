# Upload Docker image to ACR

```
 az acr login --name spdatahub
 docker build -t bioconda .
 docker tag datahubdbr:latest spdatahub.azurecr.io/databricks:latest 
 docker push spdatahub.azurecr.io/databricks:latest
 ```

# Upload Docker images to Github
```
export PAT="XXX"
echo $PAT|docker login ghcr.io -u username --password-stdin
docker build -t dbr-bioconda .
docker tag dbr-bioconda ghcr.io/ssc-sp/dbr-bioconda:latest
docker push ghcr.io/ssc-sp/dbr-bioconda:latest
```
# Sample Cluster configuration for Docker: : Access Mode: No Isolation Shared

 ```
 {
    "autoscale": {
        "min_workers": 1,
        "max_workers": 1
    },
    "cluster_name": "FSDH Test Docker Cluster",
    "spark_version": "12.2.x-scala2.12",
    "spark_conf": {
        "spark.databricks.delta.preview.enabled": "true"
    },
    "azure_attributes": {
        "first_on_demand": 1,
        "availability": "ON_DEMAND_AZURE",
        "spot_bid_max_price": -1
    },
    "node_type_id": "Standard_DS3_v2",
    "driver_node_type_id": "Standard_DS3_v2",
    "autotermination_minutes": 10,
    "enable_elastic_disk": true,
    "cluster_source": "UI",
    "docker_image": {
        "url": "spdatahub.azurecr.io/databricks:latest",
        "basic_auth": {
            "username": "acr-token-name",
            "password": "acr-password"
        }
    },
    "enable_local_disk_encryption": false,
    "data_security_mode": "NONE",
    "runtime_engine": "STANDARD",
}
```

# Conda Experiment: Access Mode: No Isolation Shared
# Runtime: 10.4-LTS, 9.1-LTS or 7.3-LTS
```
{
    "autoscale": {
        "min_workers": 1,
        "max_workers": 1
    },
    "cluster_name": "FSDH Test Docker Cluster Conda",
    "spark_version": "7.3.x-scala2.12", 
    "spark_conf": {
        "spark.databricks.delta.preview.enabled": "true"
    },
    "azure_attributes": {
        "first_on_demand": 1,
        "availability": "ON_DEMAND_AZURE",
        "spot_bid_max_price": -1
    },
    "node_type_id": "Standard_DS3_v2",
    "driver_node_type_id": "Standard_DS3_v2",
    "autotermination_minutes": 10,
    "enable_elastic_disk": true,
    "cluster_source": "UI",
    "docker_image": {
        "url": "databricksruntime/python-conda:9.x"
    },
    "enable_local_disk_encryption": false,
    "data_security_mode": "NONE",
    "runtime_engine": "STANDARD",
}
```