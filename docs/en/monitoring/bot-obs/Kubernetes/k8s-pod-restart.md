# Kubernetes Pod Abnormal Restart Intelligent Inspection

---

## Background

Kubernetes helps users automatically schedule and expand containerized applications, but modern Kubernetes environments are becoming more and more complex. When platform and application engineers need to investigate events in dynamic and containerized environments, finding the most meaningful signals may involve many trial and error steps. Intelligent Inspection can filter exceptions according to the current search context, thus speeding up incident investigation, reducing the pressure on engineers, reducing the average repair time and improving the end-user experience.

## Preconditions

1. Open[container data collection](https://docs.guance.com/datakit/container/) in Guance Cloud
2. Offline deployment of custom DataFlux Func
3. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of custom DataFlux Func 
4. Create an [API Key](../../management/api-key/open-api.md) for action in Guance Cloud "management/API Key management"
5. In the custom DataFlux Func, install Guance Cloud Custom Check Core Package, Guance Cloud Algorithm Library and Guance Cloud Custom Check (K8S-Pod Restart Detection)" through "Script Market"
6. In the DataFlux Func, write the custom check processing function
7. In the custom DataFlux Func, create auto-trigger configurations for the functions you write through "Manage/Auto-trigger Configurations."

## Configuration Check

Create a new script set in the custom DataFlux Func to open the Kubernetes Pod exception restart check configuration.

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as k8s_pod_restart


# Guance Cloud space API_KEY configuration (user self-configuration)
API_KEY_ID  = 'wsak_xxx'
API_KEY     = '5Kxxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent check configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\intelligent check. If both sides are configured, the filters parameter in the script will take effect first.

def filter_namespace(cluster_namespaces):
    '''
    Filter namespace customize the conditions that meet the requirements of namespace, return True for matching, and return False for mismatching.
    return True｜False
    '''

    cluster_name = cluster_namespaces.get('cluster_name','')
    namespace = cluster_namespaces.get('namespace','')
    if cluster_name in ['k8s-prod']:
        return True

'''  
Task configuration parameters use:
@DFF.API('K8S-Pod abnormal restart check', fixed_crontab='*/30 * * * *', timeout=900)

fixed_crontab: Fixed execution frequency "every 30 minutes"
timeout: Task execution timeout, controlled at 15 minutes.
'''    

# Kubernetes Pod abnormal restart check; users do not need to modify
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('K8S-Pod abnormal restart check', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=[]):
    """
    Parameter:
        configs：
            Configure cluster_name to be detected (cluster name, optional, not configured to be detected by namespace)
            Configure the namespace to be detected (namespace, required)

        Configuration example: namespace can be configured with multiple or single
        configs = [
        {
            "cluster_name": "xxx",
            "namespace": ["xxx1", "xxx2"]
        },
        {
            "cluster_name": "yyy",
            "namespace": "yyy1"
        }
        ]

    """
    checkers = [
         # Configure Kubernetes Pod abnormal restart check
        k8s_pod_restart.K8SPodRestartCheck(configs=configs, filters=[filter_namespace]),
    ]

    Runner(checkers, debug=False).run()
```

## Open Check

### Register a Test Item in Guance cloud

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance Cloud "Monitoring/Intelligent Check".

![image](../../img/k8s-pod-restart01.png)

### Configure Kubernetes Pod to Restart the Check Anomaly in Guance cloud

![image](../../img/k8s-pod-restart02.png)

#### Enable/Disable

  The default state of intelligent check is "disabled", which can be manually "enabled". The Pod in the configured Kubernetes cluster can be patrolled after being turned on.

#### Export

  Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.

#### Edit

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

#### Basic Attributes

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

  

  
