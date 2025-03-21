---
title: 'Azure Virtual Network Gateway'
tags: 
  - 'AZURE'
summary: '采集 Azure Virtual Network Gateway 指标数据'
__int_icon: 'icon/azure_Virtual_network_gateway'
dashboard:
  - desc: 'Azure Virtual Network Gateway'
    path: 'dashboard/zh/azure_Virtual_network_gateway'
monitor   :
  - desc  : 'Azure Virtual Network Gateway 检测库'
    path  : 'monitor/zh/azure_Virtual_network_gateway'
---

采集 Azure Virtual Network Gateway 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure Virtual Network Gateway 的监控数据，我们安装对应的采集脚本：「 集成（Azure-Virtual Network Gateway 采集）」(ID：`guance_azure_virtual_network_gateway`)

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

采集 Azure Virtual Network Gateway 指标,可以通过配置的方式采集更多的指标[microsoft.network/virtualnetworkgateways 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-network-virtualnetworkgateways-metrics){:target="_blank"}

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
|`average_bandwidth_average`| 网关 S2S 带宽 | Bytes/s |
|`bgp_peer_status_average`| BGP 对等方状态 | count |
|`bgp_routes_advertised_total`| 播发的 BGP 路由数 | count |
|`bgp_routes_learned_total`| 获知的 BGP 路由数 | count |
|`express_route_gateway_active_flows_average`| 活动流的数量 | count |
|`express_route_gateway_bits_per_second_average`| 每秒接收的位数 | Bytes/s |
|`express_route_gateway_count_of_routes_advertised_to_peer_maximum`| 播发到对等方的路由计数| count |
|`express_route_gateway_count_of_routes_learned_from_peer_maximum`| 从对等方获知的路由计数| count |
|`express_route_gateway_cpu_utilization_average`| CPU 使用率 | % |
|`express_route_gateway_frequency_of_routes_changed_total`| 路由更改频率| % |
|`express_route_gateway_max_flows_creation_rate_maximum`| 每秒创建的流数上限 | count |
|`express_route_gateway_number_of_vm_in_vnet_maximum`| 虚拟网络中的 VM 数 | count |
|`express_route_gateway_packets_per_second_average`| 每秒接收的数据包数 | count |
|`inbound_flows_count_maximum`| 网关入站流 | % |
|`outbound_flows_count_maximum`| 网关出站流 | % |
|`vnet_address_prefix_count_total`| VNet 地址前缀计数| count |
|`mesa_count_total`| 隧道 MMSA 计数 | count |
|`qmsa_count_total`| 隧道 QMSA 计数 | count |
|`tunnel_average_bandwidth_average`| 隧道带宽 | Bytes/s |
|`tunnel_egress_bytes_total`| 隧道流出字节 | Byte |
|`tunnel_ingress_bytes_total`| 隧道流入字节| Byte |
|`tunnel_egress_packets_total`| 隧道流出数据包数 | count |
|`tunnel_ingress_packets_total`| 隧道流出数据包数 | count |
