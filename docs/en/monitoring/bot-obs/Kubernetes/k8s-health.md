# Kubernetes Health Inspection
---

## Background

Nowadays, Kubernetes has swept through the entire container ecosystem, acting as the brain for distributed deployment of containers. It aims to manage service-oriented applications using containers distributed across host clusters. Kubernetes provides mechanisms for application deployment, scheduling, updates, service discovery, and scaling. However, how can we ensure the health of Kubernetes nodes? Through intelligent inspection, we can accelerate incident investigation, reduce pressure on engineers, decrease mean time to repair, and improve end-user experience by retrieving and identifying issues from current node resource status, APM, and service failure logs.

## Prerequisites

1. Enable "Container Data Collection" in <<< custom_key.brand_name >>> [Container Data Collection](<<< homepage >>>/datakit/container/)
2. Set up a self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../../dataflux-func/index.md)
4. Create an API Key for operations in <<< custom_key.brand_name >>> under "Management / API Key Management" [API Key](../../../management/api-key/open-api.md)

> **Note**: If you are considering using cloud servers for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current <<< custom_key.brand_name >>> SaaS deployment [Same Operator and Region](../../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In your self-hosted DataFlux Func, install "<<< custom_key.brand_name >>> Self-built Inspection (K8S Health Inspection)" via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to enable it.

Select the required inspection scenario in the DataFlux Func Script Market, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose Deploy to start the script.

![image](../../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../../img/success_checker.png)

## Configuring Inspection

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../../img/k8s_health03.png)

#### Enable/Disable
Kubernetes health inspection is enabled by default and can be manually disabled. Once enabled, it will inspect the configured Kubernetes health inspection list.

#### Editing
Intelligent inspection "Kubernetes Health Inspection" supports users adding filter conditions manually. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

* Filter Conditions: Configure `cluster_name` cluster name, `host` nodes to be inspected
* Alert Notifications: Supports selecting and editing alert strategies, including event levels, notification targets, and alert mute periods

Click Edit after configuring entry parameters, fill in the corresponding inspection objects in the parameter configuration, and save to start the inspection:

![image](../../img/k8s_health04.png)

You can refer to the following JSON configuration for multiple application information

```json
// Example:
    configs Configuration Example:
         cluster_name_1
         cluster_name_2
         cluster_name_3
```

> **Note**: In your self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to sample code configuration). Note that parameters configured in <<< custom_key.brand_name >>> Studio will override those set in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the necessary filtering conditions for inspection, you can test by clicking the `run()` method directly on the page. After publishing, the script will run normally. You can also view or modify configurations in <<< custom_key.brand_name >>> under "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_health__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_cluster(cluster_name_k8s):
    '''
    Filter `cluster_name_k8s`, define conditions that match `cluster_name_k8s`. Return True if matched, otherwise False.
    return True｜False
    '''
    if cluster_name_k8s in ['ningxia']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Health Inspection', timeout=900, fixed_crontab='*/15 * * * *')
def run(configs=None):
    """
    The inspection script depends on the `cluster_name_k8s` Metrics of k8s. Before enabling inspection, ensure that the `cluster_name_k8s` Metrics collection for containers is enabled.

    Parameters:
        configs:
            Configure the cluster_name (cluster name, leave blank to inspect all)

        Configs Example:
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

<<< custom_key.brand_name >>> inspects the current state of the Kubernetes cluster and generates corresponding events when memory, disk, CPU, or POD anomalies are detected. In the intelligent inspection list's operation menu on the right, click the **View Related Events** button to view corresponding anomaly events.

![image](../../img/k8s_health05.png)

### Event Details Page
Click **Event** to view the details page of the intelligent inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the small icon "View Monitor Configuration" in the upper-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes
* Inspection Dimensions: Based on the filtering conditions configured for intelligent inspection, support copying `key/value`, adding to filters, and viewing related logs, containers, processes, security inspections, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../../img/k8s_health06.png)

#### Event Details

##### Memory Usage Anomaly

![image](../../img/k8s_health07.png)

* Event Overview: Describes the object and content of the anomaly inspection event.
* Anomaly Details: View detailed metrics of memory anomalies.
* Top 5 Memory Usage List: View information about the top 5 PODs by memory usage. Clicking a POD redirects to the POD details page for more information.

##### Disk Usage Anomaly

![image](../../img/k8s_health08.png)

* Event Overview: Describes the object and content of the anomaly inspection event.
* Anomaly Details: View detailed metrics of disk anomalies.
* Anomaly Analysis: View the usage situation of hosts with abnormal disk usage rates. Clicking a host redirects to the host details page for more information.

##### CPU Usage Anomaly

![image](../../img/k8s_health09.png)

* Event Overview: Describes the object and content of the anomaly inspection event.
* Anomaly Details: View detailed metrics of CPU usage anomalies.
* Abnormal Containers: View information about the top 10 PODs by CPU usage rate. Clicking a POD redirects to the POD details page for more information.

##### High Pod Pending Ratio

![image](../../img/k8s_health10.png)

* Event Overview: Describes the object and content of the anomaly inspection event.
* Abnormal POD: View detailed information about the abnormal Pod. You can also jump to the corresponding Pod details page via the Pod name.
* Pod Logs: View logs for the corresponding abnormal Pod. You can jump to the respective anomaly details via log sources and abnormal Pods.

#### History

Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../../img/k8s_health11.png)

#### Related Events
Supports viewing related events through selected fields and time component information.

![image](../../img/k8s_health12.png)

## Common Issues
**1. How to configure the inspection frequency for Kubernetes health inspection**

* In your self-hosted DataFlux Func, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator when writing custom inspection handling functions, and configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis during Kubernetes health inspection**

When there is no anomaly analysis in the inspection report, check the current `datakit` data collection status.

**3. What to do if previously running scripts fail during inspection**

Update the referenced script set in the DataFlux Func Script Market. You can view the update records of the script market via the [Change Log](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates to the script.

**4. Why does the script set not change during inspection script upgrades**

First delete the corresponding script set, then click the upgrade button and configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection is effective after enabling**

In "Management / Automatic Trigger Configuration," view the corresponding inspection status. First, ensure it is enabled, then verify if the inspection script works by clicking Execute. If it shows "Executed Successfully xxx minutes ago," the inspection is running effectively.