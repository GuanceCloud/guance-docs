# Memory leak Intelligent Inspection

---

## Background

"Memory leak" is based on the memory anomaly analysis detector, which regularly checks the host intelligently, analyzes the root cause of the host with memory anomaly, determines the process and pod information corresponding to the abnormal time point, and analyzes whether there is memory leak in the current workspace host.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
3. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (Memory Leak)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/memory-leak02.png)

#### Enable/Disable

Memory leak Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured host list.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent inspection "Memory leak inspection" supports users to manually add filtering conditions, under the operation menu on the right side of the intelligent inspection list, click the "Edit" button, you can edit the inspection template.

* Filter conditions: Configure the host hosts that need to be inspected.
* Alarm notification: support for selecting and editing the alarm policy, including the event level to be notified, the notification object, and the alarm silence period, etc.

Configure the entry parameters and click Edit to fill in the corresponding detection object in the parameter configuration and click Save to start the inspection:

![image](../img/memory-leak03.png)

You can refer to the following to configure multiple host information:

```json
 // Configuration example:
  configs:
          host1
          host2
          host3
```

>  **Note**: In the DataFlux Func, you can also add filtering conditions when writing inspection processing functions (refer to the sample code configuration), it should be noted that the parameters configured in the guance studio will override the parameters configured when writing inspection processing functions.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_memory_leak__main as memory_leak_check

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_host(host):
    '''
    Filter hosts, customize the conditions for meeting the requirements of the host, return True if matched, and return False if not matched.
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('内存泄漏自建巡检', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    '''
可选参数：
  configs : 
          Configure the list of hosts that needs to be checked (optional. If not configured, all host memory leak conditions under the current workspace will be checked by default).
		  Multiple hosts that need to be checked can be specified (concatenated by line breaks). If not configured, all host memory leak conditions under the current workspace will be checked by default...
  configs example：
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

This inspection will scan the memory utilization information of the last 6 hours, and once the abnormal state appears, the intelligent inspection will generate corresponding events, and you can check the corresponding abnormal events by clicking the "View Related Events" button under the operation menu on the right side of the intelligent inspection list.

![image](../img/memory-leak04.png)

### Event Details Page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

* Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
* Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.

#### Basic Properties

* Detection dimension: Based on the filtering conditions configured by Intelligent Inspection, it supports copying and adding the detection dimension `key/value` to the filtering and viewing the related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
* Extended Attributes: Supports `key/value` replication and forward/reverse filtering after selecting extended attributes.

![image](../img/memory-leak05.png)

#### Event Details

* Event overview: Describe the object, content, etc. of the abnormal patrol event.
* Abnormality details: You can view the change of utilization of the current abnormal host in the past 6 hours.
* Abnormality analysis: You can display the list of processes (Pod list) of the Top 10 abnormal host memory usage

![image](../img/memory-leak06.png)

#### History

Support to view the detection object, exception/recovery time and duration.

![image](../img/memory-leak07.png)

#### Related events

Support to view related events through filtering fields and selected time component information.

![image](../img/memory-leak08.png)

## FAQ

**1. How to configure the detection frequency of memory leak Intelligent Inspection**

* In the DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` to the decorator when writing the inspection handler function, and then configure it in the `Management / Auto-trigger Configuration'.

**2. Memory leak Intelligent Inspection may not have exception analysis when triggered**

When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3. An abnormal error was found in a previously running script during the inspection**

Please update the referenced script set in the script marketplace of DataFlux Func. You can check the update log of the script marketplace through [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to update the script instantly.

**4. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the words "executed successfully xxx minutes ago" appear, the inspection is running normally and is effective.

