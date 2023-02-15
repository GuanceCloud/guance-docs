# RUM Performance Intelligent Integration
---

## Background

Real User Monitoring (RUM) is an application performance monitoring technology designed to evaluate website performance by simulating the behavior of real users browsing the site. The goal of RUM is to understand website performance from the user's perspective, including website load times, page rendering effects, page element loading status, and interaction response. The main use case of RUM performance inspection is for client-side websites, such as e-commerce websites, financial websites, entertainment websites, and so on, which all need to provide users with a fast and smooth browsing experience. By analyzing the results of RUM performance, developers can quickly understand the user's actual experience and improve website performance.

## Preconditions

1. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
2. Open DataFlux Func's [Script Marketplace](https://func.guance.com/doc/script-market-basic-usage/)
3. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)
4. In DataFlux Func，by「Script Marketplace」to install「Guance  Core Package」「Guance Algorithm Library」「Guance  script (RUM Performance)」.
5. In DataFlux Func, write  patrol processing functions.
6. In DataFlux Func , by「Manage / Auto-trigger Configurations」,create an automatic trigger configuration for the written function.

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/).

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable RUM Performance Intelligent Integration configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/rum_performance01.png)

## Start Intelligent Inspection

### Register detection items in Guance

In DataFlux Func, after the detection is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance "Monitoring/Intelligent Patrol".

![image](../img/rum_performance02.png)


### Configure RUM Performance Intelligent Integration in Guance

![image](../img/rum_performance03.png)

#### Enable/Disable
RUM Performance Intelligent Integration is "enabled" by default and can be manually "disabled". Once enabled, it will inspect the configured RUM Performance Intelligent Integration configuration list.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

Intelligent Check "RUM Performance Intelligent Integration" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter criteria: Configure the app_name to specify the name of the application.
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/rum_performance04.png)

You can refer to the following JSON configuration information for multiple applications.

```json
// configuration example:
    configs = {
        "app_names": ["app_name_1", "app_name_2"]  # Application name list
    }
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

RUM Performance Intelligent Inspection will detect three core performance indicators: LCP, FID, and CLS. When one of these indicators is abnormal, an event report will be generated based on the abnormal indicator.

- Event Overview: describes the object and content of the abnormal inspection event.
- Abnormal Page List: You can view the details of LCP, FID, and CLS indicators for the corresponding page.
- Page Details: includes the abnormal time, page address, and abnormal values of the indicators. By clicking on the page address, you can further analyze the abnormality by jumping to the corresponding front-end page.
- Sample the affected users: You can view information such as user ID, session ID, and username of the affected users on the current abnormal page, and you can jump to the corresponding session to view the impact on users by session ID.
- Suggestions: provides optimization and improvement suggestions for the current abnormal indicator.

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







