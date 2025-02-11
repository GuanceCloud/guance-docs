# Idle Host Inspection
---

## Background

As business grows, the volume of resource usage increases, leading to larger enterprise data centers. The significant waste from idle hosts becomes more pronounced. Especially within enterprises, due to demand fluctuations and departmental isolation, some hosts are not fully utilized, resulting in substantial idle resources. This situation can cause cloud service costs to skyrocket, reduce resource efficiency, and potentially lower security and performance levels.

## Prerequisites

1. Set up a self-hosted [DataFlux Func (Guance Special Edition)](https://func.guance.com/#/), or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an API Key for operations in Guance's "Management / API Key Management" section [API Key](../../management/api-key/open-api.md)

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the current Guance SaaS deployment under the [same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Inspection

In your self-hosted DataFlux Func, install "Self-hosted Inspection (Idle Host Inspection)" via the "Script Market" and configure the Guance API Key to enable it.

Select the inspection scenario you want to enable from the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) connection, then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configure Inspection

### Configuring Inspection in Guance

![image](../img/idle-resources03.png)

#### Enable/Disable
Idle host inspection is enabled by default. It can be manually disabled. Once enabled, it will inspect the configured list of idle host inspections.

#### Edit
The intelligent inspection "Idle Host Inspection" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: No parameters need to be configured; by default, it inspects all cloud hosts in the workspace.
* Alert Notifications: Supports selecting and editing alert policies, including event severity, notification targets, and alert mute periods.

To configure entry parameters, click Edit, fill in the corresponding detection object in the parameter configuration, and save to start the inspection:

![image](../img/idle-resources04.png)

## View Events
Guance will inspect the host status in the current workspace. When idle hosts are detected, intelligent inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view related anomaly events.

![image](../img/idle-resources05.png)

### Event Details Page
Click **Event** to view the details page of the intelligent inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history records, and associated events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, it supports copying `key/value`, adding filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, it supports copying in `key/value` format and forward/reverse filtering.

![image](../img/idle-resources06.png)

#### Event Details

Idle host inspection detects the operational status of cloud hosts and generates event reports when they become idle.

* Event Overview: Describes the object and content of the anomaly inspection event.
* Idle Host Details: View detailed information about currently idle hosts.
* Process Details: Display the process status of idle hosts to support business diagnostics.

![image](../img/idle-resources07.png)

#### History Records

Supports viewing the detection object, anomaly/downtime, and duration.

![image](../img/idle-resources08.png)

#### Associated Events
Supports viewing associated events through filtered fields and selected time component information.

![image](../img/idle-resources09.png)

## Common Issues
**1. How to configure the inspection frequency for idle hosts**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator while writing the self-hosted inspection handling function, then configure it in "Management / Automatic Trigger Configuration".

**2. Why there might be no anomaly analysis during inspection**

If the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. Script errors occur during inspection that were previously running normally**

Update the referenced script set in the DataFlux Func Script Market. You can view the update log via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates.

**4. No changes in the script set during inspection script upgrades**

Delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

Check the corresponding inspection status in "Management / Automatic Trigger Configuration". First, ensure it is enabled. Then verify the inspection script by clicking Execute. If it shows "Executed successfully xx minutes ago," the inspection is functioning properly.