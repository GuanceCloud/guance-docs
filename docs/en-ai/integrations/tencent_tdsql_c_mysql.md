---
title: 'Tencent Cloud TDSQL_C_MySQL'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the hosted version of Guance integration - extension - Func: all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install the **TDSQL_C_MySQL** Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize **TDSQL_C_MySQL** monitoring data, install the corresponding collection script: "Guance Integration (Tencent Cloud-TDSQL_C_MySQL Collection)" (ID: `guance_tencentcloud_tdsql_c_mysql`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, also enable the log collection script. If you need to collect billing information, enable the cloud billing collection script.

By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, go to 「Infrastructure / Custom」to check if there is asset information.
3. On the Guance platform, go to 「Metrics」to check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics by configuring [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitoring Metrics

| English Name      | Chinese Name             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `BytesSent` | Client traffic sent per second     | Client traffic sent per second  | MB/s   | InstanceId |
| `BytesReceived` | Client traffic received per second  | Client traffic received per second   | MB/s | InstanceId |
| `ComDelete` | Number of deletes  | Number of deletes  | per second | InstanceId |
| `ComInsert` | Number of inserts  | Number of inserts  | per second | InstanceId |
| `ComUpdate` | Number of updates  | Number of updates  | per second | InstanceId |
| `MemoryUse` | Memory usage   | Memory usage  | times/second | InstanceId |
| `ComSelect` | Number of queries   | Number of queries  | per second | InstanceId |
| `MaxConnections` | Maximum connections  | Maximum connections  | per second | InstanceId |
| `SlowQueries` | Number of slow queries | Number of slow queries    | per second | InstanceId |
| `ThreadsRunning` | Number of running threads | Number of running threads  | per second | InstanceId |
| `Memoryuserate` | Memory usage rate   | Memory usage rate | % | InstanceId |
| `Storageuserate` | Storage usage rate | Storage usage rate  | % | InstanceId |
| `Storageuse` | Storage usage  | Storage usage | GB | InstanceId |
| `Connectionuserate` | Connection utilization rate  | Connection utilization rate  | % | InstanceId |
| `Tps` | Transactions per second | Average number of successfully executed transactions per second (including rollbacks and commits)  | times/second | InstanceId |
| `Cpuuserate` | CPU usage rate  | CPU usage rate  | % | InstanceId |
| `Qps` | Operations executed per second  | Operations executed per second  | times/second | InstanceId |
| `Queries` | Total number of requests  | Total number of requests within a statistical period  | per second | InstanceId |


## Objects {#object}

The collected Tencent Cloud **tdsql_c_mysql** object data structure can be viewed in 「Infrastructure - Custom」

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
    "RelatedInstance"  : "{instance JSON data}",
    "ReplicaSets"      : "{instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{instance JSON data}",
  }
}
```