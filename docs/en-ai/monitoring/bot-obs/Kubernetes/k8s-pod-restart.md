# Kubernetes Pod Abnormal Restart Inspection

---

## Background

Kubernetes helps users automatically schedule and scale containerized applications, but modern Kubernetes environments are becoming increasingly complex. When platform and application engineers need to investigate events in dynamic, containerized environments, finding the most meaningful signals can involve many trial-and-error steps. By using intelligent inspection, anomalies can be filtered based on the current search context, accelerating event investigation, reducing engineer stress, decreasing mean time to repair, and improving end-user experience.

## Prerequisites

1. Enable "[Container Data Collection](https://docs.guance.com/datakit/container/)" in Guance.
2. Set up [DataFlux Func (Automata)](https://func.guance.com/#/) or activate the [DataFlux Func (Automata)](../../../dataflux-func/index.md).
3. Create an API Key for operations in Guance's "Management / API Key Management" section, as described in [API Key](../../../management/api-key/open-api.md).

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the same operator and region as your current SaaS deployment of Guance, as mentioned in [Commercial Plan Registration](../../../plans/commercial-register.md#site).

## Enabling Inspection

In your self-hosted DataFlux Func, install "Guance Self-Hosted Inspection (K8S-Pod Restart Detection)" from the "Script Market" and configure the Guance API Key to enable it.

Select the required inspection scenario from the DataFlux Func Script Market, click Install, configure the Guance API Key, and select `GuanceNode` ([documentation](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/)) before choosing to deploy and start the script.

![image](../../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and trigger configuration. You can directly jump to and view the corresponding configuration via the link.

![image](../../img/success_checker.png)

## Configuring Inspection

### Configuring Inspection in Guance

![image](../../img/k8s-pod-restart02.png)

#### Enable/Disable

Intelligent inspection is **disabled** by default and can be manually **enabled**. Once enabled, it will inspect Pods in the configured Kubernetes clusters.

#### Editing

The "Kubernetes Pod Abnormal Restart Inspection" supports manual addition of filtering conditions. In the intelligent inspection list, click the **Edit** button in the right-hand operation menu to edit the inspection template.

- **Filtering Conditions**: Configure the `cluster_name` (optional) and `namespace` (required) for the Kubernetes cluster to inspect.
- **Alert Notifications**: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

To configure parameters, click Edit, fill in the detection objects, and save to start the inspection:

![image](../../img/k8s-pod-restart03.png)

You can refer to the following JSON configuration for multiple clusters and namespaces:

```json
// Configuration example: namespace can be configured as multiple or single
configs = [
    {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
    {"cluster_name": "yyy", "namespace": "yyy1"}
]
```

> **Note**: In the self-hosted DataFlux Func, when writing custom inspection processing functions, you can add filtering conditions (refer to the sample code). Note that parameters configured in the Guance Studio will override those set in the custom inspection processing function.

### Configuring Inspection in DataFlux Func

After configuring the required filtering conditions in DataFlux Func, you can test by clicking the `run()` method directly on the page. After publishing, the script will run normally. You can also view or change configurations in Guance's "Monitoring / Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_namespace(cluster_namespaces):
    '''
    Filter hosts based on custom criteria, returning True for matching hosts and False otherwise
    return True | False
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
        configs: (default checks all, follow the content below when configured)
            Configure the cluster_name (optional, defaults to checking all namespaces if not configured)
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

Intelligent inspection, based on Guance's inspection algorithms, checks for abnormal Pod restarts within the configured clusters. For detected anomalies, it generates corresponding events. Click the **View Related Events** button in the right-hand operation menu of the intelligent inspection list to view the associated anomaly events.

![image](../../img/k8s-pod-restart04.png)

### Event Details Page

Click **Event** to view the details page of the intelligent inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

- Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes

- **Detection Dimensions**: Based on the configured filtering conditions, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
- **Extended Attributes**: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

  ![image](../../img/k8s-pod-restart05.png)

#### Event Details

- **Event Overview**: Describes the object and content of the anomaly inspection event.
- **Abnormal Pod**: View the status of the abnormal pod in the current namespace.
- **Container Status**: View detailed error times, container IDs, resource usage, container types; clicking the container ID leads to the specific container details page.

  ![image](../../img/k8s-pod-restart06.png)
  ![image](../../img/k8s-pod-restart07.png)

#### Historical Records

Supports viewing the detection object, anomaly/recovery times, and duration.

  ![image](../../img/k8s-pod-restart08.png)

#### Related Events

Supports viewing related events through filtering fields and selected time components.

  ![image](../../img/k8s-pod-restart09.png)

#### Kubernetes Metrics

Through the Kubernetes monitoring view in the event, you can see more granular information about the anomaly and potential influencing factors.

  ![image](../../img/k8s-pod-restart10.png)

## Common Issues

**1. How is the detection frequency for Kubernetes Pod Abnormal Restart Inspection configured?**

  - In the self-hosted DataFlux Func, add `fixed_crontab='*/30 * * * *', timeout=900` in the decorator when writing the custom inspection processing function, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when Kubernetes Pod Abnormal Restart Inspection triggers?**

  - If the inspection report lacks anomaly analysis, check the current `datakit` data collection status.

**3. Under what circumstances would a Kubernetes Pod Abnormal Restart Inspection event be generated?**

  - Using the ratio of restarting pods under `cluster_name + namespace` as the entry point, an event is triggered and root cause analysis is performed if this metric increases over the past 30 minutes.

**4. What should I do if a previously working script encounters errors during inspection?**

  - Update the referenced script set in the DataFlux Func Script Market. Refer to the [Change Log](https://func.guance.com/doc/script-market-guance-changelog/) to view update records for timely updates.

**5. Why does the script set in Startup remain unchanged during script upgrade?**

  - Delete the corresponding script set first, then click the upgrade button and configure the corresponding Guance API Key to complete the upgrade.

**6. How can I determine if the inspection has taken effect after enabling it?**

  - In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can verify the script by clicking Execute. If it shows "Executed Successfully xx minutes ago," the inspection is running normally.