# Kubernetes Health Inspection
---

## Background

Nowadays, Kubernetes has swept through the entire container ecosystem. It acts as the brain for distributed container deployments, aiming to manage service-oriented applications using containers distributed across host clusters. Kubernetes provides mechanisms for application deployment, scheduling, updates, service discovery, and scaling. However, how can we ensure the health of Kubernetes nodes? Through intelligent inspection, issues can be discovered by searching for information such as current node resource status, application performance management, and service failure logs, thus accelerating incident investigation, reducing pressure on engineers, minimizing mean time to repair, and improving end-user experience.

## Prerequisites

1. Enable " [Container Data Collection](<<< homepage >>>/datakit/container/)" in <<< custom_key.brand_name >>>
2. Set up a self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate the [DataFlux Func (Automata)](../../../dataflux-func/index.md)
4. Create an [API Key](../../../management/api-key/open-api.md) for operations under "Management / API Key Management" in <<< custom_key.brand_name >>>

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the same operator and region as your current SaaS-based <<< custom_key.brand_name >>> deployment [here](../../../../getting-started/necessary-for-beginners/select-site/).

## Starting the Inspection

In your self-hosted DataFlux Func, install the "<<< custom_key.brand_name >>> Self-Hosted Inspection (K8S Health Inspection)" script via the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to start.

In the DataFlux Func Script Market, select the required inspection scenario and click Install. Configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) then choose to deploy and start the script.

![image](../../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration. You can directly jump to view the corresponding configuration via the link.

![image](../../img/success_checker.png)

## Configuring the Inspection

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../../img/k8s_health03.png)

#### Enable/Disable
The Kubernetes Health Inspection is by default set to "Enabled". It can be manually "Disabled". After enabling, inspections will run based on the configured Kubernetes health inspection list.

#### Editing
The "Kubernetes Health Inspection" supports users adding filter conditions. Under the operation menu on the right side of the intelligent inspection list, click the **Edit** button to modify the inspection template.

* Filter Conditions: Configure `cluster_name` for the cluster name and `host` for the nodes to inspect.
* Alert Notifications: Supports selecting and editing alert strategies including event severity levels, notification targets, and alert silence periods.

To configure entry parameters, click Edit, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../../img/k8s_health04.png)

You can refer to the following JSON configuration to add multiple application details:

```json
// Example:
    configs Configuration Example:
         cluster_name_1
         cluster_name_2
         cluster_name_3
```

> **Note**: In the self-hosted DataFlux Func, when writing custom inspection handling functions, you can also add filtering conditions (refer to example code configurations). Note that parameters configured in <<< custom_key.brand_name >>> studio will override those set in the custom inspection handling function.

### Configuring Inspection in DataFlux Func

In DataFlux Func, after configuring the necessary filter conditions, you can test the inspection by clicking the `run()` method directly on the page. After publishing, the script will execute normally. You can also view or modify configurations in <<< custom_key.brand_name >>> under "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_health__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_cluster(cluster_name_k8s):
    '''
    Filters `cluster_name_k8s`, defines conditions for acceptable `cluster_name_k8s`. Returns True if matches, False otherwise.
    return True|False
    '''
    if cluster_name_k8s in ['ningxia']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Health Inspection', timeout=900, fixed_crontab='*/15 * * * *')
def run(configs=None):
    """
    The inspection script depends on the `cluster_name_k8s` metrics from k8s. Before starting the inspection, ensure the `cluster_name_k8s` metric collection for containers is enabled.

    Parameters:
        configs:
            Configures the clusters to inspect (cluster names, leave blank to inspect all).

        configs Configuration Example:
             cluster_name_1
             cluster_name_2
             cluster_name_3

    """
    checkers = [
        k8s__health__inspection.K8SHealthCheck(configs=configs, filters=[filter_cluster]), # Support for user-configured multiple filtering functions executed sequentially.
    ]

    Runner(checkers, debug=False).run()
```



## Viewing Events

<<< custom_key.brand_name >>> inspects the current state of the Kubernetes cluster. When memory, disk, CPU, or POD anomalies are detected, the intelligent inspection generates corresponding events. Under the operation menu on the right side of the intelligent inspection list, click the **View Related Events** button to see the corresponding abnormal events.

![image](../../img/k8s_health05.png)

### Event Details Page
Clicking **Event**, you can view the details page of the intelligent inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, history records, and associated events.

* Click the small icon in the upper-right corner of the details page labeled "View Monitor Configuration" to view and edit the current intelligent inspection configuration.

#### Basic Attributes
* Detection Dimensions: Based on the filter conditions set in the intelligent inspection configuration, supports copying detection dimensions as `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: Selecting extended attributes allows copying in `key/value` format, forward/reverse filtering.

![image](../../img/k8s_health06.png)

#### Event Details

##### Abnormal Memory Usage Rate

![image](../../img/k8s_health07.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View detailed memory anomaly metrics.
* Top 5 Memory Usage List: View the top 5 PODs consuming the most memory. You can click on the POD to go to the POD detail page for more information.

##### Abnormal Disk Usage Rate

![image](../../img/k8s_health08.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View detailed disk anomaly metrics.
* Anomaly Analysis: View the usage of hosts with abnormal disk usage rates. You can click on the host to go to the host detail page for more information.

##### Abnormal CPU Usage Rate

![image](../../img/k8s_health09.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Anomaly Details: View detailed CPU anomaly metrics.
* Abnormal Containers: View the top 10 PODs with high CPU usage. You can click on the POD to go to the POD detail page for more information.

##### High Pod Pending Ratio

![image](../../img/k8s_health10.png)

* Event Overview: Describes the object and content of the abnormal inspection event.
* Abnormal PODs: View detailed information about the abnormal Pods, and you can jump to the corresponding Pod details via the Pod name.
* Pod Logs: View logs for the corresponding abnormal Pods, and you can jump to the relevant anomaly details via log sources or abnormal Pods.

#### Historical Records

Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../../img/k8s_health11.png)

#### Associated Events
Supports viewing associated events by filtering fields and selected time components.

![image](../../img/k8s_health12.png)

## Common Issues
**1. How to configure the detection frequency for Kubernetes Health Inspection**

* In the self-hosted DataFlux Func, when writing custom inspection handling functions, add `fixed_crontab='*/15 * * * *', timeout=900` in the decorator, then configure it under "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis during Kubernetes Health Inspection triggers**

When the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. During the inspection process, previously normal scripts now have errors**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the Script Market via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely script updates.

**4. During script upgrades, why does the Startup script set remain unchanged**

Delete the corresponding script set first, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**5. How to determine if the inspection has taken effect after enabling**

Under "Management / Automatic Trigger Configuration", check the corresponding inspection status. First, ensure it is enabled, then verify the inspection script by clicking Execute. If you see a success message indicating execution minutes ago, the inspection is running properly.