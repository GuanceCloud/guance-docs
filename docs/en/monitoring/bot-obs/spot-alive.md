# Alibaba Cloud Preemptible Instance Survival Inspection
---

## Background

Due to the fluctuating market price of preemptible instances based on supply and demand, it is necessary to specify a bidding model when creating a preemptible instance. A preemptible instance can only be successfully created if the real-time market price for the specified instance specification is lower than the bid and there is sufficient inventory. Therefore, inspecting preemptible instances is crucial for cloud assets. Through inspections, if a preemptible instance is about to be released, it will prompt the latest prices of all available zones for the current specification and provide appropriate handling recommendations.

## Prerequisites

1. Self-host [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an API Key for operations in <<< custom_key.brand_name >>> "Management / API Key Management" [API Key](../../management/api-key/open-api.md)

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as the current SaaS deployment of <<< custom_key.brand_name >>>.

## Enable Inspection

In the self-hosted DataFlux Func, install the "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-ECS Collection)" and "<<< custom_key.brand_name >>> Custom Inspection (Alibaba Cloud Preemptible Instance Survival Detection)" from the script market, and configure the <<< custom_key.brand_name >>> API Key to complete the activation.

In the DataFlux Func script market, select the inspection scenario you want to enable, click install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

![image](../img/create_checker.png)

After the startup script deployment is successful, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configure Inspection

### Configuration in <<< custom_key.brand_name >>>

![image](../img/spot_alive02.png)

#### Enable/Disable
The Alibaba Cloud Preemptible Instance Survival Inspection is enabled by default. It can be manually disabled. Once enabled, it will inspect the configured list of preemptible instances.

#### Edit
The "Alibaba Cloud Preemptible Instance Survival Inspection" supports manual addition of filtering conditions. In the operation menu on the right side of the smart inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure `instance_type` and `spot_with_price_limit` acceptance discounts.
* Alert Notifications: Supports selecting and editing alert strategies, including event levels, notification targets, and alert mute periods.

To configure entry parameters, click edit and fill in the corresponding detection objects in the parameter configuration, then save to start the inspection:

![image](../img/spot_alive03.png)

You can refer to the following JSON configuration for multiple applications:

```json
 // Configuration Example: Can configure multiple groups or single
    configs = [
        {"instance_type": "xxx1", "spot_with_price_limit": "xxx2"},
        {"instance_type": "xxx3", "spot_with_price_limit": "xxx4"}
    ]
```

## View Events
<<< custom_key.brand_name >>> will inspect the status of preemptible instances and generate corresponding events when detecting that they are about to be released. In the operation menu on the right side of the smart inspection list, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/spot_alive04.png)

### Event Details Page
Click **Event**, to view the details page of the smart inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions configured in the smart inspection, support copying `key/value`, adding to filters, and viewing related logs, containers, processes, Security Check, trace, RUM PV, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, support copying in `key/value` format, forward/reverse filtering.

![image](../img/spot_alive05.png)

#### Event Details
* Event Overview: Describes the object and content of the anomaly inspection event.
* Preemptible Instance Details: View detailed information about the current instance, including instance name, ID, region, and availability zone.
* Preemptible Instance Type Price: View the prices of all available zones under the current specification to assist users in bidding.
* Preemptible Instance Type Historical Price: View historical prices of preemptible instances across different availability zones for tracking price changes.
* Warm Suggestions: Provide operational suggestions for the current anomaly scenario.

![image](../img/spot_alive06.png)

#### History Records
Support viewing detection objects, anomaly/recovery times, and duration.

![image](../img/spot_alive07.png)

#### Related Events
Support viewing related events through filtering fields and selected time component information.

![image](../img/spot_alive08.png)

## FAQs
**1. How to configure the detection frequency for Alibaba Cloud Preemptible Instance Survival Inspection**

* In the self-hosted DataFlux Func, add `fixed_crontab='*/2 * * * *', timeout=60` in the decorator when writing the custom inspection processing function, then configure it in "Management / Auto Trigger Configuration".

**2. Why might there be no anomaly analysis when Alibaba Cloud Preemptible Instance Survival Inspection triggers**

If there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. Script errors occur during inspection that previously ran normally**

Update the referenced script set in the DataFlux Func script market. You can view the update records of the script market via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely script updates.

**4. No changes in the script set in Startup during the upgrade of inspection scripts**

Delete the corresponding script set first, then click the upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Auto Trigger Configuration," check the inspection status. First, it should be enabled, then verify the inspection script by clicking execute. If it shows executed successfully xxx minutes ago, the inspection is running normally.