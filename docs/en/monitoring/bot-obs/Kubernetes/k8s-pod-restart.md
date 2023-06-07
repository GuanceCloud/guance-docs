# Kubernetes Pod Abnormal Restart Intelligent Inspection

---

## Background

Kubernetes helps users automatically schedule and expand containerized applications, but modern Kubernetes environments are becoming more and more complex. When platform and application engineers need to investigate events in dynamic and containerized environments, finding the most meaningful signals may involve many trial and error steps. Intelligent Inspection can filter exceptions according to the current search context, thus speeding up incident investigation, reducing the pressure on engineers, reducing the average repair time and improving the end-user experience.

## Preconditions

1. Open「[container data collection](../../../../datakit/container/) 」in Guance
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../../dataflux-func/index.md)
4. In Guance「Management / API Key Management」create [API Key](../../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (K8S-Pod Restart Detection)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [Guance Node](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

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

  You can refer to the following to configure multiple clusters and namespace information:

  ```json
   // Configuration example: namespace can be configured with multiple or single
      configs =[
          {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
          {"cluster_name": "yyy","namespace": "yyy1"}
      ]
  ```

> Note: When writing self-built inspection processing functions in DataFlux Func, you can also add filter conditions (refer to the sample code configuration). Note that the parameters configured in the Guance Studio will override the parameters configured when writing self-built inspection processing functions.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_namespace(cluster_namespaces):
    '''
    Filter the host, customize the conditions that meet the requirements for the host, and return True if there is a match, and False if there is no match.
Return True|False.
    '''
     cluster_name = cluster_namespaces.get('cluster_name','')
     namespace = cluster_namespaces.get('namespace','')
     if cluster_name in ['xxxx']:
         return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Pod 重启检测巡检', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    """
        Optional parameters:
        configs: (If not configured, all will be checked by default. If configured, please follow the content below)

        Configure the cluster_name that needs to be checked (cluster name , optional, if not configured, it will be checked based on namespace)
        Configure the namespace that needs to be checked (namespace, required)
        Example: multiple or single namespaces can be configured.
        configs =[
            {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
            {"cluster_name": "yyy","namespace": "yyy1"}
        ]

    """
    checkers = [
        k8s_pod_restart.K8SPodRestartCheck(configs=configs, filters=[filter_namespace]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

### View Events

  Intelligent check is based on the Guance check algorithm, which will find out whether there will be abnormal restart of Pod in the currently configured cluster. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

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

  
