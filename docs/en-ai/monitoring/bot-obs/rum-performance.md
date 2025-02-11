# RUM Performance Inspection
---

## Background

Real User Monitoring (RUM) is an application performance monitoring (APM) technology designed to evaluate website performance by simulating real user behavior while browsing a site. The purpose of RUM is to understand website performance from the user's perspective, including load times, page rendering effects, loading status of page elements, and interaction responses. RUM performance inspections are primarily used for client-side websites such as e-commerce sites, financial sites, entertainment sites, etc., which all need to provide users with a fast and smooth browsing experience. By analyzing RUM performance results, developers can quickly understand the actual user experience and improve website performance accordingly.

## Prerequisites

1. An application has already been integrated into Guance’s [User Analysis](../../real-user-monitoring/index).
2. Set up a self-hosted [DataFlux Func (Automata)](https://func.guance.com/#/) or activate the [DataFlux Func (Automata)](../../dataflux-func/index.md).
4. Create an API Key for operations in Guance's "Management / API Key Management" section.

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider using the same operator and region as your current Guance SaaS deployment [in the same location](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspections

In the self-hosted DataFlux Func, install "Guance Self-Hosted Inspection (RUM Performance)" via the "Script Market" and configure the Guance API Key to complete the setup.

Select the required inspection scenario from the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose Deploy to start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create and trigger configurations that can be viewed directly via the provided links.

![image](../img/success_checker.png)

## Configuring Inspections

Configure the inspection filters in either the Guance Studio under Monitoring - Smart Inspection module or in the auto-created startup script in DataFlux Func. Refer to the two configuration methods below.

### Configuring Inspections in Guance

![image](../img/rum_performance03.png)

#### Enable/Disable
RUM performance inspections are enabled by default but can be manually disabled. Once enabled, it will inspect the configured RUM performance settings.

#### Editing
Smart inspections for "RUM Performance" support manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the smart inspection list to edit the inspection template.

* Filter Conditions: Configure `app_name` for applications.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

Click Edit in the parameter entry, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../img/rum_performance04.png)

You can refer to the following JSON format to configure multiple application information:

```json
// Configuration Example:
	configs
    	app_name_1
    	app_name_2
```

> **Note**: In the self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to sample code configuration). Note that parameters configured in the Guance Studio will override those set in the custom inspection handling function.

### Configuring Inspections in DataFlux Func

In DataFlux Func, after configuring the necessary filtering conditions, you can test by clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or modify configurations in Guance's "Monitoring / Smart Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_performance__main as main

# Support for using filtering functions to filter inspected objects, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter app_name based on custom criteria, return True for matching, False otherwise
    return True｜False
    '''
    if app_names in ['app_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM Performance Inspection', fixed_crontab='*/15 * * * *', timeout=900)
def run(configs=None):
    """
    Parameters:
        configs: Multiple `app_name_1` can be specified (separated by new lines), unspecified means inspect all apps.

    Configuration Example:
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumPerformanceCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

Guance will perform inspections based on the current RUM performance status. When RUM performance metrics are abnormal, smart inspections generate corresponding events. Click the **View Related Events** button in the operation menu on the right side of the smart inspection list to view related anomaly events.

![image](../img/rum_performance05.png)

### Event Details Page
Clicking **Event**, you can view the details page of the smart inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the configured filter conditions in the smart inspection, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../img/rum_performance06.png)

#### Event Details

RUM performance inspections monitor three core performance metrics: LCP, FID, CLS. When one of these metrics is abnormal, it generates a corresponding event report.

* Event Overview: Describes the object and content of the anomaly inspection event.
* Abnormal Page List: View the LCP, FID, CLS metric details for the affected pages.
* Page Details: View the abnormal time, page URL, and abnormal value of the metric, and click the page URL to further analyze the anomaly.
* Affected User Samples: View the user IDs, session IDs, and usernames affected by the abnormal page, and click the session ID to see the impact on the user.
* Improvement Suggestions: Provide optimization recommendations for the current abnormal metric.

![image](../img/rum_performance07.png)

![image](../img/rum_performance08.png)

![image](../img/rum_performance09.png)

#### History

Supports viewing the detected object, anomaly/recovery times, and duration.

![image](../img/rum_performance10.png)

#### Related Events
Supports viewing related events through filtered fields and selected time components.

![image](../img/rum_performance11.png)

## Common Issues
**1. How to configure the frequency of RUM performance inspections**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing custom inspection handling functions, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis in the RUM performance inspection report**

When there is no anomaly analysis in the inspection report, check the current `datakit` data collection status.

**3. Under what circumstances will RUM performance inspection events be generated**

If the configured frontend application has LCP > 2.5s, FID > 100ms, or CLS > 0.1, an alert event will be generated.

**4. What to do if previously normal scripts encounter errors during inspections**

Update the referenced script set in the DataFlux Func Script Market. Check the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to view the update records and ensure timely updates.

**5. Why does the Startup script set not change during script upgrades**

Delete the corresponding script set first, then click Upgrade to reconfigure the Guance API key and complete the upgrade.

**6. How to determine if the inspection is effective after enabling**

In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can validate the script by clicking Execute. If it shows "Executed Successfully X minutes ago," the inspection is running effectively.