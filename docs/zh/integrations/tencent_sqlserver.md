---
title: '腾讯云 SQLServer'
tags: 
  - 腾讯云
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/tencent_sqlserver'
dashboard:

  - desc: '腾讯云 SQLServer 内置视图'
    path: 'dashboard/zh/tencent_sqlserver'

monitor:
  - desc: 'Tencent Cloud SQLServer 监控器'
    path: 'monitor/zh/tencent_sqlserver'
---

<!-- markdownlint-disable MD025 -->
# 腾讯云 SQLServer
<!-- markdownlint-enable -->

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装 SQLServer 采集脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 SQLServer 的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（腾讯云-SQL Server采集）」(ID：`guance_tencentcloud_sqlserver`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45146){:target="_blank"}

### 监控指标

| 指标英文名      | 指标中文名             | 含义                        | 单位  | 维度              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu`  | CPU 利用率     | 实例 CPU 消耗的百分比 | %    | resourceId |
| Transactions | 事务数       | 平均每秒的事务数                       | 次/秒 | resourceId |
| Connections | 连接数       | 平均每秒用户连接数据库的个数           | 个    | resourceId |
| Requests | 请求数       | 每秒请求次数                           | 次/秒 | resourceId |
| Logins | 登录次数     | 每秒登录次数                           | 次/秒 | resourceId |
| Logouts | 登出次数     | 每秒登出次数                           | 次/秒 | resourceId |
| Storage | 已用存储空间 | 实例数据库文件和日志文件占用的空间总和 | GB    | resourceId |
| InFlow | 输入流量     | 所有连接输入包大小总和                 | KB/s  | resourceId |
| OutFlow | 输出流量     | 所有连接输出包大小总和                 | KB/s  | resourceId |
| Iops         | 磁盘 IOPS    | 每秒磁盘读写次数                       | 次/秒 | resourceId |
| DiskReads    | 读取磁盘次数 | 每秒读取磁盘次数                       | 次/秒 | resourceId |
| DiskWrites   | 写入磁盘次数 | 每秒写入磁盘次数                       | 次/秒 | resourceId |
| ServerMemory | 内存占用     | 实际内存消耗量                         | MB    | resourceId |

### 性能优化指标

| 指标英文名      | 指标中文名             | 含义                        | 单位  | 维度              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| SlowQueries | 慢查询 | 运行时间超过1秒的查询数量 | 个 | resourceId |
| BlockedProcesses | 阻塞数 | 当前阻塞数量 | 个 | resourceId |
| LockRequests | 锁请求次数 | 平均每秒锁请求的次数 | 次/秒 | resourceId |
| UserErrors | 用户错误数 | 平均每秒错误数 | 次/秒 | resourceId |
| SqlCompilations | SQL 编译数 | 平均每秒 SQL 编译次数 | 次/秒 | resourceId |
| SqlRecompilations | SQL 重编译数 | 平均每秒 SQL 重编译次数 | 次/秒 | resourceId |
| FullScans | 每秒钟 SQL 做全表扫描数目 | 每秒不受限制的完全扫描数 | 次/秒 | resourceId |
| BufferCacheHitRatio | 缓冲区缓存命中率 | 数据缓存（内存）命中率 | % | resourceId |
| LatchWaits | 闩锁等待数量 | 每秒闩锁等待数量 | 次/秒 | resourceId |
| LockWaits | 平均锁等待延迟 | 每个导致等待的锁请求的平均等待时间 | Ms | resourceId |
| NetworkIoWaits | IO 延迟时间 | 平均网络 IO 延迟时间 | Ms | resourceId |
| PlanCacheHitRatio | 执行缓存缓存命中率 | 每个 SQL 有一个执行计划，执行计划的命中率 | % | resourceId |
| FreeStorage | 硬盘剩余容量 | 硬盘剩余容量百分比 | % | resourceId |

## 对象 {#object}

采集到的腾讯云 SQLServer 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_sqlserver",
  "tags": {
      "BackupCycleType": "daily",
      "CrossBackupEnabled": "disable",
      "InstanceId"      : "mssql-nmquc",
      "InstanceType"    : "SI",
      "Model"           : "2",
      "PayMode"         : "0",
      "Pid"             : "10036",
      "ProjectId"       : "0",
      "Region"          : "ap-shanghai",
      "RegionId"        : "ap-shanghai",
      "RenewFlag"       : "0",
      "Status"          : "2",
      "SubnetId"        : "68021",
      "Type"            : "CLOUD_BSSD",
      "Uid"             : "gamedb.sh1000.cdb.db",
      "UniqSubnetId"    : "subnet-b",
      "UniqVpcId"       : "vpc-xxxxx",
      "Version"         : "2016SP1",
      "VersionName"     : "SQL Server 2016 Enterprise",
      "Vip"             : "xxxxx",
      "VpcId"           : "80484",
      "Vport"           : "14",
      "Zone"            : "ap-shanghai-2",
      "ZoneId"          : "200002",
      "account_name"    : "腾讯云账号",
      "cloud_provider"  : "tencentcloud",
      "name"            : "mssql-nmqu"
    },
  "fields": {
      "Cpu"             : "2",
      "CreateTime"      : "2023-07-20 14:07:05",
      "EndTime"         : "0000-00-00 00:00:00",
      "IsolateTime"     : "0000-00-00 00:00:00",
      "Memory"          : "4",
      "StartTime"       : "2023-07-20 14:07:05",
      "Storage"         : "20",
      "UpdateTime"      : "2023-07-20 14:14:13",
      "UsedStorage"     : "0",
      "message"         : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
> 提示 1：`tags.name`值作为唯一识别
> 提示 2：`fields.message`、 `fields.InstanceNode` 为 JSON 序列化后字符串

### 附录

#### TencentCloud-SQLServer「地域和可用性」

请参考 Tencent 官方文档：

- [TencentCloud-SQLServer 地域列表](https://cloud.tencent.com/document/api/238/19930#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)
