# How to Enable Synthetic Tests
---

## Introduction

Are you still troubled by the inability to perceive user access experiences in advance? Are you losing users due to poor website availability? As user access environments and scenarios become more diverse, it is crucial to obtain real user experiences of your applications and promptly warn when user experience declines for timely handling.

To help you proactively identify user experience issues and preemptively sense network site errors, "<<< custom_key.brand_name >>>" provides an out-of-the-box Synthetic Tests solution. By leveraging a global monitoring network, you can quickly implement website availability testing through API Tests. You can combine dimensions such as region, carrier, and time to periodically monitor URL site quality, uncover potential site issues before users do, and promptly pinpoint the causes of problems.

API Tests are periodic availability tests conducted on websites, domains, and backend interfaces based on the `HTTP` protocol. By continuously monitoring sites, their availability is statistically tracked, providing probing logs and real-time alerts to help you quickly discover network issues and improve network access quality.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).

## Methods/Steps

### Step 1: Create a Probing Task

In the <<< custom_key.brand_name >>> workspace under "Synthetic Tests," click "Create" to set up an API Test task. This will periodically monitor websites, domains, and backend interfaces based on the `HTTP` protocol, detecting the performance status and user experience from different carriers across various regions.

**Note:**

- Only workspace administrators can "Create" probing tasks; other workspace members can only view information such as names, domains, types, and task statuses.
- Free Plan workspaces can create up to 5 probing tasks and only support the use of "China Region" probing nodes. If you need to create more probing tasks or use additional international probing nodes, please upgrade via the "Billing" page within your workspace.

### Step 2: Customize Probing Tasks

After entering the "Create API Test" task, you can freely configure your periodic probing needs, including:

- Selecting the probing type: Currently supports `HTTP` protocol requests;
- Defining request formats: Input URLs with four request methods: `GET`, `POST`, `PUT`, and `HEAD`;

![](img/w1.png)

- Advanced settings: Adjust advanced settings according to actual needs, including request settings, request body content, certificates, proxies, and privacy.

![](img/w2.png)

- Name: A user-defined name for cloud probing that does not support duplication within the current workspace.
- Availability judgment: Supports adding matching data conditions. When multiple conditions are selected, these conditions are logically combined using "AND."

![](img/w3.png)

- Select probing nodes: Currently <<< custom_key.brand_name >>> covers 16 nodes globally, supporting the selection of one or more nodes in China and overseas regions (only available for Commercial Plan and above users) to quickly initiate service quality monitoring for sites.
- Select probing frequency: Choose the return frequency of cloud probing data. Options include 1 minute (Commercial Plan and above), 5 minutes (Commercial Plan and above), 15 minutes (Commercial Plan and above), 30 minutes, 1 hour, 6 hours, 12 hours, and 1 day.

### Step 3: View Site Availability Status

Based on the selected detection frequency, after completing the first detection cycle (the duration of one detection cycle), you can view the corresponding site availability data for different probing tasks through "Overview" and "Explorer." **For example: If you select a monitoring frequency of "1h", wait 1-2 hours after configuration to view related data.**

First, through "Overview," you can analyze the site's availability rate and response time from multiple dimensions such as region, city, and carrier, combining rich visual data analysis systems like maps, line charts, and time-series graphs. Switching the "Time Widget" at the top allows you to quickly analyze trends and distributions.

![](img/w4.png)

Secondly, through "Explorer," you can view all application performance data within the current workspace.

![](img/w5.png)

## Advanced References

### Self-built Nodes

<<< custom_key.brand_name >>> supports quickly establishing private deployment nodes distributed globally through "Self-built Nodes Management." For detailed operation instructions, refer to [Self-built Nodes Management](../usability-monitoring/self-node.md). Specific deployment documentation can be found in [Network Testing](../integrations/network/dialtesting.md).

The <<< custom_key.brand_name >>> platform supports creating new probing nodes worldwide. Through "Self-built Nodes Management," you can establish probing nodes based on geographic location and carrier to monitor the availability of internal/external service sites. If you need to conduct cloud probing on your enterprise intranet, you must deploy DataKit on a server accessible to the intranet environment and configure your private deployment node. If you need to perform cloud probing on public websites, no special operations are required.

Take the addition of the following node as an example:

- Geographic Location: Albania/Elbasan
- Carrier: unicom
- Node code: Albania-Elbasan-unicom
- Node Name: Albania-Elbasan-Unicom

1. Through "Synthetic Tests" - "Self-built Nodes Management," click "Create" to establish a new node. Input the following details and confirm to quickly set up a service quality monitoring point distributed globally, expanding your service quality detection range.

![](img/w6.png)

2. After completing the "Create" process, obtain the "Configuration Information" for this node in the "Self-built Nodes Management" list.

![](img/w7.png)

3. Based on the acquired configuration information, install the probing node on a server capable of executing the node function.

First, ensure that your server has the latest version of DataKit installed. **If you have not installed DataKit, go to the dashboard's "Integrations" - "DataKit" to install it. If you already have DataKit installed, make sure it is the latest version.**

- After installing DataKit, navigate to the conf.d/network directory under the installation folder, copy dialtesting.conf.sample, and rename it to dialtesting.conf.

![](img/w8.png)

- Fill in the configuration content into conf.d/network/dialtesting.conf.

```
region_id = "reg_c8care8dh477jlcibvrg"
ak = "bJljwJgfYFIGBxsxGv55"
sk = "yWDP7urMuciYMW6aQxndetzZ6yL2xAkT2NfmfLwz"
```

- After saving the file content, restart DataKit. Wait 1-2 minutes, and the node will begin its operation.

![](img/w9.png)