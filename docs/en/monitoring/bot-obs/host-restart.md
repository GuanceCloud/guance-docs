# HOST Restart Inspection

---

## Background

HOST abnormal restart monitoring is an important part of modern internet system operations. On one hand, the stability and reliability of computer systems are crucial for the smooth operation of businesses and user experience. When a HOST experiences issues such as abnormal restarts, it can lead to risks like system crashes, service interruptions, and data loss, which in turn affect business operations and customer satisfaction. On the other hand, in cloud computing and virtualization environments, the number and scale of HOSTs continue to grow, and system complexity is also increasing, leading to a higher probability of problems occurring. This necessitates that system administrators use relevant system monitoring tools for real-time monitoring and promptly identify and resolve issues such as abnormal restarts. Therefore, reasonably implementing HOST abnormal restart monitoring can help businesses quickly diagnose problems, reduce business risks, and enhance operational efficiency and user experience.

## Prerequisites

1. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In <<< custom_key.brand_name >>> "Manage / API Key Management," create an [API Key](../../management/api-key/open-api.md) for performing operations.

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, ensure it is with the same operator and in the same region as the currently used <<< custom_key.brand_name >>> SaaS deployment [here](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In your self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-hosted Inspection (HOST Restart)" via the "Script Market" and follow the prompts to configure the <<< custom_key.brand_name >>> API Key to enable it.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, allowing direct access to the corresponding settings via a link.

![image](../img/success_checker.png)

## Configuring Inspection

You can configure the desired filtering conditions for inspection in the Intelligent Inspection module of <<< custom_key.brand_name >>> Studio or in the automatically created startup script of DataFlux Func. Refer to the two configuration methods below:

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/host-restart02.png)

#### Enable/Disable

The HOST restart inspection is by default set to "Enabled" status and can be manually "Disabled." Once enabled, it will inspect the configured list of HOSTs.

#### Editing

The "HOST Restart Inspection" under Intelligent Inspection supports manual addition of filter conditions. Click the **Edit** button under the operations menu on the right side of the intelligent inspection list to edit the inspection template.

* Filter Conditions: Configure the HOSTs to be inspected.
* Alert Notifications: Supports selection and editing of alert strategies, including event levels requiring notification, notified parties, and alert silence periods.

To configure entry parameters, click Edit and fill in the corresponding detection objects in the parameter configuration section, then save to start the inspection:

![image](../img/host-restart03.png)

Refer to the following example for configuring multiple HOST information:

```
configs Configuration Example:
          host1
          host2
          host3
```

> **Note**: In your self-hosted DataFlux Func, when writing custom inspection handling functions, additional filtering conditions can also be added (refer to the sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the necessary filtering conditions for inspection, you can directly run tests by selecting the `run()` method from the page. After clicking Publish, the script will execute normally. You can also view or modify configurations in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection."

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
@DFF.API('HOST Restart Inspection', fixed_crontab='*/15 * * * *', timeout=900)
def run(configs=None):
    '''
  Optional Parameters:
    configs : 
            Configure the list of hosts to be detected (optional; if not configured, it defaults to detecting all HOSTS under the current workspace).
            Multiple hosts to be detected can be specified (separated by line breaks), defaulting to detecting all HOSTS under the current workspace if not configured.
    configs Configuration Example:
            host1
            host2
            host3
    '''
    checkers = [
        host_restart.HostRestartChecker(configs=configs, filters=[filter_host]), # Support for user-configured multiple filtering functions that are executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

This inspection scans for HOST restart events within the last 15 minutes. Once a restart occurs, Intelligent Inspection generates the corresponding event. Under the operations menu on the right side of the Intelligent Inspection list, click the **View Related Events** button to see the corresponding abnormal events.

![image](../img/host-restart04.png)

### Event Details Page

Click **Event**, to view the details page of the Intelligent Inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, history records, and related events.

* Click the small icon in the upper-right corner of the details page labeled "View Monitor Configuration" to view and edit the current Intelligent Inspection configuration details.

#### Basic Attributes

* Detection Dimensions: Based on the filter conditions configured in Intelligent Inspection, supports copying `key/value`, adding to filters, and viewing logs, containers, processes, security checks, traces, user analysis, synthetic tests, and CI data.
* Extended Attributes: Selecting extended attributes supports copying in `key/value` form, as well as forward/reverse filtering.

![image](../img/host-restart05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* HOST Details: View key metrics of the HOST during the current restart period.
* Anomaly Logs: View detailed information about the current anomaly logs.

![image](../img/host-restart06.png)

#### History Records

Supports viewing the detected object, anomaly/recovery times, and duration.

![image](../img/host-restart07.png)

#### Related Events

Supports viewing associated events through filtered fields and selected time component information.

![image](../img/host-restart08.png)

#### Related Views

![image](../img/host-restart09.png)

## Common Issues

**1. How to configure the detection frequency of HOST restart inspections**

In your self-hosted DataFlux Func, when writing custom inspection handling functions, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator, then configure it in "Management / Auto Trigger Configuration."

**2. Why might there be no anomaly analysis when HOST restart inspections trigger**

If there's no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. During inspections, previously normal scripts encounter abnormal errors**

Update the referenced script set in the DataFlux Func Script Market. You can refer to the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to view the update records of the script market for timely updates.

**4. During script upgrades, why does the corresponding script set in Startup show no changes**

First delete the corresponding script set, then click Upgrade to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Auto Trigger Configuration," check the inspection status. First, the status should be Enabled, secondly, verify the inspection script by clicking Execute. If the message appears indicating successful execution X minutes ago, the inspection is running properly.