# Frontend Application Log Error Inspection
---

## Background

Frontend error log inspection helps identify new error messages (clustered Error Messages) that have appeared in the frontend application within the past hour, assisting developers and operations teams in promptly fixing issues to avoid prolonged negative impacts on customer experience.

## Prerequisites

1. An integrated application already exists under <<< custom_key.brand_name >>> "[User Access Monitoring](../../real-user-monitoring/index)"
2. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/) or activation of [DataFlux Func (Automata)](../../dataflux-func/index.md)
4. Create an [API Key](../../management/api-key/open-api.md) for operations in <<< custom_key.brand_name >>> "Management / API Key Management"

> **Note**: If you are considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and in the same region as your current <<< custom_key.brand_name >>> SaaS deployment [in the same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In the self-hosted DataFlux Func, install the "<<< custom_key.brand_name >>> Custom Inspection (New RUM Error Types)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

Choose the required inspection scenario from the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select Deploy to start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create and trigger configurations. You can directly jump to the corresponding configuration via the link.

![image](../img/success_checker.png)

## Configuring Inspection

Configure the desired inspection filters in the Intelligent Inspection module under <<< custom_key.brand_name >>> Studio Monitoring or in the automatically created startup script in DataFlux Func. Refer to the two configuration methods below.

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/rum_error11.png)

#### Enable/Disable
The frontend application log error inspection is default set to "Enabled". It can be manually "Disabled". Once enabled, it will inspect the configured list of frontend applications.

#### Editing
Intelligent Inspection "Frontend Error Inspection" supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filter Conditions: Configure frontend application `app_name`
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and click Save to start the inspection:

![image](../img/rum_error02.png)

You can refer to the following JSON to configure multiple application information

```json
 // Configuration Example:
    configs
        app_name_1
        app_name_2
```

>  **Note**: In the self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filter conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those configured in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

After configuring the necessary filtering conditions in DataFlux Func, you can test by clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or change configurations in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_error__main as main

# Support for using filtering functions to filter inspected objects, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter appid, define conditions for matching appids, return True if matched, False otherwise
    return True｜False
    '''
    if appid in ['appid_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM New Error Types', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Parameters:
        configs: Multiple `app_name_1` can be specified (separated by line breaks), unspecified means all apps are inspected

    Configuration Example:
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumErrorCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

<<< custom_key.brand_name >>> automatically clusters all browser client error information. This inspection compares all error information from the past hour with the past 12 hours. If a previously unseen error appears, it triggers an alert. The intelligent inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view the relevant anomaly events.

![image](../img/rum_error04.png)

### Event Details Page
Click **Event** to view the detailed page of the intelligent inspection event, including event status, time of occurrence, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the detail page to view and edit the current intelligent inspection configuration details.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions configured in the intelligent inspection, support copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` form, apply forward/reverse filtering.

![image](../img/rum_error05.png)

#### Event Details
* Event Overview: Describes the object and content of the anomaly inspection event.
* Frontend Error Trend: View the error statistics for the current frontend application over the past hour.
* New Error Details: View detailed error times, error messages, error types, error stacks, and error counts. Clicking on the error message or error type will enter the corresponding data viewer; clicking on the error stack will enter the specific error stack detail page.

![image](../img/rum_error06.png)
![image](../img/rum_error09.png)

#### History
Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../img/rum_error07.png)

#### Related Events
Supports viewing related events through filtered fields and selected time component information.

![image](../img/rum_error08.png)

## Common Issues
**1. How is the inspection frequency configured for frontend application log errors?**

In the self-hosted DataFlux Func, when writing custom inspection handling functions, add `fixed_crontab='0 * * * *', timeout=900` in the decorator, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when frontend application log error inspections are triggered?**

If there is no anomaly analysis in the inspection report, check the current `datakit` data collection status.

**3. During the inspection process, why do previously normal scripts show abnormal errors?**

Update the referenced script set in the DataFlux Func Script Market. You can view the update records of the script market via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates of the script.

**4. Why does the script set in Startup not change during the upgrade of the inspection script?**

Delete the corresponding script set first, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling it?**

In "Management / Automatic Trigger Configuration", check the inspection status. First, the status should be Enabled, then validate the inspection script by clicking Execute. If it shows "Executed Successfully xx minutes ago," the inspection is running normally and effectively.