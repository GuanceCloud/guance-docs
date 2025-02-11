# How to Choose a Deployment Plan
---

## Overview
Guance is a cloud service platform that provides **full-stack observability** for customer application systems. Depending on the actual usage scenarios and characteristics of the customer's application system, multiple deployment plans are available. The selectable Guance deployment plans include: **SaaS Commercial Plan**, **SaaS Exclusive Plan**, and **On-premises Deployment Plan**.

## Plan Descriptions 
All three deployment plans adopt a pay-as-you-go billing model. This means that while the features themselves are free, charges are based on data usage, which can accommodate customers with different application scales (small, medium, or large). Customers pay different fees based on their data volume.

### SaaS Commercial Plan
This is our SaaS public version deployed in the cloud. Customers can use it out-of-the-box and quickly gain access to a powerful observability platform by simply installing DataKit and configuring relevant data collectors.

Compared to the on-premises deployment plan, the SaaS version offers several advantages:
- **Higher Performance:**  
  Guance's observability data primarily consists of time series metrics data (InfluxDB) and log text data (Elasticsearch), requiring substantial resources to achieve comprehensive system observability. Using cloud resources provides robust hardware support.
  
- **Greater Elasticity:**  
  Compared to deployment versions, users do not need to worry about resource scaling, nor do they have to pay for additional resources. They can focus entirely on their observability data.
  
- **Enhanced Security:**  
  Each user's workspace data is isolated at the database level, ensuring that queries are naturally confined within their own database. There is no need to worry about data security issues. All data is stored on Alibaba Cloud in compliance with Level 3 protection requirements.
  
- **Higher Reliability:**  
  We follow an agile development approach with rapid iteration and upgrades. Fixes are made weekly, and new versions are released every two weeks. Our large SRE team ensures the platform runs securely and stably.
  
- **Timely Expert Support:**  
  The SRC team can respond promptly to customer needs through authorized access.

**Network Topology:**

![](img/11.deployment_1.png)

### SaaS Exclusive Plan
Similar to the SaaS Commercial Plan, this version is also deployed in the cloud but is exclusively used by each customer. It offers all the advantages of the SaaS Commercial Plan.
Additionally, for the exclusive version, we deploy a separate instance of Guance in each customer's independent Alibaba Cloud account, ensuring even higher security levels.
Billing is also pay-as-you-go, but due to exclusive use and dedicated support from the SRC team, the price is 20% to 30% higher than the SaaS Commercial Plan.

**Network Topology:**

![](img/11.deployment_2.png)

### On-premises Deployment Plan
Similar to the SaaS Exclusive Plan, this version is exclusively used by each customer but is deployed on the customer's local physical machines. Users must prepare their own server resources and incur a one-time resource fee, approximately RMB 150,000 (depending on the scale of the monitored objects).
Deploying on local physical resources loses all cloud advantages. Security and reliability must be ensured independently, and resources cannot be scaled elastically.
Moreover, if the monitored objects are mixed between cloud and on-premises environments, and Guance is deployed in a local data center without a fixed public IP, a dedicated line must be pulled from the cloud provider to the local data center to collect data from cloud-based monitored objects. This adds significant costs, primarily for the dedicated line.

**Network Topology:**

![](img/11.deployment_3.png)

In summary, the SaaS Commercial Plan is the most convenient, fastest to deploy, and lowest-cost option.