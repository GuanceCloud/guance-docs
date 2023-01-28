# MySQL Performance Intelligent Inspection

---

## Background

For increasingly complex application architectures, the current trend is that more and more customers adopt cloud databases free of operation and maintenance, so it is a top priority to detect MySQL performance. MySQL will be intelligently detected regularly, and abnormal alarms will be given by finding MySQL performance problems.

## Preconditions

1. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
2. Open DataFlux Func's [Script Marketplace](https://func.guance.com/doc/script-market-basic-usage/)
3. In Guance「Management / API Key Management」create [API Key](../../management/api-key/open-api.md)
4. In DataFlux Func，by「Script Marketplace」to install「Guance  Core Package」「Guance Algorithm Library」「Guance  script (MySQL Performance)」.
5. In DataFlux Func, write  patrol processing functions.
6. In DataFlux Func , by「Manage / Auto-trigger Configurations」,create an automatic trigger configuration for the written function.

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS[on [the same carrier in the same region](../../getting-started/necessary-for-beginners/select-site/).

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable MySQL Performance Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/mysql-performance11.png)

## Start Intelligent Inspection

### Register detection items in Guance


In DataFlux Func, after the patrol is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in the Guance "Monitoring/Intelligent Patrol"

![image](../img/mysql-performance01.png)


### Configure MySQL Performance Intelligent Inspection in Guance

![image](../img/mysql-performance02.png)

#### Enable/Disable

MySQL performance detection is "on" by default, and can be "off" manually. After being turned on, the configured host list will be detected.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Check "MySQL Performance Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: Configure hosts that need to be checked
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/mysql-performance03.png)

You can refer to the following JSON to configure multiple host information:

```json
 // configuration example:
configs = {
    "host": ["192.168.0.1", "192.168.0.0"]    # host list
}
```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the intelligent inspection processing function.

## View Events

This detection will scan the memory utilization information in the last 6 hours. Once the warning value will be exceeded in the next 2 hours, the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/mysql-performance04.png)

### Event Details Page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Properties

* Detection Dimensions: Filter criteria based on intelligent check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes, and forward/reverse filtering

![image](../img/mysql-performance05.png)

#### Event Details

* Event overview: Describe the objects and contents abnormal check events.
* cpu utilization line chart: you can view the cpu utilization of the current abnormal host in the past 30 minutes.
* Memory utilization line chart: You can view the memory utilization of the current abnormal host in the past 30 minutes.
* Line chart of SQL execution times: You can view the number of times of replace, update, delete, insert and select executed by the current exception host in the past 30 minutes.
* Slow SQL line chart: You can see the number of slow SQL found by the current abnormal host in the past 30 minutes.
* SQL time ranking: Display abnormal MySQL Top 5 slow SQL ranking and related information, and view related logs through diest jump

![image](../img/mysql-performance06.png)

![image](../img/mysql-performance07.png)

![image](../img/mysql-performance10.png)

#### History

Support to view detection objects, exception/recovery time and duration.

![image](../img/mysql-performance08.png)

#### Related events

Support to view associated events by filtering fields and selected time component information.

![image](../img/mysql-performance09.png)

## FAQ

**1.How to configure the detection frequency of MySQL performance detection**

* In the  DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Automatic Trigger Configuration".

**2.MySQL performance review may be triggered without exception analysis**

Check the current data collection status of `datakit` when there is no anomaly analysis in the detection report.

**3.Under what circumstances will MySQL performance review events occur**

 If the cpu utilization rate of the currently configured host continues to exceed 95% for 10 minutes, the memory utilization rate continues to exceed 95% for 10 minutes, the number of SQL executions exceeds 5 times of the month-on-month increase, and the number of slow SQL occurrences exceeds 5 times of the month-on-month increase, an alarm event will be generated.

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.
