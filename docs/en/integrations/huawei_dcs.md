---
title: 'Huawei Cloud DCS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DCS Metrics data'
__int_icon: 'icon/huawei_dcs'
dashboard:

  - desc: 'Huawei Cloud DCS built-in views'
    path: 'dashboard/en/huawei_dcs'

monitor:
  - desc: 'Huawei Cloud DCS monitors'
    path: 'monitor/en/huawei_dcs'

---

Collect Huawei Cloud DCS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud DCS monitoring data, we install the corresponding collection script:

- **guance_huaweicloud_dcs**: Collect Huawei Cloud DCS Metrics data
- **guance_huaweicloud_dcs_slowlog**: Collect Huawei Cloud DCS slow log data

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

Once the script is installed, find the script "Guance Integration (Huawei Cloud - DCS Collection)" / "Guance Integration (Huawei Cloud - DCS Slow Query Log Collection)" under "Development" in Func, unfold and modify the script. Find and edit the contents of `collector_configs` and `monitor_configs` under `region_projects`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Verification

1. Under "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure - Resource Catalog", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.
4. On the Guance platform, under "Logs", check if there is any corresponding log data.

## Metrics {#metric}

Configure Huawei Cloud DCS monitoring metrics, which can collect more metrics through configuration [Huawei Cloud DCS Metrics Details](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html){:target="_blank"}

### Redis 3.0 Instance Monitoring Metrics

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"} Note:

- DCS Redis 3.0 has been discontinued and is no longer available for purchase. It is recommended to use Redis 4.0 or higher versions.
- For the dimensions of the monitoring metrics, please refer to [Dimensions](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}.

| Metric ID                       | Metric Name             | Metric Meaning                                                     | Value Range                   | Measurement Object                    | Monitoring Period (Raw Metric) |
| ---------------------------- | -------------------- | ------------------------------------------------------------ | -------------------------- | --------------------------- | -------------------- |
| `cpu_usage`                  | CPU Utilization            | This metric samples the CPU usage rate of the measurement object multiple times within the statistical period, representing the highest value among multiple samples. Unit: %. If it's a single-node/master-slave instance, this metric represents the CPU value of the master node. If it's a Proxy cluster instance, this metric represents the average value of each Proxy node. | 0-100%                     | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `memory_usage`               | Memory Utilization           | This metric is used to calculate the memory utilization of the measurement object. Unit: %. **Note:** The memory utilization statistics deduct reserved memory. | 0-100%                     | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `net_in_throughput`          | Network Input Throughput       | This metric is used to calculate the average input traffic per second of the network interface. Unit: byte/s.         | >=0 bytes/second                 | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `net_out_throughput`         | Network Output Throughput       | This metric is used to calculate the average output traffic per second of the network interface. Unit: byte/s.         | >=0 bytes/second                 | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `connected_clients`          | Active Client Count     | This metric is used to calculate the number of connected clients, including connections for system monitoring, configuration synchronization, and business-related activities, excluding connections from slave nodes. | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `client_longest_out_list`    | Longest Client Output List   | This metric is used to calculate the longest output list of all existing client connections.             | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `client_biggest_in_buf`      | Largest Client Input Buffer   | This metric is used to calculate the maximum length of input data for all existing client connections. Unit: byte. | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `blocked_clients`            | Blocked Client Count     | This metric counts the number of clients suspended by blocking operations such as **BLPOP**, **BRPOP**, **BRPOPLPUSH**. | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `used_memory`                | Used Memory             | This metric is used to calculate the number of bytes of memory used by Redis. Unit: byte.          | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `used_memory_rss`            | Used RSS Memory          | This metric is used to calculate the RSS memory used by Redis. That is, the actual amount of memory resident "in memory". Includes heap memory but does not include swapped-out memory. Unit: byte. | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `used_memory_peak`           | Peak Used Memory         | This metric is used to calculate the peak memory usage since the Redis server started. Unit: byte. | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `used_memory_lua`            | Lua Used Memory          | This metric is used to calculate the memory bytes used by the Lua engine. Unit: byte.          | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `memory_frag_ratio`          | Memory Fragmentation Rate           | This metric is used to calculate the current memory fragmentation rate. Its numerical value equals used_memory_rss / used_memory. | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `total_connections_received` | New Connection Count           | This metric is used to calculate the number of new connections established during the period.                           | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `total_commands_processed`   | Processed Command Count         | This metric is used to calculate the number of commands processed during the period.                           | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `instantaneous_ops`          | Concurrent Operations Per Second       | This metric is used to calculate the number of commands processed per second.                             | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `total_net_input_bytes`      | Network Received Bytes       | This metric is used to calculate the number of bytes received during the period. Unit: byte.               | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `total_net_output_bytes`     | Network Sent Bytes       | This metric is used to calculate the number of bytes sent during the period. Unit: byte.               | >=0byte                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `instantaneous_input_kbps`   | Instantaneous Network Input Traffic     | This metric is used to calculate the instantaneous input traffic. Unit: KB/s.                   | >=0KB/s                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `instantaneous_output_kbps`  | Instantaneous Network Output Traffic     | This metric is used to calculate the instantaneous output traffic. Unit: KB/s.                   | >=0KB/s                    | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `rejected_connections`       | Rejected Connection Count       | This metric is used to calculate the number of connections rejected during the period due to exceeding **maxclients**. | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `expired_keys`               | Expired Key Count       | This metric is used to calculate the number of keys deleted due to expiration during the period                   | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `evicted_keys`               | Evicted Key Count       | This metric is used to calculate the number of keys deleted due to insufficient memory during the period.             | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `keyspace_hits`              | **Keyspace** Hit Count | This metric is used to calculate the number of hits in the main dictionary during the period.                 | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `keyspace_misses`            | **Keyspace** Miss Count | This metric is used to calculate the number of misses in the main dictionary during the period.               | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `pubsub_channels`            | Pub/Sub Channel Count       | This metric is used to calculate the number of Pub/Sub channels.                              | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `pubsub_patterns`            | Pub/Sub Pattern Count       | This metric is used to calculate the number of Pub/Sub patterns.                              | >=0                        | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `keyspace_hits_perc`         | Cache Hit Rate           | This metric is used to calculate the cache hit rate of Redis, with the hit rate algorithm being: `keyspace_hits/(keyspace_hits+keyspace_misses)` unit: %. | 0-100%                     | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `command_max_delay`          | Maximum Command Delay         | Statistic of the maximum command delay of the instance. Unit: ms.                           | >=0ms                      | Redis instances (single-node/master-slave/cluster) | 1 minute                |
| `auth_errors`                | Authentication Failure Count         | Statistic of the authentication failure count of the instance.                                     | >=0                        | Redis instances (single-node/master-slave)      | 1 minute                |
| `is_slow_log_exist`          | Existence of Slow Logs       | Statistic of whether the instance has slow logs. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** This monitoring does not count slow logs caused by `migrate`, `slaveof`, `config`, `bgsave`, `bgrewriteaof` commands. | 1: indicates existence 0: indicates non-existence. | Redis instances (single-node/master-slave)      | 1 minute                |
| `keys`                       | Total Cache Keys           | This metric is used to calculate the total number of keys in the Redis cache.                            | >=0                        | Redis instances (single-node/master-slave)      | 1 minute                |

### Redis 4.0, Redis 5.0, and Redis 6.0 Instance Monitoring Metrics

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"} Note:

| Metric ID                  | Metric Name                | Metric Description                                           | Value Range         | Monitored Object                                           | Monitoring Period (Raw Data) |
| -------------------------- | -------------------------- | ------------------------------------------------------------ | ------------------- | ---------------------------------------------------------- | ---------------------------- |
| `cpu_usage`                  | CPU Usage                  | The monitored object's maximum CPU usage among multiple sampling values in a monitoring periodUnit: % | 0–100%              | Single-node or master/standby DCS Redis instance           | 1 minute                     |
| `cpu_avg_usage`              | Average CPU Usage          | The monitored object's average CPU usage of multiple sampling values in a monitoring periodUnit: % | 0–100%              | Single-node or master/standby DCS Redis instance           | 1 minute                     |
| `command_max_delay`          | Maximum Command Latency    | Maximum latency of commandsUnit: ms                          | ≥ 0 ms              | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `total_connections_received` | New Connections            | Number of connections received during the monitoring period  | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `is_slow_log_exist`          | Slow Query Logs            | Existence of slow query logs in the instance![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**NOTE:**Slow queries caused by the **MIGRATE**, **SLAVEOF**, **CONFIG**, **BGSAVE**, and **BGREWRITEAOF** commands are not counted. | **1**: yes**0**: no | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `memory_usage`               | Memory Usage               | Memory consumed by the monitored objectUnit: %               | 0–100%              | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `expires`                    | Keys With an Expiration    | Number of keys with an expiration in Redis                   | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `keyspace_hits_perc`         | Hit Rate                   | Ratio of the number of Redis cache hits to the number of lookups. Calculation: keyspace_hits/(keyspace_hits + keyspace_misses)Aggregated from the master and replica nodes.Unit: % | 0–100%              | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `used_memory`                | Used Memory                | Total number of bytes used by the Redis serverUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `used_memory_dataset`        | Used Memory Dataset        | Dataset memory that the Redis server has usedUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `used_memory_dataset_perc`   | Used Memory Dataset Ratio  | Percentage of dataset memory that server has usedAggregated from the master and replica nodes.Unit: % | 0–100%              | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `used_memory_rss`            | Used Memory RSS            | Resident set size (RSS) memory that the Redis server has used, which is the memory that actually resides in the memory, including all stack and heap memory but not swapped-out memoryUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `instantaneous_ops`          | Ops per Second             | Number of commands processed per second                      | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `keyspace_misses`            | **Keyspace** Misses            | Number of failed lookups of keys in the main dictionary during the monitoring periodAggregated from the master and replica nodes. | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `keys`                       | Keys                       | Number of keys in Redis                                      | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `blocked_clients`            | Blocked Clients            | Number of clients suspended by block operations              | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `connected_clients`          | Connected Clients          | Number of connected clients (excluding those from slave nodes) | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `del`                        | DEL                        | Number of **DEL** commands processed per second              | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `evicted_keys`               | Evicted Keys               | Number of keys that have been evicted and deleted during the monitoring periodAggregated from the master and replica nodes. | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `expire`                     | EXPIRE                     | Number of **EXPIRE** commands processed per second           | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `expired_keys`               | Expired Keys               | Number of keys that have expired and been deleted during the monitoring periodAggregated from the master and replica nodes. | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `get`                        | GET                        | Number of **GET** commands processed per secondAggregated from the master and replica nodes.Unit: count/s | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `hdel`                       | **HDEL**                       | Number of **HDEL** commands processed per second             | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `hget`                       | **HGET**                       | Number of **HGET** commands processed per secondAggregated from the master and replica nodes.Unit: count/s | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `hmget`                      | **HMGET**                      | Number of **HMGET** commands processed per secondAggregated from the master and replica nodes.Unit: count/s | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `hmset`                      | **HMSET**                      | Number of **HMSET** commands processed per second            | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `hset`                       | **HSET**                       | Number of **HSET** commands processed per second             | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `instantaneous_input_kbps`   | Input Flow                 | Instantaneous input trafficUnit: KB/s                        | ≥ 0 KB/s            | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `instantaneous_output_kbps`  | Output Flow                | Instantaneous output trafficUnit: KB/s                       | ≥ 0 KB/s            | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `memory_frag_ratio`          | Memory Fragmentation Ratio | Ratio between Used Memory RSS and Used Memory                | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `mget`                       | **MGET**                       | Number of **MGET** commands processed per secondAggregated from the master and replica nodes.Unit: count/s | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `mset`                      | **MSET**                       | Number of **MSET** commands processed per second             | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `pubsub_channels`            | PubSub Channels            | Number of Pub/Sub channels                                   | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `pubsub_patterns`            | PubSub Patterns            | Number of Pub/Sub patterns                                   | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `set`                        | SET                        | Number of **SET** commands processed per second              | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `used_memory_lua`            | Used Memory Lua            | Number of bytes used by the Lua engineUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `used_memory_peak`           | Used Memory Peak           | Peak memory consumed by Redis since the Redis server last startedUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `sadd`                       | **Sadd**                       | Number of **SADD** commands processed per secondUnit: count/s | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `smembers`                   | **Smembers**                   | Number of **SMEMBERS** commands processed per secondAggregated from the master and replica nodes.Unit: count/s | 0–500,000           | Single-node, master/standby, or cluster DCS Redis instance | 1 minute                     |
| `rx_controlled`              | Flow Control Times         | Number of flow control times during the monitoring periodIf the value is greater than 0, the used bandwidth exceeds the upper limit and flow control is triggered.Unit: Count | ≥ 0                 | Redis Cluster instance                                     | 1 minute                     |
| `bandwidth_usage`            | Bandwidth Usage            | Percentage of the used bandwidth to the maximum bandwidth limit | 0–200%              | Redis Cluster instance                                     | 1 minute                     |
| `command_max_rt`             | Maximum Latency            | Maximum delay from when the node receives commands to when it respondsUnit: us | ≥ 0                 | Single-node DCS Redis 4.0/5.0/6.0 instance                 | 1 minute                     |
| `command_avg_rt`             | Average Latency            | Average delay from when the node receives commands to when it respondsUnit: us | ≥ 0                 | Single-node DCS Redis 4.0/5.0/6.0 instance                 | 1 minute                     |

### Redis Server Metrics of DCS Redis Instances

![img](https://cdn.jsdelivr.net/gh/tghlinux/BlogImage/img/202308021139584.svg)NOTE:

- For Proxy Cluster instances, the monitoring covers Redis Servers and proxies. For Redis Cluster DCS Redis 4.0/5.0/6.0 instances and master/standby instances, the monitoring only covers Redis Servers.

- [Dimensions](https://support.huaweicloud.com/intl/en-us/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"} lists the metric dimensions.

| Metric ID                  | Metric Name                | Metric Description                                           | Value Range         | Monitored Object                                             | Monitoring Period (Raw Data) |
| -------------------------- | -------------------------- | ------------------------------------------------------------ | ------------------- | ------------------------------------------------------------ | ---------------------------- |
| `cpu_usage`                  | CPU Usage                  | The monitored object's maximum CPU usage among multiple sampling values in a monitoring periodUnit: % | 0–100%              | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `cpu_avg_usage`              | Average CPU Usage          | The monitored object's average CPU usage of multiple sampling values in a monitoring periodUnit: % | 0–100%              | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `memory_usage`               | Memory Usage               | Memory consumed by the monitored objectUnit: %               | 0–100%              | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `connected_clients`          | Connected Clients          | Number of connected clients (excluding those from slave nodes) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `client_longest_out_list`    | Client Longest Output List | Longest output list among current client connections         | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 3.0 or 4.0 instance | 1 minute                     |
| `client_biggest_in_buf`      | Client Biggest Input Buf   | Maximum input data length among current client connectionsUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 3.0 or 4.0 instance | 1 minute                     |
| `blocked_clients`            | Blocked Clients            | Number of clients suspended by block operations such as **BLPOP**, **BRPOP**, and **BRPOPLPUSH** | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `used_memory`                | Used Memory                | Total number of bytes used by the Redis serverUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `used_memory_rss`            | Used Memory RSS            | RSS memory that the Redis server has used, which includes all stack and heap memory but not swapped-out memoryUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `used_memory_peak`           | Used Memory Peak           | Peak memory consumed by Redis since the Redis server last startedUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `used_memory_lua`            | Used Memory Lua            | Number of bytes used by the Lua engineUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `memory_frag_ratio`          | Memory Fragmentation Ratio | Current memory fragmentation, which is the ratio between **used_memory_rss**/**used_memory**. | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `total_connections_received` | New Connections            | Number of connections received during the monitoring period  | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `total_commands_processed`   | Commands Processed         | Number of commands processed during the monitoring period    | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `instantaneous_ops`          | Ops per Second             | Number of commands processed per second                      | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `total_net_input_bytes`      | Network Input Bytes        | Number of bytes received during the monitoring periodUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `total_net_output_bytes`     | Network Output Bytes       | Number of bytes sent during the monitoring periodUnit: KB, MB, or byte (configurable on the console) | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `instantaneous_input_kbps`   | Input Flow                 | Instantaneous input trafficUnit: KB/s                        | ≥ 0 KB/s            | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `instantaneous_output_kbps`  | Output Flow                | Instantaneous output trafficUnit: KB/s                       | ≥ 0 KB/s            | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `rejected_connections`       | Rejected Connections       | Number of connections that have exceeded **maxclients** and been rejected during the monitoring period | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `expired_keys`               | Expired Keys               | Number of keys that have expired and been deleted during the monitoring period | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `evicted_keys`               | Evicted Keys               | Number of keys that have been evicted and deleted during the monitoring period | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `pubsub_channels`            | PubSub Channels            | Number of Pub/Sub channels                                   | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `pubsub_patterns`            | PubSub Patterns            | Number of Pub/Sub patterns                                   | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 3.0, 4.0, or 5.0 instance | 1 minute                     |
| `keyspace_hits_perc`         | Hit Rate                   | Ratio of the number of Redis cache hits to the number of lookups. Calculation: keyspace_hits/(keyspace_hits + keyspace_misses)Unit: % | 0–100%              | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `command_max_delay`          | Maximum Command Latency    | Maximum latency of commandsUnit: ms                          | ≥ 0 ms              | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `is_slow_log_exist`          | Slow Query Logs            | Existence of slow query logs in the node![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**NOTE:**Slow queries caused by the **MIGRATE**, **SLAVEOF**, **CONFIG**, **BGSAVE**, and **BGREWRITEAOF** commands are not counted. | **1**: yes**0**: no | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `keys`                       | Keys                       | Number of keys in Redis                                      | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis instance | 1 minute                     |
| `sadd`                       | **Sadd**                       | Number of **SADD** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `smembers`                   | **Smembers**                   | Number of **SMEMBERS** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `ms_repl_offset`             | Replication Gap            | Data synchronization gap between the master and the replica  | -                   | Replica Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `del`                        | DEL                        | Number of **DEL** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `expire`                     | EXPIRE                     | Number of **EXPIRE** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `get`                        | GET                        | Number of **GET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `hdel`                       | **HDEL**                       | Number of **HDEL** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `hget`                       | **HGET**                       | Number of **HGET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `hmget`                      | **HMGET**                      | Number of **HMGET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `hmset`                      | **HMSET**                      | Number of **HMSET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `hset`                       | **HSET**                       | Number of **HSET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `mget`                       | **MGET**                       | Number of **MGET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `mset`                       | **MSET**                       | Number of **MSET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `set`                        | SET                        | Number of **SET** commands processed per secondUnit: count/s | 0–500,000           | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `rx_controlled`              | Flow Control Times         | Number of flow control times during the monitoring periodIf the value is greater than 0, the used bandwidth exceeds the upper limit and flow control is triggered.Unit: Count | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `bandwidth_usage`            | Bandwidth Usage            | Percentage of the used bandwidth to the maximum bandwidth limit | 0–200%              | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `connections_usage`          | Connection Usage           | Percentage of the current number of connections to the maximum allowed number of connectionsUnit: % | 0–100%              | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `command_max_rt`             | Maximum Latency            | Maximum delay from when the node receives commands to when it respondsUnit: us | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `command_avg_rt`             | Average Latency            | Average delay from when the node receives commands to when it respondsUnit: us | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `sync_full`                  | Full Sync Times            | Total number of full synchronizations since the Redis Server last started | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |
| `slow_log_counts`            | Slow Queries               | Number of times that slow queries occur within a monitoring period | ≥ 0                 | Redis Server of a master/standby or cluster DCS Redis 4.0 or 5.0 instance or a master/standby DCS Redis 6.0 instance | 1 minute                     |

### Proxy Metrics

![img](https://cdn.jsdelivr.net/gh/tghlinux/BlogImage/img/202308021139584.svg)NOTE:

[Dimensions](https://support.huaweicloud.com/intl/en-us/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"} lists the metric dimensions.

| Metric ID           | Metric Name                           | Metric Description                                           | Value Range  | Monitored Object                                | Monitoring Period (Raw Data) |
| ------------------- | ------------------------------------- | ------------------------------------------------------------ | ------------ | ----------------------------------------------- | ---------------------------- |
| `cpu_usage`           | CPU Usage                             | The monitored object's maximum CPU usage among multiple sampling values in a monitoring periodUnit: % | 0–100%       | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `memory_usage`        | Memory Usage                          | Memory consumed by the monitored objectUnit: %               | 0–100%       | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `p_connected_clients` | Connected Clients                     | Number of connected clients                                  | ≥ 0          | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `max_rxpck_per_sec`   | Max. NIC Data Packet Receive Rate     | Maximum number of data packets received by the proxy NIC per second during the monitoring periodUnit: packages/second | 0–10,000,000 | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `max_txpck_per_sec`   | Max. NIC Data Packet Transmit Rate    | Maximum number of data packets transmitted by the proxy NIC per second during the monitoring periodUnit: packages/second | 0–10,000,000 | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `max_rxkB_per_sec`    | Maximum Inbound Bandwidth             | Largest volume of data received by the proxy NIC per secondUnit: KB/s | ≥ 0 KB/s     | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `max_txkB_per_sec`    | Maximum Outbound Bandwidth            | Largest volume of data transmitted by the proxy NIC per secondUnit: KB/s | ≥ 0 KB/s     | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `avg_rxpck_per_sec`   | Average NIC Data Packet Receive Rate  | Average number of data packets received by the proxy NIC per second during the monitoring periodUnit: packages/second | 0–10,000,000 | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `avg_txpck_per_sec`   | Average NIC Data Packet Transmit Rate | Average number of data packets transmitted by the proxy NIC per second during the monitoring periodUnit: packages/second | 0–10,000,000 | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `avg_rxkB_per_sec`    | Average Inbound Bandwidth             | Average volume of data received by the proxy NIC per secondUnit: KB/s | ≥ 0 KB/s     | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |
| `avg_txkB_per_sec`    | Average Outbound Bandwidth            | Average volume of data transmitted by the proxy NIC per secondUnit: KB/s | ≥ 0 KB/s     | Proxy in a Proxy Cluster DCS Redis 3.0 instance | 1 minute                     |

| Metric ID                 | Metric Name          | Metric Description                                           | Value Range                  | Monitored Object                                       | Monitoring Period (Raw Data) |
| ------------------------- | -------------------- | ------------------------------------------------------------ | ---------------------------- | ------------------------------------------------------ | ---------------------------- |
| `node_status`               | Proxy Status         | Indication of whether the proxy is normal.                   | **0**: Normal**1**: Abnormal | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `cpu_usage`                 | CPU Usage            | The monitored object's maximum CPU usage among multiple sampling values in a monitoring periodUnit: % | 0–100%                       | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `memory_usage`              | Memory Usage         | Memory consumed by the monitored objectUnit: %               | 0–100%                       | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `connected_clients`         | Connected Clients    | Number of connected clients                                  | ≥ 0                          | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `instantaneous_ops`         | Ops per Second       | Number of commands processed per second                      | ≥ 0                          | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `instantaneous_input_kbps`  | Input Flow           | Instantaneous input trafficUnit: KB/s                        | ≥ 0 KB/s                     | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `instantaneous_output_kbps` | Output Flow          | Instantaneous output trafficUnit: KB/s                       | ≥ 0 KB/s                     | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `total_net_input_bytes`     | Network Input Bytes  | Number of bytes received during the monitoring periodUnit: KB, MB, or byte (configurable on the console) | ≥ 0                          | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `total_net_output_bytes`    | Network Output Bytes | Number of bytes sent during the monitoring periodUnit: KB, MB, or byte (configurable on the console) | ≥ 0                          | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `connections_usage`         | Connection Usage     | Percentage of the current number of connections to the maximum allowed number of connections Unit: % | 0–100%                       | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `command_max_rt`            | Maximum Latency      | Maximum delay from when the node receives commands to when it respondsUnit: us | ≥ 0                          | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |
| `command_avg_rt`            | Average Latency      | Average delay from when the node receives commands to when it respondsUnit: us | ≥ 0                          | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance | 1 minute                     |

### DCS Memcached Instance Metrics

![img](https://cdn.jsdelivr.net/gh/tghlinux/BlogImage/img/202308021139584.svg)NOTE:

[Dimensions](https://support.huaweicloud.com/intl/en-us/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"} lists the metric dimensions.

| Metric ID                    | Metric Name                      | Metric Description                                           | Value Range         | Monitored Object       | Monitoring Period (Raw Data) |
| ---------------------------- | -------------------------------- | ------------------------------------------------------------ | ------------------- | ---------------------- | ---------------------------- |
| `cpu_usage`                    | CPU Usage                        | The monitored object's maximum CPU usage among multiple sampling values in a monitoring periodUnit: % | 0–100%              | DCS Memcached instance | 1 minute                     |
| `memory_usage`                 | Memory Usage                     | Memory consumed by the monitored objectUnit: %               | 0–100%              | DCS Memcached instance | 1 minute                     |
| `net_in_throughput`            | Network Input Throughput         | Inbound throughput per second on a portUnit: byte/s          | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `net_out_throughput`           | Network Output Throughput        | Outbound throughput per second on a portUnit: byte/s         | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_connected_clients`         | Connected Clients                | Number of connected clients (excluding those from slave nodes) | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_used_memory`               | Used Memory                      | Number of bytes used by MemcachedUnit: byte                  | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_used_memory_rss`           | Used Memory RSS                  | RSS memory used that actually resides in the memory, including all stack and heap memory but not swapped-out memoryUnit: byte | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_used_memory_peak`          | Used Memory Peak                 | Peak memory consumed since the server last startedUnit: byte | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_memory_frag_ratio`         | Memory Fragmentation Ratio       | Ratio between Used Memory RSS and Used Memory                | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_connections_received`      | New Connections                  | Number of connections received during the monitoring period  | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_commands_processed`        | Commands Processed               | Number of commands processed during the monitoring period    | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_instantaneous_ops`         | Ops per Second                   | Number of commands processed per second                      | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_net_input_bytes`           | Network Input Bytes              | Number of bytes received during the monitoring periodUnit: byte | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_net_output_bytes`          | Network Output Bytes             | Number of bytes sent during the monitoring periodUnit: byte  | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_instantaneous_input_kbps`  | Input Flow                       | Instantaneous input trafficUnit: KB/s                        | ≥ 0 KB/s            | DCS Memcached instance | 1 minute                     |
| `mc_instantaneous_output_kbps` | Output Flow                      | Instantaneous output trafficUnit: KB/s                       | ≥ 0 KB/s            | DCS Memcached instance | 1 minute                     |
| `mc_rejected_connections`      | Rejected Connections             | Number of connections that have exceeded **maxclients** and been rejected during the monitoring period | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_expired_keys`              | Expired Keys                     | Number of keys that have expired and been deleted during the monitoring period | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_evicted_keys`              | Evicted Keys                     | Number of keys that have been evicted and deleted during the monitoring period | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cmd_get`                   | Number of Retrieval Requests     | Number of received data retrieval requests                   | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cmd_set`                   | Number of Storage Requests       | Number of received data storage requests                     | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cmd_flush`                 | Number of Flush Requests         | Number of received data clearance requests                   | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cmd_touch`                 | Number of Touch Requests         | Number of received requests for modifying the validity period of data | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_get_hits`                  | Number of Retrieval Hits         | Number of successful data retrieval operations               | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_get_misses`                | Number of Retrieval Misses       | Number of failed data retrieval operations due to key nonexistence | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_delete_hits`               | Number of Delete Hits            | Number of successful data deletion operations                | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_delete_misses`             | Number of Delete Misses          | Number of failed data deletion operations due to key nonexistence | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_incr_hits`                 | Number of Increment Hits         | Number of successful increment operations                    | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_incr_misses`               | Number of Increment Misses       | Number of failed increment operations due to key nonexistence | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_decr_hits`                 | Number of Decrement Hits         | Number of successful decrement operations                    | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_decr_misses`               | Number of Decrement Misses       | Number of failed decrement operations due to key nonexistence | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cas_hits`                  | Number of CAS Hits               | Number of successful CAS operations                          | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cas_misses`                | Number of CAS Misses             | Number of failed CAS operations due to key nonexistence      | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_cas_badval`                | Number of CAS Values Not Matched | Number of failed CAS operations due to CAS value mismatch    | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_touch_hits`                | Number of Touch Hits             | Number of successful requests for modifying the validity period of data | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_touch_misses`              | Number of Touch Misses           | Number of failed requests for modifying the validity period of data due to key nonexistence | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_auth_cmds`                 | Authentication Requests          | Number of authentication requests                            | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_auth_errors`               | Authentication Failures          | Number of failed authentication requests                     | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_curr_items`                | Number of Items Stored           | Number of stored data items                                  | ≥ 0                 | DCS Memcached instance | 1 minute                     |
| `mc_command_max_delay`         | Maximum Command Latency          | Maximum latency of commandsUnit: ms                          | ≥ 0 ms              | DCS Memcached instance | 1 minute                     |
| `mc_is_slow_log_exist`         | Slow Query Logs                  | Existence of slow query logs in the instance![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**NOTE:**Slow queries caused by the **MIGRATE**, **SLAVEOF**, **CONFIG**, **BGSAVE**, and **BGREWRITEAOF** commands are not counted. | **1**: yes**0**: no | DCS Memcached instance | 1 minute                     |
| `mc_keyspace_hits_perc`        | Hit Rate                         | Ratio of the number of Memcached cache hits to the number of lookupsUnit: % | 0–100%              | DCS Memcached instance | 1 minute                     |



### Dimensions

| Key                       | Value                                                  |
| ------------------------- | ------------------------------------------------------ |
| `dcs_instance_id`           | DCS Redis instance                                     |
| `dcs_cluster_redis_node`    | Redis Server                                           |
| `dcs_cluster_proxy_node`    | Proxy in a Proxy Cluster DCS Redis 3.0 instance        |
| `dcs_cluster_proxy2_node`   | Proxy in a Proxy Cluster DCS Redis 4.0 or 5.0 instance |
| `dcs_memcached_instance_id` | DCS Memcached instance                                 |

## Object {#object}

The collected Huawei Cloud DCS object data structure can be viewed in the 「Infrastructure - Resource Catalog」 for object data.

```json
{
  "measurement": "huaweicloud_redis",
  "tags": {
    "RegionId"          : "cn-north-4",
    "project_id"        : "c631f04625xxxxxxxxxxf253c62d48585",
    "enterprise_project_id" : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_id"       : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_name"     : "dcs-iash",
    "engine"            : "Redis",
  },
  "fields": {
    "engine_version"    : "5.0",
    "status"            : "RUNNING",
    "port"              : "6379",
    "ip"                : "192.xxx.x.144",
    "charging_mode"     : "0",
    "enable_publicip"   : "False",
    "spec_code"         : "xxxx",
    "az_codes"          : "xxxxx",
    "created_at"        : "2022-07-12T07:29:56.875Z",
    "max_memory"        : "128",
    "used_memory"       : "2",
    "capacity"          : "0",
    "description"       : "",
  }
}
```

Some field descriptions are as follows:

| Field                 | Type    | Description                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `ip`                 | String  | The IP address for connecting to the cache instance. If it's a cluster instance, it returns multiple IP addresses separated by commas. For example: 192.168.0.1, 192.168.0.2. |
| `charging_mode`      | String  | Billing mode, 0 means pay-as-you-go, 1 means annual/monthly subscription billing.              |
| `no_password_access` | String  | Whether password-free access to the cache instance is allowed: true: this instance can be accessed without a password. false: this instance must be authenticated with a password to access. |
| `enable_publicip`    | String  | Whether the Redis cache instance has public network access enabled True: enabled False: not enabled  |
| `max_memory`         | Integer | Total memory, unit: MB.                                           |
| `used_memory`        | Integer | Used memory, unit: MB.                                     |
| `capacity`           | Integer | Cache capacity (G Byte).                                         |
| `status`             | String  | **CREATING**: After applying for a cache instance, before the cache instance enters the running state. **CREATEFAILED**: The cache instance is in a creation failure state. **RUNNING**: The cache instance is in a normal operating state. **RESTARTING**: The cache instance is undergoing a restart operation. **FROZEN**: The cache instance is in a frozen state, and users can renew the frozen cache instance in "My Orders". **EXTENDING**: The cache instance is in an expansion state. **RESTORING**: The cache instance data recovery state. **FLUSHING**: The cache instance data clearing state. |

> *Note: Fields in `tags` and `fields` may change after subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are JSON serialized string - `fields.message` - `tags.az_codes`