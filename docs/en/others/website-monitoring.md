# How to Enable Synthetic Tests
---

## Introduction

Are you still troubled by the inability to proactively perceive user experience? Have you lost users due to poor website availability? As user access environments and scenarios become more diverse, it is crucial to obtain real user experiences of applications and promptly alert and address issues when user experience declines.

To help you proactively identify user experience issues and anticipate network site errors, “<<< custom_key.brand_name >>>” provides an out-of-the-box Synthetic Tests solution. Using a global monitoring network, you can quickly implement website availability testing through API tests. By combining dimensions such as region, carrier, and time, you can periodically monitor URL site quality, uncover potential site issues before users encounter them, and promptly identify the causes of problems.

API Testing involves periodic availability monitoring of websites, domains, backend interfaces, etc., based on the `HTTP` protocol. Through real-time monitoring of sites, it statistically evaluates their availability, providing test logs and real-time alerts to help you quickly identify network issues and improve network access quality.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com/).

## Methods/Steps

### Step 1: Create a Test Task

In the <<< custom_key.brand_name >>> workspace under "Synthetic Tests," click “Create” to set up a new API test task. This task will periodically monitor websites, domains, and backend interfaces based on the `HTTP` protocol, detecting performance and user experience from various regions and carriers.

**Note:**

- Only workspace administrators can create test tasks; other workspace members can only view information such as names, domains, types, and task statuses.
- Free Plan workspaces can create up to 5 test tasks and only use "China" test nodes. If you need to create more test tasks or use additional international test nodes, please upgrade via the "Billing" page within your workspace.

### Step 2: Customize the Test Task

After entering the new “API Test” task, you can freely configure your periodic probing requirements, including:

- Select Test Type: Currently supports `HTTP` protocol requests;
- Define Request Format: Enter the URL, including four request methods `GET`, `POST`, `PUT`, and `HEAD`;

![](img/w1.png)

- Advanced Settings: Configure advanced settings based on actual needs, including request settings, request body content, certificates, proxies, and privacy.

![](img/w2.png)

- Name: A user-defined name for the cloud test that must be unique within the current workspace.
- Availability Criteria: Supports adding conditions to match data. When multiple conditions are selected, they are combined with an AND relationship.

![](img/w3.png)

- Select Test Nodes: <<< custom_key.brand_name >>> currently covers 16 nodes globally. Users (Commercial Plan and above) can select one or more nodes from China or overseas regions to quickly start site quality monitoring.
- Select Test Frequency: Choose the frequency of data returns for the cloud test. Options include 1 minute (Commercial Plan and above), 5 minutes (Commercial Plan and above), 15 minutes (Commercial Plan and above), 30 minutes, 1 hour, 6 hours, 12 hours, and 1 day.

### Step 3: View Site Availability Status

Based on the selected testing frequency, after the first test cycle completes, you can view the site's availability data through “Summary” and “Explorer.” For example, if you choose a monitoring frequency of "1h," wait 1-2 hours after configuration to view related data.

First, through “Summary,” you can analyze the site’s availability rate and response time across multiple dimensions like region, city, and carrier using rich visual data analysis tools such as maps, line charts, and time series graphs. Switching the “Time Widget” at the top allows you to quickly analyze trends and distributions.

![](img/w4.png)

Second, through “Explorer,” you can view all APM data within the current workspace.

![](img/w5.png)

## Advanced Reference

### User-defined Node

<<< custom_key.brand_name >>> supports creating private deployment nodes distributed globally via “User-defined Node Management.” Refer to [User-defined Node Management](../usability-monitoring/self-node.md) for detailed operations, and consult [Network Dial Testing](../integrations/network/dialtesting.md) for specific deployment documentation.

The <<< custom_key.brand_name >>> platform supports establishing new test nodes globally. Through “User-defined Node Management,” you can create probe nodes based on geographic location and carrier to monitor the availability of internal/external service sites. If you need to perform cloud tests on internal corporate networks, deploy DataKit on servers that can access the internal network and configure your private deployment node. For public websites, no special setup is required.

For example, adding the following node:

- Geographic Location: Albania/Elbasan
- Carrier: unicom
- Node Code: Albania-Elbasan-unicom
- Node Name: Albania-Elbasan-Unicom

1. Through “Synthetic Tests” - “User-defined Node Management,” click “Create Node,” enter the following details, and confirm to quickly establish a global service quality monitoring point, expanding your service quality detection coverage.

![](img/w6.png)

2. After completing “Create Node,” obtain the “Configuration Information” for the node in the list under “User-defined Node Management.”

![](img/w7.png)

3. Based on the obtained configuration information, install the test node on a server with node capabilities.

First, ensure your server has the latest version of DataKit installed. **If you haven’t installed DataKit, go to the dashboard’s “Integrations” - “DataKit” to install it. If you have DataKit installed, ensure it is the latest version.**

- After installing DataKit, navigate to the installation directory’s conf.d/network, copy dialtesting.conf.sample and rename it to dialtesting.conf.

![](img/w8.png)

- Fill in the configuration content into conf.d/network/dialtesting.conf.

```
region_id = "reg_c8care8dh477jlcibvrg"
ak = "bJljwJgfYFIGBxsxGv55"
sk = "yWDP7urMuciYMW6aQxndetzZ6yL2xAkT2NfmfLwz"
```

- Save the file and restart DataKit. Wait 1-2 minutes, and the node will be ready for use.

![](img/w9.png)