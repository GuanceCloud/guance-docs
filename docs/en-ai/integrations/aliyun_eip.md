---
title: 'Alibaba Cloud EIP'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud EIP metrics, including network bandwidth, network packets, rate-limited packet loss rate, bandwidth utilization, etc.'
__int_icon: 'icon/aliyun_eip'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud EIP'
    path: 'dashboard/en/aliyun_eip/'

monitor:
  - desc: 'Alibaba Cloud EIP monitor'
    path: 'monitor/en/aliyun_eip/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud EIP
<!-- markdownlint-enable -->

Display of Alibaba Cloud EIP metrics, including network bandwidth, network packets, rate-limited packet loss rate, bandwidth utilization, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`).

To synchronize the monitoring data of EIP cloud resources, install the corresponding collection script: 「Guance Integration (Alibaba Cloud-EIP Collection)」(ID: `guance_aliyun_eip`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the relevant log collection script. If you need to collect billing data, enable the cloud billing collection script.

We have collected some configurations by default; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the task records and logs to ensure there are no abnormalities.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric | Description | Statistics | Unit |
| ---- |---- | :---:    | :----: |
|`net_rx_rate`|Inbound network bandwidth|Value|bits/s|
|`net_tx_rate`|Outbound network bandwidth|Value|bits/s|
|`netrxPkgs_rate`|Inbound packet rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`nettxPkgs_rate`|Outbound packet rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`net_in.rate_percentage`|Inbound network bandwidth utilization|Average||
|`net_out.rate_percentage`|Outbound network bandwidth utilization|Average||
|`net_rx`|Inbound traffic|Average,Minimum,Maximum,Sum|bytes|
|`net_tx`|Outbound traffic|Average,Minimum,Maximum,Sum|bytes|
|`net_rxPkgs`|Inbound packet count|Average,Minimum,Maximum,Sum|Count|
|`net_txPkgs`|Outbound packet count|Average,Minimum,Maximum,Sum|Count|
|`in_ratelimit_drop_speed`|Inbound rate-limited packet drop rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`out_ratelimit_drop_speed`|Outbound rate-limited packet drop rate|Average,Minimum,Maximum,Sum|Packets/Second|

## Objects {#object}

The structure of the collected Alibaba Cloud EIP object data can be viewed in 「Infrastructure - Custom」

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
    "message"       : "{Instance JSON data}"
  }
}
```