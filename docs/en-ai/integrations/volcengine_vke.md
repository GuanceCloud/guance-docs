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


VolcEngine Container Service (`Volcengine` Kubernetes Engine, VKE), VKE metrics collection, including Cluster, Container, Node, Pod, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified VolcEngine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of VKE cloud resources, we install the corresponding collection script: "Guance Integration (VolcEngine-VKE Collection)" (ID: `guance_volcengine_vke`)

After clicking 【Install】, enter the required parameters: VolcEngine AK, VolcEngine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm that the corresponding task has an automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring VolcEngine Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration. [VolcEngine Cloud Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_VKE){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the `volcengine` VKE console.

|`MetricName` |`SubNamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`Cluster_MemoryUsed` |`Cluster` |Cluster Memory Usage |Bytes(SI) | Cluster|
|`Cluster_CPUUsage` |`Cluster` |Cluster CPU Utilization |Percent | Cluster|
|`Cluster_MemoryUsage` |`Cluster` |Cluster Memory Utilization |Percent | Cluster|
|`Cluster_NodeCount` |`Cluster` |Cluster Node Count |Count | Cluster|
|`Cluster_CPUUsed` |`Cluster` |Cluster CPU Usage |Core | Cluster|
|`Container_MemoryUsed` |`Container` |Container Memory Usage |Bytes(SI) | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_CPUUsage` |`Container` |Container CPU Utilization (as limit) |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_MemoryUsage` |`Container` |Container Memory Utilization (as limit) |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_CPUUsed` |`Container` |Container CPU Usage |Core | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_GPU_Memory_Free` |`Container` |Container GPU Free Memory |Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Memory_Used` |`Container` |Container GPU Used Memory |Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Usage` |`Container` |Container GPU Utilization |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Count` |`Container` |Container GPU Count |Count | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Memory_Usage` |`Container` |Container GPU Memory Utilization |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`CronJob_MemoryUsed` |`CronJob` |CronJob Memory Usage |Bytes(SI) | Cluster,Namespace,CronJob|
|`CronJob_CPUUsage` |`CronJob` |CronJob CPU Utilization (as limit) |Percent | Cluster,Namespace,CronJob|
|`CronJob_MemoryUsage` |`CronJob` |CronJob Memory Utilization (as limit) |Percent | Cluster,Namespace,CronJob|
|`CronJob_CPUUsed` |`CronJob` |CronJob CPU Usage |Core | Cluster,Namespace,CronJob|
|`CronJob_GPU_Memory_Free` |`CronJob` |CronJob GPU Free Memory |Megabytes | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Memory_Used` |`CronJob` |CronJob GPU Used Memory |Megabytes | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Usage` |`CronJob` |CronJob GPU Utilization |Percent | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Count` |`CronJob` |CronJob GPU Count |Count | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Memory_Usage` |`CronJob` |CronJob GPU Memory Utilization |Percent | Cluster,Namespace,CronJob,GPU|
|`DaemonSet_MemoryUsed` |`DaemonSet` |DaemonSet Memory Usage |Bytes(SI) | Cluster,Namespace,DaemonSet|
|`DaemonSet_CPUUsage` |`DaemonSet` |DaemonSet CPU Utilization (as limit) |Percent | Cluster,Namespace,DaemonSet|
|`DaemonSet_MemoryUsage` |`DaemonSet` |DaemonSet Memory Utilization (as limit) |Percent | Cluster,Namespace,DaemonSet|
|`DaemonSet_CPUUsed` |`DaemonSet` |DaemonSet CPU Usage |Core | Cluster,Namespace,DaemonSet|
|`DaemonSet_GPU_Memory_Free` |`DaemonSet` |DaemonSet GPU Free Memory |Megabytes | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Memory_Used` |`DaemonSet` |DaemonSet GPU Used Memory |Megabytes | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Usage` |`DaemonSet` |DaemonSet GPU Utilization |Percent | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Count` |`DaemonSet` |DaemonSet GPU Count |Count | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Memory_Usage` |`DaemonSet` |DaemonSet GPU Memory Utilization |Percent | Cluster,Namespace,DaemonSet,GPU|
|`Deployment_MemoryUsed` |`Deployment` |Stateless Load Memory Usage |Bytes(SI) | Cluster,Namespace,Deployment|
|`Deployment_CPUUsage` |`Deployment` |Stateless Load CPU Utilization (as limit) |Percent | Cluster,Namespace,Deployment|
|`Deployment_MemoryUsage` |`Deployment` |Stateless Load Memory Utilization (as limit) |Percent | Cluster,Namespace,Deployment|
|`Deployment_CPUUsed` |`Deployment` |Stateless Load CPU Usage |Core | Cluster,Namespace,Deployment|
|`Deployment_GPU_Memory_Free` |`Deployment` |Stateless Load GPU Free Memory |Megabytes | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Memory_Used` |`Deployment` |Stateless Load GPU Used Memory |Megabytes | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Usage` |`Deployment` |Stateless Load GPU Utilization |Percent | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Count` |`Deployment` |Stateless Load GPU Count |Count | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Memory_Usage` |`Deployment` |Stateless Load GPU Memory Utilization |Percent | Cluster,Namespace,Deployment,GPU|
|`Job_CPUUsed` |`Job` |Job CPU Usage |Core | Cluster,Namespace,Job|
|`Job_MemoryUsed` |`Job` |Job Memory Usage |Bytes(SI) | Cluster,Namespace,Job|
|`Job_CPUUsage` |`Job` |Job CPU Utilization (as limit) |Percent | Cluster,Namespace,Job|
|`Job_MemoryUsage` |`Job` |Job Memory Utilization (as limit) |Percent | Cluster,Namespace,Job|
|`Job_GPU_Memory_Free` |`Job` |Job GPU Free Memory |Megabytes | Cluster,Namespace,Job,GPU|
|`Job_GPU_Memory_Used` |`Job` |Job GPU Used Memory |Megabytes | Cluster,Namespace,Job,GPU|
|`Job_GPU_Usage` |`Job` |Job GPU Utilization |Percent | Cluster,Namespace,Job,GPU|
|`Job_GPU_Count` |`Job` |Job GPU Count |Count | Cluster,Namespace,Job,GPU|
|`Job_GPU_Memory_Usage` |`Job` |Job GPU Memory Utilization |Percent | Cluster,Namespace,Job,GPU|
|`Namespace_CPUUsed` |`Namespace` |Namespace CPU Usage |Core | Cluster,Namespace|
|`Namespace_MemoryUsed` |`Namespace` |Namespace Memory Usage |Bytes(SI) | Cluster,Namespace|
|`Node_PodCount` |`Node` |Pod Count |Count | Cluster,Node|
|`Node_CPURequestUsage` |`Node` |Node CPU Allocation Rate (request) |Percent | Cluster,Node|
|`Node_MemoryRequestUsage` |`Node` |Node Memory Allocation Rate (request) |Percent | Cluster,Node|
|`Node_CPULimitUsage` |`Node` |Node CPU Allocation Rate (limit) |Percent | Cluster,Node|
|`Node_MemoryLimitUsage` |`Node` |Node Memory Allocation Rate (limit) |Percent | Cluster,Node|
|`Node_CPUUsage` |`Node` |Node CPU Utilization |Percent | Cluster,Node|
|`Node_MemoryUsage` |`Node` |Node Memory Utilization |Percent | Cluster,Node|
|`PersistentVolumeClaim_VolumeUsage` |`PersistentVolumeClaim` |Persistent Volume Claim Usage Rate |Percent | Cluster,Namespace,PersistentVolumeClaim|

## Objects {#object}

The structure of collected VolcEngine VKE object data can be viewed in "Infrastructure - Custom".

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