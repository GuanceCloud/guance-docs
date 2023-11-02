---
title: 'HUAWEI GaussDB-Redis'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/huawei_gaussdb_redis'
dashboard:

  - desc: 'HUAWEI CLOUD GaussDB for Redis Dashboard'
    path: 'dashboard/zh/huawei_gaussdb_redis'

monitor:
  - desc: 'HUAWEI CLOUD GaussDB for Redis Monitor'
    path: 'monitor/zh/huawei_gaussdb_redis'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD GaussDB-Redis
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automate)」: All preconditions are installed automatically, Please continue with the script installation.

If you deploy Func yourself, Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD GaussDB-Redis cloud resources, we install the corresponding collection script：「Guance Integration (HUAWEI CLOUD-GaussDB-Redis Collection)」(ID：`guance_huaweicloud_gaussdb_redis`)


Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】, The system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

After the script is installed, Find the script in「Development」in Func「Guance Integration (HUAWEI CLOUD-GaussDB-Redis Collection)」,Expand to modify this script, find `collector_configs`and`monitor_configs`Edit the content in`region_projects`, Change the locale and Project ID to the actual locale and Project ID, Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. tap【Run】, It can be executed immediately once, without waiting for a periodic time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/redisug-nosql/nosql_10_0036.html){:target="_blank"}

| metric name | description | unit | dimension |
| :---: | :---: | :---: | :---: |
| `nosql001_cpu_usage` | CPU utilization | % | redis_node_id |
| `nosql002_mem_usage` | memory utilization | % | redis_node_id |
| `nosql005_disk_usage` | Disk utilization | % | redis_node_id |
| `nosql006_disk_total_size` | Total Disk Capacity | GB | redis_node_id |
| `nosql007_disk_used_size` | Disk usage | GB | redis_node_id |
| `redis017_proxy_accept` | Total number of clients received by proxy | count | redis_node_id |
| `redis018_proxy_request_ps` | The rate at which the proxy receives requests | counts/s | redis_node_id |
| `redis019_proxy_response_ps` | Return request rate of the proxy | count/s | redis_node_id |
| `redis020_proxy_recv_client_bps` | The rate at which the proxy receives client byte streams | bytes/s | redis_node_id |
| `redis021_proxy_send_client_bps` | The rate at which the proxy sends a stream of bytes to the client. | bytes/s | redis_node_id |
| `redis032_shard_qps` | shard's qps | count | redis_node_id |
| `Invocationredis064_get_avg_usecs` | Average latency of the proxy command "get". | μs | redis_node_id |
| `redis065_get_max_usec` | Maximum delay for the proxy to execute the command "get". | μs | redis_node_id |
| `redis066_get_p99` | The p99 latency of the proxy command "get". | μs | redis_node_id |
| `redis067_get_qps` | The rate at which proxy executes the command "get". | count/s | redis_node_id |
| `redis316_all_avg_usec` | Average latency of all commands executed by proxy | μs | redis_node_id |
| `redis317_all_max_usec` | Maximum delay for proxy to execute all commands | μs | redis_node_id |
| `redis318_all_p99` | p99 latency for proxy to execute all commands | μs | redis_node_id |
| `redis319_all_qps` | The rate at which proxy executes all commands | count/s | redis_node_id |
| `redis669_connection_usage` | Connection utilization | % | redis_node_id |
| `redis670_hit_rate` | hit rate | % | redis_node_id |


## Object {#object}

The collected HUAWEI CLOUD GaussDB-Redis  object data structure can see the object data from 「Infrastructure - Customization」


``` json
{
  "measurement": "huaweicloud_gaussdb",
  "tags": {
    "RegionId"                : "cn-north-4",
    "db_user_name"            : "root",
    "name"                    : "2e10f990e139xxxxxx5fac6b59de7eein07",
    "port"                    : "3306",
    "project_id"              : "c631f046252d4xxxxxxx5f253c62d48585",
    "status"                  : "BUILD",
    "type"                    : "Cluster",
    "instance_id"             : "1236a915462940xxxxxx879882200in02",
    "instance_name"           : "xxxxx-efa7"
  },
  "fields": {
    "charge_info"          : "{Accounting type information, including on demand and packet cycle}",
    "flavor_info"          : "{Specification information}",
    "volume"               : "{volume information}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "public_ips"           : "[\"192.168.0.223\"]",
    "nodes"                : "[]",
    "message"              : "{Instance JSON data}",
    "time_zone"            : "UTC+08:00"
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




