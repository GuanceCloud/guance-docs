# Alibaba Cloud Asset Inspection
---

## Background

To provide additional data access capabilities for <<< custom_key.brand_name >>>, making it easier for users to understand the performance status of cloud provider products.

## Prerequisites

1. Set up [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an [API Key](../../management/api-key/open-api.md) in <<< custom_key.brand_name >>> under «Management / API Key Management» for operations.
5. Enable the corresponding objects in «<<< custom_key.brand_name >>> Self-built Inspection (Alibaba Cloud)» and configure collectors (e.g., Alibaba Cloud ECS) [Collector](https://func.guance.com/doc/script-market-guance-aliyun-ecs/)
7. Write self-built inspection processing functions in the self-hosted DataFlux Func.

> **Note**: If you are considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current <<< custom_key.brand_name >>> SaaS deployment [same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Configure Inspection

In the self-hosted DataFlux Func, create a new script set to enable cloud account instance-level billing inspection configuration. After creating the new script set, select the corresponding script template when creating the inspection script, and modify it as needed in the generated script file.

![image](../img/cloudasset11.png)

## Start Inspection

### Register Inspection Items in <<< custom_key.brand_name >>>

After configuring the inspection in DataFlux Func, you can test by clicking the `run()` method directly on the page. After publishing, you can view and configure the inspection in <<< custom_key.brand_name >>> under «Monitoring / Smart Inspection».

### Configure Alibaba Cloud Asset Inspection in <<< custom_key.brand_name >>>

![image](../img/cloudasset01.png)

#### Enable/Disable

The «Alibaba Cloud Asset Inspection» feature in Smart Inspection is enabled by default but can be manually disabled. Once enabled, it will inspect the configured cloud accounts.

#### Edit

Smart Inspection «Alibaba Cloud Asset Inspection» supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the Smart Inspection list to edit the inspection template.

* Filter Conditions: No parameters need to be configured for this inspection.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods.

After clicking **Edit**, fill in the corresponding inspection objects in the parameter configuration and click Save to start the inspection:

![image](../img/cloudasset02.png)

## View Events

Based on <<< custom_key.brand_name >>> smart algorithms, Smart Inspection identifies anomalies in cloud asset metrics. For anomalies, Smart Inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the Smart Inspection list to view the associated anomaly events.

![image](../img/cloudasset03.png)

When the self-built inspection is properly configured, inspections will generate events upon detecting anomalies to assist in troubleshooting error information.

### Event Details Page
Clicking **Event** allows you to view the detailed page of the Smart Inspection event, including event status, time of occurrence, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled «View Monitor Configuration» in the top-right corner of the detail page to view and edit the current Smart Inspection configuration details.

![image](../img/cloudasset04.png)

#### Basic Attributes

* Inspection Dimensions: Based on the filter conditions configured in Smart Inspection, it supports copying `key/value` pairs, adding filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, availability monitoring, and CI data.
* Extended Attributes: Selecting extended attributes allows copying `key/value` pairs and performing forward/reverse filtering.

![image](../img/cloudasset05.png)

#### Event Overview

- Event Summary: Describes the object and content of the anomaly inspection event. Different collectors may have different event details.

#### History
Supports viewing the inspected object, anomaly/recovery times, and duration.

![image](../img/cloudasset06.png)

#### Related Events
Supports viewing related events through filtered fields and selected time components.

![image](../img/cloudasset07.png)


## Common Issues
**1. How to configure the inspection frequency for Alibaba Cloud assets**

In DataFlux Func, set the automatic trigger time for the inspection function via «Management / Automatic Trigger Configuration». It is recommended to configure the inspection interval to no less than 30 minutes to avoid task accumulation.

**2. How to view the collected metrics for Alibaba Cloud assets**

Refer to the [Alibaba Cloud integration documentation](https://func.guance.com/doc/script-market-guance-aliyun-ecs/) for the data format of reported metrics.

**3. What to do if a previously working script encounters an error during inspection**

Update the referenced script set in the DataFlux Func script market. You can check the update records via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates to the scripts.