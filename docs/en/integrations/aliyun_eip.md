---
title: 'Alibaba Cloud EIP'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, speed-limited packet drop rate, bandwidth utilization, etc.'
__int_icon: 'icon/aliyun_eip'
dashboard:
  - desc: 'Alibaba Cloud EIP Built-in Views'
    path: 'dashboard/en/aliyun_eip/'

monitor:
  - desc: 'Alibaba Cloud EIP Monitors'
    path: 'monitor/en/aliyun_eip/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud EIP
<!-- markdownlint-enable -->

Alibaba Cloud EIP Metrics Display, including network bandwidth, network packets, speed-limited packet drop rate, bandwidth utilization, etc.

## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> Integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize the monitoring data of EIP cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-EIP Collection)" (ID: `guance_aliyun_eip`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you need to enable the corresponding log collection script. If you want to collect the billing, you need to enable the cloud billing collection script.


We default to collecting some configurations, details are listed under the metrics section.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitor, the default metric sets are as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric | Description | Statistics | Unit |
| ---- |---- | :---:    | :----: |
|`net_rx_rate`|Network inbound bandwidth|Value|bits/s|
|`net_tx_rate`|Network outbound bandwidth|Value|bits/s|
|`netrxPkgs_rate`|Inbound packet rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`nettxPkgs_rate`|Outbound packet rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`net_in.rate_percentage`|Network inbound bandwidth utilization|Average||
|`net_out.rate_percentage`|Network outbound bandwidth utilization|Average||
|`net_rx`|Inbound traffic|Average,Minimum,Maximum,Sum|bytes|
|`net_tx`|Outbound traffic|Average,Minimum,Maximum,Sum|bytes|
|`net_rxPkgs`|Inbound packet count|Average,Minimum,Maximum,Sum|Count|
|`net_txPkgs`|Outbound packet count|Average,Minimum,Maximum,Sum|Count|
|`in_ratelimit_drop_speed`|Inbound speed-limited packet drop rate|Average,Minimum,Maximum,Sum|Packets/Second|
|`out_ratelimit_drop_speed`|Outbound speed-limited packet drop rate|Average,Minimum,Maximum,Sum|Packets/Second|

## Objects {#object}

The collected Alibaba Cloud EIP object data structure can be viewed under 「Infrastructure - Custom」

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
    "message"       : "{JSON instance data}"
  }
}

```