---
title: '阿里云 PolarDB Oracle'
summary: '阿里云 PolarDB Oracle 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、IOPS、 TPS、 数据盘大小等。'
icon: icon/aliyun_polardb_oracle
dashboard:
  - desc: '阿里云 PolarDB Oracle 内置视图'
    path: 'dashboard/zh/aliyun_polardb_oracle/'
---

# 阿里云 PolarDB Oracle

阿里云 PolarDB Oracle 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、IOPS、 TPS、 数据盘大小等。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func ](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并安装对应的脚本包：

- 「观测云集成（阿里云-云监控）」(ID：`guance_aliyun_monitor`)

- 「观测云集成（阿里云-PolarDB采集）」(ID：`guance_aliyun_polardb`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标] (https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id            | Metric Name    | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| active_connections   | 活跃连接数     | userId,clusterId,instanceId | Average    | count     |
| blks_read_delta      | 数据块读取数   | userId,clusterId,instanceId | Average    | count     |
| conn_usage           | 连接使用率     | userId,clusterId,instanceId | Average    | %         |
| cpu_total            | CPU使用率      | userId,clusterId,instanceId | Average    | %         |
| db_age               | 数据库最大年龄 | userId,clusterId,instanceId | Average    | xids      |
| mem_usage            | 内存使用率     | userId,clusterId,instanceId | Average    | %         |
| pls_data_size        | 数据盘大小     | userId,clusterId,instanceId | Value      | Mbyte     |
| pls_iops             | IOPS           | userId,clusterId,instanceId | Average    | frequency |
| pls_iops_read        | 读IOPS         | userId,clusterId,instanceId | Average    | frequency |
| pls_iops_write       | 写IOPS         | userId,clusterId,instanceId | Average    | frequency |
| pls_pg_wal_dir_size  | WAL日志大小    | userId,clusterId,instanceId | Value      | Mbyte     |
| pls_throughput       | IO吞吐         | userId,clusterId,instanceId | Average    | Mbyte/s   |
| pls_throughput_read  | 读IO吞吐       | userId,clusterId,instanceId | Average    | Mbyte/s   |
| pls_throughput_write | 写IO吞吐       | userId,clusterId,instanceId | Average    | Mbyte/s   |
| rollback_ratio       | 事务回滚率     | userId,clusterId,instanceId | Average    | %         |
| swell_time           | 膨胀点         | userId,clusterId,instanceId | Average    | s         |
| tps                  | TPS            | userId,clusterId,instanceId | Average    | frequency |

## 对象 {#object}

采集到的阿里云 PolarDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "VpcId"               : "vpc-xxxx",
    "DBNodeNumber"        : "2",
    "PayType"             : "Postpaid",
    "DBType"              : "MySQL",
    "LockMode"            : "Unlock",
    "DBVersion"           : "8.0",
    "DBClusterId"         : "pc-xxxx",
    "DBClusterNetworkType": "VPC",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx",
    "DBNodeClass"         : "polar.mysql.x4.medium"
  },
  "fields": {
    "DBNodes"   : "{节点列表 JSON 数据}",
    "Database"  : "[数据库详情 JSON 数据]",
    "ExpireTime": "",
    "CreateTime": "2022-06-17T06:07:19Z",
    "message"   : "{实例 JSON 数据}"
  }
}

```

## 日志 {#logging}

### 慢查询统计

#### 前提条件

> 提示：本脚本的代码运行依赖 PolarDB 实例对象采集，如果未配置 PolarDB 的自定义对象采集，慢日志脚本无法采集到慢日志数据

#### 安装脚本

在之前的基础上，需要再安装一个对应 **PolarDB 慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（阿里云- PolarDB 慢查询统计日志采集）」(ID：`guance_aliyun_polardb_slowlog`)

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_polardb_slowlog",
  "tags": {
    "DBName"  : "PolarDB_MySQL",
    "DBNodeId": "pi-***************"
  },
  "fields": {
    "CreateTime"          : "2023-05-22Z",
    "MaxExecutionTime"    : 60,
    "MaxLockTime"         : 1,
    "ParseMaxRowCount"    : 1,
    "ParseTotalRowCounts" : 2,
    "ReturnMaxRowCount"   : 3,
    "ReturnTotalRowCounts": 1,
    "SQLHASH"             : "U2FsdGVkxxxx",
    "SQLText"             : "select id,name from tb_table",
    "TotalExecutionCounts": 2,
    "TotalExecutionTimes" : 2,
    "TotalLockTimes"      : 1,
    "message"             : "{日志 JSON 数据}"
  }
}

```

部分参数说明如下：

| 字段                   | 类型 | 说明                         |
| :--------------------- | :--- | :--------------------------- |
| `MaxExecutionTime`     | Long | 执行时长（最大值），单位：秒 |
| `TotalExecutionTimes`  | Long | 执行时长（总值），单位：秒   |
| `TotalLockTimes`       | Long | 锁定时长（总值），单位：秒   |
| `MaxLockTime`          | Long | 锁定时长（最大值），单位：秒 |
| `ReturnMaxRowCount`    | Long | 返回的SQL行数（最大值）      |
| `ReturnTotalRowCounts` | Long | 返回的SQL行数（总值）        |
| `ParseMaxRowCount`     | Long | 解析的SQL行数（最大值）      |
| `ParseTotalRowCounts`  | Long | 解析的SQL行数（总值）        |
| `TotalExecutionCounts` | Long | 执行次数（总值）             |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示：`fields.message`为 JSON 序列化后字符串

### 慢查询明细

#### 前提条件

> 提示：本脚本的代码运行依赖 PolarDB 实例对象采集，如果未配置 PolarDB 的自定义对象采集，慢日志脚本无法采集到慢日志数据

#### 安装脚本

在之前的基础上，需要再安装一个对应 **PolarDB 慢查询明细日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（阿里云-PolarDB 慢查询明细日志采集）」(ID：`guance_aliyun_polardb_slowlog_record`)

数据正常同步后，可以在观测云的「日志」中查看数据。

配置[云数据库 PolarDB 慢查询明细](https://func.guance.com/doc/script-market-guance-aliyun-polardb-slowlog-record/){:target="_blank"}

上报的数据示例如下：

```json
{
  "measurement": "aliyun_polardb_slowlog_record",
  "tags": {
    "DBName"     : "PolarDB_MySQL",
    "DBNodeId"   : "pi-***************",
    "HostAddress": "testdb[testdb] @ [100.**.**.242]"
  },
  "fields": {
    "SQLText"           : "select id,name from tb_table",
    "ExecutionStartTime": "2021-04-07T03:47Z",
    "QueryTimes"        : 20,
    "ReturnRowCounts"   : 0,
    "ParseRowCounts"    : 0,
    "LockTimes"         : 0,
    "QueryTimeMS"       : 100,
    "message"           : "{日志 JSON 数据}"
  }
}

```

部分参数说明如下：

| 字段                 | 类型   | 说明                                                  |
| :------------------- | :----- | :---------------------------------------------------- |
| `QueryTimes`         | Long   | SQL执行时长，单位为秒                                 |
| `QueryTimesMS`       | Long   | 查询时间。单位毫秒                                    |
| `ReturnRowCounts`    | Long   | 返回行数                                              |
| `ParseRowCounts`     | Long   | 解析行数                                              |
| `ExecutionStartTime` | String | SQL开始执行的时间。格式为YYYY-MM-DDThh:mmZ（UTC时间） |
| `LockTimes`          | Long   | SQL锁定时长，单位为秒                                 |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示：`fields.message`为 JSON 序列化后字符串

