# RUM Log Error Intelligent Inspection
---

## Background

RUM error log inspection will help discover new error messages (Error Message after clustering) of the front-end application in the past hour, helping development and operation and maintenance to fix the code in time to avoid continuous harm to customer experience with the accumulation of time.

## Precondition

1. In Guance「user access monitoring」that already have access applications.
2. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
3. Open DataFlux Func's [Script Marketplace](https://func.guance.com/doc/script-market-basic-usage/)
4. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)
5. In DataFlux Func，by「Script Marketplace」to install「Guance  Core Package」「Guance Algorithm Library」「Guance  script RUM Log Error)」.
6. In DataFlux Func, write  patrol processing functions.
7. In DataFlux Func , by「Manage / Auto-trigger Configurations」,create an automatic trigger configuration for the written function.

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS[on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable RUM Log Error Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/rum_error12.png)

## Start Intelligent Inspection

### Register detection items in Guance

In DataFlux Func, after the detection is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance "Monitoring/Intelligent Patrol".

![image](../img/rum_error01.png)


### Configure RUM Log Error Intelligent Inspection in Guance

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

You can refer to the following JSON configuration information for multiple applications.

```json
 // configuration example:
   configs = {
       "app_names": ["app_name_1", "app_name_2"]  # Application name list
   }
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

* In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2.There may be no anomaly analysis when the front-end application log error detection is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report..

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

  




