---
title: 'AWS MemoryDB'
tags: 
  - AWS
summary: 'Use the script packages in the script market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_memorydb'
dashboard:

  - desc: 'Built-in views for AWS MemoryDB'
    path: 'dashboard/en/aws_memorydb'

monitor:
  - desc: 'AWS MemoryDB Monitor'
    path: 'monitor/en/aws_memorydb'

---

<!-- markdownlint-disable MD025 -->

# AWS MemoryDB
<!-- markdownlint-enable -->

Use the script packages in the script market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of MemoryDB cloud resources, we install the corresponding collection script: "Guance Integration (AWS MemoryDB Collection)" (ID: `guance_aws_memorydb`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/memorydb/latest/devguide/metrics.memorydb.html){:target="_blank"}

| Metric                    | Description                                                          | Unit     |
| :---------------------- | :----------------------------------------------------------- |:------- |
| `ActiveDefragHits`                  | The number of reclaims performed by the active defragmentation process per minute. This is derived from the `active_defrag_hits` statistics in [Redis INFO](http://redis.io/commands/info). | Number       |
| `AuthenticationFailures` | Total number of failed authentication attempts using the AUTH command to Redis. You can use the [ACL LOG](https://redis.io/commands/acl-log) command to find more information about individual authentication failures. We recommend setting alerts for this to detect unauthorized access attempts. | Count|
| `BytesUsedForMemoryDB` | Total bytes allocated by MemoryDB for all purposes, including datasets, buffers, etc. | Bytes|
| `CommandAuthorizationFailures` | Number of failed attempts by users to execute commands they do not have permission to call. You can use the [ACL LOG](https://redis.io/commands/acl-log) command to find more information about individual authorization failures. We recommend setting alerts for this to detect unauthorized access attempts. | Count|
| `CurrConnections` | Number of client connections excluding those from read-only replicas. MemoryDB uses two to four connections to monitor various cluster conditions. This is based on the `connected_clients` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `CurrItems` | Number of items in the cache. This value is derived from the sum of all keys in the entire key space obtained from Redis `keyspace` statistics. | Count|
| `DatabaseMemoryUsagePercentage` | Percentage of available memory used by the cluster. This is calculated using `used_memory/maxmemory` from [Redis INFO](http://redis.io/commands/info). | Percentage|
| `EngineCPUUtilization` | Provides CPU utilization of Redis engine threads. Since Redis is single-threaded, you can use this metric to analyze the load on the Redis process itself. The `EngineCPUUtilization` metric more accurately represents the Redis process. It can be used alongside the `CPUUtilization` metric. `CPUUtilization` exposes overall CPU usage of the server instance, including other operating system and management processes. For larger node types with four or more vCPUs, the `EngineCPUUtilization` metric can be used to monitor and set scaling thresholds. Note that on MemoryDB hosts, background processes monitor the host to provide a managed database experience. These background processes may consume a significant portion of the CPU workload. This impact is less noticeable on large hosts with more than two vCPUs but can be significant on small hosts with two or fewer vCPUs. If you only monitor the `EngineCPUUtilization` metric, you may miss situations where high CPU usage by Redis or background monitoring processes leads to host overload. Therefore, we recommend also monitoring the `CPUUtilization` metric for hosts with two or fewer vCPUs. | Percentage|
| `Evictions` | Number of keys evicted due to the `maxmemory` limit. This is derived from the `evicted_keys` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `IsPrimary` | Indicates whether the node is the primary node for the current partition. The metric can be 0 (not primary) or 1 (primary). | Count|
| `KeyAuthorizationFailures` | Number of failed attempts by users to access keys they do not have permission to access. You can use the [ACL LOG](https://redis.io/commands/acl-log) command to find more information about individual authorization failures. We recommend setting alerts for this to detect unauthorized access attempts. | Count|
| `KeyspaceHits` | Number of successful read-only key lookups in the main dictionary. This is derived from the `keyspace_hits` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `KeyspaceMisses` | Number of failed read-only key lookups in the main dictionary. This is derived from the `keyspace_misses` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `KeysTracked` | Percentage of keys tracked by Redis key tracking relative to `tracking-table-max-keys`. Key tracking helps client-side caching and notifies clients when keys are modified. | Count|
| `MaxReplicationThroughput` | Maximum replication throughput observed during the last measurement period. | Bytes per second|
| `MemoryFragmentationRatio` | Indicates the efficiency of Redis engine memory allocation. Certain thresholds indicate different behaviors. A recommended value is for fragmentation to be greater than 1.0. This is calculated from the `mem_fragmentation_ratio` statistic in [Redis INFO](http://redis.io/commands/info). | Number|
| `NewConnections` | Total number of connections accepted by the server during this period. This is derived from the `total_connections_received` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `PrimaryLinkHealthStatus` | This status has two values: 0 or 1. A value of 0 indicates that data in the MemoryDB primary node is not synchronized with Redis on EC2. A value of 1 indicates synchronization. | Boolean|
| `Reclaimed` | Total number of expired key events. This is derived from the `expired_keys` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `ReplicationBytes` | For nodes in a replica configuration, `ReplicationBytes` reports the number of bytes sent by the master to all its replicas. This metric represents the write load on the cluster. This is derived from the `master_repl_offset` statistics in [Redis INFO](http://redis.io/commands/info). | Bytes|
| `ReplicationDelayedWriteCommands` | Number of commands delayed due to exceeding maximum replication throughput. | Count|
| `ReplicationLag`                    | This metric applies only to nodes running as read-only replicas. It represents the time lag (in seconds) in applying changes from the primary node. | Seconds|
| `CPUUtilization`                    | Percentage of CPU utilization across the entire host. Since Redis is single-threaded, we recommend monitoring the `EngineCPUUtilization` metric for nodes with 4 or more vCPUs. | Percentage     |
| `FreeableMemory`                    | Idle memory available on the host. This is derived from RAM and buffer, reported as free by the operating system. | Bytes       |
| `NetworkBytesIn`                    | Number of bytes read from the network by the host.                                   | Bytes       |
| `NetworkBytesOut`                   | Number of bytes sent over all network interfaces by the instance.                           | Bytes|
| `NetworkConntrackAllowanceExceeded` | Number of packets formed due to exceeding the maximum connection tracking on the instance and inability to establish new connections. This can cause packet loss in traffic entering and exiting the instance. | Count|
| `SwapUsage` | Usage of swap space on the host. | Bytes|


## Objects {#object}

Structure of collected AWS MemoryDB object data, which can be viewed in 「Infrastructure - Custom」

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
    "message"     : "{instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates*
