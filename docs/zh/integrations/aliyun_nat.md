---
title: '阿里云 NAT'
tags: 
  - 阿里云
summary: '阿里云 NAT 指标展示，包括并发连接数、新建连接数、 VPC 流量、 VPC 数据包等。'
__int_icon: 'icon/aliyun_nat'
dashboard:
  - desc: '阿里云 NAT 内置视图'
    path: 'dashboard/zh/aliyun_nat/'

---

<!-- markdownlint-disable MD025 -->
# 阿里云 NAT
<!-- markdownlint-enable -->

阿里云 NAT 指标展示，包括并发连接数、新建连接数、 VPC 流量、 VPC 数据包等。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 NAT 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-NAT采集）」(ID：`guance_aliyun_nat`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                         | Metric Name              | Dimensions              | Statistics | Unit   | Min Periods |
| ---- | ------ | ------ | ---- | ---- | ---- |
| BWRateInFromInside                | 从VPC来流量速率          | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateInFromOutside               | 从公网来流量速率         | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToInside                 | 入VPC流量速率            | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToOutside                | 入公网流量速率           | userId,instanceId       | Value      | bps    | 60 s        |
| BytesInFromInside                 | 从VPC来流量              | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesInFromOutside                | 从公网来流量             | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToInside                  | 入VPC流量                | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToOutside                 | 入公网流量               | userId,instanceId       | Value      | bytes  | 60 s        |
| DropTotalBps                      | 报文丢弃总带宽           | userId,instanceId       | Value      | bit/s  | 60 s        |
| DropTotalPps                      | 报文丢弃总速率           | userId,instanceId       | Value      | countS | 60 s        |
| EniBytesDropRx                    | 接口入丢弃流量           | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesDropTx                    | 接口出丢弃流量           | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesRx                        | 接口入流量               | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesTx                        | 接口出流量               | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniPacketsDropPortAllocationFail  | 接口端口分配失败包数量   | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropRx                  | 接口入丢弃报文量         | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropTx                  | 接口出丢弃报文量         | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsRx                      | 接口入报文量             | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsTx                      | 接口出报文量             | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionActiveConnection        | 接口并发连接数           | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionLimitDropConnection     | 接口新建丢弃连接速率     | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewConnection           | 接口新建连接速率         | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewLimitDropConnection  | 接口并发丢弃连接速率     | userId,instanceId,eniId | Value      | countS | 60 s        |
| ErrorPortAllocationCount          | 区间内port分配失败的个数 | userId,instanceId       | Value      | count  | 60 s        |
| ErrorPortAllocationRate           | 区间内port分配失败的速率 | userId,instanceId       | Value      | countS | 60 s        |
| InBpsSum                          | 吞吐                     | userId,instanceId       | Value      | bit/s  | 60 s        |
| PPSRateInFromInside               | 从VPC来包速率            | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateInFromOutside              | 从公网来包速率           | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToInside                | 入VPC包速率              | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToOutside               | 入公网包速率             | userId,instanceId       | Value      | countS | 60 s        |
| PacketsInFromInside               | 从VPC来包量              | userId,instanceId       | Value      | count  | 60 s        |
| PacketsInFromOutside              | 从公网来包量             | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToInside                | 入VPC包量                | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToOutside               | 入公网包量               | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnection           | 并发连接数               | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnectionWaterLever | 并发连接水位             | userId,instanceId       | Value      | %      | 60 s        |
| SessionLimitDropConnection        | 并发丢弃连接速率         | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnection              | 新建连接速率             | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnectionWaterLever    | 新建连接水位             | userId,instanceId       | Value      | %      | 60 s        |
| SessionNewLimitDropConnection     | 新建丢弃连接速率         | userId,instanceId       | Value      | countS | 60 s        |

## 对象 {#object}

采集到的阿里云 SLB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_nat",
  "tags": {
    "name"              : "ngw-bp1b3urqh0t7xxxxx",
    "NatGatewayId"      : "ngw-bp1b3urqh0t7xxxxx",
    "instance_name"     : "Operator",
    "VpcId"             : "vpc-bp1l3jzwhv8cnu9p8u4yh",
    "Spec"              : "Small",
    "InstanceChargeType": "PrePaid",
    "RegionId"          : "cn-hangzhou",
    "BusinessStatus"    : "Normal"
  },
  "fields": {
    "CreationTime": "2021-01-27T06:15:48Z",
    "ExpiredTime" : "2022-04-27T16:00Z",
    "message"     : "{实例 JSON 数据}"
  }
}

```
