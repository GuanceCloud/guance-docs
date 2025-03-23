---
title: 'Tencent Cloud TDSQL_C_MySQL'
tags: 
  - Tencent Cloud
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/tencent_tdsql_c_mysql'
dashboard:

  - desc: 'Tencent Cloud TDSQL_C_MySQL built-in views'
    path: 'dashboard/en/tencent_tdsql_c_mysql'

monitor:
  - desc: 'Tencent Cloud TDSQL_C_MySQL monitor'
    path: 'monitor/en/tencent_tdsql_c_mysql'


---
<!-- markdownlint-disable MD025 -->
# Tencent Cloud **TDSQL_C_MySQL**
<!-- markdownlint-enable -->

Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Deploy Func Yourself](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install the **TDSQL_C_MySQL** collection script

> Note: Please prepare a qualified Tencent Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of **TDSQL_C_MySQL**, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-TDSQL_C_MySQL Collection)" (ID: `guance_tencentcloud_tdsql_c_mysql`)

After clicking 【Install】, input the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the regular time. Wait for a moment, and you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect the bill, you need to enable the cloud bill collection script.

We default collect some configurations, for details, see the Metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric sets are as follows, more metrics can be collected through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitoring Metrics

| English Metric Name | Chinese Metric Name      | Meaning                          | Unit   | Dimension           |
| -------------------- | ------------------------- | -------------------------------- | ------ | ------------------- |
| `BytesSent`         | Bytes sent per second   | Bytes sent per second to client | MB/s   | InstanceId          |
| `BytesReceived`     | Bytes received per second| Bytes received per second from client | MB/s | InstanceId          |
| `ComDelete`         | Number of deletes       | Number of deletes               | Count/sec | InstanceId          |
| `ComInsert`         | Number of inserts       | Number of inserts               | Count/sec | InstanceId          |
| `ComUpdate`         | Number of updates       | Number of updates               | Count/sec | InstanceId          |
| `MemoryUse`         | Memory usage            | Memory usage                    | Times/sec | InstanceId          |
| `ComSelect`         | Number of queries       | Number of queries               | Count/sec | InstanceId          |
| `MaxConnections`    | Maximum connections     | Maximum number of connections   | Count/sec | InstanceId          |
| `SlowQueries`       | Slow query count        | Slow query count                | Count/sec | InstanceId          |
| `ThreadsRunning`    | Running threads         | Running threads                 | Count/sec | InstanceId          |
| `Memoryuserate`     | Memory usage rate       | Memory usage rate               | %        | InstanceId          |
| `Storageuserate`    | Storage usage rate      | Storage usage rate              | %        | InstanceId          |
| `Storageuse`        | Storage usage           | Storage usage                   | GB       | InstanceId          |
| `Connectionuserate`  | Connection utilization rate | Connection utilization rate      | %        | InstanceId          |
| `Tps`               | Transactions per second  | Average successful transactions per second (including rollbacks and commits) | Times/sec | InstanceId          |
| `Cpuuserate`        | CPU usage rate          | CPU usage rate                  | %        | InstanceId          |
| `Qps`               | Operations per second    | Operations executed per second   | Times/sec | InstanceId          |
| `Queries`           | Total requests          | Total requests in a statistical period | Count/sec | InstanceId          |


## Objects {#object}

The structure of the collected Tencent Cloud **tdsql_c_mysql** object data can be seen in "Infrastructure - Custom"

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
    "RelatedInstance"  : "{JSON instance data}",
    "ReplicaSets"      : "{JSON instance data}",
    "StandbyInstances" : "[]",
    "message"          : "{JSON instance data}",
  }
}
```