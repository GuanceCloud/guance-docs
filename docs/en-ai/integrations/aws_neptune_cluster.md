---
title: 'AWS Neptune Cluster'
tags: 
  - AWS
summary: 'The displayed metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function.'
__int_icon: 'icon/aws_neptune_cluster'

dashboard:
  - desc: 'Built-in View for AWS Neptune Cluster'
    path: 'dashboard/en/aws_neptune_cluster'

monitor:
  - desc: 'Monitor for AWS Neptune Cluster'
    path: 'monitor/en/aws_neptune_cluster'

---

<!-- markdownlint-disable MD025 -->
# AWS Neptune Cluster
<!-- markdownlint-enable -->

The displayed metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon Web Services AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permissions `CloudWatchReadOnlyAccess`).

To synchronize monitoring data from ECS cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Neptune Cluster Collection)" (ID: `guance_aws_lambda`)

After clicking 【Install】, enter the corresponding parameters: AWS AK ID, AWS AK SECRET.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts. Ensure that the 'regions' in the startup script match the actual regions where the instances are located.

After enabling, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


We default to collecting some configurations; for details, see the metrics section [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration. You can also check the task records and logs to ensure there are no anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration:

[Amazon Cloud Monitoring Neptune Cluster Metric Details](https://docs.aws.amazon.com/zh_cn/neptune/latest/userguide/cw-metrics.html){:target="_blank"}


### Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `BackupRetentionPeriodStorageUsed`                           | Total backup storage used to support the backup retention window of the Neptune database cluster (in bytes). This is included in the total reported by the TotalBackupStorageBilled metric. |
| `BufferCacheHitRatio`                           | The percentage of requests served by the buffer cache. This metric can be used to diagnose query latency because cache misses cause significant delays. If the cache hit ratio is below 99.9%, consider upgrading the instance type to cache more data in memory. |
| `ClusterReplicaLag`                           | The total lag (in milliseconds) when replicating updates from the primary instance for read-only replicas. |
| `ClusterReplicaLagMaximum`                           | The maximum delay (in milliseconds) between the primary instance and each Neptune database instance in the database cluster. |
| `ClusterReplicaLagMinimum`                           | The minimum delay (in milliseconds) between the primary instance and each Neptune database instance in the database cluster. |
| `CPUUtilization`                           | CPU utilization percentage. |
| `EngineUptime`                           | Length of time the instance has been running (in seconds). |
| `FreeableMemory`                           | Available random access memory (in bytes). |
| `GlobalDbDataTransferBytes`                           | Number of bytes of redo log data transferred from the primary AWS region to the secondary AWS region in Neptune global databases. |
| `GlobalDbReplicatedWriteIO`                           | Number of write I/O operations replicated from the primary AWS region to the cluster volume in the secondary AWS region within the global database.<br/> For each database cluster in Neptune global databases, billing calculations use VolumeWriteIOPS to measure the write operations performed within the cluster. For the primary database cluster, billing calculations use GlobalDbReplicatedWriteIO to account for cross-region replication to the secondary database clusters. |
| `GlobalDbProgressLag`                           | Milliseconds by which the secondary cluster lags behind the primary cluster for user transactions and system transactions. |
| `GremlinRequestsPerSec`                           | Number of requests per second to the Gremlin engine. |
| `GremlinWebSocketOpenConnections`                           | Number of open WebSocket connections to Neptune. |
| `LoaderRequestsPerSec`                           | Number of loader requests per second. |
| `MainRequestQueuePendingRequests`                           | Number of requests waiting in the input queue for execution. When requests exceed the maximum queue capacity, Neptune starts throttling requests. |
| `NCUUtilization`                           | At the cluster level, NCUUtilization reports the percentage of maximum capacity used across the entire cluster. |
| `NetworkThroughput`                           | Network throughput received from clients and transmitted to clients for each instance in the Neptune database cluster, measured in bytes per second. This throughput does not include network traffic between instances and cluster volumes within the database cluster. |


## Objects {#object}

The collected AWS Neptune Cluster object data structure can be viewed in "Infrastructure - Custom"

```json
{
  "measurement": "aws_neptune_cluster",
  "tags": {
    "DBClusterIdentifier"      :"test",
    "class"             :"aws_neptune_cluster",
    "cloud_provider"    :"aws",
    "FunctionName"      :"dataflux-alb",
    "name"              :"dataflux-alb",
    "PackageType"       :"Zip",
    "RegionId"          :"cn-northwest-1",
    "RevisionId"        :"5e52ff51-615a-4ecb-96b7-40083a7b4b62",
    "Role"              :"arn:aws-cn:iam::XXXX:role/service-role/s3--guance-role-3w34zo42",
    "Runtime"           :"python3.7",
    "Version"           :"$LATEST"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON data}",
    "AvailabilityZones"   : "{Availability Zone JSON data}",
    "message"             : "{Instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.account_name` is the instance ID, serving as a unique identifier.