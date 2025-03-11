---
title: 'VolcEngine VKE'
tags: 
  - VolcEngine
summary: 'VolcEngine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc.'
__int_icon: 'icon/volcengine_vke'
dashboard:
  - desc: 'VolcEngine VKE'
    path: 'dashboard/en/volcengine_vke/'
---

<!-- markdownlint-disable MD025 -->
# VolcEngine VKE
<!-- markdownlint-enable -->


VolcEngine Container Service (`Volcengine` Kubernetes Engine, VKE), VKE metrics collection includes Cluster, Container, Node, Pod, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a VolcEngine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of VKE cloud resources, we install the corresponding collection script: "Guance Integration (VolcEngine-VKE Collection)" (ID: `guance_volcengine_vke`).

After clicking 【Install】, enter the required parameters: VolcEngine AK, VolcEngine account name.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, then you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the log collection script. If you need to collect billing data, enable the cloud billing collection script.


We default to collecting some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring VolcEngine cloud monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [VolcEngine Cloud Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_VKE){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the `volcengine` VKE console.

| `MetricName` | `SubNamespace` | Metric Name | MetricUnit | Dimension |
| ---- |-------------------------------------| :----: |:----: |:----: |
| `Cluster_MemoryUsed` | `Cluster` | Cluster Memory Usage | Bytes(SI) | Cluster |
| `Cluster_CPUUsage` | `Cluster` | Cluster CPU Utilization | Percent | Cluster |
| `Cluster_MemoryUsage` | `Cluster` | Cluster Memory Utilization | Percent | Cluster |
| `Cluster_NodeCount` | `Cluster` | Cluster Node Count | Count | Cluster |
| `Cluster_CPUUsed` | `Cluster` | Cluster CPU Usage | Core | Cluster |
| `Container_MemoryUsed` | `Container` | Container Memory Usage | Bytes(SI) | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_CPUUsage` | `Container` | Container CPU Utilization (as a percentage of limit) | Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_MemoryUsage` | `Container` | Container Memory Utilization (as a percentage of limit) | Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_CPUUsed` | `Container` | Container CPU Usage | Core | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_GPU_Memory_Free` | `Container` | Container GPU Memory Free | Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Memory_Used` | `Container` | Container GPU Memory Usage | Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Usage` | `Container` | Container GPU Utilization | Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Count` | `Container` | Container GPU Count | Count | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Memory_Usage` | `Container` | Container GPU Memory Utilization | Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `CronJob_MemoryUsed` | `CronJob` | Cron Job Memory Usage | Bytes(SI) | Cluster,Namespace,CronJob |
| `CronJob_CPUUsage` | `CronJob` | Cron Job CPU Utilization (as a percentage of limit) | Percent | Cluster,Namespace,CronJob |
| `CronJob_MemoryUsage` | `CronJob` | Cron Job Memory Utilization (as a percentage of limit) | Percent | Cluster,Namespace,CronJob |
| `CronJob_CPUUsed` | `CronJob` | Cron Job CPU Usage | Core | Cluster,Namespace,CronJob |
| `CronJob_GPU_Memory_Free` | `CronJob` | Cron Job GPU Memory Free | Megabytes | Cluster,Namespace,CronJob,GPU |
| `CronJob_GPU_Memory_Used` | `CronJob` | Cron Job GPU Memory Usage | Megabytes | Cluster,Namespace,CronJob,GPU |
| `CronJob_GPU_Usage` | `CronJob` | Cron Job GPU Utilization | Percent | Cluster,Namespace,CronJob,GPU |
| `CronJob_GPU_Count` | `CronJob` | Cron Job GPU Count | Count | Cluster,Namespace,CronJob,GPU |
| `CronJob_GPU_Memory_Usage` | `CronJob` | Cron Job GPU Memory Utilization | Percent | Cluster,Namespace,CronJob,GPU |
| `DaemonSet_MemoryUsed` | `DaemonSet` | DaemonSet Memory Usage | Bytes(SI) | Cluster,Namespace,DaemonSet |
| `DaemonSet_CPUUsage` | `DaemonSet` | DaemonSet CPU Utilization (as a percentage of limit) | Percent | Cluster,Namespace,DaemonSet |
| `DaemonSet_MemoryUsage` | `DaemonSet` | DaemonSet Memory Utilization (as a percentage of limit) | Percent | Cluster,Namespace,DaemonSet |
| `DaemonSet_CPUUsed` | `DaemonSet` | DaemonSet CPU Usage | Core | Cluster,Namespace,DaemonSet |
| `DaemonSet_GPU_Memory_Free` | `DaemonSet` | DaemonSet GPU Memory Free | Megabytes | Cluster,Namespace,DaemonSet,GPU |
| `DaemonSet_GPU_Memory_Used` | `DaemonSet` | DaemonSet GPU Memory Usage | Megabytes | Cluster,Namespace,DaemonSet,GPU |
| `DaemonSet_GPU_Usage` | `DaemonSet` | DaemonSet GPU Utilization | Percent | Cluster,Namespace,DaemonSet,GPU |
| `DaemonSet_GPU_Count` | `DaemonSet` | DaemonSet GPU Count | Count | Cluster,Namespace,DaemonSet,GPU |
| `DaemonSet_GPU_Memory_Usage` | `DaemonSet` | DaemonSet GPU Memory Utilization | Percent | Cluster,Namespace,DaemonSet,GPU |
| `Deployment_MemoryUsed` | `Deployment` | Stateless Load Memory Usage | Bytes(SI) | Cluster,Namespace,Deployment |
| `Deployment_CPUUsage` | `Deployment` | Stateless Load CPU Utilization (as a percentage of limit) | Percent | Cluster,Namespace,Deployment |
| `Deployment_MemoryUsage` | `Deployment` | Stateless Load Memory Utilization (as a percentage of limit) | Percent | Cluster,Namespace,Deployment |
| `Deployment_CPUUsed` | `Deployment` | Stateless Load CPU Usage | Core | Cluster,Namespace,Deployment |
| `Deployment_GPU_Memory_Free` | `Deployment` | Stateless Load GPU Memory Free | Megabytes | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Memory_Used` | `Deployment` | Stateless Load GPU Memory Usage | Megabytes | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Usage` | `Deployment` | Stateless Load GPU Utilization | Percent | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Count` | `Deployment` | Stateless Load GPU Count | Count | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Memory_Usage` | `Deployment` | Stateless Load GPU Memory Utilization | Percent | Cluster,Namespace,Deployment,GPU |
| `Job_CPUUsed` | `Job` | Job CPU Usage | Core | Cluster,Namespace,Job |
| `Job_MemoryUsed` | `Job` | Job Memory Usage | Bytes(SI) | Cluster,Namespace,Job |
| `Job_CPUUsage` | `Job` | Job CPU Utilization (as a percentage of limit) | Percent | Cluster,Namespace,Job |
| `Job_MemoryUsage` | `Job` | Job Memory Utilization (as a percentage of limit) | Percent | Cluster,Namespace,Job |
| `Job_GPU_Memory_Free` | `Job` | Job GPU Memory Free | Megabytes | Cluster,Namespace,Job,GPU |
| `Job_GPU_Memory_Used` | `Job` | Job GPU Memory Usage | Megabytes | Cluster,Namespace,Job,GPU |
| `Job_GPU_Usage` | `Job` | Job GPU Utilization | Percent | Cluster,Namespace,Job,GPU |
| `Job_GPU_Count` | `Job` | Job GPU Count | Count | Cluster,Namespace,Job,GPU |
| `Job_GPU_Memory_Usage` | `Job` | Job GPU Memory Utilization | Percent | Cluster,Namespace,Job,GPU |
| `Namespace_CPUUsed` | `Namespace` | Namespace CPU Usage | Core | Cluster,Namespace |
| `Namespace_MemoryUsed` | `Namespace` | Namespace Memory Usage | Bytes(SI) | Cluster,Namespace |
| `Node_PodCount` | `Node` | Number of Pods | Count | Cluster,Node |
| `Node_CPURequestUsage` | `Node` | Node CPU Allocation Rate (request) | Percent | Cluster,Node |
| `Node_MemoryRequestUsage` | `Node` | Node Memory Allocation Rate (request) | Percent | Cluster,Node |
| `Node_CPULimitUsage` | `Node` | Node CPU Allocation Rate (limit) | Percent | Cluster,Node |
| `Node_MemoryLimitUsage` | `Node` | Node Memory Allocation Rate (limit) | Percent | Cluster,Node |
| `Node_CPUUsage` | `Node` | Node CPU Utilization | Percent | Cluster,Node |
| `Node_MemoryUsage` | `Node` | Node Memory Utilization | Percent | Cluster,Node |
| `PersistentVolumeClaim_VolumeUsage` | `PersistentVolumeClaim` | Persistent Volume Claim Volume Utilization | Percent | Cluster,Namespace,PersistentVolumeClaim |

## Objects {#object}

The collected VolcEngine VKE object data structure can be viewed in "Infrastructure - Custom".

``` json
{
    "fields": {
        "ClusterConfig": {},
        "CreateTime": "2024-04-07T06:13:08Z",
        "KubernetesConfig": {},
        "PodsConfig": {},
        "message": {}
    },
    "measurement": "volcengine_vke",
    "tags": {
        "ChargeType": "PostPaid",
        "ClusterId": "cco93ispooc7b6ohg00b0",
        "ClusterName": "test",
        "KubernetesVersion": "v1.26.10-vke.14",
        "RegionId": "cn-shanghai",
        "Status": "Running",
        "name": "cco93ispooc7b6ohg00b0"
    }
}
```
