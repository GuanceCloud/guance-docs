---
title: '华为云 DCAAS 云专线'
tags:
  - 华为云
summary: '采集华为云 DCAAS 指标数据'
__int_icon: 'icon/huawei_dcaas'
dashboard:
  - desc: '华为云 DCAAS 内置视图'
    path: 'dashboard/zh/huawei_dcaas/'

monitor:
  - desc: '华为云 DCAAS 监控器'
    path: 'monitor/zh/huawei_dcaas/'
---

采集华为云 DCAAS 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 DCAAS 监控数据，我们安装对应的采集脚本:

- **guance_huaweicloud_dcaas_virtual_interfaces**: 采集 DC云专线虚拟接口 监控指标数据
- **guance_huaweicloud_dcaas_direct_connects**: 采集 DC云专线物理连接 监控指标数据

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「观测云集成（华为云-云专线 DC-虚拟接口）」/ 「观测云集成（华为云-云专线 DC-物理连接）」，展开修改此脚本，找 collector_configs 和 monitor_configs 分别编辑下面 region_projects 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集华为云 DCAAS 指标, 可以通过配置的方式采集更多的指标 [华为云 DCAAS 指标详情](https://support.huaweicloud.com/usermanual-dc/dc_04_0802.html){:target="_blank"}

|   **指标ID**  |   **指标名称**   |  **指标含义** |  **取值范围**  | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `network_incoming_bits_rate`            |   网络流入带宽    |云专线连接侧入站数据的比特率。单位：bit/s   | ≥ 0 bit/s  | 物理连接和历史物理连接 | 1分钟             |
| `network_outgoing_bits_rate`            |   网络流出带宽    |云专线连接侧出站数据的比特率。单位：bit/s   | ≥ 0 bit/s  | 物理连接和历史物理连接 | 1分钟             |
| `network_incoming_bytes`            |   网络流入流量    |云专线连接侧入站数据的字节数。单位：byte   | ≥ 0 bytes  | 物理连接和历史物理连接 | 1分钟             |
| `network_outgoing_bytes`            |   网络流出流量    |云专线连接侧出站数据的字节数。单位：byte   | ≥ 0 bytes  | 物理连接和历史物理连接 | 1分钟             |
| `network_incoming_packets_rate`            |   网络流入包速率    |云专线连接侧入站数据包速率。单位：Packet/s   | ≥ 0 packets/s  | 物理连接和历史物理连接 | 1分钟             |
| `network_outgoing_packets_rate`            |   网络流出包速率    |云专线连接侧出站数据包速率。单位：Packet/s   | ≥ 0 packets/s  | 物理连接和历史物理连接 | 1分钟             |
| `network_incoming_packets`            |   网络流入包量    |云专线连接侧入站数据包数。单位：Packet   | ≥ 0 packets  | 物理连接和历史物理连接 | 1分钟             |
| `network_outgoing_packets`            |   网络流出包量    |云专线连接侧出站数据包数。单位：Packet   | ≥ 0 packets  | 物理连接和历史物理连接 | 1分钟             |
| `network_status`            |   端口状态    |云专线物理连接的端口状态。   | 0-DOWN 1-UP  | 物理连接和历史物理连接 | 1分钟             |
| `bgp_receive_route_num_v4`            |   接收到的IPV4路由条目数    |虚拟接口通过BGP协议学习到的IPV4的路由条目数。   | ≥0 个  | 虚拟接口 | 1分钟             |
| `bgp_receive_route_num_v6`            |   接收到的IPV6路由条目数    |虚拟接口通过BGP协议学习到的IPV6的路由条目数。   | ≥0 个  | 虚拟接口 | 1分钟             |
| `bgp_peer_status_v4`            |   IPv4 BGP PEER状态    |IPv4 BGP PEER状态   | 0-DOWN 1-ACTIVE  | 虚拟接口 | 1分钟             |
| `bgp_peer_status_v6`            |   IPv6 BGP PEER状态    |IPv6 BGP PEER状态   | 0-DOWN 1-ACTIVE  | 虚拟接口 | 1分钟             |
| `in_errors`            |   网络流入错误包量    |云专线连接侧入站错误数据包数   | 0-2^23 | 虚拟接口 | 1分钟             |

## 对象 {#object}

数据正常同步后，可以在观测云的「基础设施 - 资源目录」中查看数据。

- DC云专线虚拟接口 对象数据:

```json
{
  "measurement": "huaweicloud_dcass_virtual_interface",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17exxxxb2a16ea41912e52d",
    "enterprise_project_id"   : "320a1900-b6d2-xxxx-a348-0979986b730b",
    "tenant_id"               : "07d662153ada40c5bd984601976xxxx",
    "virtual_interface_id"    : "ccaad430-389c-4fe6-xxxx-2543e1b0d1b5",
    "virtual_interface_name"  : "vif-xxxx-xx-2g02",
    "direct_connect_id"       : "b032de49-2932-4ae3-xxxx-c0234f60afce",
    "status"                  : "ACTIVE"
  },
  "fields": {
    "type"              : "private",
    "service_type"      : "GDGW",
    "vgw_id"            : "xxxxxxxxxx",
    "bandwidth"         : "500",
    "description"       : "{JSON 数据}",
    "device_id"         : "120.87.xxx.9",
    "create_time"       : "2024/11/21 18:31:22",
    "tags"              : "[]"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`virtual_interface_id`值为 DC虚拟接口ID，作为唯一识别
>
> 提示 2：`ACTIVE`,`DOWN`为status对应的值

- DC云专线物理连接 对象数据:

```json
{
  "measurement": "huaweicloud_dcass_virtual_interface",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17exxxxb2a16ea41912e52d",
    "enterprise_project_id"   : "320a1900-b6d2-xxxx-a348-0979986b730b",
    "tenant_id"               : "07d662153ada40c5bd984601976xxxx",
    "direct_connect_id"       : "ccaad430-389c-4fe6-xxxx-2543e1b0d1b5",
    "direct_connect_name"     : "vif-xxxx-xx-2g02",
    "status"                  : "ACTIVE"
  },
  "fields": {
    "type"              : "private",
    "bandwidth"         : "500",
    "description"       : "{JSON 数据}",
    "location"          : "Shanghaixx-xxx",
    "provider"          : "others",
    "provider_status"   : "ACTIVE",
    "charge_mode"       : "prepayment",
    "device_id"         : "xx.87.xxx.9",
    "hosting_id"        : "345ed71f-91b6-4248-xxxx-952bdb1c3706",
    "port_type"         : "40G",
    "apply_time"        : "2023-05-24T08:53:05.000Z",
    "create_time"       : "2024/11/21 18:31:22",
    "tags"              : "[]"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`direct_connect_id`值为 物理连接ID，作为唯一识别
>
> 提示 2：`ACTIVE`,`DOWN`为status对应的值
