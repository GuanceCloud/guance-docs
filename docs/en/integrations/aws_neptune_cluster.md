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

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare the required Amazon Cloud AK in advance (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` permission to CloudWatch).

#### Script for Enabling the Managed Version

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If a cloud account has already been configured, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page.
6. On the cloud account details page, click the 【Integration】 button. In the `Not Installed` list, find `AWS Neptune Cluster`, click the 【Install】 button, and install it via the pop-up installation interface.

#### Manual Activation Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for: `guance_aws_neptune_cluster`.
2. After clicking 【Install】, input the relevant parameters: AWS AK ID, AK Secret, and account name.
3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.
4. After enabling, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration. You can also check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration:

[Amazon Cloud Monitoring Neptune Cluster Metric Details](https://docs.aws.amazon.com/en_us/neptune/latest/userguide/cw-metrics.html){:target="_blank"}


### Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `BackupRetentionPeriodStorageUsed`                           | Total backup storage used (in bytes) to support the backup retention window for the Neptune database cluster. This is included in the total reported by the TotalBackupStorageBilled metric. |
| `BufferCacheHitRatio`                           | The percentage of requests served from the buffer cache. This metric can be used to diagnose query latency since cache misses cause significant delays. If the cache hit ratio is below 99.9%, consider upgrading the instance type to cache more data in memory. |
| `ClusterReplicaLag`                           | For read-only replicas, the total lag (in milliseconds) when copying updates from the primary instance. |
| `ClusterReplicaLagMaximum`                           | The maximum delay amount between the primary instance and each Neptune database instance in the database cluster, measured in milliseconds. |
| `ClusterReplicaLagMinimum`                           | The minimum delay amount between the primary instance and each Neptune database instance in the database cluster, measured in milliseconds. |
| `CPUUtilization`                           | CPU utilization as a percentage. |
| `EngineUptime`                           | The length of time the instance has been running (in seconds). |
| `FreeableMemory`                           | The amount of available random access memory (in bytes). |
| `GlobalDbDataTransferBytes`                           | The number of bytes of redo log data transferred from the primary AWS region to the secondary AWS region in Neptune global databases. |
| `GlobalDbReplicatedWriteIO`                           | The number of write I/O operations replicated from the primary AWS region stored to the cluster volume in the secondary AWS region within the global database.<br/> For each database cluster in Neptune global databases, billing calculations use VolumeWriteIOPS to measure the write operations performed within that cluster. For the primary database cluster, billing calculations use GlobalDbReplicatedWriteIO to account for cross-region replication to the secondary database clusters. |
| `GlobalDbProgressLag`                           | The number of milliseconds that the secondary cluster lags behind the primary cluster for user transactions and system transactions. |
| `GremlinRequestsPerSec`                           | The number of requests per second to the Gremlin engine. |
| `GremlinWebSocketOpenConnections`                           | The number of times WebSocket connections have been opened with Neptune. |
| `LoaderRequestsPerSec`                           | The number of loader requests per second. |
| `MainRequestQueuePendingRequests`                           | The number of requests waiting in the input queue for execution. When requests exceed the maximum queue capacity, Neptune begins throttling requests. |
| `NCUUtilization`                           | At the cluster level, NCUUtilization reports the percentage of the maximum capacity used across the entire cluster. |
| `NetworkThroughput`                           | The network throughput for each instance in the Neptune database cluster receiving from clients and transmitting to clients, measured in bytes per second. This throughput does not include network traffic between instances and the cluster volume within the database cluster. |


## Objects {#object}

The object data structure collected for AWS Neptune Cluster can be seen in 「Infrastructure - Custom」.

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.account_name` is the instance ID, used as a unique identifier.