---
title: 'AWS MemoryDB'
tags: 
  - AWS
summary: 'Use the script market "Guance Cloud Sync" series script package to synchronize cloud monitoring and cloud assets data to Guance'
__int_icon: 'icon/aws_memorydb'
dashboard:

  - desc: 'AWS MemoryDB built-in view'
    path: 'dashboard/en/aws_memorydb'

monitor:
  - desc: 'AWS MemoryDB monitor'
    path: 'monitor/en/aws_memorydb'

---

<!-- markdownlint-disable MD025 -->

# AWS MemoryDB
<!-- markdownlint-enable -->

Use the script market "Guance Cloud Sync" series script package to synchronize cloud monitoring and cloud assets data to Guance


## Configuration {#config}

### Install Func

It is recommended to activate the Guance integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of MemoryDB cloud resources, we install the corresponding collection script: "Guance Integration (AWS MemoryDB Collection)" (ID: `guance_aws_memorydb`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in the "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

We have collected some configurations by default, for details, see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric set is as follows, you can collect more metrics through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/zh_cn/memorydb/latest/devguide/metrics.memorydb.html){:target="_blank"}

| Metric                    | Description                                                          | Unit     |
| :---------------------- | :----------------------------------------------------------- |:------- |
| `ActiveDefragHits`                  | The number of reassignments performed per minute by the active defragmentation process. This is derived from the `active_defrag_hits` statistics in [Redis INFO](http://redis.io/commands/info). | Number       |
| `AuthenticationFailures` | Total number of failed authentication attempts using the AUTH command on Redis. You can use the [ACL LOG](https://redis.io/commands/acl-log) command to find more information about individual authentication failures. We recommend setting up alerts to detect unauthorized access attempts. | Count|
| `BytesUsedForMemoryDB` | Total number of bytes allocated by MemoryDB for all purposes, including datasets, buffers, etc. | Bytes|
| `CommandAuthorizationFailures` | Number of failed attempts by users to run commands they do not have permission to call. You can use the [ACL LOG](https://redis.io/commands/acl-log) command to find more information about individual authentication failures. We recommend setting up alerts to detect unauthorized access attempts. | Count|
| `CurrConnections` | Number of client connections, excluding connections from read-only replicas. MemoryDB uses two to four connections to monitor clusters under various conditions. This is derived from the `connected_clients` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `CurrItems` | Number of items in the cache. This value is derived from the Redis `keyspace` statistics obtained by summing all keys across the entire key space. | Count|
| `DatabaseMemoryUsagePercentage` | Percentage of available memory used by the cluster. This is calculated using `used_memory/maxmemory` from [Redis INFO](http://redis.io/commands/info). | Percentage|
| `EngineCPUUtilization` | Provides CPU utilization for Redis engine threads. Since Redis is single-threaded, you can use this metric to analyze the load on the Redis process itself. The `EngineCPUUtilization` metric more accurately represents the Redis process. You can use it in conjunction with the `CPUUtilization` metric. The `CPUUtilization` metric exposes overall CPU usage for the server instance, including other operating system and management processes. For larger node types with four or more vCPUs, you can use the `EngineCPUUtilization` metric to monitor and set scaling thresholds. Note that on MemoryDB hosts, background processes monitor the host to provide a managed database experience. These background processes may consume a significant portion of the CPU workload. This affects large hosts with more than two vCPUs less, but affects smaller hosts with no more than two vCPUs more significantly. If you only monitor the `EngineCPUUtilization` metric, you will not discover situations where the host becomes overloaded due to high CPU usage by Redis or background monitoring processes. Therefore, we recommend that for hosts with no more than two vCPUs, you also monitor the `CPUUtilization` metric. | Percentage|
| `Evictions` | Number of keys evicted due to the `maxmemory` limit. This is derived from the `evicted_keys` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `IsPrimary` | Indicates whether the node is the primary node for the current partition. The metric can be 0 (non-primary node) or 1 (primary node). | Count|
| `KeyAuthorizationFailures` | Number of failed attempts by users to access keys they do not have permission to access. You can use the [ACL LOG](https://redis.io/commands/acl-log) command to find more information about individual authentication failures. We recommend setting up alerts to detect unauthorized access attempts. | Count|
| `KeyspaceHits` | Number of successful read-only key lookups in the main dictionary. This is derived from the `keyspace_hits` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `KeyspaceMisses` | Number of failed read-only key lookups in the main dictionary. This is derived from the `keyspace_misses` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `KeysTracked` | Percentage of Redis key tracking keys out of `tracking-table-max-keys`. Key tracking is used to help client-side caching and notify clients when keys are modified. | Count|
| `MaxReplicationThroughput` | Maximum replication throughput observed during the last measurement period. | Bytes per second|
| `MemoryFragmentationRatio` | Indicates the efficiency of memory allocation for the Redis engine. Certain thresholds will indicate different behaviors. A recommended value is to let fragmentation be greater than 1.0. This is calculated from the `mem_fragmentation_ratio statistic` in [Redis INFO](http://redis.io/commands/info). | Number|
| `NewConnections` | Total number of connections accepted by the server during this period. This is derived from the `total_connections_received` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `PrimaryLinkHealthStatus` | This status has two values: 0 or 1. A value of 0 means the data in the MemoryDB primary node is not synchronized with Redis on EC2. A value of 1 means the data is synchronized. | Boolean|
| `Reclaimed` | Total number of key expiration events. This is derived from the `expired_keys` statistics in [Redis INFO](http://redis.io/commands/info). | Count|
| `ReplicationBytes` | For nodes in a replicated configuration, `ReplicationBytes` reports the number of bytes sent by the primary to all its replicas. This metric represents the write load on the cluster. This is derived from the `master_repl_offset` statistics in [Redis INFO](http://redis.io/commands/info). | Bytes|
| `ReplicationDelayedWriteCommands` | Number of commands delayed due to exceeding maximum replication throughput. | Count|
| `ReplicationLag`                    | This metric applies only to nodes running as read-only replicas. It represents the amount of time (in seconds) that the replica lags behind in applying changes from the primary node. | Seconds|
| `CPUUtilization`                    | Percentage of CPU utilization for the entire host. Since Redis is single-threaded, we recommend you monitor the `EngineCPUUtilization` metric for nodes with 4 or more vCPUs. | Percentage     |
| `FreeableMemory`                    | Amount of idle memory available on the host. This is derived from RAM and buffer reported as free by the operating system. | Bytes       |
| `NetworkBytesIn`                    | Number of bytes read from the network by the host.                                   | Bytes       |
| `NetworkBytesOut`                   | Number of bytes sent by the instance on all network interfaces.                           | Bytes|
| `NetworkConntrackAllowanceExceeded` | Number of packets formed because connection tracking exceeded the maximum for the instance and new connections could not be established. This may result in packet loss for traffic entering and leaving the instance. | Count|
| `SwapUsage` | Amount of swap space used on the host. | Bytes|


## Objects {#object}

The structure of AWS MemoryDB object data collected can be seen in "Infrastructure - Custom"

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

> *Note: Fields in `tags`, `fields` may change with subsequent updates*