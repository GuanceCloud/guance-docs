---
title: 'Aliyun NAT'
summary: 'Aliyun NAT Indicators, including the number of concurrent connections, number of new connections, VPC traffic, and VPC data packets。'
__int_icon: 'icon/aliyun_nat'
dashboard:
  - desc: '阿里云 NAT 内置视图'
    path: 'dashboard/zh/aliyun_nat/'

---

<!-- markdownlint-disable MD025 -->
# Aliyun NAT
<!-- markdownlint-enable -->

Aliyun NAT indicators, including the number of concurrent connections, number of new connections, VPC traffic, and VPC data packets。

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Deployment of the GSE version is recommended

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「观测云集成（阿里云-NAT采集）」(ID：`guance_aliyun_nat`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Aliyun OSS monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Aliyun Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

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

## Object {#object}

The collected Aliyun NAT object data structure can see the object data from「基础设施-自定义」

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
