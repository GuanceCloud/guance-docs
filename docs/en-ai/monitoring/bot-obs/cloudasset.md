# Alibaba Cloud Asset Inspection
---

## Background

To provide additional data access capabilities for Guance, making it easier for users to gain a deeper understanding of the performance status of cloud vendor products.

## Prerequisites

1. Set up [DataFlux Func (Guance Special Edition)](https://func.guance.com/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an [API Key](../../management/api-key/open-api.md) in Guance under "Management / API Key Management" for performing operations.
5. Enable the corresponding objects in the "Self-built Inspection (Alibaba Cloud)" with collectors (e.g., Alibaba Cloud ECS) configured as needed: [Collector (e.g., Alibaba Cloud ECS)](https://func.guance.com/doc/script-market-guance-aliyun-ecs/)
7. Write self-built inspection processing functions in your DataFlux Func instance.

> **Note**: If you are considering using a cloud server for offline deployment of DataFlux Func, ensure it is deployed within the same operator and region as the currently used Guance SaaS deployment [in the same location](../../../getting-started/necessary-for-beginners/select-site/).

## Configure Inspection

Create a new script set in your self-built DataFlux Func to initiate cloud account instance billing inspection configuration. After creating the script set, select the corresponding script template when creating the inspection script, save it, and modify it as needed in the newly generated script file.

![image](../img/cloudasset11.png)

## Start Inspection

### Register Inspection Items in Guance

After configuring the inspection in DataFlux Func, you can test by clicking the `run()` method directly on the page. Once published, you can view and configure it in Guance under "Monitoring / Intelligent Inspection".

### Configure Alibaba Cloud Asset Inspection in Guance

![image](../img/cloudasset01.png)

#### Enable/Disable

The "Alibaba Cloud Asset Inspection" in Intelligent Inspection is enabled by default but can be manually disabled. Once enabled, it will inspect the configured cloud accounts.

#### Edit

The "Alibaba Cloud Asset Inspection" in Intelligent Inspection supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: No parameters need to be configured for this inspection.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

After clicking **Edit** and configuring the entry parameters, fill in the corresponding inspection objects in the parameter configuration and click **Save** to start the inspection:

![image](../img/cloudasset02.png)

## View Events

Based on Guance's intelligent algorithms, Intelligent Inspection identifies anomalies in cloud asset metrics. For example, if cloud asset metrics suddenly become abnormal, Intelligent Inspection generates corresponding events. You can view related anomaly events by clicking the **View Related Events** button in the operation menu on the right side of the intelligent inspection list.

![image](../img/cloudasset03.png)

Once the self-built inspection is properly configured, it will generate events upon detecting anomalies to help diagnose error information.

### Event Details Page
Clicking **Event** allows you to view the detailed page of an intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and associated events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

![image](../img/cloudasset04.png)

#### Basic Attributes

* Detection Dimensions: Based on the configured filtering conditions of the intelligent inspection, it supports copying detection dimensions (`key/value`), adding filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, they can be copied in `key/value` format and filtered forward/reverse.

![image](../img/cloudasset05.png)

#### Event Details

- Event Overview: Describes the object and content of the anomaly inspection event. The event details may vary depending on the collector used.

#### Historical Records
Supports viewing inspected objects, anomaly/recovery times, and duration.

![image](../img/cloudasset06.png)

#### Associated Events
Supports viewing associated events through selected fields and time component information.

![image](../img/cloudasset07.png)

## FAQs
**1. How to configure the inspection frequency for Alibaba Cloud Asset Inspection**

In DataFlux Func, configure automatic trigger times for the inspection function via "Management / Automatic Trigger Configuration". It is recommended not to set the inspection interval too short to avoid task accumulation; a 30-minute interval is suggested.

**2. How to view the collected Mearsurement sets for Alibaba Cloud Asset Inspection**

Refer to the integration documentation for Alibaba Cloud [such as Alibaba Cloud ECS](https://func.guance.com/doc/script-market-guance-aliyun-ecs/) for the reported data format and Mearsurement sets.

**3. During the inspection process, previously normal scripts have started throwing errors**

Update the referenced script set in the DataFlux Func Script Market. You can check the update records via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates to the scripts.