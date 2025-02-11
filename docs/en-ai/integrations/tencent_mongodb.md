---
title: 'Tencent Cloud MongoDB'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the script market of Guance to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_mongodb'
dashboard:

  - desc: 'Built-in view for Tencent Cloud MongoDB'
    path: 'dashboard/en/tencent_mongodb'

monitor:
  - desc: 'Tencent Cloud MongoDB monitor'
    path: 'monitor/en/tencent_mongodb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MongoDB
<!-- markdownlint-enable -->

Use the script packages in the script market of Guance to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to activate the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of MongoDB cloud resources, we install the corresponding collection script:「Guance Integration (Tencent Cloud-MongoDB Collection)」(ID: `guance_tencentcloud_mongodb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45104){:target="_blank"}

### Request Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `Inserts_sum`       | Number of write requests | Number of writes per unit time | Times | target (instance ID) |
| `Reads_sum`         | Number of read requests | Number of reads per unit time | Times | target (instance ID) |
| `Updates_sum`       | Number of update requests | Number of updates per unit time | Times | target (instance ID) |
| `Deletes_sum`       | Number of delete requests | Number of deletes per unit time | Times | target (instance ID) |
| `Counts_sum`        | Number of count requests | Number of counts per unit time | Times | target (instance ID) |
| `Success_sum`       | Number of successful requests | Number of successful requests per unit time | Times | target (instance ID) |
| `Commands_sum`      | Number of command requests | Number of commands per unit time | Times | target (instance ID) |
| `Qps_sum`           | Number of requests per second | Operations per second, including CRUD operations | Times/sec | target (instance ID) |
| `CountPerSecond_sum`| Number of count requests per second | Count requests per second | Times/sec | target (instance ID) |
| `DeletePerSecond_sum`| Number of delete requests per second | Delete requests per second | Times/sec | target (instance ID) |
| `InsertPerSecond_sum`| Number of insert requests per second | Insert requests per second | Times/sec | target (instance ID) |
| `ReadPerSecond_sum` | Number of read requests per second | Read requests per second | Times/sec | target (instance ID) |
| `UpdatePerSecond_sum`| Number of update requests per second | Update requests per second | Times/sec | target (instance ID) |

### Latency Request Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `Delay10_sum`          | Number of requests with latency between 10-50ms | Number of successful requests with delay between 10ms-50ms per unit time | Times | target (instance ID) |
| `Delay50_sum`          | Number of requests with latency between 50-100ms | Number of successful requests with delay between 50ms-100ms per unit time | Times | target (instance ID) |
| `Delay100_sum`         | Number of requests with latency over 100ms | Number of successful requests with delay over 100ms per unit time | Times | target (instance ID) |
| `AvgAllRequestDelay_sum` | Average latency of all requests | Average latency of all requests | ms | target (instance ID) |

### Connection Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `ClusterConn_max`   | Cluster connections | Total cluster proxy received connections | Times | target (instance ID) |
| `Connper_max`       | Connection usage rate | Ratio of current cluster connections to total configured connections | % | target (instance ID) |

### System Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `ClusterDiskusage`  | Disk usage rate | Ratio of actual used storage space to total capacity | % | target (instance ID) |

### Inbound and Outbound Traffic Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `ClusterNetin`      | Inbound traffic | Cluster inbound network traffic | Bytes | **target** (instance ID) |
| `ClusterNetout`     | Outbound traffic | Cluster outbound network traffic | Bytes | **target** (instance ID) |

### MongoDB Replica Set

#### 1. System Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `ReplicaDiskusage`  | Disk usage rate | Replica set capacity usage rate | % | **target** (replica set ID) |

#### 2. Master-Slave Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `SlaveDelay`        | Master-slave delay | Average delay between master and slave per unit time | Seconds | target (replica set ID) |
| `Oplogreservedtime` | Oplog retention time | Time difference between the last and first operation in oplog records | Hours | target (replica set ID) |

#### 3. Cache Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `CacheDirty`        | Cache dirty data percentage | Percentage of dirty data in current memory cache | % | target (replica set ID) |
| `CacheUsed`         | Cache usage percentage | Current cache usage percentage | % | target (replica set ID) |
| `HitRatio`          | Cache hit ratio | Current cache hit ratio | % | target (replica set ID) |

### Mongo Node

<!-- markdownlint-disable MD024 -->

#### 1. System Class

<!-- markdownlint-enable -->

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `CpuUsage`          | CPU usage rate | CPU usage rate | % | target (node ID) |
| `MemUsage`          | Memory usage rate | Memory usage rate | % | target (node ID) |
| `NetIn`             | Network inbound traffic | Network inbound traffic | MB/s | target (node ID) |
| `NetOut`            | Network outbound traffic | Network outbound traffic | MB/s | target (node ID) |
| `Disk`              | Node disk usage | Node disk usage | MB | target (node ID) |
| `Conn`              | Connections | Connections | Times | target (node ID) |
| `ActiveSession`     | Active session count | Active session count | Times | target (node ID) |
| `NodeOplogReservedTime` | Oplog retention time | Node oplog retention time | - | target (node ID) |
| `NodeHitRatio`      | Cache hit ratio | Cache hit ratio | % | target (node ID) |
| `NodeCacheUsed`     | Cache usage percentage | Cache memory usage percentage | % | target (node ID) |
| `NodeSlavedelay`    | Master-slave delay | Slave node delay | s | target (node ID) |
| `Diskusage`         | Node disk usage rate | Node disk usage rate | % | target (node ID) |
| `Ioread`            | Disk read frequency | Disk read IOPS | Times/sec | target (node ID) |
| `Iowrite`           | Disk write frequency | Disk write IOPS | Times/sec | target (node ID) |
| `NodeCacheDirty`    | Cache dirty data percentage | Percentage of dirty data in cache | % | target (node ID) |

#### 2. Read/Write Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `Qr`                | Number of read requests in the wait queue | Number of read requests in the wait queue | Count | target (node ID) |
| `Qw`                | Number of write requests in the wait queue | Number of write requests in the wait queue | Count | target (node ID) |
| `Ar`                | WT engine active read | Number of active read requests | Count | target (node ID) |
| `Aw`                | WT engine active write | Number of active write requests | Count | target (node ID) |

#### 3. Latency & Request Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `NodeAvgAllRequestDelay` | Average latency of all requests | Average latency of all requests | ms | target (node ID) |
| `NodeDelay100`      | Number of requests with latency over 100ms | Number of requests with latency over 100ms | Times | target (node ID) |
| `NodeDelay10`       | Number of requests with latency between 10-50ms | Number of requests with latency between 10-50ms | Times | target (node ID) |
| `NodeDelay50`       | Number of requests with latency between 50-100ms | Number of requests with latency between 50-100ms | Times | target (node ID) |
| `NodeSuccessPerSecond` | Number of successful requests per second | Number of successful requests per second | Times/sec | target (node ID) |
| `NodeCountPerSecond`| Number of count requests per second | Number of count requests per second | Times/sec | target (node ID) |
| `NodeDeletePerSecond`| Number of delete requests per second | Number of delete requests per second | Times/sec | target (node ID) |
| `NodeInsertPerSecond`| Number of insert requests per second | Number of insert requests per second | Times/sec | target (node ID) |
| `NodeReadPerSecond` | Number of read requests per second | Number of read requests per second | Times/sec | target (node ID) |
| `NodeUpdatePerSecond`| Number of update requests per second | Number of update requests per second | Times/sec | target (node ID) |
| `SuccessPerSecond`  | Total number of requests | Number of successful requests per second | Times/sec | target (node ID) |

#### 4. TTL Index Class

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
|---------------------|---------------------|---------|------|------------|
| `TtlDeleted`        | Number of TTL deleted entries | Number of TTL deleted entries | Count | target (node ID) |
| `TtlPass`           | TTL rotation count | TTL rotation count | Count | target (node ID) |

## Objects {#object}

The structure of the collected Tencent Cloud MongoDB object data can be viewed in 「Infrastructure-Custom」

```json
{
  "measurement": "tencentcloud_mongodb",
  "tags": {
    "ClusterType" : "0",
    "InstanceId"  : "cmxxxx",
    "InstanceName": "test_01",
    "InstanceType": "1",
    "MongoVersion": "MONxxxx",
    "NetType"     : "1",
    "PayMode"     : "0",
    "ProjectId"   : "0",
    "RegionId"    : "ap-nanjing",
    "Status"      : "2",
    "VpcId"       : "vpc-nf6xxxxx",
    "Zone"        : "ap-nanjing-1",
    "name"        : "cmxxxx"
  },
  "fields": {
    "CloneInstances"   : "[]",
    "CreateTime"       : "2022-08-24 13:54:00",
    "DeadLine"         : "2072-08-24 13:54:00",
    "ReadonlyInstances": "[]",
    "RelatedInstance"  : "{instance JSON data}",
    "ReplicaSets"      : "{instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{instance JSON data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Note 1: The script code depends on the collection of MongoDB instance objects. If MongoDB custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

Based on the previous setup, you need to install another script for collecting **MongoDB slow query statistics logs**

In 「Management / Script Market」click and install the corresponding script package:

- 「Guance Integration (Tencent Cloud-MongoDB Slow Query Log Collection)」(ID: `guance_tencentcloud_mongodb_slowlog`)

After the data synchronization is normal, you can view the data in the 「Logs」section of Guance.

Sample reported data:

```json
{
  "measurement": "tencentcloud_mongodb_slow_log",
  "tags": {

  },
  "fields": {
      "Slowlog": "Slow log details",
      "message": "{instance JSON data}"
  }
}
```

> *Note: The fields in `tags`, `fields` may change with subsequent updates*
>
> Note 1: `tags` values are supplemented by custom objects
>
> Note 2: `fields.message` is a JSON serialized string
>
> Note 3: `fields.Slowlog` is each record of all slow query details