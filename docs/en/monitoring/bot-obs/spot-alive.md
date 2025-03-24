# Inspection of Alibaba Cloud Preemptible Instance Survival
---

## Background

Due to the fluctuating market price of preemptible instances influenced by supply and demand, it is necessary to specify a bidding model when creating preemptible instances. A preemptible instance can only be successfully created if the real-time market price for the specified instance specification is lower than the bid and there is sufficient inventory. Therefore, inspection of preemptible instances for cloud assets becomes particularly important. Through inspection, when it is discovered that a preemptible instance is about to be released, it will prompt with the latest prices of all available zones for the current specification of preemptible instances as well as the historical price of that preemptible instance, and provide appropriate handling recommendations.

## Prerequisites

1. Self-built [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an [API Key](../../management/api-key/open-api.md) in <<< custom_key.brand_name >>> under 「Manage / API Key Management」 for operations.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and in the same region as your currently used <<< custom_key.brand_name >>> SaaS deployment [here](../../../getting-started/necessary-for-beginners/select-site/).

## Start Inspection

In the self-built DataFlux Func, install 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud-ECS Collection)」 and 「<<< custom_key.brand_name >>> Self-built Inspection (Alibaba Cloud Preemptible Instance Survival Detection)」 via the 「Script Market」 and configure the <<< custom_key.brand_name >>> API Key to start the inspection.

In the DataFlux Func Script Market, select the required inspection scenario to click and install. After configuring the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), choose to deploy and start the script.

![image](../img/create_checker.png)

After the startup script deployment is successful, it will automatically create the startup script and automatic trigger configuration. You can directly jump to view the corresponding configuration through the link.

![image](../img/success_checker.png)

## Configure Inspection

### Configure Inspection in <<< custom_key.brand_name >>>

![image](../img/spot_alive02.png)

#### Enable/Disable
The survival inspection of Alibaba Cloud preemptible instances is default set to 「Enable」 status. It can be manually 「Disabled」. After enabling, it will inspect the configured list of preemptible instances.

#### Edit
The intelligent inspection 「Alibaba Cloud Preemptible Instance Survival Inspection」 supports users adding manual filtering conditions. In the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure `instance_type` type and `spot_with_price_limit` accepted discount.
* Alert Notifications: Supports selecting and editing alert strategies, including event levels requiring notification, notification targets, and alert silence cycles.

To configure the entry parameters, click Edit and fill in the corresponding detection objects in the parameter configuration, then save and start the inspection:

![image](../img/spot_alive03.png)

You can refer to the following JSON to configure multiple application information

```json
 // Configuration example: Can configure multiple groups or single
    configs = [
        {"instance_type": "xxx1", "spot_with_price_limit": "xxx2"},
        {"instance_type": "xxx3", "spot_with_price_limit": "xxx4"}
    ]
```

## View Events
<<< custom_key.brand_name >>> will conduct inspections based on the current state of preemptible instances. When instances close to release are detected, the intelligent inspection will generate corresponding events. In the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to check the corresponding abnormal events.

![image](../img/spot_alive04.png)

### Event Details Page
Click **Event**, to view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, history records, and related events.

* Click the small icon 「View Monitor Configuration」 in the upper-right corner of the details page to view and edit the current intelligent inspection configuration details.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions configured for intelligent inspection, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user analysis, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, supports copying in `key/value` format, forward/reverse filtering.

![image](../img/spot_alive05.png)

#### Event Details
* Event Overview: Describes the object and content of the abnormal inspection event.
* Preemptible Instance Details: View detailed information about the current instance, including instance name, ID, region, availability zone, etc.
* Preemptible Instance Type Price: View the price of all available zones under the current specification to help users place bids.
* Preemptible Instance Type Historical Price: View the historical price of preemptible instances under different availability zones for the current specification to track price changes.
* Warm Suggestions: Provides operational suggestions for the current abnormal scenario.

![image](../img/spot_alive06.png)

#### History Records
Supports viewing the detection object, anomaly/recovery times, and duration.

![image](../img/spot_alive07.png)

#### Related Events
Supports viewing related events through filtered fields and selected time component information.

![image](../img/spot_alive08.png)

## Common Issues
**1. How to configure the detection frequency for the survival inspection of Alibaba Cloud Preemptible Instances**

* In the self-built DataFlux Func, add `fixed_crontab='*/2 * * * *', timeout=60` in the decorator while writing the custom inspection processing function. Then configure it in 「Manage / Automatic Trigger Configuration」.

**2. Why might there be no anomaly analysis during the triggering of the survival inspection of Alibaba Cloud Preemptible Instances**

When there is no anomaly analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. During the inspection process, previously normal scripts show abnormal errors**

Please update the referenced script set in the DataFlux Func Script Market. You can check the update record of the Script Market through the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates to the script.

**4. During the upgrade of the inspection script, why does the corresponding script set in Startup not change**

Please delete the corresponding script set first, then click the Upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In 「Manage / Automatic Trigger Configuration」, view the corresponding inspection status. The status should first be enabled, and secondly, you can verify whether the inspection script has any issues by clicking Execute. If there is a message indicating successful execution xxx minutes ago, the inspection is running normally and taking effect.