---
title: 'Volc Engine EIP'
tags: 
  - Volc Engine
summary: 'Collect Volc Engine EIP metrics data'
__int_icon: 'icon/volcengine_eip'
dashboard:

  - desc: 'Volc Engine EIP built-in view'
    path: 'dashboard/en/volcengine_eip'

monitor:
  - desc: 'Volc Engine EIP monitor'
    path: 'monitor/en/volcengine_eip'
---

Collect Volc Engine EIP metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Volc Engine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of EIP cloud resources, we install the corresponding collection script: "Guance Integration (Volc Engine-EIP Collection)" (ID: `guance_volcengine_eip`)

After clicking 【Install】, enter the corresponding parameters: Volc Engine AK, Volc Engine account name, regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」check if asset information exists.
3. On the Guance platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}

Configure Volc Engine EIP monitoring metrics. You can collect more metrics by configuring them. [Volc Engine EIP Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_EIP){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `InTraffic` | `Instance` | Incoming Traffic | Bytes | ResourceID |
| `OutTraffic` | `Instance` | Outgoing Traffic | Bytes | ResourceID |
| `InPackets` | `Instance` | Incoming Packets | Count | ResourceID |
| `OutPackets` | `Instance` | Outgoing Packets | Count | ResourceID |
| `InBPS` | `Instance` | Incoming Bandwidth | Bits/Second | ResourceID |
| `OutBPS` | `Instance` | Outgoing Bandwidth | Bits/Second | ResourceID |
| `InPacketsRate` | `Instance` | Incoming Packet Rate | Packet/Second | ResourceID |
| `OutPacketsRate` | `Instance` | Outgoing Packet Rate | Packet/Second | ResourceID |
| `OutPacketsDropRate` | `Instance` | Outgoing Dropped Packet Rate | Packet/Second | ResourceID |
| `OutRatePercentage` | `Instance` | Network Outbound Bandwidth Utilization | Percent | ResourceID |
| `InRatePercentage` | `Instance` | Network Inbound Bandwidth Utilization | Percent | ResourceID |
| `InPacketsDropRate` | `Instance` | Incoming Dropped Packet Rate | Packet/Second | ResourceID |

## Objects {#object}

The collected Volc Engine EIP object data structure can be viewed in 「Infrastructure - Resource Catalog」

``` json
  {
    "measurement": "volcengine_eip",
    "tags": {
    "AllocationId"    : "eip-xxxxlsmpds73inqkqifze9",
    "Description"     : "",
    "EipAddress"      : "14.103.xx.xx",
    "RegionId"        : "cn-guangzhou",
    "ProjectName"     : "default",
    "name"            : "url-5gwfnylsmpds73inqkxxxx"
    },
    "fileds": {
      "AllocationTime": "2024-12-08T21:42:17+08:00",
      "Bandwidth"     : 115,
      "ExpiredTime"   : "",
      "ISP"           : "BGP"
      "InstanceId"    : "i-ydkgzgx14wwuxjsfi06q",
      "InstanceType"  : "EcsInstance",
      "IsBlocked"     : false,
      "Status"        : "Attached",
      "Tags"          : "[]"
    }
  }
```
