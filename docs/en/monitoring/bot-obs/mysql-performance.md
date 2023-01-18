# MySQL Performance  Intelligent Inspection

---

## Background

For increasingly complex application architectures, the current trend is that more and more customers adopt cloud databases free of operation and maintenance, so it is a top priority to detect MySQL performance. MySQL will be intelligently detected regularly, and abnormal alarms will be given by finding MySQL performance problems.

## Preconditions

1. Offline deployment of self-built DataFlux Func
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func 
3. Create [API Key](../../management/api-key/open-api.md) in the Guance Cloud "management/API Key management" 
4. In the self-built DataFlux Func, install "Guance Cloud Intelligent Inspection Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Self-built Inspection (MYSQL Performance)" through "Script Market"
5. In the DataFlux Func, write the intelligent inspection processing function
6. In the self-built DataFlux Func, create auto-trigger configurations for the functions you write through "Manage/Auto-trigger Configurations."

## Configuration Detection

Create a new script set in the self-built DataFlux Func to start the MySQL performance review configuration.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_mysql_performance__main as main

# Guance Cloud space API_KEY configuration (user-configured)
API_KEY_ID  = 'wsak_xxxx'
API_KEY     = '3LTcYxxxxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent check configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\intelligent check. If both sides are configured, the filters parameter in the script will take effect first

def filter_host(host):
    '''
    Filter host, customize the conditions that meet the requirements of host, return True for matching, and return False for mismatching
    return True｜False
    '''
    if host in ['196.168.0.0']:
        return True

'''
Task configuration parameters use:
@DFF.API('MYSQL performance detection', fixed_crontab='*/30 * * * *', timeout=900)

fixed_crontab: Fixed execution frequency "every 30 minutes"
timeout: Task execution timeout, limited to 15 minutes
'''
# Custom detection configuration; users do not need to modify it
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('MYSQL performance detection', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    '''
    configs : Configure the list of hosts to be detected (optional, do not configure default detection of all hosts in the current workspace)
    configs = {
        "host": ["192.168.0.1", "192.168.0.0"]    # host list
    }

    '''
    checkers = [
        main.MysqlChecker(configs=configs, filters=[filter_host]),
    ]

    Runner(checkers, debug=False).run()
```

## Start Detection

### Register a Detectioan Item in Guance Cloud


In DataFlux Func, after the patrol is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in the Guance Cloud "Monitoring/Intelligent Patrol"

![image](../img/mysql-performance01.png)


### Configure MySQL Performance Detection in Guance Cloud

![image](../img/mysql-performance02.png)

#### Enable/Disable

MySQL performance detection is "on" by default, and can be "off" manually. After being turned on, the configured host list will be detected.

#### Export

Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.

#### Edit

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

>  **Note**: In the self-built DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance Cloud studio will override the parameters configured when writing the intelligent inspection processing function.

## View Events

This detection will scan the memory utilization information in the last 6 hours. Once the warning value will be exceeded in the next 2 hours, the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/mysql-performance04.png)

### Event Details Page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Atributes

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

#### Associated Events

Support to view associated events by filtering fields and selected time component information.

![image](../img/mysql-performance09.png)

## FAQ

**1.How to configure the detection frequency of MySQL performance detection**

* In the self-built DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Automatic Trigger Configuration".

**2.MySQL performance review may be triggered without exception analysis**

Check the current data collection status of `datakit` when there is no anomaly analysis in the detection report.

**3.Under what circumstances will MySQL performance review events occur**

 If the cpu utilization rate of the currently configured host continues to exceed 95% for 10 minutes, the memory utilization rate continues to exceed 95% for 10 minutes, the number of SQL executions exceeds 5 times of the month-on-month increase, and the number of slow SQL occurrences exceeds 5 times of the month-on-month increase, an alarm event will be generated.
