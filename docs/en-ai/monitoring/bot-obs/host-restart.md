# Host Restart Inspection

---

## Background

Monitoring abnormal host restarts is a crucial aspect of modern internet system operations. On one hand, the stability and reliability of computer systems are essential for smooth business operations and user experience. When issues like abnormal host restarts occur, they can lead to system crashes, service interruptions, and data loss, thereby impacting business operations and user satisfaction. On the other hand, in cloud computing and virtualized environments, the number and scale of hosts continue to grow, increasing system complexity and the likelihood of problems. This necessitates that system administrators use relevant monitoring tools for real-time monitoring and timely detection and resolution of abnormal restarts. Therefore, implementing effective host restart monitoring helps businesses quickly diagnose issues, reduce operational risks, improve operational efficiency, and enhance user experience.

## Prerequisites

1. Set up [DataFlux Func (Guance Special Edition)](https://func.guance.com/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) in Guance under "Management / API Key Management"

> **Note**: If you plan to deploy DataFlux Func offline using a cloud server, consider deploying it with the current SaaS deployment of Guance on the [same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In your self-hosted DataFlux Func, install the "Self-hosted Inspection (Host Restart)" script from the "Script Market" and configure the Guance API Key to enable it.

Select the inspection scenario you want to enable in the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configuring Inspection

Configure the inspection conditions you want to filter in the Guance Studio Monitoring - Smart Inspection module or in the startup script automatically created by DataFlux Func. Refer to the following two configuration methods:

### Configuring Inspection in Guance

![image](../img/host-restart02.png)

#### Enable/Disable

Host restart inspection is enabled by default. It can be manually disabled. Once enabled, it will inspect the configured list of hosts.

#### Editing

The "Host Restart Inspection" feature supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the smart inspection list to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

Click Edit in the configuration entry parameters and fill in the corresponding inspection objects in the parameter configuration, then save and start the inspection:

![image](../img/host-restart03.png)

You can reference the following configuration for multiple hosts:

```
Example configs:
          host1
          host2
          host3
```

> **Note**: In your self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to example code configuration). Note that parameters configured in the Guance Studio will override those set in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

After configuring the required filtering conditions in DataFlux Func, you can test the script by clicking the `run()` method directly on the page. After publishing, the script will execute normally. You can also view or change the configuration in the Guance "Monitoring / Smart Inspection" section.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_host_restart__main as host_restart

def filter_host(host):
  '''
  Filter host by defining custom conditions that meet the requirements. If a match is found, return True. If no match is found, return False.
  return True | False
  '''
  if host == "iZuf609uyxtf9dvivdpmi6z":
    return True
  
 
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('Host Restart Inspection', fixed_crontab='*/15 * * * *', timeout=900)
def run(configs=None):
    '''
  Optional Parameters:
    configs : 
            List of hosts to inspect (optional; if not configured, defaults to all hosts in the current workspace)
            Multiple hosts can be specified (using newline separation); if not configured, defaults to all hosts in the current workspace
    Example configs:
            host1
            host2
            host3
    '''
    checkers = [
        host_restart.HostRestartChecker(configs=configs, filters=[filter_host]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

This inspection scans for host restart events within the last 15 minutes. Once a restart occurs, the smart inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the smart inspection list to view the associated abnormal events.

![image](../img/host-restart04.png)

### Event Details Page

Click **Event** to view the details page of the smart inspection event, including event status, time of occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the smart inspection, support copying, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data in `key/value` format.
* Extended Attributes: Selecting extended attributes allows copying in `key/value` format and forward/reverse filtering.

![image](../img/host-restart05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Host Details: View key metrics of the host during the restart period.
* Anomaly Logs: View detailed information about the current anomaly logs.

![image](../img/host-restart06.png)

#### Historical Records

Support viewing the detected object, anomaly/recovery times, and duration.

![image](../img/host-restart07.png)

#### Related Events

Support viewing related events through filtering fields and selected time component information.

![image](../img/host-restart08.png)

#### Related Views

![image](../img/host-restart09.png)

## Common Issues

**1. How to configure the inspection frequency for host restarts**

In your self-hosted DataFlux Func, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator when writing the custom inspection handling function, then configure it in "Management / Automatic Trigger Configuration".

**2. No anomaly analysis in the host restart inspection report**

If there is no anomaly analysis in the inspection report, check the current `datakit` data collection status.

**3. Previously normal scripts encounter errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can check the update records of the script market via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script updates.

**4. Startup script set does not change during inspection script upgrade**

First delete the corresponding script set, then click the upgrade button and configure the corresponding Guance API Key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

Check the corresponding inspection status in "Management / Automatic Trigger Configuration". The status should be enabled first, then verify the inspection script by clicking Execute. If it shows "Executed successfully X minutes ago," the inspection is running normally and has taken effect.