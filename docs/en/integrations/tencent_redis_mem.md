---
title: 'Tencent Cloud Redis'
tags: 
  - Tencent Cloud
summary: 'Tencent Cloud Redis Metrics Display, including connections, requests, latency, slow queries, etc.'
__int_icon: 'icon/tencent_redis_mem'
dashboard:

  - desc: 'Tencent Cloud Redis Built-in Views'
    path: 'dashboard/en/tencent_redis_mem'

monitor:
  - desc: 'Tencent Cloud Redis Monitor'
    path: 'monitor/en/tencent_redis_mem'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Redis
<!-- markdownlint-enable -->


Tencent Cloud Redis Metrics Display, including connections, requests, latency, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Expansion - Managed Func: All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data for Tencent Cloud - Redis, we install the corresponding collection script: "Guance Integration (Tencent Cloud - Redis Collection)" (ID: `guance_tencentcloud_redis`)

After clicking 【Install】, input the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default collect some configurations, for more details see the metrics section [Customize cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-redis/){:target="_blank"}



### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Redis, the default metric sets are as follows. More metrics can be collected through configuration [Tencent Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Redis Instance Monitoring

| Metric English Name | Metric Chinese Name | Metric Description                                                                                   | Unit | Dimension       | Statistical Granularity                         |
| -------------------- | ------------------- | -------------------------------------------------------------------------------------------------- | ---- | --------------- | --------------------------------------------- |
| `CpuUtil`            | CPU Utilization     | Average CPU utilization                                                                            | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CpuMaxUtil`         | Maximum Node CPU   | Maximum CPU usage of nodes (shards or replicas) within the instance                                  | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `MemUsed`            | Memory Usage       | Actual memory capacity used, including data and cache parts                                         | MB   | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `MemUtil`            | Memory Utilization | Ratio of actual memory used to total requested memory                                              | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `MemMaxUtil`         | Maximum Node Mem   | Maximum memory usage of nodes (shards or replicas) within the instance                               | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `Keys`               | Total Keys         | Total number of keys stored in the instance (first-level keys)                                      | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `Expired`            | Expired Keys       | Number of keys evicted within the time window, corresponding to expired_keys from the info command output | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `Evicted`            | Evicted Keys       | Number of keys evicted within the time window, corresponding to evicted_keys from the info command output | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `Connections`        | Connection Count   | Number of TCP connections connected to the instance                                                  | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `ConnectionsUtil`    | Connection Utilization | Ratio of actual TCP connections to maximum connections                                             | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `InFlow`             | Incoming Flow      | Internal network incoming flow                                                                     | Mb/s | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `InBandwidthUtil`    | Incoming Flow Utilization | Ratio of actual internal network incoming flow to maximum flow                                     | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `InFlowLimit`        | Incoming Flow Limit Trigger | Number of times the incoming flow triggers rate limiting                                           | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `OutFlow`            | Outgoing Flow     | Internal network outgoing flow                                                                     | Mb/s | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `OutBandwidthUtil`   | Outgoing Flow Utilization | Ratio of actual internal network outgoing flow to maximum flow                                     | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `OutFlowLimit`       | Outgoing Flow Limit Trigger | Number of times the outgoing flow triggers rate limiting                                           | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `LatencyAvg`         | Average Execution Latency | Average execution latency from Proxy to Redis Server                                               | ms   | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `LatencyMax`         | Maximum Execution Latency | Maximum execution latency from Proxy to Redis Server                                               | ms   | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `LatencyRead`        | Average Read Latency      | Average execution latency of read commands from Proxy to Redis Server                              | ms   | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `LatencyWrite`       | Average Write Latency     | Average execution latency of write commands from Proxy to Redis Server                             | ms   | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `LatencyOther`       | Average Other Commands Latency | Average execution latency of commands other than read/write from Proxy to Redis Server          | ms   | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `Commands`           | Total Requests     | QPS, number of command executions                                                                  | Times/second | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdRead`            | Read Requests      | Number of read command executions per second                                                       | Times/second | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdWrite`           | Write Requests     | Number of write command executions per second                                                      | Times/second | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdOther`           | Other Requests     | Number of command executions other than read/write per second                                     | Times/second | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdBigValue`        | Big Value Requests | Number of command executions exceeding 32KB per second                                             | Times/second | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdKeyCount`        | Key Request Count  | Number of keys accessed by the command                                                            | Keys/second  | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdMget`            | **Mget** Request Count | Number of **Mget** command executions                                                             | Keys/second  | `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdSlow`            | Slow Queries      | Number of commands executed with latency greater than slowlog - log - slower - than configuration | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdHits`            | Read Hits         | Number of existing keys for read requests, corresponding to keyspace_hits from info command output | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdMiss`            | Read Misses       | Number of non-existing keys for read requests, corresponding to keyspace_misses from info command output | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdErr`             | Execution Errors   | Number of command execution errors, such as non-existent commands, parameter errors, etc.          | Count| `instanceid`    | 5s、60s、300s、3600s、86400s                |
| `CmdHitsRatio`       | Read Hit Rate     | Hits / (Hits + Miss), this metric reflects Cache Miss situation                                    | %    | `instanceid`    | 5s、60s、300s、3600s、86400s                |


### Overview of Parameters Corresponding to Each Dimension

| Parameter Name                         | Dimension Name     | Dimension Explanation               | Format                                                         |
| -------------------------------------- | ------------------ | ---------------------------------- | -------------------------------------------------------------- |
| `Instances.N.Dimensions.0.Name`        | `instanceid`       | Instance ID dimension name          | Input String type dimension name: **instanceid**                |
| `Instances.N.Dimensions.0.Value`       | `instanceid`       | Specific instance ID                | Input specific Redis instance ID, e.g., `tdsql-123456`, or instance serial number, e.g., `crs-ifmymj41`. You can query via [Query Redis Instance List Interface](https://cloud.tencent.com/document/api/239/20018){:target="_blank"} |
| `Instances.N.Dimensions.1.Name`        | `rnodeid`          | Redis node ID dimension name        | Input String type dimension name: **rnodeid**                   |
| `Instances.N.Dimensions.1.Value`       | `rnodeid`          | Specific Redis node ID              | Input specific Redis node ID, obtainable via [Query Instance Node Information](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} interface |
| `Instances.N.Dimensions.1.Name`        | `pnodeid`          | Proxy node ID dimension name        | Input String type dimension name: **pnodeid**                   |
| `Instances.N.Dimensions.1.Value`       | `pnodeid`          | Specific proxy node ID              | Input specific proxy node ID, obtainable via [Query Instance Node Information](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} interface |
| `Instances.N.Dimensions.1.Name`        | `command`          | Command word dimension name         | Input String type dimension name: **command**                   |
| `Instances.N.Dimensions.1.Value`       | `command`          | Specific command word               | Input specific command word, e.g., ping, get, etc.              |

### Input Parameter Explanation

**To query Redis instance monitoring data, input parameters are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID`

**To query Proxy node monitoring data, input parameters are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=pnodeid &Instances.N.Dimensions.1.Value=Proxy node ID`

**To query Redis node monitoring data, input parameters are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=rnodeid &Instances.N.Dimensions.1.Value=Redis node ID`

**To query Redis latency metrics (command dimension) monitoring data, input parameters are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=command &Instances.N.Dimensions.1.Value=Specific command word`

## Object {#object}
The structure of collected Tencent Cloud Redis object data can be viewed in "Infrastructure - Custom"

```json
{
  "measurement": "tencentcloud_redis",
  "tags": {
    "name"        : "crs-xxxx",
    "BillingMode" : "0",
    "Engine"      : "Redis",
    "InstanceId"  : "crs-xxxx",
    "InstanceName": "solution",
    "Port"        : "6379",
    "ProductType" : "standalone",
    "ProjectId"   : "0",
    "RegionId"    : "ap-shanghai",
    "Status"      : "2",
    "Type"        : "6",
    "WanIp"       : "172.x.x.x",
    "ZoneId"      : "200002"
  },
  "fields": {
    "ClientLimits"    : "10000",
    "Createtime"      : "2022-07-14 13:54:14",
    "DeadlineTime"    : "0000-00-00 00:00:00",
    "InstanceNodeInfo": "{Instance node information}",
    "InstanceTitle"   : "Running",
    "Size"            : 1024,
    "message"         : "{Instance JSON data}"
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on Redis instance object collection. If Redis custom object collection is not configured, the slow log script cannot collect slow log data.

#### Slow Query Statistics Installation Script

Based on the previous steps, another corresponding script needs to be installed for **RDS Slow Query Statistics Log Collection**

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Tencent Cloud - Redis Slow Query Log Collection)" (ID: `guance_tencentcloud_redis_slowlog`)

After data synchronization is normal, you can view the data in the "Logs" section of Guance.

An example of the reported data is as follows:

```json
{
    "measurement": "tencentcloud_redis_slow_log",
    "tags": {
        "BillingMode" : "0",
        "Client"      : "",
        "Engine"      : "Redis",
        "InstanceId"  : "crs-rha4zlon",
        "InstanceName": "crs-rha4zlon",
        "Node"        : "6d5d8cc6fxxxx",
        "Port"        : "6379",
        "ProductType" : "standalone",
        "ProjectId"   : "0",
        "RegionId"    : "ap-shanghai",
        "Status"      : "2",
        "Type"        : "8",
        "WanIp"       : "172.17.0.9",
        "ZoneId"      : "200002",
        "name"        : "crs-xxxx"
    },
    "fields": {
        "Command"    : "config",
        "CommandLine": "config get whitelist-ips",
        "Duration"   : 1,
        "ExecuteTime": "2022-07-22 18:00:28",
        "message"    : "{Instance JSON data}"
    }
}
```

Part of the parameter explanation is as follows:

| Field          | Type    | Description           |
| -------------- | ------- | --------------------- |
| `Duration`     | Integer | Slow query duration  |
| `Client`       | String  | Client address       |
| `Command`      | String  | Command              |
| `CommandLine`  | String  | Detailed command line information |
| `ExecuteTime`  | String  | Execution time       |
| `Node`         | String  | Node ID              |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
> Note 2: `fields.message` is a JSON serialized string.