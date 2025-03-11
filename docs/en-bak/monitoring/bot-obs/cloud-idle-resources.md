# Cloud Idle Resources Intelligent Inspection

---

## Background

Cloud computing, as a rapidly developing new IT service method, provides enterprises and individuals with convenient, fast, and flexible IT infrastructure and application services, bringing extremely high efficiency and cost-effectiveness. However, as cloud resources gradually become a major part of enterprise data centers, the problem of massive waste of resources in the cloud becomes more significant. Especially within the enterprise scope, due to factors such as demand fluctuations and isolation between departments, some cloud resources cannot be fully utilized, resulting in a large amount of idle resources. This situation leads to a linear increase in the cost of enterprise cloud services, a decrease in resource efficiency, and a potential reduction in security and performance levels. In order to better manage and optimize idle resources in the cloud, and to improve the usage benefits and resource utilization of cloud computing, it is essential to inspect idle resources in the cloud. Through inspection, unnecessary resources in the current cloud services can be discovered and processed promptly, avoiding problems such as cost overhead, data leakage, and poor performance due to long-term unnecessary resource usage.

## Preconditions

1. In Guance「 [application performance monitoring](../../application-performance-monitoring/collection/index) 」that already have access applications.
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (Idle Cloud Resource Inspection)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

> Note: If you need to inspect idle resources from different cloud providers, you need to enable different collectors.
>
> AWS: Guance Integration (AWS-EC2 collection), Guance Integration (AWS-CloudWatch collection) - mem
>
> Huawei: Guance Integration (Huawei Cloud - Cloud Monitoring Collection)
>
> Tencent: Guance Integration (Tencent Cloud - Cloud Monitoring Collection)
>
> Alibaba: Guance Integration (Alibaba Cloud - Cloud Monitoring Collection)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

  ![image](../img/cloud_idle_resources02.png)



#### Enable/Disable

APM Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured APM.



#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

The Smart Inspection "Idle Cloud Resource Inspection" supports users manually adding filtering conditions. In the operation menu on the right side of the Smart Inspection list, click the **Edit** button to edit the inspection template.

  * Filtering conditions: Configure the corresponding cloud provider information for the inspection (it is recommended to configure separately for different cloud providers)
  * Alert notifications: Support selecting and editing alert policies, including the event levels to be notified, notification objects, and the alert silence period, etc.

  After configuring the entry parameters, click edit, fill in the corresponding detection objects in the parameter configuration, and click save to start the inspection:

  ![image](../img/cloud_idle_resources03.png)

You can refer to the following configuration:

  ```json
  		 config example：
              aliyun
              aws
              tencentcloud
              huaweicloud
  ```



## View Events

 Based on the Guance inspection algorithm, Intelligent Inspection will look for abnormalities in APM metrics, such as `resource` abnormalities occurring suddenly. For abnormal conditions, Intelligent Inspection will generate corresponding events, and you can check the corresponding abnormal events by clicking the "View Related Events" button under the operation menu on the right side of the Smart Inspection list.

![image](../img//cloud_idle_resources04.png)



### Event Details page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

  * Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
  * Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.



#### Basic Properties

  * Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
  * Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering.

  ![image](../img/cloud_idle_resources05.png)



#### Event Details

  * Event overview: Describes the object, content, etc., of abnormal inspection events
  * Idle host details: You can view the idle host status and consumption situation under the current cloud account

> Note: When some hosts in the workspace fail to query custom object data and cannot obtain host details, please check whether the custom object data reporting is correct.

![image](../img/cloud_idle_resources06.png)



#### History

 Support to view the detection object, exception/recovery time and duration.

 ![image](../img/cloud_idle_resources07.png)



#### Related events

  Support to view related events through filtering fields and selected time component information.

  ![image](../img/cloud_idle_resources08.png)



## FAQ

**1. How to configure the detection frequency of idle cloud resource inspection**

In the self-built DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the custom inspection processing function, and then configure it in "Management / Automatic Trigger Configuration".

**2. Idle cloud resource inspection may not have abnormal analysis when triggered**

When there is no abnormal analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. Under what circumstances will idle cloud resource inspection events be generated**

When it is found that the average CPU utilization per hour in the past 48 hours is < 1% and the average MEM usage per hour in 48 hours is < 10% and the total in/out TCP traffic per hour in 48 hours is lower than 10M

**4. During the inspection process, previously normally running scripts have abnormal errors**

Please update the referenced script set in the DataFlux Func script market. You can view the update records of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely script updates.

**5. During the inspection script upgrade process, there is no change in the corresponding script set in Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to judge whether the inspection is effective after starting the inspection**

View the corresponding inspection status in "Management / Automatic Trigger Configuration". First, the status should be enabled; secondly, you can verify whether there is a problem with the inspection script by clicking "Execute". If the message "xxx minutes ago execution successful" appears, the inspection is running normally and takes effect.

  

  
