---
title: 'Volcengine VKE'
tags: 
  - Volcengine
summary: 'Volcengine VKE Metrics Collection, including Cluster, Container, Node, Pod, etc.'
__int_icon: 'icon/volcengine_vke'
dashboard:
  - desc: 'Volcengine VKE'
    path: 'dashboard/en/volcengine_vke/'
---

<!-- markdownlint-disable MD025 -->
# Volcengine VKE
<!-- markdownlint-enable -->


Volcengine Container Service (`Volcengine` Kubernetes Engine, VKE), VKE Metrics Collection, including Cluster, Container, Node, Pod, etc.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a qualified Volcengine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of VKE cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Volcengine-VKE Collection)" (ID: `guance_volcengine_vke`)

After clicking 【Install】, input the corresponding parameters: Volcengine AK and Volcengine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default collect some configurations, for details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have been configured for automatic triggers. You can also check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Volcengine - Cloud Monitoring, the default Metric Set is as follows. You can collect more metrics through configuration. [Volcengine Cloud Monitoring Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_VKE){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the `volcengine` VKE console.

|`MetricName` |`SubNamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`Cluster_MemoryUsed` |`Cluster` |Cluster Memory Usage |Bytes(SI) | Cluster|
|`Cluster_CPUUsage` |`Cluster` |Cluster CPU Usage Rate |Percent | Cluster|
|`Cluster_MemoryUsage` |`Cluster` |Cluster Memory Usage Rate |Percent | Cluster|
|`Cluster_NodeCount` |`Cluster` |Cluster Node Count |Count | Cluster|
|`Cluster_CPUUsed` |`Cluster` |Cluster CPU Usage |Core | Cluster|
|`Container_MemoryUsed` |`Container` |Container Memory Usage |Bytes(SI) | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_CPUUsage` |`Container` |Container CPU Usage Rate (percentage of limit) |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_MemoryUsage` |`Container` |Container Memory Usage Rate (percentage of limit) |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_CPUUsed` |`Container` |Container CPU Usage |Core | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_GPU_Memory_Free` |`Container` |Container GPU Memory Free |Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Memory_Used` |`Container` |Container GPU Memory Used |Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Usage` |`Container` |Container GPU Usage Rate |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Count` |`Container` |Container GPU Card Count |Count | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Memory_Usage` |`Container` |Container GPU Memory Usage Rate |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`CronJob_MemoryUsed` |`CronJob` |CronJob Memory Usage |Bytes(SI) | Cluster,Namespace,CronJob|
|`CronJob_CPUUsage` |`CronJob` |CronJob CPU Usage Rate (percentage of limit) |Percent | Cluster,Namespace,CronJob|
|`CronJob_MemoryUsage` |`CronJob` |CronJob Memory Usage Rate (percentage of limit) |Percent | Cluster,Namespace,CronJob|
|`CronJob_CPUUsed` |`CronJob` |CronJob CPU Usage |Core | Cluster,Namespace,CronJob|
|`CronJob_GPU_Memory_Free` |`CronJob` |CronJob GPU Memory Free |Megabytes | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Memory_Used` |`CronJob` |CronJob GPU Memory Used |Megabytes | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Usage` |`CronJob` |CronJob GPU Usage Rate |Percent | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Count` |`CronJob` |CronJob GPU Card Count |Count | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Memory_Usage` |`CronJob` |CronJob GPU Memory Usage Rate |Percent | Cluster,Namespace,CronJob,GPU|
|`DaemonSet_MemoryUsed` |`DaemonSet` |DaemonSet Memory Usage |Bytes(SI) | Cluster,Namespace,DaemonSet|
|`DaemonSet_CPUUsage` |`DaemonSet` |DaemonSet CPU Usage Rate (percentage of limit) |Percent | Cluster,Namespace,DaemonSet|
|`DaemonSet_MemoryUsage` |`DaemonSet` |DaemonSet Memory Usage Rate (percentage of limit) |Percent | Cluster,Namespace,DaemonSet|
|`DaemonSet_CPUUsed` |`DaemonSet` |DaemonSet CPU Usage |Core | Cluster,Namespace,DaemonSet|
|`DaemonSet_GPU_Memory_Free` |`DaemonSet` |DaemonSet GPU Memory Free |Megabytes | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Memory_Used` |`DaemonSet` |DaemonSet GPU Memory Used |Megabytes | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Usage` |`DaemonSet` |DaemonSet GPU Usage Rate |Percent | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Count` |`DaemonSet` |DaemonSet GPU Card Count |Count | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Memory_Usage` |`DaemonSet` |DaemonSet GPU Memory Usage Rate |Percent | Cluster,Namespace,DaemonSet,GPU|
|`Deployment_MemoryUsed` |`Deployment` |Deployment Memory Usage |Bytes(SI) | Cluster,Namespace,Deployment|
|`Deployment_CPUUsage` |`Deployment` |Deployment CPU Usage Rate (percentage of limit) |Percent | Cluster,Namespace,Deployment|
|`Deployment_MemoryUsage` |`Deployment` |Deployment Memory Usage Rate (percentage of limit) |Percent | Cluster,Namespace,Deployment|
|`Deployment_CPUUsed` |`Deployment` |Deployment CPU Usage |Core | Cluster,Namespace,Deployment|
|`Deployment_GPU_Memory_Free` |`Deployment` |Deployment GPU Memory Free |Megabytes | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Memory_Used` |`Deployment` |Deployment GPU Memory Used |Megabytes | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Usage` |`Deployment` |Deployment GPU Usage Rate |Percent | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Count` |`Deployment` |Deployment GPU Card Count |Count | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Memory_Usage` |`Deployment` |Deployment GPU Memory Usage Rate |Percent | Cluster,Namespace,Deployment,GPU|
|`Job_CPUUsed` |`Job` |Job CPU Usage |Core | Cluster,Namespace,Job|
|`Job_MemoryUsed` |`Job` |Job Memory Usage |Bytes(SI) | Cluster,Namespace,Job|
|`Job_CPUUsage` |`Job` |Job CPU Usage Rate (percentage of limit) |Percent | Cluster,Namespace,Job|
|`Job_MemoryUsage` |`Job` |Job Memory Usage Rate (percentage of limit) |Percent | Cluster,Namespace,Job|
|`Job_GPU_Memory_Free` |`Job` |Job GPU Memory Free |Megabytes | Cluster,Namespace,Job,GPU|
|`Job_GPU_Memory_Used` |`Job` |Job GPU Memory Used |Megabytes | Cluster,Namespace,Job,GPU|
|`Job_GPU_Usage` |`Job` |Job GPU Usage Rate |Percent | Cluster,Namespace,Job,GPU|
|`Job_GPU_Count` |`Job` |Job GPU Card Count |Count | Cluster,Namespace,Job,GPU|
|`Job_GPU_Memory_Usage` |`Job` |Job GPU Memory Usage Rate |Percent | Cluster,Namespace,Job,GPU|
|`Namespace_CPUUsed` |`Namespace` |Namespace CPU Usage |Core | Cluster,Namespace|
|`Namespace_MemoryUsed` |`Namespace` |Namespace Memory Usage |Bytes(SI) | Cluster,Namespace|
|`Node_PodCount` |`Node` |Pod Count |Count | Cluster,Node|
|`Node_CPURequestUsage` |`Node` |Node CPU Allocation Rate (request) |Percent | Cluster,Node|
|`Node_MemoryRequestUsage` |`Node` |Node Memory Allocation Rate (request) |Percent | Cluster,Node|
|`Node_CPULimitUsage` |`Node` |Node CPU Allocation Rate (limit) |Percent | Cluster,Node|
|`Node_MemoryLimitUsage` |`Node` |Node Memory Allocation Rate (limit) |Percent | Cluster,Node|
|`Node_CPUUsage` |`Node` |Node CPU Usage Rate |Percent | Cluster,Node|
|`Node_MemoryUsage` |`Node` |Node Memory Usage Rate |Percent | Cluster,Node|
|`PersistentVolumeClaim_VolumeUsage` |`PersistentVolumeClaim` |Persistent Volume Claim Capacity Usage Rate |Percent | Cluster,Namespace,PersistentVolumeClaim|



## Objects {#object}

The structure of collected Volcengine VKE object data can be viewed under "Infrastructure - Custom".

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