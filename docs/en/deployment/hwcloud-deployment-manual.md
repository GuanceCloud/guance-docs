## 1 Introduction

### 1.1 Document Description

This document primarily describes the deployment on Huawei Cloud, introducing the complete steps from resource planning and configuration to deploying <<< custom_key.brand_name >>> and running it.

**Note:**

- This document uses **dataflux.cn** as the primary domain for examples. Replace it with the corresponding domain during actual deployment.

### 1.2 Key Terms

| **Term**   | **Description**                                                     |
| :--------- | :------------------------------------------------------------------- |
| Launcher   | A WEB application used for deploying and installing <<< custom_key.brand_name >>>. Follow the guided steps provided by the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>. |
| Operations Machine | A machine that has kubectl installed and is in the same network as the target Kubernetes cluster. |
| Installation Machine | A machine used to access the launcher service via a browser to complete the guided installation of <<< custom_key.brand_name >>>. |
| kubectl    | The command-line client tool for Kubernetes, installed on the **operations machine**. |

### 1.3 Deployment Architecture

[![img](https://docs.guance.com/deployment/img/23.install-step.png)](https://docs.guance.com/deployment/img/23.install-step.png)

## 2 Resource List

???+ warning "Note"

     **1.** The "**Minimum Configuration**" is only suitable for POC scenarios, for functional validation, and not for production environments.
    
     **2.** The "**Recommended Configuration**" is suitable for scenarios where InfluxDB has fewer than 150,000 time series and Elasticsearch has fewer than 7 billion documents (total number of log, trace, RUM PV, and event documents).
    
     **3.** For production deployment, assess based on actual data volume. The more data ingested, the higher the storage and specification requirements for InfluxDB and Elasticsearch.
    
     **4.** If using self-built TDengine and OpenSearch, they need to be added to the CCE node pool. Self-built OpenSearch nodes require 3 coordinator nodes (4c8g) and 3 data nodes (8c32g), totaling 6 nodes.


| **Resource**                  | **Specification (Minimum Configuration)** | **Specification (Recommended Configuration)**   | **Quantity** | **Notes**                                           |
| ----------------------------- | ------------------------------------------ | ------------------------------------------------ | ------------ | -------------------------------------------------- |
| CCE                           | Standard Managed Cluster Edition           | Standard Managed Cluster Edition                 | 1            | Version: 1.23                                          |
| CCE Node Pool                 | 4C8G (single system disk 80GB)             | 8C16G (single system disk 120GB)                 | 4            | Deployed in Huawei Cloud CCE managed cluster                                 |
|                               | 2C4G (single system disk 80GB)             | 4C8G (single system disk 120GB)                  | 2            | Deploy Dataway                                       |
| NAT Gateway                   | Small NAT Gateway                          | Small NAT Gateway                                | 1            | Used for outbound traffic from the CCE cluster        |
| ELB                           | Shared Type                                | Shared Type                                      | 1            | Placed before Kubernetes Ingress                     |
| RDS                           | 2C4G 50GB                                  | 4C8G 100GB (master-slave)                        | 1            | MySQL 8.0                                        |
| Redis                         | 4GB                                        | 8GB (standard master-slave edition with dual replicas) | 1            | Version: 6.0                                           |
| TDengine \| InfluxDB          | 4C16G 300GB                                | 8C32G 500GB (cluster edition)                    | 1            | TDengine (**self-built**) Version: 2.6+ InfluxDB Version: 1.7.x       |
| Elasticsearch \| OpenSearch   | 4C16G 1TB (single node)                    | 16C64G 2TB (3 nodes)                             | 1            | Elasticsearch Version: 7.10.2 OpenSearch (**self-built**) Version: 2.3 |
| Domain Name                   | -                                          | -                                                | 1            | The main domain must be registered, with 8 subdomains under one main domain                              |
| SSL Certificate               | Wildcard domain certificate                | Wildcard domain certificate                      | 1            | -                                                |

## 3 Infrastructure Deployment

### 3.1 Deployment Instructions

**RDS, Redis, InfluxDB, Elasticsearch** should be created according to the configuration requirements, all within the same **VPC** network in the same region.

### 3.2 Steps One, Two, Three: CCE Service Creation

#### 3.2.1 Step One: Purchase CCE Cluster

Go to the official website, select **Products** in the navigation bar, choose **Container**, click **Cloud Container Engine CCE**, and create a CCE cluster.

- It must be in the same region as the RDS, InfluxDB, Elasticsearch resources created later.
- Choose the **cluster size** based on your needs; you will then create **worker nodes** afterward.

![](img/huaweicloud_1.png)

#### 3.2.2 Step Two: Worker Node Configuration

Primarily choose ECS specifications and quantity. Specifications can be created according to the resource list or assessed based on actual conditions but must not be lower than the minimum configuration requirements. There should be at least 3 nodes or more, and it is recommended that the data disk size should not be less than **100GiB**.

![](img/huaweicloud_2.png)

![](img/huaweicloud_3.png)

#### 3.2.3 Step Three: Plugin Management

Everest and coredns plugins are created by default when purchasing a k8s cluster. It is recommended to add the following two plugins. To ensure cluster resources and avoid additional costs, it is suggested to remove the **ICAgent** plugin.

![](img/huaweicloud_4.png)

**Install nginx-ingress plugin**

1) Configure CPU and memory resource limits

![](img/huaweicloud_5.png)

2) Create Load Balancer ELB

If needed, you can choose a dedicated elastic load balancer. This document chooses the shared type. Note: Select an **elastic public IP** and it is recommended to use an existing one or create a new one with a bandwidth of 300Mbit/s charged by traffic.

- Differences between dedicated and shared types can be found at the following link:

[https://support.huaweicloud.com/productdesc-elb/elb_pro_0004.html](https://support.huaweicloud.com/productdesc-elb/elb_pro_0004.html){:target="_blank"}

![](img/huaweicloud_6.png)

![](img/huaweicloud_7.png)

![](img/huaweicloud_8.png)

3) Configure **nginx-ingress** plugin content related to nginx forwarding

```shell
# Add the following content
{
	"allow-backend-server-header": "true",
	"client-header-buffer-size": "32k",
	"enable-underscores-in-headers": "true",
	"forwarded-for-header": "X-Forwarded-For",
	"generate-request-id": "true",
	"ignore-invalid-headers": "true",
	"keep-alive-requests": "100",
	"large-client-header-buffers": "4 32k",
	"proxy-body-size": "20m",
	"proxy-connect-timeout": "20",
	"reuse-port": "true",
	"server-tokens": "false",
	"ssl-protocols": "TLSv1 TLSv1.1 TLSv1.2 SSLv3",
	"ssl-redirect": "false",
	"use-gzip": "true",
	"worker-cpu-affinity": "auto"
}
```

**Install node-local-dns plugin**

- Enable DNS Config injection functionality

???+ warning "Note"
     The namespace must have the label `node-local-dns-injection=enabled` for the DNS cache feature to function.

**Uninstall ICAgent plugin** (optional)

Select **AOM Application Operation Management** and uninstall the **ICAgent plugin**, and turn off the switches for continuing to collect logs and metrics beyond the quota.

![](img/huaweicloud_9.png)

### 3.4 Step Four: Cache Service

- You can choose to use the default built-in cache service. If not using the default built-in cache service, configure Redis according to the following requirements:
  - Distributed caching service (Redis version).
  - Redis version: 6.0, standard master-slave architecture, supporting dual replicas.
  - Set a Redis password.
  - Add the internal network IP addresses of ECS instances automatically created by CCE to the Redis whitelist.

### 3.5 Step Five: InfluxDB

- Name: Cloud Database GaussDB(for influx)
- Version: 1.7
- Set InfluxDB user password
- Add the internal network IP addresses of ECS instances automatically created by CCE to the InfluxDB whitelist

### 3.6 Step Six: Elasticsearch

- Name: Cloud Search Service CSS
- Version: 7.10.2
- Enable security mode to set up admin accounts and passwords
- Add the internal network IP addresses of ECS instances automatically created by CCE to the Elasticsearch whitelist

### 3.7 Step Seven: RDS

- Name: Cloud Database RDS
- Version: 8.0, standard master-slave edition
- Set MySQL root user password
- Add the internal network IP addresses of ECS instances automatically created by CCE to the MySQL whitelist

## 4 kubectl Installation and Configuration

### 4.1 Install kubectl

kubectl is a command-line client tool for Kubernetes, which can be used to deploy applications, check and manage cluster resources, etc. Our Launcher is based on this command-line tool for deploying applications. Refer to the official documentation for specific installation methods:

[Install and configure kubectl](https://kubernetes.io/docs/tasks/tools/){:target="_blank"}

You can also click on the cluster and find **kubectl Click to View**

![](img/huaweicloud_10.png)

### 4.2 Configure kube config

Choose whether to use the public or private network kubeconfig based on whether your operations machine can connect to the cluster's internal network. Determine the connection method based on the following **use cases**.

![](img/huaweicloud_11.png)

## 5 Start Installation

After completing the operations, refer to the manual [Start Installation](https://docs.guance.com/deployment/launcher-install/){:target="_blank"}