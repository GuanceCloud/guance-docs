# Kubernetes Health Intelligent Integration
---

## Background

Nowadays, Kubernetes has taken over the entire container ecosystem and acts as the brain for distributed container deployment, aiming to manage service-oriented applications using containers distributed across clusters of hosts. Kubernetes provides mechanisms for application deployment, scheduling, updates, service discovery, and scaling. However, how to ensure the health of Kubernetes nodes? Through smart inspections, information retrieval and problem discovery based on the current node's resource status, application performance management, service failure logs, etc. can be used to speed up event investigation, reduce engineers' pressure, decrease average repair time, and improve the end-user experience.

## Preconditions

1. Open「[container data collection](../../../../datakit/container/) 」in Guance
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../../dataflux-func/index.md)
4. In Guance「Management / API Key Management」create [API Key](../../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (K8S Health Inspection)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../../img/k8s_health03.png)

#### Enable/Disable

Kubernetes health Intelligent Integration is enabled by default and can be manually disabled. After being enabled, it will inspect the configured Kubernetes health check configuration list.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

  Intelligent check "Kubernetes Pod Abnormal Restart Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

  * Filter Criteria: Configure the `cluster_name` for the cluster name and `host` for the node that needs to be monitored.
  * Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period.

  Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start patrol inspection:

![image](../../img/k8s_health04.png)

  You can refer to the following to configure multiple clusters and namespace information:

```json
    // Configuration example：
    configs ：
         cluster_name_1
         cluster_name_2
         cluster_name_3
```

> Note: When writing self-built inspection processing functions in DataFlux Func, you can also add filter conditions (refer to the sample code configuration). Note that the parameters configured in the Guance Studio will override the parameters configured when writing self-built inspection processing functions.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_health__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_cluster(cluster_name_k8s):
    '''
    Filter the "cluster_name_k8s" metric, customize the conditions that meet the requirements for the "cluster_name_k8s" metric, and return True if there is a match, and False if there is no match.
    return True｜False
    '''
    if cluster_name_k8s in ['ningxia']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-健康巡检', timeout=900, fixed_crontab='*/15 * * * *')
def run(configs=None):
    """
    The inspection script depends on the k8s "cluster_name_k8s" metric. Before starting the inspection, it is necessary to enable the "cluster_name_k8s" metric configuration for container collection.

    Parameters：
        configs：
            Configure the cluster_name that needs to be checked (cluster name, if not configured, all will be checked.)

        configs example：
             cluster_name_1
             cluster_name_2
             cluster_name_3

    """
    checkers = [
        k8s__health__inspection.K8SHealthCheck(configs=configs, filters=[filter_cluster]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



## View Events

Guance will perform inspections based on the current state of the Kubernetes cluster. When memory, disk, CPU, or POD exceptions are detected, the smart inspection will generate corresponding events. Click the "View Related Events" button in the smart inspection list's action menu to view the corresponding exception events.

![image](../../img/k8s_health05.png)

### Event Details Page

  Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

  * Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check.
  * Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events.

#### Basic Properties

  * Detection dimensions: Filter criteria based on smart patrol configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data.
  * Extended attributes: Supports replication in the form of `key/value` after selecting extended attributes, and forward/reverse filtering.

![image](../../img/k8s_health06.png)

#### Event Details

##### Memory usage Abnormal

![image](../../img/k8s_health07.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal Details: Displays details of memory-related abnormal performance metrics.
* Top 5 Memory Usage List: Displays information of the top 5 PODs with the highest memory usage. Clicking on a POD takes you to its details page to view more information.

##### Disk usage Abnormal

![image](../../img/k8s_health08.png)

* Event overview: Describes the object and content of the exception inspection event
* Abnormal details: Displays details of the disk abnormal performance metric
* Abnormal analysis: Displays the usage of the host with abnormal disk usage. You can click on the host to jump to the host details page for more information.

##### CPU usage Abnormal

![image](../../img/k8s_health09.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal Details: Shows the details of the CPU usage abnormal index.
* Abnormal Containers: Displays the top 10 POD information with abnormal CPU usage, and clicking on the POD can navigate to the POD details page to view more information.

##### Pod Pending Over-representation

![image](../../img/k8s_health10.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal Pod: Displays detailed information about the abnormal Pod, and you can also jump to the corresponding Pod details by name.
* Pod Logs: Displays the logs of the corresponding abnormal Pod, and you can jump to the corresponding abnormal details by log source or abnormal Pod.

#### History

  Support to view detection objects, exception/recovery time and duration.

![image](../../img/k8s_health11.png)

#### Associated Events

  Support to view associated events by filtering fields and selected time component information.

![image](../../img/k8s_health12.png)

## FAQ
**1. How to configure the detection frequency of Kubernetes Health Intelligent IntegrationInspection**

In the  DataFlux Func, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator when writing the intelligent inspection processing function, and then configure it in "Administration/Auto-trigger Configuration".

**2. There may be no anomaly analysis when Kubernetes Health Intelligent Integration is triggered**

Check the current data collection status of `datakit` when there is no anomaly analysis in the patrol report..

**3. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.







