# AWS Cloudtrail Exception Event Intelligent Inspection

---

## Background

AWS CloudTrail is a service used to track, log, and monitor activity in an AWS account. It records various actions performed within the AWS account, including management console access, API calls, and resource changes. By monitoring CloudTrail for error events, potential security issues can be promptly identified. For example, unauthorized API calls, access to denied resources, and abnormal authentication attempts. This helps protect your AWS account and resources from unauthorized access and malicious activities. It also provides insights into the types, frequency, and scope of failures occurring in the system. This enables you to quickly identify issues and take appropriate corrective measures, reducing service downtime and minimizing the impact on your business.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
2. In Guance「Management / API Key Management」create [API Key](../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection


In the self-built DataFlux Func, you can install the "Guance Self-built Inspection (AWS CloudTrail Exception Event Inspection)" through the "Script Market" and follow the prompts to configure the Guance API Key to enable it.

In the DataFlux Func Script Market, select the desired inspection scenario and click on install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/). Finally, select deploy to start the script.

> Note: First, you need to configure the CloudTrail log collection in CloudWatch Logs on AWS. Then, enable the "Guance Integration (AWS-CloudWatchLogs)" in Func.
>

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)



## Configs Intelligent Inspection

To configure the inspection conditions you want to filter in the Guance Studio Monitoring - Intelligent Inspection module's automatically created startup script, you can refer to the following two configuration methods:

### Configure Intelligent Inspection in Guance

  ![image](../img/aws_ak_errorlog02.png)



#### Enable/Disable

By default, AWS CloudTrail Exception Event Inspection is in the "Enabled" state and can be manually "Disabled." When enabled, it performs inspections on the configured AWS accounts.



#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.



#### Editor

In the Intelligent Inspection module, specifically for "AWS CloudTrail Exception Event Inspection," users can manually add filtering conditions. In the right-side action menu of the Intelligent Inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure the corresponding log group names (the log groups collected by CloudWatch Logs) that need to be inspected.
* Alert Notifications: Support selecting and editing alert policies, including the event severity level to be notified, the recipients of the notifications, and the silence period for alerts.

After clicking the Edit button in the configuration entry parameters, fill in the corresponding detection objects in the parameter configuration, and click Save to start the inspection.

  ![image](/Users/pacher/Downloads/aws_ak_errorlog03.png)

You can refer to the following configuration:

  ```json
      configs example：
          source1
          source2
          source3
  ```



## View Events

The Intelligent Inspection module, based on the Guance inspection algorithm, searches for AWS CloudTrail exception events. When an exception event is detected, the Intelligent Inspection generates corresponding events. You can view the related events by clicking the **View Related Events** button in the right-side action menu of the Intelligent Inspection list.

![image](../img/aws_ak_errorlog04.png)



### Event Details page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

  * Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
  * Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.



#### Basic Properties

  * Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
  * Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering.

  ![image](../img/aws_ak_errorlog05.png)



#### Event Details

  * Event Overview: Describes the objects, content, and other details of the exceptional inspection event.
* CloudTrail: The number of newly added error events in the current cloud account.
* AK Last Active Time: The last active time of the Access Key (AK) in the current cloud account.
* New Errors: Clusters of newly added error events in the current cloud account, which can be clicked to navigate to the corresponding event details.

![image](../img/aws_ak_errorlog06.png)



#### History

 Support to view the detection object, exception/recovery time and duration.

 ![image](../img/aws_ak_errorlog07.png)



#### Related events

Support to view related events through filtering fields and selected time component information.

  ![image](../img/aws_ak_errorlog08.png)



## FAQ

**1.How to configure the detection frequency for AWS Cloudtrail Exception Event Intelligent Inspection?**

In the self-built DataFlux Func, when writing the self-built inspection processing function, add `fixed_crontab='0 * * * *', timeout=900` in the decorator. Then, configure it in "Management / Automatic Trigger Configuration."

**2.AWS Cloudtrail Exception Event Intelligent Inspection may not have any anomaly analysis when triggered？**

If there is no anomaly analysis in the inspection report, please check if the current Func pre-collector has data.

**3.Under what circumstances does AWS Cloudtrail Exception Event Intelligent Inspection generate events?**

When new exceptional events are detected within the past 1 hour.

**4.During the inspection process, previously running scripts are found to have exception errors？**

Please update the referenced script set in the DataFlux Func Script Market. You can check the script market's updates through the [Changelog](https://func.guance.com/doc/script-market-guance-changelog/) for convenient script updates.

**5.During the upgrade of the inspection script, there are no changes in the corresponding script set in the Startup？**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6.How to determine if the inspection is effective after enabling it?**

Check the corresponding inspection status in "Management / Automatic Trigger Configuration." First, the status should be enabled. Secondly, you can verify if the inspection script has any issues by clicking "Execute." If it shows "Execution successful xx minutes ago," then the inspection is running correctly and effective.

  

  
