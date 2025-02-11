# Memory Leak Inspection

---

## Background

"Memory Leak" is based on a memory anomaly detector that regularly performs intelligent inspections of hosts. It analyzes the root cause by identifying processes and pod information corresponding to abnormal time points, determining whether there is a memory leak issue in the current workspace's hosts.

## Prerequisites

1. Set up [DataFlux Func (Automata) for Guance](https://func.guance.com/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an API Key for operations in the "Management / API Key Management" section of Guance [API Key](../../management/api-key/open-api.md)

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the same operator and region as the currently used Guance SaaS deployment [in the same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Inspection

In your self-hosted DataFlux Func, install "Guance Self-hosted Inspection (Memory Leak)" via the "Script Market" and configure the Guance API Key to enable it.

Select the desired inspection scenario from the DataFlux Func Script Market, click install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configure Inspection

Configure the inspection filters in the Intelligent Inspection module of Guance Studio or in the startup script automatically created by DataFlux Func. You can refer to the following two configuration methods:

### Configuration in Guance

![image](../img/memory-leak02.png)

#### Enable/Disable

The memory leak inspection is default set to "Enabled". You can manually "Disable" it. Once enabled, it will inspect the configured list of hosts.

#### Edit

The "Memory Leak Inspection" supports manual addition of filter conditions. Click the **Edit** button under the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filter Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selection and editing of alert policies, including event severity levels, notification targets, and alert silence periods.

To configure entry parameters, click edit and fill in the corresponding detection objects in the parameter configuration, then save to start the inspection:

![image](../img/memory-leak03.png)

You can reference the configuration of multiple host information as follows:

```json
// Configuration example:
configs Configuration example:
        host1
        host2
        host3
```

> **Note**: In the self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filter conditions (refer to the sample code configuration). Note that the parameters configured in Guance Studio will override those configured in the custom inspection handling function.

### Configuration in DataFlux Func

After configuring the necessary filter conditions in DataFlux Func, you can test by clicking the `run()` method directly on the page. After clicking publish, the script will run normally. You can also view or modify configurations in the "Monitoring / Intelligent Inspection" section of Guance.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_memory_leak__main as memory_leak_check

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter host, define conditions for matching hosts, return True if matched, False otherwise.
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('Self-hosted Memory Leak Inspection', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    '''
Optional Parameters:
  configs : 
          List of hosts to inspect (optional, defaults to inspecting all hosts in the current workspace for memory leaks).
          Multiple hosts can be specified (separated by new lines), defaults to inspecting all hosts in the current workspace for memory leaks.
  configs Configuration example:
          host1
          host2
          host3
    '''
    checkers = [
        memory_leak_check.MemoryLeakCheck(configs=configs, filters=[filter_host]),  # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## View Events

This inspection scans memory usage data from the last 6 hours. When an anomaly is detected, the intelligent inspection generates corresponding events. Under the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/memory-leak04.png)

### Event Details Page

Click **Event** to view the details page of the intelligent inspection event, including event status, time of occurrence, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon in the top-right corner of the details page labeled "View Monitor Configuration" to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filter conditions configured in the intelligent inspection, support copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../img/memory-leak05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly inspection event.
* Anomaly Details: View the usage rate changes over the past 6 hours for the current anomalous host.
* Anomaly Analysis: Displays the Top 10 process lists (Pod lists) consuming the most memory on the anomalous host.

![image](../img/memory-leak06.png)

#### History

Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../img/memory-leak07.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

![image](../img/memory-leak08.png)

## Common Issues

**1. How to configure the inspection frequency for memory leak detection**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the custom inspection handling function, then configure it in "Management / Automatic Trigger Configuration".

**2. No anomaly analysis in the memory leak inspection report**

When the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. Previously running scripts fail during inspection**

Update the referenced script set in the DataFlux Func Script Market. Refer to the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to view the update records of the script market for timely updates.

**4. Startup script set remains unchanged during upgrade**

Delete the corresponding script set first, then click the upgrade button and configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration", check the inspection status. The status should be enabled, and you can validate the script by clicking execute. If it shows "Executed successfully xx minutes ago," the inspection is running normally.