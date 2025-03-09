# Server-Side Application Error Inspection

---

## Background

When server-side errors occur, we need to detect and alert early so that development and operations can troubleshoot promptly and confirm whether the error has any potential impact on the application. The content reported by server-side application error inspection events is to remind developers and operators of new errors in the past hour and provide diagnostic clues associated with specific error locations.

## Prerequisites

1. <<< custom_key.brand_name >>>「[APM](../../application-performance-monitoring/collection/index)」already has integrated applications
2. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
4. In <<< custom_key.brand_name >>>「Manage / API Key Management」, create an [API Key](../../management/api-key/open-api.md) for performing operations

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed in the [same operator and region](../../../getting-started/necessary-for-beginners/select-site/) as the current SaaS deployment of <<< custom_key.brand_name >>>.

## Enable Inspection

In your self-hosted DataFlux Func, install 「<<< custom_key.brand_name >>> Self-Hosted Inspection (APM Errors)」via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

In the DataFlux Func Script Market, select the required inspection scenario, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configure Inspection

Configure the desired filtering conditions for inspection in the <<< custom_key.brand_name >>> Studio under Monitoring - Smart Inspection or in the startup script automatically created by DataFlux Func. You can refer to the following two configuration methods:

### Configuration in <<< custom_key.brand_name >>>

![image](../img/apm-errors02.png)

#### Enable/Disable

Memory leak inspection is enabled by default and can be manually disabled. After enabling, it will inspect the configured service list.

#### Edit

The smart inspection 「Server-Side Application Error Inspection」supports users adding manual filtering conditions. In the operation menu on the right side of the smart inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure the list of app_names to be inspected (optional, defaults to all app_names if not configured)
* Alert Notifications: Supports selecting and editing alert strategies, including event severity, notification targets, and alert mute periods

Click Edit to enter parameter configuration and fill in the corresponding detection objects before saving and starting the inspection:

![image](../img/apm-errors03.png)

You can reference the configuration of multiple projects, environments, versions, and services as follows:

```json
// Configuration Example:
configs configuration instance:
    project1:service1:env1:version1
    project2:service2:env2:version2
```

> **Note**: In self-hosted DataFlux Func, when writing self-hosted inspection processing functions, you can also add filtering conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the self-hosted inspection processing function.

### Configuration in DataFlux Func

After configuring the necessary filtering conditions in DataFlux Func, you can test by clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or change the configuration in <<< custom_key.brand_name >>>「Monitoring / Smart Inspection」.

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_apm_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    project = data['project']
    service_sub = data['service_sub']
    '''
    Filter service_sub, customize conditions matching service_sub, return True for matches, False otherwise.
    return True｜False
    '''
    if service_sub in ['xxx-xxx-auth:dev:1.0']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('New APM Error Types', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Optional parameter:
        configs :
            Can specify multiple services (separated by line breaks), unspecified checks all services.
            Each service is composed of project, service, environment, version joined by ":", e.g., "project1:service:env:version"
    Example:
        configs configuration instance:
            project1:service1:env1:version1
            project2:service2:env2:version2
    """
    checkers = [
        main.ApmErrorCheck(configs=configs, filters=[filter_project_servcie_sub]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## View Events

This inspection scans for new application errors in the last hour. Once a new error type occurs, the smart inspection generates a corresponding event. In the operation menu on the right side of the smart inspection list, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/apm-errors04.png)

### Event Details Page

Click **Event** to view the details page of the smart inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled 「View Monitor Configuration」in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the smart inspection, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM PV, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to support copying in `key/value` format, forward/reverse filtering.

![image](../img/apm-errors05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly inspection event.
* Error Distribution: View the number of errors that occurred in the last hour for the current anomalous application.
* Error Details: Displays detailed information about new errors and specific error counts for the anomalous application. You can click specific error messages, error types, and error stacks to navigate to the error detail page for viewing.

![image](../img/apm-errors06.png)

![image](../img/apm-errors07.png)

#### History

Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../img/apm-errors08.png)

#### Related Events

Supports viewing related events through filtering fields and selected time component information.

![image](../img/apm-errors09.png)

## Common Issues

**1. How to configure the inspection frequency for server-side application errors**

* In self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=1800` in the decorator when writing self-hosted inspection processing functions, then configure it in 「Manage / Auto-Trigger Configuration」.

**2. Why might there be no anomaly analysis in the inspection report**

If the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. Under what circumstances would server-side application error inspection events be generated**

Server-side application error inspection scans for new application errors in the last hour. Once a new error type appears, the smart inspection generates a corresponding event.

**4. What should I do if a previously working script fails during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can review the update records via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to keep the scripts up-to-date.

**5. Why does the Startup script set not change during script upgrade**

Delete the corresponding script set first, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection is effective after enabling**

In 「Manage / Auto-Trigger Configuration」, check the inspection status. First, it should be enabled. Then, verify the inspection script by clicking Execute. If it shows "Executed successfully xxx minutes ago," the inspection is running normally.