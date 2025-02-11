# Hybrid Cloud Deployment Solution
---

## Overview
Guance is available in two versions: SaaS and private deployment. The SaaS version offers quick and easy integration, with all services provided by our center. Customers only need to install DataKit and enable the required data collection to use all monitoring features of Guance. For customers who require monitoring for larger application clusters or have data that cannot leave the internal network, Guance provides a private deployment version.

## Deployment Implementation of Guance
The deployment of Guance is divided into three parts: 1. Deployment of DataKit on monitored objects and implementation of data collection; 2. Configuration of scenarios, views, anomaly detection, etc., within Guance; 3. If using the private deployment version of Guance, an independent deployment of Guance is also required.

After installing DataKit on the monitored system hosts and enabling the corresponding data collection, the data needs to be reported to the Guance center for visualization and analysis of metrics, logs, traces, RUM, etc., as well as anomaly detection. The Guance center can either use the SaaS version or the private deployment version.
### SaaS Version of Guance
The SaaS version has low usage costs and fast implementation (only requiring installation and activation of DataKit in the customer's application environment), making it suitable for monitoring medium to small-scale application clusters. Its key feature is low upfront investment, pay-as-you-go pricing, and no initial resource commitment.

For specific DataKit implementation details, refer to the "DataKit Deployment Plan" section later.

### Private Deployment Version of Guance
For customers with larger volumes or higher requirements for system and data control, the private deployment version allows exclusive resource usage. This approach requires a higher initial investment, including resource procurement fees. For example, deploying on Alibaba Cloud would incur annual resource consumption costs of at least 200,000 to 300,000 RMB (depending on the total data scale).

### Private Deployment Architecture

![](img/10.deployment_1.png)

Private deployment of Guance involves us handling installation, deployment, and subsequent maintenance and upgrades for customers. To ensure the security of the customer's application system, IT resources should be isolated from the monitored application service cluster, allowing only unidirectional access from the monitored objects to Guance resources. VPC isolation, security group isolation, or even deploying Guance under a separate cloud account can effectively protect user system data security.

Guance supports deployment on various clouds and offline hosts. Due to differences in supported cloud products and customer environments, the entire system uses a cloud-native microservices architecture with Kubernetes as the deployment foundation to ensure consistent runtime environments and eliminate system discrepancies.

In terms of architecture, all host, application log, trace, and other data are collected by DataKit and reported to the Guance center via DataWay. If the data volume is large, DataWay supports clustered deployment for horizontal scaling.

To ensure smooth data reporting without bottlenecks, Guance uses NSQ message queues (a decentralized, node auto-registration and discovery open-source messaging system). All data first enters the NSQ queue, then Kodo processes it, writing time series metric data to InfluxDB and log text data to Elasticsearch.

#### Cloud Deployment
We recommend cloud-based deployment for Guance. All required hardware resources are selected from cloud vendor-supported products, ensuring infrastructure reliability, stability, and disaster recovery.

For example, on Alibaba Cloud:
- Kubernetes uses **Container Service ACK**,
- InfluxDB uses the **Time Series Database InfluxDB Edition**,
- Elasticsearch uses the **Elasticsearch** big data product,
- MySQL uses **RDS MySQL Edition**,
- Redis uses **Redis Edition**.

#### Offline Host Deployment
Guance also supports deployment on offline hosts, where all basic components must be set up independently. The Guance center deployment must be based on Kubernetes.

First, deploy a Kubernetes cluster on the offline host. All basic components like InfluxDB, Elasticsearch, MySQL, Redis, etc., can be deployed as containers within the Kubernetes cluster. For improved system stability, it is recommended to deploy these components in separate container clusters.

## DataKit Deployment Plan
DataKit deployment is independent of the Guance center architecture. Whether connecting to the SaaS version or private deployment version of Guance, there is no difference in the target workspace. After implementing DataKit, you can seamlessly switch the target Guance center by simply changing the data gateway address.
### DataKit Basic Architecture
![](img/10.deployment_2.png)

DataKit supports the three major platforms: Linux, MacOS, Windows. Installing DataKit on monitored hosts defaults to enabling the collection of basic metrics such as CPU, Mem, Disk, DiskIO, System, etc. Additional data collection can be enabled as needed. For configuration methods and source lists, see the [Collection Source Configuration](../integrations/integration-index.md) documentation.

After installation, DataKit listens on port 9529 (which can be modified in the `datakit.conf` file) as an HTTP data intake port. Various external sources such as Metrics, Logs, Tracing, RUM, Security send data through the HTTP interface at port 9529, which is then processed and forwarded to the Guance center.

### Trace Deployment
![](img/10.deployment_3.png)

DataKit supports data intake from open-source tracing frameworks like Skywalking, Jaeger, Zipkin, ddTrace. Configure the agent output addresses of these tracing frameworks to the DataKit tracing route address.

The optimal deployment plan is to install DataKit on each application server to better correlate server host metrics, application logs, syslog, and application service trace data for comprehensive analysis.

### User Access Monitoring Deployment
![](img/10.deployment_4.png)

Refer to the [User Access Monitoring](../real-user-monitoring/index.md) documentation for data intake methods.

Deployment involves installing a DataKit (RUM DataKit) on the user application server and integrating the appropriate RUM SDKs on the client side. Various page requests, resource requests, JS error information, etc., are preprocessed and formatted by the RUM DataKit before being uploaded to Guance.

### Kubernetes Deployment

In the era of cloud-native microservices architecture, many applications adopt microservices architecture, and Kubernetes is widely used as a cloud-native container orchestration and scheduling tool. DataKit also supports containerized deployment.

#### DaemonSet Method

Deploying DataKit using the DaemonSet method in Kubernetes has two main advantages:

1. Simplified deployment: Regardless of the size of the service cluster, individual deployments are not required.
1. High scalability: DataKit automatically starts on newly scaled-out nodes without manual intervention.

### Cluster Deployment Without Public Internet Access
In some scenarios, not all service hosts can access the public internet. DataKit on these hosts cannot directly report data to Guance.

A proxy solution can be implemented by deploying a host with public internet access within the cluster. All DataKit instances within the cluster send data through this proxy to Guance.

DataKit also supports cascading proxies. By installing DataKit on the public internet host and enabling the proxy function, internal hosts' monitoring data can be routed through this DataKit to the Guance center.

Additionally, Nginx, HAProxy, H5, and other proxy solutions can be used to route internal data to the public internet.