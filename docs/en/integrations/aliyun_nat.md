---
title: 'Alibaba Cloud NAT'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud NAT metrics display, including concurrent connections, new connections, VPC traffic, VPC packets, etc.'
__int_icon: 'icon/aliyun_nat'
dashboard:
  - desc: 'Alibaba Cloud NAT built-in views'
    path: 'dashboard/en/aliyun_nat/'

---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud NAT
<!-- markdownlint-enable -->

Alibaba Cloud NAT metrics display, including concurrent connections, new connections, VPC traffic, VPC packets, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of NAT cloud resources, we install the corresponding collection script:「Guance Integration (Alibaba Cloud-NAT Collection)」(ID: `guance_aliyun_nat`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We have collected some configurations by default; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                         | Metric Name              | Dimensions              | Statistics | Unit   | Min Periods |
| ---- | ------ | ------ | ---- | ---- | ---- |
| BWRateInFromInside                | Traffic Rate from VPC     | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateInFromOutside               | Traffic Rate from Public  | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToInside                 | Traffic Rate into VPC     | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToOutside                | Traffic Rate into Public  | userId,instanceId       | Value      | bps    | 60 s        |
| BytesInFromInside                 | Traffic from VPC          | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesInFromOutside                | Traffic from Public       | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToInside                  | Traffic into VPC          | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToOutside                 | Traffic into Public       | userId,instanceId       | Value      | bytes  | 60 s        |
| DropTotalBps                      | Total Dropped Bandwidth   | userId,instanceId       | Value      | bit/s  | 60 s        |
| DropTotalPps                      | Total Dropped Packet Rate | userId,instanceId       | Value      | countS | 60 s        |
| EniBytesDropRx                    | Interface Inbound Dropped Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesDropTx                    | Interface Outbound Dropped Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesRx                        | Interface Inbound Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesTx                        | Interface Outbound Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniPacketsDropPortAllocationFail  | Interface Port Allocation Failed Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropRx                  | Interface Inbound Dropped Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropTx                  | Interface Outbound Dropped Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsRx                      | Interface Inbound Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsTx                      | Interface Outbound Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionActiveConnection        | Interface Concurrent Connections | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionLimitDropConnection     | Interface New Dropped Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewConnection           | Interface New Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewLimitDropConnection  | Interface Concurrent Dropped Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| ErrorPortAllocationCount          | Number of Port Allocation Failures in Interval | userId,instanceId       | Value      | count  | 60 s        |
| ErrorPortAllocationRate           | Port Allocation Failure Rate in Interval | userId,instanceId       | Value      | countS | 60 s        |
| InBpsSum                          | Throughput                | userId,instanceId       | Value      | bit/s  | 60 s        |
| PPSRateInFromInside               | Packet Rate from VPC      | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateInFromOutside              | Packet Rate from Public   | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToInside                | Packet Rate into VPC      | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToOutside               | Packet Rate into Public   | userId,instanceId       | Value      | countS | 60 s        |
| PacketsInFromInside               | Packet Volume from VPC    | userId,instanceId       | Value      | count  | 60 s        |
| PacketsInFromOutside              | Packet Volume from Public | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToInside                | Packet Volume into VPC    | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToOutside               | Packet Volume into Public | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnection           | Concurrent Connections    | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnectionWaterLever | Concurrent Connection Water Level | userId,instanceId       | Value      | %      | 60 s        |
| SessionLimitDropConnection        | Concurrent Dropped Connection Rate | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnection              | New Connection Rate       | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnectionWaterLever    | New Connection Water Level | userId,instanceId       | Value      | %      | 60 s        |
| SessionNewLimitDropConnection     | New Dropped Connection Rate | userId,instanceId       | Value      | countS | 60 s        |

## Objects {#object}

The structure of the collected Alibaba Cloud SLB object data can be viewed in 「Infrastructure-Custom」

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
