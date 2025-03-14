---
title: 'Alibaba Cloud Redis Standard Edition'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, and accesses per second.'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: 'Alibaba Cloud Redis Standard Edition built-in view'
    path: 'dashboard/en/aliyun_redis/'
monitor:
  - desc: 'Alibaba Cloud Redis Monitor'
    path: 'monitor/en/aliyun_redis_standard/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud Redis Standard Edition
<!-- markdownlint-enable -->

Alibaba Cloud Redis Standard Edition Metrics display, including CPU usage, memory usage, disk read/write, network traffic, and accesses per second.


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for Alibaba Cloud Redis Standard Edition, we install the corresponding collection script: "Guance Integration (Alibaba Cloud - Redis Collection)" (ID: `guance_aliyun_redis`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」whether the corresponding task has an automatic trigger configuration. You can also check the task records and logs to ensure there are no anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name               | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| StandardAvgRt            | Average Response Time     | userId,instanceId | Average,Maximum | us       |
| StandardBlockedClients   | Blocked Client Connections| userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage  | Connection Usage          | userId,instanceId | Average,Maximum | %        |
| StandardCpuUsage         | CPU Usage                 | userId,instanceId | Average,Maximum | %        |
| StandardHitRate          | Hit Rate                  | userId,instanceId | Average,Maximum | %        |
| StandardIntranetIn       | Inbound Traffic           | userId,instanceId | Average,Maximum | KBytes/s |
| StandardIntranetInRatio  | Inbound Bandwidth Usage   | userId,instanceId | Average,Maximum | %        |
| StandardIntranetOut      | Outbound Traffic          | userId,instanceId | Average,Maximum | KBytes/s |
| StandardIntranetOutRatio | Outbound Bandwidth Usage  | userId,instanceId | Average,Maximum | %        |
| StandardKeys             | Number of Keys in Cache   | userId,instanceId | Average,Maximum | Count    |
| StandardMemoryUsage      | Memory Usage              | userId,instanceId | Average,Maximum | %        |
| StandardSyncDelayTime    | Multi-active Sync Delay   | userId,instanceId | Average,Maximum | seconds  |
| StandardUsedConnection   | Used Connections          | userId,instanceId | Average,Maximum | Count    |
| StandardUsedMemory       | Memory Usage Amount       | userId,instanceId | Average,Maximum | Bytes    |
| StandardUsedQPS          | Average Queries Per Second| userId,instanceId | Average,Maximum | Count    |

## Objects {#object}

The object data structure of the collected Alibaba Cloud Redis objects can be viewed in 「Infrastructure - Custom」

```json
{
  "measurement": "aliyun_redis",
  "tags": {
    "name"            : "r-bp12xxxxxxx",
    "InstanceId"      : "r-bp12vxxxxxxxxx",
    "RegionId"        : "cn-hangzhou",
    "ZoneId"          : "cn-hangzhou-h",
    "InstanceClass"   : "redis.master.small.default",
    "EngineVersion"   : "5.0",
    "ChargeType"      : "PrePaid",
    "ConnectionDomain": "r-bp12vxxxxxxx.redis.rds.aliyuncs.com",
    "NetworkType"     : "VPC",
    "PrivateIp"       : "xxxxxx",
    "Port"            : "6379",
    "InstanceName"    : "xxx System",
    "InstanceType"    : "Redis",
    "InstanceStatus"  : "Normal"
  },
  "fields": {
    "Capacity"  : "1024",
    "EndTime"   : "2022-12-13T16:00:00Z",
    "CreateTime": "2021-01-11T09:35:51Z",
    "Accounts"  : "[{Account JSON data}]",
    "message"   : "{Instance JSON data}"
  }
}

```

## Logging {#logging}

### Slow Queries

#### Prerequisites

> Note: The code execution of this script depends on the collection of Redis instance objects. If custom object collection for Redis is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for **Redis Slow Query Log Collection**.

In 「Manage / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - Redis Slow Query Log Collection)」(ID: `guance_aliyun_redis_slowlog`)

After data synchronization is normal, you can view the data in the 「Logs」section of Guance.

Sample data reported is as follows:

```json
{
  "measurement": "aliyun_redis_slowlog",
  "tags": {
      "name"            : "r-bp1c4xxxxxxxofy2vm",
      "Account"         : "(null)",
      "IPAddress"       : "172.xx.x.201",
      "AccountName"     : "(null)",
      "DBName"          : "3",
      "NodeId"          : "(null)",
      "ChargeType"      : "PrePaid",
      "ConnectionDomain": "r-bpxxxxxxxxxxy2vm.redis.rds.aliyuncs.com",
      "EngineVersion"   : "4.0",
      "InstanceClass"   : "redis.master.small.default",
      "InstanceId"      : "r-bpxxxxxxxxxxxxxxx2vm",
      "InstanceName"    : "xx3.0-xx System",
      "NetworkType"     : "VPC",
      "Port"            : "6379",
      "PrivateIp"       : "172.xxx.xx.200",
      "RegionId"        : "cn-hangzhou",
      "ZoneId"          : "cn-hangzhou-h"
  },
  "fields": {
    "Command"    : "latency:eventloop",
    "ElapsedTime": 192000,
    "ExecuteTime": "2022-07-26T03:18:36Z",
    "message"    : "{Instance JSON data}"
  }
}

```

Parameter descriptions are as follows:

| Field          | Type | Description                    |
| :------------ | :--- | :----------------------------- |
| `ElapsedTime` | int  | Execution duration, in milliseconds |
| `ExecuteTime` | str  | Start time of execution         |
| `IPAddress`   | str  | Client IP address              |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string
