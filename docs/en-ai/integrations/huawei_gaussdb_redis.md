---
title: 'Huawei Cloud GaussDB-Redis'
tags: 
  - Huawei Cloud
summary: 'The displayed Metrics of Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching.'
__int_icon: 'icon/huawei_gaussdb_redis'
dashboard:

  - desc: 'Built-in Views for Huawei Cloud GaussDB for Redis'
    path: 'dashboard/en/huawei_gaussdb_redis'

monitor:
  - desc: 'Monitor for Huawei Cloud GaussDB for Redis'
    path: 'monitor/en/huawei_gaussdb_redis'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Redis
<!-- markdownlint-enable -->

The displayed Metrics of Huawei Cloud GaussDB-Redis include read/write throughput, response time, concurrent connections, and data persistence. These Metrics reflect the performance and reliability of GaussDB-Redis when handling high-concurrency data storage and caching.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Expansion - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud GaussDB-Redis, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-GaussDB-Redis Collection)」(ID: `guance_huaweicloud_gaussdb_redis`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create the `Startup` script set and configure the corresponding startup script.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-GaussDB-Redis Collection)」 under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs` and edit the content of `region_projects`, replacing the region and Project ID with the actual ones, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}

### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud cloud monitoring, the default Metrics set is as follows. You can collect more Metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/redisug-nosql/nosql_10_0036.html){:target="_blank"}

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| `nosql001_cpu_usage` | CPU utilization | % | redis_node_id |
| `nosql002_mem_usage` | Memory utilization | % | redis_node_id |
| `nosql005_disk_usage` | Disk utilization | % | redis_node_id |
| `nosql006_disk_total_size` | Total disk capacity | GB | redis_node_id |
| `nosql007_disk_used_size` | Used disk space | GB | redis_node_id |
| `redis017_proxy_accept` | Total number of clients accepted by proxy | count | redis_node_id |
| `redis018_proxy_request_ps` | Proxy's request reception rate | counts/s | redis_node_id |
| `redis019_proxy_response_ps` | Proxy's response transmission rate | count/s | redis_node_id |
| `redis020_proxy_recv_client_bps` | Rate of byte streams received by proxy from clients | bytes/s | redis_node_id |
| `redis021_proxy_send_client_bps` | Rate of byte streams sent by proxy to clients | bytes/s | redis_node_id |
| `redis032_shard_qps` | Shard QPS | count | redis_node_id |
| `Invocationredis064_get_avg_usecs` | Average latency of proxy executing command "get" | μs | redis_node_id |
| `redis065_get_max_usec` | Maximum latency of proxy executing command "get" | μs | redis_node_id |
| `redis066_get_p99` | P99 latency of proxy executing command "get" | μs | redis_node_id |
| `redis067_get_qps` | QPS of proxy executing command "get" | count/s | redis_node_id |
| `redis316_all_avg_usec` | Average latency of proxy executing all commands | μs | redis_node_id |
| `redis317_all_max_usec` | Maximum latency of proxy executing all commands | μs | redis_node_id |
| `redis318_all_p99` | P99 latency of proxy executing all commands | μs | redis_node_id |
| `redis319_all_qps` | QPS of proxy executing all commands | count/s | redis_node_id |
| `redis669_connection_usage` | Connection usage rate | % | redis_node_id |
| `redis670_hit_rate` | Hit rate | % | redis_node_id |

## Objects {#object}

The object data structure collected from Huawei Cloud GaussDB-Redis can be seen under 「Infrastructure-Custom」.

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
    "charge_info"          : "{Billing type information, supports pay-as-you-go and subscription}",
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
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`