---
title: 'AWS Neptune Cluster'
tags: 
  - AWS
summary: 'The displayed Metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function.'
__int_icon: 'icon/aws_neptune_cluster'

dashboard:
  - desc: 'Built-in Views for AWS Neptune Cluster'
    path: 'dashboard/en/aws_neptune_cluster'

monitor:
  - desc: 'Monitor for AWS Neptune Cluster'
    path: 'monitor/en/aws_neptune_cluster'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_neptune_cluster'
---


<!-- markdownlint-disable MD025 -->
# AWS Neptune Cluster
<!-- markdownlint-enable -->

The displayed Metrics of the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Neptune Cluster function.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant `CloudWatchReadOnlyAccess`).

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: 「Guance Integration (AWS-Neptune Cluster Collection)」(ID: `guance_aws_lambda`)

After clicking 【Install】, enter the corresponding parameters: AWS AK ID, AWS AK SECRET.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script. Ensure that the 'regions' in the startup script match the actual regions of the instances.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the task execution records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default Mearsurement set is as follows. More Metrics can be collected via configuration:

[Amazon Cloud Monitoring Neptune Cluster Metrics Details](https://docs.aws.amazon.com/zh_cn/neptune/latest/userguide/cw-metrics.html){:target="_blank"}


### Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `BackupRetentionPeriodStorageUsed`                           | Total backup storage used (in bytes) to support backups from the Neptune database cluster's backup retention window. This is included in the total reported by the TotalBackupStorageBilled metric. |
| `BufferCacheHitRatio`                           | The percentage of requests served by the buffer cache. This metric can be used to diagnose query latency, as cache misses can cause significant delays. If the cache hit ratio is below 99.9%, consider upgrading the instance type to cache more data in memory. |
| `ClusterReplicaLag`                           | The total lag (in milliseconds) when replicating updates from the primary instance to read-only replicas. |
| `ClusterReplicaLagMaximum`                           | The maximum delay (in milliseconds) between the primary instance and each Neptune database instance in the database cluster. |
| `ClusterReplicaLagMinimum`                           | The minimum delay (in milliseconds) between the primary instance and each Neptune database instance in the database cluster. |
| `CPUUtilization`                           | Percentage of CPU utilization. |
| `EngineUptime`                           | Length of time (in seconds) the instance has been running. |
| `FreeableMemory`                           | Amount of available random access memory (in bytes). |
| `GlobalDbDataTransferBytes`                           | Number of bytes of redo log data transferred from the primary server AWS region to the secondary AWS region in the Neptune global database. |
| `GlobalDbReplicatedWriteIO`                           | Number of write I/O operations replicated from the primary server AWS region to the secondary database cluster volume in the global database. Billing for Neptune global databases uses VolumeWriteIOPS to measure write operations within each database cluster. For the primary database cluster, billing uses GlobalDbReplicatedWriteIO to account for cross-region replication to secondary database clusters. |
| `GlobalDbProgressLag`                           | Milliseconds by which the secondary cluster lags behind the primary cluster for user transactions and system transactions. |
| `GremlinRequestsPerSec`                           | Number of requests per second to the Gremlin engine. |
| `GremlinWebSocketOpenConnections`                           | Number of open WebSocket connections to Neptune. |
| `LoaderRequestsPerSec`                           | Number of loader requests per second. |
| `MainRequestQueuePendingRequests`                           | Number of requests waiting in the input queue for execution. When requests exceed the maximum queue capacity, Neptune starts throttling requests. |
| `NCUUtilization`                           | At the cluster level, NCUUtilization reports the percentage of the maximum capacity used across the entire cluster. |
| `NetworkThroughput`                           | Network throughput (in bytes per second) received from clients and transmitted to clients by each instance in the Neptune database cluster. This does not include network traffic between instances and the cluster volume within the database cluster. |


## Objects {#object}

The structure of the AWS Neptune Cluster object data collected can be viewed in 「Infrastructure - Custom」

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
    "AvailabilityZones"   : "{JSON data of availability zones}",
    "message"             : "{JSON data of instance}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.account_name` is the instance ID, serving as a unique identifier.