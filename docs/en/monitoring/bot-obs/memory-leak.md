# Memory leak Intelligent Inspection

---

## Background

"Memory leak" is based on the memory anomaly analysis detector, which regularly checks the host intelligently, analyzes the root cause of the host with memory anomaly, determines the process and pod information corresponding to the abnormal time point, and analyzes whether there is memory leak in the current workspace host.

## Preconditions

1. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
2. Open DataFlux Func's [Script Marketplace](https://func.guance.com/doc/script-market-basic-usage/)
3. In Guance Cloud「Management / API Key Management」create [API Key](../../management/api-key/open-api.md)
4. In DataFlux Func，by「Script Marketplace」to install「Guance Cloud Self-Built Core Package」「Guance Cloud Algorithm Library」「Guance Cloud Self-Built script (Memory leak)」.
5. In DataFlux Func, write self-built patrol processing functions.
6. In DataFlux Func , by「Manage / Auto-trigger Configurations」,create an automatic trigger configuration for the written function.

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance Cloud SaaS[on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable Memory leak Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../img/memory-leak11.png)

## Start Intelligent Inspection

### Register detection items in Guance Cloud 

After configuring the inspection in DataFlux Func, you can run the test by selecting the `run()` method directly on the page, and then you can view and configure it in the Guance Cloud "Monitoring / Intelligent Inspection" after clicking Publish.

![image](../img/memory-leak01.png)


### Configure Memory leak Intelligent Inspection in Guance Cloud

![image](../img/memory-leak02.png)

#### Enable/Disable

Memory leak Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured host list.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent inspection "Memory leak inspection" supports users to manually add filtering conditions, under the operation menu on the right side of the intelligent inspection list, click the "Edit" button, you can edit the inspection template.

* Filter conditions: Configure the host hosts that need to be inspected.
* Alarm notification: support for selecting and editing the alarm policy, including the event level to be notified, the notification object, and the alarm silence period, etc.

Configure the entry parameters and click Edit to fill in the corresponding detection object in the parameter configuration and click Save to start the inspection:

![image](../img/memory-leak03.png)

You can refer to the following JSON to configure multiple host information:

```json
 // Configuration example:
  configs = {
        "hosts": ["localhost"]
    }
```

>  **Note**: In the DataFlux Func, you can also add filtering conditions when writing inspection processing functions (refer to the sample code configuration), it should be noted that the parameters configured in the observation cloud studio will override the parameters configured when writing inspection processing functions.

## View Events

This inspection will scan the memory utilization information of the last 6 hours, and once the abnormal state appears, the intelligent inspection will generate corresponding events, and you can check the corresponding abnormal events by clicking the "View Related Events" button under the operation menu on the right side of the intelligent inspection list.

![image](../img/memory-leak04.png)

### Event Details Page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

* Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
* Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.

#### Basic Properties

* Detection dimension: Based on the filtering conditions configured by Intelligent Inspection, it supports copying and adding the detection dimension `key/value` to the filtering and viewing the related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
* Extended Attributes: Supports `key/value` replication and forward/reverse filtering after selecting extended attributes.

![image](../img/memory-leak05.png)

#### Event Details

* Event overview: Describe the object, content, etc. of the abnormal patrol event.
* Abnormality details: You can view the change of utilization of the current abnormal host in the past 6 hours.
* Abnormality analysis: You can display the list of processes (Pod list) of the Top 10 abnormal host memory usage

![image](../img/memory-leak06.png)

#### History

Support to view the detection object, exception/recovery time and duration.

![image](../img/memory-leak07.png)

#### Related events

Support to view related events through filtering fields and selected time component information.

![image](../img/memory-leak08.png)

## FAQ

**1. How to configure the detection frequency of memory leak Intelligent Inspection**

* In the DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` to the decorator when writing the inspection handler function, and then configure it in the `Management / Auto-trigger Configuration'.

**2. Memory leak Intelligent Inspection may not have exception analysis when triggered**

When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3. An abnormal error was found in a previously running script during the inspection**

Please update the referenced script set in the script marketplace of DataFlux Func. You can check the update log of the script marketplace through [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to update the script instantly.
