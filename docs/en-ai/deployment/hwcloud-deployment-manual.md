## 1 Introduction

### 1.1 Document Overview

This document primarily focuses on deploying in Huawei Cloud, detailing the complete steps from resource planning and configuration to deploying Guance, and running it.

**Note:**

- This document uses **dataflux.cn** as the main domain example. Replace it with the corresponding domain during actual deployment.

### 1.2 Key Terms

| **Term**          | **Description**                                                                 |
| :---------------- | :------------------------------------------------------------------------------ |
| Launcher          | A WEB application used for deploying and installing Guance. Follow the steps provided by the Launcher service to complete the installation and upgrade of Guance. |
| Operations Machine| A machine that has kubectl installed and is on the same network as the target Kubernetes cluster. |
| Installation Machine | A machine that accesses the Launcher service via a browser to complete the guided installation of Guance. |
| kubectl           | The command-line client tool for Kubernetes, installed on the **operations machine**. |

### 1.3 Deployment Architecture

[![img](https://docs.guance.com/deployment/img/23.install-step.png)](https://docs.guance.com/deployment/img/23.install-step.png)

## 2 Resource List

???+ warning "Note"

     **1.** The "**Minimum Configuration**" is only suitable for POC scenarios, for functional verification, and not for production environments.
    
     **2.** The "**Recommended Configuration**" is suitable for data volume scenarios where InfluxDB has fewer than 150,000 time series and Elasticsearch has fewer than 7 billion documents (total number of log, trace, RUM, and event documents).
    
     **3.** For production deployment, evaluate based on actual data volume接入的数据量越多，InfluxDB、Elasticsearch 的存储与规格配置相应也需要越高。
    
     **4.** If using self-built TDengine and OpenSearch, they need to be added to the CCE node pool. Self-built OpenSearch nodes require 3 coordinating nodes (4c8g) and 3 data nodes (8c32g), totaling 6 nodes.

| **Resource**                  | **Specification (Minimum Configuration)** | **Specification (Recommended Configuration)**   | **Quantity** | **Remarks**                                           |
| ----------------------------- | ----------------------------------------- | ----------------------------------------------- | ------------ | ----------------------------------------------------- |
| CCE                          | Standard Managed Cluster                  | Standard Managed Cluster                        | 1            | Version: 1.23                                         |
| CCE Node Pool                | 4C8G (Single System Disk 80GB)            | 8C16G (Single System Disk 120GB)                | 4            | Deployed in Huawei Cloud CCE Managed Cluster          |
|                              | 2C4G (Single System Disk 80GB)            | 4C8G (Single System Disk 120GB)                 | 2            | Deploy Dataway                                       |
| NAT Gateway                  | Small NAT Gateway                         | Small NAT Gateway                               | 1            | Used for outbound traffic from CCE clusters           |
| ELB                          | Shared Type                               | Shared Type                                     | 1            | In front of Kubernetes Ingress                        |
| RDS                          | 2C4G 50GB                                 | 4C8G 100GB (Master-Slave)                       | 1            | MySQL 8.0                                            |
| Redis                        | 4G                                        | 8G (Standard Master-Slave Edition with Dual Replicas) | 1            | Version: 6.0                                          |
| TDengine \| InfluxDB         | 4C16G 300GB                               | 8C32G 500GB (Cluster Edition)                   | 1            | TDengine (**Self-built**) Version: 2.6+ InfluxDB Version: 1.7.x       |
| Elasticsearch\|OpenSearch    | 4C16G 1TB (Single Node)                   | 16C64G 2TB (3 Nodes)                            | 1            | Elasticsearch Version: 7.10.2  OpenSearch (**Self-built**) Version: 2.3 |
| Domain Name                  | -                                         | -                                               | 1            | Main domain needs to be registered, including 8 subdomains under one main domain |
| SSL Certificate              | Wildcard Domain Certificate               | Wildcard Domain Certificate                     | 1            | -                                                    |

## 3 Infrastructure Deployment

### 3.1 Deployment Description

**RDS, Redis, InfluxDB, Elasticsearch** should be created according to the configuration requirements and placed in the same **VPC** network in the same region.

### 3.2 Steps One, Two, Three: CCE Service Creation

#### 3.2.1 Step One: Purchase CCE Cluster

Navigate to the official website, choose **Product**, select **Container**, click **Cloud Container Engine CCE**, and create a CCE cluster.

- It must be in the same region as the RDS, InfluxDB, Elasticsearch resources created later.
- Choose the **cluster scale** based on your own situation; worker nodes will be created afterward.

![](img/huaweicloud_1.png)

#### 3.2.2 Step Two: Worker Node Configuration

Choose ECS specifications and quantity based on the configuration list or actual assessment, but do not fall below the minimum configuration requirements. At least 3 or more nodes are recommended, and data disks should not be less than **100GiB**.

![](img/huaweicloud_2.png)

![](img/huaweicloud_3.png)

#### 3.2.3 Step Three: Plugin Management

Everest and CoreDNS plugins are created by default when purchasing the k8s cluster. It is recommended to add the following two plugins. To ensure cluster resources and avoid additional costs, delete the **ICAgent** plugin.

![](img/huaweicloud_4.png)

**Install nginx-ingress Plugin**

1) Configure CPU and memory resource limits

![](img/huaweicloud_5.png)

2) Create Load Balancer ELB

If needed, choose an exclusive elastic load balancer. This document selects a shared type. Note: Select **Elastic Public IP** and choose an existing one if possible. If creating a new one, use a bandwidth-based billing plan with 300Mbit/s.

- Differences between exclusive and shared types can be found at the following link:

[https://support.huaweicloud.com/productdesc-elb/elb_pro_0004.html](https://support.huaweicloud.com/productdesc-elb/elb_pro_0004.html){:target="_blank"}

![](img/huaweicloud_6.png)

![](img/huaweicloud_7.png)

![](img/huaweicloud_8.png)

3) Configure nginx forwarding content for the **nginx-ingress** plugin

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

**Install node-local-dns Plugin**

- Enable DNS Config Injection feature

???+ warning "Note"
     Add the label `node-local-dns-injection=enabled` to the namespace to enable DNS cache functionality.

**Delete ICAgent Plugin** (Optional)

Select **AOM Application Operation Management** and uninstall the **ICAgent** plugin, as well as disable the log and metrics collection switch.

![](img/huaweicloud_9.png)

### 3.4 Step Four: Cache Service

- You can choose to use the default built-in cache service. If you do not use the default built-in cache service, configure Redis according to the following requirements:
  - Distributed caching service (Redis version).
  - Redis version: 6.0, standard master-slave architecture, supports dual replicas.
  - Set a Redis password.
  - Add the internal network IP of the ECS automatically created by CCE to the Redis whitelist.

### 3.5 Step Five: InfluxDB

- Name: Cloud Database GaussDB(for Influx)
- Version: 1.7
- Set InfluxDB user password
- Add the internal network IP of the ECS automatically created by CCE to the InfluxDB whitelist

### 3.6 Step Six: Elasticsearch

- Name: Cloud Search Service CSS
- Version: 7.10.2
- Enable security mode to set up administrator accounts and passwords
- Add the internal network IP of the ECS automatically created by CCE to the Elasticsearch whitelist

### 3.7 Step Seven: RDS

- Name: Cloud Database RDS
- Version: 8.0, standard master-slave edition
- Set MySQL root user password
- Add the internal network IP of the ECS automatically created by CCE to the MySQL whitelist

## 4 kubectl Installation and Configuration

### 4.1 Install kubectl

kubectl is a command-line client tool for Kubernetes, which can be used to deploy applications, check and manage cluster resources, etc. Our Launcher is based on this command-line tool for deploying applications. Refer to the official documentation for specific installation methods:

[Install and Configure kubectl](https://kubernetes.io/docs/tasks/tools/){:target="_blank"}

You can also click **kubectl View** in the cluster.

![](img/huaweicloud_10.png)

### 4.2 Configure kube config

Choose whether to use public or private kubeconfig depending on whether your operations machine can access the cluster's internal network. Determine the connection method based on the following **usage scenarios**.

![](img/huaweicloud_11.png)

## 5 Start Installation

After completing the operations, refer to the manual [Start Installation](https://docs.guance.com/deployment/launcher-install/){:target="_blank"}