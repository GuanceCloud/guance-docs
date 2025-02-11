# Preemptible Instance Survival Inspection for Alibaba Cloud

---

## Background

Due to the fluctuating market price of preemptible instances based on supply and demand, it is necessary to specify a bidding model when creating a preemptible instance. A preemptible instance can only be successfully created if the real-time market price of the specified instance type is lower than the bid and there is sufficient inventory. Therefore, inspecting preemptible instances is crucial for cloud assets. Through inspections, when a preemptible instance is about to be released, it will prompt the latest prices of all available zones for the current instance type and provide appropriate handling recommendations.

## Prerequisites

1. Set up [DataFlux Func (Guance Special Edition)](https://func.guance.com/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) in Guance under "Management / API Key Management"

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as the currently used Guance SaaS deployment [in the same location](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspections

In your self-hosted DataFlux Func, install "Guance Integration (Alibaba Cloud-ECS Collection)" and "Guance Self-Hosted Inspection (Alibaba Cloud Preemptible Instance Survival Detection)" via the "Script Market" and configure the Guance API Key to enable the inspection.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose Deploy to start the script.

![image](../img/create_checker.png)

After the deployment script is successfully started, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration through the link.

![image](../img/success_checker.png)

## Configuring Inspections

### Configuring Inspections in Guance

![image](../img/spot_alive02.png)

#### Enable/Disable
The Alibaba Cloud preemptible instance survival inspection is enabled by default but can be manually disabled. Once enabled, it will inspect the configured list of preemptible instances.

#### Editing
The "Alibaba Cloud Preemptible Instance Survival Inspection" supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filter Conditions: Configure `instance_type` and `spot_with_price_limit` for accepted discounts.
* Alert Notifications: Supports selecting and editing alert policies, including event levels, notification targets, and alert mute periods.

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../img/spot_alive03.png)

You can refer to the following JSON configuration to set multiple application information:

```json
// Configuration Example: Can configure multiple groups or single configurations
configs = [
    {"instance_type": "xxx1", "spot_with_price_limit": "xxx2"},
    {"instance_type": "xxx3", "spot_with_price_limit": "xxx4"}
]
```

## Viewing Events
Guance will inspect the status of preemptible instances and generate events when an instance is about to be released. In the intelligent inspection list, click the **View Related Events** button to view corresponding anomaly events.

![image](../img/spot_alive04.png)

### Event Details Page
Click **Event** to view the detailed page of the intelligent inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the "View Monitor Configuration" icon in the upper-right corner of the detail page to view and edit the current intelligent inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the configured filter conditions, supports copying `key/value`, adding filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, supports copying `key/value` and forward/reverse filtering.

![image](../img/spot_alive05.png)

#### Event Details
* Event Overview: Describes the object and content of the anomaly inspection event.
* Preemptible Instance Details: View detailed information about the current instance, including name, ID, region, and availability zone.
* Preemptible Instance Type Price: View the prices of all available zones for the current specification to help users bid.
* Historical Prices for Preemptible Instance Types: View historical prices for the current specification across different availability zones to track price changes.
* Warm Suggestions: Provides operational recommendations for the current anomaly scenario.

![image](../img/spot_alive06.png)

#### History
Supports viewing the detection object, anomaly/recovery times, and duration.

![image](../img/spot_alive07.png)

#### Related Events
Supports viewing related events through filtered fields and selected time component information.

![image](../img/spot_alive08.png)

## Common Issues
**1. How to configure the detection frequency for Alibaba Cloud preemptible instance survival inspection**

* In your self-hosted DataFlux Func, add `fixed_crontab='*/2 * * * *', timeout=60` in the decorator when writing the custom inspection handler function, and configure it in "Management / Auto Trigger Configuration".

**2. No anomaly analysis in the inspection report**

If no anomaly analysis appears in the inspection report, check the data collection status of the current `datakit`.

**3. Previously running scripts fail during inspection**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates.

**4. Startup script set does not change during upgrade**

Delete the corresponding script set first, then click Upgrade and configure the corresponding Guance API key to complete the upgrade.

**5. How to verify if the inspection is effective after enabling**

In "Management / Auto Trigger Configuration," check the inspection status. It should be enabled, and you can validate the inspection script by clicking Execute. If it shows "Executed Successfully xxx minutes ago," the inspection is running normally.