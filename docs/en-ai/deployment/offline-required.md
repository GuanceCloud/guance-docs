# Resources and System Requirements


## Offline Environment Resource List {#list}

???+ warning "Note"

    1. The "Minimum Configuration" is suitable for POC scenarios, only for functional verification, not recommended for production environments.
    2. For production deployment, evaluate based on actual data volume; the more data ingested, the higher the storage and specification requirements for InfluxDB and Elasticsearch.

| **Purpose** | **Resource Type** | **Minimum Specification** | **Recommended Specification** | **Quantity** | **Notes**                                                                                  |
| --- | --- | --- | --- | --- |---------------------------------------------------------------------------------|
| **Kubernetes Cluster** | Physical Server&#124;VM | 4C8GB 100GB | 8C16GB 100GB | 3 | Role: Master <br>Version: 1.18+ **Note: If using VMs, appropriately increase resource specifications**                                   |
|  | Physical Server&#124;VM | 4C8GB 100GB | 8C16GB 100GB | 4 | Role: Node <br/>k8s cluster worker nodes, hosting Guance applications, k8s components, basic services MySQL 8.0, Redis 6.0              |
|  | Physical Server&#124;VM | 2C4GB 100GB | 4C8GB 200GB | 1 | Role: Proxy (not in cluster) <br/>[Optional] For deploying reverse proxy servers, proxy to ingress edge nodes **Note: For security reasons, do not expose cluster edge nodes directly** |
|  | Physical Server&#124;VM | 2C4GB 200GB | 4C8GB 1TB high-performance disk | 1 | Role: Shared Storage (not in cluster) <br/>Deploy network file system, network storage service, default NFS                                       |
| **DataWay** | Physical Server&#124;VM | 2C4GB 100GB | 4C8GB 100GB | 1 | Role: Data Gateway (not in cluster) <br/>User-deployed DataWay                                                |
| **ElasticSearch** &#124; **OpenSearch**  | Physical Server&#124;VM | 4C16GB 1TB (2 nodes) | 8C32GB 2TB (3 nodes) | 1 | ElasticSearch Version: 7.10+ OpenSearch Version: 2.3.0 **Note: Password authentication must be enabled, install matching version analysis-ik plugin** |
| **GuanceDB** | Physical Server&#124;VM | 4C8GB 300GB | 8C16GB 500GB | 1 | GuanceDB Version: 1.9.0+                                             |
| **Others** | Email Server/SMS Gateway | - | - | 1 | SMS gateway, email server, alert channels                                                                 |
|  | Officially Registered Wildcard Domain | - | - | 1 | Main domain must be registered                                                                          |
|  | SSL/TLS Certificate | Wildcard Domain Certificate | Wildcard Domain Certificate | 1 | Ensures site security                                                                          |