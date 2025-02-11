# Workspace Asset Inspection

---

## Background

Service inspections should ensure services are running normally, promptly identify faults or anomalies, and minimize business losses. Additionally, inspections help improve service availability and stability by discovering and resolving potential issues. They also enhance operations efficiency, accelerate problem diagnosis and resolution, and optimize resource allocation to ensure business security. By regularly inspecting hosts, K8s, containers, and other services, operations personnel can ensure these services efficiently and stably support business operations, providing a continuously reliable environment for enterprises.

## Prerequisites

1. Deploy [DataFlux Func (Automata)](https://func.guance.com/#/) on your own infrastructure, or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) in Guance under "Management / API Key Management" for performing operations

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, please consider deploying it with the same operator and region as your current Guance SaaS deployment [in the same location](../../../getting-started/necessary-for-beginners/select-site/).

## Initiating Inspection

In your self-hosted DataFlux Func, install the "Self-hosted Inspection Script (Weekly/Monthly Reports)" from the "Script Market" and configure the Guance API Key to initiate the inspection.

Select the desired inspection scenario from the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and trigger configuration. You can directly jump to view the corresponding configuration via the provided link.

![image](../img/success_checker.png)

## Configuring Inspections

Configure the inspection filters you want either in the Guance Studio's Monitoring - Intelligent Inspection module or in the startup script automatically created by DataFlux Func. Refer to the two configuration methods below:

### Configuring Inspection in Guance

![image](../img/workspace-weekly-report02.png)

#### Enable/Disable

The workspace asset inspection usage rate is enabled by default. It can be manually disabled. Once enabled, it will inspect the configured list of hosts.

#### Editing

Intelligent inspection for "Workspace Asset Inspection" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filtering Conditions: Configure the reporting period for the inspection. Currently, only 7 days and 30 days are supported.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

After clicking Edit, fill in the corresponding detection object in the parameter configuration and save to start the inspection:

![image](../img/workspace-weekly-report03.png)

Refer to the following configuration example:

```
Configuration example:
          7
```

> **Note**: When writing custom inspection processing functions in your self-hosted DataFlux Func, you can add filtering conditions (refer to the sample code configuration). Note that parameters configured in Guance Studio will override those set in the custom inspection processing function.

### Configuring Inspection in DataFlux Func

After configuring the necessary filtering conditions in DataFlux Func, you can test by selecting the `run()` method directly on the page and clicking Run. After publishing, the script will execute normally. You can also view or change configurations in Guance under "Monitoring / Intelligent Inspection".

```python
# Please fill in the following configuration according to the actual situation

# Guance API key
account = {
    "api_key_id" : "<Guance API key ID>",
    "api_key"    : "<Guance API key>",
    "guance_node": "<Guance Node [About Guance Node](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/)>"
}

# Hosts that do not need to be checked
# Example:
#         no_check_host = ['192.168.0.1', '192.168.0.1']
no_check_host = []

###### Do not modify the following content #####
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_weekly_report__main as main


@self_hosted_monitor(account['api_key_id'], account['api_key'], account['guance_node'])
@DFF.API('Workspace asset inspection', fixed_crontab='* * */7 * *', timeout=900)
# @DFF.API('Workspace asset inspection', fixed_crontab='* * */30 * *', timeout=900)
def run(configs=None):
    '''
    en:
        title: Workspace asset inspection
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

This inspection scans asset information within the workspace over the past 7 or 30 days. The intelligent inspection aggregates 7-day or 30-day asset reports. In the intelligent inspection list's operation menu on the right, click the **View Related Events** button to view corresponding events.

![image](../img/workspace-weekly-report04.png)

### Event Details Page

Click **Event** to view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon in the upper right corner of the details page labeled "View Monitor Configuration" to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, it supports copying detection dimensions as `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../img/workspace-weekly-report05.png)

#### Event Details

##### Summary

* Summary: Displays an overview of the current workspace resources, including total number of hosts, containers, etc.
* Cloud Vendor Host Distribution: View the distribution of cloud vendor hosts in the current workspace assets.
* Geographic Host Distribution: View the geographic distribution of hosts in the current workspace assets.
* Operating System Host Distribution: View the operating system distribution of hosts in the current workspace assets.
* Restarted Pods: View the situation of abnormally restarted Pods in the current workspace and navigate to the corresponding log details for further investigation.

![image](../img/workspace-weekly-report06.png)

##### Hosts

* Disk: Displays disk details of the current workspace resources.
* CPU: Displays CPU usage details of the current workspace resources and shows process details of top hosts.
* MEM: Displays memory usage details of the current workspace resources and shows process details of top hosts.
* Traffic: Displays traffic details of the current workspace resources.

![image](../img/workspace-weekly-report07.png)

#### Historical Records

Supports viewing the inspected objects, anomaly/recovery times, and duration.

![image](../img/workspace-weekly-report08.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

![image](../img/workspace-weekly-report09.png)

## Common Issues

**1. How to configure the inspection frequency for workspace asset inspection**

To enable monthly inspections, change the parameter in the automatically created inspection processing function decorator to `fixed_crontab='* * */30 * *', timeout=900`, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when workspace asset inspection triggers**

If the inspection report lacks anomaly analysis, check the data collection status of the current `datakit`.

**3. What to do if a previously working script encounters an error during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update history of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates.

**4. Why does the script set in Startup remain unchanged during inspection script upgrades**

Delete the corresponding script set first, then click the upgrade button to reconfigure the corresponding Guance API Key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can verify the inspection script by clicking Execute. If it shows "Executed successfully xx minutes ago," the inspection is running normally and has taken effect.