# Cloud Account Billing Intelligent Inspection
---

## Background

Cloud ( Alibaba Cloud, Tecent Cloud, Huawei Cloud ) Account Billing Inspection helps subscribers manage budget alerts, abnormal cost alerts, forecast costs for cloud services and provides subscribers with the ability to visualize and support multi-dimensional visualization of consumption of cloud service resources.

## Preconditions

1. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of  DataFlux Func 
3. Create [API Key](../../../management/api-key/open-api.md) in Guance "management/API Key management" 
4. In the  DataFlux Func, install "Guance  Inspection Core Core Package", "Guance Algorithm Library" and "Guance  Inspection (Bill)" through "Script Market"
5. Install and open ["Guance Cluster (Huawei Cloud-Billing)"](https://func.guance.com/doc/script-market-guance-huaweicloud-billing/)、["Guance Cluster (Alibaba Cloud-Billing)"](https://func.guance.com/doc/script-market-guance-aliyun-billing/)、["Guance Cluster (Tencent Cloud-Billing)"](https://func.guance.com/doc/script-market-guance-tencentcloud-billing/) and collect data for more than 15 days
6. In the DataFlux Func, write the  check processing function
7. In the  DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable Cloud Account Billing Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/cloudfee15.png)

## Start Intelligent Inspection

### Register detection items in Guance

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in the Guance "Monitoring/Intelligent Patrol"

![image](../img/cloudfee01.png)



### Configure Cloud Account Billing Intelligent Inspection in Guance

![image](../img/cloudfee04.png)



#### Enable/Disable

Intelligent check "Cloud Account Bill Check" defaults to "on" state, which can be manually "off". After opening, the configured cloud account will be checked.



#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.



#### Editor

Intelligent check "Cloud Account Bill Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter Criteria: Configure the corresponding cloud supplier, cloud account and current month account budget information
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/cloudfee05.png)

You can configure multiple cloud accounts and corresponding budget information with reference to the following JSON.

```json
[
  {
    "account_id"    : "wsak_3132xxxxxxxxxxx",
    "cloud_provider": "aliyun",
    "budget"        : 10000
	},
  {
    "account_id"    : "wsak_3132xxxxxxxxxxx",
    "cloud_provider": "aliyun",
    "budget"        : 100011
	},
  {
    "account_id"    : "wsak_3132xxxxxxxxxxx",
    "cloud_provider": "aliyun",
    "budget"        : 9999
	}
]
```



## View Events

Intelligent check is based on the intelligent algorithm of Guance, which will find abnormal situations in cloud asset expenses and budget metrics, such as sudden abnormality of cloud asset expenses. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

After configuring the corresponding cloud supplier's cloud account and the current month's budget, the cloud account bill check will generate two types of events after discovering anomalies according to the configuration to cooperate with us to troubleshoot error messages.

![image](../img/cloudfee06.svg)

### Event Details Page
Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Attributes

* Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
* Extended attributes: Support replication in the form of `key/value` after selecting extended attributes, and forward/reverse filtering

![image](../img/cloudfee07.png)

#### Event Details

- Event overview: Describe the object, content the anomaly check event
- Cost analysis: you can view the consumption trend of current abnormal cloud accounts in recent 30 days
	- Exception interval: Exception start time to end time in intelligent check data

- Consumption amount ranking: View the current cloud account product expense ranking
- Expense forecast: Forecast the consumption amount of cloud account on the remaining date of the current month
	- Confidence interval: the accurate range for predicting the trend line

- Monthly budget: current account expenses in monthly budget

##### Cloud Account Cost over Budget

![image](../img/cloudfee08.png)

##### Cloud Account Fees Have Increased Abnormally

![image](../img/cloudfee09.png)

#### History
Support to view detection objects, exception/recovery time and duration.

![image](../img/cloudfee10.png)

#### Related events
Support to view associated events by filtering fields and selected time component information.

![image](../img/cloudfee11.png)
#### View Link
The Cloud Billing Expense Monitoring view in the event list allows you to view finer-grained information corresponding to the exception information and possible factors affecting it.
![image](../img/cloudfee12.png)

## FAQ
**1.How to configure the detection frequency of cloud account bill check**

* In the  DataFlux Func, add `fixed_crontab='0 0 * * *', timeout=900` in the decorator when writing the  check processing function, and then configure it in "management/auto-trigger configuration".

**2.What do you think of the relevant measurement collected by cloud account bill check**

Measurement: `cloud_bill` 

**3.Under what circumstances will the cloud account bill check event occur**

Taking the total cost of the designated cloud supplier as the entrance, when the cost information changes significantly or the budget of the total cost exceeds the configured budget, the event generation logic is triggered to carry out root cause analysis and generate check events.

* Tracking threshold: If the current expenses are more than 100% year-on-year
* Track Budget: Total expenses of the month is more than set budget

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.



