# Disk Usage Inspection

---

## Background

"Disk Usage Inspection" is based on the disk anomaly analysis detector, which regularly performs intelligent inspections on host disks. It identifies root causes by analyzing hosts with disk anomalies, determining the corresponding disk mount points and disk information at the time of anomaly, and analyzing whether there are disk usage issues in the current workspace hosts.

## Prerequisites

1. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/), or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an [API Key](../../management/api-key/open-api.md) for operations in <<< custom_key.brand_name >>> "Manage / API Key Management"

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current <<< custom_key.brand_name >>> SaaS deployment [in the same location](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Inspection

In the self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-hosted Inspection (Disk Usage)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

Select the inspection scenario you want to enable in the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configure Inspection

Configure the inspection conditions you want to filter in the <<< custom_key.brand_name >>> studio under Monitoring - Intelligent Inspection module or in the startup script automatically created by DataFlux Func. Refer to the following two configuration methods:

### Configuration in <<< custom_key.brand_name >>>

![image](../img/disk-usage02.png)

#### Enable/Disable

Disk usage inspection is enabled by default and can be manually disabled. After enabling, it will inspect the configured list of hosts.

#### Edit

The "Disk Usage Inspection" supports users to manually add filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods

Click the **Edit** button to enter the parameter configuration, fill in the corresponding detection objects, and save to start the inspection:

![image](../img/disk-usage03.png)

You can refer to the following configuration for multiple hosts:

```
Configuration example:
          host1
          host2
          host3
```

> **Note**: In the self-hosted DataFlux Func, when writing the self-hosted inspection processing function, you can also add filtering conditions (refer to the sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> studio will override those configured in the self-hosted inspection processing function.

### Configuration in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions for inspection, you can test by clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or modify configurations in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection".

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
@DFF.API('Self-hosted Disk Usage Inspection', fixed_crontab='0 */6 * * *', timeout=900)
def run(configs=None):
    '''
  Optional parameters:
    configs : 
            List of hosts to be inspected (optional, defaults to all hosts in the current workspace if not configured)
            Multiple hosts can be specified (through newline concatenation), defaults to all hosts in the current workspace if not configured
    Configuration example:
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

This inspection scans disk usage information for the past 14 days. If it detects that the threshold will be exceeded within the next 48 hours, the intelligent inspection will generate corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view the corresponding abnormal events.

![image](../img/disk-usage04.png)

### Event Details Page

Click **Event** to view the details page of the intelligent inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon in the upper right corner of the details page labeled "View Monitor Configuration" to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, support copying detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: Selecting extended attributes allows copying in `key/value` format, forward/reverse filtering.

![image](../img/disk-usage05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View the disk usage for the last 14 days for the currently anomalous disk.
* Anomaly Analysis: Display information about the anomalous host, disk, and mount point to help analyze specific issues.

![image](../img/disk-usage06.png)

#### History

Support viewing detected objects, anomaly/recovery times, and duration.

![image](../img/disk-usage07.png)

#### Related Events

Support viewing related events through filtered fields and selected time component information.

![image](../img/disk-usage08.png)

## Common Issues

**1. How to configure the inspection frequency for disk usage**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 */6 * * *', timeout=900` in the decorator when writing the self-hosted inspection processing function, then configure it in "Manage / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when the disk usage inspection triggers**

If the inspection report does not contain anomaly analysis, please check the data collection status of the current `datakit`.

**3. Previously running scripts may encounter errors during inspection**

Please update the referenced script set in the DataFlux Func Script Market. You can view the update records of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) for timely updates.

**4. No changes in the script set during upgrade**

Delete the corresponding script set first, then click the upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Manage / Automatic Trigger Configuration," check the inspection status. First, it should be enabled, and second, you can validate by clicking Execute to see if the inspection script runs without issues. If it shows "Executed successfully xxx minutes ago," the inspection is functioning properly.