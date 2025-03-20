---
title: 'Alibaba Cloud Lindorm'
tags: 
  - Alibaba Cloud
summary: 'Use the script packages in the "Guance Cloud Sync" series from the script market to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/aliyun_lindorm'
dashboard:
  - desc: 'Alibaba Cloud Lindorm built-in views'
    path: 'dashboard/en/aliyun_lindorm/'

monitor:
  - desc: 'Alibaba Cloud Lindorm monitors'
    path: 'monitor/en/aliyun_lindorm/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud `Lindorm`
<!-- markdownlint-enable -->


Use the script packages in the "Guance Cloud Sync" series from the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize **Lindorm** cloud resources monitoring data, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-**Lindorm** Collection)" (ID: `guance_aliyun_lindorm`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you want to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing data, you need to enable the cloud billing collection script.


We default to collecting some configurations, see Metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_lindorm/lindorm){:target="_blank"}

> Note: You need to install the monitoring plugin in the Aliyun `Lindorm` console

| MetricName | MetricDescribe           | Dimensions | Statistics | Unit | MinPeriods |
| ---- | :---:    | :----: | ------ | ------ | :----: |
| `load_one`                   | Average load every 5 minutes      | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `load_five`                  | Average load every 5 minutes      | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `cpu_system`                 | CPU utilization System      | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_user`                   | CPU utilization User        | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_idle`                   | CPU idle rate            | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_wio`                    | CPU utilization IOWait      | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_total`                  | Total memory (total)      | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_used_percent`           | Memory usage ratio         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_free`                   | Free memory size (free)   | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_buff_cache`             | Cache size (buff/cache) | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_shared`                 | Shared memory size (shared) | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `bytes_in`                   | Network inflow per second       | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `bytes_out`                  | Network outflow per second       | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `storage_used_percent`       | Storage space usage ratio     | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `storage_used_bytes`         | Storage space usage amount       | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `storage_total_bytes`        | Total storage space         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `hot_storage_used_percent`   | Hot storage usage ratio       | userId,instanceId,host | Average,Maximum         | %       |    60 s    |
| `hot_storage_used_bytes`     | Hot storage usage amount         | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `hot_storage_total_bytes`    | Total hot storage capacity         | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `cold_storage_used_percent`  | Cold storage usage percentage     | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cold_storage_used_bytes`    | Cold storage usage amount         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_total_bytes`   | Total cold storage capacity         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_token_percent` | Cold storage read token usage ratio   | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `store_locality`             | Storage locality rate         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `disk_readbytes`             | Disk read traffic           | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `disk_writebytes` | Disk write traffic | userId,instanceId,host | Average,Maximum,Minimum | bytes/s | 60 s |
| `table_cold_storage_used_bytes` | Wide table cold storage usage amount | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `table_hot_storage_used_bytes` | Wide table hot storage usage amount | userId,instanceId,host | Average,Maximum,Minimum | Byte | 60 s |
| `read_ops` | Read request volume | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `read_rt` | Average read RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `read_data_kb` | Read traffic | userId,instanceId,host | Average,Maximum,Minimum | KB/s | 60 s |
| `get_num_ops` | Get request volume | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `get_rt_avg` | Average Get RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `get_rt_p99` | P99 delay for Get operations | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_num_ops` | Scan request volume | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `scan_rt_avg` | Average scan delay | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_rt_p99` | P99 scan delay | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `thrift_call_num_ops` | Thrift request volume | userId,instanceId | Average | count | 60 s |
| `thrift_call_mean` | Average thrift request duration | userId,instanceId | Average | milliseconds | 60 s |
| `thrift_call_time_in_queue_ops` | Number of Thrift requests waiting in queue | userId,instanceId | Average | count | 60 s |
| `thrift_call_time_in_queue` | Duration of Thrift requests waiting in queue | userId,instanceId | Average | ms | 60 s |
| `write_ops` | Write request volume | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `write_rt` | Average write RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `write_data_kb` | Write traffic | userId,instanceId,host | Average,Maximum,Minimum | KB/s | 60 s |
| `put_num_ops` | Put request volume | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `put_rt_avg` | Average Put RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `put_rt_p99` | P99 delay for Put operations | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `above_memstore_count` | Number of times exceeding `memstore` limit | userId,instanceId,host | Average,Maximum,Minimum | frequency | 60 s |
| `lql_connection` | `sql` connection count | userId,instanceId,host | Average,Maximum | count | 60 s |
| `lql_select_ops` | Select request count | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_upsert_avg_rt` | Average `upsert` request duration | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_upsert_ops` | `upsert` request count | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_select_p99_rt` | P99 select duration | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_select_avg_rt` | Average select request duration | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_upsert_p99_rt` | P99 `upsert` duration | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_delete_ops` | Delete request count | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_delete_avg_rt` | Average delete request duration | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_delete_p99_rt` | P99 delete duration | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `regions_per_ldserver` | Number of Regions managed by RegionServer | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `handler_queue_size` | HandlerQueue length | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `compaction_queue_size` | Compaction queue length | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `tsdb_jvm_used_percent` | JVM memory usage rate | userId,instanceId,host | Average,Maximum,Minimum | % | 60 s |
| `tsdb_disk_used` | Disk usage | userId,instanceId,host | Average,Maximum,Minimum | `Gbyte` | 60 s |
| `tsdb_hot_storage_used_bytes` | Time-series hot storage usage amount | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_cold_storage_used_bytes` | Time-series cold storage usage amount | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_datapoints_added` | Data point count | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_cold_storage_used_bytes` | Search cold storage usage amount | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_hot_storage_used_bytes` | Search hot storage usage amount | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_select_count` | Total select count | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_select_meanRate` | Average select ops | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_select_mean_rt` | Average select RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p95_rt` | P95 select RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p999_rt` | P999 select RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p99_rt` | P99 select RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_count` | Total update count | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_update_meanRate` | Average update ops | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_update_mean_rt` | Average update RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p95_rt` | P95 update RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p99_rt` | P99 update RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p999_rt` | P999 update RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `worker_count` | Worker node count | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `failed_job_count` | Failed job count | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `warn_job_count` | Warning job count | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `task_delay_max` | Maximum task delay | userId,instanceId,host | Average,Maximum,Minimum | ms | 60 s |
## Objects {#object}
The Alibaba Cloud `Lindorm` object data structure collected can be viewed in "Infrastructure - Custom"

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
    "account_name"   : "xxx Account",
    "cloud_provider" : "aliyun"
  },
  "fields": {
    "CreateTime"      : "2023-07-14 10:54:05",
    "EnableStream"    : "False",
    "InstanceStorage" : "20",
    "message"         : "{JSON instance data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Tip 2: `fields.message` is a JSON serialized string.
>
