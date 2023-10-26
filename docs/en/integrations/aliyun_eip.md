---
title: 'Aliyun EIP'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aliyun_eip'
dashboard:
  - desc: 'Aliyun EIP Monitoring View'
    path: 'dashboard/zh/aliyun_eip/'

monitor:
  - desc: 'Aliyun EIP Monitor'
    path: 'monitor/zh/aliyun_eip/'
---


<!-- markdownlint-disable MD025 -->
# Aliyun  EIP
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of EIP cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -EIPCollect）」(ID：`guance_aliyun_eip`)

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

Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Alibaba Cloud Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_vpc_eip/eip){:target="_blank"}


| Metric | Description | Statistics | Unit |
| ---- |---- | :---:    | :----: |
|`net_rx_rate`|net_rx.rate|Value|bits/s|
|`net_tx_rate`|net_tx.rate|Value|bits/s|
|`netrxPkgs_rate`|**net_rxPkgs.rate**|Average,Minimum,Maximum,Sum|Packets/Second|
|`nettxPkgs_rate`|**net_txPkgs.rate**|Average,Minimum,Maximum,Sum|Packets/Second|
|`net_in.rate_percentage`|InternetInRatePercentage|Average||
|`net_out.rate_percentage`|InternetOutRatePercentage|Average||
|`net_rx`|net.rx|Average,Minimum,Maximum,Sum|bytes|
|`net_tx`|net.tx|Average,Minimum,Maximum,Sum|bytes|
|`net_rxPkgs`|**net.rxPkgs**|Average,Minimum,Maximum,Sum|Count|
|`net_txPkgs`|**net.txPkgs**|Average,Minimum,Maximum,Sum|Count|
|`in_ratelimit_drop_speed`|In **Ratelimit** Drop Speed|Average,Minimum,Maximum,Sum|Packets/Second|
|`out_ratelimit_drop_speed`|Out **Ratelimit** Drop Speed|Average,Minimum,Maximum,Sum|Packets/Second|

## Object {#object}

The collected Alibaba Cloud EIP object data structure can see the object data from 「Infrastructure-Custom」

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
