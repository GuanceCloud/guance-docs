---
title: 'Tencent Redis'
summary: 'Tencent Cloud Redis metrics display, including connection count, request count, latency, and slow queries.'
__int_icon: 'icon/tencent_redis_mem'
dashboard:

  - desc: 'Tencent Redis Built-in Dashboard'
    path: 'dashboard/zh/tencent_redis_mem'

monitor:
  - desc: 'Tencent Redis Monitor'
    path: 'monitor/zh/tencent_redis_mem'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Redis
<!-- markdownlint-enable -->


Tencent Cloud Redis metrics display, including connection count, request count, latency, and slow queries.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Tencent AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud-RedisCollect）」(ID：`guance_tencentcloud_redis`)

Click 【Install】 and enter the corresponding parameters: Tencent AK, Tencent account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configuring Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-redis/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Tencent Cloud Redis monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}


| Metric English Name       | Metric Chinese Name          | Metric Description                                                     | Unit  | Dimension       | Granularity                         |
| ---------------- | ------------------- | ------------------------------------------------------------ | ----- | ---------- | -------------------------------- |
| CpuUtil          | CPU 使用率          | Average CPU Usage                                              | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CpuMaxUtil       | 节点最大 CPU 使用率 | Maximum CPU Usage in the Instance for a Node (Shard or Replica)                    | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| MemUsed          | 内存使用量          | Actual Used Memory Capacity, Including Data and Cache                         | MB    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| MemUtil          | 内存使用率          | Ratio of Actual Used Memory to Total Allocated Memory                                 | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| MemMaxUtil       | 节点最大内存使用率  | Maximum Memory Usage in the Instance for a Node (Shard or Replica)                     | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| Keys             | Key 总个数          | Total number of Keys (Top-level Keys) stored in the instance.                            | 个    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| Expired          | Key 过期数          | Number of Keys evicted within the time window, corresponding to the expired_keys output in the info command | 个    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| Evicted          | Key 驱逐数          | Number of Keys evicted within the time window, corresponding to the evicted_keys output in the info command | 个    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| Connections      | 连接数量            | Number of TCP connections to the instance                                   | 个    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| ConnectionsUtil  | 连接使用率          | Ratio of actual TCP connections to the maximum connection limit                              | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| InFlow           | 入流量              | Internal network inbound traffic                                                  | Mb/s  | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| InBandwidthUtil  | 入流量使用率        | Ratio of actual internal network inbound traffic to the maximum allowed inbound traffic                               | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| InFlowLimit      | 入流量限流触发      | Number of times inbound traffic triggered rate limiting                                         | count   | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| OutFlow          | 出流量              | Internal network outbound traffic                                                   | Mb/s  | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| OutBandwidthUtil | 出流量使用率        | Ratio of actual internal network outbound traffic to the maximum allowed outbound traffic                               | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| OutFlowLimit     | 出流量限流触发      | Number of times outbound traffic triggered rate limiting                                         | count    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| LatencyAvg       | 平均执行时延        | Average execution latency from Proxy to Redis Server                       | ms    | **instanceid** | 5s、60s、300s、3600s、86400s     |
| LatencyMax       | 最大执行时延        | Maximum execution latency from Proxy to Redis Server                       | ms    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| LatencyRead      | 读平均时延          | Average execution latency of read commands from Proxy to Redis Server                   | ms    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| LatencyWrite     | 写平均时延          | Average execution latency of write commands from Proxy to Redis Server                   | ms    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| LatencyOther     | 其他命令平均时延    | Average execution latency of commands other than read and write commands from Proxy to Redis Server      | ms    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| Commands         | 总请求              | QPS (Queries Per Second), number of command executions                                            | count per second | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdRead          | 读请求              | Read QPS (Queries Per Second), number of read command executions per second                                           | 次/秒 | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdWrite         | 写请求              | Write QPS (Queries Per Second), number of write command executions per second                                          | 次/秒 | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdOther         | 其他请求            | QPS for commands other than read and write, number of executions per second                               | count per second | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdBigValue      | 大 Value 请求       | QPS for commands with a size exceeding 32KB, number of executions per second                           | count per second | **instanceid** | 5s、60s、300s、3600s、86400s     |
| CmdKeyCount      | Key 请求数          | Number of Keys accessed by commands                                          | number per second | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| **CmdMget**          | **Mget** 请求数         | Number of executions of the **MGET** command                                            | number per second | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdSlow          | 慢查询              | Number of commands with execution latency greater than the **slowlog-log-slower-than** configuration value    | count    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdHits          | 读请求命中          | Number of read requests for Keys that exist, corresponding to the **keyspace_hits** metric in the info command output | count    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdMiss          | 读请求Miss          | Number of read requests for Keys that do not exist, corresponding to the **keyspace_misses** metric in the info command output | count    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdErr           | 执行错误            | Number of command execution errors, such as command not found, parameter errors, etc         | count    | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |
| CmdHitsRatio     | 读请求命中率        | Cache Hit Ratio" (Key Hits / (Key Hits + Key Misses)), this metric reflects the Cache Miss situation | %     | **instanceid** | 5s、 60s、 300s、 3600s、 86400s |





### Overview of Parameters Corresponding to Each Dimension

| Parameter Name                       | Dimension Name   | Dimension Explanation               | Format                                                         |
| ------------------------------ | ---------- | ---------------------- | ------------------------------------------------------------ |
| Instances.N.Dimensions.0.Name  | **instanceid** | Instance ID Dimension Name       | Input String Type Dimension Name：**instanceid**                         |
| Instances.N.Dimensions.0.Value | **instanceid** | Specific Instance ID           | To input the specific Redis instance ID, please provide either the instance ID in the format **"tdsql-123456"** or the instance serial number like **"crs-ifmymj41"**. You can obtain this information by querying the Redis instance list{:target="_blank"} through the corresponding API |
| Instances.N.Dimensions.1.Name  | **rnodeid**    | Redis Node ID Dimension Name | Input String Type Dimension Name: **rnodeid**                            |
| Instances.N.Dimensions.1.Value | **rnodeid**    | Specific Redis Node ID      | Please input the specific Redis node ID. You can obtain this information through the Query Instance Node Information{:target="_blank"} API |
| Instances.N.Dimensions.1.Name  | **pnodeid**    | Proxy Node ID Dimension Name | Input String Type Dimension Name: **pnodeid**                            |
| Instances.N.Dimensions.1.Value | **pnodeid**    | Specific Proxy Node ID      | Please input the specific Proxy node ID. You can obtain this information through the Query Instance Node Information{:target="_blank"} API |
| Instances.N.Dimensions.1.Name  | **command**    | Command Dimension Name         | Input String Type Dimension Name: **command**                            |
| Instances.N.Dimensions.1.Value | **command**    | Specific Command             | Please input the specific command. For example: "ping", "get", etc                            |

### Parameter Description

Querying cloud database Redis instance monitoring data, the input parameter values are as follows： `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID`

Querying cloud database Proxy node monitoring data, the input parameter values are as follows： `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=pnodeid &Instances.N.Dimensions.1.Value=Proxy Node ID`

Querying cloud database Redis node monitoring data, the input parameter values are as follows： `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=rnodeid  &Instances.N.Dimensions.1.Value=Redis Node ID`

Querying cloud database Redis latency metrics (command dimension) monitoring data, the input parameter values are as follows： `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=Instance ID &Instances.N.Dimensions.1.Name=command &Instances.N.Dimensions.1.Value=Specific Command`

## Object {#object}
The data structure of collected Tencent Cloud Redis object can be viewed in 'Infrastructure - Custom' where object data is available

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
    "InstanceNodeInfo": "{Instance Node}",
    "InstanceTitle"   : "Running",
    "Size"            : 1024,
    "message"         : "{Instance JSON data}"
  }
}
```

## Logging {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Hint 1: The execution of this script relies on Redis instance object collection. If custom object collection for Redis is not configured, the slow log script will be unable to collect slow log data

#### Installation of Slow Query Statistics Script

Based on the previous steps, you need to install another script **RDS Tencent Cloud-Redis Slow LogCollect**

In the 'Management / Script Market' section, click and install the corresponding script package：

- 「Guance Integration（Tencent Cloud - Redis Slow Log Collect） 」(ID：`guance_tencentcloud_redis_slowlog`)

After successful data synchronization, you can view the data in the 'Logs' section of the Observation Cloud.

The example of reported data is as follows：

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
        "message"    : "{InstanceJSONdata}"
    }
}
```

Partial parameter explanations are as follows:

| Field          | Type    | Description           |
| :------------ | :------ | :------------- |
| `Duration`    | Integer | Slow query execution time     |
| `Client`      | String  | Client address     |
| `Command`     | String  | Command           |
| `CommandLine` | String  | Detailed command-line information |
| `ExecuteTime` | String  | Execution time       |
| `Node`        | String  | Node ID        |

> *Note: The fields in tags and fields may change in subsequent updates*
> Hint 1: The value of tags.name is the instance ID, which serves as a unique identifier
> Hint 2: The value of fields.message is a JSON-serialized string
