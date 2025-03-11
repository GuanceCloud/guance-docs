---
title: 'Tencent Cloud Redis'
tags: 
  - Tencent Cloud
summary: 'Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc.'
__int_icon: 'icon/tencent_redis_mem'
dashboard:

  - desc: 'Built-in views for Tencent Cloud Redis'
    path: 'dashboard/zh/tencent_redis_mem'

monitor:
  - desc: 'Tencent Cloud Redis monitor'
    path: 'monitor/zh/tencent_redis_mem'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Redis
<!-- markdownlint-enable -->


Display of Tencent Cloud Redis metrics, including connections, requests, latency, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed, please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only permissions `ReadOnlyAccess`).

Synchronize monitoring data from Tencent Cloud Redis. We install the corresponding collection script: 「Guance Integration (Tencent Cloud-Redis Collection)」(ID: `guance_tencentcloud_redis`)

After clicking 【Install】, enter the required parameters: Tencent Cloud AK and Tencent Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-redis/){:target="_blank"}


### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud Redis, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Redis Instance Monitoring

| Metric Name         | Metric Description                                                    | Unit  | Dimension       | Statistical Granularity                         |
| ------------------- | --------------------------------------------------------------------- | ----- | --------------- | ----------------------------------------------- |
| `CpuUtil`           | Average CPU utilization                                               | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CpuMaxUtil`        | Maximum CPU utilization of nodes (shards or replicas)                 | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `MemUsed`           | Actual memory usage, including data and cache                         | MB    | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `MemUtil`           | Ratio of actual memory usage to total allocated memory                | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `MemMaxUtil`        | Maximum memory utilization of nodes (shards or replicas)              | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `Keys`              | Total number of keys                                                  | Count | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `Expired`           | Number of expired keys within the time window                         | Count | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `Evicted`           | Number of evicted keys within the time window                         | Count | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `Connections`       | Number of TCP connections                                             | Count | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `ConnectionsUtil`   | Ratio of actual TCP connections to maximum connections                | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `InFlow`            | Inbound traffic                                                       | Mb/s  | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `InBandwidthUtil`   | Ratio of actual inbound traffic to maximum traffic                    | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `InFlowLimit`       | Number of times inbound traffic triggers throttling                   | Count | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `OutFlow`           | Outbound traffic                                                      | Mb/s  | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `OutBandwidthUtil`  | Ratio of actual outbound traffic to maximum traffic                   | %     | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `OutFlowLimit`      | Number of times outbound traffic triggers throttling                  | Count | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `LatencyAvg`        | Average execution latency                                             | ms    | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `LatencyMax`        | Maximum execution latency                                             | ms    | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `LatencyRead`       | Average read command latency                                          | ms    | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `LatencyWrite`      | Average write command latency                                         | ms    | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `LatencyOther`      | Average latency for commands other than read/write                    | ms    | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `Commands`          | Total requests                                                        | Times/sec | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdRead`           | Read requests                                                         | Times/sec | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdWrite`          | Write requests                                                        | Times/sec | `instanceid`    | 5s, 600s, 300s, 3600s, 86400s                   |
| `CmdOther`          | Requests other than read/write                                        | Times/sec | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdBigValue`       | Large value requests                                                  | Times/sec | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdKeyCount`       | Number of keys accessed by commands                                   | Keys/sec | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdMget`           | **Mget** request count                                                | Keys/sec | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdSlow`           | Slow queries                                                          | Count   | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdHits`           | Hits for read requests                                                | Count   | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdMiss`           | Misses for read requests                                              | Count   | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdErr`            | Execution errors                                                      | Count   | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |
| `CmdHitsRatio`      | Hit rate for read requests                                            | %       | `instanceid`    | 5s, 60s, 300s, 3600s, 86400s                    |

### Overview of Dimensions and Corresponding Parameters

| Parameter Name                         | Dimension Name     | Dimension Explanation               | Format                                                         |
| -------------------------------------- | ------------------ | ------------------------------------ | -------------------------------------------------------------- |
| `Instances.N.Dimensions.0.Name`        | `instanceid`       | Instance ID dimension name          | Input String type dimension name: **instanceid**               |
| `Instances.N.Dimensions.0.Value`       | `instanceid`       | Specific instance ID                | Input specific Redis instance ID, e.g., `tdsql-123456`         |
| `Instances.N.Dimensions.1.Name`        | `rnodeid`          | Redis node ID dimension name        | Input String type dimension name: **rnodeid**                  |
| `Instances.N.Dimensions.1.Value`       | `rnodeid`          | Specific Redis node ID              | Input specific Redis node ID via [Query Redis Instance List API](https://cloud.tencent.com/document/api/239/20018){:target="_blank"} |
| `Instances.N.Dimensions.1.Name`        | `pnodeid`          | Proxy node ID dimension name        | Input String type dimension name: **pnodeid**                  |
| `Instances.N.Dimensions.1.Value`       | `pnodeid`          | Specific proxy node ID              | Input specific proxy node ID via [Query Instance Node Info API](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} |
| `Instances.N.Dimensions.1.Name`        | `command`          | Command word dimension name         | Input String type dimension name: **command**                  |
| `Instances.N.Dimensions.1.Value`       | `command`          | Specific command word               | Input specific command word, e.g., ping, get                   |

### Input Parameter Explanation

**To query Redis instance monitoring data, use the following input parameters:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID`

**To query Proxy node monitoring data, use the following input parameters:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=pnodeid &Instances.N.Dimensions.1.Value=Proxy Node ID`

**To query Redis node monitoring data, use the following input parameters:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=rnodeid &Instances.N.Dimensions.1.Value=Redis Node ID`

**To query Redis latency metrics (command dimension), use the following input parameters:** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=command &Instances.N.Dimensions.1.Value=Specific Command Word`

## Objects {#object}
The collected Tencent Cloud Redis object data structure can be viewed under 「Infrastructure-Custom」.

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

On top of the previous setup, you need to install an additional script for **RDS slow query statistics log collection**

In 「Manage / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Tencent Cloud-Redis Slow Query Log Collection)」(ID: `guance_tencentcloud_redis_slowlog`)

After data synchronization, you can view the data in the 「Logs」 section of Guance.

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
> Note 1: `tags.name` value is the instance ID, used for unique identification.
> Note 2: `fields.message` is a JSON serialized string.
