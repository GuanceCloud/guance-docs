---
title: '华为云 GaussDB-Cassandra'
summary: 'Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_gaussdb_cassandra'
dashboard:

  - desc: '华为云 GaussDB-Cassandra 内置视图'
    path: 'dashboard/zh/huawei_gaussdb_cassandra'

monitor:
  - desc: '华为云 GaussDB-Cassandra 监控器'
    path: 'monitor/zh/huawei_gaussdb_cassandra'

---


<!-- markdownlint-disable MD025 -->
# Huawei GaussDB-Cassandra
<!-- markdownlint-enable -->

Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.

## ConfiG {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automate)」: All preconditions are installed automatically, Please continue with the script installation.

If you deploy Func yourself, Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare Huawei AK that meets the requirements in advance（For simplicity's sake, You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  Huawei GaussDB-Cassandra cloud resources, we install the corresponding collection script：「观测云集成（华为云-GaussDB-Cassandra采集）」(ID：`guance_huaweicloud_gaussdb_cassandra`)

Click 【Install】 and enter the corresponding parameters: Huawei AK, Huawei account name.

tap【Deploy startup Script】, The system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

After the script is installed, Find the script in「Development」in Func「观测云集成（华为云-GaussDB-Cassandra采集）」, Expand to modify this script, find `collector_configs`and`monitor_configs`Edit the content in`region_projects`, Change the locale and Project ID to the actual locale and Project ID, Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. tap【Run】, It can be executed immediately once, without waiting for a periodic time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Huawei Cloud - cloud monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Huawei CloudMonitor Metrics Details](https://support.huaweicloud.com/cassandraug-nosql/nosql_03_0011.html){:target="_blank"}

| **Metric ID**                 | Metric Name               | **Description**                                           | Value Range | Monitored Object                  | Monitoring Period (Raw Data) |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `cassandra001_cpu_usage`       | CPU利用率      | 该指标为从系统层面采集的CPU使用率。 单位：%                  | 0~100 %  | GaussDB(for Cassandra)实例的节点 | 1分钟                                             |
| `cassandra002_mem_usage`       | 内存利用率     | 该指标为从系统层面采集的内存使用率。 单位：%                 | 0~100 %  | GaussDB(for Cassandra)实例的节点 | 1分钟                |
| `cassandra003_bytes_out`       | 网络输出吞吐量 | 统计平均每秒从测量对象的所有网络适配器输出的流量。单位：kb/s | ≥ 0 kb/s | GaussDB(for Cassandra)实例的节点 | 1分钟                |
| `cassandra004_bytes_in`    | 网络输入吞吐量 | 统计平均每秒从测量对象的所有网络适配器输入的流量。 单位：kb/s | ≥ 0 kb/s | GaussDB(for Cassandra)实例的节点 | 1分钟                |
| `nosql005_disk_usage`      | 磁盘利用率     | 该指标用于统计测量对象的磁盘利用率。 单位：%                 | 0~100 %  | GaussDB(for Cassandra)实例的节点 | 1分钟                |
| `nosql006_disk_total_size` | 磁盘总大小     | 该指标用于统计测量对象的磁盘总大小。 单位：GB                | ≥ 0 GB   | GaussDB(for Cassandra)实例的节点 | 1分钟                |
| `nosql007_disk_used_size`  | 磁盘使用量     | 该指标用于统计测量对象的磁盘已使用总大小。 单位：GB          | ≥ 0 GB   | GaussDB(for Cassandra)实例的节点 | 1分钟                |
| `cassandra014_connections` | 活动连接数 | 该指标用于统计当前Cassandra实例节点的活动连接数。 单位：Counts | ≥ 0 Counts | GaussDB(for Cassandra)实例的节点 | 1分钟 |
| `cassandra015_read_latency` | 每秒查询请求 | 该指标用于统计数据库读请求的平均耗时。 单位：ms | ≥ 0 ms | GaussDB(for Cassandra)实例的节点 | 1分钟 |
| `cassandra016_write_latency` | 每秒写入请求 | 该指标用于统计数据库写请求的平均耗时。 单位：ms | ≥ 0 ms | GaussDB(for Cassandra)实例的节点 | 1分钟 |
| `cassandra037_pending_write` | 挂起的写任务数 | 描述当前排队等待的写任务数。 单位：Counts | ≥ 0 Counts | GaussDB(for Cassandra)实例的节点 | 1分钟 |
| `cassandra038_pending_read` | 挂起的读任务数 | 描述当前排队等待的读任务数。 单位：Counts | ≥ 0 Counts | GaussDB(for Cassandra)实例的节点 | 1分钟 |

## Object {#object}

The collected Huawei Cloud GaussDB-Cassandra  object data structure can see the object data from 「基础设施-自定义」

``` json
{
  "measurement": "huaweicloud_gaussdb_nosql",
  "tags": {
    "RegionId"          : "cn-north-4",
    "db_user_name"      : "rwuser",
    "engine"            : "rocksDB",
    "instance_id"       : "1236a915462940xxxxxx879882200in02",
    "instance_name"     : "nosql-efa7",
    "name"              : "1236a915462940xxxxxx879882200in02",
    "pay_mode"          : "0",
    "port"              : "8635",
    "project_id"        : "15c6ce1c12dxxxx0xxxx2076643ac2b9",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "status"            : "normal",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961"
  },
  "fields": {
    "actions"         : "[]",
    "create_time"     : "2023-08-01T14:17:40+0800",
    "update_time"     : "2023-08-01T14:17:42+0800",
    "backup_strategy" : "{实例 JSON 数据}",
    "datastore"       : "{实例 JSON 数据}",
    "groups"          : "[{实例 JSON 数据}]",
    "time_zone"       : "",
    "message"         : "{实例 JSON 数据}"
  }
}

```


> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：The following fields are JSON serialized strings
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`



