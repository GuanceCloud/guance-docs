---
title: '阿里云 RDS SQLServer'
summary: '阿里云 RDS SQLServer 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。'
__int_icon: 'icon/aliyun_rds_sqlserver'
dashboard:
  - desc: '阿里云 RDS SQLServer 内置视图'
    path: 'dashboard/zh/aliyun_rds_sqlserver/'

---

阿里云 RDS SQLServer 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。

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

- 「观测云集成（阿里云- RDS 采集）」(ID：`guance_aliyun_rds`)

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

| Metric Id              | Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| SQLServer_CpuUsage     | SQLServerCpu使用率    | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_DiskUsage    | SQLServer磁盘使用率   | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_IOPS         | SQLServer每秒IO次数   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_NetworkRead  | SQLServer网络流出带宽 | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_NetworkWrite | SQLServer网络流入带宽 | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_QPS          | SQLServer每秒查询数   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TPS          | SQLServer每秒事务数   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TotaConn     | SQLServer总连接数     | userId,instanceId | Average,Maximum,Minimum | count       |

## 对象 {#object}

采集到的阿里云 SLB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
{
  "measurement": "aliyun_rds",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "DBInstanceId"         : "rm-xxxxx",
    "ZoneId"               : "cn-shanghai-h",
    "RegionId"             : "cn-shanghai",
    "DBInstanceDescription": "业务系统",
    "LockMode"             : "Unlock",
    "Category"             : "Basic",
    "ConnectionMode"       : "Standard",
    "DBInstanceNetType"    : "Intranet",
    "DBInstanceStorageType": "local_ssd",
  },
  "fields": {
    "CreationTime"     : "2022-12-13T16:00:00Z",
    "ExpireTime"       : "2022-12-13T16:00:00Z",
    "DiskUsed"         : "10000",
    "BackupSize"       : "10000",
    "LogSize"          : "10000",
    "BackupLogSize"    : "10000",
    "BackupDataSize"   : "10000",
    "ConnectionString" : "{连接地址 JSON 数据}",
    "DBInstanceStorage": "100",
    "accounts"         : "{用户权限信息 JSON 数据}",
    "databases"        : "{数据库信息 JSON 数据}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{实例 JSON 数据}",
  }
}

```

## 日志 {#logging}

### 慢查询统计

#### 前提条件

> 提示 1：本脚本的代码运行依赖 RDS 实例对象采集，如果未配置 RDS 的自定义对象采集，慢日志脚本无法采集到慢日志数据

> 提示 2：因阿里云统计数据返回有 6~8 小时的延迟，所以采集器更新数据可能会有延迟，详细参考阿里云文档：云数据库 RDS 查询慢日志统计

> 提示 3：本采集器支持 MySQL所有版本（MySQL 5.7基础版除外）、SQL Server 2008 R2、MariaDB 10.3 类型数据库，若要采集其他类型数据库，请使用 [阿里云-RDS 慢查询明细](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} 采集器

#### 安装脚本

在之前的基础上，需要再安装一个对应 **RDS 慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（阿里云- RDS 慢查询统计日志采集）」(ID：`guance_aliyun_rds_slowlog`)

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_rds_slowlog",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBName"               : "cloudcare_core",
    "DBInstanceId"         : "rm-bp1xxxxxxxxxx",
    "RegionId"             : "cn-hangzhou",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "ZoneId"               : "cn-shanghai-h",
    "DBInstanceDescription": "业务系统"
  },
  "fields": {
    "SQLHASH"                      : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                      : "{SQL 语句}",
    "CreateTime"                   : "2022-06-05Z",
    "SQLServerTotalExecutionTimes" : 0,
    "MaxExecutionTime"             : 1,
    "MaxLockTime"                  : 0,
    "AvgExecutionTime"             : 0,
    "MySQLTotalExecutionTimes"     : 0,
    "SQLServerTotalExecutionTimes" : 1,
    "SQLServerTotalExecutionCounts": 0,
    "MySQLTotalExecutionCounts"    : 0,
    "SQLServerAvgExecutionTime"    : 0,
    "message"                      : "{日志 JSON 数据}"
  }
}

```

部分参数说明如下：

| 字段                            | 类型 | 说明                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server 执行时长（总值，毫秒）      |
| `AvgExecutionTime`              | int  | 执行时间（平均值）单位：秒             |
| `SQLServerAvgExecutionTime`     | int  | 执行时间（平均值）单位：秒             |
| `MySQLTotalExecutionTimes`      | int  | MySQL 执行时间（总值）单位：秒         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server 执行时间（总值） 单位：毫秒 |
| `SQLServerTotalExecutionCounts` | int  | SQL Server 执行次数（总值）            |
| `MySQLTotalExecutionCounts`     | int  | MySQL 执行次数（总值）                 |

> *注意：`AvgExecutionTime`、`SQLServerAvgExecutionTime`、`SQLServerTotalExecutionTimes`、等字段仅 SQL Server 实例支持*

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

### 慢查询明细

#### 前提条件


> 提示：本脚本的代码运行依赖 RDS 实例对象采集，如果未配置 RDS 的自定义对象采集，慢日志脚本无法采集到慢日志数据

#### 安装脚本

在之前的基础上，需要再安装一个对应 **RDS 慢查询明细日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（阿里云-RDS慢查询明细日志采集）」(ID：`guance_aliyun_rds_slowlog_record`)

数据正常同步后，可以在观测云的「日志」中查看数据。

配置[云数据库 RDS 慢查询明细](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

上报的数据示例如下：

```json
{
  "measurement": "aliyun_rds_slowlog",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBName"               : "cloudcare_core",
    "DBInstanceId"         : "rm-bp1xxxxxxxxxx",
    "RegionId"             : "cn-hangzhou",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "ZoneId"               : "cn-shanghai-h",
    "DBInstanceDescription": "业务系统",
    "HostAddress"          : "xxxx",
    "UserName"             : "xxxx",
    "ClientHostName"       : "xxxx",
    "ApplicationName"      : "xxxx",

  },
  "fields": {
    "SQLHASH"                      : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                      : "{SQL 语句}",
    "QueryTimes"                   : 0,
    "QueryTimesMS"                 : 0,
    "ReturnRowCounts"              : 0,
    "ParseRowCounts"               : 0,
    "ExecutionStartTime"           : "2022-02-02T12:00:00Z",
    "CpuTime"                      : 1,
    "RowsAffectedCount"            : 0,
    "LastRowsAffectedCount"        : 0,
    "message"                      : "{日志 JSON 数据}"
  }
}

```

部分参数说明如下：

| 字段                    | 类型 | 说明                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | 执行时长。单位：秒（s）    |
| `QueryTimesMS`          | int  | 执行时长。单位：毫秒（ms） |
| `ReturnRowCounts`       | int  | 返回行数                   |
| `ParseRowCounts`        | int  | 解析行数                   |
| `ExecutionStartTime`    | str  | 执行开始时间               |
| `CpuTime`               | int  | CPU处理时长                |
| `RowsAffectedCount`     | int  | 影响行数                   |
| `LastRowsAffectedCount` | int  | 最后一条语句影响行数       |

> *注意：`CpuTime`、`RowsAffectedCount`、`LastRowsAffectedCount`等字段仅 SQL Server 实例支持*

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

