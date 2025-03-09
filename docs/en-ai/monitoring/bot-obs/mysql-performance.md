# MySQL Performance Security Check

---

## Background

For increasingly complex application architectures, the current trend is for more and more customers to adopt maintenance-free cloud databases. Therefore, performing a MySQL performance security check is crucial. Regular intelligent security checks on MySQL are conducted to detect performance issues and trigger anomaly alerts.

## Prerequisites

1. Self-host [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) for operations in <<< custom_key.brand_name >>> "Management / API Key Management"

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the current used <<< custom_key.brand_name >>> SaaS [in the same provider and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Security Check

In your self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-hosted Security Check (MySQL Performance)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to enable it.

Select the required security check scenario from the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) settings, then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to and view the corresponding configuration via the provided link.

![image](../img/success_checker.png)

## Configure Security Check

Configure the desired filtering conditions for the security check in the <<< custom_key.brand_name >>> Studio Monitoring - Intelligent Security Check module or in the startup script automatically created by DataFlux Func. Refer to the following two configuration methods.

### Configuration in <<< custom_key.brand_name >>>

![image](../img/mysql-performance02.png)

#### Enable/Disable

MySQL performance security check is set to "Enabled" by default. It can be manually "Disabled". Once enabled, it will perform security checks on the configured host list.

#### Edit

The "MySQL Performance Security Check" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent security check list to edit the security check template.

* Filtering Conditions: Configure the hosts to be checked
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods

Click **Edit** to enter the parameter configuration and fill in the detection objects, then save to start the security check:

![image](../img/mysql-performance03.png)

You can refer to the following example to configure multiple host information

```json
 // Configuration Example:
  configs Configuration Example:
            host1
            host2
            host3
```

> **Note**: In your self-hosted DataFlux Func, when writing custom security check processing functions, you can also add filtering conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the custom security check processing function.

### Configuration in DataFlux Func

After configuring the necessary filtering conditions in DataFlux Func, you can test the configuration by clicking the `run()` method directly on the page. After publishing, the script will run normally. You can also view or modify the configuration in <<< custom_key.brand_name >>> "Monitoring / Intelligent Security Check".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_mysql_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter host, define conditions for matching hosts, return True if matched, False otherwise
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('MySQL Performance Self-hosted Security Check', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    '''
    Optional parameters:
      configs : 
              List of hosts to monitor (optional, defaults to all hosts in the current workspace running Mysql services)
              Multiple hosts can be specified (separated by new lines), unspecified means monitoring all hosts.
      configs Configuration Example:
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

This security check scans memory usage information for the past 6 hours. If it predicts that the threshold will be exceeded within the next 2 hours, it will generate corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent security check list to view related anomaly events.

![image](../img/mysql-performance04.png)

### Event Details Page

Click **Event** to view the details page of the intelligent security check event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon labeled "View Monitor Configuration" in the upper right corner of the details page to view and edit the current intelligent security check configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent security check, it supports copying, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data in `key/value` format.
* Extended Attributes: Selecting extended attributes allows copying and filtering in `key/value` format.

![image](../img/mysql-performance05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly security check event.
* CPU Utilization Line Chart: View the CPU utilization of the current anomaly host over the past 30 minutes.
* Memory Utilization Line Chart: View the memory utilization of the current anomaly host over the past 30 minutes.
* SQL Execution Count Line Chart: View the execution counts of replace, update, delete, insert, and select statements over the past 30 minutes.
* Slow SQL Line Chart: View the occurrences of slow SQL queries over the past 30 minutes.
* SQL Execution Time Ranking: Display the top 5 slow SQL queries and related information for the abnormal MySQL instance, which can be viewed via digest links.

![image](../img/mysql-performance06.png)

![image](../img/mysql-performance07.png)

![image](../img/mysql-performance10.png)

#### Historical Records

Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/mysql-performance08.png)

#### Related Events

Supports viewing related events through selected fields and time component information.

![image](../img/mysql-performance09.png)

## FAQs

**1. How to configure the detection frequency of MySQL Performance Security Check**

* In your self-hosted DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing custom security check processing functions, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis in the MySQL Performance Security Check report**

If the security check report lacks anomaly analysis, check the data collection status of the current `datakit`.

**3. Under what circumstances will MySQL Performance Security Check events be generated**

Events are generated if the CPU utilization of the configured host exceeds 95% for 10 consecutive minutes, memory utilization exceeds 95% for 10 consecutive minutes, SQL execution count increases fivefold compared to the previous period, or slow SQL occurrences increase fivefold compared to the previous period.

**4. What should I do if a previously working script encounters errors during the security check**

Update the referenced script set in the DataFlux Func Script Market. You can view the update history of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates.

**5. Why does the script set in Startup not change during the upgrade of the security check script**

First, delete the corresponding script set, then click the upgrade button and configure the <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the security check has taken effect after enabling**

Check the corresponding security check status in "Management / Automatic Trigger Configuration". The status should be enabled first, and you can verify if the security check script works properly by clicking execute. If it shows "Executed Successfully X minutes ago," the security check is running normally and has taken effect.