# Workspace Asset Inspection

---

## Background

Service inspections should ensure the normal operation of services, promptly identify failures or anomalies, and reduce business losses. Additionally, inspections help improve service availability and stability by identifying and resolving potential issues. Inspections can also enhance operations efficiency, accelerate problem diagnosis and resolution, and optimize resource allocation. They ensure business security. Through regular inspections of HOSTs, K8s, CONTAINERS, and other services, operations personnel can ensure that these services efficiently and stably support business operations, providing enterprises with a continuously reliable operating environment.

## Prerequisites

1. Self-host [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In <<< custom_key.brand_name >>> "Manage / API Key Management," create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If you consider using cloud servers for offline deployment of DataFlux Func, please ensure it is deployed in the [same provider and region](../../../getting-started/necessary-for-beginners/select-site/) as the currently used <<< custom_key.brand_name >>> SaaS deployment.

## Starting the Inspection

In self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-hosted Inspection (Weekly/Monthly Report)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to start.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and automatic trigger configuration, which can be viewed directly through the link.

![image](../img/success_checker.png)

## Configuring the Inspection

Configure the desired filtering conditions for the inspection either in the Intelligent Inspection module of <<< custom_key.brand_name >>> Studio or in the startup script automatically created by DataFlux Func. You can refer to the following two configuration methods:

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/workspace-weekly-report02.png)

#### Enable/Disable

Workspace asset inspection usage rate inspection is by default "Enabled" and can be manually "Disabled." After enabling, the configured host list will undergo inspection.

#### Edit

The Intelligent Inspection "Workspace Asset Inspection" supports manual addition of filtering conditions. Under the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure the reporting period for the inspections. Currently, only 7 days and 30 days options are supported.
* Alert Notifications: Support selecting and editing alert strategies, including event severity levels to notify, notification targets, and alert silence periods.

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../img/workspace-weekly-report03.png)

You can reference the following configuration:

```
configs Configuration Example:
          7
```

> **Note**: In self-hosted DataFlux Func, when writing self-hosted inspection handling functions, you can also add filtering conditions (refer to example code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the self-hosted inspection handling function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions for the inspection, you can test it by selecting the `run()` method directly on the page and clicking Run. After publishing, the script will execute normally. You can also view or modify the configuration in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection."

```python
# Please fill in the following configuration according to the actual situation

# Guance API key
account = {
    "api_key_id" : "<Guance API key ID>",
    "api_key"    : "<Guance API key>",
    "guance_node": "<Guance Node [About Guance Node](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/)>"
}

# The HOSTs that do not need to be checked
# Example:
#         no_check_host = ['192.168.0.1', '192.168.0.1']
no_check_host = []

###### Do not modify the following content #####
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_weekly_report__main as main


@self_hosted_monitor(account['api_key_id'], account['api_key'], account['guance_node'])
@DFF.API('Workspace Asset Inspection', fixed_crontab='* * */7 * *', timeout=900)
# @DFF.API('Workspace Asset Inspection', fixed_crontab='* * */30 * *', timeout=900)
def run(configs=None):
    '''
    en:
        title: Workspace Asset Inspection
        doc: |
            parameters:
                configs :
                    Set the detection period to seven days or thirty days (optional. If this parameter is not configured, the detection period is seven days by default).

                configs Configuration example：
                    7
    '''

    checkers = [
        main.WeeklyreportEventStruct(configs=configs, no_check_host=no_check_host),
    ]

    Runner(checkers).run()
```

## Viewing Events

This inspection will scan the asset information within the workspace over the past 7 or 30 days. Intelligent Inspection will summarize the asset reports for 7 or 30 days. Under the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view corresponding events.

![image](../img/workspace-weekly-report04.png)

### Event Details Page

Clicking **Event**, you can view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, history records, and associated events.

* Clicking the small icon in the top-right corner of the details page labeled "View Monitor Configuration" allows you to view and edit the configuration details of the current intelligent inspection.

#### Basic Attributes

* Detection Dimensions: Based on the screening conditions of the intelligent inspection configuration, it supports copying the detection dimension `key/value`, adding to filters, and viewing related LOGs, CONTAINERS, processes, Security Checks, APM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, it supports copying in `key/value` form, forward/reverse filtering.

![image](../img/workspace-weekly-report05.png)

#### Event Details

##### Summary

* Summary: Displays an overview of the current workspace resources, including total number of HOSTs, CONTAINERS, etc.
* Cloud Provider HOST Distribution: View the distribution of cloud providers for assets in the current workspace.
* Regional HOST Distribution: View the regional distribution of assets in the current workspace.
* Operating System HOST Distribution: View the operating system distribution of assets in the current workspace.
* Restart Pods: View the abnormal restart situations of Pods in the current workspace and jump to the corresponding log details for further investigation.

![image](../img/workspace-weekly-report06.png)

##### Hosts

* Disk: Displays detailed disk information for resources in the current workspace.
* CPU: Displays CPU usage details for resources in the current workspace and shows process details for Top HOSTs.
* MEM: Displays MEM usage details for resources in the current workspace and shows process details for Top HOSTs.
* Traffic: Displays traffic details for resources in the current workspace.

![image](../img/workspace-weekly-report07.png)

#### History Records

Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/workspace-weekly-report08.png)

#### Associated Events

Supports viewing associated events through filtered fields and selected time component information.

![image](../img/workspace-weekly-report09.png)

## Common Issues

**1. How to configure the inspection frequency for workspace asset inspection**

When enabling monthly inspections, change the parameter in the decorator of the automatically created inspection handling function to `fixed_crontab='* * */30 * *', timeout=900`, then configure it in "Manage / Automatic Trigger Configuration."

**2. Why might there be no anomaly analysis during workspace asset inspection triggers**

If there is no anomaly analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. During the inspection process, previously normally running scripts may encounter abnormal errors**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the Script Market through the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate immediate script updates.

**4. During the upgrade of inspection scripts, why does the corresponding script set in Startup show no changes**

First delete the corresponding script set, then click the Upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Manage / Automatic Trigger Configuration," view the corresponding inspection status. First, the status should be enabled; secondly, you can verify whether the inspection script has any problems by clicking Execute. If the message appears indicating successful execution xxx minutes ago, the inspection is functioning properly.