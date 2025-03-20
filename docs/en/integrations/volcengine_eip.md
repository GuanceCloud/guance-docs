---
title: 'Volcengine EIP'
tags: 
  - Volcengine
summary: 'Collect Volcengine EIP Metrics data'
__int_icon: 'icon/volcengine_eip'
dashboard:

  - desc: 'Volcengine EIP built-in views'
    path: 'dashboard/en/volcengine_eip'

monitor:
  - desc: 'Volcengine EIP monitors'
    path: 'monitor/en/volcengine_eip'
---

Collect Volcengine EIP Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Volcengine AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize EIP cloud resource monitoring data, we install the corresponding collection script: 「Guance Integration (Volcengine-EIP Collection)」(ID: `guance_volcengine_eip`)

After clicking 【Install】, enter the corresponding parameters: Volcengine AK, Volcengine account name, Regions.

Click 【Deploy and Start Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」check if there is asset information.
3. On the Guance platform, in 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Volcengine EIP monitoring metrics, more metrics can be collected through configuration [Volcengine EIP Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_EIP){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `InTraffic` | `Instance` | Inbound Traffic | Bytes | ResourceID |
| `OutTraffic` | `Instance` | Outbound Traffic | Bytes | ResourceID |
| `InPackets` | `Instance` | Inbound Packets Count | Count | ResourceID |
| `OutPackets` | `Instance` | Outbound Packets Count | Count | ResourceID |
| `InBPS` | `Instance` | Inbound Bandwidth | Bits/Second | ResourceID |
| `OutBPS` | `Instance` | Outbound Bandwidth | Bits/Second | ResourceID |
| `InPacketsRate` | `Instance` | Inbound Packet Rate | Packet/Second | ResourceID |
| `OutPacketsRate` | `Instance` | Outbound Packet Rate | Packet/Second | ResourceID |
| `OutPacketsDropRate` | `Instance` | Outbound Throttling Packet Drop Rate | Packet/Second | ResourceID |
| `OutRatePercentage` | `Instance` | Network Outbound Bandwidth Utilization | Percent | ResourceID |
| `InRatePercentage` | `Instance` | Network Inbound Bandwidth Utilization | Percent | ResourceID |
| `InPacketsDropRate` | `Instance` | Inbound Throttling Packet Drop Rate | Packet/Second | ResourceID |

## Objects {#object}

The collected Volcengine EIP object data structure can be viewed from 「Infrastructure - Resource Catalog」

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