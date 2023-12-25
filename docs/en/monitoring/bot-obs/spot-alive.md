# Alibaba Cloud Preemptible Instance Survival Intelligent Inspection
---

## Background

Since the market price of the preemptible instances fluctuates with the change of supply and demand, it is necessary to specify the bid mode when creating the preemptible instance, and only when the real-time market price of the specified instance specification is lower than the bid price and the inventory is sufficient can the preemptible instance be successfully created. Therefore, it is particularly important to inspect the preemptible instance of cloud assets. When the preemptible instance is found to be about to be released through inspection, the latest price of all available zones of the current specification of the preemptible instance and the historical price of the changed preemptible instance will be indicated and appropriate treatment advice will be given.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)../../dataflux-func/index.md)
3. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Integration (Aliyun-ECS Collection)" and "Guance Custom Inspection (Aliyun Spot Instance Survival Detection)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/spot_alive02.png)

#### Enable/Disable
Alibaba Cloud Preemptible Instance Survival Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured Alibaba Cloud Preemptible Instance.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor
Intelligent Inspection "Alibaba Cloud Preemptible Instance Survival Intelligent Inspection" supports users to manually add filtering conditions, and click the "Edit" button under the operation menu on the right side of the Smart Inspection list to edit the inspection template.

* Filter criteria: configure instance_type configure type, spot_with_price_limit accepted discount
* Alarm notification: support for selecting and editing alarm policies, including the level of events to be notified, notification objects, and alarm silence period, etc.

 Configure the entry parameters by clicking on Edit and then fill in the corresponding detection object in the parameter configuration and click Save to start the inspection：

![image](../img/spot_alive03.png)

You can refer to the following configuration Preemptible Instance multiple information

```json
 // Configuration example:
        configs = [
        {"instance_type": "xxx1", "spot_with_price_limit": "xxx2"},
        {"instance_type": "xxx3", "spot_with_price_limit": "xxx4"}
    ]
```

## View Events
When a preemptive instance is found to be about to be released, the intelligent inspection will generate the corresponding event, and you can view the corresponding abnormal event by clicking the "View Related Events" button under the operation menu on the right side of the intelligent inspection list.

![image](../img/spot_alive04.png)

### Event details page
Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

  * Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
  * Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.

#### Basic Properties
* Detection dimension: Based on the filtering conditions configured by Intelligent Inspection, it supports copying and adding the detection dimension `key/value` to the filtering and viewing the related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
  * Extended Attributes: Supports `key/value` replication and forward/reverse filtering after selecting extended attributes.

![image](../img/spot_alive05.png)

#### Event details
* Event overview: describes the object, content, etc. of the exception patrol event
* Preemptive Instance Details: View the details of the current instance including instance name, ID, region, available zones, etc.
* Preemptive instance type price: View the price of all available zones under the current specification to help users make bids
* Preemptive instance type history price: You can view the history price of the current specification of the preemptive instance in different available zones to facilitate tracking price changes
* Warm Suggestions: Gives operation suggestions for current exception scenarios

![image](../img/spot_alive06.png)

#### History
 Support to view the detection object, exception/recovery time and duration.

![image](../img/spot_alive07.png)

#### Related events

  Support to view related events through filtering fields and selected time component information.

![image](../img/spot_alive08.png)

## FAQ
**1.How to configure the detection frequency of the Alibaba Cloud Preemptible Instance Survival Intelligent Inspection**

* In the  DataFlux Func, add `fixed_crontab='*/2 * * * *', timeout=60` to the decorator when writing the  patrol handler function, and then configure it in `Management / Auto-trigger Configuration'.

**2. There may be no exception analysis when triggered by Alibaba Cloud Preemptible Instance Survival Intelligent Inspection**

When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3.Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**4. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the wor



