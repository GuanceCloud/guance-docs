# Memory Leak Inspection

---

## Background

"Memory leak" is based on the memory anomaly analysis detector, which periodically performs intelligent inspections on hosts. By analyzing hosts with memory anomalies, it determines the processes and pod information corresponding to the anomalous time points, and analyzes whether there are any memory leaks in the current workspace hosts.

## Prerequisites

1. Set up a [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. In <<< custom_key.brand_name >>> "Management / API Key Management", create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed in the [same provider and region](../../../getting-started/necessary-for-beginners/select-site/) as your current <<< custom_key.brand_name >>> SaaS deployment.

## Enabling Inspection

In your self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-hosted Inspection (Memory Leak)" from the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configuring Inspection

In the <<< custom_key.brand_name >>> Studio Monitoring - Intelligent Inspection module or in the startup script automatically created by DataFlux Func, configure the inspection conditions you want to filter. Refer to the following two configuration methods:

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/memory-leak02.png)

#### Enable/Disable

The memory leak inspection is enabled by default. It can be manually disabled. Once enabled, it will inspect the configured list of hosts.

#### Editing

The "Memory Leak Inspection" supports users to manually add filtering conditions. In the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods.

To configure entry parameters, click Edit and fill in the corresponding detection objects in the parameter configuration, then save and start the inspection:

![image](../img/memory-leak03.png)

You can refer to the following configuration for multiple host information:

```json
// Configuration example:
configs Configuration example:
        host1
        host2
        host3
```

> **Note**: In your self-hosted DataFlux Func, when writing the self-hosted inspection processing function, you can also add filtering conditions (refer to the sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the self-hosted inspection processing function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions for inspection, you can test by selecting the `run()` method directly on the page and clicking Run. After clicking Publish, the script will execute normally. You can also view or modify the configuration in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_memory_leak__main as memory_leak_check

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter host, define conditions for hosts that match, return True for matches, False for non-matches
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('Self-hosted Memory Leak Inspection', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    '''
Optional parameters:
  configs : 
          List of hosts to inspect (optional, defaults to all hosts in the current workspace if not configured)
          Multiple hosts can be specified (separated by new lines), defaults to all hosts in the current workspace if not configured...
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

## Viewing Events

This inspection scans memory usage information from the last 6 hours. When an abnormal state occurs, the intelligent inspection generates corresponding events. In the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding abnormal events.

![image](../img/memory-leak04.png)

### Event Details Page

Clicking **Event**, you can view the details page of the intelligent inspection event, including event status, time of occurrence, anomaly name, basic attributes, event details, alert notifications, history records, and associated events.

* Click the small icon "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, supports copying detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM PV, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to support copying in `key/value` form, forward/reverse filtering.

![image](../img/memory-leak05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View the usage rate changes over the past 6 hours for the currently abnormal host.
* Anomaly Analysis: Displays the Top 10 process lists (Pod lists) occupying memory on the abnormal host.

![image](../img/memory-leak06.png)

#### History Records

Supports viewing the detected objects, anomaly/recovery times, and duration.

![image](../img/memory-leak07.png)

#### Associated Events

Supports viewing associated events through filtered fields and selected time component information.

![image](../img/memory-leak08.png)

## Common Issues

**1. How to configure the detection frequency of memory leak inspection**

* In your self-hosted DataFlux Func, when writing the self-hosted inspection processing function, add `fixed_crontab='0 * * * *', timeout=900` in the decorator, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when memory leak inspection triggers**

If there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. Encountering abnormal errors in previously running scripts during inspection**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the script market via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates of scripts.

**4. No changes in the script set in Startup during script upgrade**

First delete the corresponding script set, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration", check the corresponding inspection status. First, the status should be enabled; secondly, you can validate the inspection script by clicking Execute. If it shows "Executed Successfully xxx minutes ago," the inspection is running normally and has taken effect.