---
title: 'AWS Neptune Cluster'
tags: 
  - AWS
summary: 'The displayed Metrics for the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of Neptune Cluster functions.'
__int_icon: 'icon/aws_neptune_cluster'

dashboard:
  - desc: 'Built-in views for AWS Neptune Cluster'
    path: 'dashboard/en/aws_neptune_cluster'

monitor:
  - desc: 'Monitors for AWS Neptune Cluster'
    path: 'monitor/en/aws_neptune_cluster'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_neptune_cluster'
---


<!-- markdownlint-disable MD025 -->
# AWS Neptune Cluster
<!-- markdownlint-enable -->

The displayed Metrics for the AWS Neptune Cluster include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of Neptune Cluster functions.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Web Services AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only access `CloudWatchReadOnlyAccess`)

To synchronize monitoring data of ECS cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-Neptune Cluster Collection)" (ID: `guance_aws_lambda`)

After clicking 【Install】, input the corresponding parameters: AWS AK ID, AWS AK SECRET.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script. In the startup script, ensure that 'regions' match the actual regions where instances are located.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration." Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you must also enable the corresponding log collection script. If you need to collect billing information, you must enable the cloud billing collection script.


We default to collecting some configurations; for more details, see [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding tasks have the relevant automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. In the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom," check if asset information exists.
3. In the <<< custom_key.brand_name >>> platform, under "Metrics," check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration:

[Amazon CloudWatch Neptune Cluster Metrics Details](https://docs.aws.amazon.com/en_us/neptune/latest/userguide/cw-metrics.html){:target="_blank"}


### Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `BackupRetentionPeriodStorageUsed`                           | Total amount of backup storage used to support backups from the Neptune database cluster's backup retention window (in bytes). This is included in the total reported by the TotalBackupStorageBilled metric. |
| `BufferCacheHitRatio`                           | Percentage of requests served by the buffer cache. This Metric can be used to diagnose query latency since cache misses can cause significant delays. If the cache hit ratio drops below 99.9%, consider upgrading the instance type to cache more data in memory. |
| `ClusterReplicaLag`                           | Total lag (in milliseconds) when replicating updates from the primary instance to the read-only replica. |
| `ClusterReplicaLagMaximum`                           | Maximum delay (in milliseconds) between the primary instance and each Neptune database instance in the database cluster. |
| `ClusterReplicaLagMinimum`                           | Minimum delay (in milliseconds) between the primary instance and each Neptune database instance in the database cluster. |
| `CPUUtilization`                           | Percentage of CPU utilized. |
| `EngineUptime`                           | Length of time the instance has been running (in seconds). |
| `FreeableMemory`                           | Amount of random-access memory available (in bytes). |
| `GlobalDbDataTransferBytes`                           | Number of bytes of redo log data transferred from the primary server in one AWS region to the secondary AWS region in a Neptune global database. |
| `GlobalDbReplicatedWriteIO`                           | Number of write I/O operations replicated from the primary server in one AWS region stored to the cluster volume in the secondary AWS region in a global database.<br/> Billing for each database cluster in a Neptune global database is calculated using VolumeWriteIOPS to measure the number of write operations performed within that cluster. For the primary database cluster, billing is calculated using GlobalDbReplicatedWriteIO to account for cross-region replication to the secondary database clusters. |
| `GlobalDbProgressLag`                           | Milliseconds by which the secondary cluster lags behind the primary cluster for user transactions and system transactions. |
| `GremlinRequestsPerSec`                           | Number of requests per second to the Gremlin engine. |
| `GremlinWebSocketOpenConnections`                           | Number of times WebSocket connections are opened with Neptune. |
| `LoaderRequestsPerSec`                           | Number of loader requests per second. |
| `MainRequestQueuePendingRequests`                           | Number of requests waiting in the input queue to be executed. When requests exceed the maximum queue capacity, Neptune starts throttling requests. |
| `NCUUtilization`                           | At the cluster level, NCUUtilization reports the percentage of the maximum capacity used across the entire cluster. |
| `NetworkThroughput`                           | Network throughput received from clients and transmitted to clients for each instance in the Neptune database cluster, measured in bytes per second. This throughput does not include network traffic between instances in the database cluster and the cluster volume. |


## Objects {#object}

The collected AWS Neptune Cluster object data structure can be viewed in "Infrastructure - Custom."

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
    "AvailabilityZones"   : "{JSON data for availability zones}",
    "message"             : "{JSON data for instance}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.account_name` is the instance ID, used as a unique identifier.