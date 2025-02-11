# Kubernetes Health Inspection
---

## Background

Nowadays, Kubernetes has swept through the entire container ecosystem. It acts as the brain of distributed container deployment, aiming to manage service-oriented applications using containers distributed across a host cluster. Kubernetes provides mechanisms for application deployment, scheduling, updates, service discovery, and scaling. However, how can we ensure the health of Kubernetes nodes? Through intelligent inspection based on current node resource status, APM, service failure logs, and other information retrieval and problem detection, event investigation can be accelerated, engineers' pressure reduced, mean time to repair (MTTR) decreased, and end-user experience improved.

## Prerequisites

1. Enable "[Container Data Collection](https://docs.guance.com/datakit/container/)" in Guance.
2. Set up [DataFlux Func (Automata)](https://func.guance.com/#/) or subscribe to the [DataFlux Func (Automata)](../../../dataflux-func/index.md).
4. Create an [API Key](../../../management/api-key/open-api.md) for operations under "Management / API Key Management" in Guance.

> **Note**: If you consider using cloud servers for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as the SaaS deployment of Guance [here](../../../../getting-started/necessary-for-beginners/select-site/).

## Initiating Inspection

In your self-hosted DataFlux Func, install "Guance Self-Hosted Inspection (K8S Health Inspection)" via the "Script Market" and configure the Guance API Key to activate it.

Select the required inspection scenario from the DataFlux Func Script Market, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../../img/success_checker.png)

## Configuring Inspection

### Configuring Inspection in Guance

![image](../../img/k8s_health03.png)

#### Enable/Disable
Kubernetes health inspection is enabled by default but can be manually disabled. Once enabled, it inspects the configured list of Kubernetes health inspections.

#### Editing
Intelligent inspection "Kubernetes Health Inspection" supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filter Conditions: Configure `cluster_name` for the cluster name and `host` for the node to be inspected.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert mute periods.

Click Edit in the parameter entry to fill in the corresponding inspection objects in the parameter configuration and save to start the inspection:

![image](../../img/k8s_health04.png)

You can refer to the following JSON configuration for multiple application information

```json
// Example:
    configs configuration example:
         cluster_name_1
         cluster_name_2
         cluster_name_3
```

> **Note**: In self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to sample code configuration). Note that parameters configured in the Guance Studio will override those configured in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the necessary filtering conditions, you can run tests by clicking the `run()` method directly on the page. After clicking Publish, the script will execute normally. You can also view or change configurations in Guance's "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_health__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_cluster(cluster_name_k8s):
    '''
    Filter cluster_name_k8s, define conditions that match the required cluster_name_k8s, return True if matched, otherwise False
    return True｜False
    '''
    if cluster_name_k8s in ['ningxia']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Health Inspection', timeout=900, fixed_crontab='*/15 * * * *')
def run(configs=None):
    """
    The inspection script depends on the `cluster_name_k8s` Metrics. Before starting the inspection, enable the `cluster_name_k8s` Metrics configuration for container collection.

    Parameters:
        configs:
            Configure the cluster_name (cluster name, leave blank to inspect all)

        Configuration examples:
             cluster_name_1
             cluster_name_2
             cluster_name_3

    """
    checkers = [
        k8s__health__inspection.K8SHealthCheck(configs=configs, filters=[filter_cluster]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



## Viewing Events

Guance will inspect the current state of the Kubernetes cluster. When memory, disk, CPU, or POD anomalies are detected, intelligent inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view related anomaly events.

![image](../../img/k8s_health05.png)

### Event Details Page
Click **Event** to view the details page of the intelligent inspection event, including event status, occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the filter conditions configured in intelligent inspection, support copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, support copying in `key/value` format, forward/reverse filtering.

![image](../../img/k8s_health06.png)

#### Event Details

##### Memory Usage Anomaly

![image](../../img/k8s_health07.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View detailed memory anomaly metrics.
* Top 5 Memory Usage List: View the top 5 PODs by memory usage. Click POD to jump to the POD details page for more information.

##### Disk Usage Anomaly

![image](../../img/k8s_health08.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View detailed disk anomaly metrics.
* Anomaly Analysis: View the usage of hosts with abnormal disk usage rates. Click the host to jump to the host details page for more information.

##### CPU Usage Anomaly

![image](../../img/k8s_health09.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View detailed CPU usage anomaly metrics.
* Abnormal Containers: View the top 10 PODs by CPU usage. Click POD to jump to the POD details page for more information.

##### High Pod Pending Ratio

![image](../../img/k8s_health10.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal POD: View detailed information about the abnormal Pod. You can also jump to the corresponding Pod details via the Pod name.
* Pod Logs: View logs of the abnormal Pod. You can jump to the corresponding anomaly details via log source and abnormal Pod.

#### History

Support viewing detection objects, anomaly/recovery times, and duration.

![image](../../img/k8s_health11.png)

#### Related Events
Support viewing related events through selected fields and time component information.

![image](../../img/k8s_health12.png)

## Common Issues
**1. How to configure the detection frequency of Kubernetes health inspection**

* In self-hosted DataFlux Func, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator when writing custom inspection handling functions, then configure it in "Management / Automatic Trigger Configuration".

**2. Why there might be no anomaly analysis during Kubernetes health inspection**

When the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. What to do if previously running scripts encounter errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update records of the script market via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates of scripts.

**4. Why the script set in Startup remains unchanged during script upgrade**

Delete the corresponding script set first, then click Upgrade and configure the corresponding Guance API key to complete the upgrade.

**5. How to determine if the inspection is effective after enabling**

In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can verify if the inspection script works properly by clicking Execute. If it shows "Executed Successfully X minutes ago," the inspection is running effectively.