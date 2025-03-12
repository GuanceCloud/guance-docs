# MySQL Performance Intelligent Inspection

---

## Background

For increasingly complex application architectures, the current trend is that more and more customers adopt cloud databases free of operation and maintenance, so it is a top priority to detect MySQL performance. MySQL will be intelligently detected regularly, and abnormal alarms will be given by finding MySQL performance problems.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
3. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/).

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (MySQL Performance)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

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

You can refer to the following to configure multiple host information:

```json
 // configuration example:
  configs ：
            host1
            host2
            host3
```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the intelligent inspection processing function.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_mysql_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter hosts, customize the conditions for matching the required hosts, and return True if matched, and False if not matched.
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('MYSQL 性能自建巡检', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    '''
    Optional parameters：
      configs : 
              Configure the list of hosts to be checked (optional. If not configured, MySQL services on all hosts under the current workspace will be checked by default).
			  Multiple hosts can be specified (concatenated by line breaks). If not specified, MySQL services on all hosts will be checked.
      configs example：
              host1
              host2
              host3
    '''
    checkers = [
        main.MysqlChecker(configs=configs, filters=[filter_host]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

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

**5. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the words "executed successfully xxx minutes ago" appear, the inspection is running normally and is effective.
