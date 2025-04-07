---
title: 'Azure Storage'
tags: 
  - 'AZURE'
summary: '采集 Azure Storage 指标数据'
__int_icon: 'icon/azure_storage'
dashboard:
  - desc: 'Azure Storage 监控视图'
    path: 'dashboard/zh/azure_storage'
monitor   :
  - desc  : 'Azure Storage 检测库'
    path  : 'monitor/zh/azure_storage'
---

采集 Azure Storage 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索 `guance_azure_storage`

2. 点击【安装】后，输入相应的参数：`Azure Tenant ID`、`Azure Client ID`，`Azure Client Secret Value`、`Subscriptions`

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集 Azure Storage 指标,可以通过配置的方式采集更多的指标:

[Microsoft.ClassicStorage/storageAccounts 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/blobServices 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-blobservices-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/fileServices 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-fileservices-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/queueServices 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-queueservices-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/tableServices 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-tableservices-metrics){:target="_blank"}

`Microsoft.Storage/storageAccounts`命名空间下，包含以下指标：

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
| `availability_average` | 可用性 | % |
| `egress_total` | 数据流出量 | Bytes |
| `ingress_total` | 数据流入量 | Bytes |
| `success_e_2_elatency_average` | 成功 E2E 延迟 | ms |
| `success_server_latency_average` | 成功服务器延迟 | ms |
| `transactions_total` | 向存储服务或指定的 API 操作发出的请求数 | Count |
| `used_capacity_average` | 已用容量 | Bytes |

`Microsoft.Storage/storageAccounts/blobServices`命名空间下，包含以下指标：

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
| `availability_average` | 可用性 | % |
| `egress_total` | 数据流出量 | Bytes |
| `ingress_total` | 数据流入量 | Bytes |
| `blob_capacity_average` | Blob 容量 | Bytes |
| `blob_count_average` | Blob 计数 | Count |
| `container_count_average` | Blob 容器计数 | Count |
| `index_capacity_average` | 索引容量 | Bytes |
| `success_e_2_elatency_average` | 成功 E2E 延迟 | ms |
| `success_server_latency_average` | 成功服务器延迟 | ms |
| `transactions_total` | 向存储服务或指定的 API 操作发出的请求数 | Count |

`Microsoft.Storage/storageAccounts/fileServices`命名空间下，包含以下指标：

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
| `availability_average` | 可用性 | % |
| `egress_total` | 数据流出量 | Bytes |
| `ingress_total` | 数据流入量 | Bytes |
| `file_capacity_average` | 文件容量 | Bytes |
| `file_count_average` | 文件计数 | Count |
| `file_share_capacity_quota_average` | 文件共享配额大小 | Bytes |
| `file_share_snapshot_count_average` | 文件共享计数 | Count |
| `file_share_snapshot_size_average` | 文件共享快照大小 | Bytes |
| `file_share_snapshot_count_average` | 文件共享快照计数 | Count |
| `success_e_2_elatency_average` | 成功 E2E 延迟 | ms |
| `success_server_latency_average` | 成功服务器延迟 | ms |
| `transactions_total` | 向存储服务或指定的 API 操作发出的请求数 | Count |

`Microsoft.Storage/storageAccounts/queueServices`命名空间下，包含以下指标：

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
| `availability_average` | 可用性 | % |
| `egress_total` | 数据流出量 | Bytes |
| `ingress_total` | 数据流入量 | Bytes |
| `queue_capacity_average` | 队列容量 | Bytes |
| `queue_count_average` | 队列计数 | Count |
| `queue_message_count_average` | 队列消息计数 | Count |
| `success_e_2_elatency_average` | 成功 E2E 延迟 | ms |
| `success_server_latency_average` | 成功服务器延迟 | ms |
| `transactions_total` | 向存储服务或指定的 API 操作发出的请求数 | Count |

`Microsoft.Storage/storageAccounts/tableServices`命名空间下，包含以下指标：

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
| `availability_average` | 可用性 | % |
| `egress_total` | 数据流出量 | Bytes |
| `ingress_total` | 数据流入量 | Bytes |
| `table_capacity_average` | 表容量 | Bytes |
| `table_count_average` | 表计数 | Count |
| `table_entity_count_average` | 表实体计数 | Count |
| `success_e_2_elatency_average` | 成功 E2E 延迟 | ms |
| `success_server_latency_average` | 成功服务器延迟 | ms |
| `transactions_total` | 向存储服务或指定的 API 操作发出的请求数 | Count |
