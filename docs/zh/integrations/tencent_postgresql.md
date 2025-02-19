---
title: '腾讯云 PostgreSQL'
tags: 
  - 腾讯云
summary: '使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}'
__int_icon: 'icon/tencent_postgresql'
dashboard:

  - desc: '腾讯云 PostgreSQL 内置视图'
    path: 'dashboard/zh/tencent_postgresql'

monitor:
  - desc: '腾讯云 PostgreSQL 监控器'
    path: 'monitor/zh/tencent_postgresql'


---
<!-- markdownlint-disable MD025 -->
# 腾讯云 PostgreSQL
<!-- markdownlint-enable -->

使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装PostgreSQL采集脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 PostgreSQL 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（腾讯云-PostgreSQL采集）」(ID：`guance_tencentcloud_postgresql`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### 监控指标

| 指标英文名      | 指标中文名             | 含义                        | 单位  | 维度              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu` | CPU 利用率     | CPU 实际利用率  | %    | resourceId |
| `DataFileSize` | 数据文件大小  | 数据文件占用空间大小   | GB | resourceId |
| `LogFileSize` | 日志文件大小  | wal 日志文件占用空间大小  | MB | resourceId |
| `TempFileSize` | 临时文件大小  | 临时文件的大小  | 次 | resourceId |
| `StorageRate` | 存储空间使用率  | 总的存储空间使用率，包括临时文件、数据文件、日志文件以及其他类型的数据库文件  | % | resourceId |
| `Qps` | 每秒查询数   | 平均每秒执行的 SQL 语句数量  | 次/秒 | resourceId |
| `Connections` | 连接数   | 对数据库发起采集时，数据库当前总连接数  | 个 | resourceId |
| `NewConnIn5s` | 5秒内新建连接数  | 对数据库发起采集时，查询出关于最近5秒内建立的所有连接数  | 次 | resourceId |
| `ActiveConns` | 活跃连接数 | 对数据库发起采集时，数据库瞬时活跃连接（非 idle 连接）    | 个 | resourceId |
| `IdleConns` | 空闲连接数 | 对数据库发起采集时，查询出来的数据库瞬时空闲连接（idle 连接）  | 个 | resourceId |
| `Waiting` | 等待会话数   | 对数据库发起采集时，数据库正在等待的会话数量（状态为 waiting） | 次/秒 | resourceId |
| `LongWaiting` | 等待超过5秒的会话数 | 一个采集周期内，数据库等待超过5秒的会话数量（状态为 waiting，且等待状态维持了5秒）  | 个 | resourceId |
| `IdleInXact` | 空闲事务数  | 对数据库发起采集时，数据库正在处于 idle 状态的事务数量 | 个 | resourceId |
| `LongXact` | 执行时长超过1秒的事务数目  | 一个采集周期内，执行时间超过1秒的事务数量  | 个 | resourceId |
| `Tps` | 每秒事务数 | 平均每秒执行成功的事务数（包括回滚和提交）  | 次/秒 | resourceId |
| `XactCommit` | 事务提交数  | 平均每秒提交的事务数  | 次/秒 | resourceId |
| `XactRollback` | 事务回滚数  | 平均每秒回滚的事务数  | 次/秒 | resourceId |
| `ReadWriteCalls` | 请求数  | 一个统计周期内的总请求数  | 次 | resourceId |
| `ReadCalls` | 读请求数  | 一个统计周期内的读请求数  | 次 | resourceId |
| `WriteCalls` | 写请求数  | 一个统计周期内的写请求数  | 次 | resourceId |
| `OtherCalls` | 其他请求数  | 一个统计周期内的其他请求数（begin、create、非 DML、DDL、DQL 操作）  | 次 | resourceId |
| `HitPercent` | 缓冲区缓存命中率  | 一个请求周期内的所有 SQL 语句执行的命中率  | % | resourceId |
| `SqlRuntimeAvg` | 平均执行时延  | 一次统计周期内所有 SQL 语句的平均执行时延  | ms | resourceId |
| `SqlRuntimeMax` | 最长 TOP10 执行时延  | 一次统计周期内最长 TOP10 的 SQL 平均执行时延  | ms | resourceId |
| `SqlRuntimeMin` | 最短 TOP10 执行时延  | 一次统计周期内最短 TOP10 的 SQL 平均执行时延  | ms | resourceId |
| `SlowQueryCnt` | 慢查询数量  | 一个采集周期内，出现的慢查询个数  | 个 | resourceId |
| `LongQuery` | 执行时长超过1秒的 SQL 数  | 对数据库发起采集时，查询出来 执行时间超过1s的 SQL 数量  | 个 | resourceId |
| `2pc` | 2pc事务数  | 对数据库发起采集时，当前的 2PC 事务数量  | 个 | resourceId |
| `Long2pc` | 超过5s未提交的 2PC 事务数  | 对数据库发起采集时，当前执行时间超过5s的 2PC 事务数量  | 个 | resourceId |
| `Deadlocks` | 死锁数  | 在一个采集周期内的所有死锁数  | 个 | resourceId |
| `Memory` | 内存占用量  | 内存已使用量  | MB | resourceId |
| `MemoryRate` | 内存使用率  | 内存已使用量占用总量的百分比  | % | resourceId |

## 对象 {#object}

采集到的腾讯云 **postgresql** 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_postgresql",
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

> 提示 1：本脚本的代码运行依赖 PostgreSQL 实例对象采集，如果未配置 PostgreSQL 的自定义对象采集，慢日志脚本无法采集到慢日志数据


#### 安装日志采集脚本

在之前的基础上，需要再安装一个对应 **PostgreSQL 慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「{{{ custom_key.brand_name }}}集成（腾讯云-PostgreSQL慢查询日志采集）  」(ID：`guance_tencentcloud_postgresql_slowlog`)

数据正常同步后，可以在{{{ custom_key.brand_name }}}的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_postgre_slowlog",
  "tags": {
      "AppId": "137185",
      "ClientAddr": "",
      "DBCharset": "UTF8",
      "DBEngine": "postgresql",
      "DBEngineConfig": "",
      "DBInstanceClass": "cdb.pg.ts1.2g",
      "DBInstanceId": "postgres-3coh1xgm",
      "DBInstanceName": "Unnamed",
      "DBInstanceStatus": "running",
      "DBInstanceType": "primary",
      "DBInstanceVersion": "standard",
      "DBVersion": "10.17",
      "DatabaseName": "postgres",
      "PayType": "postpaid",
      "ProjectId": "0",
      "Region": "ap-shanghai",
      "RegionId": "ap-shanghai",
      "SubnetId": "subnet-bp2jqhcj",
      "Type": "TS85",
      "Uid": "4147",
      "UserName": "postgres",
      "VpcId": "vpc-kcpy",
      "Zone": "ap-shanghai-2",
      "name": "postgres-3coh1xgm"
  },
  "fields": {
      "NormalQuery": "select $1 from information_schema.tables where table_schema = $2 and table_name = $3",
      "AvgCostTime" : "101.013005",
      "CostTime"    : "101.013025",
      "FirstTime"   : "2021-07-27 03:12:01",
      "LastTime"    : "2021-07-27 03:12:01",
      "MaxCostTime" : "101.828125",
      "MinCostTime" : "101.828125",
      "message"     : "{慢查询 JSON 数据}"
  }
}


```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
> 提示 1：`tags`值由自定义对象补充
> 提示 2：`fields.message`为 JSON 序列化后字符串

### 附录

#### TencentCloud-PostgreSQL「地域」

请参考 Tencent 官方文档：

- [TencentCloud-MongoDB 地域 ID](https://cloud.tencent.com/document/api/409/16764)


#### TencentCloud-PostgreSQL「慢日志信息说明文档」
请参考 Tencent 官方文档：

- [TencentCloud-PostgreSQL 慢日志详细信息说明文档](https://cloud.tencent.com/document/api/409/60541)

