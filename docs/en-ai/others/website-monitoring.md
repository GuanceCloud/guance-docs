# How to Enable Synthetic Tests
---

## Introduction

Are you still troubled by the inability to proactively perceive user experience? Have you lost users due to poor website availability? As user access environments become more diverse, it is crucial to obtain real user experiences and receive timely alerts when user experience degrades for prompt handling.

To help you proactively identify user experience issues and preemptively detect website errors, Guance provides an out-of-the-box Synthetic Tests solution. Utilizing a global monitoring network, you can quickly implement website availability testing through API dial testing. You can monitor URL site quality periodically based on various dimensions such as region, ISP, and time, identifying potential site issues before users do and promptly pinpointing the causes of these issues.

API dial testing involves periodic availability monitoring of websites, domains, backend interfaces, etc., based on the `HTTP` protocol. By continuously monitoring sites, it statistically tracks their availability, providing dial test logs and real-time alerts to help you quickly identify network issues and improve network access quality.

## Prerequisites

You need to first create a [Guance account](https://www.guance.com/).

## Method/Steps

### Step 1: Create a Dial Testing Task

In the Guance workspace under "Synthetic Tests," click "New" to create an API dial testing task. This task will periodically monitor websites, domains, and backend interfaces based on the `HTTP` protocol, probing performance and user experience from different ISPs in various regions.

**Note:**

- Only workspace administrators can create new dial testing tasks; other members can only view information such as name, domain, type, and task status.
- The Free Plan allows up to 5 dial testing tasks and supports only "China Region" dial testing nodes. To create more tasks or use additional international dial testing nodes, please upgrade via the "Paid Plans & Billing" page within your workspace.

### Step 2: Customize the Dial Testing Task

After creating a new "API Dial Testing" task, you can configure your periodic probing requirements, including:

- Select Dial Test Type: Currently supports `HTTP` protocol requests;
- Define Request Format: Enter the URL, including four request methods: `GET`, `POST`, `PUT`, and `HEAD`;

![](img/w1.png)

- Advanced Settings: Customize advanced settings based on actual needs, including request settings, request body content, certificates, proxies, and privacy.

![](img/w2.png)

- Name: A user-defined name for the dial testing task that must be unique within the current workspace.
- Availability Judgment: Supports adding conditions to match data. When multiple conditions are selected, they are evaluated using AND logic.

![](img/w3.png)

- Select Dial Testing Nodes: Guance currently covers 16 nodes globally. Users can choose one or more nodes from China or overseas regions (only available to Commercial Plan and above users) to quickly initiate service quality monitoring.
- Select Dial Testing Frequency: Choose the frequency of dial testing data returns, supporting options like 1 minute (Commercial Plan and above only), 5 minutes (Commercial Plan and above only), 15 minutes (Commercial Plan and above only), 30 minutes, 1 hour, 6 hours, 12 hours, and 1 day.

### Step 3: View Site Availability Status

Based on the selected testing frequency, after the first test cycle completes, you can view the site's availability data via "Summary" and "Explorer". **For example, if you select a monitoring frequency of "1h", wait 1-2 hours after configuration to view relevant data.**

First, through "Summary," you can analyze the site's availability rate and response time across multiple dimensions such as region, city, and ISP. Using rich visual analytics, including maps, line charts, and time series graphs, you can quickly analyze trends and distributions by switching the "Time Component" at the top.

![](img/w4.png)

Second, through "Explorer," you can view all application performance data within the current workspace.

![](img/w5.png)

## Advanced References

### User-defined Node

Guance supports rapidly establishing private deployment nodes distributed globally via "User-defined Node Management." For detailed operations, refer to [User-defined Node Management](../usability-monitoring/self-node.md). Specific deployment documentation can be found in [Network Dial Testing](../integrations/network/dialtesting.md).

The Guance platform supports creating new dial testing nodes globally. Through "User-defined Node Management," you can establish probe nodes based on geographic location and ISP to monitor internal/external service sites. If you need to perform cloud dial testing for internal networks, deploy DataKit on a server with access to the internal network and configure your private deployment node. For public websites, no special setup is required.

For example, adding the following node:

- Location: Albania/Elbasan
- ISP: unicom
- Node Code: Albania-Elbasan-unicom
- Node Name: Albania-Elbasan-Unicom

1. Through "Synthetic Tests" - "User-defined Node Management," click "New Node" to create a new node. Input the following details and confirm to quickly establish a global service quality monitoring point, expanding your service quality detection range.

![](img/w6.png)

2. After completing "New Node," obtain the "Configuration Information" for the node in the "User-defined Node Management" list.

![](img/w7.png)

3. Based on the obtained configuration information, install the dial testing node on a server with node capabilities.

First, ensure your server has the latest version of DataKit installed. **If you haven't installed DataKit, go to the dashboard's "Integrations" - "DataKit" for installation. If DataKit is already installed, ensure it is the latest version.**

- After installing DataKit, open the conf.d/network directory under the installation path, copy dialtesting.conf.sample, and rename it to dialtesting.conf.

![](img/w8.png)

- Fill in the configuration content into conf.d/network/dialtesting.conf.

```
region_id = "reg_c8care8dh477jlcibvrg"
ak = "bJljwJgfYFIGBxsxGv55"
sk = "yWDP7urMuciYMW6aQxndetzZ6yL2xAkT2NfmfLwz"
```

- Save the file content, restart DataKit, and wait 1-2 minutes to activate the node.

![](img/w9.png)