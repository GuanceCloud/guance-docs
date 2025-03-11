---
title: 'Aliyun Redis Standard'
tags: 
  - Alibaba Cloud
summary: 'Aliyun Redis Standard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc.'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: 'Aliyun Redis Standard Built-in Dashboard'
    path: 'dashboard/zh/aliyun_redis/'
monitor:
  - desc: 'Aliyun Redis Standard Monitor'
    path: 'monitor/zh/aliyun_redis_standard/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun Redis Standard
<!-- markdownlint-enable -->

Aliyun Redis Standard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance (For simplicity's sake,，You can directly grant the global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Aliyun Redis Standard resources,we install the corresponding collection script:「Guance Integration（Aliyun - RedisCollect）」(ID：`guance_aliyun_redis`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Tap "Deploy startup Script"，The system automatically creates Startup script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click "Run", you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We have collected some configurations by default, see the index column for details

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| StandardAvgRt            | Average response time     | userId,instanceId | Average,Maximum | us       |
| StandardBlockedClients   | Number of blocked client connections | userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage  | Connection usage     | userId,instanceId | Average,Maximum | %        |
| StandardCpuUsage         | Cpu usage        | userId,instanceId | Average,Maximum | %        |
| StandardHitRate          | Hit rate           | userId,instanceId | Average,Maximum | %        |
| StandardIntranetIn       | Inbound traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| StandardIntranetInRatio  | Incoming bandwidth utilization   | userId,instanceId | Average,Maximum | %        |
| StandardIntranetOut      | Outbound traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| StandardIntranetOutRatio | Outgoing bandwidth usage   | userId,instanceId | Average,Maximum | %        |
| StandardKeys             | Number of keys in the cache  | userId,instanceId | Average,Maximum | Count    |
| StandardMemoryUsage      | Memory usage       | userId,instanceId | Average,Maximum | %        |
| StandardSyncDelayTime    | Multi-active synchronization delay     | userId,instanceId | Average,Maximum | seconds  |
| StandardUsedConnection   | Used connections       | userId,instanceId | Average,Maximum | Count    |
| StandardUsedMemory       | Used memory       | userId,instanceId | Average,Maximum | Bytes    |
| StandardUsedQPS          | Average Used QPS | userId,instanceId | Average,Maximum | Count    |

## Object {#object}

The collected Aliyun redis  object data structure can see the object data from「Infrastructure-Custom」

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

### **Longquery**

#### Prerequisite

> Tip：The code operation of this script depends on the collection of Redis instance objects. If the custom object collection of Redis is not configured, the slow log script cannot collect slow log data

<!-- markdownlint-disable MD024 -->
#### Installation script
<!-- markdownlint-enable -->

On the previous basis, you need to install **Redis Script for longquery log**

Click and install the corresponding script package in [Management / Script Market]:「Guance Integration（Aliyun - Redis Slow Query Log Collect）」(ID：`guance_aliyun_redis_slowlog`)

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

Some parameters are described as follows:

| Field          | Type | Description                 |
| :------------ | :--- | :------------------- |
| `ElapsedTime` | int  | Execution time, in milliseconds |
| `ExecuteTime` | str  | Execution start time         |
| `IPAddress`   | str  | Client ip address     |

> *Notice：The fields in `tags` and `fields` may change with subsequent updates*
>
> Tip：The `fields.message` is JSON serialized string
