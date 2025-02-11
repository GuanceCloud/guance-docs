# MySQL Performance Inspection

---

## Background

As application architectures become increasingly complex, more and more customers are opting for managed cloud databases to avoid operational overhead. Therefore, inspecting the performance of MySQL is crucial. Regular intelligent inspections of MySQL help identify performance issues early, enabling timely alerts.

## Prerequisites

1. Set up [DataFlux Func (Automata) Guance Special Edition](https://func.guance.com/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) in the Guance "Management / API Key Management" section for performing operations.

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, ensure it is deployed with the same operator and region as your current Guance SaaS deployment [in the same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Initiating Inspection

In your self-hosted DataFlux Func, install the "Guance Self-Hosted Inspection (MySQL Performance)" script from the "Script Market" and configure the Guance API Key to start the inspection.

Select the required inspection scenario in the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configuring Inspection

You can configure the inspection filters either in the Guance Studio under Monitoring - Intelligent Inspection or in the startup script automatically created by DataFlux Func. Refer to the following two configuration methods.

### Configuring Inspection in Guance

![image](../img/mysql-performance02.png)

#### Enable/Disable

The MySQL performance inspection is enabled by default but can be manually disabled. Once enabled, it will inspect the configured list of hosts.

#### Editing

The "MySQL Performance Inspection" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

Click Edit in the parameter configuration entry, fill in the corresponding detection objects, and save to start the inspection:

![image](../img/mysql-performance03.png)

You can refer to the following configuration for multiple host information:

```json
// Configuration example:
  configs:
        host1
        host2
        host3
```

> **Note**: In your self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to sample code configurations). However, parameters configured in the Guance Studio will override those set in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

After configuring the necessary filtering conditions in DataFlux Func, you can test by selecting the `run()` method on the page and clicking Run. After publishing, the script will execute normally. You can also view or change the configuration in the Guance "Monitoring / Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_mysql_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter host, define conditions for matching hosts, return True if matched, False otherwise.
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('Self-Hosted MySQL Performance Inspection', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    '''
    Optional parameters:
      configs : 
              List of hosts to inspect (optional; if not configured, it defaults to all hosts in the current workspace running MySQL services).
        	  Multiple hosts can be specified (separated by line breaks); if not specified, all hosts running MySQL services will be inspected.
      Example configuration:
              host1
              host2
              host3
    '''
    checkers = [
        main.MysqlChecker(configs=configs, filters=[filter_host]), # Supports user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

This inspection scans memory usage over the past 6 hours. If it predicts that usage will exceed the warning threshold within the next 2 hours, it generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view related anomaly events.

![image](../img/mysql-performance04.png)

### Event Details Page

Click **Event** to view the detailed page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and associated events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, support copying, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data in `key/value` format.
* Extended Attributes: Select extended attributes to copy in `key/value` format and perform forward/reverse filtering.

![image](../img/mysql-performance05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* CPU Utilization Line Chart: View the CPU utilization rate of the current abnormal host over the past 30 minutes.
* Memory Utilization Line Chart: View the memory utilization rate of the current abnormal host over the past 30 minutes.
* SQL Execution Count Line Chart: View the execution counts of replace, update, delete, insert, and select statements on the current abnormal host over the past 30 minutes.
* Slow SQL Line Chart: View the number of slow SQL queries detected on the current abnormal host over the past 30 minutes.
* Top 5 Slow SQL Ranking: Display the top 5 slow SQL queries and related information for the abnormal MySQL, allowing navigation to related logs via digest.

![image](../img/mysql-performance06.png)

![image](../img/mysql-performance07.png)

![image](../img/mysql-performance10.png)

#### Historical Records

Supports viewing the detection object, anomaly/recovery times, and duration.

![image](../img/mysql-performance08.png)

#### Associated Events

Supports viewing associated events through filtered fields and selected time components.

![image](../img/mysql-performance09.png)

## Common Issues

**1. How to Configure the Inspection Frequency for MySQL Performance**

* In your self-hosted DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing custom inspection handling functions, and configure it in "Management / Automatic Trigger Configuration".

**2. Why Might There Be No Anomaly Analysis When the Inspection Triggers**

If no anomaly analysis appears in the inspection report, check the data collection status of the current `datakit`.

**3. Under What Circumstances Will MySQL Performance Inspection Events Be Generated**

Events are generated if the configured hosts experience CPU utilization consistently exceeding 95% for 10 minutes, memory utilization consistently exceeding 95% for 10 minutes, SQL execution counts increasing fivefold compared to the previous period, or slow SQL occurrences increasing fivefold compared to the previous period.

**4. What to Do If Previously Normal Scripts Fail During Inspection**

Update the referenced script sets in the DataFlux Func Script Market. Refer to the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to check the update history of the script market for timely updates.

**5. What to Do If the Script Set in Startup Does Not Change During Upgrade**

Delete the corresponding script set first, then click the upgrade button and configure the corresponding Guance API Key to complete the upgrade.

**6. How to Verify That the Inspection Has Taken Effect After Enabling**

Check the inspection status in "Management / Automatic Trigger Configuration". It should be enabled, and you can verify the script by executing it. If it shows "Executed Successfully xx Minutes Ago," the inspection is functioning correctly.