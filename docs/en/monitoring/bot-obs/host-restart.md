# Host Restart Inspection

---

## Background

Monitoring abnormal host restarts is an important aspect of modern internet system operations. On one hand, the stability and reliability of computer systems are crucial for smooth business operations and user experience. When issues such as abnormal host restarts occur, they can lead to system crashes, service interruptions, and data loss, thereby impacting business operations and customer satisfaction. On the other hand, in cloud computing and virtualized environments, the number and scale of hosts continue to increase, and system complexity is also rising, increasing the likelihood of problems. Therefore, system administrators need to use relevant monitoring tools for real-time monitoring and promptly identify and resolve abnormal restarts. Properly implementing host restart monitoring helps businesses quickly diagnose issues, reduce business risks, improve operational efficiency, and enhance user experience.

## Prerequisites

1. Self-host [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. In <<< custom_key.brand_name >>> "Management / API Key Management," create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the current <<< custom_key.brand_name >>> SaaS deployment on the [same provider and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In your self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-built Inspection (Host Restart)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to enable it.

Select the required inspection scenario in the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configuring Inspection

Configure the desired filtering conditions for inspection in either the <<< custom_key.brand_name >>> Studio under Monitoring - Smart Inspection module or in the startup script automatically created by DataFlux Func. Refer to the two configuration methods below:

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/host-restart02.png)

#### Enable/Disable

Host restart inspection is set to "Enabled" by default and can be manually "Disabled." Once enabled, it will inspect the configured list of hosts.

#### Editing

Smart Inspection "Host Restart Inspection" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the smart inspection list to edit the inspection template.

* Filtering Conditions: Configure the hosts to be inspected.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity, notification targets, and alert mute periods.

Click Edit in the entry parameter configuration and fill in the corresponding detection objects in the parameter configuration, then save and start the inspection:

![image](../img/host-restart03.png)

You can refer to the following configuration for multiple host information:

```
Example configs:
          host1
          host2
          host3
```

> **Note**: In self-hosted DataFlux Func, when writing self-built inspection processing functions, you can add filtering conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those configured in the self-built inspection processing function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions, you can test by selecting the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or modify configurations in <<< custom_key.brand_name >>> "Monitoring / Smart Inspection."

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
  Optional parameters:
    configs : 
            List of hosts to be inspected (optional; defaults to all hosts in the current workspace if not specified)
            Multiple hosts can be specified (separated by new lines); defaults to all hosts in the current workspace if not specified
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

This inspection scans for host restart events within the last 15 minutes. Once a restart occurs, the smart inspection generates the corresponding event. In the operation menu on the right side of the smart inspection list, click the **View Related Events** button to view the corresponding abnormal events.

![image](../img/host-restart04.png)

### Event Details Page

Click **Event** to view the details page of the smart inspection event, including event status, occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the smart inspection, support copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: Selecting extended attributes allows copying in `key/value` format and forward/reverse filtering.

![image](../img/host-restart05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Host Details: View key metrics of the host during the restart period.
* Anomaly Logs: View detailed logs of the current anomaly.

![image](../img/host-restart06.png)

#### History

Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/host-restart07.png)

#### Related Events

Supports viewing related events using filtered fields and selected time components.

![image](../img/host-restart08.png)

#### Related Views

![image](../img/host-restart09.png)

## Common Issues

**1. How to configure the frequency of host restart inspections**

In self-hosted DataFlux Func, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator when writing self-built inspection processing functions, then configure it in "Management / Auto-Trigger Configuration."

**2. Why there might be no anomaly analysis when host restart inspections trigger**

When there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. Previously working scripts fail during inspection**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the script market via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely script updates.

**4. No changes in the script set in Startup during script upgrade**

Delete the corresponding script set first, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API Key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Auto-Trigger Configuration," check the corresponding inspection status. It should be Enabled first, then verify the inspection script by clicking Execute. If it shows "Executed Successfully xxx minutes ago," the inspection is running normally and taking effect.