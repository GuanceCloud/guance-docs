---
title: '腾讯云 MongoDB'
tags: 
  - 腾讯云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/tencent_mongodb'
dashboard:

  - desc: '腾讯云 MongoDB 内置视图'
    path: 'dashboard/zh/tencent_mongodb'

monitor:
  - desc: '腾讯云 MongoDB 监控器'
    path: 'monitor/zh/tencent_mongodb'

---

<!-- markdownlint-disable MD025 -->
# 腾讯云 MongoDB
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MongoDB 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-MongoDB采集）」(ID：`guance_tencentcloud_mongodb`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45104){:target="_blank"}

### 请求类

| 指标英文名      | 指标中文名             | 含义                        | 单位  | 维度              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Inserts_sum`       | 写入请求次数           | 单位时间内写入次数          | 次    | target（实例 ID） |
| `Reads_sum`         | 读取请求次数           | 单位时间内读取次数          | 次    | target（实例 ID） |
| `Updates_sum`       | 更新请求次数           | 单位时间内更新次数          | 次    | target（实例 ID） |
| `Deletes_sum`       | 删除请求次数           | 单位时间内删除次数          | 次    | target（实例 ID） |
| `Counts_sum`        | count 请求次数         | 单位时间内 count 次数       | 次    | target（实例 ID） |
| `Success_sum`       | 成功请求次数           | 单位时间内成功请求次数      | 次    | target（实例 ID） |
| `Commands_sum`      | command 请求次数       | 单位时间内 command 请求次数 | 次    | target（实例 ID） |
| `Qps_sum`           | 每秒钟请求次数         | 每秒操作数，包含 CRUD 操作  | 次/秒 | target（实例 ID） |
| `CountPerSecond_sum` | 每秒钟 count 请求次数  | 每秒钟 count 请求次数       | 次/秒 | target（实例 ID） |
| `DeletePerSecond_sum` | 每秒钟 delete 请求次数 | 每秒钟 delete 请求次数      | 次/秒 | target（实例 ID） |
| `InsertPerSecond_sum` | 每秒钟 insert 请求次数 | 每秒钟 insert 请求次数      | 次/秒 | target（实例 ID） |
| `ReadPerSecond_sum` | 每秒钟 read 请求次数   | 每秒钟 read 请求次数        | 次/秒 | target（实例 ID） |
| `UpdatePerSecond_sum` | 每秒钟 update 请求次数 | 每秒钟 update 请求次数      | 次/秒 | target（实例 ID） |

### 时延请求类

| 指标英文名         | 指标中文名                   | 含义                                     | 单位 | 维度              |
| ------------------ | ---------------------------- | ---------------------------------------- | ---- | ----------------- |
| `Delay10_sum`          | 时延在10 - 50毫秒间请求次数  | 单位时间内成功请求延迟在10ms - 50ms次数  | 次   | target（实例 ID） |
| `Delay50_sum`          | 时延在50 - 100毫秒间请求次数 | 单位时间内成功请求延迟在50ms - 100ms次数 | 次   | target（实例 ID） |
| `Delay100_sum`         | 时延在100毫秒以上请求次数    | 单位时间内成功请求延迟在100ms以上次数    | 次   | target（实例 ID） |
| `AvgAllRequestDelay_sum` | 所有请求平均延迟             | 所有请求平均延迟                         | ms   | target（实例 ID） |

### 连接数类

| 指标英文名  | 指标中文名 | 含义                                        | 单位 | 维度              |
| ----------- | ---------- | ------------------------------------------- | ---- | ----------------- |
| `ClusterConn_max` | 集群连接数 | 集群总连接数，指当前集群 proxy 收到的连接数 | 次   | target（实例 ID） |
| `Connper_max`   | 连接使用率 | 当前集群的连接数与集群总连接配置的比例      | %    | target（实例 ID） |

### 系统类

| 指标英文名         | 指标中文名 | 含义                                       | 单位 | 维度              |
| ------------------ | ---------- | ------------------------------------------ | ---- | ----------------- |
| `ClusterDiskusage` | 磁盘使用率 | 集群当前实际占用存储空间与总容量配置的比例 | %    | target（实例 ID） |

### 出入流量类

| 指标英文名      | 指标中文名 | 含义           | 单位  | 维度                  |
| --------------- | ---------- | -------------- | ----- | --------------------- |
| `ClusterNetin`  | 入流量     | 集群网络入流量 | Bytes | **target**（实例 ID） |
| `ClusterNetout` | 出流量     | 集群网络出流程 | Bytes | **target**（实例 ID） |

### MongoDB 副本集

#### 1. 系统类

| 指标英文名         | 指标中文名 | 含义             | 单位 | 维度                    |
| ------------------ | ---------- | ---------------- | ---- | ----------------------- |
| `ReplicaDiskusage` | 磁盘使用率 | 副本集容量使用率 | %    | **target**（副本集 ID） |

#### 2. 主从类

| 指标英文名          | 指标中文名         | 含义                                         | 单位 | 维度                |
| ------------------- | ------------------ | -------------------------------------------- | ---- | ------------------- |
| `SlaveDelay`        | 主从延迟           | 主从单位时间内平均延迟                       | 秒   | target（副本集 ID） |
| `Oplogreservedtime` | **oplog** 保存时间 | **oplog** 记录中最后一次操作和首次操作时间差 | 小时 | target（副本集 ID)  |

#### 3. Cache 类

| 指标英文名   | 指标中文名         | 含义                          | 单位 | 维度               |
| ------------ | ------------------ | ----------------------------- | ---- | ------------------ |
| `CacheDirty` | Cache 脏数据百分比 | 当前内存 Cache 中脏数据百分比 | %    | target（副本集 ID) |
| `CacheUsed`  | Cache 使用百分比   | 当前 Cache 使用百分比         | %    | target（副本集 ID) |
| `HitRatio`   | Cache 命中率       | 当前 Cache 命中率             | %    | target（副本集 ID) |

### Mongo 节点

<!-- markdownlint-disable MD024 -->

#### 1. 系统类

<!-- markdownlint-enable -->

| 指标英文名              | 指标中文名         | 含义                     | 单位  | 维度             |
| ----------------------- | ------------------ | ------------------------ | ----- | ---------------- |
| `CpuUsage`              | CPU 使用率         | CPU 使用率               | %     | target（节点 ID) |
| `MemUsage`              | 内存使用率         | 内存使用率               | %     | target（节点 ID) |
| `NetIn`                 | 网络入流量         | 网络入流量               | MB/s  | target（节点 ID) |
| `NetOut`                | 网络出流量         | 网络出流量               | MB/s  | target（节点 ID) |
| `Disk`                  | 节点磁盘用量       | 节点磁盘用量             | MB    | target（节点 ID) |
| `Conn`                  | 连接数             | 连接数                   | 次    | target（节点 ID) |
| `ActiveSession`         | 活跃 session 数量  | 活跃 session 数量        | 次    | target（节点 ID) |
| `NodeOplogReservedTime` | **Oplog** 保存时长 | 节点 **oplog** 保存时长  | -     | target（节点 ID) |
| `NodeHitRatio`          | Cache 命中率       | Cache 命中率             | %     | target（节点 ID) |
| `NodeCacheUsed`         | Cache 使用百分比   | Cache 内存在总内存中占比 | %     | target（节点 ID) |
| `NodeSlavedelay`        | 主从延迟           | 从节点延迟               | s     | target（节点 ID) |
| `Diskusage`             | 节点磁盘使用率     | 节点磁盘使用率           | %     | target（节点 ID) |
| `Ioread`                | 磁盘读次数         | 磁盘读 IOPS              | 次/秒 | target（节点 ID) |
| `Iowrite`               | 磁盘写次数         | 磁盘写 IOPS              | 次/秒 | target（节点 ID) |
| `NodeCacheDirty`        | Cache 脏数据百分比 | Cache 中脏数据比例       | %     | target（节点 ID) |

#### 2. 读写类

| 指标英文名 | 指标中文名                 | 含义                       | 单位 | 维度             |
| ---------- | -------------------------- | -------------------------- | ---- | ---------------- |
| `Qr`       | Read 请求等待队列中的个数  | Read 请求等待队列中的个数  | 个   | target（节点 ID) |
| `Qw`       | Write 请求等待队列中的个数 | Write 请求等待队列中的个数 | 个   | target（节点 ID) |
| `Ar`       | WT 引擎的ActiveRead        | Read 请求活跃个数          | 个   | target（节点 ID) |
| `Aw`       | WT 引擎ActiveWrite         | Write 请求活跃个数         | 个   | target（节点 ID) |

#### 3. 时延&请求类

| 指标英文名               | 指标中文名                     | 含义                           | 单位  | 维度             |
| ------------------------ | ------------------------------ | ------------------------------ | ----- | ---------------- |
| `NodeAvgAllRequestDelay` | 所有请求平均时延               | 节点所有请求平均延迟           | ms    | target（节点 ID) |
| `NodeDelay100`           | 节点延迟超过100毫秒请求量      | 节点延迟超过100毫秒请求量      | 次    | target（节点 ID) |
| `NodeDelay10`            | 节点延迟介于10-50毫秒间请求量  | 节点延迟介于10-50毫秒间请求量  | 次    | target（节点 ID) |
| `NodeDelay50`            | 节点延迟介于50-100毫秒间请求量 | 节点延迟介于50-100毫秒间请求量 | 次    | target（节点 ID) |
| `NodeSuccessPerSecond`   | 节点每秒钟请求成功数           | 节点每秒钟请求成功数           | 次/秒 | target（节点 ID) |
| `NodeCountPerSecond`     | 节点每秒钟 count 请求次数      | 节点每秒钟 count 请求次数      | 次/秒 | target（节点 ID) |
| `NodeDeletePerSecond`    | 节点每秒钟 delete 请求次数     | 节点每秒钟 delete 请求次数     | 次/秒 | target（节点 ID) |
| `NodeInsertPerSecond`    | 节点每秒钟 insert 请求次数     | 节点每秒钟 insert 请求次数     | 次/秒 | target（节点 ID) |
| `NodeReadPerSecond`      | 节点每秒钟 read 请求次数       | 节点每秒钟 read 请求次数       | 次/秒 | target（节点 ID) |
| `NodeUpdatePerSecond`    | 节点每秒钟 update 请求次数     | 节点每秒钟 update 请求次数     | 次/秒 | target（节点 ID) |
| `SuccessPerSecond`       | 总请求                         | 节点每秒钟请求成功数           | 次/秒 | target（节点 ID) |

#### 4. TTL 索引类

| 指标英文名   | 指标中文名         | 含义               | 单位 | 维度             |
| ------------ | ------------------ | ------------------ | ---- | ---------------- |
| `TtlDeleted` | TTL 删除的数据条数 | TTL 删除的数据条数 | 个   | target（节点 ID) |
| `TtlPass`    | TTL 运转轮数       | TTL 运转轮数       | 个   | target（节点 ID) |

## 对象 {#object}

采集到的腾讯云 MongoDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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

## 日志 {#logging}

### 慢查询统计

#### 前提条件

> 提示 1：本脚本的代码运行依赖 MongoDB 实例对象采集，如果未配置 MongoDB 的自定义对象采集，慢日志脚本无法采集到慢日志数据

<!-- markdownlint-disable MD024 -->

#### 安装脚本

<!-- markdownlint-enable -->

在之前的基础上，需要再安装一个对应 **MongoDB 慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（腾讯云-MongoDB慢查询日志采集）  」(ID：`guance_tencentcloud_mongodb_slowlog`)

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

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

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags`值由自定义对象补充
>
> 提示 2：`fields.message`为 JSON 序列化后字符串
>
> 提示 3：`fields.Slowlog`为 所有的慢查询详情记录的每一条记录
