# RUM Log Error Intelligent Inspection
---

## Background

RUM error log inspection will help discover new error messages (Error Message after clustering) of the front-end application in the past hour, helping development and operation and maintenance to fix the code in time to avoid continuous harm to customer experience with the accumulation of time.

## Precondition

1. In Guance「 [user access monitoring](../../real-user-monitoring/index) 」that already have access applications.
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
4. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (RUM New Error Types)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/rum_error11.png)

#### Enable/Disable
The error detection of front-end application log is "on" by default, which can be manually "off". After being turned on, the configured front-end application list will be detected.

#### Export
Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor
Intelligent Check "Front-end Error Detection" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent detection list, click the "Edit" button to edit the detection template.

* Filter criteria: Configure the front-end application app_name
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start detection:

![image](../img/rum_error02.png)

You can refer to the following to configuration information for multiple applications.

```json
 // configuration example:
 	configs:
    	app_name_1
    	app_name_2
```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the intelligent inspection processing function.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter `appid`, customize the conditions for matching the required `appid`, and return True if matched, and False if not matched.
    return True｜False
    '''
    if appid in ['appid_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM 新增错误类型', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Optional parameters：
        configs：Multiple `appid` can be specified (concatenated by line breaks). If not specified, all apps will be checked.

    config example：
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumErrorCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## View Events

 Guance automatically clusters error messages from all browser clients, This detection will compare all error messages in the past one hour with those in the past 12 hours. Once an error that has never occurred, an alarm will be given, and the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/rum_error04.png)

### Event Details page
Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Properties
* Detection Dimensions: Filter criteria based on intelligent check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security check, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Supports replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/rum_error05.png)

#### Event details
* Event overview: Describes the object and content of the anomaly detection event
* Front-end error trend: You can view the error statistics of the current front-end application in the past hour
* New error details: View the detailed error time, error information, error type, error stack and number of errors; Click on the error message, and the error type will enter the corresponding data explorer; Clicking on the error stack will bring you to the specific error stack details page.

![image](../img/rum_error06.png)
![image](../img/rum_error09.png)

#### History
Support to view detection objects, exception/recovery time and duration.

![image](../img/rum_error07.png)

#### Related events
Support to view associated events by filtering fields and selected time component information.

![image](../img/rum_error08.png)

## FAQ
**1.How to configure the detection frequency of front-end application log error detection**

In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2.There may be no anomaly analysis when the front-end application log error detection is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report..

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**5. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the wor





