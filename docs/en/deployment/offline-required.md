# Resources and System Requirements


## Offline Environment Resource List {#list}

???+ warning "Note"

    1. The "minimum configuration" is suitable for POC scenarios, only for functional validation, not recommended for production environments.
    2. For production deployment, evaluate based on actual data volume接入的数据量越多，InfluxDB、Elasticsearch 的存储与规格配置相应也需要越高. The higher the data volume, the higher the storage and specification requirements for InfluxDB and Elasticsearch.

| **Purpose** | **Resource Type** | **Minimum Specification** | **Recommended Specification** | **Quantity** | **Notes**                                                                          |
| --- | --- | --- | --- | --- |---------------------------------------------------------------------------------|
| **Kubernetes Cluster** | Physical Server&#124;Virtual Machine | 4C8GB 100GB | 8C16GB  100GB | 3 | Role: Master <br> Version: 1.18+ **Note: If using virtual machines, appropriately increase resource specifications**                                   |
|  | Physical Server&#124;Virtual Machine | 4C8GB 100GB | 8C16GB  100GB | 4 | Role: Node <br/>k8s cluster worker node, hosting <<< custom_key.brand_name >>> application, k8s components, basic service components MySQL 8.0, Redis 6.0              |
|  | Physical Server&#124;Virtual Machine | 2C4GB  100GB | 4C8GB    200GB | 1 | Role: Proxy (not in cluster) <br/>[Optional] Used to deploy reverse proxy server, proxy to ingress edge node **Note: For security reasons, do not directly expose cluster edge nodes** |
|  | Physical Server&#124;Virtual Machine | 2C4GB 200GB | 4C8GB 1TB High-performance Disk | 1 | Role: Shared Storage (not in cluster) <br/>Deploy network file system, network storage service, default NFS                                       |
| **DataWay** | Physical Server&#124;Virtual Machine | 2C4GB  100GB | 4C8GB    100GB | 1 | Role: Data Gateway (not in cluster) <br/>User deploys DataWay                                                |
| **ElasticSearch** &#124; **OpenSearch**  | Physical Server&#124;Virtual Machine | 4C16GB 1TB (2 nodes) | 8C32GB   2TB (3 nodes) | 1 | ElasticSearch Version: 7.10+  OpenSearch Version: 2.3.0 **Note: Password authentication must be enabled, install matching version segmentation plugin analysis-ik** |
| **GuanceDB** | Physical Server&#124;Virtual Machine | 4C8GB  300GB | 8C16GB 500GB | 1 | GuanceDB Version: 1.9.0+                                             |
| **Others** | Email Server/SMS | - | - | 1 | SMS gateway, email server, alert channels                                                                 |
|  | Officially Registered Wildcard Domain | - | - | 1 | Main domain needs to be registered                                                                        |
|  | SSL/TLS Certificate | Wildcard Domain Certificate | Wildcard Domain Certificate | 1 | Ensures site security                                                                        |

Please note that the phrase "接入的数据量越多，InfluxDB、Elasticsearch 的存储与规格配置相应也需要越高" has been translated as "The higher the data volume, the higher the storage and specification requirements for InfluxDB and Elasticsearch." This maintains the meaning while ensuring readability in English.