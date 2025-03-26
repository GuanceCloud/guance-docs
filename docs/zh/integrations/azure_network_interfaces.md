---
title: 'Azure Network Interfaces'
tags: 
  - 'AZURE'
summary: '采集 Azure Network Interface 指标数据'
__int_icon: 'icon/azure_network_interfaces'
dashboard:
  - desc: 'Azure Network Interface 监控视图'
    path: 'dashboard/zh/azure_network_interfaces'
monitor   :
  - desc  : 'Azure Network Interface 检测库'
    path  : 'monitor/zh/azure_network_interfaces'
---

采集 Azure Network Interfaces 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure Network Interface 的监控数据，我们安装对应的采集脚本：「集成（Azure-Network Interface 采集）」(ID：`guance_azure_network_interface`)

点击【安装】后，输入相应的参数：

- `Azure Tenant ID`：租户 ID
- `Azure Client ID`：应用注册 Client ID
- `Azure Client Secret Value`：客户端密码值，注意不是 ID
- `Subscriptions`：订阅 ID ,多个订阅用`,`分割

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集 Azure Network Interfaces 指标,可以通过配置的方式采集更多的指标[Microsoft.Network/networkinterfaces 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-network-networkinterfaces-metrics){:target="_blank"}

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
|`BytesReceivedRate`| 接收的字节数 | byte|
|`BytesSentRate`| 发送的字节数 | byte |
|`CreationRateMaxTotalFlowsIn`| 入站流最大创建速率 | count |
|`CreationRateMaxTotalFlowsOut`| 出站流最大创建速率 | count/s |
|`CurrentTotalFlowsIn`| 入站流 | count |
|`CurrentTotalFlowsOut`| 出站流 | count |
|`PacketsReceivedRate`| 已接收的数据包数 | count |
|`PacketsSentRate`| 发送的数据包数 | count |
