# RUM Performance Inspection
---

## Background

Real User Monitoring (RUM) is an application performance monitoring technology designed to evaluate website performance by simulating real user behavior while browsing the site. The purpose of RUM is to understand website performance from the user's perspective, including load times, page rendering effects, loading status of page elements, and interaction responses. The use cases for RUM performance inspection mainly involve client-side websites such as e-commerce sites, financial sites, entertainment sites, etc., which all need to provide users with a fast and smooth browsing experience. By analyzing RUM performance results, developers can quickly understand the actual user experience and improve website performance accordingly.

## Prerequisites

1. <<< custom_key.brand_name >>>「[User Analysis](../../real-user-monitoring/index)」already has integrated applications.
2. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/), or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
4. Create an [API Key](../../management/api-key/open-api.md) for operations in <<< custom_key.brand_name >>>「Manage / API Key Management」

> **Note**: If you are considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current <<< custom_key.brand_name >>> SaaS deployment [same provider and region](../../../getting-started/necessary-for-beginners/select-site/).

## Initiating Inspection

In your self-hosted DataFlux Func, install 「 <<< custom_key.brand_name >>> Self-hosted Inspection (RUM Performance)」from the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

Select the desired inspection scenario in the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) connection, then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and trigger configuration. You can directly jump to view the corresponding configuration via the provided link.

![image](../img/success_checker.png)

## Configuring Inspection

Configure the desired filtering conditions for the inspection in either the <<< custom_key.brand_name >>> Studio under Monitoring - Smart Inspection module or in the auto-created startup script of DataFlux Func. Refer to the two configuration methods below.

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/rum_performance03.png)

#### Enable/Disable
RUM performance inspection defaults to "Enabled". It can be manually "Disabled". Once enabled, it will inspect the configured RUM performance inspection settings.

#### Editing
Smart Inspection 「RUM Performance Inspection」 supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the smart inspection list to edit the inspection template.

* Filter Conditions: Configure `app_name` for the application name.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods.

Click Edit in the configuration entry parameters, fill in the corresponding detection object in the parameter configuration, and click Save to start the inspection:

![image](../img/rum_performance04.png)

You can refer to the following JSON configuration for multiple application information:

```json
// Configuration Example:
 	configs
    	app_name_1
    	app_name_2
```

> **Note**: In the self-hosted DataFlux Func, when writing custom inspection processing functions, you can also add filter conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the custom inspection processing function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filter conditions for the inspection, you can test by selecting the `run()` method directly on the page. After clicking Publish, the script will execute normally. You can also view or change configurations in <<< custom_key.brand_name >>>「Monitoring / Smart Inspection」.

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter app_name, customize conditions for matching app_name, return True if matched, False otherwise
    return True｜False
    '''
    if app_names in ['app_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM Performance Inspection', fixed_crontab='*/15 * * * *', timeout=900)
def run(configs=None):
    """
    Parameters:
        configs: Multiple app_name_1 can be specified (separated by new lines), unspecified means inspect all apps

    Configuration Example:
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumPerformanceCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions that are executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```

## Viewing Events

<<< custom_key.brand_name >>> inspects RUM performance based on the current state. When RUM performance metrics are abnormal, smart inspections generate corresponding events. Click the **View Related Events** button in the operation menu on the right side of the smart inspection list to view corresponding anomaly events.

![image](../img/rum_performance05.png)

### Event Details Page
Click **Event** to view the details page of the smart inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history records, and related events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions configured in the smart inspection, support copying detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user analysis, synthetic tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../img/rum_performance06.png)

#### Event Details

RUM performance inspection monitors three core performance metrics: LCP, FID, CLS. When one of these metrics is abnormal, it generates a corresponding event report.

* Event Overview: Describes the object and content of the anomaly inspection event.
* Anomalous Page List: View LCP, FID, CLS metric details for the corresponding pages.
* Page Details: View the abnormal time, page URL, abnormal metric values, etc., for the anomalous metrics. Click the page URL to navigate to the front-end page for further analysis.
* Affected User Samples: View user IDs, session IDs, usernames, etc., affected by the anomalous page. Click the session ID to view the impact on users.
* Improvement Suggestions: Provide optimization recommendations for the current abnormal metrics.

![image](../img/rum_performance07.png)

![image](../img/rum_performance08.png)

![image](../img/rum_performance09.png)

#### History Records

Support viewing detected objects, anomaly/recovery times, and duration.

![image](../img/rum_performance10.png)

#### Related Events
Support viewing related events through filtered fields and selected time components.

![image](../img/rum_performance11.png)

## Common Issues
**1. How to configure the inspection frequency of RUM performance**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing custom inspection processing functions, then configure it in 「Manage / Automatic Trigger Configuration」.

**2. Why might there be no anomaly analysis when RUM performance inspection triggers**

If there is no anomaly analysis in the inspection report, check the current `datakit` data collection status.

**3. Under what circumstances will RUM performance inspection events be generated**

If the configured front-end application experiences LCP metrics > 2.5s, FID metrics > 100ms, or CLS metrics > 0.1, an alert event will be generated.

**4. What should I do if previously running scripts encounter errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. Check the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) for updates to the script market to facilitate timely script updates.

**5. What should I do if the script set in Startup remains unchanged during inspection script upgrade**

Delete the corresponding script set first, then click the Upgrade button to configure the <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection is effective after enabling**

In 「Manage / Automatic Trigger Configuration」, check the inspection status. First, it should be Enabled, then verify the inspection script by clicking Execute. If it shows successful execution within the last xxx minutes, the inspection is running effectively.