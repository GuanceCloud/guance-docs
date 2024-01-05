# Workspace Asset Intelligent Inspection

---

## Background

For service inspections, it is essential to ensure the normal operation of the service, detect faults or abnormalities in a timely manner, and reduce business losses. Secondly, inspections help improve service availability and stability, identify and resolve potential problems. Inspections can also enhance operational efficiency, accelerate problem diagnosis and resolution, and optimize resource allocation. Ensuring business security is of utmost importance. By regularly inspecting services such as hosts, K8s, and containers, operations personnel can ensure that these services can efficiently and stably support the business, providing a continuously reliable operating environment for the enterprise.

## Preconditions

1. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
2. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In DataFlux Func, install the "Guance Self-Built Inspection (Weekly and Monthly Inspection)" from the "Script Market" and follow the prompts to configure the Guance API Key to complete the activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

In the Guance Studio Monitoring - Intelligent Inspection module or the startup script automatically created by DataFlux Func, configure the desired inspection filtering conditions. You can refer to the following two configuration methods:

### Configure Intelligent Inspection in Guance

![image](../img/workspace-weekly-report02.png)

#### Enable/Disable

Workspace Asset Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured Alibaba Cloud Preemptible Instance.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

The intelligent inspection "Workspace Asset Intelligent Inspection" allows users to manually add filtering conditions. In the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filtering conditions: Configure the reporting period for inspection, currently supporting only 7 days and 30 days options
* Alert notifications: Support selection and editing of alert policies, including the event level to be notified, notification objects, and alert silence periods, etc.

After clicking edit for the configuration entry parameters, fill in the corresponding detection objects in the parameter configuration and click save to start the inspection:

![image](../img/workspace-weekly-report03.png)

You can refer to the following configuration:

```
configs example：
          7
```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the intelligent inspection processing function.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
# Please fill in the following configuration according to the actual situation

# Guance API key
account = {
    "api_key_id" : "<Guance API key ID>",
    "api_key"    : "<Guance API key>",
    "guance_node": "<Guance Node [About Guance Node](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/)>"
}

# The host does not need to be checked
# Example:
#         no_check_host = ['192.168.0.1', '192.168.0.1']
no_check_host = []

###### Do not modify the following content #####
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_weekly_report__main as main


@self_hosted_monitor(account['api_key_id'], account['api_key'], account['guance_node'])
@DFF.API('工作空间资产巡检', fixed_crontab='* * */7 * *', timeout=900)
# @DFF.API('工作空间资产巡检', fixed_crontab='* * */30 * *', timeout=900)
def run(configs=None):
    '''
    zh-CN:
        title: 工作空间资产巡检
        doc: |
            参数:
                configs :
                    配置检测周期，七天或三十天（可选，不配置则默认检测七天）

                configs 配置示例：
                    7
    en:
        title: Workspace asset inspection
        doc: |
            parameters:
                configs :
                    Set the detection period to seven days or several days (optional. If this parameter is not configured, the detection period is seven days by default).

                configs Configuration example：
                    7
    '''

    checkers = [
        main.WeeklyreportEventStruct(configs=configs, no_check_host=no_check_host),
    ]

    Runner(checkers).run()
```

## View Events

This inspection will scan the asset information within the workspace for the past 7 days or 30 days. The intelligent inspection will summarize the asset reports for 7 days or 30 days. In the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding events.

![image](../img/workspace-weekly-report04.png)

### Event details page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

  * Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
  * Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.

#### Basic Properties

* Detection dimension: Based on the filtering conditions configured by Intelligent Inspection, it supports copying and adding the detection dimension `key/value` to the filtering and viewing the related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
  * Extended Attributes: Supports `key/value` replication and forward/reverse filtering after selecting extended attributes.

![image](../img/workspace-weekly-report05.png)

#### Event details

##### Overview

* Overview: Displays the resource overview of the current workspace, including the total number of hosts, containers, etc.
* Cloud Vendor Host Distribution: Allows users to view the distribution of cloud vendors for the assets in the current workspace.
* Regional Host Distribution: Allows users to view the geographical distribution of the assets in the current workspace.
* Operating System Host Distribution: Allows users to view the operating system distribution of the assets in the current workspace.
* Restarted Pods: Allows users to view the status of abnormally restarted Pods in the current workspace and navigate to the corresponding log details for further investigation.

![image](../img/workspace-weekly-report06.png)

##### Host

* Disk: Displays the disk details of the resources in the current workspace.
* CPU: Displays the CPU usage details of the resources in the current workspace, and shows the process details of the Top hosts.
* MEM: Displays the MEM usage details of the resources in the current workspace, and shows the process details of the Top hosts.
* Traffic: Displays the traffic details of the resources in the current workspace.s

![image](../img/workspace-weekly-report07.png)

#### History

 Support to view the detection object, exception/recovery time and duration.

![image](../img/workspace-weekly-report08.png)

#### Related events

  Support to view related events through filtering fields and selected time component information.

![image](../img/workspace-weekly-report09.png)

## FAQ

**1. How to configure the detection frequency for Workspace Asset Intelligent Inspection**

To enable monthly inspection, change the decorator parameter in the automatically created inspection processing function to `fixed_crontab='* * */30 * *', timeout=900`, and then configure it in "Management / Automatic Trigger Configuration".

**2. There may be no anomaly analysis when Workspace Asset Intelligent Inspection is triggered**

If there is no anomaly analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. During the inspection process, an exception error occurs in a script that was previously running normally**

Please update the referenced script set in the DataFlux Func script market. You can view the update records of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) for timely script updates.

**4. No changes in the corresponding script set in Startup during the inspection script upgrade process**

Please first delete the corresponding script set, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection takes effect after enabling it**

Check the corresponding inspection status in "Management / Automatic Trigger Configuration". First, the status should be enabled. Secondly, you can click Execute to verify if there is any problem with the inspection script. If it shows "xxx minutes ago execution successful", the inspection is running normally and takes effect.

