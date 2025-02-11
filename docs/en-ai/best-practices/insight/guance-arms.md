# Guance vs Alibaba Cloud ARMS 3.0

---

## Product Comparison
Background introduction:

40 Alibaba Cloud servers, log volume of 70-80 GB/day (including trace data), approximately 60 million lines/day, PV 30,000/day

### Deployment Architecture Comparison

![image.png](../images/guance-arms-1.png)

### Product Cost Comparison

(Representative of this test only)

![image.png](../images/guance-arms-2.png)

### Resource Consumption Comparison

(Representative of this test only)

![image.png](../images/guance-arms-3.png)

## ARMS 3.0

Application Real-Time Monitoring Service (ARMS) is an Application Performance Management (APM) product that includes three sub-products: application monitoring, Prometheus monitoring, and frontend monitoring. It covers performance management for distributed applications, container environments, browsers, mini-programs, and apps, enabling comprehensive stack performance monitoring and end-to-end full trace diagnosis to make application operations easy and efficient.
![](../images/guance-arms-4.png)

### Prometheus

Alibaba Cloud Prometheus monitoring fully integrates with the open-source Prometheus ecosystem, supporting a wide range of component monitoring, providing various ready-to-use pre-configured monitoring dashboards, and offering a fully managed Prometheus service.

#### Integration Methods

1. ACK (Alibaba Cloud Container Service) Kubernetes cluster 

2. Self-built Kubernetes cluster

3. RemoteWrite (remote storage)

#### Implementation Configuration

Prometheus data integration is based on Kubernetes clusters, directly creating [[Kubernetes Managed Cluster](https://help.aliyun.com/document_detail/85903.htm?spm=a2c4g.11186623.2.6.472e7cb6yXVXyj#task-mmv-33q-n2b)]. After creation, you can see built-in view dashboards related to Kubernetes on the page.

![image.png](../images/guance-arms-5.png)

#### Product Pricing

Prometheus monitoring charges based on the number of metrics reported. Metrics are divided into two types: basic metrics and custom metrics. Among them, [[basic metrics](https://help.aliyun.com/document_detail/148104.html#concept-2372936)] are free, while custom metrics are charged.

| Daily Reported Metrics Range (millions) | Unit Price (RMB/million) | Daily Charge Range (RMB) |
| --- | --- | --- |
| 0~50 | 0.8 | 0~40 |
| 50~150 | 0.65 | 40~105 |
| 150~300 | 0.55 | 105~187.5 |
| 300~600 | 0.45 | 187.5~322.5 |
| 600~1200 | 0.35 | 322.5~530.5 |
| Over 1200 | 0.25 | Over 530.5 |

##### Notes

1. Each reported metric cannot exceed 2 KB.

2. Each metric is stored for up to 15 days; data older than 15 days will be cleared. You can contact support to adjust this.

### Cloud Monitor

CloudMonitor is a service for monitoring Alibaba Cloud resources and internet applications.

#### Integration Methods

Prometheus integrates with Alibaba Cloud CloudMonitor to monitor cloud services in the specified region under the current cloud account within Prometheus.

Currently supports integrating ECS, RDS MongoDB, Redis, OSS, RDS, NAT, SLB, RocketMQ, Kafka, EIP, ES, and DRDS.

#### Implementation Configuration

Add cloud service integration through the Prometheus configuration interface.

![image.png](../images/guance-arms-6.png)

#### Product Pricing

After integrating Prometheus with CloudMonitor, there are no additional charges for CloudMonitor. The collected monitoring data will be charged **according to Prometheus rules**.

### Frontend Monitoring

ARMS frontend monitoring focuses on Web scenarios, Weex scenarios, and mini-program scenarios, monitoring web and mini-program page health from three aspects: page load speed (speed measurement), page stability (JS Error), and external service call success rate (API).

#### Integration Methods

Web scenario

- CDN installation of probe

- NPM installation of probe

Weex scenario

- Weex integration

Mini-program scenario

- DingTalk mini-program

- Alipay mini-program

- WeChat mini-program

- Other categories

#### Implementation Configuration

Create an application site, choose Web type integration, copy the BI probe (code) and place it at the first line of the HTML `<body>` content.

![image.png](../images/guance-arms-7.png)

#### Product Pricing

##### Basic Edition

Pay-as-you-go

| Billing Quantity | Billing Unit Price |
| --- | --- |
| All sites frontend data reporting times | 0.028 RMB / 1000 page reporting times |

##### Professional Edition

Pay-as-you-go

| Billing Quantity | Billing Unit Price |
| --- | --- |
| All sites frontend data reporting times | 0.28 RMB / 1000 page reporting times |

Resource Packs

| Name | Specification | Price | Discounted Billing Price | Validity Period |
| --- | --- | --- | --- | --- |
| Basic Resource Pack | 2 million page reporting times | 420 RMB | 0.21 RMB / 1000 frontend data reporting times | 6 months |
| Intermediate Resource Pack | 16 million page reporting times | 2,520 RMB | 0.158 RMB / 1000 frontend data reporting times | 1 year |
| Advanced Resource Pack | 128 million page reporting times | 15,120 RMB | 0.118 RMB / 1000 frontend data reporting times | 1 year |
| Gold Resource Pack | 600 million page reporting times | 60,000 RMB | 0.1 RMB / 1000 frontend data reporting times | 1 year |

##### Notes

1. Frontend monitoring: billing mainly involves page PV calls and API call reporting times, custom reporting times. Billing is settled daily, and any usage less than 1000 reporting times is billed as 1000. Frontend monitoring data is cached by default for 30 days.

2. Frontend monitoring calculation formula reference: Daily reporting traffic = daily PV + (daily API call times - daily 500,000) * 0.1 + custom reporting.

3. One PV generates data reporting times = 1 + API call times + custom data reporting times. In most cases, page data reporting times are roughly equal to page visit times.

### Application Monitoring

ARMS application monitoring is an Application Performance Management (APM) product. Without modifying code, you just need to install a probe for your application, and ARMS can provide comprehensive monitoring to help you quickly locate faulty interfaces and slow interfaces, reproduce call parameters, discover system bottlenecks, thus significantly improving online issue diagnosis efficiency.

#### Data Integration

Integration based on deployment environment

- EDAS

- ACK (Alibaba Cloud Container Service)

- Open-source K8s cluster

- Docker cluster

- Other environments (such as self-built IDC)

Integration based on development language

- JAVA

- PHP

#### Implementation Configuration

Integrate application, choose Java language, automatic script installation method

![image.png](../images/guance-arms-8.png)

#### Product Pricing 

##### Basic Edition

| Name | Billing Content | Notes |
| --- | --- | --- |
| Application Monitoring Basic Edition - Statistical Metrics Storage Fee | Statistical metrics stored for 3 days, free.<br />Statistical metrics stored for 30 days, 1.2 RMB per probe per day.<br />Statistical metrics stored for 90 days, 2.4 RMB per probe per day.<br />Statistical metrics stored for 180 days, 3.6 RMB per probe per day. | (1) Default storage period for statistical metrics is 3 days, free to use. To extend the storage period, adjust in the Global Configuration - Storage Period Configuration page under Application Monitoring.<br /> (2) One probe can monitor one application instance (e.g., one Tomcat instance, one Java process).<br /> (3) Supports upgrading to Expert Edition, which charges according to the Expert Edition after activation. |
| Application Monitoring Basic Edition - Call Chain Storage Fee | 0.2 RMB / million request chains * day<br />Default sampling strategy stores for 1 day, free. | (1) Free sampling and storage for the first request chain of each interface every minute for 1 day. To store more request chains, adjust in the Custom Configuration - Sampling Rate page under Application Settings, pay-as-you-go.<br /> (2) All calls under the same TraceId are considered one request chain, with a maximum of ten spans per chain. Excess parts are charged at one-tenth of the request chain fee.<br /> (3) Supports upgrading to Expert Edition, which charges according to the Expert Edition after activation. |

##### Professional Edition

Pay-as-you-go:

| Billing Item | Billing Unit Price |
| --- | --- |
| Pay-as-you-go | 6.72 RMB per probe per day |

Resource pack billing:

| Name | Specification | Price | Discounted Billing Price | Validity Period |
| --- | --- | --- | --- | --- |
| Basic Resource Pack | 150 probes*days (resources available for 150 probes for 1 day, or 5 probes for 30 days) | 700 RMB | 4.68 RMB / probe*day | 6 months |
| Intermediate Resource Pack | 1200 probes*days (resources available for 1200 probes for 1 day, or 40 probes for 30 days) | 4,200 RMB | 4.38 RMB / probe*day | 1 year |
| Advanced Resource Pack | 9600 probes*days (resources available for 9600 probes for 1 day, or 320 probes for 30 days) | 25,200 RMB | 2.616 RMB / probe*day | 1 year |
| Gold Resource Pack | 36500 probes*days (resources available for 100 probes for 365 days) | 66,838 RMB | 1.8312 RMB / probe*day | 1 year |
| Platinum Resource Pack | 109500 probes*days (resources available for 300 probes for 365 days) | 174,000 RMB | 1.5696 RMB / probe*day | 1 year |
| Top Resource Pack | 182500 probes*days (resources available for 500 probes for 365 days) | 238,710 RMB | 1.308 RMB / probe*day | 1 year |

##### Notes

1. One probe can monitor one application instance (e.g., one Tomcat instance, one Java process).

2. Application monitoring: traffic is calculated based on the actual total online time of all applications, settled daily. Application monitoring data is cached by default for 60 days.

### Synthetic Tests

Synthetic Tests is a service for monitoring the performance and user experience of internet applications (web pages, network links, etc.).

#### Integration Methods

Synthetic Tests can utilize a globally distributed monitoring network to perform browsing or network tests on target web applications (such as websites, servers), currently supporting up to 50 monitoring points per task.

#### Implementation Configuration

Create a synthetic testing task, add URLs and monitoring points (up to 50) to be monitored

![image.png](../images/guance-arms-9.png)
#### Product Pricing

Synthetic Tests entered public beta on November 20, 2020. You can activate ARMS' 15-day free trial version or any paid version to use Synthetic Tests. During the public beta period, even after the 15-day trial expires, you can still **use Synthetic Tests for free**.

### Log Monitoring

For highly customized business scenarios, you can create log monitoring tasks to freely aggregate required metrics, generate necessary data and reports, and configure alarms flexibly.

#### Integration Methods

ARMS log monitoring supports completely customizable monitoring tasks, involving configuring data sources and metrics, as shown below.

![](../images/guance-arms-10.png)
#### Configuration Implementation

Prerequisites: [[Activate Alibaba Cloud Log Service](https://www.aliyun.com/product/sls?spm=a2c4g.11186623.2.9.2f287973Qu3iYk)], synchronize LogHub, and generate required metrics

![image.png](../images/guance-arms-11.png)

#### Product Pricing

Log metrics generated **are charged according to Prometheus rules**

## Guance

Guance is a cloud service platform aimed at solving observability for complete applications in the era of cloud computing and cloud-native systems.

### Integration Methods

- Frontend page configuration

- Datakit data collection

### Implementation Configuration

#### Host Infrastructure

Install Datakit, default enabled [CPU, System, Mem, Disk, DiskIO, Swap, Net information collection], view **infrastructure** information

![image.png](../images/guance-arms-12.png)

#### Application Middleware

Configure Datakit [[MySQL data collection](/../../integrations/mysql.md)] and [[Nginx data collection](/datakit/nginx/)], click `Integration Status` of host

Nginx redirects to built-in views

![image.png](../images/guance-arms-13.png)

![](../images/guance-arms-14.png)

#### Logs
Configure logs in [[MySQL data collection](/../../integrations/mysql.md)] and [[Nginx data collection](/datakit/nginx/)], or enable custom log configuration [Tailf data collection], after creation you can see the log list

![image.png](../images/guance-arms-15.png)

Click log source to view detailed log information (processed with Grok parsing)

![image.png](../images/guance-arms-16.png)

#### APM

Download dd-java-agent.jar, add it as a javaagent parameter to the Java application startup command (-javaagent:/root/mall/dd-java-agent-0.75.0.jar), configure Datakit's [dd-trace data collection], after successful creation you can see the application list

![image.png](../images/guance-arms-17.png)

Click service name to see the summary

![image.png](../images/guance-arms-18.png)

Click trace to see trace information

![image.png](../images/guance-arms-19.png)

Click service name to see flame graphs and detailed information

![image.png](../images/guance-arms-20.png)

#### RUM

Create an application, choose Web type integration, copy the probe (code) and place it at the first line of the HTML `<body>` content

![image.png](../images/guance-arms-21.png)

#### Synthetic Tests

Create new synthetic testing URL and testing points and frequency
![image.png](../images/guance-arms-22.png)

#### Incident Detection Library

Built-in host detection library (no configuration needed), other detection libraries added as needed

![image.png](../images/guance-arms-23.png)

### Product Pricing

#### Pay-as-you-go Basic Pricing Model

Guance offers two pricing models, which can be switched in the billing center. One model calculates "DataKit + Time Series" quantities, while the other only calculates "Time Series" quantities. Other billing items such as backup log data quantity, API synthetic testing times, task scheduling times, and SMS sending times are common billing items.

###### 1. Calculating "DataKit + Time Series" Quantities

| **Billing Item** | **Billing Unit** | **Commercial Plan Price** |
| --- | --- | --- |
| Datakit Quantity | Per 1 unit | 3 RMB |
| Time Series Quantity | Per 500 | 3 RMB |
| Backup Log Data Quantity | Per 10 million | 2 RMB |
| API Synthetic Testing Times | Per 10,000 | 1 RMB<br />Note: Statistics do not include API synthetic testing data generated by user-defined nodes |
| Task Scheduling Times | Per 10,000 | 1 RMB |

Time Series Calculation Formula:

- Billing Time Series Quantity = Time Series Quantity - DataKit Quantity * 500

- Billing Time Series Amount = (Time Series Quantity - DataKit Quantity * 500) / 500 * 3

- If the calculated billing Time Series Quantity <= 0, it is billed as 0.

###### 2. Calculating "Time Series" Quantities

| **Billing Item** | **Billing Unit** | **Commercial Plan Price** |
| --- | --- | --- |
| Time Series Quantity | Per 300 | 3 RMB |
| Backup Log Data Quantity | Per 10 million | 2 RMB |
| API Synthetic Testing Times | Per 10,000 | 1 RMB<br />Note: Statistics do not include API synthetic testing data generated by user-defined nodes |
| Task Scheduling Times | Per 10,000 | 1 RMB |
| SMS Sending Times | Per 10 | 1 RMB |

Time Series Calculation Formula:

- Billing Time Series Quantity = Time Series Quantity

- Billing Time Series Amount = Time Series Quantity / 300 * 3

##### Tiered Pricing Model

###### Log Data

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |  |
| --- | --- | --- | --- | --- |
| Data Storage Strategy |  | 14 Days | 30 Days | 60 Days |
| Log Data Quantity | Per million | 1.5 RMB | 2 RMB | 2.5 RMB |

###### APM Trace

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |
| --- | --- | --- | --- |
| Data Storage Strategy |  | 7 Days | 14 Days |
| APM Trace Quantity | Per million | 3 RMB | 6 RMB |

###### User Visit PV

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |
| --- | --- | --- | --- |
| Data Storage Strategy |  | 7 Days | 14 Days |
| User Visit PV Quantity | Per ten thousand | 1 RMB | 2 RMB |

#### Annual Package

##### Startup Acceleration Package

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 Days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 20 units | **￥ 72,168** | **￥ 42,000** |
| Log Data | 40 million |  |  |
| APM Trace | 5 million |  |  |
| User Visit PV | 400,000 |  |  |
| Task Calls | 190,000 |  |  |

##### Entrepreneur Development Package

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 Days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 100 units | **￥ 517,080** | **￥ 280,000** |
| Log Data | 400 million |  |  |
| APM Trace | 50 million |  |  |
| User Visit PV | 2 million |  |  |
| Task Calls | 1.4 million |  |  |

##### Enterprise Standard Package

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 Days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 200 units | **￥ 1,019,280** | **￥ 510,000** |
| Log Data | 800 million |  |  |
| APM Trace | 100 million |  |  |
| User Visit PV | 4 million |  |  |
| Task Calls | 2.4 million |  |  |

##### Traffic Package

Traffic packages offer different discounts based on the purchased capacity size. Specific details can be obtained by contacting the account manager.

| **Traffic Package** | **Base Unit** | **Base Capacity Purchased** | **Default Data Storage Strategy** | **Unit Price** | **Price (Day)** |
| --- | --- | --- | --- | --- | --- |
| DataKit | 1 | 20 units | / | 3 | 60 |
| Log Data (ten thousand) | 1 million | 1 million | 14 Days | 1.5 | 1.5 |
| Backup Logs (ten thousand) | 10 million | 10 million | / | 2 | 2 |
| APM Trace (ten thousand) | 1 million | 1 million | 7 Days | 3 | 3 |
| User PV (ten thousand) | 100 thousand | 100 thousand | 7 Days | 1 | 10 |
| API Calls (ten thousand) | 10 thousand | 100 thousand | / | 1 | 10 |
| Task Calls (ten thousand) | 10 thousand | 300 thousand | / | 1 | 30 |
| SMS | 1 | 100 | / | 0.1 | 10 |

##### Notes

- Once the package limit is exceeded, the excess can be purchased as a traffic package or charged based on the "pay-as-you-go" method using the **default data retention policy price**.
- For tiered billing items in the package, the data retention strategy follows the default strategy: log data (14 days), APM Trace (7 days), User Visit PV (7 days).
- If the data retention strategy is not the default strategy (log data 30 days or 60 days, APM Trace 14 days, User Visit PV 14 days), the billing platform needs to convert the reported usage and data retention strategy accordingly. Conversion factors are as follows:
   - Log data conversion factor: default 14 days, 30 days Usage * 2, 60 days Usage * 3
   - APM Trace conversion factor: default 7 days, 14 days Usage * 2
   - User Visit PV conversion factor: default 7 days, 14 days Usage * 2

Time Series Calculation Formula:

- Billing Time Series Quantity = Time Series Quantity - DataKit Quantity * 500
- Billing Time Series Amount = (Time Series Quantity - DataKit Quantity * 500) / 500 * 3
- If the calculated billing Time Series Quantity <= 0, it is billed as 0.