---
title: 'Volcengine VKE'
tags: 
  - Volcengine
summary: 'Volcengine VKE metrics collection, including Cluster, Container, Node, Pod, etc.'
__int_icon: 'icon/volcengine_vke'
dashboard:
  - desc: 'Volcengine VKE'
    path: 'dashboard/en/volcengine_vke/'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` VKE
<!-- markdownlint-enable -->


`Volcengine` Kubernetes Engine (VKE), VKE metrics collection, including Cluster, Container, Node, Pod, etc.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **VKE** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcenine`  -**VKE** Collect）」(ID：`guance_volcengine_vke`)

Click "Install" and enter the corresponding parameters: `Volcenine`  AK, `Volcenine`  account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric  {#metric}

Configure `Volcenine` Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcenine` Cloud Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_VKE){:target="_blank"}


| MetricName | SubNamespace |  Description | MetricUnit | Dimension (multiple entries separated by commas) |
|-------------------------------|---------------|-------------------------------|------------|------------------------------------------------------|
| `Cluster_MemoryUsed`| Cluster| Cluster Memory Usage   | Bytes(SI)  | Cluster|
| `Cluster_CPUUsage`| Cluster| Cluster CPU Usage| Percent| Cluster  |
| `Cluster_MemoryUsage`   | Cluster| Cluster Memory Utilization | Percent| Cluster  |
| `Cluster_NodeCount`| Cluster| Cluster Node Count | Count  | Cluster  |
| `Cluster_CPUUsed` | Cluster| Cluster CPU Usage| Core| Cluster  |
| `Container_MemoryUsed`  | Container | Container Memory Usage | Bytes(SI)  | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_CPUUsage`| Container | Container CPU Usage (Limit)| Percent| Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_MemoryUsage` | Container | Container Memory Utilization (Limit) | Percent| Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_CPUUsed` | Container | Container CPU Usage| Core| Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container |
| `Container_GPU_Memory_Free`| Container | Container GPU Memory Free  | Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Memory_Used`| Container | Container GPU Memory Used  | Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Usage`   | Container | Container GPU Utilization | Percent| Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Count`   | Container | Container GPU Card Count| Count  | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `Container_GPU_Memory_Usage`   | Container | Container GPU Memory Utilization | Percent| Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU |
| `CronJob_MemoryUsed`| CronJob| CronJob Memory Usage   | Bytes(SI)  | Cluster,Namespace,CronJob|
| `CronJob_CPUUsage`| CronJob| CronJob CPU Usage (Limit) | Percent| Cluster,Namespace,CronJob|
| `CronJob_MemoryUsage`   | CronJob| CronJob Memory Utilization (Limit) | Percent| Cluster,Namespace,CronJob|
| `CronJob_CPUUsed` | CronJob| CronJob CPU Usage| Core| Cluster,Namespace,CronJob|
| `CronJob_GPU_Memory_Free`  | CronJob| CronJob GPU Memory Free| Megabytes | Cluster,Namespace,CronJob,GPU|
| `CronJob_GPU_Memory_Used`  | CronJob| CronJob GPU Memory Used| Megabytes | Cluster,Namespace,CronJob,GPU  |
| `CronJob_GPU_Usage` | CronJob| CronJob GPU Utilization| Percent| Cluster,Namespace,CronJob,GPU  |
| `CronJob_GPU_Count` | CronJob| CronJob GPU Card Count| Count  | Cluster,Namespace,CronJob,GPU|
| `CronJob_GPU_Memory_Usage` | CronJob| CronJob GPU Memory Utilization | Percent| Cluster,Namespace,CronJob,GPU  |
| `DaemonSet_MemoryUsed`  | DaemonSet | DaemonSet Memory Usage | Bytes(SI)  | Cluster,Namespace,DaemonSet |
| `DaemonSet_CPUUsage`| DaemonSet | DaemonSet CPU Usage (Limit)   | Percent| Cluster,Namespace,DaemonSet |
| `DaemonSet_MemoryUsage` | DaemonSet | DaemonSet Memory Utilization (Limit) | Percent| Cluster,Namespace,DaemonSet |
| `DaemonSet_CPUUsed` | DaemonSet | DaemonSet CPU Usage| Core| Cluster,Namespace,DaemonSet |
| `DaemonSet_GPU_Memory_Free`| DaemonSet | DaemonSet GPU Memory Free | Megabytes | Cluster,Namespace,DaemonSet,GPU|
| `DaemonSet_GPU_Memory_Used`| DaemonSet | DaemonSet GPU Memory Used | Megabytes | Cluster,Namespace,DaemonSet,GPU|
| `DaemonSet_GPU_Usage`   | DaemonSet | DaemonSet GPU Utilization | Percent| Cluster,Namespace,DaemonSet,GPU|
| `DaemonSet_GPU_Count`   | DaemonSet | DaemonSet GPU Card Count  | Count  | Cluster,Namespace,DaemonSet,GPU|
| `DaemonSet_GPU_Memory_Usage`   | DaemonSet | DaemonSet GPU Memory Utilization | Percent| Cluster,Namespace,DaemonSet,GPU|
| `Deployment_MemoryUsed` | Deployment| Stateless Load Memory Usage  | Bytes(SI)  | Cluster,Namespace,Deployment|
| `Deployment_CPUUsage`   | Deployment| Stateless Load CPU Usage (Limit) | Percent| Cluster,Namespace,Deployment|
| `Deployment_MemoryUsage`| Deployment| Stateless Load Memory Utilization (Limit) | Percent| Cluster,Namespace,Deployment|
| `Deployment_CPUUsed`| Deployment| Stateless Load CPU Usage | Core| Cluster,Namespace,Deployment|
| `Deployment_GPU_Memory_Free`   | Deployment| Stateless Load GPU Memory Free | Megabytes | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Memory_Used`   | Deployment| Stateless Load GPU Memory Used | Megabytes | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Usage`  | Deployment| Stateless Load GPU Utilization | Percent| Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Count`  | Deployment| Stateless Load GPU Card Count | Count  | Cluster,Namespace,Deployment,GPU |
| `Deployment_GPU_Memory_Usage`  | Deployment| Stateless Load GPU Memory Utilization | Percent| Cluster,Namespace,Deployment,GPU |
| `Job_CPUUsed` | Job| Job CPU Usage| Core| Cluster,Namespace,Job|
| `Job_MemoryUsed`  | Job| Job Memory Usage | Bytes(SI)  | Cluster,Namespace,Job|
| `Job_CPUUsage`| Job| Job CPU Usage (Limit)  | Percent| Cluster,Namespace,Job|
| `Job_MemoryUsage` | Job| Job Memory Utilization (Limit) | Percent| Cluster,Namespace,Job|
| `Job_GPU_Memory_Free`   | Job| Job GPU Memory Free| Megabytes | Cluster,Namespace,Job,GPU|
| `Job_GPU_Memory_Used`   | Job| Job GPU Memory Used| Megabytes | Cluster,Namespace,Job,GPU|
| `Job_GPU_Usage`   | Job| Job GPU Utilization| Percent| Cluster,Namespace,Job,GPU|
| `Job_GPU_Count`   | Job| Job GPU Card Count| Count  | Cluster,Namespace,Job,GPU|
| `Job_GPU_Memory_Usage`  | Job| Job GPU Memory Utilization| Percent| Cluster,Namespace,Job,GPU|
| `Namespace_CPUUsed` | Namespace | Namespace CPU Usage   | Core| Cluster,Namespace   |
| `Namespace_MemoryUsed`  | Namespace | Namespace Memory Usage| Bytes(SI)  | Cluster,Namespace   |
| `Node_PodCount`   | Node   | Pod Count| Count  | Cluster,Node|
| `Node_CPURequestUsage`  | Node   | Node CPU Allocation (Request) | Percent| Cluster,Node  |
| `Node_MemoryRequestUsage`  | Node   | Node Memory Allocation (Request) | Percent| Cluster,Node  |
| `Node_CPULimitUsage`| Node   | Node CPU Allocation (Limit)   | Percent| Cluster,Node  |
| `Node_MemoryLimitUsage` | Node   | Node Memory Allocation (Limit) | Percent| Cluster,Node  |
| Node_CPUUsage   | Node   | Node CPU Usage  | Percent| Cluster,Node|
| `Node_MemoryUsage`| Node   | Node Memory Utilization  | Percent| Cluster,Node  |
| `PersistentVolumeClaim_VolumeUsage` | PersistentVolumeClaim | Storage Volume Claim Usage | Percent | Cluster,Namespace,PersistentVolumeClaim |



## Object  {#object}

The collected `Volcenine` Cloud **VKE** object data structure can see the object data from 「Infrastructure-Custom」

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

