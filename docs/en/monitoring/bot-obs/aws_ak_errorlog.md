# AWS Cloudtrail Anomaly Event Inspection

---

## Background

AWS CloudTrail is a service used for tracking, logging, and monitoring AWS account activities. It records operations performed in the AWS account, including management console access, API calls, resource changes, etc. By monitoring error events in CloudTrail, we can promptly identify potential security issues. For example, unauthorized API calls, denied resource access, and abnormal authentication attempts. This helps protect your AWS account and resources from unauthorized access and malicious activities; it also allows you to understand the types, frequency, and scope of failures that occur in the system. This enables you to quickly identify problems and take appropriate corrective actions to reduce downtime and business impact.

## Prerequisites

1. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. In <<< custom_key.brand_name >>> "Management / API Key Management," create an [API Key](../../management/api-key/open-api.md) for performing operations.

> **Note**: If you are considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current <<< custom_key.brand_name >>> SaaS deployment [here](../../../getting-started/necessary-for-beginners/select-site/).

## Start Inspection

In your self-hosted DataFlux Func, install 「 <<< custom_key.brand_name >>> Self-built Inspection (AWS Cloudtrail Anomaly Event Inspection)」 via the "Script Market" and follow the prompts to configure the <<< custom_key.brand_name >>> API Key to activate it.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

> Note: First, configure CloudWatchLogs to collect CloudTrail data on AWS, then enable 「 <<< custom_key.brand_name >>> Integration (AWS-CloudWatchLogs) 」in Func.
>

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and automatic trigger configuration. You can directly jump to the corresponding configuration through the link.

![image](../img/success_checker.png)


## Configure Inspection

In the <<< custom_key.brand_name >>> studio Monitoring - Intelligent Inspection module or in the startup script automatically created by DataFlux Func, configure the inspection conditions you want to filter. You can refer to the following two configuration methods.

### Configure Inspection in <<< custom_key.brand_name >>>

  ![image](../img/aws_ak_errorlog02.png)



#### Enable/Disable

The AWS Cloudtrail anomaly event inspection is by default in the "Enabled" state, which can be manually "Disabled." Once enabled, it will inspect the configured cloud accounts.



#### Edit

The "AWS Cloudtrail Anomaly Event Inspection" intelligent inspection supports users to manually add filtering conditions. Click the **Edit** button under the operation menu on the right side of the intelligent inspection list to edit the inspection template.

  * Filtering Conditions: Configure the name of the log set that needs to be inspected (the name of the log group collected by CloudWatchLogs).
  * Alert Notifications: Supports selecting and editing alert strategies, including event severity levels requiring notification, notification targets, and alert mute cycles.

To configure entry parameters, click edit and fill in the corresponding detection objects in the parameter configuration, then save and start the inspection:

  ![image](/Users/pacher/Downloads/aws_ak_errorlog03.png)

You can refer to the following configuration:

  ```json
   // Configuration Example:
      configs Configuration Example:
          source1
          source2
          source3
  ```



## View Events

Intelligent inspection based on <<< custom_key.brand_name >>> inspection algorithms will search for AWS Cloudtrail anomaly events. When anomaly events are detected, the intelligent inspection generates corresponding events. Under the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/aws_ak_errorlog04.png)



### Event Details Page

Clicking **Event**, you can view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon "View Monitor Configuration" in the top-right corner of the detail page to view and edit the configuration details of the current intelligent inspection.

#### Basic Attributes

  * Detection Dimensions: Based on the filtering conditions configured for intelligent inspection, support copying `key/value` dimensions, adding them to filters, and viewing related logs, containers, processes, security checks, traces, user analysis, synthetic tests, and CI data.
  * Extended Attributes: After selecting extended attributes, support copying in `key/value` format, forward/reverse filtering.

  ![image](../img/aws_ak_errorlog05.png)



#### Event Details

  * Event Overview: Describes the object and content of the anomaly inspection event.
  * Cloudtrail: The number of new error events under the current cloud account.
  * AK Last Active Time: The last active time of the AK under the current cloud account.
  * New Errors: Clusters of new error events under the current cloud account, which can be linked to the corresponding event details.

![image](../img/aws_ak_errorlog06.png)



#### Historical Records

Supports viewing the detection object, anomaly/recovery times, and duration.

 ![image](../img/aws_ak_errorlog07.png)



#### Related Events

Supports viewing related events by filtering fields and selected time component information.

  ![image](../img/aws_ak_errorlog08.png)



## Common Issues

**1. How to configure the detection frequency of AWS Cloudtrail Anomaly Event Inspection**

In your self-hosted DataFlux Func, when writing custom inspection handling functions, add `fixed_crontab='0 * * * *', timeout=900` in the decorator. Then configure it in "Management / Automatic Trigger Configuration."

**2. Why might there be no anomaly analysis when AWS Cloudtrail Anomaly Event Inspection is triggered**

If there is no anomaly analysis in the inspection report, check if the preceding collector in Func has any data.

**3. In what situations would AWS Cloudtrail Anomaly Event Inspection events be generated**

When new anomaly events are detected within the past hour.

**4. What to do if a previously normal script encounters errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update records of the script market through the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates to the script.

**5. During the upgrade of the inspection script, why does the corresponding script set in Startup not change**

First delete the corresponding script set, then click the upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection is effective after enabling**

In "Management / Automatic Trigger Configuration," check the status of the corresponding inspection. First, the status should be enabled. Second, you can verify whether the inspection script has issues by clicking execute. If there is a message indicating successful execution X minutes ago, the inspection is running normally and taking effect.