---
title: 'Tencent Cloud TDSQL_C_MySQL'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install the **TDSQL_C_MySQL** Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of **TDSQL_C_MySQL**, install the corresponding collection script: "Guance Integration (Tencent Cloud-TDSQL_C_MySQL Collection)" (ID: `guance_tencentcloud_tdsql_c_mysql`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script package and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

By default, we collect some configurations, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"} for details.


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitoring Metrics

| Metric Name      | Description             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `BytesSent` | Bytes Sent Per Second     | Bytes sent to client per second  | MB/s   | InstanceId |
| `BytesReceived` | Bytes Received Per Second  | Bytes received from client per second   | MB/s | InstanceId |
| `ComDelete` | Delete Count  | Number of delete operations  | ops/sec | InstanceId |
| `ComInsert` | Insert Count  | Number of insert operations  | ops/sec | InstanceId |
| `ComUpdate` | Update Count  | Number of update operations  | ops/sec | InstanceId |
| `MemoryUse` | Memory Usage   | Memory usage  | ops/sec | InstanceId |
| `ComSelect` | Query Count   | Number of queries  | ops/sec | InstanceId |
| `MaxConnections` | Maximum Connections  | Maximum number of connections  | ops/sec | InstanceId |
| `SlowQueries` | Slow Query Count | Number of slow queries    | ops/sec | InstanceId |
| `ThreadsRunning` | Running Threads | Number of running threads  | ops/sec | InstanceId |
| `Memoryuserate` | Memory Usage Rate   | Memory usage rate | % | InstanceId |
| `Storageuserate` | Storage Usage Rate | Storage usage rate  | % | InstanceId |
| `Storageuse` | Storage Usage  | Storage usage | GB | InstanceId |
| `Connectionuserate` | Connection Utilization Rate  | Connection utilization rate  | % | InstanceId |
| `Tps` | Transactions Per Second | Average number of transactions successfully executed per second (including rollbacks and commits)  | ops/sec | InstanceId |
| `Cpuuserate` | CPU Usage Rate  | CPU usage rate  | % | InstanceId |
| `Qps` | Queries Per Second  | Number of queries executed per second  | ops/sec | InstanceId |
| `Queries` | Total Queries  | Total number of queries within a statistical period  | ops/sec | InstanceId |


## Objects {#object}

The structure of collected Tencent Cloud **tdsql_c_mysql** object data can be viewed in "Infrastructure - Custom"

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
