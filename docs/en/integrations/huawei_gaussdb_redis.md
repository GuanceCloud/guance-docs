---
title: 'Huawei Cloud GaussDB-Redis'
tags: 
  - Huawei Cloud
summary: 'The displayed Metrics for Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching.'
__int_icon: 'icon/huawei_gaussdb_redis'
dashboard:

  - desc: 'Huawei Cloud GaussDB for Redis built-in views'
    path: 'dashboard/en/huawei_gaussdb_redis'

monitor:
  - desc: 'Huawei Cloud GaussDB for Redis Monitor'
    path: 'monitor/en/huawei_gaussdb_redis'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Redis
<!-- markdownlint-enable -->

The displayed Metrics for Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for Huawei Cloud GaussDB-Redis, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Huawei Cloud-GaussDB-Redis Collection)" (ID: `guance_huaweicloud_gaussdb_redis`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "<<< custom_key.brand_name >>> Integration (Huawei Cloud-GaussDB-Redis Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs` respectively and edit the content of `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

We default to collecting some configurations, for more details see the Metrics section [Customize cloud object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/redisug-nosql/nosql_10_0036.html){:target="_blank"}

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| `nosql001_cpu_usage` | CPU utilization | % | redis_node_id |
| `nosql002_mem_usage` | Memory utilization | % | redis_node_id |
| `nosql005_disk_usage` | Disk utilization | % | redis_node_id |
| `nosql006_disk_total_size` | Total disk capacity | GB | redis_node_id |
| `nosql007_disk_used_size` | Disk usage | GB | redis_node_id |
| `redis017_proxy_accept` | Total number of clients accepted by proxy | count | redis_node_id |
| `redis018_proxy_request_ps` | Proxy's request reception rate | counts/s | redis_node_id |
| `redis019_proxy_response_ps` | Proxy's response rate | count/s | redis_node_id |
| `redis020_proxy_recv_client_bps` | Rate at which proxy receives client byte streams | bytes/s | redis_node_id |
| `redis021_proxy_send_client_bps` | Rate at which proxy sends byte streams to clients | bytes/s | redis_node_id |
| `redis032_shard_qps` | Shard QPS | count | redis_node_id |
| `Invocationredis064_get_avg_usecs` | Average latency for proxy executing "get" command | μs | redis_node_id |
| `redis065_get_max_usec` | Maximum latency for proxy executing "get" command | μs | redis_node_id |
| `redis066_get_p99` | P99 latency for proxy executing "get" command | μs | redis_node_id |
| `redis067_get_qps` | Rate for proxy executing "get" command | count/s | redis_node_id |
| `redis316_all_avg_usec` | Average latency for proxy executing all commands | μs | redis_node_id |
| `redis317_all_max_usec` | Maximum latency for proxy executing all commands | μs | redis_node_id |
| `redis318_all_p99` | P99 latency for proxy executing all commands | μs | redis_node_id |
| `redis319_all_qps` | Rate for proxy executing all commands | count/s | redis_node_id |
| `redis669_connection_usage` | Connection usage rate | % | redis_node_id |
| `redis670_hit_rate` | Hit rate | % | redis_node_id |


## Objects {#object}

The collected Huawei Cloud GaussDB-Redis object data structure can be viewed under "Infrastructure - Custom"

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
    "charge_info"          : "{Billing type information, supports on-demand and package cycle}",
    "flavor_info"          : "{Specification information}",
    "volume"               : "{Volume information}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "public_ips"           : "[\"192.168.0.223\"]",
    "nodes"                : "[]",
    "message"              : "{Instance JSON data}",
    "time_zone"            : "UTC+08:00"
  }
}


```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: The following fields are all JSON serialized strings.
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`