---
title: 'Alibaba Cloud Redis Cluster Edition'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, and requests per second.'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: 'Built-in views for Alibaba Cloud Redis Cluster Edition'
    path: 'dashboard/en/aliyun_redis_shard/'
monitor:
  - desc: 'Monitors for Alibaba Cloud Redis Cluster Edition'
    path: 'monitor/en/aliyun_redis_shard/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud Redis Cluster Edition
<!-- markdownlint-enable -->

Display of Alibaba Cloud Redis Cluster Edition metrics, including CPU usage, memory usage, disk read/write, network traffic, and requests per second.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud Redis Cluster Edition, install the corresponding collection script: 「Guance Integration (Alibaba Cloud - Redis Collection)」(ID: `guance_aliyun_redis`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

We collect some default configurations; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       | Metric Name               | Dimensions               | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAdminClients            | Number of Proxy-to-DB connections | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingAvgRt                   | Average Response Time      | userId,instanceId,nodeId | Average,Maximum | us       |
| ShardingBlockedClients          | Number of Blocked Client Connections | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingConnectionUsage         | Connection Usage Rate      | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingCpuUsage                | CPU Usage Rate             | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingHitRate                 | Hit Rate                   | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingInstProxyIntranetIn     | Proxy Instance Inbound Bandwidth | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyIntranetOut    | Proxy Instance Outbound Bandwidth | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyTotalQps       | Total QPS of Proxy Instance | userId,instanceId        | Value           | Count/s  |
| ShardingInstProxyUsedConnection | Used Connections of Proxy Instance | userId,instanceId        | Value           | Count    |
| ShardingIntranetIn              | Inbound Traffic            | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio         | Inbound Bandwidth Usage Rate | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingIntranetOut             | Outbound Traffic           | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio        | Outbound Bandwidth Usage Rate | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingKeys                    | Number of Keys in Cache    | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory Usage Rate | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyAvgRequestSize | Average Request Size of Proxy | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgResponseSize | Average Response Size of Proxy | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgRt | Average Latency of Proxy | userId,instanceId,nodeId | Average,Maximum | us |
| ShardingProxyConnectionUsage | Proxy Connection Usage Rate | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyCpuUsage | Proxy CPU Usage Rate | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyIntranetIn | Proxy Inbound Traffic Rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyIntranetOut | Proxy Outbound Traffic Rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyMaxRequestSize | Maximum Request Size of Proxy | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyMaxResponseSize | Maximum Response Size of Proxy | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyTotalQps | Total QPS of Proxy | userId,instanceId,nodeId | Average,Maximum | Count/s |
| ShardingProxyUsedConnection | Used Connections of Proxy | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingSyncDelayTime | Multi-active Sync Delay | userId,instanceId,nodeId | Maximum,Average | seconds |
| ShardingUsedConnection | Used Connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingUsedMemory | Memory Usage | userId,instanceId,nodeId | Average,Maximum | Bytes |
| ShardingUsedQPS | Average Requests Per Second | userId,instanceId,nodeId | Average,Maximum | Count |

## Objects {#object}

The object data structure of Alibaba Cloud Redis collected can be viewed in 「Infrastructure - Custom」

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
    "Accounts"  : "[{Account JSON Data}]",
    "message"   : "{Instance JSON Data}"
  }
}

```

## Logs {#logging}

### Slow Queries

#### Prerequisites

> Note: The code execution of this script depends on the Redis instance object collection. If Redis custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Installation Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for **Redis Slow Query Log Collection**

In 「Manage / Script Market」, click and install the corresponding script package: 「Guance Integration (Alibaba Cloud - Redis Slow Query Log Collection)」(ID: `guance_aliyun_redis_slowlog`)

After data synchronization is normal, you can view the data in the 「Logs」section of Guance.

Example of reported data:

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

Parameter descriptions are as follows:

| Field          | Type | Description                 |
| :------------ | :--- | :------------------- |
| `ElapsedTime` | int  | Execution duration, unit is milliseconds |
| `ExecuteTime` | str  | Execution start time         |
| `IPAddress`   | str  | Client IP address     |

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string.