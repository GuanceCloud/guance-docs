---
title: 'Volcengine VKE'
tags: 
  - `Volcengine`
summary: 'Volcengine VKE metrics collection, including Cluster, Container, Node, Pod, etc.'
__int_icon: 'icon/volcengine_vke'
dashboard:
  - desc: 'Volcengine VKE'
    path: 'dashboard/zh/volcengine_vke/'
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
Configure `Volcenine` Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcenine` Cloud Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_VKE){:target="_blank"}

| Metric | Description                          | Unit |
| ---- |-------------------------------------| :----: |
|`Cluster_NodeCount` |Number of cluster nodes|Count|
|`Cluster_CPUUsage` |Cluster CPU usage rate|Percent|
|`Cluster_MemoryUsage` |Cluster memory usage rate|Percent|
|`Cluster_CPUUsed` |Cluster CPU usage|Core|
|`Cluster_MemoryUsed` |Cluster memory usage|Bytes(SI)|
|`Namespace_CPUUsed` | Namespace CPU usage|Core|
|`Namespace_MemoryUsed` |Namespace memory usage|Bytes(SI)|
|`Node_PodCount` | Number of Pods in Node|Count|
|`Node_CPUUsage` |Node CPU usage rate|Percent|
|`Node_MemoryUsage` |Node memory usage rate|Percent|
|`Node_CPURequestUsage` |Node CPU allocation rate (request)|Percent|
|`Node_CPULimitUsage` |Node CPU allocation rate (limit)|Percent|
|`Node_MemoryRequestUsage` |Node memory allocation rate (request)|Percent|
|`Node_MemoryLimitUsage` |Node memory allocation rate (limit)|Percent|
|`Pod_CPUUsage` |CPU usage rate of container group (as a percentage of limit)|Percent|
|`Pod_CPUUsed` |CPU usage of container group|Count|
|`Pod_MemoryUsage` |Container group memory usage rate (as a percentage of limit)|Percent|
|`Pod_MemoryUsed` |Container group memory usage|Bytes(SI)|
|`Pod_NetworkReceiveBytesRate` |Container group network inflow traffic rate|Bytes/Second(SI)|
|`Pod_NetworkReceiveLossPacketRate` |Container group network inflow packet loss rate|Percent|
|`Pod_NetworkTransmitBytesRate` |Container group network outflow traffic rate|Bytes/Second(SI)|
|`Pod_NetworkTransmitLossPacketRate` |Container group network inflow traffic rate|Percent|



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

```
