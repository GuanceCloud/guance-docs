---
title: 'Tencent Cloud Redis'
tags: 
  - Tencent Cloud
summary: 'Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc.'
__int_icon: 'icon/tencent_redis_mem'
dashboard:

  - desc: 'Built-in views for Tencent Cloud Redis'
    path: 'dashboard/en/tencent_redis_mem'

monitor:
  - desc: 'Tencent Cloud Redis Monitor'
    path: 'monitor/en/tencent_redis_mem'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Redis
<!-- markdownlint-enable -->


Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

Synchronize monitoring data from Tencent Cloud-Redis by installing the corresponding collection script: 「Guance Integration (Tencent Cloud-Redis Collection)」(ID: `guance_tencentcloud_redis`)

After clicking 【Install】, enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-redis/){:target="_blank"}



### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, in 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Tencent Cloud-Redis, the default metric set is as follows. You can collect more metrics through configuration. [Tencent Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Redis Instance Monitoring

| Metric English Name | Metric Chinese Name | Metric Description                                                     | Unit | Dimension         | Statistical Granularity                         |
| ------------------ | ------------------- | ------------------------------------------------------------ | ----- | ------------ | -------------------------------- |
| `CpuUtil`          | CPU Usage           | Average CPU usage                                              | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CpuMaxUtil`       | Maximum Node CPU Usage | Maximum CPU usage of nodes (shards or replicas) in the instance                    | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `MemUsed`          | Memory Usage        | Actual memory capacity used, including data and cache parts                         | MB    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `MemUtil`          | Memory Usage Rate   | Ratio of actual memory used to total allocated memory                                 | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `MemMaxUtil`       | Maximum Node Memory Usage | Maximum memory usage rate of nodes (shards or replicas) in the instance                     | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Keys`             | Total Key Count     | Total number of keys stored in the instance (first-level keys)                            | Count    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Expired`          | Expired Keys        | Number of keys evicted within the time window, corresponding to the expired_keys output of the info command | Count    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Evicted`          | Evicted Keys        | Number of keys evicted within the time window, corresponding to the evicted_keys output of the info command | Count    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Connections`      | Connection Count    | Number of TCP connections connected to the instance                                    | Count    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `ConnectionsUtil`  | Connection Usage Rate | Ratio of actual TCP connections to maximum connections                              | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `InFlow`           | Inbound Traffic     | Internal inbound traffic                                                   | Mb/s  | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `InBandwidthUtil`  | Inbound Traffic Usage Rate | Ratio of actual internal inbound traffic to maximum traffic                               | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `InFlowLimit`      | Inbound Traffic Throttling Trigger | Number of times inbound traffic triggers throttling                                         | Times    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `OutFlow`          | Outbound Traffic    | Internal outbound traffic                                                   | Mb/s  | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `OutBandwidthUtil` | Outbound Traffic Usage Rate | Ratio of actual internal outbound traffic to maximum traffic                               | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `OutFlowLimit`     | Outbound Traffic Throttling Trigger | Number of times outbound traffic triggers throttling                                         | Times    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyAvg`       | Average Execution Latency | Average execution latency from Proxy to Redis Server                       | ms    | `instanceid` | 5s、60s、300s、3600s、86400s     |
| `LatencyMax`       | Maximum Execution Latency | Maximum execution latency from Proxy to Redis Server                       | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyRead`      | Average Read Latency | Average execution latency of read commands from Proxy to Redis Server                   | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyWrite`     | Average Write Latency | Average execution latency of write commands from Proxy to Redis Server                   | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyOther`     | Average Latency for Other Commands | Average execution latency of commands other than read/write commands from Proxy to Redis Server       | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Commands`         | Total Requests      | QPS, number of command executions                                            | Times/sec | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdRead`          | Read Requests       | Number of read command executions per second                                           | Times/sec | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdWrite`         | Write Requests      | Number of write command executions per second                                           | Times/sec | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdOther`         | Other Requests      | Number of command executions per second other than read/write commands                               | Times/sec | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdBigValue`      | Large Value Requests | Number of command executions per second where request size exceeds 32KB                           | Times/sec | `instanceid` | 5s、60s、300s、3600s、86400s     |
| `CmdKeyCount`      | Key Request Count   | Number of keys accessed by commands                                          | Count/sec | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdMget`          | **Mget** Request Count | Number of **Mget** command executions                                        | Count/sec | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdSlow`          | Slow Queries        | Number of commands with execution latency greater than the slowlog-log-slower-than configuration    | Times    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdHits`          | Hits on Read Requests | Number of read requests where the key exists, corresponding to the keyspace_hits metric from the info command | Times    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdMiss`          | Misses on Read Requests | Number of read requests where the key does not exist, corresponding to the keyspace_misses metric from the info command | Times    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdErr`           | Execution Errors    | Number of command execution errors, such as non-existent commands, incorrect parameters, etc.         | Times    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdHitsRatio`     | Hit Rate on Read Requests | Hits / (Hits + Misses), this metric reflects the Cache Miss situation | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |



### Overview of Parameters for Each Dimension

| Parameter Name                         | Dimension Name     | Dimension Explanation               | Format                                                         |
| -------------------------------- | ------------ | ---------------------- | ------------------------------------------------------------ |
| `Instances.N.Dimensions.0.Name`  | `instanceid` | Instance ID Dimension Name       | Input String type dimension name: **instanceid**                     |
| `Instances.N.Dimensions.0.Value` | `instanceid` | Specific Instance ID            | Input the specific Redis instance ID, e.g., `tdsql-123456`, or instance serial number, e.g., `crs-ifmymj41`. This can be queried via [Query Redis Instance List API](https://cloud.tencent.com/document/api/239/20018){:target="_blank"} |
| `Instances.N.Dimensions.1.Name`  | `rnodeid`    | Redis Node ID Dimension Name | Input String type dimension name: **rnodeid**                        |
| `Instances.N.Dimensions.1.Value` | `rnodeid`    | Specific Redis Node ID      | Input the specific Redis node ID, which can be obtained via [Query Instance Node Information API](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} |
| `Instances.N.Dimensions.1.Name`  | `pnodeid`    | Proxy Node ID Dimension Name | Input String type dimension name: **pnodeid**                        |
| `Instances.N.Dimensions.1.Value` | `pnodeid`    | Specific Proxy Node ID      | Input the specific proxy node ID, which can be obtained via [Query Instance Node Information API](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} |
| `Instances.N.Dimensions.1.Name`  | `command`    | Command Word Dimension Name         | Input String type dimension name: **command**                        |
| `Instances.N.Dimensions.1.Value` | `command`    | Specific Command Word             | Input specific command word, e.g., ping, get, etc. |

### Parameter Explanation

**To query Redis instance monitoring data, the parameter values are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID`

**To query Proxy node monitoring data, the parameter values are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=pnodeid &Instances.N.Dimensions.1.Value=Proxy Node ID`

**To query Redis node monitoring data, the parameter values are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=rnodeid  &Instances.N.Dimensions.1.Value=Redis Node ID`

**To query Redis latency metrics (command dimension) monitoring data, the parameter values are as follows:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=command &Instances.N.Dimensions.1.Value=Specific Command Word`

## Objects {#object}
The collected Tencent Cloud Redis object data structure can be viewed under 「Infrastructure-Custom」

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
    "InstanceNodeInfo": "{Instance Node Information}",
    "InstanceTitle"   : "Running",
    "Size"            : 1024,
    "message"         : "{Instance JSON Data}"
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the collection of Redis instance objects. If Redis custom object collection is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Statistics

On top of the existing setup, install the corresponding script for **RDS Slow Query Log Collection**

In 「Management / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Tencent Cloud-Redis Slow Query Log Collection)」(ID: `guance_tencentcloud_redis_slowlog`)

After data synchronization is normal, you can view the data in the 「Logs」section on Guance.

Example of reported data:

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
        "message"    : "{Instance JSON Data}"
    }
}
```

Explanation of some parameters:

| Field          | Type    | Description           |
| :------------ | :------ | :------------- |
| `Duration`    | Integer | Slow query duration     |
| `Client`      | String  | Client address     |
| `Command`     | String  | Command           |
| `CommandLine` | String  | Detailed command line information |
| `ExecuteTime` | String  | Execution time       |
| `Node`        | String  | Node ID        |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note 1: The value of `tags.name` is the instance ID, used for unique identification.
> Note 2: `fields.message` is a JSON serialized string.