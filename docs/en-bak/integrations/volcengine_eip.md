---
title: 'Volcengine EIP'
tags: 
  - Volcengine
summary: 'Collect EIP metrics data of Volcengine'
__int_icon: 'icon/volcengine_eip'
dashboard:

  - desc: 'Volcengine EIP Built in View'
    path: 'dashboard/en/volcengine_eip'

monitor:
  - desc: 'Volcengine EIP Monitor'
    path: 'monitor/en/volcengine_eip'
---

Collect EIP metrics data of Volcengine

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of EIP cloud resources, we install the corresponding collection script：「Guance Integration（Volcengine EIP Collect）」(ID：`guance_volcengine_eip`)

Click【Install】and enter the corresponding parameters: Volcenine AK, Volcenine account name, Volcenine regions.

Tap 【Deploy startup Script】, The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task. In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric  {#metric}

Configure the Volcengine EIP monitoring metric to collect more metrics through configuration [Volcengine EIP metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_EIP){:target="_blank"}

|`MetricName` |`Subnamespace` | MetricName |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `InTraffic` | `Instance` | Incoming flow rate | Bytes | ResourceID |
| `OutTraffic` | `Instance` | Outbound flow rate | Bytes | ResourceID |
| `InPackets` | `Instance` | Number of incoming data packets | Count | ResourceID |
| `OutPackets` | `Instance` | Number of outbound data packets | Count | ResourceID |
| `InBPS` | `Instance` | Entering direction bandwidth | Bits/Second | ResourceID |
| `OutBPS` | `Instance` | Output bandwidth | Bits/Second | ResourceID |
| `InPacketsRate` | `Instance` | Entering direction packet speed | Packet/Second | ResourceID |
| `OutPacketsRate` | `Instance` | Outbound package speed | Packet/Second | ResourceID |
| `OutPacketsDropRate` | `Instance` | Outbound speed limit and packet loss rate | Packet/Second | ResourceID |
| `OutRatePercentage` | `Instance` | Network outflow bandwidth utilization rate | Percent | ResourceID |
| `InRatePercentage` | `Instance` | Network inflow bandwidth utilization rate | Percent | ResourceID |
| `InPacketsDropRate` | `Instance` | Speed limit and packet loss rate in the incoming direction | Packet/Second | ResourceID |

## Object  {#object}

The collected Volcengine EIP object data structure can see the object data from 「Infrastructure - Resource Catalog」

``` json
  {
    "measurement": "volcengine_eip",
    "tags": {
    "AllocationId"    : "eip-xxxxlsmpds73inqkqifze9",
    "Description"     : "",
    "EipAddress"      : "14.103.xx.xx",
    "RegionId"        : "cn-guangzhou",
    "ProjectName"     : "default",
    "name"            : "5gwfnylsmpds73inqkqixxxxx"
    },
    "fileds": {
      "AllocationTime": "2024-12-08T21:42:17+08:00",
      "Bandwidth"     : 115,
      "ExpiredTime"   : "",
      "ISP"           : "BGP",
      "InstanceId"    : "i-ydkgzgx14wwuxjsfi06q",
      "InstanceType"  : "EcsInstance",
      "IsBlocked"     : false,
      "Status"        : "Attached",
      "Tags"          : "[]"
    }
  }
```
