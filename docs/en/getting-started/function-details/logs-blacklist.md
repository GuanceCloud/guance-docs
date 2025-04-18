# Log Blacklist
---


<<< custom_key.brand_name >>> provides you with comprehensive log collection capabilities, supporting the collection of log data generated by Windows/Linux/MacOS hosts, web servers, virtual machines, network devices, security devices, databases, etc. However, since the collected logs may include parts of the logs that you do not need, <<< custom_key.brand_name >>> provides you with the **Log Blacklist** feature, which <u>filters out log data that matches the added log filtering rules and prevents it from being reported to the workspace</u>, helping you save on log data storage costs.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>), and then [install DataKit](../../datakit/datakit-install.md) on your host, enabling the operation of relevant integrations for data collection.

## The Role of the Log Blacklist

### 1. Save Money

In <<< custom_key.brand_name >>>, the billing method for log data is as follows:

| **Billing Item** | **Billing Unit** | **Commercial Plan Tiered Price** |  |  |  |
| --- | --- | --- | --- | --- | --- |
| Data Storage Policy |  | 7 Days | 14 Days | 30 Days | 60 Days |
| Number of Log Data | Per Million Entries | $0.12 | $0.15 | $0.20 | $0.25 |

For example, using logs produced by **Synthetic Tests**, we create a node in Beijing that performs a test on our company's site once per minute. At this point, a log will be generated every minute and uploaded to the workspace, but we are more concerned about when the node times out or fails during testing. Therefore, at this time, you can use our log blacklist feature to filter out logs with `status` set to `OK`, thereby significantly reducing data costs.

### 2. Peace of Mind

The log blacklist configuration takes effect immediately upon success, applies to all users across the workspace, and only needs to be configured once, remaining effective permanently. Members with standard membership and above can create and edit blacklist configurations.

### 3. Time-Saving

Using the log blacklist feature reduces the collection of ineffective logs, presenting more useful information within the workspace, making it easier for you to find target logs faster.

## How to Use the Log Blacklist Feature

### 1. View the Blacklist

In the <<< custom_key.brand_name >>> workspace, click **Logs > Blacklist**, where you can view all log filtering rules through the **Log Blacklist**.

![](../img/5.logs_blacklist_1.png)

### 2. Create, Edit Blacklists

- Create: In the upper-left corner of the log blacklist, click **Create Blacklist** to create a new log filtering rule;
- Edit: On the right side of the log blacklist, click **Edit** to modify an already created log filtering rule.

As shown in the figure below; select the log source `http_dail_testing`, filter out logs where `status=OK` and `city=hangzhou`. Logs that meet these filtering criteria simultaneously will not be reported to the workspace.

![](../img/5.logs_blacklist_2.png)

### 3. Delete Blacklist

On the right side of the log blacklist, click **Delete** to remove existing log filtering rules. After the filtering rule is deleted, log data will be normally reported to the workspace.

![](../img/5.logs_blacklist_3.png)