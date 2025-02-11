---
title: 'Alibaba Cloud EIP'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, rate-limiting packet loss rate, bandwidth utilization, etc.'
__int_icon: 'icon/aliyun_eip'
dashboard:
  - desc: 'Alibaba Cloud EIP Built-in Views'
    path: 'dashboard/en/aliyun_eip/'

monitor:
  - desc: 'Alibaba Cloud EIP Monitor'
    path: 'monitor/en/aliyun_eip/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud EIP
<!-- markdownlint-enable -->

Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, rate-limiting packet loss rate, bandwidth utilization, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of EIP cloud resources, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-EIP Collection)」(ID: `guance_aliyun_eip`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the relevant log collection script. If you need to collect billing data, enable the cloud billing collection script.


We default to collecting some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」whether the corresponding tasks have been configured for automatic triggers, and check the task records and logs for any abnormalities.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric | Description | Statistics | Unit |
| ---- |---- | :---:    | :----: |
|`net_rx_rate`|Network Inbound Bandwidth|Value|bits/s|
|`net_tx_rate`|Network Outbound Bandwidth|Value|bits/s|
|`netrxPkgs_rate`|Inbound Packet Rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`nettxPkgs_rate`|Outbound Packet Rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`net_in.rate_percentage`|Network Inbound Bandwidth Utilization|Average||
|`net_out.rate_percentage`|Network Outbound Bandwidth Utilization|Average||
|`net_rx`|Inbound Traffic|Average,Minimum,Maximum,Sum|bytes|
|`net_tx`|Outbound Traffic|Average,Minimum,Maximum,Sum|bytes|
|`net_rxPkgs`|Inbound Packets Count|Average,Minimum,Maximum,Sum|Count|
|`net_txPkgs`|Outbound Packets Count|Average,Minimum,Maximum,Sum|Count|
|`in_ratelimit_drop_speed`|Inbound Rate-Limiting Packet Drop Rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`out_ratelimit_drop_speed`|Outbound Rate-Limiting Packet Drop Rate|Average,Minimum,Maximum,Sum|Packets/Second|

## Objects {#object}

The collected Alibaba Cloud EIP object data structure can be viewed in 「Infrastructure - Custom」.

```json
{
  "measurement": "aliyun_eip",
  "tags": {
    "name"              : "eip-xxxxx",
    "AllocationId"      : "eip-bp1lfsikwo4roa0mcqg9u",
    "EIPName"           : "",
    "Status"            : "InUse",
    "RegionId"          : "cn-hangzhou",
    "Bandwidth"         : "1",
    "IpAddress"         : "47.96.22.249",
    "InternetChargeType": "PayByTraffic",
    "BusinessStatus"    : "Normal",
    "ChargeType"        : "PostPaid"
  },
  "fields": {
    "AllocationTime": "2022-01-20T03:06:51Z",
    "ExpiredTime"   : "",
    "message"       : "{instance JSON data}"
  }
}
```