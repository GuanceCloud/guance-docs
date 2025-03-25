# Alibaba Cloud Asset Inspection
---

## Background

To provide <<< custom_key.brand_name >>> with additional data access capabilities, allowing users to better understand the performance status of cloud provider products.

## Prerequisites

1. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an [API Key](../../management/api-key/open-api.md) in the <<< custom_key.brand_name >>> "Manage / API Key Management" section for operational purposes.
5. Enable the corresponding objects in the "[<<< custom_key.brand_name >>> Self-hosted Inspection (Alibaba Cloud)]" (e.g., [Alibaba Cloud ECS](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-ecs/)).
7. Write self-hosted inspection processing functions in your DataFlux Func instance.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as the current <<< custom_key.brand_name >>> SaaS deployment [here](../../../getting-started/necessary-for-beginners/select-site/).

## Configure Inspection

In the self-hosted DataFlux Func, create a new script set to enable billing inspections at the cloud account instance level. After creating the script set, select the corresponding script template when creating the inspection script, save it, and modify it according to your needs in the newly generated script file.

![image](../img/cloudasset11.png)

## Start Inspection

### Register Inspection Items in <<< custom_key.brand_name >>>

After configuring the inspection in DataFlux Func, you can test it by clicking the `run()` method directly on the page. After publishing, you can view and configure the inspection under <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection."

### Configure Alibaba Cloud Asset Inspection in <<< custom_key.brand_name >>>

![image](../img/cloudasset01.png)

#### Enable/Disable

The "Alibaba Cloud Asset Inspection" in Intelligent Inspection is **enabled** by default but can be manually turned off. Once enabled, it will inspect the configured cloud accounts.

#### Edit

The "Alibaba Cloud Asset Inspection" in Intelligent Inspection supports manual addition of filtering conditions. To edit the inspection template, click the **Edit** button in the operation menu on the right side of the intelligent inspection list.

* Filtering Conditions: This inspection does not require configuration parameters.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert mute cycles.

To configure entry parameters, click **Edit**, fill in the corresponding detection objects in the parameter configuration, and start the inspection after saving:

![image](../img/cloudasset02.png)

## View Events

Based on <<< custom_key.brand_name >>> intelligent algorithms, intelligent inspection will identify anomalies in cloud asset metrics, such as sudden abnormalities in cloud asset metrics. For anomalies, intelligent inspection generates corresponding events. To view related anomaly events, click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list.

![image](../img/cloudasset03.png)

After setting up the self-hosted inspection, the inspection will generate events upon detecting anomalies to help us troubleshoot error information.

### Event Details Page
Click **Event** to view the details page of the intelligent inspection event, which includes event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and associated events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the configuration details of the current intelligent inspection.

![image](../img/cloudasset04.png)

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in intelligent inspection, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user analysis, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, supports copying in `key/value` form, forward/reverse filtering.

![image](../img/cloudasset05.png)

#### Event Details

- Event Overview: Describes the object and content of the abnormal inspection event. The event details may vary depending on different collectors.

#### Historical Records
Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../img/cloudasset06.png)

#### Associated Events
Supports viewing associated events through filtered fields and selected time component information.

![image](../img/cloudasset07.png)


## Common Issues
**1. How to configure the detection frequency for Alibaba Cloud Asset Inspection**

In DataFlux Func, go to "Manage / Automatic Trigger Configuration" to set the automatic trigger time for the detection function. It is recommended to configure an interval of no less than half an hour to avoid task accumulation.

**2. How to view the relevant metric sets collected by Alibaba Cloud Asset Inspection**

Refer to the [Alibaba Cloud integration documentation](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-ecs/) for the format of reported data from the metric set.

**3. During the inspection process, previously normal scripts are now encountering abnormal errors**

Update the referenced script set in the DataFlux Func Script Market. You can view the update history via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate immediate script updates.