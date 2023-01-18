# Memory Leak Check

---

## Background

"Memory leak" is based on the memory anomaly analysis detector, which regularly checks the host intelligently, analyzes the root cause of the host with memory anomaly, determines the process and pod information corresponding to the abnormal time point, and analyzes whether there is memory leak in the current workspace host.

## Preconditions

1. Offline deployment of self-built DataFlux Func
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func 
3. Create [API Key](../../management/api-key/open-api.md) in the Guance Cloud "management/API Key management" 
4. In the self-built DataFlux Func, install "Guance Cloud Self-built Check Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Self-built Check (Memory Leak)" through "Script Market"
5. In the DataFlux Func, write the self-built check processing function
6. In the self-built DataFlux Func, create auto-trigger configurations for the functions you write through "Manage/Auto-trigger Configurations."

## Configuration Check

Create a new script set in the self-built DataFlux Func to start the memory leak check configuration.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_memory_leak__main as memory_leak_check

# Account Configuration
API_KEY_ID  = 'wsak_xxx'
API_KEY     = 'wsak_xxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent check configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\intelligent check. If both sides are configured, the filters parameter in the script will take effect first.

def filter_host(host):
    '''
    Filter host, customize the conditions that meet the requirements of host, return True for matching, and return False for mismatching
    return True｜False
    '''
    if host in ['iZuf6aq9gu32lpgvx8ynhbZ']:
        return True

'''
Task configuration parameters use:
@DFF.API('memory leak check', fixed_crontab='0 * * * *', timeout=900)

fixed_crontab: Fixed execution frequency "once per hour"
timeout: Task execution timeout, controlled at 15 minutes
'''

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('memory leak check', fixed_crontab='0 * * * *', timeout=900)
def run(configs={}):
    '''
    Parameters:
    configs : Configure the list of hosts to be detected (optional, do not configure default detection of all hosts in the current workspace)

    Example:
        configs = {
            "hosts": ["localhost"]
        }
    '''
    checkers = [
        memory_leak_check.MemoryLeakCheck(configs=configs, filters=[filter_host]), # example here
    ]

    Runner(checkers, debug=False).run()
```

## Start Check

### Register a Detectioan Item in Guance Cloud

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in the Guance Cloud "Monitoring/Intelligent Check".

![image](../img/memory-leak01.png)


### Configure Memory Leak Check in Guance Cloud

![image](../img/memory-leak02.png)

#### Enable/Disable

Memory leak check is "on" by default, and can be "off" manually. After being turned on, the configured host list will be inspected.

#### Export

Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.

#### Edit

Intelligent check "Memory Leak Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: Configure hosts that need to be checked
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/memory-leak03.png)

You can refer to the following JSON to configure multiple host information:

```json
 // Configuration example:
  configs = {
        "hosts": ["localhost"]
    }
```

>  **Note**: In the self-built DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance Cloud studio will override the parameters configured when writing the intelligent inspection processing function.

## View Events

This detection will scan the memory utilization information in the last 6 hours. Once the warning value will be exceeded in the next 2 hours, the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/memory-leak04.png)

### Event Details Page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Attributes

* Detection Dimensions: Filter criteria based on intelligent check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/memory-leak05.png)

#### Event Details

* Event Overview: Describe the objects, contents of abnormal check events.
* Exception details: You can view the utilization changes of the current exception host in the past 6 hours.
* Exception analysis: Top 10 process list (Pod list) that can display abnormal host memory usage

![image](../img/memory-leak06.png)

#### History

Support to view detection objects, exception/recovery time and duration.

![image](../img/memory-leak07.png)

#### Associated Events

Support to view associated events by filtering fields and selected time component information.

![image](../img/memory-leak08.png)

## FAQ

**1.How to configure the detection frequency of memory leak check**

* In the self-built DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2.Memory leak check may be triggered without exception analysis**

Check the current data collection status of `datakit` when there is no anomaly analysis in the detection report.
