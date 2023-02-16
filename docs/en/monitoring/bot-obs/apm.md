# APM Intelligent Inspection

---

## Background

「APM Intelligent Inspection」is based on APM root cause analysis detector, select the `service` 、 `resource` 、 `project` 、 `env` information to be tested, and perform intelligent inspection of APM on a regular basis to automatically analyze the upstream and downstream information of the service through application service index exceptions, and confirm the root cause of the abnormal problem for the application.

## Preconditions

1. In Guance「APM」that already have access applications.
2. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
3. Open DataFlux Func's [Script Marketplace](https://func.guance.com/doc/script-market-basic-usage/)
4. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)
5. In DataFlux Func，by「Script Marketplace」to install「Guance  Core Package」「Guance Algorithm Library」「Guance  script (APM Performance)」.
6. In DataFlux Func, write  patrol processing functions.
7. In DataFlux Func , by「Manage / Auto-trigger Configurations」,create an automatic trigger configuration for the written function.

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable APM Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/apm11.png)

## Start Intelligent Inspection

### Register detection items in Guance

After configuring the inspection in DataFlux Func, you can run the test by selecting the `run()` method directly on the page, and then you can view and configure it in the Guance "Monitoring / Intelligent Inspection" after clicking Publish.

![image](../img/apm01.png)



### Configure APM Intelligent Inspection in Guance

  ![image](../img/apm02.png)



#### Enable/Disable

APM Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured APM.



#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Inspection "APM Intelligent Inspection" supports users to manually add filtering conditions, and click the "Edit" button under the operation menu on the right side of the Intelligent Inspection list to edit the inspection template.

  * Filter criteria: configuration application project service belongs to the project, service_sub including service, environment, version by ":" stitching.
  * Alarm notification: support for selecting and editing alarm policies, including the level of events to be notified, notification objects, and alarm silence period, etc.

 Configure the entry parameters by clicking on Edit and then fill in the corresponding detection object in the parameter configuration and click Save to start the inspection：

  ![image](../img/apm03.png)

You can refer to the following JSON configuration for multiple projects, environments, versions and services

  ```json
   // Configuration example:
      configs = [
          {"project": "project1", "service_sub": "service1:env1:version1"},
          {"project": "project2", "service_sub": "service2:env2:version2"}
      ]
  ```



## View Events

 Based on the Guance inspection algorithm, Intelligent Inspection will look for abnormalities in APM metrics, such as `resource` abnormalities occurring suddenly. For abnormal conditions, Intelligent Inspection will generate corresponding events, and you can check the corresponding abnormal events by clicking the "View Related Events" button under the operation menu on the right side of the Smart Inspection list.

![image](../img/apm04.png)



### Event Details page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

  * Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
  * Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.



#### Basic Properties

  * Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
  * Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering.

  ![image](../img/apm05.png)



#### Event Details

  * Event overview: describes the object and content of the exception patrol event
  * Error trend: you can view the performance metrics of the current application for nearly 1 hour
  * Abnormal impact: you can view the services and resources affected by the abnormal service of the current link
  * Abnormal link sampling: view the detailed error time, service, resource and link ID; Click Services and Resources to enter the corresponding data explorer; Click the link ID to enter the specific link details page.

![image](../img/apm06.png)
  ![image](../img/apm07.png)



#### History

 Support to view the detection object, exception/recovery time and duration.

 ![image](../img/apm08.png)



#### Related events

  Support to view related events through filtering fields and selected time component information.

  ![image](../img/apm09.png)



## FAQ

**1. How to configure the detection frequency of the APM Intelligent Inspection**

  **In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` to the decorator when writing the  patrol handler function, and then configure it in `Management / Auto-trigger Configuration'.

**2. There may be no exception analysis when triggered by APM Intelligent Inspection**

  When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3. Under what circumstances will an APM Intelligent Inspection event be generated**

  Use metrics such as error rate and P90 as entry points to trigger the collection of alarm information and root cause analysis when one of these metrics changes abnormally and has an upstream and downstream link impact.

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

  

  
