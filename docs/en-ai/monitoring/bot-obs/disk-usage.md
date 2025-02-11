# Disk Usage Inspection

---

## Background

"Disk Usage Inspection" is based on a disk anomaly analysis detector, which regularly performs intelligent inspections of host disks. It analyzes the root cause of hosts with disk anomalies to determine the mount points and disk information corresponding to the anomalous time points, and assesses whether there are disk usage issues in the current workspace's hosts.

## Prerequisites

1. Set up [DataFlux Func (Automata) for Guance](https://func.guance.com/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) for operations in the "Management / API Key Management" section of Guance.

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and in the same region as your current Guance SaaS deployment [here](../../../getting-started/necessary-for-beginners/select-site/).

## Enable Inspection

In your self-hosted DataFlux Func, install "Guance Self-hosted Inspection (Disk Usage)" from the "Script Market" and configure the Guance API Key to enable it.

Select the inspection scenario you want to enable from the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and automatic trigger configuration. You can directly jump to view the corresponding configuration via the provided link.

![image](../img/success_checker.png)

## Configure Inspection

Configure the inspection conditions you want to filter in either the Guance Studio Monitoring - Intelligent Inspection module or the startup script automatically created by DataFlux Func. Refer to the following two configuration methods:

### Configuration in Guance

![image](../img/disk-usage02.png)

#### Enable/Disable

Disk Usage Inspection is enabled by default. You can manually disable it. Once enabled, it will inspect the configured list of hosts.

#### Edit

The "Disk Usage Inspection" under Intelligent Inspection supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert mute periods.

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../img/disk-usage03.png)

You can refer to the following example for configuring multiple hosts:

```
Configuration Example:
          host1
          host2
          host3
```

> **Note**: In your self-hosted DataFlux Func, you can also add filtering conditions when writing custom inspection handling functions (refer to sample code configuration). Note that parameters configured in the Guance Studio will override those set in the custom inspection handling function.

### Configuration in DataFlux Func

In DataFlux Func, after configuring the necessary filtering conditions for inspection, you can test the script by clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or modify the configuration in the Guance "Monitoring / Intelligent Inspection".

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
  Optional Parameters:
    configs : 
            List of hosts to inspect (optional; if not configured, it defaults to all hosts in the current workspace)
            Multiple hosts can be specified (separated by new lines); if not configured, it defaults to all hosts in the current workspace
    Configuration Example:
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

This inspection scans disk usage information for the past 14 days. If it predicts that usage will exceed the warning threshold within the next 48 hours, it will generate corresponding events. In the intelligent inspection list, click the **View Related Events** button in the operation menu on the right to view the corresponding anomaly events.

![image](../img/disk-usage04.png)

### Event Details Page

Clicking **Event**, you can view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, you can copy, add to filters, and view related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data in `key/value` format.
* Extended Attributes: Select extended attributes to copy, forward/reverse filter in `key/value` format.

![image](../img/disk-usage05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly inspection event.
* Anomaly Details: View the disk usage over the past 14 days for the current anomalous disk.
* Anomaly Analysis: Displays information about the anomalous host, disk, and mount point to help analyze specific issues.

![image](../img/disk-usage06.png)

#### Historical Records

Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/disk-usage07.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

![image](../img/disk-usage08.png)

## Common Issues

**1. How to configure the inspection frequency of Disk Usage Inspection**

* In your self-hosted DataFlux Func, add `fixed_crontab='0 */6 * * *', timeout=900` in the decorator when writing custom inspection handling functions, and configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when Disk Usage Inspection triggers**

If there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. What to do if a previously working script fails during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update records of the Script Market [here](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates to the script.

**4. Why does the script set in Startup not change during script upgrade**

Delete the corresponding script set first, then click the Upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration", check the inspection status. First, the status should be Enabled, and second, you can verify if the inspection script runs correctly by clicking Execute. If it shows "Executed Successfully xxx minutes ago," the inspection is running normally.