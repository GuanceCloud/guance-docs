# Kubernetes Pod Abnormal Restart Intelligent Inspection

---

## Background

Kubernetes helps users automatically schedule and expand containerized applications, but modern Kubernetes environments are becoming more and more complex. When platform and application engineers need to investigate events in dynamic and containerized environments, finding the most meaningful signals may involve many trial and error steps. Intelligent Inspection can filter exceptions according to the current search context, thus speeding up incident investigation, reducing the pressure on engineers, reducing the average repair time and improving the end-user experience.

## Preconditions

1. Open「[container data collection](https://docs.guance.com/datakit/container/) 」in Guance Cloud
2. Offline deployment of [DataFlux Func](https://func.guance.com/#/)
3. Open DataFlux Func's [Script Marketplace](https://func.guance.com/doc/script-market-basic-usage/)
4. In Guance Cloud「Management / API Key Management」create [API Key](../../management/api-key/open-api.md)
5. In DataFlux Func，by「Script Marketplace」to install「Guance Cloud Self-Built Core Package」「Guance Cloud Algorithm Library」「Guance Cloud Self-Built script (APM Performance)」.
6. In DataFlux Func, write self-built patrol processing functions.
7. In DataFlux Func , by「Manage / Auto-trigger Configurations」,create an automatic trigger configuration for the written function.

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance Cloud SaaS[on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Configure Intelligent Inspection

In DataFlux Func create a new set of scripts to enable Kubernetes Pod Abnormal Restart Intelligent Inspection configuration. After creating a new script set, select the corresponding script template to save when creating the Inspection script, and change it as needed in the resulting new script file.

![image](../../img/k8s-pod-restart11.png)

## Start Intelligent Inspection

### Register detection items in Guance Cloud

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance Cloud "Monitoring/Intelligent Check".

![image](../../img/k8s-pod-restart01.png)

### Configure Kubernetes Pod Abnormal Restart Intelligent Inspection in Guance cloud

![image](../../img/k8s-pod-restart02.png)

#### Enable/Disable

  The default state of intelligent check is "disabled", which can be manually "enabled". The Pod in the configured Kubernetes cluster can be patrolled after being turned on.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

  Intelligent check "Kubernetes Pod Abnormal Restart Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

  * Filter Criteria: Configure cluster_name (cluster name, optional, all namespaces detected when not configured) and namespaces to be detected (namespace, required) that need to be inspected by Kubernetes.
  * Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period.

  Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start patrol inspection:

![image](../../img/k8s-pod-restart03.png)

  You can refer to the following JSON to configure multiple clusters and namespace information:

  ```json
   // Configuration example: namespace can be configured with multiple or single
      configs =[
          {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
          {"cluster_name": "yyy","namespace": "yyy1"}
      ]
  ```

### View Events

  Intelligent check is based on the Guance Cloud check algorithm, which will find out whether there will be abnormal restart of Pod in the currently configured cluster. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../../img/k8s-pod-restart04.png)

### Event Details Page

  Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

  * Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check.
  * Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events.

#### Basic Properties

  * Detection dimensions: Filter criteria based on smart patrol configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
  * Extended attributes: Supports replication in the form of `key/value` after selecting extended attributes, and forward/reverse filtering.

  ![image](../../img/k8s-pod-restart05.png)

#### Event Details

  * Event Overview: Describe the object and content of the anomaly inspection event.
  * Exception pod: You can view the status of exception pod under the current namespace.
  * container status: Detailed error time, container ID status, current resource status and container type can be viewed; Clicking the container ID will bring you to the specific container details page.

![image](../../img/k8s-pod-restart06.png)
  ![image](../../img/k8s-pod-restart07.png)

#### History

  Support to view detection objects, exception/recovery time and duration.

 ![image](../../img/k8s-pod-restart08.png)

#### Associated Events

  Support to view associated events by filtering fields and selected time component information.

 ![image](../../img/k8s-pod-restart09.png)



#### Kubernetes Metric

The Kubernetes monitoring view in the event allows you to view finer-grained information corresponding to the exception information and possible factors affecting it.

![image](../../img/k8s-pod-restart10.png)

## FAQ

  **1.How to configure the detection frequency of Kubernetes Pod abnormal restart check**

  * In the custom DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing the custom check processing function, and then configure it in "Administration/Automatic Trigger Configuration".

  **2.Kubernetes Pod exception restart check triggered without exception analysis**

  Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report.

  **3.Under what circumstances will Kubernetes Pod abnormal restart patrol event occur**

  Taking the proportion of restarted pod number under cluster_name + namespace as the entry, when the metric rises in recent 30 minutes, it triggers the logic of generating events and performs root cause analysis.

  **4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

  
