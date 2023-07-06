# Hybrid Cloud Deployment
---

## Overview
Guance is divided into SaaS service version and private deployment version. SaaS service version access is fast and convenient, and our center provides all services. Customers only need to install DataKit and start the required data collection to use all monitoring functions of Guance. For some customers with large application cluster monitoring and inconvenient data leaving the intranet, Guance can provide privately deployed versions. 

## Deployment and Implementation of Guance
The deployment and implementation of Guance is divided into three parts: 1. DataKit deployment of monitored objects and data collection implementation; 2. Implement the scheme of scene, view and anomaly detection in Guance; 3. If you use the privately deployed version of Guance, you need to deploy a set of Guance independently. 

After installing DataKit on the host object of the monitored user system and starting the corresponding data collection, it needs to be reported to the Guance center for visual insight into the data, data association analysis of metrics, logs, links, RUM, anomaly detection, etc. The Guance center can choose to use SaaS version or private deployment version. 
### SaaS Version of Guance
SaaS version has the characteristics of low access cost and fast implementation speed (only need to install and open DataKit in the customer application environment), which is suitable for small and medium-sized application cluster monitoring. It is characterized by low cost of early input, charging according to usage, and no early resource input. 

Refer to the section "DataKit Deployment Scenarios" later for a detailed implementation of DataKit. 

### Private Deployment Version of Guance
For customers with large volume or high control degree of system and data, they can use private deployment version and exclusive use of resources. In this way, the input cost is high in the early stage, and a resource procurement cost is needed in the early stage. Taking Alibaba Cloud as an example, the annual resource consumption cost is at least 200,000 ~ 300,000 (according to the total data scale of customers). 

### Private Deployment Architecture 

![](img/10.deployment_1.png)

Private deployment version of Guance, We are responsible for the installation, deployment and later maintenance and upgrade for customers. In order to ensure the security of customer application system, In the network planning of IT resources, it should be isolated from the monitored user application service cluster, and only the monitored objects are allowed to access Guance resources in one direction. VPC isolation, security group isolation and even deployment of the Guance to an independent cloud account can be used, which can effectively guarantee the data security of the user system. 

Guance center supports deployment on various clouds, it also supports deployment on offline hosts. Due to the differences in cloud products supported by various clouds and the differences in systems in different customer environments, the whole system adopts the cloud native micro-service architecture in deployment architecture, and uses Kubernetes as the deployment base of the whole system to ensure the consistency of the running environment of the system and eliminate system differences. 

Architecturally, all data such as hosts, application logs and links of user systems are collected by DataKit and reported to the Guance center through DataWay. If the amount of collected data is huge and a single DataWay cannot carry it, DataWay supports cluster deployment and horizontal expansion. 

In order to ensure that the data reported by clients is balanced and not blocked, the Guance Cloud center uses NSQ message queue (**an open source message system without center and automatic registration and discovery of nodes**). All data first enters NSQ message queue, and Kodo queues the consumption data. After processing, the time series metric data is written into InfluxDB, and the log text data is written into Elasticsearch. 

#### Deploy on the Cloud 
For the deployment of Guance, it is recommended to use the deployment scheme on the cloud, deploy all required hardware resources on the cloud, and give priority to the cloud products supported by cloud vendors, because the cloud products themselves ensure the reliability, stability and disaster tolerance of the infrastructure. 

Take Alibaba Cloud as an example. For example, Kubernetes uses Alibaba Cloud's **container service ACK**; InfluxDB uses Alibaba Cloud's **time series database InfluxDB version**; ElasticSearch uses Alibaba Cloud's big data cloud product **Elasticsearch**; MySQL uses Alibaba Cloud's **cloud database RDS MySQL version**, and Redis use **cloud database Redis version**.

#### Deployment on Offline Host 

Guance also supports deployment on offline hosts, and all basic components need to be built by themselves. The deployment of the Guance center must also be based on Kubernetes. 

First of all, Kubernetes cluster needs to be deployed on the offline host. All basic components such as InfuxDB, Elasticsearch, MySQL and Redis can be deployed in Kubernetes cluster in container mode. In order to improve the stability of the system, it is recommended to deploy in two container clusters together with Guance. 

## DataKit Deployment Scenario
The deployment and implementation of DataKit is independent of the architecture of the Guance center, and there is no difference in the target workspace of data access, whether accessing SaaS version of Guance or private deployment version of Guance. 
That is to say, after the implementation of DataKit, the target Guance center can be seamlessly switched, as long as the data gateway address is changed. 

### DataKit Infrastructure
![](img/10.deployment_2.png)

DataKit supports three mainstream platforms: Linux, MacOS and Windows. DataKit is installed in the monitored host. After installation, the collection of basic metrics of the host has been started by default, such as CPU, Mem, Disk, DiskIO and System. More other data collection can be started. For specific configuration methods and collection source list, please check the document [collection source configuration](../integrations/changgelog.md).

After the DataKit is installed, the 9529 listening port is opened by default (the default listening port can be modified in the datakit.conf file), which is used as the HTTP data access service port. The data collected by various external collection sources such as Metric, Log, Tracing, RUM and Security would be cleaned and formatted after reaching the DataKit through the HTTP interface address of the 9529 port, and then reported to the Guance center. 

### Link Tracing Deployment 
![](img/10.deployment_3.png)

DataKit supports data access of open source link acquisition frameworks such as Skywalking, Jaeger, Zipkin and ddTrace, and configures the agent output address of link acquisition framework as DataKit tracing routing address. 

The best deployment scheme is to deploy DataKit in every application server, so as to better unify the server host index, application log, syslog, application service link data and other data of application service and carry out correlation analysis. 

### User Access Monitoring Deployment 
![](img/10.deployment_4.png)

The access mode of user access monitoring data can view the document [RUM](../real-user-monitoring/index.md).

In the deployment mode, a DataKit (RUM DataKit) needs to be deployed on the user application server, and the application client introduces rum sdk of each end. After preprocessing and formatting by RUM DataKit, various page requests, resource requests, js error messages and other data accessing the client are uploaded to Guance. 

### Kubernetes Deployment

In the era of cloud native micro-service architecture, a large number of application services collect micro-service architecture. Kubernetes, as a cloud native container orchestration and scheduling tool, is frequently used. DataKit also supports containerized deployment. 

#### DaemonSet Mode

Two major advantages of DataKit deployment in Kubernetes using DaemonSet: 

1. Deployment is simple, and no matter how large the same service cluster is, it is not necessary for each service cluster to be deployed and implemented separately. 
1. With the high scalability of Kubernetes cluster, DataKit can be automatically opened on the automatically expanded node host without manual intervention. 

### Cluster Deployment Without Public Network Exit 
In some server-side scenarios, not all service hosts can access from the public network, and DataKit on these hosts without public network outlets cannot directly report data to Guance. 

You can open another host with public network export capability in the cluster as Proxy, and all DataKits in the cluster report data to Guance through this Proxy. 

DataKit itself also supports Proxy cascade. After installing DataKit on this public network host, Proxy can be started, and the data addresses of DataKit in the cluster can be configured to this Proxy DataKit. All monitoring data of the intranet host would be reported to the Guance center through this DataKit with public network exit. 

In addition, Nginx, HAProxy, H5 and other Proxy schemes can also be used to send the intranet data out of the public network after passing through Proxy. 

