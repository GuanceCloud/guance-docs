# Server-Side Application Error Inspection

---

## Background

When server-side errors occur, we need to detect them early and issue timely alerts to allow development and operations teams to troubleshoot. This helps in quickly confirming whether the errors have potential impacts on the application. The content reported by server-side application error inspection events is a reminder to developers and operations that new errors have occurred in the application within the past hour. It also provides diagnostic clues related to the specific error locations.

## Prerequisites

1. Applications are already integrated with Guance's [APM](../../application-performance-monitoring/collection/index)
2. Set up [DataFlux Func (User-defined Node)](https://func.guance.com/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In Guance's "Management / API Key Management," create an [API Key](../../management/api-key/open-api.md) for performing operations

> **Note**: If you plan to use cloud servers for offline deployment of DataFlux Func, ensure it is deployed with the same provider and region as your current Guance SaaS deployment [here](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In your self-hosted DataFlux Func, install the "Guance Self-Hosted Inspection (APM Errors)" script from the "Script Market" and configure the Guance API Key to complete the setup.

Select the desired inspection scenario in the DataFlux Func Script Market, click Install, configure the Guance API Key, and choose to deploy and start the script after setting up [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/)

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create and configure the trigger settings. You can directly access the corresponding configuration via the provided link.

![image](../img/success_checker.png)

## Configuring Inspection

You can configure the inspection filters either in the Guance Studio under Monitoring - Smart Inspection or in the auto-created startup script in DataFlux Func. Refer to the following two configuration methods:

### Configuring Inspection in Guance

![image](../img/apm-errors02.png)

#### Enable/Disable

Memory leak inspections default to "Enabled" status and can be manually "Disabled." Once enabled, it will inspect the configured service list.

#### Editing

Smart Inspection "Server-Side Application Error Inspection" supports manual addition of filtering conditions. Click the **Edit** button in the operation menu on the right side of the Smart Inspection list to edit the inspection template.

* Filtering Conditions: Configure the list of app_name to be inspected (optional; if not configured, all app_names are inspected by default).
* Alert Notifications: Supports selection and editing of alert policies, including event severity levels, notification targets, and alert silence periods.

Click Edit to enter parameters in the configuration, then save and start the inspection:

![image](../img/apm-errors03.png)

Refer to the example below for configuring multiple projects, environments, versions, and services:

```json
// Configuration Example:
configs:
    project1:service1:env1:version1
    project2:service2:env2:version2
```

> **Note**: In the self-hosted DataFlux Func, when writing custom inspection handling functions, you can add filtering conditions (refer to sample code configuration). However, note that parameters configured in the Guance Studio will override those set in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

After configuring the required filtering conditions in DataFlux Func, you can test the script by selecting the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or modify configurations in Guance's "Monitoring / Smart Inspection."

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_apm_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    project = data['project']
    service_sub = data['service_sub']
    '''
    Filter service_sub, return True for matching conditions, False otherwise.
    return True｜False
    '''
    if service_sub in ['xxx-xxx-auth:dev:1.0']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('New APM Error Types', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Optional parameters:
        configs :
            Can specify multiple services (separated by newline), unspecified means inspect all services.
            Each service is concatenated by project, service, environment, and version separated by ":", e.g., "project1:service:env:version"
    Example:
        configs:
            project1:service1:env1:version1
            project2:service2:env2:version2
    """
    checkers = [
        main.ApmErrorCheck(configs=configs, filters=[filter_project_servcie_sub]), # Supports user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

This inspection scans for new application errors in the last hour. When a new error occurs, Smart Inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the Smart Inspection list to view the associated anomaly events.

![image](../img/apm-errors04.png)

### Event Details Page

Click **Event** to view the details page of the Smart Inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon "View Monitor Configuration" in the top-right corner of the details page to view and edit the current Smart Inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the configured filtering conditions, supports copying detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, forward/reverse filtering.

![image](../img/apm-errors05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly inspection event.
* Error Distribution: View the change in error counts for the current anomalous application over the past hour.
* Error Details: Display detailed information about new errors and specific error counts. Click specific error messages, error types, and error stacks to jump to the error detail page for viewing.

![image](../img/apm-errors06.png)

![image](../img/apm-errors07.png)

#### History

Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/apm-errors08.png)

#### Related Events

Supports viewing related events through filtered fields and selected time components.

![image](../img/apm-errors09.png)

## Common Issues

**1. How to configure the inspection frequency for server-side application errors**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=1800` in the decorator when writing custom inspection handling functions, then configure it in "Management / Automatic Trigger Configuration."

**2. Why might there be no anomaly analysis in the inspection report**

If the inspection report lacks anomaly analysis, check the data collection status of the current `datakit`.

**3. Under what circumstances does a server-side application error inspection event occur**

Server-side application error inspection scans for new application errors in the last hour. When a new error type appears, Smart Inspection generates corresponding events.

**4. What to do if a previously normal script throws an error during inspection**

Update the referenced script sets in the DataFlux Func Script Market. Check the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) for updates to facilitate immediate script updates.

**5. No changes in the Startup script set during inspection script upgrade**

Delete the corresponding script set first, then click Upgrade and configure the corresponding Guance API Key to complete the upgrade.

**6. How to verify if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration," check the inspection status. First, ensure it is enabled, then validate the script by clicking Execute. If it shows "Executed Successfully X minutes ago," the inspection is running effectively.