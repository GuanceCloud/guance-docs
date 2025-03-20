---
title: 'Alibaba Cloud Redis Cluster Edition'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud Redis Cluster Edition Metrics Display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc.'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: 'Alibaba Cloud Redis Cluster Edition Built-in Views'
    path: 'dashboard/en/aliyun_redis_shard/'
monitor:
  - desc: 'Alibaba Cloud Redis Cluster Edition Monitor'
    path: 'monitor/en/aliyun_redis_shard/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud Redis Cluster Edition
<!-- markdownlint-enable -->

Alibaba Cloud Redis Cluster Edition Metrics Display, including CPU usage, memory usage, disk read/write, network traffic, access per second, etc.


## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> Integration - Expansion - Managed Func: All prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for Alibaba Cloud Redis Cluster Edition, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - Redis Collection)" (ID: `guance_aliyun_redis`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in the "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       | Metric Name               | Dimensions               | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAdminClients            | Proxy to DB connection count           | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingAvgRt                   | Average response time              | userId,instanceId,nodeId | Average,Maximum | us       |
| ShardingBlockedClients          | Blocked client connection count          | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingConnectionUsage         | Connection usage              | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingCpuUsage                | CPU usage                 | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingHitRate                 | Hit rate                    | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingInstProxyIntranetIn     | Proxy instance inbound bandwidth         | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyIntranetOut    | Proxy instance outbound bandwidth         | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyTotalQps       | Proxy instance total requests per second     | userId,instanceId        | Value           | Count/s  |
| ShardingInstProxyUsedConnection | Proxy instance used connections       | userId,instanceId        | Value           | Count    |
| ShardingIntranetIn              | Inbound traffic                | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio         | Inbound bandwidth usage            | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingIntranetOut             | Outbound traffic                | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio        | Outbound bandwidth usage            | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingKeys                    | Cache Key count           | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory usage | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyAvgRequestSize | Proxy average request size per request | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgResponseSize | Proxy average response size per request | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgRt | Proxy average latency | userId,instanceId,nodeId | Average,Maximum | us |
| ShardingProxyConnectionUsage | Proxy connection usage | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyCpuUsage | Proxy CPU usage | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyIntranetIn | Proxy inbound traffic rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyIntranetOut | Proxy outbound traffic rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyMaxRequestSize | Proxy maximum request size per request | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyMaxResponseSize | Proxy maximum response size per request | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyTotalQps | Proxy total requests per second | userId,instanceId,nodeId | Average,Maximum | Count/s |
| ShardingProxyUsedConnection | Proxy used connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingSyncDelayTime | Multi-active synchronization delay | userId,instanceId,nodeId | Maximum,Average | seconds |
| ShardingUsedConnection | Used connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingUsedMemory | Memory usage | userId,instanceId,nodeId | Average,Maximum | Bytes |
| ShardingUsedQPS | Average queries per second | userId,instanceId,nodeId | Average,Maximum | Count |

## Objects {#object}

The object data structure of collected Alibaba Cloud redis, which can be seen in "Infrastructure - Custom"

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

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script corresponding to **Redis Slow Query Log Collection**

In the "Manage / Script Market", click and install the corresponding script package: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - Redis Slow Query Log Collection)" (ID: `guance_aliyun_redis_slowlog`)

After the data is synchronized normally, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

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

Explanation of some parameters:

| Field          | Type | Description                 |
| :------------ | :--- | :------------------------- |
| `ElapsedTime` | int  | Execution duration, unit in milliseconds |
| `ExecuteTime` | str  | Start execution time       |
| `IPAddress`   | str  | Client's IP address       |

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string
```