---
title: 'Alibaba Cloud NAT'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud NAT Metrics Display, including concurrent connections, new connections, VPC traffic, VPC packets, etc.'
__int_icon: 'icon/aliyun_nat'
dashboard:
  - desc: 'Alibaba Cloud NAT Built-in Views'
    path: 'dashboard/en/aliyun_nat/'

---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud NAT
<!-- markdownlint-enable -->

Alibaba Cloud NAT Metrics Display, including concurrent connections, new connections, VPC traffic, VPC packets, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Expansion - Hosted Func: All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of NAT cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-NAT Collection)" (ID: `guance_aliyun_nat`)

After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, for more details see the metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                         | Metric Name              | Dimensions              | Statistics | Unit   | Min Periods |
| ---- | ------ | ------ | ---- | ---- | ---- |
| BWRateInFromInside                | Traffic Rate from VPC    | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateInFromOutside               | Traffic Rate from Public Network | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToInside                 | Outbound VPC Traffic Rate | userId,instanceId       | Value      | bps    | 60 s        |
| BWRateOutToOutside                | Outbound Public Network Traffic Rate | userId,instanceId       | Value      | bps    | 60 s        |
| BytesInFromInside                 | Traffic from VPC         | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesInFromOutside                | Traffic from Public Network | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToInside                  | Outbound VPC Traffic     | userId,instanceId       | Value      | bytes  | 60 s        |
| BytesOutToOutside                 | Outbound Public Network Traffic | userId,instanceId       | Value      | bytes  | 60 s        |
| DropTotalBps                      | Total Dropped Bandwidth   | userId,instanceId       | Value      | bit/s  | 60 s        |
| DropTotalPps                      | Total Dropped Rate        | userId,instanceId       | Value      | countS | 60 s        |
| EniBytesDropRx                    | Interface Incoming Dropped Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesDropTx                    | Interface Outgoing Dropped Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesRx                        | Interface Incoming Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniBytesTx                        | Interface Outgoing Traffic | userId,instanceId,eniId | Value      | bytes  | 60 s        |
| EniPacketsDropPortAllocationFail  | Interface Port Allocation Failed Packet Count | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropRx                  | Interface Incoming Dropped Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsDropTx                  | Interface Outgoing Dropped Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsRx                      | Interface Incoming Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniPacketsTx                      | Interface Outgoing Packets | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionActiveConnection        | Interface Concurrent Connections | userId,instanceId,eniId | Value      | count  | 60 s        |
| EniSessionLimitDropConnection     | Interface New Dropped Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewConnection           | Interface New Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| EniSessionNewLimitDropConnection  | Interface Concurrent Dropped Connection Rate | userId,instanceId,eniId | Value      | countS | 60 s        |
| ErrorPortAllocationCount          | Number of Port Allocation Failures in Interval | userId,instanceId       | Value      | count  | 60 s        |
| ErrorPortAllocationRate           | Port Allocation Failure Rate in Interval | userId,instanceId       | Value      | countS | 60 s        |
| InBpsSum                          | Throughput                | userId,instanceId       | Value      | bit/s  | 60 s        |
| PPSRateInFromInside               | Packet Rate from VPC     | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateInFromOutside              | Packet Rate from Public Network | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToInside                | Inbound VPC Packet Rate  | userId,instanceId       | Value      | countS | 60 s        |
| PPSRateOutToOutside               | Inbound Public Network Packet Rate | userId,instanceId       | Value      | countS | 60 s        |
| PacketsInFromInside               | Packet Volume from VPC   | userId,instanceId       | Value      | count  | 60 s        |
| PacketsInFromOutside              | Packet Volume from Public Network | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToInside                | Inbound VPC Packet Volume | userId,instanceId       | Value      | count  | 60 s        |
| PacketsOutToOutside               | Inbound Public Network Packet Volume | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnection           | Concurrent Connections    | userId,instanceId       | Value      | count  | 60 s        |
| SessionActiveConnectionWaterLever | Concurrent Connection Water Level | userId,instanceId       | Value      | %      | 60 s        |
| SessionLimitDropConnection        | Concurrent Dropped Connection Rate | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnection              | New Connection Rate      | userId,instanceId       | Value      | countS | 60 s        |
| SessionNewConnectionWaterLever    | New Connection Water Level | userId,instanceId       | Value      | %      | 60 s        |
| SessionNewLimitDropConnection     | New Dropped Connection Rate | userId,instanceId       | Value      | countS | 60 s        |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed under "Infrastructure - Custom".

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
    "message"     : "{Instance JSON Data}"
  }
}
```