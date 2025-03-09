# How to Choose a Deployment Plan
---

## Overview
The "<<< custom_key.brand_name >>>" system observability platform provides a cloud service platform offering **full-stack observability** for customer application systems. Based on the actual usage scenarios and characteristics of customer application systems, multiple deployment options are available for selection. The selectable "<<< custom_key.brand_name >>>" deployment plans include: **SaaS Commercial Plan**, **SaaS Exclusive Plan**, and **On-premises Deployment Plan**.

## Plans 
All three deployment options adopt a pay-as-you-go billing model, meaning that the functionality itself is free, and charges are based on data usage. This model fits well with customers of different application scales, from small to large, paying fees according to the volume of data.

### SaaS Commercial Plan
This is our SaaS public version deployed in the cloud. Customers can use it out-of-the-box, quickly obtaining a powerful observability platform. They only need to install DataKit and configure relevant data collectors to complete the observability integration.

Compared to the on-premises deployment plan, the SaaS version has many advantages:
**Higher Performance:**
The observable data of "<<< custom_key.brand_name >>>" mainly consists of time series metrics data (InfluxDB) and log text data (Elasticsearch). To achieve system observability, a massive amount of data is required, which consumes significant system resources. Using cloud resources leverages the robust hardware capabilities provided by the cloud.

**More Elasticity:**
Compared to deployment versions, users do not need to worry about resource scaling, nor do they need to pay for additional resources. Users can focus on their own observability data.

**Greater Security:**
Each user's workspace data is isolated at the DB level, with queries naturally limited to their own database, ensuring no data security concerns. All data is stored on Alibaba Cloud storage in compliance with Level 3 security requirements.

**Higher Reliability:**
We adopt an agile development approach with rapid iteration and upgrades. Fixes are made weekly, and a new version is released every two weeks. A large SRE team ensures the platform's secure and stable operation.

**Timely Expert Support:**
The SRC team can respond promptly to customer needs through authorized access.

**Network Topology:**

![](img/11.deployment_1.png)

### SaaS Exclusive Plan
Similar to the SaaS Commercial Plan, this option is also deployed in the cloud but is exclusively used by each customer. It offers all the advantages of the **SaaS Commercial Plan**.
Additionally, for the exclusive version, we deploy a separate instance of "<<< custom_key.brand_name >>>" within each customer’s independent Alibaba Cloud account, providing higher security levels.
Billing is also on a pay-as-you-go basis, but due to the exclusive nature and dedicated support from the SRC team, the price is 20% to 30% higher compared to the SaaS Commercial Plan.

**Network Topology:**

![](img/11.deployment_2.png)

### On-premises Deployment Plan
Similar to the SaaS Exclusive Plan, this option is for exclusive use by the customer but is deployed on the customer's local physical resources. Users must prepare their own service resources and incur a one-time resource cost, approximately $150,000 for server resources (depending on the scale of the monitored objects).
Deploying on local physical resources means losing all cloud advantages, requiring self-management of security and reliability without elastic resources.
Furthermore, if the monitored objects are a mix of cloud and on-premises, and "<<< custom_key.brand_name >>>" is deployed in a local data center without a fixed public IP, a dedicated line must be pulled from the cloud operator to the local data center to collect data from cloud-based monitored objects into the local "<<< custom_key.brand_name >>>" system, adding significant costs.

**Network Topology:**

![](img/11.deployment_3.png)

In summary, the SaaS Commercial Plan is the most convenient, fastest to integrate, and lowest-cost solution.