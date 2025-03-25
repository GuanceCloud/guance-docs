# Kubernetes Pod Abnormal Restart Inspection

---

## Background

Kubernetes helps users automatically schedule and scale containerized applications, but modern Kubernetes environments are becoming increasingly complex. When platform and application engineers need to investigate events in dynamic, containerized environments, finding the most meaningful signals may involve many trial-and-error steps. Through intelligent inspection, anomalies can be filtered based on the current search context, thus accelerating event investigation, alleviating pressure on engineers, reducing mean time to repair, and improving end-user experience.

## Prerequisites

1. Enable " [Container Data Collection](<<< homepage >>>/datakit/container/)" in <<< custom_key.brand_name >>>
2. Self-build [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../../dataflux-func/index.md)
4. In <<< custom_key.brand_name >>> "Management / API Key Management", create an [API Key](../../../management/api-key/open-api.md) for operations.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, ensure it is deployed with the SaaS version of <<< custom_key.brand_name >>> under the [same provider and region](../../../plans/commercial-register.md#site).

## Enabling Inspection

In your self-built DataFlux Func, install "<<< custom_key.brand_name >>> Self-Built Inspection (K8S-Pod Restart Detection)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to enable it.

In the DataFlux Func Script Market, select the required inspection scenario, click to install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) connection, then choose to deploy and start the script.

![image](../../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration through the link.

![image](../../img/success_checker.png)

## Configuring Inspection

### Configuration in <<< custom_key.brand_name >>>

![image](../../img/k8s-pod-restart02.png)

#### Enable/Disable

Intelligent inspection is by default **disabled** and can be manually **enabled**. After enabling, inspections can be performed on configured Kubernetes clusters' Pods.

#### Edit

The "Kubernetes Pod Abnormal Restart Inspection" supports manual addition of filtering conditions. On the right side of the intelligent inspection list's operation menu, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure the cluster_name (cluster name, optional, if not configured, all namespaces will be inspected) and namespace (namespace, required) for the Kubernetes cluster to inspect.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert mute cycles.

After clicking edit in the configuration entry parameters, fill in the corresponding detection objects and save to start the inspection:

![image](../../img/k8s-pod-restart03.png)

You can refer to the following JSON configuration for multiple clusters and namespace information:

```json
   // Example configuration: namespace can be configured as multiple or single
      configs =[
          {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
          {"cluster_name": "yyy","namespace": "yyy1"}
      ]
```

> **Note**: In the self-built DataFlux Func, when writing custom inspection handling functions, additional filtering conditions can also be added (refer to example code configurations). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the custom inspection handling function.

### Configuration in DataFlux Func

After configuring the required filtering conditions in DataFlux Func, you can test them by clicking the `run()` method directly on the page. After publishing, the script will run normally. You can also view or modify the configuration in <<< custom_key.brand_name >>> "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as main

# Support for using filtering functions to filter inspected objects, for example:
def filter_namespace(cluster_namespaces):
    '''
    Filter hosts, define conditions for hosts that meet requirements, return True if matched, False otherwise
    return True｜False
    '''
     cluster_name = cluster_namespaces.get('cluster_name','')
     namespace = cluster_namespaces.get('namespace','')
     if cluster_name in ['xxxx']:
         return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Pod Restart Detection Inspection', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    """
    Optional parameters:
        configs: (if not configured, default is to inspect all; follow the content below if configured)
            Configure the cluster_name (cluster name, optional, not configured means inspect based on namespace)
            Configure the namespace (namespace, required)

    Example: namespace can be configured as multiple or single
        configs =[
            {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
            {"cluster_name": "yyy","namespace": "yyy1"}
        ]

    """
    checkers = [
        k8s_pod_restart.K8SPodRestartCheck(configs=configs, filters=[filter_namespace]), # Support for user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```



### Viewing Events

Based on the <<< custom_key.brand_name >>> inspection algorithm, Intelligent Inspection will look for abnormal Pod restarts within the currently configured clusters. For any anomalies, Intelligent Inspection will generate corresponding events. In the Intelligent Inspection list's operation menu on the right, click the **View Related Events** button to view corresponding abnormal events.

![image](../../img/k8s-pod-restart04.png)

### Event Details Page

By clicking **Event**, you can view the details page of the Intelligent Inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history records, and associated events.

* Clicking the small icon in the top-right corner of the details page labeled "View Monitor Configuration" allows viewing and editing the current Intelligent Inspection configuration details.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in Intelligent Inspection, it supports copying detection dimensions `key/value`, adding them to filters, and viewing related logs, containers, processes, Security Checks, traces, RUM PVs, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, you can copy them in `key/value` format and perform forward/reverse filtering.

 ![image](../../img/k8s-pod-restart05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal Pod: View the status of abnormal Pods in the current namespace.
* Container Status: View detailed error times, container ID status, current resource usage, and container types; clicking the container ID enters the specific container details page.

![image](../../img/k8s-pod-restart06.png)
  ![image](../../img/k8s-pod-restart07.png)

#### History Records

Supports viewing detected objects, anomaly/recovery times, and duration.

 ![image](../../img/k8s-pod-restart08.png)

#### Associated Events

Supports viewing associated events through filtering fields and selected time widget information.

 ![image](../../img/k8s-pod-restart09.png)

#### Kubernetes Metrics

Through the Kubernetes monitoring view in the event, you can see more granular information about the corresponding anomalies and potential influencing factors.

![image](../../img/k8s-pod-restart10.png)

## Common Issues

**1. How to configure the detection frequency for Kubernetes Pod Abnormal Restart Inspection**

  * In the self-built DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing the custom inspection handling function, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when Kubernetes Pod Abnormal Restart Inspection triggers**

  If there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. Under what circumstances would Kubernetes Pod Abnormal Restart Inspection events be generated**

  Use the percentage of restarted pods in cluster_name + namespace as the entry point. If this metric rises in the past 30 minutes, it triggers the event generation logic and performs root cause analysis.

**4. What to do if previously normal scripts encounter errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update records of the Script Market via [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates of the scripts.

**5. Why does the Startup script set remain unchanged during script upgrade**

First delete the corresponding script set, then click the upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection has taken effect after enabling**

In "Management / Automatic Trigger Configuration," view the corresponding inspection status. First, the status should be enabled, then validate the inspection script by clicking execute. If the message "Executed successfully xxx minutes ago" appears, the inspection is running normally and taking effect.