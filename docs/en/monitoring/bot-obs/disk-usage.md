# Disk utilization Intelligent Inspection

---

## Background

「Disk utilization Intelligent Inspection」 is based on the disk exception analysis detector. It regularly performs intelligent patrols on the host disk. It analyzes the root cause of the host with disk exceptions, determines the disk mount point and disk information corresponding to the time point of the exception, and analyzes whether the current workspace host has disk usage problems.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
3. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (Disk Usage Rate)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/disk-usage02.png)

#### Enable/Disable

APM Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured Disk.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Inspection supports users to manually add filtering conditions, and click the "Edit" button under the operation menu on the right side of the Intelligent Inspection list to edit the inspection template.

* Filter conditions: Configure the host hosts that need to be inspected.
* Alarm notification: support for selecting and editing the alarm policy, including the event level to be notified, the notification object, and the alarm silence period, etc.

Configure the entry parameters and click Edit to fill in the corresponding detection object in the parameter configuration and click Save to start the inspection.

![image](../img/disk-usage03.png)

You can refer to the following to configure multiple host information

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
import guance_monitor_disk_usage__main as disk_usage_check

def filter_host(host):
  '''
  Filter host by defining custom conditions that meet the requirements. If a match is found, return True. If no match is found, return False.
  return True | False
  '''
  if host == "iZuf609uyxtf9dvivdpmi6z":
    return True
  
 
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('磁盘使用率自建巡检', fixed_crontab='0 */6 * * *', timeout=900)
def run(configs=None):
    '''
  Optional parameters：
    configs : 
            Configure the list of hosts that needs to be checked (optional. If not configured, all host disks under the current workspace will be checked by default).
			Multiple hosts that need to be checked can be specified (concatenated by line breaks). If not configured, all host disks under the current workspace will be checked by default.
    configs example：
            host1
            host2
            host3
    '''
    checkers = [
        disk_usage_check.DiskUsageCheck(configs=configs, filters=[filter_host]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



## View Events

This inspection will scan the disk utilization information of the last 14 days, and once it appears that the warning value will be exceeded in the next 48 hours, the intelligent inspection will generate corresponding events, and you can check the corresponding abnormal events by clicking the "View Related Events" button under the operation menu on the right side of the intelligent inspection list.

![image](../img/disk-usage04.png)

### Event Details Page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

* Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
* Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.

#### Basic Properties

* Detection dimension: Based on the filtering conditions configured by Intelligent Inspection, it supports copying and adding the detection dimension `key/value` to the filtering and viewing the related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
* Extended Attributes: Supports `key/value` replication and forward/reverse filtering after selecting extended attributes.

![image](../img/disk-usage05.png)

#### Event Details

* Event Overview: Describes the object, content, etc. of the exception patrol event.
* Exception details: You can view the utilization rate of the current abnormal disk for the past 14 days.
* Abnormality Analysis: You can display abnormal host, disk, and mount point information to help analyze specific problems.

![image](../img/disk-usage06.png)

#### History

Support to view the detection object, exception/recovery time and duration.

![image](../img/disk-usage07.png)

#### Related events

Support to view related events through filtering fields and selected time component information.

![image](../img/disk-usage08.png)

## FAQ

**1. How to configure the detection frequency of Disk utilization Intelligent Inspection**

* In the DataFlux Func, add `fixed_crontab='0 */6 * * *', timeout=900` to the decorator when writing the patrol processing function, and then configure it in `Management / Auto-trigger Configuration'.

**2. Disk utilization Intelligent Inspection may not have exception analysis when triggered**

When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3. An abnormal error was found in a script that used to run normally during the inspection**

Please update the referenced script set in the script marketplace of DataFlux Func. You can check the update log of the script marketplace through [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to update the script instantly.

**4. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the words "executed successfully xxx minutes ago" appear, the inspection is running normally and is effective.
