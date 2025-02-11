# Resources and System Requirements


## Alibaba Cloud Resource List {#list}

???+ warning "Note"

    1. The “**Minimum Configuration**” is only suitable for POC scenario deployments, suitable for functional validation, and not recommended for production environments.
    2. The “**Recommended Configuration**” is suitable for scenarios with fewer than 150,000 InfluxDB time series and fewer than 7 billion documents in Elasticsearch (total document count for logs, traces, RUM, events, etc.).
    3. For production deployment, evaluate based on actual data volume接入的数据量越多，InfluxDB、Elasticsearch 的存储与规格配置相应也需要越高。


| **Resource** | **Specification (Minimum Configuration)** | **Specification (Recommended Configuration)** | **Quantity** | **Remarks**                                |
| --- | --- | --- | --- |---------------------------------------|
| ACK | Standard Managed Cluster Edition | Standard Managed Cluster Edition | 1 | Version: 1.18+                              |
| NAS | 200GB (Capacity Type) | 1TB (Capacity Type) | 1 | Data persistence for ACK clusters                            |
| NAT Gateway | Small NAT Gateway | Small NAT Gateway | 1 | Used for outbound traffic from ACK clusters                             |
| SLB | Performance Guarantee Type | Performance Guarantee Type | 2 | Positioned before Kubernetes Ingress                 |
| ECS | 4C8G (single system disk 80GB) | 8C16G (single system disk 120GB) | 4 | Deploying Alibaba Cloud ACK Managed Cluster                         |
|  | 2C4G (single system disk 80GB) | 4C8G (single system disk 120GB) | 2 | Deploying Dataway                            |
| RDS | 1C2G 50GB | 2C4G 100GB (three-node enterprise edition) | 1 | MySQL 8.0                             |
| InfluxDB | 4C16G 300GB | 8C32G 500GB | 1 | InfluxDB Version: 1.7.x |
| OpenSearch | 4C16G 1TB (2 nodes) | 16C64G 2TB (3 nodes) | 1 | Version: 2.3.0              |
| Cloud Communication | - | - | 1 | Enable email service, SMS service                           |
| Domain Name | - | - | 1 | Main domain must be registered; supports up to 8 subdomains under one main domain                   |
| SSL Certificate | Wildcard domain certificate | Wildcard domain certificate | 1 | -                                     |
| OSS | Standard storage, local redundant storage | Standard storage, local redundant storage | 2 | Used for profiling, session-apply, and backuplog |

The more data you integrate, the higher the storage and specification requirements for InfluxDB and Elasticsearch will be.