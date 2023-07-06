# Alibaba Cloud Asset Intelligent Inspection
---

## Background

It provides additional data access capability for Guance, which is convenient for users to have a better understanding of the product performance status of cloud suppliers.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
3. Create [API Key](../../../management/api-key/open-api.md) in Guance "management/API Key management" 
5. Open the [collector (such as Alibaba Cloud ECS)](https://func.guance.com/doc/script-market-guance-aliyun-ecs/) corresponding to the objects in the "Guance  Check (Alibaba Cloud)" to be detected
7. In the DataFlux Func, write the  check processing function

**Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable Alibaba Cloud Asset Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/cloudasset11.png)

## Start Intelligent Inspection

### Register detection items in Guance

After configuring the inspection in DataFlux Func, you can run the test by selecting the `run()` method directly on the page, and then you can view and configure it in the Guance "Monitoring / Intelligent Inspection" after clicking Publish.

### Configure Alibaba Cloud Asset Intelligent Inspection in Guance

![image](../img/cloudasset01.png)

#### Enable/Disable

Intelligent check "Alibaba Cloud Asset Check" defaults to "Started" status, which can be manually "Closed". After being opened, the configured cloud account will be inspected.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent check "Alibaba Cloud Asset Intelligent Inspection" supports users to manually add filter criteria. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: No configuration parameters are required for this check
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/cloudasset02.png)

## View Events

Intelligent check is based on the intelligent algorithm of Guance, which will find abnormal situations in cloud asset metrics, such as sudden abnormality of cloud asset metrics. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/cloudasset03.png)

After the corresponding  check is configured, the check will generate events after discovering exceptions according to the configuration to cooperate with us to troubleshoot error messages.

### Event Details Page
Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

![image](../img/cloudasset04.png)

#### Basic Properties

* Detection Dimensions: Filter criteria based on smart patrol configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/cloudasset05.png)

#### Event Details

- Event overview: Describe the object and content of abnormal check events. Different collectors may have different event details.

#### History
 Support to view the detection object, exception/recovery time and duration.

![image](../img/cloudasset06.png)

#### Related events
Support to view associated events by filtering fields and selected time component information.

![image](../img/cloudasset07.png)


## FAQ
**1.How to configure the detection frequency of Alibaba Cloud asset check**

In DataFlux Func, setting automatic trigger time for detection function through "management/automatic trigger configuration" suggests that the check interval should not be too short, which will cause task accumulation, and it is recommended to configure it for half an hour.

**2.What do you think of the relevant measurement collected by Alibaba Cloud Asset Check**

You can refer to the measurement in the report data format in the Alibaba Cloud Integration document [(e.g., Alibaba Cloud ECS)](https://func.guance.com/doc/script-market-guance-aliyun-ecs/) for data viewing.

**3. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.





