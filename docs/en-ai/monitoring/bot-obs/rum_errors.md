# Frontend Application Log Error Inspection
---

## Background

Frontend error log inspection helps to identify new error messages (clustered Error Messages) that have appeared in the frontend application within the past hour. This assists developers and operations teams in promptly fixing code issues, thereby preventing continuous harm to the customer experience over time.

## Prerequisites

1. There exists an integrated application under "User Access Monitoring" in Guance.
2. Set up a self-hosted [DataFlux Func for Guance](https://func.guance.com/#/) or activate the [DataFlux Func (Automata)](../../dataflux-func/index.md).
4. Create an API Key for performing operations in "Management / API Key Management" in Guance.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, ensure it is deployed with the same operator and region as the current SaaS deployment of Guance [in the same provider and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In the self-hosted DataFlux Func, install "Self-hosted Inspection for Guance (New RUM Error Types)" from the "Script Market" and configure the Guance API Key to complete the setup.

Choose the desired inspection scenario in the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) settings, then select Deploy to start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via a link.

![image](../img/success_checker.png)

## Configuring Inspection

Configure the inspection conditions you wish to filter in either the Smart Inspection module under Guance Studio's monitoring section or the startup script automatically created by DataFlux Func. Refer to the following two configuration methods.

### Configuring Inspection in Guance

![image](../img/rum_error11.png)

#### Enable/Disable
By default, the frontend application log error inspection is set to "Enabled". You can manually "Disable" it. Once enabled, it will inspect the configured list of frontend applications.

#### Editing
The "Frontend Error Inspection" feature in Smart Inspection supports users to add filtering conditions manually. In the operation menu on the right side of the Smart Inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure frontend application `app_name`
* Alert Notifications: Supports selecting and editing alert policies, including event levels, notification targets, and alert mute periods

Click Edit to enter parameters in the parameter configuration, fill in the corresponding detection objects, and click Save to start the inspection:

![image](../img/rum_error02.png)

You can reference the following JSON configuration for multiple application information

```json
 // Configuration Example:
    configs
        app_name_1
        app_name_2
```

>  **Note**: When writing custom inspection handling functions in self-hosted DataFlux Func, you can also add filtering conditions (refer to example code configurations). Note that parameters configured in Guance Studio will override those configured in custom inspection handling functions.

### Configuring Inspection in DataFlux Func

After configuring the required filtering conditions in DataFlux Func, you can test by clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or change configurations in the "Monitoring / Smart Inspection" section of Guance.

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter appid, return True if it matches the defined criteria, otherwise return False
    return True｜False
    '''
    if appid in ['appid_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM New Error Types', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Parameters:
        configs: Multiple app_name_1 can be specified (separated by line breaks), unspecified means all apps are inspected

    Configuration Example:
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumErrorCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

Guance automatically clusters all browser client error information. This inspection compares errors from the past hour with those from the past 12 hours. If any previously unseen errors occur, an alert is triggered. The Smart Inspection generates corresponding events. In the operation menu on the right side of the Smart Inspection list, click the **View Related Events** button to view associated anomaly events.

![image](../img/rum_error04.png)

### Event Detail Page
Clicking **Event**, you can view the detailed page of the Smart Inspection event, including event status, occurrence time, anomaly name, basic attributes, event details, alert notifications, history records, and related events.

* Click the small icon "View Monitor Configuration" in the upper-right corner of the detail page to view and edit the current Smart Inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the configured filtering conditions in Smart Inspection, supports copying `key/value`, adding filters, and viewing related logs, containers, processes, Security Checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../img/rum_error05.png)

#### Event Details
* Event Overview: Describes the object and content of the anomaly inspection event.
* Frontend Error Trends: View error statistics for the past hour for the current frontend application.
* New Error Details: View detailed error times, error messages, error types, stack traces, and error counts; clicking on the error message or type enters the respective data viewer; clicking on the stack trace opens the specific stack trace detail page.

![image](../img/rum_error06.png)
![image](../img/rum_error09.png)

#### History Records
Supports viewing detection objects, anomaly/detection times, and duration.

![image](../img/rum_error07.png)

#### Related Events
Supports viewing related events through filtering fields and selected time components.

![image](../img/rum_error08.png)

## Common Issues
**1. How to configure the inspection frequency for frontend application log errors**

In the self-hosted DataFlux Func, when writing custom inspection handling functions, add `fixed_crontab='0 * * * *', timeout=900` in the decorator, then configure it in "Management / Automatic Trigger Configuration".

**2. Why there might be no anomaly analysis when the frontend application log error inspection triggers**

If the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. What to do if scripts that were running normally during inspection now show abnormal errors**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records in the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate updates.

**4. No changes found in Startup script sets during inspection script upgrade**

First, delete the corresponding script set, then click Upgrade to configure the corresponding Guance API Key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration", check the inspection status. First, it should be Enabled. Then, validate by clicking Execute to verify if the inspection script runs without issues. If it shows "Executed Successfully xx minutes ago," the inspection is functioning correctly.