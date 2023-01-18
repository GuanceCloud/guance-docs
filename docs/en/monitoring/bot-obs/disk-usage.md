# Disk Utilization Check

---

## Background

Based on the disk anomaly analysis detector, "Disk Utilization Check" regularly conducts intelligent inspection on the host disk, analyzes the root cause of the host with disk anomaly, determines the disk mount point and disk information corresponding to the abnormal time point, and analyzes whether there is disk utilization problem in the current workspace host.

## Preconditions

1. Offline deployment of self-built DataFlux Func
2. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func 
3. Create [API Key](../../management/api-key/open-api.md) in the Guance Cloud "management/API Key management" 
4. In the self-built DataFlux Func, install "Guance Cloud Self-built Detection Core Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Self-built Detection (Disk Utilization)" through "Script Market"
5. In the DataFlux Func, write the self-built patrol processing function
6. In the self-built DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

## Configuration Detection

Create a new script set in the self-built DataFlux Func to start the disk utilization detection configuration.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_disk_usage__main as disk_usage_check

# Account Configuration
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'wsak_xxxxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent detection configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\intelligent detection. If both sides are configured, the filters parameter in the script will take effect first.

def filter_host(host):
    '''
    Filter host, customize the conditions that meet the requirements of host, return True for matching, and return False for mismatching
    return True｜False
    '''
    if host == "iZuf609uyxtf9dvivdpmi6Z":
        return True

'''
Task configuration parameters use:
@DFF.API('Self-built detection of disk utilization rate', fixed_crontab='0 */6 * * *', timeout=900)

fixed_crontab: Fixed execution frequency "every 6 hours"
timeout: Task execution timeout, controlled at 15 minutes
'''

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Disk utilization detection', fixed_crontab='0 */6 * * *', timeout=900)
def run(configs={}):
    '''
    Parameters:
    configs : Configure the list of hosts to be detected (optional, do not configure default detection of all host disks in the current workspace)

    Example:
        configs = {
            "hosts": ["localhost"]
        }
    '''
    checkers = [
        disk_usage_check.DiskUsageCheck(configs=configs, filters=[filter_host]), # example here
    ]

    Runner(checkers, debug=False).run()
```

## Start Detection

### Register a Detection Item in Guance Cloud

In DataFlux Func, after the detection is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance Cloud "Monitoring/Intelligent Patrol".

![image](../img/disk-usage01.png)


### Configure Disk Usage Surveys in Guance Cloud

![image](../img/disk-usage02.png)

#### Enable/Disable

The disk utilization detection is "on" by default, and can be "off" manually. After being turned on, the configured host list will be detected.

#### Export

Intelligent detection supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent detection list, click the "Export" button to export the json code of the current detection, and export the file name format: intelligent detection name. json.

#### Edit

Intelligent detection "Disk Usage Detection" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent detection list, click the "Edit" button to edit the detection template.

* Filter criteria: Configure hosts that need to be patrolled
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period
  
Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start detection:

![image](../img/disk-usage03.png)

You can refer to the following JSON to configure multiple host information.

```json
 // Configuration example:
  configs = {
        "hosts": ["localhost"]
    }
```

>  **Note**: In the custom DataFlux Func, filter conditions can also be added when writing the custom patrol processing function (refer to the sample code configuration). Note that the parameters configured in the Guance Cloud studio will override the parameters configured when writing the custom detection processing function.

## View Events

This detection will scan the disk utilization information in the last 14 days. Once the warning value will be exceeded in the next 48 hours, the intelligent detection will generate corresponding events. Under the operation menu on the right side of the intelligent detection list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/disk-usage04.png)

### Event Details Page

Click "Event" to view the details page of intelligent detection events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent detection
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Attributes

* Detection Dimensions: Filter criteria based on smart detection configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security check, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/disk-usage05.png)

#### Event Details

* Event Overview: Describes the objects, contents, etc. of abnormal inspection events.
* Exception details: You can view the usage rate of the current exception disk in the past 14 days.
* Exception analysis: It can display abnormal host, disk and mount point information to help analyze specific problems.

![image](../img/disk-usage06.png)

#### History

Support to view detection objects, exception/recovery time and duration.

![image](../img/disk-usage07.png)

#### Associated Events

Support to view associated events by filtering fields and selected time component information.

![image](../img/disk-usage08.png)

## FAQ

**1.How to configure the detection frequency of disk utilization detection**

* In the self-built DataFlux Func, add `fixed_crontab='0 */6 * * *', timeout=900` in the decorator when writing the self-built detection processing function, and then configure it in "admin/auto-trigger configuration".

**2.There may be no exception analysis when the disk usage detection is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the detection report.

