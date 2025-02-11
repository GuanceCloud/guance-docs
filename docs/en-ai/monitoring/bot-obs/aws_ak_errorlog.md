# AWS Cloudtrail Anomaly Event Inspection

---

## Background

AWS CloudTrail is a service used to track, log, and monitor activities in AWS accounts. It records operations performed within the AWS account, including management console access, API calls, resource changes, etc. By monitoring error events in CloudTrail, potential security issues can be identified promptly. For example, unauthorized API calls, denied resource access, abnormal authentication attempts, etc. This helps protect your AWS account and resources from unauthorized access and malicious activities; it also allows you to understand the types, frequency, and impact of failures in the system. This aids in quickly identifying issues and taking appropriate corrective actions to reduce downtime and business impact.

## Prerequisites

1. Set up [DataFlux Func (Automata) Observability Cloud Special Edition](https://func.guance.com/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) for operations in the "Management / API Key Management" section of Guance

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, ensure it is deployed with the current Observability Cloud SaaS in the [same provider and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Inspection

In your self-hosted DataFlux Func, install "Observability Cloud Self-hosted Inspection (AWS Cloudtrail Anomaly Event Inspection)" via the "Script Market" and configure the Guance API Key to complete the setup.

Choose the inspection scenario you want to enable in the DataFlux Func Script Market, click install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) then select deploy to start the script.

> Note: First, configure CloudWatchLogs collection for CloudTrail on AWS, then enable "Guance Integration (AWS-CloudWatchLogs)" in Func.
>

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configure Inspection

Configure the inspection conditions you wish to filter either in the Observability Cloud Studio's Monitoring - Smart Inspection module or in the startup script automatically created by DataFlux Func. Refer to the following two configuration methods:

### Configuring Inspection in Observability Cloud

  ![image](../img/aws_ak_errorlog02.png)

#### Enable/Disable

AWS Cloudtrail anomaly event inspection is set to "Enabled" by default and can be manually "Disabled". Once enabled, it will inspect the configured cloud accounts.

#### Edit

The "AWS Cloudtrail Anomaly Event Inspection" feature supports users to manually add filtering conditions. Click the **Edit** button in the operation menu on the right side of the smart inspection list to edit the inspection template.

* Filtering Conditions: Configure the name of the log group (collected by CloudWatchLogs) that needs to be inspected.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert mute periods.

Click Edit in the configuration entry parameters, fill in the corresponding detection object in the parameter configuration, and click Save to start the inspection:

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

Based on the inspection algorithm of Observability Cloud, smart inspections will identify anomalies in AWS Cloudtrail. When anomalies are detected, smart inspections generate corresponding events. Click the **View Related Events** button in the operation menu on the right side of the smart inspection list to view the corresponding anomaly events.

![image](../img/aws_ak_errorlog04.png)

### Event Details Page

Clicking **Event** allows you to view the details page of the smart inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and associated events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the configured filtering conditions of the smart inspection, it supports copying `key/value` pairs, adding filters, and viewing related logs, containers, processes, Security Check, RUM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, they can be copied as `key/value` pairs and filtered positively or negatively.

  ![image](../img/aws_ak_errorlog05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly inspection event.
* Cloudtrail: The number of new error events under the current cloud account.
* AK Last Active Time: The last active time of the AK under the current cloud account.
* New Errors: Clusters of new error events under the current cloud account, which can be navigated to their respective event details.

![image](../img/aws_ak_errorlog06.png)

#### Historical Records

Supports viewing detection objects, anomaly/recovery times, and duration.

 ![image](../img/aws_ak_errorlog07.png)

#### Associated Events

Supports viewing associated events through selected time component information and filtering fields.

  ![image](../img/aws_ak_errorlog08.png)

## Common Issues

**1. How to configure the detection frequency of AWS Cloudtrail Anomaly Event Inspection**

In your self-hosted DataFlux Func, when writing custom inspection processing functions, add `fixed_crontab='0 * * * *', timeout=900` in the decorator, and then configure it in "Management / Auto Trigger Configuration".

**2. Why might there be no anomaly analysis when AWS Cloudtrail Anomaly Event Inspection is triggered**

When there is no anomaly analysis in the inspection report, check if the current Func pre-collector has data.

**3. Under what circumstances would AWS Cloudtrail Anomaly Event Inspection events occur**

When new anomaly events appear within the past hour.

**4. What to do if previously functioning scripts encounter abnormal errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update history of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates of the script.

**5. Why does the script set in Startup remain unchanged during inspection script upgrades**

First, delete the corresponding script set, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to determine if the inspection has taken effect after enabling**

In "Management / Auto Trigger Configuration," check the corresponding inspection status. It should first show as enabled, and you can verify the script by clicking Execute. If it shows "Executed Successfully xx minutes ago," the inspection is running normally and effectively.