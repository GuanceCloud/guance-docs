---
title: '腾讯云 MariaDB'
tags: 
  - 腾讯云
summary: '使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}'
__int_icon: 'icon/tencent_mariadb'
dashboard:

  - desc: '腾讯云 MariaDB 内置视图'
    path: 'dashboard/zh/tencent_mariadb'

monitor:
  - desc: 'Tencent MariaDB 监控器'
    path: 'monitor/zh/tencent_mariadb'
---

<!-- markdownlint-disable MD025 -->
# 腾讯云 MariaDB
<!-- markdownlint-enable -->

使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装 MariaDB 采集脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MariaDB 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（腾讯云-MariaDB采集）」(ID：`guance_tencentcloud_mariadb`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-mariadb/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/54397){:target="_blank"}

### 监控指标

| 指标英文名      | 指标中文名             | 含义                        | 单位  | 维度              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| ActiveThreadCount | 活跃线程数               | 实例级别监控指标， 计算方式为累加所有分片主备节点活跃线程数  | 个   | InstanceId |
| BinlogDiskAvailable | 剩余 Binlog 日志磁盘空间 | 实例级别监控指标， 计算方式为累加各个分片 BinlogDiskAvailableShard 指标监控值 | GB | InstanceId |
| BinlogUsedDisk | 已用 Binlog 日志磁盘空间 | 实例级别监控指标， 计算方式为累加各个分片主节点已用 Binlog 日志磁盘空间 | GB | InstanceId |
| ConnUsageRate | DB 连接使用率            | 实例级别监控指标， 取值为实例所有分片主备节点的 DB 连接使用率的最大值 | % | InstanceId |
| CpuUsageRate | CPU 利用率               | 实例级别监控指标，取值为实例所有分片主节点 CPU 使用率的最大值 | % | InstanceId |
| DataDiskAvailable | 可用数据磁盘空间         | 实例级别监控指标，计算方式为累加各个分片主节点可用数据磁盘空间 | GB | InstanceId |
| DataDiskUsedRate | 数据磁盘空间利用率       | 实例级别监控指标，取值为实例各个分片主节点数据磁盘空间利用率最大值 | % | InstanceId |
| DeleteTotal | DELETE 请求数            | 实例级别监控指标，计算方式为累加实例各个分片主节点的 Delete 请求数 | 次/秒 | InstanceId |
| `InnodbBufferPoolReads` | `innodb` 磁盘读页次数      | 实例级别监控指标，计算方式为累加实例所有分片主备节点 `innodb` 磁盘读页次数 | 次 | InstanceId |
| `InnodbBufferPoolReadAhead` | `innodb` 缓冲池预读页次数  | 实例级别监控指标，计算方式为累加实例所有分片主备节点 `innodb` 缓冲池预读页次数 | 次 | InstanceId |
| `InnodbBufferPoolReadRequests` | `innodb` 缓冲池读页次数    | 实例级别监控指标，计算方式为累加实例所有分片主备节点 `innodb` 缓冲池读页次数 | 次 | InstanceId |
| `InnodbRowsDeleted` | `innodb` 执行 DELETE 行数  | 实例级别监控指标，计算方式为累加实例各个分片主节点 `innodb` 执行 DELETE 行数 | 行 | InstanceId |
| `InnodbRowsInserted` | `innodb` 执行 INSERT 行数  | 实例级别监控指标，计算方式为累加实例各个分片主节点 `innodb` 执行 INSERT 行数 | 行 | InstanceId |
| `InnodbRowsRead` | `innodb` 执行 READ 行数    | 实例级别监控指标，计算方式为累加实例所有分片主备节点 `innodb` 执行 READ 行数 | 行 | InstanceId |
| `InnodbRowsUpdated` | `innodb` 执行 UPDATE 行数  | 实例级别监控指标，计算方式为累加实例各个分片主节点 `innodb` 执行 UPDATE 行数 | 行 | InstanceId |
| InsertTotal | INSERT 请求数            | 实例级别监控指标，计算方式为累加实例各个分片主节点的 INSERT 请求数 | 次/秒 | InstanceId |
| LongQueryCount | 慢查询数                 | 实例级别监控指标，计算方式为累加实例各个分片主节点的慢查询数 | 次 | InstanceId |
| MemAvailable | 可用缓存空间             | 实例级别监控指标，计算方式为累加实例各个分片主节点的可用缓存空间 | GB | InstanceId |
| MemHitRate | 缓存命中率               | 实例级别监控指标，取值为实例各个分片主节点的缓存命中率最小值 | % | InstanceId |
| ReplaceSelectTotal | REPLACE_SELECT 请求数    | 实例级别监控指标，计算方式为累加实例各个分片主节点 REPLACE-SELECT 请求数 | 次/秒 | InstanceId |
| ReplaceTotal | REPLACE 请求数           | 实例级别监控指标，计算方式为累加实例各个分片主节点 REPLACE 请求数 | 次/秒 | InstanceId |
| RequestTotal | 总请求数                 | 实例级别监控指标，计算方式为累加实例所有主节点总请求数和所有备节点的 SELECT 请求数 | 次/秒 | InstanceId |
| SelectTotal | SELECT 请求数            | 实例级别监控指标，计算方式为累加实例所有分片主备节点 SELECT 请求数 | 次/秒 | InstanceId |
| SlaveDelay | 备库延迟                 | 实例级别监控指标，先计算各个分片的备延迟，然后取1个最大值作为这个实例的备延迟。分片的备延迟为这个分片的所有备节点延迟的最小值 | 秒 | InstanceId |
| UpdateTotal | UPDATE 请求数            | 实例级别监控指标，计算方式为累加实例各个分片主节点 UPDATE 请求数 | 次/秒 | InstanceId |
| ThreadsConnected | 当前打开连接数           | 实例级别监控指标，计算方式为累加实例所有分片主备节点当前打开连接数 | 次 | InstanceId |
| ConnMax | 最大连接数               | 实例级别监控指标，计算方式为累加实例所有分片主备节点最大连接数 | 个 | InstanceId |
| ClientConnTotal | 客户端总连接数           | 实例级别监控指标，计算方式为累加实例 Proxy 上的所有连接。这个指标真实展示了您有多少个客户端连到数据库实例上 | 个 | InstanceId |
| SQLTotal | SQL 总数                 | 实例级别监控指标，表示您有多少条 SQL 发往数据库实例          | 条 | InstanceId |
| ErrorSQLTotal | SQL 错误数               | 实例级别监控指标，表示有多少条 SQL 执行错误                  | 条 | InstanceId |
| SuccessSQLTotal | SQL 成功数               | 实例级别监控指标，表示成功执行的 SQL 数量                    | 个 | InstanceId |
| TimeRange0 | 耗时(<5ms)请求数         | 实例级别监控指标，表示执行时间小于5ms的请求数                | 次/秒 | InstanceId |
| TimeRange1 | 耗时(5~20ms)请求数       | 实例级别监控指标，表示执行时间5-20ms的请求数                 | 次/秒 | InstanceId |
| TimeRange2 | 耗时(20~30ms)请求数      | 实例级别监控指标，表示执行时间20~30ms的请求数                | 次/秒 | InstanceId |
| TimeRange3 | 耗时(大于30ms)请求数     | 实例级别监控指标，表示执行时间大于30ms的请求数               | 次/秒 | InstanceId |
| MasterSwitchedTotal | 主从切换次数             | 实例级别监控指标，表示实例主从切换发生的次数                 | 次 | InstanceId |
| IOUsageRate | IO 利用率                | 实例级别监控指标，取值为实例各个分片主节点 IO 利用率的最大值 | % | InstanceId |
| MaxSlaveCpuUsageRate | 最大备节点 CPU 利用率    | 实例级别监控指标，取值为所有备节点 CPU 利用率的最大值        | % | InstanceId |
| ThreadsRunningCount | 汇总运行线程数           | 实例级别监控指标，取值为累加实例所有节点 Threads_running 数值。Threads_running 为执行 show status like 'Threads_running' 得到的结果 | 个 | InstanceId |

## 对象 {#object}

采集到的腾讯云 MariaDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_mariadb",
  "tags": {
    "AppId": "1311xxx185",
    "AutoRenewFlag" : "0",
    "DbEngine"      : "MariaDB",
    "DbVersion"     : "10.1",
    "DbVersionId"   : "10.1",
    "InstanceId"    : "tdsql-ewqokixxxxxhu",
    "InstanceName"  : "tdsql-ewqoxxxxxxihu",
    "InstanceType"  : "2",
    "Paymode"       : "postpaid",
    "ProjectId"     : "0",
    "RegionId"      : "ap-shanghai",
    "Status"        : "0",
    "StatusDesc"    : "创建中",
    "TdsqlVersion"  : "基于MariaDB 10.1设计(兼容Mysql 5.6)",
    "Uin"           : "100xxxx113474",
    "Vip"           : "",
    "Vport"         : "3306",
    "WanDomain"     : "",
    "WanPort"       : "0",
    "WanVip"        : "",
    "Zone"          : "ap-shanghai-5",
    "name"          : "tdsql-ewqokihu",
    "WanVIP"        : ""
  },
  "fields": {
    "Cpu"           : 1,
    "CreateTime"    : "2023-08-17 17:55:03",
    "Memory"        : 2,
    "NodeCount"     : 2,
    "PeriodEndTime" : "0001-01-01 00:00:00",
    "Qps"           : 2100,
    "Storage"       : 10,
    "UpdateTime"    : "2023-08-17 17:55:03",
    "message"       : "{实例 JSON 数据}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值作为唯一识别
>
> 提示 2：`fields.message`、 `fields.InstanceNode` 为 JSON 序列化后字符串
