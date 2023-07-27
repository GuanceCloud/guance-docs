---
title: '阿里云 SLB'
summary: '阿里云 SLB 指标展示，包括后端 ECS 实例状态、端口连接数、 QPS、网络流量、状态码等。'
__int_icon: 'icon/aliyun_slb'
dashboard:
  - desc: '阿里云 SLB 内置视图'
    path: 'dashboard/zh/aliyun_slb/'

monitor:
  - desc: '阿里云 SLB 监控器'
    path: 'monitor/zh/aliyun_slb/'
---

阿里云 SLB 指标展示，包括后端 ECS 实例状态、端口连接数、 QPS、网络流量、状态码等。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（阿里云-）」(ID：`guance_aliyun_slb`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

## 对象 {#object}

采集到的阿里云 SLB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_slb",
  "tags": {
    "name"              : "lb.xxxxxxxx",
    "LoadBalancerId"    : "lb.xxxxxxxxx",
    "RegionId"          : "cn-shanghai",
    "SlaveZoneId"       : "cn-shanghai-i",
    "MasterZoneId"      : "cn-shanghai",
    "Address"           : "172.xxx.xxx.xxx",
    "PayType"           : "PayOnDemand",
    "InternetChargeType": "paybytraffic",
    "LoadBalancerName"  : "业务系统",
    "LoadBalancerStatus": "active",
    "AutoReleaseTime"   : "1513947075000",
    "RenewalStatus"     : "AutoRenewal",
    "AddressType"       : "Internet",
    "NetworkType"       : "vpc",
},
  "fields": {
    "CreateTime"              : "2020-11-18T08:47:11Z",
    "ListenerPortsAndProtocol": "{监听端口 JSON 数据}",
    "ServerHealthStatus"      : "{实例健康状态 JSON 数据}",
    "ServerCertificates"      : "{证书信息 JSON 数据}",
    "Bandwidth"               : "5120",
    "EndTimeStamp"            : "32493801600000",
    "message"                 : "{实例 JSON 数据}",
  }
}
```
