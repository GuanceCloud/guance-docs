---
title: '火山云 VKE'
tags: 
  - 火山引擎
summary: '火山云 VKE 指标采集，包括 Cluster、Container、Node、Pod等。'
__int_icon: 'icon/volcengine_vke'
dashboard:
  - desc: '火山云 VKE'
    path: 'dashboard/zh/volcengine_vke/'
---

<!-- markdownlint-disable MD025 -->
# 火山云 VKE
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
配置好火山云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山云云监控指标详情](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_VKE){:target="_blank"}

> 注意：需要在 `volcengine` VKE 控制台安装监控插件

| Metric | Description                          | Unit |
| ---- |-------------------------------------| :----: |
|`Cluster_NodeCount` |集群 Node 数量|Count|
|`Cluster_CPUUsage` |集群 CPU 使用率|Percent|
|`Cluster_MemoryUsage` |集群内存使用率|Percent|
|`Cluster_CPUUsed` |集群 CPU 用量|Core|
|`Cluster_MemoryUsed` |集群内存用量|Bytes(SI)|
|`Namespace_CPUUsed` | 命名空间 CPU 用量|Core|
|`Namespace_MemoryUsed` |命名空间内存用量|Bytes(SI)|
|`Node_PodCount` | Node 的 Pod 数量|Count|
|`Node_CPUUsage` |节点 CPU 使用率|Percent|
|`Node_MemoryUsage` |节点内存使用率|Percent|
|`Node_CPURequestUsage` |节点 CPU 分配率（request）|Percent|
|`Node_CPULimitUsage` |节点 CPU 分配率（limit）|Percent|
|`Node_MemoryRequestUsage` |节点内存分配率（request）|Percent|
|`Node_MemoryLimitUsage` |节点内存分配率（limit）|Percent|
|`Pod_CPUUsage` |容器组 CPU 使用率（占limit）|Percent|
|`Pod_CPUUsed` |容器组 CPU 用量|Count|
|`Pod_MemoryUsage` |容器组内存使用率（占limit）|Percent|
|`Pod_MemoryUsed` |容器组内存用量|Bytes(SI)|
|`Pod_NetworkReceiveBytesRate` |容器组网络流入流量速率|Bytes/Second(SI)|
|`Pod_NetworkReceiveLossPacketRate` |容器组网络流入丢包率|Percent|
|`Pod_NetworkTransmitBytesRate` |容器组网络流出流量速率|Bytes/Second(SI)|
|`Pod_NetworkTransmitLossPacketRate` |容器组网络流入流量速率|Percent|



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
