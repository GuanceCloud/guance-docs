# MySQL Performance Inspection

---

## Background

For increasingly complex application architectures, the current trend is that more and more customers are adopting maintenance-free cloud databases. Therefore, inspecting MySQL performance is of utmost importance. Regular intelligent inspections of MySQL are conducted to identify performance issues and trigger anomaly alerts.

## Prerequisites

1. Self-built [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In <<< custom_key.brand_name >>> "Manage / API Key Management", create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it's in the same operator and region as the currently used <<< custom_key.brand_name >>> SaaS deployment [Same Operator Same Region](../../../getting-started/necessary-for-beginners/select-site/).

## Starting Inspection

In your self-built DataFlux Func, install "<<< custom_key.brand_name >>> Self-Built Inspection (MySQL Performance)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to start.

In the DataFlux Func Script Market, select the inspection scenario you want to activate, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration through the link.

![image](../img/success_checker.png)

## Configuring Inspection

In the <<< custom_key.brand_name >>> studio Monitoring - Intelligent Inspection module or in the automatically created startup script in DataFlux Func, configure the inspection conditions you want to filter. You can refer to the two configuration methods below.

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/mysql-performance02.png)

#### Enable/Disable

The MySQL performance inspection is by default "Enabled". It can be manually "Disabled". Once enabled, it will inspect the configured list of hosts.

#### Editing

The "MySQL Performance Inspection" in the Intelligent Inspection supports manual addition of filtering conditions. Click the **Edit** button under the operation menu on the right side of the Intelligent Inspection list to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selection and editing of alert strategies, including event levels to notify, notification targets, and alert mute cycles.

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and click Save to start the inspection:

![image](../img/mysql-performance03.png)

You can refer to the following configuration for multiple host information

```json
 // Configuration Example:
  configs Configuration Example:
            host1
            host2
            host3
```

> **Note**: In your self-built DataFlux Func, when writing custom inspection processing functions, you can also add filtering conditions (refer to example code configurations). Note that the parameters configured in <<< custom_key.brand_name >>> studio will override those set in the custom inspection processing function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions for inspection, you can test by selecting the `run()` method directly on the page and clicking Run. After clicking Publish, the script will run normally. You can also view or change the configuration in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_mysql_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter host, define custom conditions for matching hosts, return True for matches, False otherwise.
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('MYSQL Performance Self-Built Inspection', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    '''
    Optional Parameters:
      configs : 
              Configure the list of detection hosts (optional; if not configured, all Mysql services on all hosts in the current workspace will be detected by default).
              Multiple hosts can be specified (by line breaks), or leave blank to detect all hosts' Mysql services.
      configs Configuration Example:
              host1
              host2
              host3
    '''
    checkers = [
        main.MysqlChecker(configs=configs, filters=[filter_host]), # Support for user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

This inspection scans memory usage rates over the past 6 hours. If there is a prediction that it will exceed the warning threshold within the next 2 hours, the intelligent inspection will generate corresponding events. Under the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view corresponding abnormal events.

![image](../img/mysql-performance04.png)

### Event Details Page

Click **Event**, to view the details page of the intelligent inspection event, including event status, time of abnormal occurrence, abnormal name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon "View Monitor Configuration" in the upper-right corner of the detail page to view and edit the current intelligent inspection configuration details.

#### Basic Attributes

* Detection Dimensions: Based on the screening conditions of the intelligent inspection configuration, supports copying detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user analysis, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, supports copying in `key/value` format, forward/reverse filtering.

![image](../img/mysql-performance05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* CPU Utilization Line Chart: View the CPU utilization rate of the current abnormal host over the past 30 minutes.
* Memory Utilization Line Chart: View the memory utilization rate of the current abnormal host over the past 30 minutes.
* SQL Execution Count Line Chart: View the execution counts of replace, update, delete, insert, select over the past 30 minutes for the current abnormal host.
* Slow SQL Line Chart: View the number of slow SQL instances discovered over the past 30 minutes for the current abnormal host.
* SQL Execution Time Ranking: Displays the top 5 slow SQL rankings and related information for abnormal MySQL, allowing navigation to related logs via digest.

![image](../img/mysql-performance06.png)

![image](../img/mysql-performance07.png)

![image](../img/mysql-performance10.png)

#### Historical Records

Supports viewing detection objects, abnormal/recovery times, and duration.

![image](../img/mysql-performance08.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

![image](../img/mysql-performance09.png)

## Common Issues

**1. How to configure the detection frequency for MySQL Performance Inspection**

* In the self-built DataFlux Func, when writing the custom inspection processing function, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator, then configure it in "Manage / Automatic Trigger Configuration".

**2. Why might MySQL Performance Inspection triggers lack anomaly analysis**

When the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. Under what circumstances does a MySQL Performance Inspection event get generated**

If the configured host experiences a CPU utilization rate consistently exceeding 95% for 10 minutes, memory utilization consistently exceeding 95% for 10 minutes, SQL execution count rising fivefold compared to the previous period, or slow SQL occurrences increasing fivefold compared to the previous period, an alert event is generated.

**4. What to do if errors occur during inspection with previously normal scripts**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the script market via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates of the scripts.

**5. Why does the corresponding script set in Startup remain unchanged during inspection script upgrades**

First, delete the corresponding script set, then click the Upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection has taken effect after enabling**

In "Manage / Automatic Trigger Configuration", check the status of the corresponding inspection. First, the status should be Enabled. Secondly, you can verify the inspection script by clicking Execute. If the message indicates successful execution X minutes ago, the inspection is running normally and taking effect.