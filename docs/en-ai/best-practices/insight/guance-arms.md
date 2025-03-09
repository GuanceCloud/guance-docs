# <<< custom_key.brand_name >>> vs Alibaba Cloud ARMS 3.0

---

## Product Comparison
Background introduction:

40 Alibaba Cloud ECS instances, log volume of 70-80 GB/day (including trace data), approximately 60 million lines/day, PV 30,000/day.

### Deployment Architecture Comparison

![image.png](../images/guance-arms-1.png)

### Product Cost Comparison

(This represents this specific test only)

![image.png](../images/guance-arms-2.png)

### Resource Consumption Comparison

(This represents this specific test only)

![image.png](../images/guance-arms-3.png)

## ARMS 3.0

Application Real-Time Monitoring Service (ARMS) is an APM product that includes three major sub-products: application monitoring, Prometheus monitoring, and frontend monitoring. It covers performance management for distributed applications, container environments, browsers, mini-programs, and mobile apps, providing comprehensive stack performance monitoring and end-to-end full trace diagnostics to make application operations efficient and easy.
![](../images/guance-arms-4.png)

### Prometheus

Alibaba Cloud Prometheus Monitoring fully integrates with the open-source Prometheus ecosystem, supporting rich component monitoring and offering various pre-configured dashboards. It also provides a fully managed Prometheus service.

#### Access Methods

1. ACK (Alibaba Cloud Container Service for Kubernetes) Kubernetes cluster

2. Self-built Kubernetes cluster

3. RemoteWrite (remote storage)

#### Implementation Configuration

Prometheus data ingestion is based on Kubernetes clusters. Directly create [[Kubernetes Managed Cluster](https://help.aliyun.com/document_detail/85903.htm?spm=a2c4g.11186623.2.6.472e7cb6yXVXyj#task-mmv-33q-n2b)]. After creation, you can see built-in dashboard views related to Kubernetes on the page.

![image.png](../images/guance-arms-5.png)

#### Product Pricing

Prometheus monitoring charges based on the number of metric reports. Metrics are divided into two types: basic metrics and custom metrics. Among them, [[basic metrics](https://help.aliyun.com/document_detail/148104.html#concept-2372936)] are free, while custom metrics incur charges.

| Daily Reported Metric Range (millions) | Unit Price (CNY/million) | Daily Charge Range (CNY) |
| --- | --- | --- |
| 0~50 | 0.8 | 0~40 |
| 50~150 | 0.65 | 40~105 |
| 150~300 | 0.55 | 105~187.5 |
| 300~600 | 0.45 | 187.5~322.5 |
| 600~1200 | 0.35 | 322.5~530.5 |
| Over 1200 | 0.25 | Over 530.5 |

##### Notes

1. Each reported metric must not exceed 2 KB.

2. Each metric is stored for up to 15 days; data older than 15 days will be cleared but can be adjusted upon request.

### CloudMonitor

CloudMonitor is a service for monitoring Alibaba Cloud resources and internet applications.

#### Access Methods

Prometheus integrates with Alibaba Cloud CloudMonitor, allowing cloud services in specified regions to be monitored within Prometheus via CloudMonitor.

Currently supported services include ECS, RDS MongoDB, Redis, OSS, RDS, NAT, SLB, RocketMQ, Kafka, EIP, ES, and DRDS.

#### Implementation Configuration

Add cloud service access in the Prometheus configuration interface.

![image.png](../images/guance-arms-6.png)

#### Product Pricing

After integrating Prometheus with CloudMonitor, CloudMonitor does not incur additional charges. The collected monitoring data will be charged **according to Prometheus rules**.

### Frontend Monitoring

ARMS frontend monitoring focuses on Web scenarios, Weex scenarios, and mini-program scenarios, monitoring the health of Web and mini-program pages from three aspects: page load speed (speed measurement), page stability (JS Error), and external service call success rate (API).

#### Access Methods

Web Scenarios

- CDN installation of probe

- NPM installation of probe

Weex Scenarios

- Weex integration

Mini-Program Scenarios

- DingTalk Mini Program

- Alipay Mini Program

- WeChat Mini Program

- Other categories

#### Implementation Configuration

Create an application site, choose Web type integration, copy the BI probe (code) and place it in the first line of the HTML `<body>` content.

![image.png](../images/guance-arms-7.png)

#### Product Pricing

##### Basic Edition

Pay-as-you-go

| Billing Volume | Billing Unit Price |
| --- | --- |
| All sites frontend data reporting times | 0.028 CNY / 1000 page reporting times |

##### Professional Edition

Pay-as-you-go

| Billing Volume | Billing Unit Price |
| --- | --- |
| All sites frontend data reporting times | 0.28 CNY / 1000 page reporting times |

Resource Packs

| Name | Specification | Price | Discounted Billing Price | Validity Period |
| --- | --- | --- | --- | --- |
| Basic Resource Pack | 2 million page reporting times | 420 CNY | 0.21 CNY / 1000 frontend data reporting times | 6 months |
| Intermediate Resource Pack | 16 million page reporting times | 2,520 CNY | 0.158 CNY / 1000 frontend data reporting times | 1 year |
| Advanced Resource Pack | 128 million page reporting times | 15,120 CNY | 0.118 CNY / 1000 frontend data reporting times | 1 year |
| Gold Resource Pack | 600 million page reporting times | 60,000 CNY | 0.1 CNY / 1000 frontend data reporting times | 1 year |

##### Notes

1. Frontend monitoring: billing primarily measures page PV calls and API call reporting times, self-defined reporting times. Charges are settled daily, with any less than 1000 reporting times rounded up to 1000. Frontend monitoring data is cached by default for 30 days.

2. Calculation formula reference: Daily reported traffic = daily PV + (daily API calls - 500,000 per day) * 0.1 + self-defined reporting.

3. Data reporting times generated by one PV = 1 + API call times + self-defined data reporting times. In most cases, page data reporting times are roughly equal to page visits.

### Application Monitoring

ARMS Application Monitoring is an APM product. Without modifying code, just install a probe for your application, ARMS can provide comprehensive monitoring, helping you quickly locate faulty interfaces and slow interfaces, reproduce call parameters, discover system bottlenecks, and significantly improve online issue diagnosis efficiency.

#### Data Access

By deployment environment

- EDAS

- ACK (Alibaba Cloud Container Service)

- Open-source K8s cluster

- Docker cluster

- Other environments (such as self-built IDC)

By development language

- JAVA

- PHP

#### Implementation Configuration

Integrate the application, choose Java language, and use script auto-installation method.

![image.png](../images/guance-arms-8.png)

#### Product Pricing 

##### Basic Edition

| Name | Billing Content | Notes |
| --- | --- | --- |
| Application Monitoring Basic Edition - Statistical Metric Storage Costs | Statistical metrics stored for 3 days, free.<br />Statistical metrics stored for 30 days, 1.2 CNY per probe per day.<br />Statistical metrics stored for 90 days, 2.4 CNY per probe per day.<br />Statistical metrics stored for 180 days, 3.6 CNY per probe per day. | (1) Default storage period for statistical metrics is 3 days, free to use. To extend the storage period, adjust settings in the global configuration - storage period configuration page under Application Monitoring.<br /> (2) One probe can monitor one application instance (e.g., one Tomcat instance, one Java process).<br /> (3) Supports upgrading to the Expert Edition, which charges according to the Expert Edition after activation. |
| Application Monitoring Basic Edition - Call Chain Storage Costs | 0.2 CNY / million request chains * day<br />Default sampling strategy stores for 1 day, free. | (1) Free sampling and storing the first request chain every minute for each interface for 1 day. To store more request chains, adjust settings in the custom configuration - sampling rate page under Application Settings, billed on a pay-as-you-go basis.<br /> (2) All calls under the same TraceId are considered one request chain, with a maximum of ten Spans per chain. Excess parts are billed at one-tenth the request chain.<br /> (3) Supports upgrading to the Expert Edition, which charges according to the Expert Edition after activation. |

##### Professional Edition

Pay-as-you-go:

| Billing Item | Billing Unit Price |
| --- | --- |
| Pay-as-you-go | 6.72 CNY per probe per day |

Resource pack pricing:

| Name | Specification | Price | Discounted Billing Price | Validity Period |
| --- | --- | --- | --- | --- |
| Basic Resource Pack | 150 probes*day (resources sufficient for 150 probes for 1 day or 5 probes for 30 days) | 700 CNY | 4.68 CNY / probe*day | 6 months |
| Intermediate Resource Pack | 1200 probes*day (resources sufficient for 1200 probes for 1 day or 40 probes for 30 days) | 4,200 CNY | 4.38 CNY / probe*day | 1 year |
| Advanced Resource Pack | 9600 probes*day (resources sufficient for 9600 probes for 1 day or 320 probes for 30 days) | 25,200 CNY | 2.616 CNY / probe*day | 1 year |
| Gold Resource Pack | 36500 probes*day (resources sufficient for 100 probes for 365 days) | 66,838 CNY | 1.8312 CNY / probe*day | 1 year |
| Platinum Resource Pack | 109500 probes*day (resources sufficient for 300 probes for 365 days) | 174,000 CNY | 1.5696 CNY / probe*day | 1 year |
| Top-tier Resource Pack | 182500 probes*day (resources sufficient for 500 probes for 365 days) | 238,710 CNY | 1.308 CNY / probe*day | 1 year |

##### Notes

1. One probe can monitor one application instance (e.g., one Tomcat instance, one Java process).

2. Application monitoring: traffic is calculated based on the total online time of all applications, settled daily. Application monitoring data is cached by default for 60 days.

### Synthetic Tests

Synthetic Tests is a service for monitoring the performance and user experience of internet applications (Web pages, network links, etc.).

#### Access Methods

Synthetic Tests can utilize a globally distributed monitoring network to perform browsing or network tests on target Web applications (such as websites, servers), currently supporting up to 50 monitoring points per task.

#### Implementation Configuration

Create a Synthetic Test task, add URLs and monitoring points (up to 50) to be monitored.

![image.png](../images/guance-arms-9.png)
#### Product Pricing

Synthetic Tests entered public beta on November 20, 2020. You can activate the 15-day free trial version of ARMS or any paid version to use Synthetic Tests. During the beta period, even after the 15-day trial expires, you can still **use Synthetic Tests for free**.

### Log Monitoring

For highly customized business scenarios, you can create log monitoring tasks to freely calculate required metrics, generate necessary data and reports, and configure alarms flexibly.

#### Access Methods

ARMS Log Monitoring supports completely customizable monitoring tasks, involving configuring data sources and metrics, as shown in the following figure.

![](../images/guance-arms-10.png)
#### Configuration Implementation

Prerequisites: [[Activate Alibaba Cloud Log Service](https://www.aliyun.com/product/sls?spm=a2c4g.11186623.2.9.2f287973Qu3iYk)], synchronize LogHub, and generate required metrics

![image.png](../images/guance-arms-11.png)

#### Product Pricing

Log metrics generated **are charged according to Prometheus rules**

## <<< custom_key.brand_name >>>

<<< custom_key.brand_name >>> is a cloud service platform aimed at solving observability for complete applications in the era of cloud computing and cloud-native systems.

### Access Methods

- Frontend page configuration

- Datakit data collection

### Implementation Configuration

#### Host Infrastructure

Install Datakit, default enabling [CPU, System, Mem, Disk, DiskIO, Swap, Net information collection], view **infrastructure** information

![image.png](../images/guance-arms-12.png)

#### Application Middleware

Configure Datakit [[Mysql data collection](/../../integrations/mysql.md)] and [[Nginx data collection](/datakit/nginx/)], click on host `integration runtime`

Nginx redirects to built-in views

![image.png](../images/guance-arms-13.png)

![](../images/guance-arms-14.png)

#### Logs
Configure Datakit [[Mysql data collection](/../../integrations/mysql.md)] and [[Nginx data collection](/datakit/nginx/)] log configurations, or enable custom log configuration [Tailf data collection], after creation you can see the log list

![image.png](../images/guance-arms-15.png)

Click on log source to view detailed log information (processed with Grok parsing)

![image.png](../images/guance-arms-16.png)

#### APM

Download dd-java-agent.jar, add it as a javaagent parameter to the Java application startup command (-javaagent:/root/mall/dd-java-agent-0.75.0.jar), configure Datakit's [dd-trace data collection], after successful creation you can see the application list

![image.png](../images/guance-arms-17.png)

Click on service name to see summary

![image.png](../images/guance-arms-18.png)

Click on trace to see trace information

![image.png](../images/guance-arms-19.png)

Click on service name to see flame graph and detailed information

![image.png](../images/guance-arms-20.png)

#### RUM

Create an application, choose Web type integration, copy the probe (code) and place it in the first line of the HTML `<body>` content

![image.png](../images/guance-arms-21.png)

#### Synthetic Tests

Create new URL and test point along with frequency
![image.png](../images/guance-arms-22.png)

#### Incident Detection Library

Built-in host detection library (no configuration needed), other detection libraries added as needed

![image.png](../images/guance-arms-23.png)

### Product Pricing

#### Pay-as-you-go Basic Pricing Model

<<< custom_key.brand_name >>> offers two pricing models, switchable in the billing center. One model calculates "DataKit+Time Series" quantities, while the other calculates only "Time Series" quantities. Other general billing items include backup log data quantity, API synthetic test counts, task scheduling counts, and SMS sending counts.

###### 1. Calculating "DataKit+Time Series" Quantities

| **Billing Item** | **Billing Unit** | **Commercial Plan Unit Price** |
| --- | --- | --- |
| Datakit Quantity | Per 1 unit | 3 CNY |
| Time Series Quantity | Per 500 units | 3 CNY |
| Backup Log Data Quantity | Per 10 million units | 2 CNY |
| API Synthetic Test Counts | Per 10,000 units | 1 CNY<br />Note: Statistics do not include API synthetic test data from user-defined nodes |
| Task Scheduling Counts | Per 10,000 units | 1 CNY |

Time Series calculation formula:

- Billable Time Series Quantity = Time Series Quantity - DataKit Quantity * 500

- Billable Time Series Quantity Invoice = (Time Series Quantity - DataKit Quantity * 500) / 500 * 3

- If the calculated billable Time Series Quantity <= 0, it is counted as 0.

###### 2. Calculating "Time Series" Quantities

| **Billing Item** | **Billing Unit** | **Commercial Plan Unit Price** |
| --- | --- | --- |
| Time Series Quantity | Per 300 units | 3 CNY |
| Backup Log Data Quantity | Per 10 million units | 2 CNY |
| API Synthetic Test Counts | Per 10,000 units | 1 CNY<br />Note: Statistics do not include API synthetic test data from user-defined nodes |
| Task Scheduling Counts | Per 10,000 units | 1 CNY |
| SMS Sending Counts | Per 10 units | 1 CNY |

Time Series calculation formula:

- Billable Time Series Quantity = Time Series Quantity

- Billable Time Series Quantity Invoice = Time Series Quantity / 300 * 3

##### Tiered Pricing Model

###### Log Data

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |  |
| --- | --- | --- | --- | --- |
| Data Retention Policy |  | 14 days | 30 days | 60 days |
| Log Data Quantity | Per million units | 1.5 CNY | 2 CNY | 2.5 CNY |

###### APM Trace

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |
| --- | --- | --- | --- |
| Data Retention Policy |  | 7 days | 14 days |
| APM Trace Quantity | Per million units | 3 CNY | 6 CNY |

###### RUM PV

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |
| --- | --- | --- | --- |
| Data Retention Policy |  | 7 days | 14 days |
| RUM PV Quantity | Per 10,000 units | 1 CNY | 2 CNY |

#### Annual Subscription Packages

##### Startup Accelerator Package

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 20 units | **￥ 72,168** | **￥ 42,000** |
| Log Data | 40 million |  |  |
| APM Trace | 5 million |  |  |
| RUM PV | 400,000 |  |  |
| Task Calls | 190,000 |  |  |

##### Entrepreneur Development Package

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 100 units | **￥ 517,080** | **￥ 280,000** |
| Log Data | 400 million |  |  |
| APM Trace | 50 million |  |  |
| RUM PV | 2 million |  |  |
| Task Calls | 1.4 million |  |  |

##### Enterprise Standard Package

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 200 units | **￥ 1,019,280** | **￥ 510,000** |
| Log Data | 800 million |  |  |
| APM Trace | 100 million |  |  |
| RUM PV | 4 million |  |  |
| Task Calls | 2.4 million |  |  |

##### Traffic Package

Traffic packages offer different discounts based on purchased capacity size; contact your account manager for details.

| **Traffic Package** | **Base Unit** | **Base Capacity Purchase** | **Default Data Retention Policy** | **Unit Price** | **Price (Day)** |
| --- | --- | --- | --- | --- | --- |
| DataKit | 1 | 20 units | / | 3 | 60 |
| Log Data (million units) | 1 million | 1 million units | 14 days | 1.5 | 1.5 |
| Backup Log (million units) | 10 million | 10 million units | / | 2 | 2 |
| APM Trace (ten thousand units) | 1 million | 1 million units | 7 days | 3 | 3 |
| User PV (ten thousand units) | 100 thousand | 100 thousand units | 7 days | 1 | 10 |
| API Calls (ten thousand units) | 10 thousand | 100 thousand units | / | 1 | 10 |
| Task Calls (ten thousand units) | 10 thousand | 300 thousand units | / | 1 | 30 |
| SMS | 1 | 100 units | / | 0.1 | 10 |

##### Notes

- Once package limits are exceeded, additional usage can be covered by purchasing traffic packages or paying based on **default data retention policy unit prices**.
- For tiered billing items in the package, data retention policies follow default settings: log data (14 days), APM Trace (7 days), RUM PV (7 days).
- If data retention policies differ from defaults (log data 30 or 60 days, APM Trace 14 days, RUM PV 14 days), the billing platform adjusts charges based on reported usage and retention policies as follows:
   - Log Data Conversion Factor: default 14 days, 30 days Usage * 2, 60 days Usage * 3
   - APM Trace Conversion Factor: default 7 days, 14 days Usage * 2
   - RUM PV Conversion Factor: default 7 days, 14 days Usage * 2

Time Series calculation formula:

- Billable Time Series Quantity = Time Series Quantity - DataKit Quantity * 500
- Billable Time Series Quantity Invoice = (Time Series Quantity - DataKit Quantity * 500) / 500 * 3
- If the calculated billable Time Series Quantity <= 0, it is counted as 0.