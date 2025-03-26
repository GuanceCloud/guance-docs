---
title: 'Azure Kubernetes'
tags: 
  - 'AZURE'
summary: 'Collect Azure Kubernetes metric data'
__int_icon: 'icon/azure_kubernetes'
dashboard:
  - desc: 'Azure Kubernetes monitoring view'
    path: 'dashboard/en/azure_kubernetes'
monitor:
  - desc: 'Azure Kubernetes detection library'
    path: 'monitor/en/azure_kubernetes'
---

Collect Azure Kubernetes metric data

## Configuration {#config}

### Install Func

It is recommended to enable Guance Cloud Integration - Extensions - Managed Func: All preconditions will be automatically installed. Please continue with the script installation.

If you want to deploy Func by yourself, refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}.

### Install the script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize the monitoring data of Azure Kubernetes Service, we install the corresponding collection script: `ID:guance_azure_kubernetes`.

After clicking [Install], enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, separate multiple subscriptions with a comma (`,`)

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click [Execute] to execute it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verify

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. On the Guance Cloud platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance Cloud platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}

Collect Azure Kubernetes Service metrics. You can collect more metrics through configuration [Supported metrics for Microsoft.ContainerService/managedClusters](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-containerservice-managedclusters-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`apiserver_current_inflight_requests`| Number of ongoing requests | count |
|`cluster_autoscaler_cluster_safe_to_autoscale`| Cluster health status | boolean |
|`cluster_autoscaler_scale_down_in_cooldown`| Vertical scale-down cooling device | - |
|`cluster_autoscaler_unneeded_nodes_count`| Number of unnecessary nodes | count |
|`cluster_autoscaler_unschedulable_pods_count`| Number of unschedulable Pods | count |
|`kube_node_status_allocatable_cpu_cores`| Total number of available CPU cores in the managed cluster | count |
|`kube_node_status_allocatable_memory_bytes`| Total amount of available memory in the managed cluster | count |
|`kube_node_status_condition`| Status of various node conditions | count |
|`kube_pod_status_phase`| Number of Pods based on phases | count |
|`kube_pod_status_ready`| Number of Pods in the ready state | count |
|`node_cpu_usage_millicores`| CPU usage (millicores) | % |
|`node_disk_usage_bytes`| Disk usage in bytes | bytes |
|`node_disk_usage_percentage`| Disk usage percentage | % |
|`node_memory_rss_bytes`| Memory RSS in bytes | bytes |
|`node_memory_rss_percentage`| Memory RSS percentage | % |
|`node_memory_working_set_bytes`| Memory working set in bytes | bytes |
|`node_memory_working_set_percentage`| Memory working set percentage | % |
|`node_network_in_bytes`| Network inbound bytes | bytes |
|`node_network_out_bytes`| Network outbound bytes | bytes |
