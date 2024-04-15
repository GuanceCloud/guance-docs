---
title: 'Aliyun PolarDB PostgreSQL'
summary: 'Aliyun PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS (Input/Output Operations Per Second), TPS (Transactions Per Second), and data disk size.'
__int_icon: 'icon/aliyun_polardb_postgresql'
dashboard:
  - desc: 'Aliyun PolarDB PostgreSQL Monitoring View'
    path: 'dashboard/zh/aliyun_polardb_postgresql/'

monitor:
  - desc: 'Aliyun PolarDB PostgreSQL Monitor'
    path: 'monitor/zh/aliyun_polardb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun PolarDB PostgreSQL
<!-- markdownlint-enable -->

Aliyun PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS (Input/Output Operations Per Second), TPS (Transactions Per Second), and data disk size.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of PolarDB cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -PolarDBCollect）」(ID：`guance_aliyun_polardb`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in "Management / Crontab Config". Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs){:target="_blank"}

| Metric Id               | Metric Name       | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| pg_active_connections   | pg active connections     | userId,clusterId,instanceId | Average    | count     |
| pg_blks_read_delta      | pg data block reads   | userId,clusterId,instanceId | Average    | count     |
| pg_conn_usage           | pg connection usage rate     | userId,clusterId,instanceId | Average    | %         |
| pg_cpu_total            | pg CPU usage      | userId,clusterId,instanceId | Average    | %         |
| pg_db_age               | pg database maximum age | userId,clusterId,instanceId | Average    | **xids**      |
| pg_mem_usage            | pg memory usage rate     | userId,clusterId,instanceId | Average    | %         |
| pg_pls_data_size        | pg data disk size     | userId,clusterId,instanceId | Value      | **Mbyte**     |
| pg_pls_iops             | pg IOPS           | userId,clusterId,instanceId | Average    | frequency |
| pg_pls_iops_read        | pg read IOPS         | userId,clusterId,instanceId | Average    | frequency |
| pg_pls_iops_write       | pg write IOPS         | userId,clusterId,instanceId | Average    | frequency |
| pg_pls_pg_wal_dir_size  | pg WAL log size    | userId,clusterId,instanceId | Value      | **Mbyte**     |
| pg_pls_throughput       | pg IO throughput         | userId,clusterId,instanceId | Average    | **Mbyte/s**   |
| pg_pls_throughput_read  | pg read IO throughput       | userId,clusterId,instanceId | Average    | **Mbyte/s**   |
| pg_pls_throughput_write | pg write IO throughput       | userId,clusterId,instanceId | Average    | **Mbyte/s**   |
| pg_rollback_ratio       | pg transaction rollback rate     | userId,clusterId,instanceId | Average    | %         |
| pg_swell_time           | pg bloat point         | userId,clusterId,instanceId | Average    | s         |
| pg_tps                  | pg TPS            | userId,clusterId,instanceId | Average    | frequency |

## Object {#object}

The collected Aliyun PolarDB object data structure can be viewed in "Infrastructure - Custom" under the object data.

```json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "VpcId"               : "vpc-xxxx",
    "DBNodeNumber"        : "2",
    "PayType"             : "Postpaid",
    "DBType"              : "MySQL",
    "LockMode"            : "Unlock",
    "DBVersion"           : "8.0",
    "DBClusterId"         : "pc-xxxx",
    "DBClusterNetworkType": "VPC",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx",
    "DBNodeClass"         : "polar.mysql.x4.medium"
  },
  "fields": {
    "DBNodes"   : "{Node list JSON data}",
    "Database"  : "[Details of the data library JSON data]",
    "ExpireTime": "",
    "CreateTime": "2022-06-17T06:07:19Z",
    "message"   : "{Instance JSON data}"
  }
}

```
