---
title: 'Azure Kubernetes'
tags: 
  - 'AZURE'
summary: '采集 Azure Kubernetes 指标数据'
__int_icon: 'icon/azure_kubernetes'
dashboard:
  - desc: 'Azure Kubernetes 监控视图'
    path: 'dashboard/zh/azure_kubernetes'
monitor   :
  - desc  : 'Azure Kubernetes 检测库'
    path  : 'monitor/zh/azure_kubernetes'
---

采集 Azure Kubernetes 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure Kubernetes Service 的监控数据，我们安装对应的采集脚本：「集成（Azure-Kubernetes service 采集）」(ID：`guance_azure_kubernetes`)

点击【安装】后，输入相应的参数：

- `Azure Tenant ID`：租户 ID
- `Azure Client ID`：应用注册 Client ID
- `Azure Client Secret Value`：客户端密码值，注意不是 ID
- `Subscriptions`：订阅 ID ,多个订阅用`,`分割

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集 Azure Kubernetes Service 指标,可以通过配置的方式采集更多的指标[Microsoft.ContainerService/managedClusters 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-containerservice-managedclusters-metrics){:target="_blank"}

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
|`apiserver_current_inflight_requests`| 进行中的请求数 | count |
|`cluster_autoscaler_cluster_safe_to_autoscale`| 集群运行状况 | boolean |
|`cluster_autoscaler_scale_down_in_cooldown`| 纵向缩减散热设备 | - |
|`cluster_autoscaler_unneeded_nodes_count`| 不需要的节点 | count |
|`cluster_autoscaler_unschedulable_pods_count`| 不可计划的 Pod | count |
|`kube_node_status_allocatable_cpu_cores`|  托管群集中可用 CPU 内核的总数 | count |
|`kube_node_status_allocatable_memory_bytes`| 托管群集中可用内存的总量 | count |
|`kube_node_status_condition`| 各种节点条件的状态 | count |
|`kube_pod_status_phase`| 依据阶段的 Pod 数 | count |
|`kube_pod_status_ready`| 就绪状态下的 Pod 数 | count |
|`node_cpu_usage_millicores`| CPU 使用率(毫核) | % |
|`node_disk_usage_bytes`| 磁盘已用字节数 | bytes |
|`node_disk_usage_percentage`| 磁盘已用百分比 | % |
|`node_memory_rss_bytes`| 内存 RSS 字节数 | bytes |
|`node_memory_rss_percentage`| 内存 RSS 百分比 | % |
|`node_memory_working_set_bytes`| 内存工作集字节数 | bytes |
|`node_memory_working_set_percentage`| 内存工作集百分比 | % |
|`node_network_in_bytes`| 网络传入字节数 | bytes |
|`node_network_out_bytes`| 网络传出字节数 | bytes |
