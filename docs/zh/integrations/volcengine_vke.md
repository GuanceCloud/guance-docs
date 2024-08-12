---
title: '火山引擎 VKE'
tags: 
  - 火山引擎
summary: '火山云 VKE 指标采集，包括 Cluster、Container、Node、Pod等。'
__int_icon: 'icon/volcengine_vke'
dashboard:
  - desc: '火山云 VKE'
    path: 'dashboard/zh/volcengine_vke/'
---

<!-- markdownlint-disable MD025 -->
# 火山引擎 VKE
<!-- markdownlint-enable -->


火山云容器服务(`Volcengine` Kubernetes Engine,VKE)， VKE 指标采集，包括 Cluster、Container、Node、Pod等。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的火山云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 VKE 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（火山云-VKE采集）」(ID：`guance_volcengine_vke`)

点击【安装】后，输入相应的参数：火山云 AK、火山云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好火山云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山云云监控指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_VKE){:target="_blank"}

> 注意：需要在 `volcengine` VKE 控制台安装监控插件

|`MetricName` |`SubNamespace` |指标名称 |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`Cluster_MemoryUsed` |`Cluster` |集群内存用量 |Bytes(SI) | Cluster|
|`Cluster_CPUUsage` |`Cluster` |集群 CPU 使用率 |Percent | Cluster|
|`Cluster_MemoryUsage` |`Cluster` |集群内存使用率 |Percent | Cluster|
|`Cluster_NodeCount` |`Cluster` |集群节点数量 |Count | Cluster|
|`Cluster_CPUUsed` |`Cluster` |集群 CPU 用量 |Core | Cluster|
|`Container_MemoryUsed` |`Container` |容器内存用量 |Bytes(SI) | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_CPUUsage` |`Container` |容器 CPU 使用率（占limit） |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_MemoryUsage` |`Container` |容器内存使用率（占limit） |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_CPUUsed` |`Container` |容器 CPU 用量 |Core | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container|
|`Container_GPU_Memory_Free` |`Container` |容器GPU显存未使用量 |Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Memory_Used` |`Container` |容器GPU显存用量 |Megabytes | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Usage` |`Container` |容器GPU使用率 |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Count` |`Container` |容器GPU卡数 |Count | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`Container_GPU_Memory_Usage` |`Container` |容器GPU显存使用率 |Percent | Cluster,Namespace,Deployment,StatefulSet,DaemonSet,CronJob,Job,Pod,Container,GPU|
|`CronJob_MemoryUsed` |`CronJob` |定时任务内存用量 |Bytes(SI) | Cluster,Namespace,CronJob|
|`CronJob_CPUUsage` |`CronJob` |定时任务 CPU 使用率（占limit） |Percent | Cluster,Namespace,CronJob|
|`CronJob_MemoryUsage` |`CronJob` |定时任务内存使用率（占limit） |Percent | Cluster,Namespace,CronJob|
|`CronJob_CPUUsed` |`CronJob` |定时任务 CPU 用量 |Core | Cluster,Namespace,CronJob|
|`CronJob_GPU_Memory_Free` |`CronJob` |定时任务GPU显存未使用量 |Megabytes | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Memory_Used` |`CronJob` |定时任务GPU显存用量 |Megabytes | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Usage` |`CronJob` |定时任务GPU使用率 |Percent | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Count` |`CronJob` |定时任务GPU卡数 |Count | Cluster,Namespace,CronJob,GPU|
|`CronJob_GPU_Memory_Usage` |`CronJob` |定时任务GPU显存使用率 |Percent | Cluster,Namespace,CronJob,GPU|
|`DaemonSet_MemoryUsed` |`DaemonSet` |守护进程内存用量 |Bytes(SI) | Cluster,Namespace,DaemonSet|
|`DaemonSet_CPUUsage` |`DaemonSet` |守护进程 CPU 使用率（占limit） |Percent | Cluster,Namespace,DaemonSet|
|`DaemonSet_MemoryUsage` |`DaemonSet` |守护进程内存使用率（占limit） |Percent | Cluster,Namespace,DaemonSet|
|`DaemonSet_CPUUsed` |`DaemonSet` |守护进程 CPU 用量 |Core | Cluster,Namespace,DaemonSet|
|`DaemonSet_GPU_Memory_Free` |`DaemonSet` |守护进程GPU显存未使用量 |Megabytes | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Memory_Used` |`DaemonSet` |守护进程GPU显存用量 |Megabytes | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Usage` |`DaemonSet` |守护进程GPU使用率 |Percent | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Count` |`DaemonSet` |守护进程GPU卡数 |Count | Cluster,Namespace,DaemonSet,GPU|
|`DaemonSet_GPU_Memory_Usage` |`DaemonSet` |守护进程GPU显存使用率 |Percent | Cluster,Namespace,DaemonSet,GPU|
|`Deployment_MemoryUsed` |`Deployment` |无状态负载内存用量 |Bytes(SI) | Cluster,Namespace,Deployment|
|`Deployment_CPUUsage` |`Deployment` |无状态负载 CPU 使用率（占limit） |Percent | Cluster,Namespace,Deployment|
|`Deployment_MemoryUsage` |`Deployment` |无状态负载内存使用率（占limit） |Percent | Cluster,Namespace,Deployment|
|`Deployment_CPUUsed` |`Deployment` |无状态负载 CPU 用量 |Core | Cluster,Namespace,Deployment|
|`Deployment_GPU_Memory_Free` |`Deployment` |无状态负载GPU显存未使用量 |Megabytes | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Memory_Used` |`Deployment` |无状态负载GPU显存用量 |Megabytes | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Usage` |`Deployment` |无状态负载GPU使用率 |Percent | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Count` |`Deployment` |无状态负载GPU卡数 |Count | Cluster,Namespace,Deployment,GPU|
|`Deployment_GPU_Memory_Usage` |`Deployment` |无状态负载GPU显存使用率 |Percent | Cluster,Namespace,Deployment,GPU|
|`Job_CPUUsed` |`Job` |任务 CPU 用量 |Core | Cluster,Namespace,Job|
|`Job_MemoryUsed` |`Job` |任务内存用量 |Bytes(SI) | Cluster,Namespace,Job|
|`Job_CPUUsage` |`Job` |任务 CPU 使用率（占limit） |Percent | Cluster,Namespace,Job|
|`Job_MemoryUsage` |`Job` |任务内存使用率（占limit） |Percent | Cluster,Namespace,Job|
|`Job_GPU_Memory_Free` |`Job` |任务GPU显存未使用量 |Megabytes | Cluster,Namespace,Job,GPU|
|`Job_GPU_Memory_Used` |`Job` |任务GPU显存用量 |Megabytes | Cluster,Namespace,Job,GPU|
|`Job_GPU_Usage` |`Job` |任务GPU使用率 |Percent | Cluster,Namespace,Job,GPU|
|`Job_GPU_Count` |`Job` |任务GPU卡数 |Count | Cluster,Namespace,Job,GPU|
|`Job_GPU_Memory_Usage` |`Job` |任务GPU显存使用率 |Percent | Cluster,Namespace,Job,GPU|
|`Namespace_CPUUsed` |`Namespace` |命名空间 CPU 用量 |Core | Cluster,Namespace|
|`Namespace_MemoryUsed` |`Namespace` |命名空间内存用量 |Bytes(SI) | Cluster,Namespace|
|`Node_PodCount` |`Node` |容器组个数 |Count | Cluster,Node|
|`Node_CPURequestUsage` |`Node` |节点 CPU 分配率（request） |Percent | Cluster,Node|
|`Node_MemoryRequestUsage` |`Node` |节点内存分配率（request） |Percent | Cluster,Node|
|`Node_CPULimitUsage` |`Node` |节点 CPU 分配率（limit） |Percent | Cluster,Node|
|`Node_MemoryLimitUsage` |`Node` |节点内存分配率（limit） |Percent | Cluster,Node|
|`Node_CPUUsage` |`Node` |节点 CPU 使用率 |Percent | Cluster,Node|
|`Node_MemoryUsage` |`Node` |节点内存使用率 |Percent | Cluster,Node|
|`PersistentVolumeClaim_VolumeUsage` |`PersistentVolumeClaim` |存储卷声明容量使用率 |Percent | Cluster,Namespace,PersistentVolumeClaim|



## 对象 {#object}

采集到的火山云 VKE 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
