---
title: '阿里云 Redis 集群版'
summary: '阿里云 Redis 集群版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: '阿里云 Redis 集群版内置视图'
    path: 'dashboard/zh/aliyun_redis_shard/'
monitor:
  - desc: '阿里云 Redis 集群版监控器'
    path: 'monitor/zh/aliyun_redis_shard/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun Redis Shard
<!-- markdownlint-enable -->

Aliyun Redis Shard Indicator display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance (For simplicity's sake,，You can directly grant the global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Aliyun Redis Shard resources,we install the corresponding collection script:「观测云集成（阿里云- Redis采集）」(ID：`guance_aliyun_redis`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Tap【Deploy startup Script】，The system automatically creates Startup script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click【Run】, you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We have collected some configurations by default, see the index column for details

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Alibaba Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       | Metric Name               | Dimensions               | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAdminClients            | Proxy to DB connections           | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingAvgRt                   | Average response time              | userId,instanceId,nodeId | Average,Maximum | us       |
| ShardingBlockedClients          | Number of blocked client connections          | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingConnectionUsage         | Connection usage              | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingCpuUsage                | CPU usage                 | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingHitRate                 | Hit rate                    | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingInstProxyIntranetIn     | Proxy instance inflow bandwidth         | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyIntranetOut    | Proxy instance outbound bandwidth        | userId,instanceId        | Value           | KBytes/s |
| ShardingInstProxyTotalQps       | Proxy instance total number of requests per second     | userId,instanceId        | Value           | Count/s  |
| ShardingInstProxyUsedConnection | Proxy instance used connections     | userId,instanceId        | Value           | Count    |
| ShardingIntranetIn              | Inbound traffic                | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio         | Incoming Bandwidth Utilization            | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingIntranetOut             | Outbound traffic                | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio        | Outgoing bandwidth usage            | userId,instanceId,nodeId | Average,Maximum | %        |
| ShardingKeys                    | Number of keys in the cache           | userId,instanceId,nodeId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory usage | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyAvgRequestSize | Proxy Average per request size | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgResponseSize | ProxyAverage per response size | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyAvgRt | Proxy average delay | userId,instanceId,nodeId | Average,Maximum | us |
| ShardingProxyConnectionUsage | Proxy connection usage | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyCpuUsage | Proxy CPU usage | userId,instanceId,nodeId | Average,Maximum | % |
| ShardingProxyIntranetIn | Proxy inflow rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyIntranetOut | Proxy outflow rate | userId,instanceId,nodeId | Average,Maximum | KBytes/s |
| ShardingProxyMaxRequestSize | Proxy per request max size | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyMaxResponseSize | Proxy per response max size | userId,instanceId,nodeId | Average,Maximum | Byte |
| ShardingProxyTotalQps | Proxy total qps per second | userId,instanceId,nodeId | Average,Maximum | Count/s |
| ShardingProxyUsedConnection | Proxy used connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingSyncDelayTime | Multi-active synchronization delay | userId,instanceId,nodeId | Maximum,Average | seconds |
| ShardingUsedConnection | Used connections | userId,instanceId,nodeId | Average,Maximum | Count |
| ShardingUsedMemory | Memory usage | userId,instanceId,nodeId | Average,Maximum | Bytes |
| ShardingUsedQPS | Average used qps per second | userId,instanceId,nodeId | Average,Maximum | Count |

## Object {#object}

The collected Alibaba Cloud redis  object data structure can see the object data from「基础设施-自定义」

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
    "InstanceName"    : "xxx 系统",
    "InstanceType"    : "Redis",
    "InstanceStatus"  : "Normal"
  },
  "fields": {
    "Capacity"  : "1024",
    "EndTime"   : "2022-12-13T16:00:00Z",
    "CreateTime": "2021-01-11T09:35:51Z",
    "Accounts"  : "[{账号信息 JSON 数据}]",
    "message"   : "{实例 JSON 数据}"
  }
}

```

## Logging {#logging}

### Longquery

#### Prerequisite

> Tip：The code operation of this script depends on the collection of Redis instance objects. If the custom object collection of Redis is not configured, the slow log script cannot collect slow log data

#### Installation script

On the previous basis, you need to install **Redis Script for longquery log **

Click and install the corresponding script package in [Management / Script Market]:「观测云集成（阿里云- Redis 慢查询日志采集）」(ID：`guance_aliyun_redis_slowlog`)

After the data is synchronized normally, you can view the data in the [log] of Guance platform.

An example of reported data is as follows:

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
      "InstanceName"    : "xx3.0-xx 系统",
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
    "message"    : "{实例 JSON 数据}"
  }
}

```

Some parameters are described as follows:

| Field          | Type | Description                 |
| :------------ | :--- | :------------------- |
| `ElapsedTime` | int  | Execution time, in milliseconds |
| `ExecuteTime` | str  | Execution start time         |
| `IPAddress`   | str  | Client ip address     |

> *Notice：The fields in `tags` and `fields` may change with subsequent updates*
>
> Tip：The `fields.message` is JSON serialized string