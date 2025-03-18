# Kubernetes Pod Abnormal Restart Inspection

---

## Background

Kubernetes helps users automatically schedule and scale containerized applications, but modern Kubernetes environments are becoming increasingly complex. When platform and application engineers need to investigate events in dynamic, containerized environments, finding the most meaningful signals can involve many trial-and-error steps. By using intelligent inspections, anomalies can be filtered based on the current search context, accelerating event investigation, reducing engineer stress, decreasing mean time to repair, and improving end-user experience.

## Prerequisites

1. Enable "[Container Data Collection](<<< homepage >>>/datakit/container/)" in <<< custom_key.brand_name >>>
2. Set up [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../../dataflux-func/index.md)
4. Create an [API Key](../../../management/api-key/open-api.md) for operations in <<< custom_key.brand_name >>> under "Management / API Key Management"

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current SaaS deployment of <<< custom_key.brand_name >>>.

## Enabling Inspection

In your self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-built Inspection (K8S-Pod Restart Detection)" from the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to enable it.

Select the inspection scenario you want to enable from the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../../img/create_checker.png)

After the startup script is successfully deployed, it will automatically create the startup script and automatic trigger configuration. You can directly jump to view the corresponding configuration via the provided link.

![image](../../img/success_checker.png)

## Configuring Inspection

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../../img/k8s-pod-restart02.png)

#### Enable/Disable

Intelligent inspection is **disabled** by default. You can manually **enable** it. Once enabled, it will inspect Pods in the configured Kubernetes clusters.

#### Editing

The "Kubernetes Pod Abnormal Restart Inspection" supports adding filter conditions manually. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

- Filter Conditions: Configure the cluster_name (optional, detects all namespaces if not configured) and namespace (required) for the Kubernetes cluster to be inspected.
- Alert Notifications: Supports selecting and editing alert strategies, including event severity, notification targets, and alert silence periods.

Click Edit in the configuration entry parameters, fill in the detection objects in the parameter configuration, and save to start the inspection:

![image](../../img/k8s-pod-restart03.png)

You can refer to the following JSON configuration to set multiple clusters and namespace information:

```json
// Configuration example: namespace can be configured as multiple or single
configs = [
    {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
    {"cluster_name": "yyy", "namespace": "yyy1"}
]
```

> **Note**: In your self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> studio will override those configured in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions, you can test by selecting and clicking the `run()` method directly on the page. After clicking Publish, the script will run normally. You can also view or change configurations in <<< custom_key.brand_name >>> under "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_namespace(cluster_namespaces):
    '''
    Filter host, define conditions for hosts that meet requirements, return True for matching, False otherwise
    return True｜False
    '''
    cluster_name = cluster_namespaces.get('cluster_name', '')
    namespace = cluster_namespaces.get('namespace', '')
    if cluster_name in ['xxxx']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Pod Restart Detection Inspection', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    """
    Optional parameters:
        configs: (if not configured, defaults to detecting all; follow the below content if configured)
            Configure the cluster_name (optional, detects based on namespace if not configured)
            Configure the namespace (required)

    Example: namespace can be configured as multiple or single
        configs =[
            {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
            {"cluster_name": "yyy", "namespace": "yyy1"}
        ]

    """
    checkers = [
        k8s_pod_restart.K8SPodRestartCheck(configs=configs, filters=[filter_namespace]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```

### Viewing Events

Based on <<< custom_key.brand_name >>> inspection algorithms, intelligent inspection will look for abnormal Pod restarts within the currently configured clusters. For any abnormalities, intelligent inspection will generate corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view the corresponding abnormal events.

![image](../../img/k8s-pod-restart04.png)

### Event Details Page

Click **Event** to view the details page of the intelligent inspection event, which includes event status, time of occurrence, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the configured filtering conditions of intelligent inspection, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM PV, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, supports copying in `key/value` form, forward/reverse filtering.

![image](../../img/k8s-pod-restart05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal Pod: View the status of abnormal pods in the current namespace.
* Container Status: View detailed error times, container IDs, current resource usage, and container types; clicking on the container ID will lead to the specific container detail page.

![image](../../img/k8s-pod-restart06.png)
![image](../../img/k8s-pod-restart07.png)

#### History

Supports viewing detection objects, abnormal/recovery times, and duration.

![image](../../img/k8s-pod-restart08.png)

#### Related Events

Supports viewing related events through selected filtering fields and time component information.

![image](../../img/k8s-pod-restart09.png)

#### Kubernetes Metrics

You can view more granular information about the corresponding anomalies and potential influencing factors through the Kubernetes monitoring view in the event.

![image](../../img/k8s-pod-restart10.png)

## FAQs

**1. How to configure the detection frequency for Kubernetes Pod abnormal restart inspection**

* In your self-hosted DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing custom inspection handling functions, then configure in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when Kubernetes Pod abnormal restart inspection triggers**

If there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. Under what circumstances will Kubernetes Pod abnormal restart inspection events be generated**

Based on the percentage of restarted pods in cluster_name + namespace, if this metric increases over the past 30 minutes, it triggers event generation logic and root cause analysis.

**4. What to do if previously normal scripts encounter errors during inspection**

Update the referenced script sets in the DataFlux Func Script Market. You can check the update records via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates to the scripts.

**5. No changes in the Startup script set during inspection script upgrades**

Delete the corresponding script set first, then click the upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can verify by clicking Execute. If it shows "Executed Successfully xxx Minutes Ago," the inspection is running normally.