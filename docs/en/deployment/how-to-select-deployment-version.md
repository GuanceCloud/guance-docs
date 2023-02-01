# How to Select a Deployment Version 
---

## Overview
The observable platform in Guance system provides a **full-link observable cloud service platform** for customer application systems, and provides a variety of deployment schemes to choose from according to the actual use scenarios and characteristics of customer application systems. Deployment scenarios for Guance can choose from **SaaS Commercial Version**, **SaaS Exclusive Version** and **Local Deployment Version**. 
## Version Description 
Three different deployment schemes all adopt the charging mode of charging according to volume, that is, the function itself is free, and they are all based on data charging, which can well adapt to customers with different application scales and pay different fees according to the size of data volume. 

### SaaS Business Version
It is a public version of SaaS deployed on the cloud. Customers can use it out of the box and quickly have a powerful system observable platform. They only need to install DataKit and configure relevant data collectors to complete observable access. 

Compared with the locally deployed version, SaaS version has many advantages:
**Higher performance:**
The observable data of Guance are mainly time series metric data (InfluxDB) and log text data (Elasticsearch), which requires a huge amount of data to complete the observable purpose of the system and consumes a lot of system resources. Using resources on the cloud, the cloud provides powerful hardware capability support

**More flexible:**
Compared with the deployed version, users don't need to care about the expansion of resources, and users don't need to pay for the expanded resources. You can focus on your own observable data. 

**Safer:**
Each user's workspace data is isolated at an independent DB level, and data query is naturally limited in its own DB, so there is no need to worry about data security.
All data are stored on Alibaba Cloud Storage according to the requirements of Equal Guarantee III. 

**More reliable:**
We are in a small step and fast walk mode, with fast iterative upgrade speed, problem fix every week, and a new version goes online every two weeks.
Our SRE team ensures the safe and stable operation of the platform.

**More timely expert support:**
SRC team can respond to customer needs in a timely manner through customer authorization. 

**Network Mapping:**

![](img/11.deployment_1.png)

### SaaS Exclusive Version
Similar to SaaS Business Edition, it is also deployed on the cloud, but it is used exclusively by customers and has all the advantages of ** SaaS **business version** **.
In addition, in the exclusive version, we deploy a set of Guance Cloud for each customer in its own independent Alibaba Cloud account, which is used exclusively by each customer and has higher security level.
Billing is also based on quantity, but because it is used exclusively by customers and supported by SRC team alone, the price is 20% ~ 30% more expensive than SaaS commercial version. 

**network mapping:**

![](img/11.deployment_2.png)

### Local Deployment Version
Similar to SaaS exclusive version, it is used exclusively by customers, but deployed on customers' local physical machine resources, which requires users to prepare their own service resources, and requires a one-time resource cost, which is about 150,000 server resource cost (depending on the scale of monitored objects).
Deployment on local physical resources loses all advantages in the cloud, and all security and reliability must be guaranteed by themselves, so resources cannot be flexible.
In addition, if the user is mixed with the monitored objects on the cloud and under the cloud, Guance is deployed in the local computer room without fixed public network IP, and the cloud operator's special line is needed to pull to the local computer room in order to collect the monitored object data on the cloud into the local Guance system, in which the optical special line is a large cost. 

**network mapping:**

![](img/11.deployment_3.png)

To sum up, SaaS Business Version is the most convenient, fastest and lowest cost access solution. 
