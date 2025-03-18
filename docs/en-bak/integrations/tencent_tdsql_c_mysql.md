---
title: 'Tencent Cloud TDSQL-C MySQL'
tags: 
  - Tencent Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_tdsql_c_mysql'
dashboard:

  - desc: 'Tencent Cloud TDSQL-C MySQL Monitoring View'
    path: 'dashboard/zh/tencent_tdsql_c_mysql'

monitor:
  - desc: 'Tencent Cloud TDSQL-C MySQL Monitor'
    path: 'monitor/zh/tencent_tdsql_c_mysql'

---
<!-- markdownlint-disable MD025 -->
# Tencent Cloud **TDSQL-C** MySQL
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **TDSQL-C** MySQL cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud-**TDSQL-C** MySQLCollect）」(ID：`guance_tencentcloud_tdsql-c_mysql`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure Tencent Cloud COS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitor Metric
| Metric name      | Metric             | Implication                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `BytesSent` | Bytes sent per second     | Amount of data sent from the client per second  | MB/s   | InstanceId |
| `BytesReceived` | Bytes received per second  | Amount of data received by the client per second   | MB/s | InstanceId |
| `ComDelete` | Number of delete operations  | Number of delete operations per second  | Count/s | InstanceId |
| `ComInsert` | Number of insert operations  | Number of insert operations per second  | Count/s | InstanceId |
| `ComUpdate` | Number of update operations  | Number of update operations per second  | Count/s | InstanceId |
| `MemoryUse` | Memory usage   | Amount of memory used per second  | Count/s | InstanceId |
| `ComSelect` | Number of select operations   | Number of select operations per second  | Count/s | InstanceId |
| `MaxConnections` | Maximum number of connections  | Maximum number of connections per second  | Count/s | InstanceId |
| `SlowQueries` | Number of slow queries | Number of slow queries per second    | Count/s | InstanceId |
| `ThreadsRunning` | Number of running threads | Number of running threads per second  | Count/s | InstanceId |
| `Memoryuserate` | Memory usage rate   | Percentage of memory usage  | % | InstanceId |
| `Storageuserate` | Storage usage rate | Percentage of storage usage  | % | InstanceId |
| `Storageuse` | Storage usage  | Amount of storage used  | GB | InstanceId |
| `Connectionuserate` | Connection usage rate  | Percentage of connection usage  | % | InstanceId |
| `Tps` | Transactions per second | Average number of successful transactions executed per second (including rollbacks and commits)  | Count/s | InstanceId |
| `Cpuuserate` | CPU usage rate  | Percentage of CPU usage  | % | InstanceId |
| `Qps` | Queries per second  | Number of queries executed per second  | Count/s | InstanceId |
| `Queries` | Total number of queries  | Total number of queries within a statistical period  | Count/s | InstanceId |

## Object {#object}

Collected Tencent Cloud **TDSQL-C** MySQL object data structure, you can see the object data from "Infrastructure - Customize".

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
    "RelatedInstance"  : "{Instance JSON data}",
    "ReplicaSets"      : "{Instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{Instance JSON data}",
  }
}
```
