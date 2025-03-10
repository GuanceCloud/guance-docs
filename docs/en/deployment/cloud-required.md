# Resources and System Requirements


## Alibaba Cloud Resource List {#list}

???+ warning "Note"

    1. The "**Minimum Configuration**" is only suitable for POC scenario deployment, suitable for functional validation, not recommended for production environments.
    1. The "**Recommended Configuration**" is suitable for scenarios with less than 150,000 InfluxDB time series and less than 7 billion documents in Elasticsearch (total of log, trace, RUM, event, etc., document counts).
    1. For production deployment, evaluate based on actual data volume. The higher the data volume, the higher the storage and specification requirements for InfluxDB and Elasticsearch.


| **Resource** | **Specification (Minimum Configuration)** | **Specification (Recommended Configuration)** | **Quantity** | **Notes**                                |
| --- | --- | --- | --- |---------------------------------------|
| ACK | Standard Managed Cluster Edition | Standard Managed Cluster Edition | 1 | Version: 1.18+                              |
| NAS | 200GB (Capacity Type) | 1T (Capacity Type) | 1 | Data persistence for ACK clusters                            |
| NAT Gateway | Small NAT Gateway | Small NAT Gateway | 1 | Outbound internet access for ACK clusters                             |
| SLB | Performance Assurance Type | Performance Assurance Type | 2 | Positioned before Kubernetes Ingress                 |
| ECS | 4C8G (Single System Disk 80GB) | 8C16G (Single System Disk 120GB) | 4 | Deploying Alibaba Cloud ACK Managed Cluster                         |
|  | 2C4G (Single System Disk 80GB) | 4C8G (Single System Disk 120GB) | 2 | Deploying Dataway                            |
| RDS | 1C2G 50GB | 2C4G 100GB (Three-node Enterprise Edition) | 1 | MySQL 8.0                             |
| InfluxDB | 4C16G 300GB | 8C32G 500GB | 1 | InfluxDB Version: 1.7.x |
| OpenSearch | 4C16G 1T (2 Nodes) | 16C64G 2T (3 Nodes) | 1 | Version: 2.3.0              |
| Cloud Communication | - | - | 1 | Enable email service, SMS service                           |
| Domain Name | - | - | 1 | Main domain needs to be registered, including 8 subdomains under one main domain                   |
| SSL Certificate | Wildcard Domain Certificate | Wildcard Domain Certificate | 1 | -                                     |
| OSS | Standard Storage, Local Redundant Storage | Standard Storage, Local Redundant Storage | 2 | Used for profiling, session-apply, and backuplog |