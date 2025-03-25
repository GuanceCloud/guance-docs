## 1 Introduction

### 1.1 Document Description

This document mainly focuses on deployment on Huawei Cloud, introducing the complete steps from resource planning and configuration to deploying <<< custom_key.brand_name >>> and running it.

**Note:**

- This document uses **dataflux.cn** as the main domain example; in actual deployment, replace it with the corresponding domain.

### 1.2 Key Terms

| **Term**   | **Description**                                                     |
| :--------- | :----------------------------------------------------------------- |
| Launcher   | A WEB application used for deploying and installing <<< custom_key.brand_name >>>. Follow the steps provided by the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>. |
| Operations Machine | A machine with kubectl installed, within the same network as the target Kubernetes cluster.   |
| Installation Machine | The machine that accesses the launcher service via a browser to complete the guided installation of <<< custom_key.brand_name >>>.       |
| kubectl    | Kubernetes command-line client tool, installed on the **operations machine**.      |

### 1.3 Deployment Architecture

[![img](<<< homepage >>>/deployment/img/23.install-step.png)](<<< homepage >>>/deployment/img/23.install-step.png)

## 2 Resource List

???+ warning "Note"

     **1.** The "**Minimum Configuration**" is only suitable for POC scenarios and is intended for functional verification, not for production environments.
    
     **2.** The "**Recommended Configuration**" is suitable for scenarios where InfluxDB has fewer than 150,000 time series and Elasticsearch has fewer than 7 billion documents (the total number of documents for logs, traces, user access monitoring, and events).
    
     **3.** For production deployment, assess based on the actual amount of data being ingested. The more data ingested, the higher the storage and specification requirements for InfluxDB and Elasticsearch.
    
     **4.** If using self-built TDengine and OpenSearch, they need to be added to the CCE node pool. Self-built OpenSearch nodes require 3 coordinating nodes (4c8g) and 3 data nodes (8c32g), totaling 6 nodes.


| **Resources**                  | **Specification (Minimum Configuration)** | **Specification (Recommended Configuration)**   | **Quantity** | **Notes**                                           |
| ----------------------------- | --------------------------------------- | -------------------------------------------- | ----------- | ---------------------------------------------------|
| CCE                          | Standard Managed Cluster Edition          | Standard Managed Cluster Edition              | 1           | Version: 1.23                                        |
| CCE Node Pool                 | 4C8G (Single system disk 80GB)          | 8C16G (Single system disk 120GB)            | 4           | Deploy Huawei Cloud CCE managed cluster             |
|                              | 2C4G (Single system disk 80GB)          | 4C8G (Single system disk 120GB)             | 2           | Deploy Dataway                                      |
| NAT Gateway                  | Small NAT Gateway                       | Small NAT Gateway                           | 1           | Used for outbound traffic from the CCE cluster       |
| ELB                          | Shared type                            | Shared type                                 | 1           | Positioned before Kubernetes Ingress                  |
| RDS                          | 2C4G 50GB                              | 4C8G 100GB (Master-Slave)                   | 1           | MySQL 8.0                                          |
| Redis                        | 4G                                    | 8G (Standard Master-Slave Dual Replica)     | 1           | Version: 6.0                                         |
| TDengine &#124; InfluxDB      | 4C16G 300GB                            | 8C32G 500GB (Cluster Edition)                | 1           | TDengine (**Self-built**) Version: 2.6+ InfluxDB Version: 1.7.x       |
| Elasticsearch\|OpenSearch     | 4C16G 1TB (Single node)                 | 16C64G 2TB (3 nodes)                        | 1           | Elasticsearch Version: 7.10.2  OpenSearch (**Self-built**) Version: 2.3 |
| Domain Name                  | -                                     | -                                           | 1           | The main domain must be registered; eight subdomains under one main domain are required                             |
| SSL Certificate              | Wildcard domain certificate             | Wildcard domain certificate                 | 1           | -                                                  |

## 3 Infrastructure Deployment

### 3.1 Deployment Description

**RDS, Redis, InfluxDB, Elasticsearch** should be created according to the configuration requirements, all within the same region and under the same **VPC** network.

### 3.2 Steps One, Two, Three - CCE Service Creation

#### 3.2.1 Step One - Purchase CCE Cluster

Go to the official website and select **Products** in the navigation bar, choose **Container**, click **Cloud Container Engine CCE**, and create a CCE cluster.

- It must be in the same region as the RDS, InfluxDB, and Elasticsearch resources mentioned later.
- Mainly choose the **cluster size** based on your own situation, and then create **worker nodes** later.

![](img/huaweicloud_1.png)

#### 3.2.2 Step Two - Worker Node Configuration

Mainly choose ECS specifications and quantity. Specifications can be created according to the requirements in the resource list or assessed based on actual needs, but they cannot be lower than the minimum configuration requirements. The quantity should be at least 3 nodes, or more than 3, and here it is recommended that the data disk should not be less than **100GiB**.

![](img/huaweicloud_2.png)

![](img/huaweicloud_3.png)

#### 3.2.3 Step Three - Plugin Management

Everest and coredns plugins have been created by default when purchasing the k8s cluster. Here, it is recommended to add two additional plugins for installation. To ensure cluster resources and avoid additional costs, it is suggested to delete the **ICAgent** plugin.

![](img/huaweicloud_4.png)

**Install nginx-ingress plugin**

1) Configure CPU and memory resource limits

![](img/huaweicloud_5.png)

2) Create Load Balancer ELB

If needed, you can choose a dedicated elastic load balancer. In this article, we choose a shared type. Note: Choose **Elastic Public IP** and recommend using an existing one, or create a new one with a bandwidth charge of 300Mbit/s.

- Differences between dedicated and shared types can be found in the following link:

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

- Enable DNS Config Injection function

???+ warning "Note"
     Add the label node-local-dns-injection=enabled to the namespace for the DNS cache feature to work.

**Delete ICAgent plugin** (Optional)

Choose **AOM Application Operations Management**, uninstall the **ICAgent plugin**, and turn off the switches for log over-limit collection and metric collection.

![](img/huaweicloud_9.png)

### 3.4 Step Four - Cache Service

- You can use the default built-in caching service. If you do not use the default built-in caching service, configure Redis according to the following requirements:
  - Distributed caching service (Redis version).
  - Redis version: 6.0, standard master-slave architecture, supports dual replicas.
  - Set the Redis password.
  - Add the automatically created ECS internal network IP of CCE to the Redis whitelist.

### 3.5 Step Five - InfluxDB

- Name: Cloud Database GaussDB(for influx)
- Version: 1.7
- Set InfluxDB user password
- Add the automatically created ECS internal network IP of CCE to the InfluxDB whitelist

### 3.6 Step Six - Elasticsearch

- Name: Cloud Search Service CSS
- Version: 7.10.2
- Enable security mode to set the administrator account and password
- Add the automatically created ECS internal network IP of CCE to the Elasticsearch whitelist

### 3.7 Step Seven - RDS

- Name: Cloud Database RDS
- Version: 8.0, standard master-slave edition
- Set the MySQL root user password
- Add the automatically created ECS internal network IP of CCE to the MySQL whitelist

## 4 kubectl Installation and Configuration

### 4.1 Install kubectl

kubectl is a Kubernetes command-line client tool that allows you to deploy applications, check, and manage cluster resources through this command-line tool. Our Launcher is based on this command-line tool for application deployment. Specific installation methods can be found in the official documentation:

[Install and Configure kubectl](https://kubernetes.io/docs/tasks/tools/){:target="_blank"}

You can also click the cluster and find **kubectl Click to View**

![](img/huaweicloud_10.png)

### 4.2 Configure kube config

Choose whether to use public or private kubeconfig depending on whether your operations machine is connected to the cluster's internal network. Determine the connection method based on the **use cases** below.

![](img/huaweicloud_11.png)

## 5 Start Installation

After completing the operations, refer to the manual [Start Installation](<<< homepage >>>/deployment/launcher-install/){:target="_blank"}