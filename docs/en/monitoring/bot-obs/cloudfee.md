# Cloud Account Billing Check Integration Document
---

## Background

Cloud account bill check helps users manage cloud service budget warning, abnormal cost warning, forecast cost situation and provide users with visualization ability, supporting multi-dimensional visualization of cloud service resource consumption.

## Preconditions

1. Deploy your own DataFlux Func offline
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func 
3. Create [API Key](../../management/api-key/open-api.md) in Guance Cloud "management/API Key management" 
4. In the self-built DataFlux Func, install "Guance Cloud Self-built Inspection Core Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Self-built Inspection (Bill)" through "Script Market"
5. Install and open ["Guance Cloud Cluster (Huawei Cloud-Billing)"](https://func.guance.com/doc/script-market-guance-aliyun-billing/)、["Guance Cloud Cluster (Alibaba Cloud-Billing)"](https://func.guance.com/doc/script-market-guance-huaweicloud-billing/)、["Guance Cloud Cluster (Tencent Cloud-Billing)"](https://func.guance.com/doc/script-market-guance-tencentcloud-billing/) and collect data for more than 15 days
6. In the DataFlux Func, write the self-built check processing function
7. In the self-built DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

## Configuration Check

Create a new script set in the self-built DataFlux Func to start the cloud account bill check configuration.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_billing__main as main

# Account Configuration
API_KEY_ID  = 'xxxxx'
API_KEY     = 'xxxx'

'''
Task configuration parameters use:
@DFF.API('Cloud account bill check', fixed_crontab='0 0 * * *', timeout=900)

fixed_crontab: Fixed execution frequency "once a day"
timeout: Task execution timeout, limited to 15 minutes
'''

# Cloud billing configuration; users do not need to modify it
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Cloud account bill check', fixed_crontab='0 0 * * *', timeout=900)
def run(configs=None):
    '''
    configs : list type
    configs = [
        {
            "account_id": "10000000",    # account ID
            "budget": 20000,             # billing budget; value type
            "cloud_provider": "aliyun"   # Cloud supplier name; Optional parameters such as aliyun，huaweicloud，tencentcloud
        },
        ...
    ]
    '''
    # Cloud Billing Detector Configuration
    checkers = [
        main.CloudChecker(configs=configs),
    ]

    # Execute Cloud Asset Detector
    Runner(checkers, debug=False).run()
```
## Start Check

### Register a Detect Item in Guance Cloud

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in the Guance Cloud "Monitoring/Intelligent Patrol"

![image](../img/cloudfee01.png)



### Configure Cloud Account Bill Check in Guance Cloud

![image](../img/cloudfee04.png)



#### Enable/Disable

Intelligent check "Cloud Account Bill Check" defaults to "on" state, which can be manually "off". After opening, the configured cloud account will be checked.



#### Export

Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.



#### Edit

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

Intelligent check is based on the intelligent algorithm of Guance Cloud, which will find abnormal situations in cloud asset expenses and budget metrics, such as sudden abnormality of cloud asset expenses. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

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

#### Associated Events
Support to view associated events by filtering fields and selected time component information.

![image](../img/cloudfee11.png)
#### View Link
The Cloud Billing Expense Monitoring view in the event list allows you to view finer-grained information corresponding to the exception information and possible factors affecting it.
![image](../img/cloudfee12.png)

## FAQ
**1.How to configure the detection frequency of cloud account bill check**

* In the self-built DataFlux Func, add `fixed_crontab='0 0 * * *', timeout=900` in the decorator when writing the self-built check processing function, and then configure it in "management/auto-trigger configuration".

**2.What do you think of the relevant measurement collected by cloud account bill check**

Measurement: `cloud_bill` 

**3.Under what circumstances will the cloud account bill check event occur**

Taking the total cost of the designated cloud supplier as the entrance, when the cost information changes significantly or the budget of the total cost exceeds the configured budget, the event generation logic is triggered to carry out root cause analysis and generate check events.

* Tracking threshold: If the current expenses are more than 100% year-on-year
* Track Budget: Total expenses of the month is more than set budget





