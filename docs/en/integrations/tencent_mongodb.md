---
title: 'Tencent Cloud MongoDB'
summary: 'Use the 「Observation Cloud Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud'
__int_icon: 'icon/tencent_mongodb'
dashboard:

  - desc: 'Tencent Cloud MongoDB 内置视图'
    path: 'dashboard/zh/tencent_mongodb'

monitor:
  - desc: 'Tencent Cloud MongoDB 监控器'
    path: 'monitor/zh/tencent_mongodb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MongoDB
<!-- markdownlint-enable -->

Use the 「Observation Cloud Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「观测云集成（腾讯云-MongoDB采集）」(ID：`guance_tencentcloud_mongodb`)

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

Configure Tencent Cloud OSS monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45104){:target="_blank"}

### Request class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| Inserts_sum         | 写入请求次数           | 单位时间内写入次数          | 次    | target（实例 ID） |
| Reads_sum           | 读取请求次数           | 单位时间内读取次数          | 次    | target（实例 ID） |
| Updates_sum         | 更新请求次数           | 单位时间内更新次数          | 次    | target（实例 ID） |
| Deletes_sum         | 删除请求次数           | 单位时间内删除次数          | 次    | target（实例 ID） |
| Counts_sum          | count 请求次数         | 单位时间内 count 次数       | 次    | target（实例 ID） |
| Success_sum         | 成功请求次数           | 单位时间内成功请求次数      | 次    | target（实例 ID） |
| Commands_sum        | command 请求次数       | 单位时间内 command 请求次数 | 次    | target（实例 ID） |
| Qps_sum             | 每秒钟请求次数         | 每秒操作数，包含 CRUD 操作  | 次/秒 | target（实例 ID） |
| CountPerSecond_sum  | 每秒钟 count 请求次数  | 每秒钟 count 请求次数       | 次/秒 | target（实例 ID） |
| DeletePerSecond_sum | 每秒钟 delete 请求次数 | 每秒钟 delete 请求次数      | 次/秒 | target（实例 ID） |
| InsertPerSecond_sum | 每秒钟 insert 请求次数 | 每秒钟 insert 请求次数      | 次/秒 | target（实例 ID） |
| ReadPerSecond_sum   | 每秒钟 read 请求次数   | 每秒钟 read 请求次数        | 次/秒 | target（实例 ID） |
| UpdatePerSecond_sum | 每秒钟 update 请求次数 | 每秒钟 update 请求次数      | 次/秒 | target（实例 ID） |

### Delay request class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ------------------ | ---------------------------- | ---------------------------------------- | ---- | ----------------- |
| Delay10_sum            | 时延在10 - 50毫秒间请求次数  | 单位时间内成功请求延迟在10ms - 50ms次数  | 次   | target（实例 ID） |
| Delay50_sum            | 时延在50 - 100毫秒间请求次数 | 单位时间内成功请求延迟在50ms - 100ms次数 | 次   | target（实例 ID） |
| Delay100_sum           | 时延在100毫秒以上请求次数    | 单位时间内成功请求延迟在100ms以上次数    | 次   | target（实例 ID） |
| AvgAllRequestDelay_sum | 所有请求平均延迟             | 所有请求平均延迟                         | ms   | target（实例 ID） |

### Connection number class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ----------- | ---------- | ------------------------------------------- | ---- | ----------------- |
| ClusterConn_max | 集群连接数 | 集群总连接数，指当前集群 proxy 收到的连接数 | 次   | target（实例 ID） |
| Connper_max     | 连接使用率 | 当前集群的连接数与集群总连接配置的比例      | %    | target（实例 ID） |

### System class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------------- | ---------- | ------------------------------------------ | ---- | ----------------- |
| ClusterDiskusage | 磁盘使用率 | 集群当前实际占用存储空间与总容量配置的比例 | %    | target（实例 ID） |

### In/Out flow class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ------------- | ---------- | -------------- | ----- | ----------------- |
| ClusterNetin  | 入流量     | 集群网络入流量 | Bytes | target（实例 ID） |
| ClusterNetout | 出流量     | 集群网络出流程 | Bytes | target（实例 ID） |

### MongoDB Replica set

#### 1. System class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------------- | ---------- | ---------------- | ---- | ------------------- |
| ReplicaDiskusage | 磁盘使用率 | 副本集容量使用率 | %    | target（副本集 ID） |

#### 2. Master-slave class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ----------------- | -------------- | ---------------------------------------- | ---- | ------------------- |
| SlaveDelay        | 主从延迟       | 主从单位时间内平均延迟                   | 秒   | target（副本集 ID） |
| Oplogreservedtime | oplog 保存时间 | oplog 记录中最后一次操作和首次操作时间差 | 小时 | target（副本集 ID)  |

#### 3. Cache class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------- | ------------------ | ----------------------------- | ---- | ------------------ |
| CacheDirty | Cache 脏数据百分比 | 当前内存 Cache 中脏数据百分比 | %    | target（副本集 ID) |
| CacheUsed  | Cache 使用百分比   | 当前 Cache 使用百分比         | %    | target（副本集 ID) |
| HitRatio   | Cache 命中率       | 当前 Cache 命中率             | %    | target（副本集 ID) |

### Mongo Node

#### 1. System class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| --------------------- | ------------------ | ------------------------ | ----- | ---------------- |
| CpuUsage              | CPU 使用率         | CPU 使用率               | %     | target（节点 ID) |
| MemUsage              | 内存使用率         | 内存使用率               | %     | target（节点 ID) |
| NetIn                 | 网络入流量         | 网络入流量               | MB/s  | target（节点 ID) |
| NetOut                | 网络出流量         | 网络出流量               | MB/s  | target（节点 ID) |
| Disk                  | 节点磁盘用量       | 节点磁盘用量             | MB    | target（节点 ID) |
| Conn                  | 连接数             | 连接数                   | 次    | target（节点 ID) |
| ActiveSession         | 活跃 session 数量  | 活跃 session 数量        | 次    | target（节点 ID) |
| NodeOplogReservedTime | Oplog 保存时长     | 节点 oplog 保存时长      | -     | target（节点 ID) |
| NodeHitRatio          | Cache 命中率       | Cache 命中率             | %     | target（节点 ID) |
| NodeCacheUsed         | Cache 使用百分比   | Cache 内存在总内存中占比 | %     | target（节点 ID) |
| NodeSlavedelay        | 主从延迟           | 从节点延迟               | s     | target（节点 ID) |
| Diskusage             | 节点磁盘使用率     | 节点磁盘使用率           | %     | target（节点 ID) |
| Ioread                | 磁盘读次数         | 磁盘读 IOPS              | 次/秒 | target（节点 ID) |
| Iowrite               | 磁盘写次数         | 磁盘写 IOPS              | 次/秒 | target（节点 ID) |
| NodeCacheDirty        | Cache 脏数据百分比 | Cache 中脏数据比例       | %     | target（节点 ID) |

#### 2. Read/Write class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------- | -------------------------- | -------------------------- | ---- | ---------------- |
| Qr         | Read 请求等待队列中的个数  | Read 请求等待队列中的个数  | 个   | target（节点 ID) |
| Qw         | Write 请求等待队列中的个数 | Write 请求等待队列中的个数 | 个   | target（节点 ID) |
| Ar         | WT 引擎的ActiveRead        | Read 请求活跃个数          | 个   | target（节点 ID) |
| Aw         | WT 引擎ActiveWrite         | Write 请求活跃个数         | 个   | target（节点 ID) |

#### 3. Delay&Request class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------------------- | ------------------------------ | ------------------------------ | ----- | ---------------- |
| NodeAvgAllRequestDelay | 所有请求平均时延               | 节点所有请求平均延迟           | ms    | target（节点 ID) |
| NodeDelay100           | 节点延迟超过100毫秒请求量      | 节点延迟超过100毫秒请求量      | 次    | target（节点 ID) |
| NodeDelay10            | 节点延迟介于10-50毫秒间请求量  | 节点延迟介于10-50毫秒间请求量  | 次    | target（节点 ID) |
| NodeDelay50            | 节点延迟介于50-100毫秒间请求量 | 节点延迟介于50-100毫秒间请求量 | 次    | target（节点 ID) |
| NodeSuccessPerSecond   | 节点每秒钟请求成功数           | 节点每秒钟请求成功数           | 次/秒 | target（节点 ID) |
| NodeCountPerSecond     | 节点每秒钟 count 请求次数      | 节点每秒钟 count 请求次数      | 次/秒 | target（节点 ID) |
| NodeDeletePerSecond    | 节点每秒钟 delete 请求次数     | 节点每秒钟 delete 请求次数     | 次/秒 | target（节点 ID) |
| NodeInsertPerSecond    | 节点每秒钟 insert 请求次数     | 节点每秒钟 insert 请求次数     | 次/秒 | target（节点 ID) |
| NodeReadPerSecond      | 节点每秒钟 read 请求次数       | 节点每秒钟 read 请求次数       | 次/秒 | target（节点 ID) |
| NodeUpdatePerSecond    | 节点每秒钟 update 请求次数     | 节点每秒钟 update 请求次数     | 次/秒 | target（节点 ID) |
| SuccessPerSecond       | 总请求                         | 节点每秒钟请求成功数           | 次/秒 | target（节点 ID) |

#### 4. TTL Index class

| Metric Id      | Metric name           | Implication                        | Unit  | Dimensions              |
| ---------- | ------------------ | ------------------ | ---- | ---------------- |
| TtlDeleted | TTL 删除的数据条数 | TTL 删除的数据条数 | 个   | target（节点 ID) |
| TtlPass    | TTL 运转轮数       | TTL 运转轮数       | 个   | target（节点 ID) |

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
    "RelatedInstance"  : "{实例 JSON 数据}",
    "ReplicaSets"      : "{实例 JSON 数据}",
    "StandbyInstances" : "[]",
    "message"          : "{实例 JSON 数据}",
  }
}
```

## Loging {#logging}

### Slow query statistics

#### Preconditions

> Tip 1: The code running of this script depends on the collection of MongoDB instance objects. If the custom collection of MongoDB object is not configured, the slow log script cannot collect slow log data

#### Installation script

On the basis of the previous, you need to install another script for **MongoDB slow query statistics log collection **

In "Manage/Script Marketplace", click and install the corresponding script package:

- 「观测云集成（腾讯云-MongoDB慢查询日志采集）  」(ID：`guance_tencentcloud_mongodb_slowlog`)

After data is synchronized, you can view the data in Logs of the observation cloud.

The following is an example of the reported data:

```json
{
  "measurement": "tencentcloud_mongodb_slow_log",
  "tags": {

  },
  "fields": {
      "Slowlog": "慢日志详情",
      "message": "{实例 JSON 数据}"
  }
}
```

> * Note: The fields in tags and Fields may change with subsequent updates *
>
> Tip 1: The tags value is supplemented by a custom object
>
> Tip 2: 'fields.message' is the JSON serialized string
>
> Tip 3: 'fields.Slowlog' records each record for all slow query details
