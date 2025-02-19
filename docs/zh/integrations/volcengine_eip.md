---
title: '火山引擎 EIP'
tags: 
  - 火山引擎
summary: '采集火山引擎 EIP 指标数据'
__int_icon: 'icon/volcengine_eip'
dashboard:

  - desc: '火山引擎 EIP 内置视图'
    path: 'dashboard/zh/volcengine_eip'

monitor:
  - desc: '火山引擎 EIP 监控器'
    path: 'monitor/zh/volcengine_eip'
---

采集火山引擎 EIP 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 EIP 云资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（火山引擎-EIP采集）」(ID：`guance_volcengine_eip`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名、地域Regions。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置火山引擎 EIP 监控指标，可以通过配置的方式采集更多的指标 [火山引擎 EIP 指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_EIP){:target="_blank"}

|`MetricName` |`Subnamespace` |指标名称 |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `InTraffic` | `Instance` | 入方向流量 | Bytes | ResourceID |
| `OutTraffic` | `Instance` | 出方向流量 | Bytes | ResourceID |
| `InPackets` | `Instance` | 入方向数据包数 | Count | ResourceID |
| `OutPackets` | `Instance` | 出方向数据包数 | Count | ResourceID |
| `InBPS` | `Instance` | 入方向带宽 | Bits/Second | ResourceID |
| `OutBPS` | `Instance` | 出方向带宽 | Bits/Second | ResourceID |
| `InPacketsRate` | `Instance` | 入方向包速率 | Packet/Second | ResourceID |
| `OutPacketsRate` | `Instance` | 出方向包速率 | Packet/Second | ResourceID |
| `OutPacketsDropRate` | `Instance` | 出方向限速丢包速率 | Packet/Second | ResourceID |
| `OutRatePercentage` | `Instance` | 网络流出带宽利用率 | Percent | ResourceID |
| `InRatePercentage` | `Instance` | 网络流入带宽利用率 | Percent | ResourceID |
| `InPacketsDropRate` | `Instance` | 入方向限速丢包速率 | Packet/Second | ResourceID |

## 对象 {#object}

采集到的火山引擎 EIP 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

``` json
  {
    "measurement": "volcengine_eip",
    "tags": {
    "AllocationId"    : "eip-xxxxlsmpds73inqkqifze9",
    "Description"     : "",
    "EipAddress"      : "14.103.xx.xx",
    "RegionId"        : "cn-guangzhou",
    "ProjectName"     : "default",
    "name"            : "url-5gwfnylsmpds73inqkxxxx"
    },
    "fileds": {
      "AllocationTime": "2024-12-08T21:42:17+08:00",
      "Bandwidth"     : 115,
      "ExpiredTime"   : "",
      "ISP"           : "BGP"
      "InstanceId"    : "i-ydkgzgx14wwuxjsfi06q",
      "InstanceType"  : "EcsInstance",
      "IsBlocked"     : false,
      "Status"        : "Attached",
      "Tags"          : "[]"
    }
  }
```
