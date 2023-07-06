# Host Restart Intelligent Inspection

---

## Background

Host abnormal restart monitoring is an important aspect of modern internet system operation and maintenance. On the one hand, the stability and reliability of computer systems are crucial for the smooth operation of businesses and the user experience. When a host experiences abnormal restarts or other issues, it may lead to system crashes, service interruptions, and data loss, which in turn affect business operations and user satisfaction. On the other hand, with the increasing number and scale of hosts in cloud computing and virtualization environments, system complexity is also constantly increasing, as is the probability of problems occurring. This requires system administrators to use relevant system monitoring tools for real-time monitoring and promptly discover and resolve abnormal restarts and other issues. Therefore, implementing host abnormal restart monitoring in a reasonable manner can help enterprises quickly diagnose problems, reduce business risks, improve operation and maintenance efficiency, and enhance user experience.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
2. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/).

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (Host Restart)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/host-restart02.png)

#### Enable/Disable

APM Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured Disk.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent inspection "Host Restart Inspection" allows users to manually add filter conditions. In the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection

* Filter conditions: Configure the hosts that need to be inspected
* Alert notification: Supports selecting and editing alert policies, including the event level that needs to be notified, the notification object, and the alert silence period, etc.

After clicking on the edit button, enter the corresponding detection object in the parameter configuration and click save to start the inspection:

![image](../img/host-restart03.png)

You can refer to the following example for configuring multiple host information:

```
configs example：
          host1
          host2
          host3
```

>  **注意**：在自建的 DataFlux Func 中，编写自建巡检处理函数时也可以添加过滤条件（参考示例代码配置），要注意的是在观测云 studio 中配置的参数会覆盖掉编写自建巡检处理函数时配置的参数

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

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
@DFF.API('主机重启巡检', fixed_crontab='*/15 * * * *', timeout=900)
def run(configs=None):
    '''
Optional parameters:
  	configs:
          Configure the list of hosts that need to be detected (optional, if not configured, all hosts in the current workspace will be detected by default)
          Multiple hosts to be detected can be specified (joined by line breaks). If not configured, all hosts in the current workspace will be detected by default.
    configs 配置示例：
            host1
            host2
            host3
    '''
    checkers = [
        host_restart.HostRestartChecker(configs=configs, filters=[filter_host]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## View Events

This inspection will scan the host restart events in the last 15 minutes. Once a restart occurs, the intelligent inspection will generate a corresponding event. In the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding abnormal events.

![image](../img/host-restart04.png)

### Event Details Page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

* Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
* Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.

#### Basic Properties

* Detection dimension: Based on the filtering conditions configured by Intelligent Inspection, it supports copying and adding the detection dimension `key/value` to the filtering and viewing the related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
* Extended Attributes: Supports `key/value` replication and forward/reverse filtering after selecting extended attributes.

![image](../img/host-restart05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Host Details: View the main indicators of the host during the current restart period.
* Abnormal Log: You can view the details of the current abnormal log.

![image](../img/host-restart06.png)

#### History

Support to view the detection object, exception/recovery time and duration.

![image](../img/host-restart07.png)

#### Related events

Support to view related events through filtering fields and selected time component information.

![image](../img/host-restart08.png)

#### Associated View

![image](../img/host-restart09.png)

## FAQ

**1. How to configure the detection frequency of host restart inspection**

In a self-built DataFlux Func, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator when writing the self-built inspection processing function. Then configure it in "Management / Auto Trigger Configuration".

**2. Host restart inspection may not have abnormal analysis when triggered**

If there is no abnormal analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. Anomalies found in previously running scripts during the inspection process**

Please update the referenced script set in DataFlux Func's script market. You can view the update log of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to update the script promptly.

**4. No changes found in the corresponding script set in Startup during the upgrade of the inspection script**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection is effective after enabling it**

Check the corresponding inspection status in "Management / Auto Trigger Configuration". First, the status should be enabled, and secondly, you can verify whether the inspection script has any problems by clicking on execution. If the executed successfully message appears a few minutes ago, the inspection is running normally and takes effect.

