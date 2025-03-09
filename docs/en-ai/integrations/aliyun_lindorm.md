---
title: 'Alibaba Cloud Lindorm'
tags: 
  - Alibaba Cloud
summary: 'Use the cloud synchronization script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/aliyun_lindorm'
dashboard:
  - desc: 'Alibaba Cloud Lindorm built-in views'
    path: 'dashboard/en/aliyun_lindorm/'

monitor:
  - desc: 'Alibaba Cloud Lindorm monitor'
    path: 'monitor/en/aliyun_lindorm/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud `Lindorm`
<!-- markdownlint-enable -->


Use the cloud synchronization script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize **Lindorm** cloud resource monitoring data, install the corresponding collection script: 「Guance Integration (Alibaba Cloud-**Lindorm** Collection)」(ID: `guance_aliyun_lindorm`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations; see the Metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the automatic trigger configuration and check the task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud cloud monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud cloud monitoring metrics details](https://cms.console.aliyun.com/metric-meta/acs_lindorm/lindorm){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the Aliyun `Lindorm` console

| MetricName | MetricDescription           | Dimensions | Statistics | Unit | MinPeriods |
| ---- | :---:    | :----: | ------ | ------ | :----: |
| `load_one`                   | Average load over 5 minutes      | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `load_five`                  | Average load over 5 minutes      | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `cpu_system`                 | CPU utilization System      | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_user`                   | CPU utilization User        | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_idle`                   | CPU idle rate            | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_wio`                    | CPU utilization IOWait      | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_total`                  | Total memory (total)      | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_used_percent`           | Memory usage ratio         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_free`                   | Free memory size (free)   | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_buff_cache`             | Cache size (buff/cache) | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_shared`                 | Shared memory size (shared) | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `bytes_in`                   | Network input per second       | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `bytes_out`                  | Network output per second       | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `storage_used_percent`       | Storage space usage ratio     | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `storage_used_bytes`         | Storage space usage       | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `storage_total_bytes`        | Total storage space         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `hot_storage_used_percent`   | Hot storage usage ratio       | userId,instanceId,host | Average,Maximum         | %       |    60 s    |
| `hot_storage_used_bytes`     | Hot storage usage         | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `hot_storage_total_bytes`    | Total hot storage capacity         | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `cold_storage_used_percent`  | Cold storage usage percentage     | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cold_storage_used_bytes`    | Cold storage usage         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_total_bytes`   | Total cold storage capacity         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_token_percent` | Cold storage read token usage ratio   | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `store_locality`             | Storage locality rate         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `disk_readbytes`             | Disk read traffic           | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `disk_writebytes`            | Disk write traffic          | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `table_cold_storage_used_bytes` | Wide table cold storage usage | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `table_hot_storage_used_bytes` | Wide table hot storage usage | userId,instanceId,host | Average,Maximum,Minimum | Byte    |    60 s    |
| `read_ops`                   | Read request count          | userId,instanceId,host | Average,Maximum,Minimum | countS  |    60 s    |
| `read_rt`                    | Average read RT             | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `read_data_kb`               | Read throughput             | userId,instanceId,host | Average,Maximum,Minimum | KB/s    |    60 s    |
| `get_num_ops`                | Get request count           | userId,instanceId,host | Average,Maximum,Minimum | countS  |    60 s    |
| `get_rt_avg`                 | Average Get RT              | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `get_rt_p99`                 | P99 delay for Get operation | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_num_ops`               | Scan request count          | userId,instanceId,host | Average,Maximum,Minimum | countS  |    60 s    |
| `scan_rt_avg`                | Average Scan delay          | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_rt_p99`                | P99 delay for Scan          | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `thrift_call_num_ops`        | Thrift request count        | userId,instanceId      | Average                 | count   |    60 s    |
| `thrift_call_mean`           | Average Thrift request duration | userId,instanceId     | Average                 | milliseconds | 60 s |
| `thrift_call_time_in_queue_ops` | Number of Thrift requests in queue | userId,instanceId     | Average                 | count   |    60 s    |
| `thrift_call_time_in_queue`  | Duration of Thrift requests in queue | userId,instanceId     | Average                 | ms      |    60 s    |
| `write_ops`                  | Write request count         | userId,instanceId,host | Average,Maximum,Minimum | countS  |    60 s    |
| `write_rt`                   | Average write RT            | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `write_data_kb`              | Write throughput            | userId,instanceId,host | Average,Maximum,Minimum | KB/s    |    60 s    |
| `put_num_ops`                | Put request count           | userId,instanceId,host | Average,Maximum,Minimum | countS  |    60 s    |
| `put_rt_avg`                 | Average Put RT              | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `put_rt_p99`                 | P99 delay for Put operation | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `above_memstore_count`       | Number of times exceeding `memstore` limit | userId,instanceId,host | Average,Maximum,Minimum | frequency | 60 s |
| `lql_connection`             | `SQL` connection count      | userId,instanceId,host | Average,Maximum         | count   |    60 s    |
| `lql_select_ops`             | Select request count        | userId,instanceId,host | Average,Maximum         | countSecond | 60 s |
| `lql_upsert_avg_rt`          | Average `upsert` request duration | userId,instanceId,host | Average,Maximum         | milliseconds | 60 s |
| `lql_upsert_ops`             | `upsert` request count      | userId,instanceId,host | Average,Maximum         | countSecond | 60 s |
| `lql_select_p99_rt`          | P99 duration for select     | userId,instanceId,host | Average,Maximum         | milliseconds | 60 s |
| `lql_select_avg_rt`          | Average select request duration | userId,instanceId,host | Average,Maximum         | milliseconds | 60 s |
| `lql_upsert_p99_rt`          | P99 duration for `upsert`   | userId,instanceId,host | Average,Maximum         | milliseconds | 60 s |
| `lql_delete_ops`             | Delete request count        | userId,instanceId,host | Average,Maximum         | countSecond | 60 s |
| `lql_delete_avg_rt`          | Average delete request duration | userId,instanceId,host | Average,Maximum         | milliseconds | 60 s |
| `lql_delete_p99_rt`          | P99 duration for delete     | userId,instanceId,host | Average,Maximum         | milliseconds | 60 s |
| `regions_per_ldserver`       | Number of regions managed by RegionServer | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `handler_queue_size`         | HandlerQueue length         | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `compaction_queue_size`      | Compaction queue length     | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `tsdb_jvm_used_percent`      | JVM memory usage rate       | userId,instanceId,host | Average,Maximum,Minimum | % | 60 s |
| `tsdb_disk_used`             | Disk usage                  | userId,instanceId,host | Average,Maximum,Minimum | `Gbyte` | 60 s |
| `tsdb_hot_storage_used_bytes`| Hot storage usage for TSDB  | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_cold_storage_used_bytes`| Cold storage usage for TSDB | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_datapoints_added`      | Number of data points       | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_cold_storage_used_bytes` | Cold storage usage for search | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_hot_storage_used_bytes` | Hot storage usage for search | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_select_count`        | Total number of select operations | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_select_meanRate`     | Average select ops          | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_select_mean_rt`      | Average select RT           | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p95_rt`       | P95 select RT               | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p999_rt`      | P999 select RT              | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p99_rt`       | P99 select RT               | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_count`        | Total number of update operations | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_update_meanRate`     | Average update ops          | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_update_mean_rt`      | Average update RT           | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p95_rt`       | P95 update RT               | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p99_rt`       | P99 update RT               | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p999_rt`      | P999 update RT              | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `worker_count`               | Number of worker nodes      | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `failed_job_count`           | Number of failed jobs       | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `warn_job_count`             | Number of warning jobs      | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `task_delay_max`             | Maximum task delay          | userId,instanceId,host | Average,Maximum,Minimum | ms | 60 s |
## Object {#object}
The collected Alibaba Cloud `Lindorm` object data structure can be viewed in 「Infrastructure - Custom」

``` json
{
  "measurement": "aliyun_lindorm",
  "tags": {
    "name"           : "r-bp12xxxxxxx",
    "InstanceId"     : "r-bp12xxxxxxx",
    "InstanceStatus" : "CREATING",
    "NetworkType"    : "vpc",
    "PayType"        : "POSTPAY",
    "RegionId"       : "cn-hangzhou",
    "ServiceType"    : "lindorm_standalone",
    "VpcId"          : "vpc-bp1pxxxxxx4t75e73v",
    "ZoneId"         : "cn-hangzhou-f",
    "account_name"   : "xxx account",
    "cloud_provider" : "aliyun"
  },
  "fields": {
    "CreateTime"      : "2023-07-14 10:54:05",
    "EnableStream"    : "False",
    "InstanceStorage" : "20",
    "message"         : "{JSON serialized instance data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Tip 2: `fields.message` is a JSON serialized string.
>
