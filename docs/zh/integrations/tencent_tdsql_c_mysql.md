---
title: '腾讯云 TDSQL_C_MySQL'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/tencent_tdsql_c_mysql'
dashboard:

  - desc: '腾讯云 TDSQL_C_MySQL 内置视图'
    path: 'dashboard/zh/tencent_tdsql_c_mysql'

monitor:
  - desc: '腾讯云 TDSQL_C_MySQL 监控器'
    path: 'monitor/zh/tencent_tdsql_c_mysql'


---
<!-- markdownlint-disable MD025 -->
# 腾讯云 **TDSQL_C_MySQL**
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装 **TDSQL_C_MySQL** 采集脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 **TDSQL_C_MySQL** 的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-TDSQL_C_MySQL采集）」(ID：`guance_tencentcloud_tdsql_c_mysql`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### 监控指标

| 指标英文名      | 指标中文名             | 含义                        | 单位  | 维度              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `BytesSent` | 每秒发送客户端流量     | 每秒发送客户端流量  | MB/s   | InstanceId |
| `BytesReceived` | 每秒接收客户端流量  | 每秒接收客户端流量   | MB/s | InstanceId |
| `ComDelete` | 删除数  | 删除数  | 个/秒 | InstanceId |
| `ComInsert` | 插入数  | 插入数  | 个/秒 | InstanceId |
| `ComUpdate` | 更新数  | 更新数  | 个/秒 | InstanceId |
| `MemoryUse` | 内存使用量   | 内存使用量  | 次/秒 | InstanceId |
| `ComSelect` | 查询数   | 查询数  | 个/秒 | InstanceId |
| `MaxConnections` | 最大连接数  | 最大连接数  | 个/秒 | InstanceId |
| `SlowQueries` | 慢查询数 | 慢查询数    | 个/秒 | InstanceId |
| `ThreadsRunning` | 运行的线程数 | 运行的线程数  | 个/秒 | InstanceId |
| `Memoryuserate` | 内存使用率   | 内存使用率 | % | InstanceId |
| `Storageuserate` | 存储使用率 | 存储使用率  | % | InstanceId |
| `Storageuse` | 存储使用量  | 存储使用量 | GB | InstanceId |
| `Connectionuserate` | 连接数利用率  | 连接数利用率  | % | InstanceId |
| `Tps` | 每秒事务数 | 平均每秒执行成功的事务数（包括回滚和提交）  | 次/秒 | InstanceId |
| `Cpuuserate` | CPU使用率  | CPU使用率  | % | InstanceId |
| `Qps` | 每秒执行操作数  | 每秒执行操作数  | 次/秒 | InstanceId |
| `Queries` | 总请求数  | 一个统计周期内的总请求数  | 个/秒 | InstanceId |


## 对象 {#object}

采集到的腾讯云 **tdsql_c_mysql** 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_tdsql_c_mysql",
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
