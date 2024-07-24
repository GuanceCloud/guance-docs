---
title: 'HUAWEI DCS'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_dcs'
dashboard:

  - desc: 'HUAWEI CLOUD DCS Monitoring View'
    path: 'dashboard/zh/huawei_dcs'

monitor:
  - desc: 'HUAWEI CLOUD DCS Monitor'
    path: 'monitor/zh/huawei_dcs'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD DCS
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD DCS cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-DCSCollect）」(ID：`guance_huaweicloud_dcs`)

After clicking "Install," enter the corresponding parameters: HUAWEI CLOUD AK (Access Key) and HUAWEI CLOUD account name.

Click "Deploy and Start Script," and the system will automatically create a `Startup` script set and configure the corresponding startup script.

In addition, in "Management / Automatic Trigger Configuration," you can see the corresponding automatic trigger configuration. Click "Execute" to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

We have collected some default configurations. For details, please refer to the "Metrics" section: [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}.


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html){:target="_blank"}

### Redis 3.0 Instance Monitoring Metrics

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}Note:

- DCS Redis 3.0 has been discontinued and is no longer available for purchase. We recommend using Redis 4.0 and above versions.
- For dimensions of the monitoring metrics, please refer to [Dimensions](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}.

| Metric ID                   | Metric Name           | Metric Definition                                            | Value Range                | Measurement Object           | Monitoring Interval (Raw Metric) |
| --------------------------- | --------------------- | ------------------------------------------------------------ | -------------------------- | --------------------------- | -------------------------------- |
| `cpu_usage`                   | CPU Usage             | This metric records multiple samples of CPU usage for the measured object during a statistical period and represents the highest value of the multiple samples. Unit: %. For standalone/primary-replica instances, this metric represents the CPU value of the primary node. For Proxy cluster instances, it represents the average value of each Proxy node's CPU. | 0-100%                     | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `memory_usage`                | Memory Usage          | This metric records the memory usage of the measured object. Unit: %. **Note:** Memory usage statistics deduct reserved memory. | 0-100%                     | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `net_in_throughput`           | Network Input Throughput | This metric records the average incoming traffic on the network interface per second. Unit: byte/s. | >=0 bytes/second           | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `net_out_throughput`          | Network Output Throughput | This metric records the average outgoing traffic on the network interface per second. Unit: byte/s. | >=0 bytes/second           | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `connected_clients`           | Connected Clients     | This metric counts the number of connected clients, including connections for system monitoring, configuration synchronization, and business operations, but excluding connections from slave nodes. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `client_longest_out_list`     | Longest Output List for Clients | This metric records the longest output list among all existing client connections. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `client_biggest_in_buf`       | Largest Input Buffer for Clients | This metric records the maximum input data length among all existing client connections. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `blocked_clients`             | Blocked Clients       | This metric counts the number of clients that are blocked due to suspended operations, such as **BLPOP**, **BRPOP**, **BRPOPLPUSH**. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `used_memory`                 | Used Memory          | This metric records the total number of bytes of memory used by Redis. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `used_memory_rss`             | Used Memory RSS      | This metric records the used RSS memory of Redis, which is the actual memory "resident in memory." It includes heap memory but excludes swapped-out memory. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `used_memory_peak`            | Used Memory Peak     | This metric records the peak memory usage since Redis server started. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `used_memory_lua`             | Used Memory for Lua  | This metric records the memory used by the Lua engine in bytes. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `memory_frag_ratio`           | Memory Fragmentation Ratio | This metric records the current memory fragmentation ratio, which is calculated as used_memory_rss / used_memory. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `total_connections_received`  | Total New Connections | This metric counts the total number of new connections during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `total_commands_processed`    | Total Processed Commands | This metric counts the total number of commands processed during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `instantaneous_ops`           | Instantaneous Operations per Second | This metric records the number of commands processed per second. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `total_net_input_bytes`       | Total Network Input Bytes | This metric records the total number of bytes received during the monitoring period. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `total_net_output_bytes`      | Total Network Output Bytes | This metric records the total number of bytes sent during the monitoring period. Unit: byte. | >=0 bytes                  | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `instantaneous_input_kbps`    | Instantaneous Network Input Rate | This metric records the instantaneous input rate of the network. Unit: KB/s. | >=0 KB/s                   | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `instantaneous_output_kbps`   | Instantaneous Network Output Rate | This metric records the instantaneous output rate of the network. Unit: KB/s. | >=0 KB/s                   | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `rejected_connections`        | Rejected Connections  | This metric counts the total number of connections rejected due to reaching the **maxclients** limit during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `expired_keys`                | Expired Keys         | This metric counts the total number of keys expired and deleted during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `evicted_keys`                | Evicted Keys         | This metric counts the total number of keys evicted due to memory exhaustion during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `keyspace_hits`               | **Keyspace** Hits        | This metric counts the total number of successful lookups in the main dictionary during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `keyspace_misses`             | **Keyspace** Misses      | This metric counts the total number of unsuccessful lookups in the main dictionary during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `pubsub_channels`             | Pub/Sub Channels     | This metric counts the total number of active Pub/Sub channels during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `pubsub_patterns`             | Pub/Sub Patterns     | This metric counts the total number of active Pub/Sub patterns during the monitoring period. | >=0                        | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `keyspace_hits_perc`          | Cache Hit Rate       | This metric calculates the cache hit rate of Redis as keyspace_hits / (keyspace_hits + keyspace_misses). Unit: %. | 0-100%                     | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `command_max_delay`           | Maximum Command Delay | This metric records the maximum delay of commands in milliseconds for the instance. | >=0 ms                     | Redis Instance (Standalone/Primary-Replica/Cluster) | 1 minute                |
| `auth_errors`                 | Authentication Errors | This metric counts the total number of authentication failures for the instance. | >=0                        | Redis Instance (Standalone/Primary-Replica) | 1 minute                |
| `is_slow_log_exist`           | Slow Logs Existence  | This metric indicates whether slow logs exist for the instance. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** This monitoring metric does not include slow logs caused by migrate, slaveof, config, bgsave, and bgrewriteaof commands. | 1: Exist, 0: Not Exist    | Redis Instance (Standalone/Primary-Replica) | 1 minute                |
| `keys`                        | Total Keys           | This metric counts the total number of keys in the Redis cache. | >=0                        | Redis Instance (Standalone/Primary-Replica) | 1 minute                |

<!-- markdownlint-disable MD013 -->
### Redis 4.0, Redis 5.0, and Redis 6.0 Instance Monitoring Metrics
<!-- markdownlint-enable -->

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}Explanation:

- For the dimensions of monitoring metrics, please refer to [Dimensions](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}.
- Instance monitoring aggregates data from primary nodes.
- Some instance monitoring metrics are aggregated from both primary and secondary nodes. Please refer to "Meaning of Metrics" in [Table 3](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__table1496722055110){:target="_blank"}.

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

```json
{
  "measurement": "huaweicloud_redis",
  "tags": {
    "name"              : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_id"       : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_name"     : "dcs-iash",
    "RegionId"          : "cn-north-4",
    "project_id"        : "c631f04625xxxxxxxxxxf253c62d48585",
    "engine"            : "Redis",
    "engine_version"    : "5.0",
    "status"            : "RUNNING",
    "az_codes"          : "[\"cn-north-4c\", \"cn-north-4a\"]",
    "port"              : "6379",
    "ip"                : "192.xxx.x.144",
    "charging_mode"     : "0",
    "no_password_access": "true",
    "enable_publicip"   : "False"
  },
  "fields": {
    "created_at" : "2022-07-12T07:29:56.875Z",
    "max_memory" : 128,
    "used_memory": 2,
    "capacity"   : 0,
    "description": "",
    "message"    : "{Instance JSON data}"
  }
}
```

Here is the translation of the provided field descriptions:

| Field                | Type    | Description                                                  |
| :------------------- | :------ | :----------------------------------------------------------- |
| `ip`                 | String  | IP address used to connect to the cache instance. If it is a cluster instance, multiple IP addresses are returned, separated by commas. For example: 192.168.0.1, 192.168.0.2. |
| `charging_mode`      | String  | Billing mode, where 0 indicates pay-as-you-go, and 1 indicates subscription. |
| `no_password_access` | String  | Indicates whether no password is required to access the cache instance: true: the instance does not require a password for access. false: the instance requires password authentication for access. |
| `enable_publicip`    | String  | Specifies whether Redis cache instance allows public network access. True: enabled; False: not enabled. |
| `max_memory`         | Integer | Total memory of the instance, measured in MB.                |
| `used_memory`        | Integer | Memory currently in use, measured in MB.                     |
| `capacity`           | Integer | Cache capacity in GigaBytes (GB).                            |
| `status`             | String  | CREATING: The cache instance is being created and is not yet in the running state. CREATEFAILED: The cache instance creation has failed. RUNNING: The cache instance is in normal running state. RESTARTING: The cache instance is undergoing a restart operation. FROZEN: The cache instance is in a frozen state. Users can renew the frozen cache instance in "My Orders". EXTENDING: The cache instance is in the process of being extended. RESTORING: The cache instance is currently restoring data. FLUSHING: The cache instance is currently clearing data. |

> *Note: Fields `tags` and `fields` might be subject to changes in future updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as the unique identifier.
>
> Tip 2: All the following fields are JSON serialized strings - `fields.message` - `tags.az_codes`

