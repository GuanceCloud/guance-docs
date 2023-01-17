# Front-end Application Log Error Detection
---

## Background

Front-end error log detection will help find new error messages (Error Message after clustering) in front-end applications in the past hour, help development, operation and maintenance to repair codes in time, and avoid persistent damage to customer experience over time。

## Precondition

1. There are already access applications in Guance Cloud "user access monitoring"
2. Offline deployment of self-built DataFlux Func
3. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func 
4. Create an [API Key](../../management/api-key/open-api.md) for action in Guance Cloud "management/API Key management"
5. In the self-built DataFlux Func, install "Guance Cloud Intelligent Inspection Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Intelligent Inspection (rum)" through "Script Market"
6. In the DataFlux Func, write the Intelligent Inspection processing function
7. In the self-built DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

## Configuration Detection

Create a new script set in the self-built DataFlux Func to start the front-end error log detection configuration.

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum__main as main

# Guance Cloud space API_KEY configuration (user-configured)
API_KEY_ID  = 'xxxxx'
API_KEY     = 'xxxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent check configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\intelligent check. If both sides are configured, the filters parameter in the script will take effect first.

def filter_appid(data):
    appid = data[0]
    if appid in ['appid_Htow4wbwHXUptr7etBB2vQ']:
        return True


'''
Task configuration parameters use:
@DFF.API('Front-end application log error detection', fixed_crontab='0 * * * *', timeout=900)

fixed_crontab: Fixed execution frequency "once per hour"
timeout: Task execution timeout, limited to 15 minutes
'''

# RUM error type self-built inspection configuration; Users do not need to modify
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Front-end application log error detection', fixed_crontab='0 * * * *', timeout=900)
def run(configs={}):
    """
    parameters:
        configs: Configure the list of app_names to be detected (optional, do not configure default detection of all app_names)

        configuration example:
        configs = {
            "app_names": ["app_name_1", "app_name_2"]  # Application name list
        }
    """
    checkers = [
 		# Configuring RUM error detection
        main.RUMErrorCheck(configs=configs),
    ]

    Runner(checkers, debug=False).run()
```
## Open Configuration
### Register a Detectioan Item in Guance Cloud

In DataFlux Func, after the detection is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance Cloud "Monitoring/Intelligent Patrol".

![image](../img/rum_error01.png)


### Configure Front-end Application Log Error Detection in Guance Cloud

![image](../img/rum_error11.png)

#### Enable/Disable
The error detection of front-end application log is "on" by default, which can be manually "off". After being turned on, the configured front-end application list will be detected.

#### Export
Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.

#### Edit
Intelligent Check "Front-end Error Detection" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent detection list, click the "Edit" button to edit the detection template.

* Filter criteria: Configure the front-end application app_name
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  
Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start detection:

![image](../img/rum_error02.png)

You can refer to the following JSON configuration information for multiple applications.

```json
 // configuration example:
   configs = {
       "app_names": ["app_name_1", "app_name_2"]  # Application name list
   }
```

## View Events
 Guance Cloud automatically clusters error messages from all browser clients, This detection will compare all error messages in the past one hour with those in the past 12 hours. Once an error that has never occurred, an alarm will be given, and the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/rum_error04.png)

### Event Details page
Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Attributes
* Detection Dimensions: Filter criteria based on intelligent check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security check, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Supports replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/rum_error05.png)

#### Event details
* Event overview: Describes the object and content of the anomaly detection event
* Front-end error trend: You can view the error statistics of the current front-end application in the past hour
* New error details: View the detailed error time, error information, error type, error stack and number of errors; Click on the error message, and the error type will enter the corresponding data observer; Clicking on the error stack will bring you to the specific error stack details page.

![image](../img/rum_error06.png)
![image](../img/rum_error09.png)

#### History
Support to view detection objects, exception/recovery time and duration.

![image](../img/rum_error07.png)

#### Associated Events
Support to view associated events by filtering fields and selected time component information.

![image](../img/rum_error08.png)

## FAQ
**1.How to configure the detection frequency of front-end application log error detection**

* In the self-built DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2.There may be no anomaly analysis when the front-end application log error detection is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report..







