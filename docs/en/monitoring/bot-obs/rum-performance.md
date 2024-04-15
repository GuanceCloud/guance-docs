# RUM Performance Intelligent Integration
---

## Background

Real User Monitoring (RUM) is an application performance monitoring technology designed to evaluate website performance by simulating the behavior of real users browsing the site. The goal of RUM is to understand website performance from the user's perspective, including website load times, page rendering effects, page element loading status, and interaction response. The main use case of RUM performance inspection is for client-side websites, such as e-commerce websites, financial websites, entertainment websites, and so on, which all need to provide users with a fast and smooth browsing experience. By analyzing the results of RUM performance, developers can quickly understand the user's actual experience and improve website performance.

## Preconditions

1. In Guance「 [user access monitoring](../../real-user-monitoring/index) 」that already have access applications.
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
4. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/).

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (RUM Performance)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/rum_performance03.png)

#### Enable/Disable
RUM Performance Intelligent Integration is "enabled" by default and can be manually "disabled". Once enabled, it will inspect the configured RUM Performance Intelligent Integration configuration list.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Check "RUM Performance Intelligent Integration" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: Configure the app_name to specify the name of the application.
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/rum_performance04.png)

You can refer to the following to configuration information for multiple applications.

```json
// configuration example:
 	configs:
    	app_name_1
    	app_name_2
```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the intelligent inspection processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the intelligent inspection processing function.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_appid(data):
    appid = data[0]
    '''
    Filter `app_name`, customize the conditions for matching the required `app_name`, and return True if matched, and False if not matched.
    return True｜False
    '''
    if app_names in ['app_xxxxxxxxxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('RUM 性能巡检', fixed_crontab='*/15 * * * *', timeout=900)
def run(configs=None):
    """
     Optional parameters：
        configs：Multiple `app_name_1` can be specified (concatenated by line breaks). If not specified, all apps will be checked.

    config example：
        configs
            app_name_1
            app_name_2
    """
    checkers = [
        main.RumPerformanceCheck(configs=configs, filters=[filter_appid]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



## View Events

Guance will conduct inspections based on the current RUM performance of the application. When RUM performance metrics are detected as abnormal, the smart inspection will generate corresponding events. Click the "View Related Events" button in the operation menu on the right side of the smart inspection list to view the corresponding abnormal events.

![image](../img/rum_performance05.png)

### Event Details page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Properties

* Detection Dimensions: Filter criteria based on intelligent check configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security check, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Supports replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/rum_performance06.png)

#### Event details

RUM Performance Intelligent Inspection will detect three core performance metrics: LCP, FID, and CLS. When one of these metrics is abnormal, an event report will be generated based on the abnormal metric.

- Event Overview: describes the object and content of the abnormal inspection event.
- Abnormal Page List: You can view the details of LCP, FID, and CLS metrics for the corresponding page.
- Page Details: includes the abnormal time, page address, and abnormal values of the metrics. By clicking on the page address, you can further analyze the abnormality by jumping to the corresponding front-end page.
- Sample the affected users: You can view information such as user ID, session ID, and username of the affected users on the current abnormal page, and you can jump to the corresponding session to view the impact on users by session ID.
- Suggestions: provides optimization and improvement suggestions for the current abnormal metric.

![image](../img/rum_performance07.png)

![image](../img/rum_performance08.png)

![image](../img/rum_performance09.png)

#### History

Support to view detection objects, exception/recovery time and duration.

![image](../img/rum_performance10.png)

#### Related events

Support to view associated events by filtering fields and selected time component information.

![image](../img/rum_performance11.png)

## FAQ
**1.How to configure the detection frequency of RUM Performance Intelligent Inspection**

In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2.There may be no anomaly analysis when RUM Performance Intelligent Inspection is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report..

**3.Under what circumstances will RUM Performance Intelligent Inspection events be generated?**

An alert event will be generated if the front-end application's LCP metric is greater than 2.5s, FID metric is greater than 100ms, or CLS metric is greater than 0.1.

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**5. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the wor



