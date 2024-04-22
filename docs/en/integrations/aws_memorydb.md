---
title: 'AWS MemoryDB'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_memorydb'
dashboard:
  - desc: 'AWS MemoryDB Monitoring View'
    path: 'dashboard/zh/aws_memorydb'

monitor:
  - desc: 'AWS MemoryDB Monitor'
    path: 'monitor/zh/aws_memorydb'

---

<!-- markdownlint-disable MD025 -->

# AWS MemoryDB
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automate)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of MemoryDB cloud resources, we install the corresponding collection script：「Guance Integration（AWS MemoryDB Collect）」(ID：`guance_aws_memorydb`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click【Run】，you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/memorydb/latest/devguide/metrics.memorydb.html){:target="_blank"}


| Metric                    | Description                                                          |**Unit**     |
| :---------------------- | :----------------------------------------------------------- |:------- |
| `ActiveDefragHits`                  | The number of value reallocations per minute performed by the active defragmentation process. This is derived from `active_defrag_hits` statistic at [Redis INFO](http://redis.io/commands/info). | Number           |
| `AuthenticationFailures`            | The total number of failed attempts to authenticate to Redis using the AUTH command. You can find more information about individual authentication failures using the [ACL LOG](https://redis.io/commands/acl-log) command. We suggest setting an alarm on this to detect unauthorized access attempts. | Count            |
| `BytesUsedForMemoryDB`              | The total number of bytes allocated by MemoryDB for all purposes, including the dataset, buffers, and so on. | Bytes            |
| `CommandAuthorizationFailures`      | The total number of failed attempts by users to run commands they don’t have permission to call. You can find more information about individual authentication failures using the [ACL LOG](https://redis.io/commands/acl-log) command. We suggest setting an alarm on this to detect unauthorized access attempts. | Count            |
| `CurrConnections`                   | The number of client connections, excluding connections from read replicas. MemoryDB uses two to four of the connections to monitor the cluster in each case. This is derived from the `connected_clients` statistic at [Redis INFO](http://redis.io/commands/info). | Count            |
| `CurrItems`                         | The number of items in the cache. This is derived from the Redis `keyspace` statistic, summing all of the keys in the entire `keyspace`. | Count            |
| `DatabaseMemoryUsagePercentage`     | Percentage of the memory available for the cluster that is in use. This is calculated using `used_memory/maxmemory` from [Redis INFO](http://redis.io/commands/info). | Percent          |
| `EngineCPUUtilization`              | Provides CPU utilization of the Redis engine thread. Because Redis is single-threaded, you can use this metric to analyze the load of the Redis process itself. The `EngineCPUUtilization` metric provides a more precise visibility of the Redis process. You can use it in conjunction with the `CPUUtilization` metric. `CPUUtilization` exposes CPU utilization for the server instance as a whole, including other operating system and management processes. For larger node types with four vCPUs or more, use the `EngineCPUUtilization` metric to monitor and set thresholds for scaling.NoteOn a MemoryDB host, background processes monitor the host to provide a managed database experience. These background processes can take up a significant portion of the CPU workload. This is not significant on larger hosts with more than two vCPUs. But it can affect smaller hosts with 2vCPUs or fewer. If you only monitor the `EngineCPUUtilization` metric, you will be unaware of situations where the host is overloaded with both high CPU usage from Redis and high CPU usage from the background monitoring processes. Therefore, we recommend monitoring the `CPUUtilization` metric for hosts with two vCPUs or less. | Percent          |
| `Evictions`                         | The number of keys that have been evicted due to the `maxmemory` limit. This is derived from the `evicted_keys` statistic at [Redis INFO](http://redis.io/commands/info). | Count            |
| `IsPrimary`                         | Indicates whether the node is primary node of current shard. The metric can be either 0 (not primary) or 1 (primary). | Count            |
| `KeyAuthorizationFailures`          | The total number of failed attempts by users to access keys they don’t have permission to access. You can find more information about individual authentication failures using the [ACL LOG](https://redis.io/commands/acl-log) command. We suggest setting an alarm on this to detect unauthorized access attempts. | Count            |
| `KeyspaceHits`                      | The number of successful read-only key lookups in the main dictionary. This is derived from `keyspace_hits` statistic at [Redis INFO](http://redis.io/commands/info). | Count            |
| `KeyspaceMisses`                    | The number of unsuccessful read-only key lookups in the main dictionary. This is derived from `keyspace_misses` statistic at [Redis INFO](http://redis.io/commands/info). | Count            |
| `KeysTracked`                       | The number of keys being tracked by Redis key tracking as a percentage of `tracking-table-max-keys`. Key tracking is used to aid client-side caching and notifies clients when keys are modified. | Count            |
| `MaxReplicationThroughput`          | The maximum observed replication throughput during the last measurement cycle. | Bytes per second |
| `MemoryFragmentationRatio`          | Indicates the efficiency in the allocation of memory of the Redis engine. Certain thresholds signify different behaviors. The recommended value is to have fragmentation above 1.0. This is calculated from the `mem_fragmentation_ratio statistic` of [Redis INFO](http://redis.io/commands/info). | Number           |
| `NewConnections`                    | The total number of connections that have been accepted by the server during this period. This is derived from the `total_connections_received` statistic at [Redis INFO](http://redis.io/commands/info). | Count            |
| `PrimaryLinkHealthStatus`           | This status has two values: 0 or 1. The value 0 indicates that data in the MemoryDB primary node is not in sync with Redis on EC2. The value of 1 indicates that the data is in sync. | Boolean          |
| `Reclaimed`                         | The total number of key expiration events. This is derived from the `expired_keys` statistic at [Redis INFO](http://redis.io/commands/info). | Count            |
| `ReplicationBytes`                  | For nodes in a replicated configuration, `ReplicationBytes` reports the number of bytes that the primary is sending to all of its replicas. This metric is representative of the write load on the cluster. This is derived from the `master_repl_offset` statistic at [Redis INFO](http://redis.io/commands/info). | Bytes            |
| `ReplicationDelayedWriteCommands`   | Number of commands that were delayed due to exceeding the maximum replication throughput. | Count            |
| `ReplicationLag`                    | This metric is only applicable for a node running as a read replica. It represents how far behind, in seconds, the replica is in applying changes from the primary node. | Seconds          |
| `CPUUtilization`                    | The percentage of CPU utilization for the entire host. Because Redis is single-threaded, and we recommend you monitor `EngineCPUUtilization` metric for nodes with 4 or more vCPUs. | Percent          |
| `FreeableMemory`                    | The amount of free memory available on the host. This is derived from the RAM, buffers, and that the OS reports as freeable. | Bytes            |
| `NetworkBytesIn`                    | The number of bytes the host has read from the network.      | Bytes            |
| `NetworkBytesOut`                   | The number of bytes sent out on all network interfaces by the instance. | Bytes            |
| `NetworkConntrackAllowanceExceeded` | The number of packets shaped because connection tracking exceeded the maximum for the instance and new connections could not be established. This can result in packet loss for traffic to or from the instance. | Count            |
| `SwapUsage`                         | The amount of swap used on the host.                         | Bytes            |


## Object {#object}

The collected AWS MemoryDB object data structure can be viewed in "Infrastructure - Custom" under the object data.


```json
{
  "measurement": "aws_memorydb",
  "tags": {
    "RegionId"              : "cn-north-1",
    "Status"                : "xxxx",
    "ClusterName"           : "xxxxxx",
    "AvailabilityMode"      : "xxxxxx",
    "NodeType"              : "xxxxxx",
    "EngineVersion"         : "xxxxxx",
    "EnginePatchVersion"    : "xxxxxx",
    "ParameterGroupName"    : "xxxxxx",
    "ParameterGroupStatus"  : "xxxxxx",
    "ARN"                   : "arn:aws-cn:kms:cn-northwest-1:xxxx",
    "SnsTopicStatus"        : "xxxxxx",
    "SnsTopicArn"           : "xxxxxx",
    "MaintenanceWindow"     : "xxxxxx",
    "SnapshotWindow"        : "xxxxxx",
    "ACLName"               : "xxxxxx",
    "name"                  : "xxxxxx"
  },
  "fields": {
    "Description": "xxxxxx",
    "SecurityGroups": "xxxxxx",
    "NumberOfShards": "xxxxxx",
    "TLSEnabled": "xxxxxx",
    "SnapshotRetentionLimit": "xxxxxx",
    "AutoMinorVersionUpgrade": "xxxxxx",
    "NumberOfShards" : "1",
    "message"     : "{Instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may be subject to changes in subsequent updates.*
