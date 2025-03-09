# Hybrid Cloud Deployment Solution
---

## Overview
"<<< custom_key.brand_name >>>" is available in two editions: SaaS service and private deployment. The SaaS service edition offers quick and easy integration, with all services provided by our center. Customers only need to install DataKit and enable the required data collection to use all monitoring features of "<<< custom_key.brand_name >>>". For customers who require large-scale application cluster monitoring or have data that cannot leave the internal network, "<<< custom_key.brand_name >>>" can provide a private deployment version.

## Deployment Implementation of "<<< custom_key.brand_name >>>"
The deployment implementation of "<<< custom_key.brand_name >>>" consists of three parts: 1) Deployment of DataKit on monitored objects and data collection; 2) Implementation of scenarios, views, anomaly detection, etc., within "<<< custom_key.brand_name >>>"; 3) If using the private deployment version of "<<< custom_key.brand_name >>>", an independent deployment of "<<< custom_key.brand_name >>>" is also required.

DataKit is installed on the monitored user system hosts. After enabling the corresponding data collection, the data needs to be reported to the "<<< custom_key.brand_name >>>" center for visualization and insights, including correlation analysis of metrics, logs, traces, RUM, etc., and anomaly detection. The "<<< custom_key.brand_name >>>" center can either use the SaaS version or the private deployment version.
### SaaS Version of "<<< custom_key.brand_name >>>"
The SaaS version has low access and usage costs and fast implementation (only requiring the installation and activation of DataKit in the customer's application environment), making it suitable for medium to small-scale application clusters. It features low upfront investment and pay-as-you-go pricing, eliminating the need for initial resource investment.

For specific implementation steps for DataKit, refer to the "DataKit Deployment Plan" section.

### Private Deployment Version of "<<< custom_key.brand_name >>>"
For larger-scale applications or customers requiring higher control over systems and data, the private deployment version can be used, ensuring exclusive resource usage. This approach requires higher upfront investment, including resource procurement costs. For example, deploying on Alibaba Cloud would incur annual resource consumption costs of at least 200,000 to 300,000 RMB (depending on the total data scale).

### Private Deployment Architecture

![](img/10.deployment_1.png)

Private deployment of "<<< custom_key.brand_name >>>" is handled by us, including installation, deployment, and ongoing maintenance and upgrades. To ensure the security of the customer’s application system, IT resources should be isolated from the monitored user application service cluster, allowing only one-way access from monitored objects to "<<< custom_key.brand_name >>>" resources. This can be achieved through VPC isolation, security group isolation, or even deploying "<<< custom_key.brand_name >>>" in a separate cloud account, effectively safeguarding the security of the user system's data.

The "<<< custom_key.brand_name >>>" center supports deployment on various clouds and offline hosts. Due to differences in supported cloud products and customer environments, the system adopts a cloud-native microservices architecture, using Kubernetes as the deployment foundation to ensure consistent runtime environments and eliminate system differences.

In this architecture, all host, application log, trace, and other data are collected by DataKit and reported to the "<<< custom_key.brand_name >>>" center via DataWay. If the data volume is enormous and a single DataWay cannot handle it, DataWay supports cluster deployment for horizontal scaling.

To ensure balanced and non-blocking client-side data reporting, the "<<< custom_key.brand_name >>>" center uses NSQ message queues (an open-source message system with no central node, automatic registration, and discovery). All data first enters the NSQ message queue, then Kodo processes and consumes the data, writing time series metrics to InfluxDB and log text data to Elasticsearch.

#### Cloud Deployment
We recommend cloud deployment for "<<< custom_key.brand_name >>>". Cloud deployment utilizes hardware resources provided by cloud vendors, leveraging cloud products that ensure infrastructure reliability, stability, and disaster recovery.

For example, on Alibaba Cloud:
- Kubernetes uses **Alibaba Cloud Container Service ACK**
- InfluxDB uses **Alibaba Cloud Time Series Database InfluxDB Edition**
- Elasticsearch uses **Alibaba Cloud Elasticsearch**
- MySQL uses **Alibaba Cloud RDS MySQL Edition**
- Redis uses **Alibaba Cloud Redis**

#### Offline Host Deployment
"<<< custom_key.brand_name >>>" also supports deployment on offline hosts, where all basic components must be set up independently. The "<<< custom_key.brand_name >>>" center must be deployed based on Kubernetes.

First, deploy a Kubernetes cluster on the offline host. All basic components such as InfluxDB, Elasticsearch, MySQL, Redis, etc., can be deployed as containers within the Kubernetes cluster. To improve system stability, we recommend deploying "<<< custom_key.brand_name >>>" and its dependencies in separate container clusters.

## DataKit Deployment Plan
DataKit deployment is independent of the "<<< custom_key.brand_name >>>" center architecture. Regardless of whether you connect to the SaaS version or the private deployment version of "<<< custom_key.brand_name >>>", there is no difference in data ingestion into the target workspace. Once DataKit is implemented, switching the target "<<< custom_key.brand_name >>>" center only requires changing the data gateway address.

### DataKit Basic Architecture
![](img/10.deployment_2.png)

DataKit supports three major platforms: Linux, MacOS, Windows. Installing DataKit on the monitored host enables default collection of basic host metrics like CPU, Mem, Disk, DiskIO, System, etc. Additional data collection can be enabled as needed. Specific configuration methods and source lists can be found in the [Collection Source Configuration](../integrations/integration-index.md) documentation.

After installation, DataKit listens on port 9529 (the default listening port can be modified in the datakit.conf file) as an HTTP data intake service. Various external collection sources like Metrics, Logs, Traces, RUM, Security send data to DataKit via the HTTP interface on port 9529, which then cleans and formats the data before reporting it to the "<<< custom_key.brand_name >>>" center.

### Trace Deployment
![](img/10.deployment_3.png)

DataKit supports data intake from open-source tracing frameworks like Skywalking, Jaeger, Zipkin, ddTrace. Configure the agent output address of the tracing framework to the DataKit tracing route address.

The optimal deployment plan is to deploy DataKit on each application server to better correlate host metrics, application logs, syslog, and application service trace data for unified analysis.

### User Access Monitoring Deployment
![](img/10.deployment_4.png)

For user access monitoring data ingestion, refer to the [User Access Monitoring](../real-user-monitoring/index.md) documentation.

Deployment involves installing a DataKit (RUM DataKit) on the user application server and integrating the appropriate RUM SDKs on the client side. Various page requests, resource requests, JS error information, etc., from the user client are preprocessed and formatted by RUM DataKit before being uploaded to "<<< custom_key.brand_name >>>".

### Kubernetes Deployment

In the era of cloud-native microservices architectures, many application services adopt microservices architecture. Kubernetes, as a cloud-native container orchestration and scheduling tool, is increasingly used. DataKit also supports containerized deployment.

#### DaemonSet Method

Deploying DataKit in Kubernetes using the DaemonSet method offers two main advantages:

1. Simple deployment: Regardless of the size of the service cluster, no individual deployment is required.
2. Leveraging Kubernetes cluster scalability: Automatically start DataKit on newly added nodes without manual intervention.

### Cluster Deployment Without Public Internet Access
In some server scenarios, not all service hosts can access the public internet. For these hosts, DataKit cannot directly report data to "<<< custom_key.brand_name >>>".

A solution is to use a host with public internet access as a Proxy within the cluster. All DataKit instances within the cluster can route their data through this Proxy to "<<< custom_key.brand_name >>>".

DataKit also supports proxy chaining. Install DataKit on the public internet host and configure it as a Proxy. Set the data addresses of all internal DataKit instances to this Proxy DataKit, allowing internal host monitoring data to be reported to the "<<< custom_key.brand_name >>>" center via this DataKit.

Additionally, Nginx, HAProxy, H5, and other Proxy solutions can be used to route internal data to the public internet.