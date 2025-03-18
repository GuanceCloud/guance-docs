# Idle Host Inspection
---

## Background

As business grows, the volume of resource usage increases, and enterprise data centers become larger. The problem of significant waste from idle hosts becomes more pronounced. Especially within enterprises, due to demand fluctuations and departmental isolation, some hosts cannot be fully utilized, resulting in a large amount of idle resources. This situation can lead to a direct increase in cloud service costs, reduced resource efficiency, and potential decreases in security and performance levels.

## Prerequisites

1. Set up [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In <<< custom_key.brand_name >>> under "Manage / API Key Management," create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the current SaaS deployment of <<< custom_key.brand_name >>> on [the same provider and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Inspection

In your self-hosted DataFlux Func, install the "<<< custom_key.brand_name >>> Self-built Inspection (Idle Host Inspection)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key as prompted to enable it.

Select the inspection scenario you want to enable in the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configure Inspection

### Configuration in <<< custom_key.brand_name >>>

![image](../img/idle-resources03.png)

#### Enable/Disable
Idle host inspection is enabled by default. It can be manually disabled. Once enabled, it will inspect the configured list of idle host inspection configurations.

#### Edit
The intelligent inspection "Idle Host Inspection" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: No parameters need to be configured; it will inspect all workspace cloud hosts by default.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods.

Click Edit in the entry parameter configuration, fill in the corresponding detection object in the parameter configuration, click Save, and start the inspection:

![image](../img/idle-resources04.png)

## View Events
<<< custom_key.brand_name >>> inspects the host status of the current workspace. When idle hosts are detected, the intelligent inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view the corresponding anomaly events.

![image](../img/idle-resources05.png)

### Event Details Page
Click **Event** to view the details page of the intelligent inspection event, which includes event status, occurrence time of anomalies, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, it supports copying `key/value` pairs, adding filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, it supports copying in `key/value` format and performing forward/reverse filtering.

![image](../img/idle-resources06.png)

#### Event Details

The idle host inspection detects the running state of cloud hosts and generates event reports when they are found to be idle.

* Event Overview: Describes the object and content of the anomaly inspection event.
* Idle Host Details: View detailed information about currently idle hosts.
* Process Details: Displaying the process status of idle hosts provides support for business diagnostics.

![image](../img/idle-resources07.png)

#### History

Supports viewing the inspected objects, anomaly/recovery times, and duration.

![image](../img/idle-resources08.png)

#### Related Events
Supports viewing related events through filtered fields and selected time component information.

![image](../img/idle-resources09.png)

## FAQs
**1. How to configure the inspection frequency for idle hosts**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the self-built inspection handling function, and then configure it in "Manage / Automatic Trigger Configuration".

**2. Why there might be no anomaly analysis during inspection**

If the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. Previously normal scripts fail during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can refer to the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to view the update records of the script market for timely updates.

**4. During script upgrades, the Startup script set does not change**

Delete the corresponding script set first, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Manage / Automatic Trigger Configuration," check the inspection status. First, ensure it is enabled, then verify the inspection script by clicking Execute. If it shows "Executed successfully xx minutes ago," the inspection is running normally and has taken effect.