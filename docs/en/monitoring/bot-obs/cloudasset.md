# Alibaba Cloud Asset Check
---

## Background

It provides additional data access capability for Guance Cloud, which is convenient for users to have a better understanding of the product performance status of cloud suppliers.

## Preconditions

1. Deploy your own DataFlux Func offline
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func 
3. Create [API Key](../../management/api-key/open-api.md) in Guance Cloud "management/API Key management" 
4. In the self-built DataFlux Func, install "Guance Cloud Self-built Check Core Core Package" and "Guance Cloud Self-built Check (Alibaba Cloud)" through "Script Market"
5. Open the [collector (such as Alibaba Cloud ECS)](https://func.guance.com/doc/script-market-guance-aliyun-ecs/) corresponding to the objects in the "Guance Cloud Self-built Check (Alibaba Cloud)" to be detected
6. Install the accompanying third-party dependency package in your self-built DataFlux Func
7. In the DataFlux Func, write the self-built check processing function
8. In the self-built DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

## Configuration Check

In the self-built DataFlux Func, configure "Alibaba Cloud ECS Status" as an example, and other check configurations are the same. Change import to other patrol under the "Guance Cloud Self-built Check (Alibaba Cloud)" package

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_aliyun__ecs_status as ecs_status

# Account Configuration
API_KEY_ID  = 'wsak_313xxxxxxx'
API_KEY     = 'b9Vr06lxxxxxxxx'

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Alibaba Cloud Asset Check Test-ecs Status')
def run():
    '''
    Alibaba Cloud Host, Cloud Database, Load Balancer and other assets detection
    '''
    # Cloud Asset Detector Configuration
    checkers = [
        # Configure detection (see below for currently supported detection)
        ecs_delete.CloudChecker(),
    ]

    # Execute Cloud Asset Detector
    Runner(checkers, debug=False).run()

```
## Start Check

### Register a Detect Item in Guance Cloud

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance Cloud "Monitoring/Intelligent Patrol"

### Configure Alibaba Cloud Asset Check in Guance Cloud

![image](../img/cloudasset01.png)

#### Enable/Disable

Intelligent check "Alibaba Cloud Asset Check" defaults to "Started" status, which can be manually "Closed". After being opened, the configured cloud account will be inspected.

#### Export

Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.

#### Edit

Intelligent check "Alibaba Cloud Asset Check" supports users to manually add filter criteria. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: No configuration parameters are required for this check
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  
Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/cloudasset02.png)

## View Events

Intelligent check is based on the intelligent algorithm of Guance Cloud, which will find abnormal situations in cloud asset metrics, such as sudden abnormality of cloud asset metrics. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/cloudasset03.png)

After the corresponding self-built check is configured, the check will generate events after discovering exceptions according to the configuration to cooperate with us to troubleshoot error messages.

### Event Details Page
Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

![image](../img/cloudasset04.png)

#### Basic Attributes

* Detection Dimensions: Filter criteria based on smart patrol configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/cloudasset05.png)

#### Event Details

- Event overview: Describe the object and content of abnormal check events. Different collectors may have different event details.

#### History
Support to view detection objects, exception/recovery time and duration.

![image](../img/cloudasset06.png)

#### Associated Events
Support to view associated events by filtering fields and selected time component information.

![image](../img/cloudasset07.png)


## FAQ
**1.How to configure the detection frequency of Alibaba Cloud asset check**

In DataFlux Func, setting automatic trigger time for detection function through "management/automatic trigger configuration" suggests that the check interval should not be too short, which will cause task accumulation, and it is recommended to configure it for half an hour.

**2.What do you think of the relevant measurement collected by Alibaba Cloud Asset Check**

You can refer to the measurement in the report data format in the Alibaba Cloud Integration document [(e.g., Alibaba Cloud ECS)](https://func.guance.com/doc/script-market-guance-aliyun-ecs/) for data viewing.







