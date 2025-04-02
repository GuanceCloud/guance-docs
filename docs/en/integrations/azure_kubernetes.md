---
title: 'Azure Kubernetes'
tags: 
  - 'AZURE'
summary: 'Collect Azure Kubernetes Metrics data'
__int_icon: 'icon/azure_kubernetes'
dashboard:
  - desc: 'Azure Kubernetes monitoring view'
    path: 'dashboard/en/azure_kubernetes'
monitor   :
  - desc  : 'Azure Kubernetes detection library'
    path  : 'monitor/en/azure_kubernetes'
---

Collect Azure Kubernetes Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Kubernetes Service monitoring data, we install the corresponding collection script: 「Integration (Azure-Kubernetes service collection)」(ID: `guance_azure_kubernetes`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding automatic trigger configuration exists for the corresponding task. You can also check the corresponding task records and logs to verify if there are any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure - Resource Catalog」check if asset information exists.
3. In <<< custom_key.brand_name >>>, 「Metrics」check if corresponding monitoring data exists.

## Metrics {#metric}

Collect Azure Kubernetes Service Metrics, you can collect more metrics via configuration [Microsoft.ContainerService/managedClusters supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-containerservice-managedclusters-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`apiserver_current_inflight_requests`| Number of requests in progress | count |
|`cluster_autoscaler_cluster_safe_to_autoscale`| Cluster health status | boolean |
|`cluster_autoscaler_scale_down_in_cooldown`| Vertical reduction cooling device | - |
|`cluster_autoscaler_unneeded_nodes_count`| Unnecessary nodes | count |
|`cluster_autoscaler_unschedulable_pods_count`| Unschedulable Pods | count |
|`kube_node_status_allocatable_cpu_cores`| Total number of allocatable CPU cores in the managed cluster | count |
|`kube_node_status_allocatable_memory_bytes`| Total amount of allocatable memory in the managed cluster | count |
|`kube_node_status_condition`| Status of various node conditions | count |
|`kube_pod_status_phase`| Pod count based on phase | count |
|`kube_pod_status_ready`| Pod count in ready state | count |
|`node_cpu_usage_millicores`| CPU usage (millicores) | % |
|`node_disk_usage_bytes`| Disk used bytes | bytes |
|`node_disk_usage_percentage`| Disk used percentage | % |
|`node_memory_rss_bytes`| Memory RSS bytes | bytes |
|`node_memory_rss_percentage`| Memory RSS percentage | % |
|`node_memory_working_set_bytes`| Memory working set bytes | bytes |
|`node_memory_working_set_percentage`| Memory working set percentage | % |
|`node_network_in_bytes`| Network incoming bytes | bytes |
|`node_network_out_bytes`| Network outgoing bytes | bytes |