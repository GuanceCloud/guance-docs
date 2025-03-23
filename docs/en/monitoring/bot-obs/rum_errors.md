# Frontend Application Log Error Inspection
---

## Background

Frontend error log inspection will help discover new error messages (Error Messages after clustering) that have appeared in frontend applications within the past hour, assisting developers and operations teams in timely code repairs to avoid continuous damage to customer experience over time.

## Prerequisites

1. There exists an integrated application in <<< custom_key.brand_name >>>'s "[Real User Monitoring](../../real-user-monitoring/index)"
2. Self-built [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
4. Create an [API Key](../../management/api-key/open-api.md) for performing operations in <<< custom_key.brand_name >>>'s "Management / API Key Management"

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with [the same operator and region as the currently used <<< custom_key.brand_name >>> SaaS](../../../getting-started/necessary-for-beginners/select-site/).

## Start Inspection

In your self-built DataFlux Func, install "<<< custom_key.brand_name >>> Self-built Inspection (RUM New Error Types)" through the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to start.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and automatic trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configure Inspection

You can configure the desired filtering conditions for inspection in either the Intelligent Inspection module of <<< custom_key.brand_name >>> Studio or in the automatically created startup script of DataFlux Func. Refer to the two configuration methods below.

### Configure Inspection in <<< custom_key.brand_name >>>

![image](../img/rum_error11.png)

#### Enable/Disable
The frontend application log error inspection is by default in the "Enabled" state and can be manually "Disabled". After enabling, inspections will be conducted on the configured list of frontend applications.

#### Edit
Intelligent inspection "Frontend Error Inspection" supports manual addition of filtering conditions. In the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure the frontend application `app_name`
* Alert Notifications: Supports selection and editing of alert strategies, including event levels to notify, notification targets, and alert mute cycles

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and start the inspection after saving:

![image](../img/rum_error02.png)

You can refer to the following JSON configuration for multiple application information

```json
 // Configuration Example:
    configs
        app_name_1
        app_name_2
```

> **Note**: In the self-built DataFlux Func, when writing custom inspection processing functions, additional filtering conditions can also be added (refer to example code configurations). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the custom inspection processing function.

### Configure Inspection in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions for inspection, you can test by selecting and running the `run()` method directly from the page. After clicking publish, the script will run normally. You can also view or modify the configuration in <<< custom_key.brand_name >>>'s "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter appid, define conditions for appids that meet requirements, return True for matches, False for non-matches
    return True｜False
    '''
    if appid in ['appid_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM New Error Type', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Parameters:
        configs: Multiple `app_name_1` can be specified (separated by line breaks), unspecified means inspect all apps

    Configuration Example:
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumErrorCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions that are executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```



## View Events

<<< custom_key.brand_name >>> will automatically cluster all browser client error information. This inspection compares all error information from the past hour with the past 12 hours, and alerts if any previously unseen errors occur. The intelligent inspection will generate corresponding events. In the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to view the corresponding abnormal events.

![image](../img/rum_error04.png)

### Event Details Page
Click **Event**, to view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon in the upper-right corner of the detail page labeled "View Monitor Configuration" to view and edit the detailed configuration of the current intelligent inspection.

#### Basic Attributes
* Detection Dimension: Based on the filtering conditions configured in intelligent inspection, it supports copying the detection dimension `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, real user monitoring, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, it supports copying in `key/value` form, forward/reverse filtering.

![image](../img/rum_error05.png)

#### Event Details
* Event Overview: Describes the object and content of the anomaly inspection event.
* Frontend Error Trend: View the error statistics of the current frontend application in the past hour.
* New Error Details: View detailed error times, error messages, error types, error stacks, and number of errors; click the error message or error type to enter the corresponding data viewer; click the error stack to enter the specific error stack detail page.

![image](../img/rum_error06.png)
![image](../img/rum_error09.png)

#### Historical Records
Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../img/rum_error07.png)

#### Related Events
Supports viewing related events through filtering fields and selected time component information.

![image](../img/rum_error08.png)

## Common Issues
**1. How to configure the detection frequency of frontend application log error inspections**

In the self-built DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator while writing the custom inspection processing function, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis triggered during frontend application log error inspections**

When there is no anomaly analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. During the inspection process, why might previously normal scripts encounter abnormal errors**

Please update the referenced script sets in the DataFlux Func Script Market. You can use the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to view the update records of the script market for timely updates.

**4. During the upgrade of the inspection script, why does the corresponding script set in Startup show no changes**

Please delete the corresponding script set first, then click the upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine whether the inspection has taken effect after activation**

In "Management / Automatic Trigger Configuration", view the corresponding inspection status. First, the status should be enabled, secondly, you can verify whether the inspection script works by clicking execute. If the message "Executed successfully xxx minutes ago" appears, the inspection is functioning properly.