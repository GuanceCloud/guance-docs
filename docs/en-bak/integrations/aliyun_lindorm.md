---
title: 'Aliyun Lindorm'
tags: 
  - Alibaba Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.' 
__int_icon: 'icon/aliyun_lindorm'
dashboard:
  - desc: 'Aliyun Lindorm Monitoring View'
    path: 'dashboard/zh/aliyun_lindorm/'

monitor:
  - desc: 'Aliyun Lindorm Monitor'
    path: 'monitor/zh/aliyun_lindorm/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun **Lindorm**
<!-- markdownlint-enable -->


Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance。


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **Lindorm** cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -**Lindorm** Collect）」(ID：`guance_aliyun_lindorm`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric  {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Alibaba Cloud Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_lindorm/lindorm){:target="_blank"}

| MetricName | MetricDescribe           | Dimensions | Statistics | Unit | MinPeriods |
| ---- | :---:    | :----: | ------ | ------ | :----: |
| `load_one`                   | load_one | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `load_five`                  |           load_five            | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `cpu_system`                 | cpu_system | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_user`                   | cpu_user | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_idle`                   | cpu_idle    | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_wio`                    | cpu_wio | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_total`                  | mem_total | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_used_percent`           | mem_used_percent | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_free`                   | mem_free | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_buff_cache`             | mem_buff_cache | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_shared`                 | mem_shared | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `bytes_in`                   | bytes_in | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `bytes_out`                  | bytes_out | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `storage_used_percent`       | storage_used_percent | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `storage_used_bytes`         |       storage_used_bytes       | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `storage_total_bytes`        |      storage_total_bytes       | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `hot_storage_used_percent`   |    hot_storage_used_percent    | userId,instanceId,host | Average,Maximum         | %       |    60 s    |
| `hot_storage_used_bytes`     |     hot_storage_used_bytes     | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `hot_storage_total_bytes`    |    hot_storage_total_bytes     | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `cold_storage_used_percent`  |   cold_storage_used_percent    | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cold_storage_used_bytes`    |    cold_storage_used_bytes     | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_total_bytes`   |    cold_storage_total_bytes    | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_token_percent` |   cold_storage_token_percent   | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `store_locality`             |         store_locality         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `disk_readbytes`             |         **disk_readbytes**         | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `disk_writebytes` |        **disk_writebytes**         | userId,instanceId,host | Average,Maximum,Minimum | bytes/s | 60 s |
| `table_cold_storage_used_bytes` | table_cold_storage_used_bytes  | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `table_hot_storage_used_bytes` |  table_hot_storage_used_bytes  | userId,instanceId,host | Average,Maximum,Minimum | Byte | 60 s |
| `read_ops` |            read_ops            | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `read_rt` |            read_rt             | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `read_data_kb` |          read_data_kb          | userId,instanceId,host | Average,Maximum,Minimum | KB/s | 60 s |
| `get_num_ops` |          get_num_ops           | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `get_rt_avg` |           get_rt_avg           | userId,instanceId,host | Average,Maximum,Minimum | **milliseconds** | 60 s |
| `get_rt_p99` |           get_rt_p99           | userId,instanceId,host | Average,Maximum,Minimum | **millseconds** | 60 s |
| `scan_num_ops` |          scan_num_ops          | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `scan_rt_avg` | scan_rt_avg | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_rt_p99` | scan_rt_p99 | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `thrift_call_num_ops` |      thrift_call_num_ops       | userId,instanceId | Average | count | 60 s |
| `thrift_call_mean` | thrift_call_mean | userId,instanceId | Average | milliseconds | 60 s |
| `thrift_call_time_in_queue_ops` | thrift_call_time_in_queue_ops  | userId,instanceId | Average | count | 60 s |
| `thrift_call_time_in_queue` |   thrift_call_time_in_queue    | userId,instanceId | Average | ms | 60 s |
| `write_ops` |           write_ops            | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `write_rt` |            write_rt            | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `write_data_kb` |         write_data_kb          | userId,instanceId,host | Average,Maximum,Minimum | KB/s | 60 s |
| `put_num_ops` |          put_num_ops           | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `put_rt_avg` |           put_rt_avg           | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `put_rt_p99` |           put_rt_p99           | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `above_memstore_count` |      above_memstore_count      | userId,instanceId,host | Average,Maximum,Minimum | frequency | 60 s |
| `lql_connection` |         lql_connection         | userId,instanceId,host | Average,Maximum | count | 60 s |
| `lql_select_ops` | lql_select_ops | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_upsert_avg_rt` |       lql_upsert_avg_rt        | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_upsert_ops` |         lql_upsert_ops         | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_select_p99_rt` |       lql_select_p99_rt        | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_select_avg_rt` |       lql_select_avg_rt        | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_upsert_p99_rt` | lql_upsert_p99_rt | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_delete_ops` |         lql_delete_ops         | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_delete_avg_rt` |       lql_delete_avg_rt        | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_delete_p99_rt` |       lql_delete_p99_rt        | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `regions_per_ldserver` |      **regions_per_ldserver**      | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `handler_queue_size` |       handler_queue_size       | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `compaction_queue_size` |     compaction_queue_size      | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `tsdb_jvm_used_percent` |     tsdb_jvm_used_percent      | userId,instanceId,host | Average,Maximum,Minimum | % | 60 s |
| `tsdb_disk_used` |         tsdb_disk_used         | userId,instanceId,host | Average,Maximum,Minimum | **Gbyte** | 60 s |
| `tsdb_hot_storage_used_bytes` |  tsdb_hot_storage_used_bytes   | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_cold_storage_used_bytes` |  tsdb_cold_storage_used_bytes  | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_datapoints_added` |     tsdb_datapoints_added      | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_cold_storage_used_bytes` | search_cold_storage_used_bytes | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_hot_storage_used_bytes` | search_hot_storage_used_bytes  | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_select_count` |      search_select_count       | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_select_meanRate` |     search_select_meanRate     | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_select_mean_rt` |     search_select_mean_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p95_rt` |      search_select_p95_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p999_rt` |     search_select_p999_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p99_rt` |      search_select_p99_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_count` |      search_update_count       | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_update_meanRate` |     search_update_meanRate     | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_update_mean_rt` |     search_update_mean_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p95_rt` |      search_update_p95_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p99_rt` |      search_update_p99_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p999_rt` |     search_update_p999_rt      | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `worker_count` |          worker_count          | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `failed_job_count` |        failed_job_count        | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `warn_job_count` |         warn_job_count         | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `task_delay_max` |         task_delay_max         | userId,instanceId,host | Average,Maximum,Minimum | ms | 60 s |

## Object  {#object}
The collected Alibaba Cloud **Lindorm** object data structure can see the object data from 「Infrastructure-Custom」

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
    "message"         : "{Instance JSON data}"
  }
}
```

>
> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：`fields.message` is JSON serialized strings
