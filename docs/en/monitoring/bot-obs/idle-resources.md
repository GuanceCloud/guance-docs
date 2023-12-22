# Idle Resources Intelligent Inspection
---

## Background

Cloud computing has rapidly developed as a new mode of IT service, providing convenient, fast, and elastic IT infrastructure and application services for both enterprises and individuals, and bringing high efficiency and economy. However, as cloud resources gradually become the main component of enterprise data centers, the huge waste of cloud resources has become increasingly significant. Especially within enterprises, due to fluctuations in demand and isolation between departments, some cloud resources are not fully utilized, resulting in a large number of idle resources. This situation can cause an increase in cloud service costs, a decrease in resource efficiency, and even a reduction in security and performance levels. In order to better manage and optimize idle resources in the cloud, and improve the utilization efficiency of cloud computing, it is necessary to perform inspections on idle resources in the cloud. Through inspections, unnecessary resources in cloud services can be found and processed, avoiding problems such as cost increases, data leaks, or poor performance caused by long-term unnecessary use of resources.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
3. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/).

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (Idle Host Inspection)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/idle-resources03.png)

#### Enable/Disable
Idle Resources Intelligent Inspection is "enabled" by default and can be manually "disabled". Once enabled, it will inspect the configured Idle Resources Intelligent Inspection configuration list.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Check "Idle Resources Intelligent Inspection" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: Without configuring parameters, the entire workspace cloud host will be inspected by default.
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/idle-resources04.png)

## View Events
CloudMonitor will inspect based on the current status of hosts in the workspace. When an idle host is found, an event will be generated for smart inspection. Click the "View Related Events" button under the operation menu on the right side of the smart inspection list to view the corresponding abnormal events.

![image](../img/idle-resources05.png)

### Event Details page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Properties

* Detection Dimensions: Filter criteria based on intelligent check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security check, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Supports replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/idle-resources06.png)

#### Event details

Idle Resources Intelligent Inspection will detect the running status of cloud hosts and generate corresponding event reports when it finds that they are idle.

- Event Overview: describes the object and content of the abnormal inspection event.
- Idle host details: You can view detailed information about the host that is currently in idle state.
- Process details: By displaying the process status of the idle host, it provides support for business diagnosis.

![image](../img/idle-resources07.png)

#### History

Support to view detection objects, exception/recovery time and duration.

![image](../img/idle-resources08.png)

#### Related events

Support to view associated events by filtering fields and selected time component information.

![image](../img/idle-resources09.png)

## FAQ
**1.How to configure the detection frequency of Idle Resources Intelligent Inspection**

In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2.There may be no anomaly analysis when Idle Resources Intelligent Inspection is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report..

**3. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**4. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the words "executed successfully xxx minutes ago" appear, the inspection is running normally and is effective.





