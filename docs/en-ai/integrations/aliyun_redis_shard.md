---
title: 'Alibaba Cloud Redis Cluster Edition'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, requests per second, etc.'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: 'Built-in views for Alibaba Cloud Redis Cluster Edition'
    path: 'dashboard/en/aliyun_redis_shard/'
monitor:
  - desc: 'Monitor for Alibaba Cloud Redis Cluster Edition'
    path: 'monitor/en/aliyun_redis_shard/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud Redis Cluster Edition
<!-- markdownlint-enable -->

Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, requests per second, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud Redis Cluster Edition, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud - Redis Collection)」(ID: `guance_aliyun_redis`)

Click 【Install】, then enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding automatic trigger configuration exists for the task and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       | Metric Name               | Dimensions               | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAdminClients            | Proxy-to-DB Connection Count           | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingAvgRt                   | Average Response Time              | userId,instanceId,nodeId | Average,Maximum | us       |
| ShardingBlockedClients          | Blocked Client Connection Count          | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingConnectionUsage         | Connection Usage Rate              | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingCpuUsage                | CPU Usage Rate                 | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingHitRate                 | Hit Rate                    | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingInstProxyIntranetIn     | Proxy Instance Inbound Bandwidth         | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyIntranetOut    | Proxy Instance Outbound Bandwidth        | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyTotalQps       | Proxy Instance Total Requests Per Second     | userId,instanceId        | Value           | Count/s  |
| ShardingInstProxyUsedConnection | Proxy Instance Used Connections       | userId,instanceId        | Value           | Count    |
| ShardingIntranetIn              | Inbound Traffic                | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio         | Inbound Bandwidth Usage Rate            | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingIntranetOut             | Outbound Traffic                | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio        | Outbound Bandwidth Usage Rate            | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingKeys                    | Number of Keys in Cache           | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory Usage Rate | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyAvgRequestSize | Average Request Size per Proxy Request | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgResponseSize | Average Response Size per Proxy Response | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgRt | Average Proxy Latency | userId,instanceId,nodeId | Average,Maximum | us |
| ShardingProxyConnectionUsage | Proxy Connection Usage Rate | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyCpuUsage | Proxy CPU Usage Rate | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyIntranetIn | Proxy Inbound Traffic Rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyIntranetOut | Proxy Outbound Traffic Rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyMaxRequestSize | Maximum Request Size per Proxy Request | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyMaxResponseSize | Maximum Response Size per Proxy Response | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyTotalQps | Proxy Total Requests Per Second | userId,instanceId,nodeId | Average,Maximum | Count/s |
| ShardingProxyUsedConnection | Proxy Used Connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingSyncDelayTime | Multi-Live Sync Delay | userId,instanceId,nodeId | Maximum,Average | seconds |
| ShardingUsedConnection | Used Connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingUsedMemory | Used Memory | userId,instanceId,nodeId | Average,Maximum | Bytes |
| ShardingUsedQPS | Average Requests Per Second | userId,instanceId,nodeId | Average,Maximum | Count |

## Objects {#object}

The object data structure of collected Alibaba Cloud Redis objects can be viewed in 「Infrastructure - Custom」.

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
    "Accounts"  : "[{Account Information JSON Data}]",
    "message"   : "{Instance JSON Data}"
  }
}

```

## Logs {#logging}

### Slow Queries

#### Prerequisites

> Note: This script's code depends on the Redis instance object collection. If the custom object collection for Redis is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for **Redis Slow Query Log Collection**.

In 「Management / Script Market」, click and install the corresponding script package: 「Guance Integration (Alibaba Cloud - Redis Slow Query Log Collection)」(ID: `guance_aliyun_redis_slowlog`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Sample reported data:

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
    "message"    : "{Instance JSON Data}"
  }
}

```

Parameter descriptions:

| Field          | Type | Description                 |
| :------------ | :--- | :-------------------------- |
| `ElapsedTime` | int  | Execution duration, in milliseconds |
| `ExecuteTime` | str  | Execution start time         |
| `IPAddress`   | str  | Client IP address            |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string