---
title: 'Aliyun PolarDB Oracle'
tags: 
  - Alibaba Cloud
summary: 'Aliyun PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS (Input/Output Operations Per Second), TPS (Transactions Per Second), and data disk size.'
__int_icon: icon/aliyun_polardb_oracle
dashboard:
  - desc: 'Aliyun PolarDB Oracle Monitoring View'
    path: 'dashboard/en/aliyun_polardb_oracle/'

monitor:
  - desc: 'Aliyun PolarDB Oracle Monitor'
    path: 'monitor/en/aliyun_polardb_oracle/' 
---

<!-- markdownlint-disable MD025 -->
# Aliyun PolarDB Oracle
<!-- markdownlint-enable -->

Aliyun PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS (Input/Output Operations Per Second), TPS (Transactions Per Second), and data disk size.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of PolarDB Oracle cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -PolarDB Oracle Collect）」(ID：`guance_aliyun_polardb_oracle`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs){:target="_blank"}

| Metric Id            | Metric Name    | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| `active_connections`   | Active connections     | userId,clusterId,instanceId | Average    | count     |
| `blks_read_delta`      | data block reads   | userId,clusterId,instanceId | Average    | count     |
| `conn_usage`           | connection usage rate     | userId,clusterId,instanceId | Average    | %         |
| `cpu_total`            | CPU usage      | userId,clusterId,instanceId | Average    | %         |
| `db_age`               | Database maximum age | userId,clusterId,instanceId | Average    | **xids**      |
| `mem_usage`            | memory usage rate     | userId,clusterId,instanceId | Average    | %         |
| `pls_data_size`        | data disk size     | userId,clusterId,instanceId | Value      | **Mbyte**     |
| `pls_iops`             | IOPS           | userId,clusterId,instanceId | Average    | frequency |
| `pls_iops_read`        | read IOPS         | userId,clusterId,instanceId | Average    | frequency |
| `pls_iops_write`       | write IOPS         | userId,clusterId,instanceId | Average    | frequency |
| `pls_pg_wal_dir_size`  | WAL log size    | userId,clusterId,instanceId | Value      | **Mbyte**     |
| `pls_throughput`       | IO throughput         | userId,clusterId,instanceId | Average    | **Mbyte/s**   |
| `pls_throughput_read`  | read IO throughput       | userId,clusterId,instanceId | Average    | **Mbyte/s**   |
| `pls_throughput_write` | write IO throughput       | userId,clusterId,instanceId | Average    | **Mbyte/s**   |
| `rollback_ratio`       | transaction rollback rate     | userId,clusterId,instanceId | Average    | %         |
| `swell_time`           | bloat point         | userId,clusterId,instanceId | Average    | s         |
| `tps`                  | TPS            | userId,clusterId,instanceId | Average    | frequency |

## Object {#object}

The collected Aliyun PolarDB object data structure can be viewed in 「Infrastructure - Resource Catalog」 under the object data.

```json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "DBNodeNumber"        : "2",
    "DBType"              : "MySQL",
    "DBClusterId"         : "pc-xxxx",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx"
  },
  "fields": {
    "CreateTime"          : "2022-06-17T06:07:19Z",
    "DBClusterNetworkType": "VPC",
    "DBNodeClass"         : "polar.mysql.g1.tiny.c",
    "DBNodes"             : "{Node List JSON Data}",
    "DBVersion"           : "8.0",
    "Database"            : "[Database Details JSON Data]",
    "ExpireTime"          : "",
    "LockMode"            : "Unlock",
    "PayType"             : "Postpaid",
    "Tags"                : "{"Tag": []}",
    "VpcId"               : "vpc-bp16f7**********3p3",
    "message"             : "{Instance JSON data}"
  }
}

```
