# Cloud Account Billing Inspection Intelligent Integration 
---

## Background

Cloud (now only suport alibaba cloud) Account Billing Inspection helps subscribers manage budget alerts, abnormal cost alerts, forecast costs for cloud services and provides subscribers with the ability to visualize and support multi-dimensional visualization of consumption of cloud service resources.

## Preconditions

1. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of  DataFlux Func 
3. Create [API Key](../../../management/api-key/open-api.md) in Guance "management/API Key management" 
4. In DataFlux Func，by「Script Marketplace」to install「Guance  Core Package」「Guance Algorithm Library」「Guance  script (Cloud Account Billing Inspection)」.
5. Install and open[「Observation Cloud Integration (Huawei Cloud - Billing Collection - By Instance)」](https://func.guance.com/doc/script-market-guance-aliyun-billing-by-instance/)、[「Observation Cloud Integration (Tencent Cloud - Billing Collection - By Instance)」](https://func.guance.com/doc/script-market-guance-huaweicloud-billing-by-instance/)、[「Observation Cloud Integration (Alibaba Cloud - Billing Collection - By Instance)」](https://func.guance.com/doc/script-market-guance-tencentcloud-billing-by-instance/) in the Script Market, and the number of days to collect data exceeds 15 days
6. In the DataFlux Func, write the  check processing function
7. In the  DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。
>
> **Note 2:** Since instance level billing data is stored in logs, Observation Cloud SaaS log data is only stored for 15 days by default.

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable Cloud Account Billing Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/cloudfee_instacne11.png)

## Start Intelligent Inspection

### Register detection items in Guance

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in the Guance "Monitoring/Intelligent Patrol"

![image](../img/cloudfee_instacne01.png)


### Configure Cloud Account Billing Inspection Intelligent Integration  in Guance

![image](../img/cloudfee_instacne02.png)

#### Enable / Disable

Smart Inspection "Cloud Account Billing Inspection Intelligent Integration" is "On" by default, you can manually "Off", when it is on, it will inspection the configured cloud accounts.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor
Intelligent check "Cloud Account Billing Inspection Intelligent Integration" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter Criteria: Configure corresponding cloud vendor and cloud account information
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/cloudfee_instacne03.png)

You can configure multiple cloud accounts and corresponding budget information with reference to the following JSON.

```json
 //  Configuration Example：
 configs = [
        {
            "account_id": "10000000",    # 账户 ID
            "cloud_provider": "aliyun"   # 云厂商名称 可选参数 aliyun，huaweicloud，tencentcloud
        },
        ...
    ]
```

## View Events
 Based on the Guance intelligence algorithm, the intelligent inspection will look for abnormalities in cloud asset costs and budget indicators, such as cloud asset costs suddenly occurring abnormally. For abnormal cases, Smart Inspection will generate corresponding events. Under the operation menu on the right side of the Smart Inspection list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/cloudfee_instacne04.png)

### Event Details Page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Properties

  * Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
  * Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering.

![image](../img/cloudfee_instacne05.png)

#### Event Details
* Event overview: Describe the object, content, etc. of the abnormal inspection events
* Cost analysis: You can view the consumption trend of the current abnormal cloud account for the past 30 days
  * Abnormal interval: The abnormal start time to the end time in the intelligent inspection data

* Consumption amount increase product ranking: View the current cloud account product cost ranking
* Spending amount increase instance ranking: View current cloud account instance cost ranking
* Expense Forecast: Forecast the consumption amount of the cloud account for the remaining dates of the month
  * Confidence interval: Predict the exact range of the trend line


![image](../img/cloudfee_instacne06.png)

#### History
Support to view detection objects, exception/recovery time and duration.

![image](../img/cloudfee_instacne07.png)

#### Related events

Support to view associated events by filtering fields and selected time component information.

![image](../img/cloudfee_instacne08.png)

#### View Link

You can view more granular information about the corresponding exception messages, and the factors that may affect them, through the Cloud Billing Instance Expense Monitoring view in the Event List
![image](../img/cloudfee_instacne09.png)

## FAQ

**1.How to configure the detection frequency of Cloud Account Billing Inspection Intelligent Integration **

* In the  DataFlux Func, add `fixed_crontab='0 0 * * *', timeout=900` in the decorator when writing the  check processing function, and then configure it in "management/auto-trigger configuration".

**2. Cloud Account Billing Inspection Intelligent Integration may not have exception analysis when triggered**

When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3.Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**4.Under what circumstances will Cloud Account Billing Inspection Intelligent Integration event be generated**

Using the specified cloud vendor product cost sum as the entry point, when there is a significant change in this cost information or when the budget of the total cost exceeds the configured budget triggers the generation of event logic for root cause analysis and generates a walk-through event.

* Tracking thresholds: e.g., current period cost year-over-year > 100%

**5.Cloud Account Billing Inspection Intelligent Integration no exceptions for a long time**

If billing exceptions are found in the online view patrol but not in the patrol, you should first check whether the patrol is open for more than 15 days, secondly, you should check whether the use of log data storage expiration policy is greater than 15 days, and finally, you should check in DataFlux Func whether the automatic triggering task is correctly configured.





