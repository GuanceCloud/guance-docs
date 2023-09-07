---
title: 'Tencent Cloud TDSQL-C MySQL'
summary: 'Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_tdsql_c_mysql'
dashboard:

  - desc: '腾讯云 TDSQL-C MySQL 内置视图'
    path: 'dashboard/zh/tencent_tdsql_c_mysql'

monitor:
  - desc: '腾讯云 TDSQL-C MySQL 监控器'
    path: 'monitor/zh/tencent_tdsql_c_mysql'

---
<!-- markdownlint-disable MD025 -->
# Tencent Cloud TDSQL-C MySQL
<!-- markdownlint-enable -->

Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of TDSQL-C MySQL cloud resources, we install the corresponding collection script：「观测云集成（腾讯云-TDSQL-C MySQL采集）」(ID：`guance_tencentcloud_tdsql-c_mysql`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure Tencent Cloud COS monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### 监控指标

| Metric name      | 指标中文名             | Implication                        | Unit  | Dimensions              |
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

## Object {#object}

Collected Tencent Cloud TDSQL-C MySQL object data structure, you can see the object data from "Infrastructure - Customize".

```json
{
  "measurement": "tencentcloud_tdsql-c_mysql",
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
