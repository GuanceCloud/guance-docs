# Memory Leak Inspection

---

## Background

"Memory leak" is based on the memory anomaly analysis detector, which regularly performs intelligent inspections on HOSTs. By identifying HOSTs with memory anomalies, it conducts root cause analysis to determine the corresponding processes and pod information at the anomalous time points, analyzing whether there are any memory leakage issues in the current workspace's HOSTs.

## Prerequisites

1. Self-built [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In <<< custom_key.brand_name >>> "Manage / API Key Management", create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, ensure it is deployed with the current used <<< custom_key.brand_name >>> SaaS under the [same operator and same region](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In the self-built DataFlux Func, install "<<< custom_key.brand_name >>> Self-built Inspection (Memory Leak)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to activate it.

In the DataFlux Func Script Market, select the desired inspection scenario to click and install. After configuring the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and automatic trigger configuration, allowing direct navigation to the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configuring Inspection

In the <<< custom_key.brand_name >>> studio Monitoring - Intelligent Inspection module or in the automatically created startup script of DataFlux Func, configure the filtering conditions for the inspection as desired. Refer to the two configuration methods below.

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/memory-leak02.png)

#### Enable/Disable

The memory leak inspection is by default "enabled". It can be manually "disabled". Once enabled, it will inspect the configured list of HOSTs.

#### Editing

The intelligent inspection "memory leak inspection" supports users adding manual filter conditions. Under the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filter Conditions: Configure the HOSTs that need to be inspected.
* Alert Notifications: Supports selecting and editing alert strategies, including event levels to notify, notification targets, and alert mute cycles.

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../img/memory-leak03.png)

You can refer to the following configuration for multiple HOSTs information.

```json
 // Configuration example:
  configs Configuration example:
          host1
          host2
          host3
```

> **Note**: In the self-built DataFlux Func, when writing the self-built inspection processing function, you can also add filter conditions (refer to the sample code configuration). Note that the parameters configured in <<< custom_key.brand_name >>> studio will override the parameters configured in the self-built inspection processing function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filter conditions for the inspection, you can directly select the `run()` method on the page to test by clicking Run. After clicking Publish, the script will run normally. You can also view or modify the configuration in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_memory_leak__main as memory_leak_check

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter host, define conditions for hosts that meet requirements, return True for matching, False otherwise.
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('Memory Leak Self-Built Inspection', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    '''
Optional Parameters:
  configs : 
          List of HOSTs to inspect (optional, defaults to inspecting all HOSTs in the current workspace for memory leaks).
          You can specify multiple HOSTs to inspect (separated by new lines), default inspects all HOSTs in the current workspace for memory leaks...
  configs Configuration Example:
          host1
          host2
          host3
    '''
    checkers = [
        memory_leak_check.MemoryLeakCheck(configs=configs, filters=[filter_host]),  # Support for user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

This inspection scans memory usage information from the last 6 hours. When an abnormal state occurs, the intelligent inspection generates corresponding events. Under the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding abnormal events.

![image](../img/memory-leak04.png)

### Event Details Page

Click **Event**, to view the details page of the intelligent inspection event, including event status, time of occurrence of the anomaly, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon in the upper right corner of the details page labeled "View Monitor Configuration" to view and edit the current intelligent inspection configuration details.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, supports copying the detection dimension `key/value`, adding to filters, and viewing relevant LOGs, CONTAINERS, processes, security checks, traces, RUM PV, Synthetic Tests, and CI data.
* Extended Attributes: Selecting extended attributes allows copying in `key/value` form, forward/reverse filtering.

![image](../img/memory-leak05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View the usage rate changes of the current abnormal HOST over the past 6 hours.
* Anomaly Analysis: Displays the Top 10 process lists (Pod lists) occupying the memory of the abnormal HOST.

![image](../img/memory-leak06.png)

#### Historical Records

Supports viewing the detection object, abnormal/recovery times, and duration.

![image](../img/memory-leak07.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

![image](../img/memory-leak08.png)

## Common Issues

**1. How to configure the detection frequency of memory leak inspections**

* In the self-built DataFlux Func, when writing the self-built inspection processing function, add `fixed_crontab='0 * * * *', timeout=900` in the decorator, then configure it in "Manage / Automatic Trigger Configuration."

**2. Why might there be no anomaly analysis when the memory leak inspection triggers**

When the inspection report lacks anomaly analysis, check the data collection status of the current `datakit`.

**3. During the inspection process, why does a previously normal script show abnormal errors**

Update the referenced script set in the DataFlux Func Script Market. You can view the update record of the script market through the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates of the script.

**4. During the upgrade of the inspection script, why does the corresponding script set in Startup show no changes**

First delete the corresponding script set, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Manage / Automatic Trigger Configuration", view the status of the corresponding inspection. First, the status should be enabled, secondly, verify if the inspection script works by clicking Execute. If the message indicates successful execution xxx minutes ago, the inspection is running properly.