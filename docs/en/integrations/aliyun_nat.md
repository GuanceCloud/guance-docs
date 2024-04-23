---
title: 'Aliyun NAT'
tags: 
  - Alibaba Cloud
summary: 'Aliyun NAT Metrics, including the number of concurrent connections, number of new connections, VPC traffic, and VPC data packets。'
__int_icon: 'icon/aliyun_nat'
dashboard:
  - desc: 'Aliyun NAT Monitoring View'
    path: 'dashboard/zh/aliyun_nat/'

---

<!-- markdownlint-disable MD025 -->
# Aliyun NAT
<!-- markdownlint-enable -->

Aliyun NAT metrics, including the number of concurrent connections, number of new connections, VPC traffic, and VPC data packets。

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Deployment of the GSE version is recommended

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -NATCollect）」(ID：`guance_aliyun_nat`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Aliyun OSS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                         | Metric Name              | Dimensions              | Statistics | Unit   | Min Periods |
| ---- | ------ | ------ | ---- | ---- | ---- |
| BWRateInFromInside                | Traffic Rate from VPC | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateInFromOutside               | Traffic Rate from Public Network | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToInside                 | Inbound VPC Traffic Rate | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToOutside                | Inbound Public Network Traffic Rate | userId,instanceId       | Value      | bps    | 60 s        |
| BytesInFromInside                 | Traffic from VPC | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesInFromOutside                | Traffic from Public Network | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToInside                  | Inbound VPC Traffic | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToOutside                 | Inbound Public Network Traffic | userId,instanceId       | Value      | bytes  | 60 s        |
| DropTotalBps                      | Total Bandwidth of Packet Loss | userId,instanceId       | Value      | bit/s  | 60 s        |
| DropTotalPps                      | Total Rate of Packet Loss | userId,instanceId       | Value      | countS | 60 s        |
| EniBytesDropRx                    | Inbound Interface Drop Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesDropTx                    | Outbound Interface Drop Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesRx                        | Inbound Interface Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesTx                        | Outbound Interface Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniPacketsDropPortAllocationFail  | Number of Failed Port Assignments on the Interface | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropRx                  | Inbound Interface Dropped Packet Volume | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropTx                  | Outbound Interface Dropped Packet Volume | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsRx                      | Inbound Interface Packet Volume | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsTx                      | Outbound Interface Packet Volume | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionActiveConnection        | Interface Concurrent Connection Number | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionLimitDropConnection     | Interface New Dropped Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewConnection           | Interface New Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewLimitDropConnection  | Interface Concurrent Dropped Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| ErrorPortAllocationCount          | Number of port allocation failures within the interval | userId,instanceId       | Value      | count  | 60 s        |
| ErrorPortAllocationRate           | Rate of port allocation failures within the interval | userId,instanceId       | Value      | countS | 60 s        |
| InBpsSum                          | Throughput           | userId,instanceId       | Value      | bit/s  | 60 s        |
| PPSRateInFromInside               | Packet rate from VPC | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateInFromOutside              | Packet rate from the public network | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToInside                | Packet rate into VPC | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToOutside               | Packet rate into the public network | userId,instanceId       | Value      | countS | 60 s        |
| PacketsInFromInside               | Packet volume from VPC | userId,instanceId       | Value      | count  | 60 s        |
| PacketsInFromOutside              | Packet volume from the public network | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToInside                | Packet volume into VPC | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToOutside               | Packet volume into the public network | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnection           | Number of concurrent connections | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnectionWaterLever | Concurrent connection water level | userId,instanceId       | Value      | %      | 60 s        |
| SessionLimitDropConnection        | Concurrent connection drop rate | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnection              | New connection rate | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnectionWaterLever    | New connection water level | userId,instanceId       | Value      | %      | 60 s        |
| SessionNewLimitDropConnection     | New drop connection rate | userId,instanceId       | Value      | countS | 60 s        |

## Object {#object}

The collected Aliyun NAT object data structure can see the object data from「Infrastructure-Custom」

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
    "message"     : "{Instance JSON data}"
  }
}

```
