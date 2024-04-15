---
title: 'Tencent Cloud MongoDB'
summary: 'Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud'
__int_icon: 'icon/tencent_mongodb'
dashboard:

  - desc: 'Tencent Cloud MongoDB Monitoring View'
    path: 'dashboard/zh/tencent_mongodb'

monitor:
  - desc: 'Tencent Cloud MongoDB Monitor'
    path: 'monitor/zh/tencent_mongodb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MongoDB
<!-- markdownlint-enable -->

Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud - MongoDBCollect）」(ID：`guance_tencentcloud_mongodb`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Tencent Cloud OSS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45104){:target="_blank"}

### Request class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| Inserts_sum         | Number of write requests           | Number of writes per unit time          | Times    | target（Instance ID） |
| Reads_sum           | Number of read requests           | Number of reads per unit time          | Times    | target（Instance ID） |
| Updates_sum         | Number of update requests           | Number of updates per unit time          | Times    | target（Instance ID） |
| Deletes_sum         | Number of delete requests           | Number of deletes per unit time          | Times    | target（Instance ID） |
| Counts_sum          | Number of count requests         | Number of counts per unit time       | Times    | target（Instance ID） |
| Success_sum         | Number of successful requests           | Number of successful requests per unit time      | Times    | target（Instance ID） |
| Commands_sum        | Number of command requests       | Number of command requests per unit time | Times    | target（Instance ID） |
| Qps_sum             | Number of requests per second         | Number of operations per second, including CRUD operations  | Times/second | target（Instance ID） |
| CountPerSecond_sum  | Number of count requests per second  | Number of count requests per second       | Times/second | target（Instance ID） |
| DeletePerSecond_sum | Number of delete requests per second | Number of delete requests per second      | Times/second | target（Instance ID） |
| InsertPerSecond_sum | Number of insert requests per second | Number of insert requests per second      | Times/second | target（Instance ID） |
| ReadPerSecond_sum   | Number of read requests per second   | Number of read requests per second        | Times/second | target（Instance ID） |
| UpdatePerSecond_sum | Number of update requests per second | Number of update requests per second      | Times/second | target（Instance ID） |

### Delay request class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ------------------ | ---------------------------- | ---------------------------------------- | ---- | ----------------- |
| Delay10_sum            | Number of requests with delay between 10 - 50 ms  | Number of successful requests with delay between 10ms - 50ms per unit time  | Times   | target（Instance ID） |
| Delay50_sum            | Number of requests with delay between 50 - 100 ms | Number of successful requests with delay between 50ms - 100ms per unit time | Times   | target（Instance ID） |
| Delay100_sum           | Number of requests with delay over 100 ms    | Number of successful requests with delay over 100ms per unit time    | Times   | target（Instance ID） |
| AvgAllRequestDelay_sum | Average delay of all requests             | Average delay of all requests                         | ms   | target（Instance ID） |

### Connection number class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ----------- | ---------- | ------------------------------------------- | ---- | ----------------- |
| `ClusterConn_max` | Cluster connection number | Total number of connections received by the current cluster proxy | Times   | target（Instance ID） |
| `Connper_max`     | Connection usage rate | The ratio of the number of connections in the current cluster to the total connection configuration      | %    | target（Instance ID） |

### System class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------------- | ---------- | ------------------------------------------ | ---- | ----------------- |
| `ClusterDiskusage` | Disk usage rate | The ratio of the actual occupied storage space of the cluster to the total capacity configuration | %    | target（Instance ID） |

### In/Out flow class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ------------- | ---------- | -------------- | ----- | ----------------- |
| `ClusterNetin`  | Inflow     | Cluster network inflow | Bytes | target（Instance ID） |
| `ClusterNetout` | Outflow     | Cluster network outflow | Bytes | target（Instance ID） |

### MongoDB Replica set

#### 1. System class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------------- | ---------- | ---------------- | ---- | ------------------- |
| `ReplicaDiskusage` | Disk usage rate | Replica set capacity usage rate | %    | target（Replica set ID） |

#### 2. Master-slave class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ----------------- | -------------- | ---------------------------------------- | ---- | ------------------- |
| `SlaveDelay`        | Master-slave delay       | Average delay of master and slave in unit time                   | Seconds   | target（Replica set ID） |
| `Oplogreservedtime` | **Oplog** retention time | The time difference between the last operation and the first operation in the **oplog** record | Hours | target（Replica set ID)  |

#### 3. Cache class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------- | ------------------ | ----------------------------- | ---- | ------------------ |
| CacheDirty | Percentage of dirty data in Cache | Percentage of dirty data in current memory Cache | %    | target（Replica set ID) |
| CacheUsed  | Cache usage percentage   | Current Cache usage percentage         | %    | target（Replica set ID) |
| HitRatio   | Cache hit rate       | Current Cache hit rate             | %    | target（Replica set ID) |

### Mongo Node

<!-- markdownlint-disable MD024 -->
#### 1. System class
<!-- markdownlint-enable -->

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| --------------------- | ------------------ | ------------------------ | ----- | ---------------- |
| `CpuUsage`              | CPU usage rate         | CPU usage rate               | %     | target（Node ID) |
| `MemUsage`              | Memory usage rate         | Memory usage rate               | %     | target（Node ID) |
| `NetIn`                 | Network inflow         | Network inflow               | MB/s  | target（Node ID) |
| `NetOut`                | Network outflow         | Network outflow               | MB/s  | target（Node ID) |
| `Disk`                  | Node disk usage       | Node disk usage             | MB    | target（Node ID) |
| `Conn`                  | Number of connections             | Number of connections                   | Times    | target（Node ID) |
| `ActiveSession`         | Number of active sessions  | Number of active sessions        | Times    | target（Node ID) |
| `NodeOplogReservedTime` | **Oplog** retention duration     | Node **oplog** retention duration      | -     | target（Node ID) |
| `NodeHitRatio`          | Cache hit rate       | Cache hit rate             | %     | target（Node ID) |
| `NodeCacheUsed`         | Cache usage percentage   | Percentage of Cache memory in total memory | %     | target（Node ID) |
| `NodeSlavedelay`        | Master-slave delay           | Delay of slave nodes               | Seconds     | target（Node ID) |
| `Diskusage`             | Node disk usage rate     | Node disk usage rate           | %     | target（Node ID) |
| `Ioread`                | Number of disk reads         | Disk read IOPS              | Times/second | target（Node ID) |
| `Iowrite`               | Number of disk writes         | Disk write IOPS              | Times/second | target（Node ID) |
| `NodeCacheDirty`        | Percentage of dirty data in Cache | Percentage of dirty data in Cache       | %     | target（Node ID) |

#### 2. Read/Write class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------- | -------------------------- | -------------------------- | ---- | ---------------- |
| Qr         | Number of read requests in the waiting queue  | Number of read requests in the waiting queue  | Count   | target（Node ID) |
| Qw         | Number of write requests in the waiting queue | Number of write requests in the waiting queue | Count   | target（Node ID) |
| Ar         | ActiveRead of WT engine        | Number of active read requests          | Count   | target（Node ID) |
| Aw         | ActiveWrite of WT engine         | Number of active write requests         | Count   | target（Node ID) |

#### 3. Delay&Request class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------------------- | ------------------------------ | ------------------------------ | ----- | ---------------- |
| NodeAvgAllRequestDelay | Average delay of all requests               | Average delay of all requests on node           | ms    | target（Node ID) |
| NodeDelay100           | Number of requests on node with delay over 100 ms      | Number of requests on node with delay over 100 ms      | Times    | target（Node ID) |
| NodeDelay10            | Number of requests on node with delay between 10-50 ms  | Number of requests on node with delay between 10-50 ms  | Times    | target（Node ID) |
| NodeDelay50            | Number of requests on node with delay between 50-100 ms | Number of requests on node with delay between 50-100 ms | Times    | target（Node ID) |
| NodeSuccessPerSecond   | Number of successful requests on node per second           | Number of successful requests on node per second           | Times/second | target（Node ID) |
| NodeCountPerSecond     | Number of count requests on node per second      | Number of count requests on node per second      | Times/second | target（Node ID) |
| NodeDeletePerSecond    | Number of delete requests on node per second     | Number of delete requests on node per second     | Times/second | target（Node ID) |
| NodeInsertPerSecond    | Number of insert requests on node per second     | Number of insert requests on node per second     | Times/second | target（Node ID) |
| NodeReadPerSecond      | Number of read requests on node per second       | Number of read requests on node per second       | Times/second | target（Node ID) |
| NodeUpdatePerSecond    | Number of update requests on node per second     | Number of update requests on node per second     | Times/second | target（Node ID) |
| SuccessPerSecond       | Total requests                         | Number of successful requests on node per second           | Times/second | target（Node ID) |

#### 4. TTL Index class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------- | ------------------ | ------------------ | ---- | ---------------- |
| TtlDeleted | Number of data deleted by TTL | Number of data deleted by TTL | Count   | target（Node ID) |
| TtlPass    | Number of TTL rotations       | Number of TTL rotations       | Count   | target（Node ID) |

## Object {#object}

The collected Tencent Cloud MongoDB object data structure can be seen from the "Infrastructure - Custom" object data

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
    "RelatedInstance"  : "{Instance JSON data}",
    "ReplicaSets"      : "{Instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{Instance JSON data}",
  }
}
```

## **Loging** {#logging}

### Slow query statistics

#### Preconditions

> Tip 1: The code running of this script depends on the collection of MongoDB instance objects. If the custom collection of MongoDB object is not configured, the slow log script cannot collect slow log data

<!-- markdownlint-disable MD024 -->
#### Installation script
<!-- markdownlint-enable -->

On the basis of the previous, you need to install another script for **MongoDB slow query statistics log collection**

In "Manage/Script Marketplace", click and install the corresponding script package:

- 「Guance Integration（Tencent Cloud - MongoDB Slow Query Log Collect）  」(ID：`guance_tencentcloud_mongodb_slowlog`)

After data is synchronized, you can view the data in Logs of the observation cloud.

The following is an example of the reported data:

```json
{
  "measurement": "tencentcloud_mongodb_slow_log",
  "tags": {

  },
  "fields": {
      "Slowlog": "Slow log details",
      "message": "{Instance JSON data}"
  }
}
```

> Note: The fields in tags and Fields may change with subsequent updates
>
> Tip 1: The tags value is supplemented by a custom object
>
> Tip 2: 'fields.message' is the JSON serialized string
>
> Tip 3: 'fields.Slowlog' records each record for all slow query details
