---
title: 'AWS DocumentDB'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS DocumentDB include read and write throughput, query latency, scalability, etc.'
__int_icon: 'icon/aws_documentdb'
dashboard:

  - desc: 'Built-in Views for AWS DocumentDB'
    path: 'dashboard/en/aws_documentdb'

monitor:
  - desc: 'AWS DocumentDB Monitors'
    path: 'monitor/en/aws_documentdb'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_documentdb'
---


<!-- markdownlint-disable MD025 -->
# AWS DocumentDB
<!-- markdownlint-enable -->

The displayed Metrics for AWS DocumentDB include read and write throughput, query latency, scalability, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from DocumentDB, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS DocumentDB Collection)" (ID: `guance_aws_documentdb`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We have collected some configurations by default. For details, see the Metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the corresponding task records and logs to check for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/cloud_watch.html#cloud_watch-metrics_list){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization` | The percentage of CPU utilized by the instance. |
| `FreeableMemory` | The amount of available random access memory (in bytes). |
| `FreeLocalStorage` | This metric reports the storage available on each instance for temporary tables and logs. This value depends on the instance class. You can increase the amount of storage available to the instance by selecting a larger instance class for the instance. |
| `SwapUsage` | The size of swap space used on the instance. |
| `DatabaseConnections` | The number of connections opened per minute on the instance. |
| `DatabaseConnectionsMax` | The maximum number of database connections opened on the instance per minute. |
| `DatabaseCursors` | The number of cursors opened per minute on the instance. |
| `DatabaseCursorsMax` | The maximum number of cursors opened on the instance per minute. |
| `DatabaseCursorsTimedOut` | The number of cursors timed out per minute. |
| `LowMemThrottleQueueDepth` | The queue depth of requests throttled due to insufficient available memory, frequency per minute. |
| `LowMemThrottleMaxQueueDepth` | The maximum queue depth of requests throttled due to insufficient available memory per minute. |
| `LowMemNumOperationsThrottled` | The number of requests throttled due to insufficient available memory per minute. |
| `ReadThroughput` | The average number of bytes read from disk per second. |
| `WriteThroughput` | The average number of bytes written to disk per second. |
| `ReadIOPS` | The average number of disk I/O operations read per second. Amazon DocumentDB reports Read and Write IOPS once per minute separately. |
| `NetworkThroughput` | The network throughput received from clients and sent to clients for each instance in the Amazon DocumentDB cluster, measured in bytes per second. This throughput does not include network traffic between instances in the cluster and the cluster volume. |
| `NetworkReceiveThroughput` | The network throughput received from clients for each instance in the cluster (measured in bytes per second). This throughput does not include network traffic between instances in the cluster and the cluster volume. |
| `NetworkTransmitThroughput` | The network throughput sent to clients for each instance in the cluster (measured in bytes per second). This throughput does not include network traffic between instances in the cluster and the cluster volume. |
| `WriteIOPS` | The average number of disk I/O operations written per second. When using `WriteIOPs` at the cluster level, it will be evaluated across all instances in the cluster. Read and Write IOPS are reported once per minute separately. |
| `ReadLatency` | The average time required for each disk I/O operation. |
| `WriteLatency` | The average time required for each disk I/O operation (in milliseconds). |
| `DBInstanceReplicaLag` | The total lag (in milliseconds) when copying updates from the primary instance to the replica instance. |
| `OpcountersQuery` | The number of queries issued per minute. |
| `OpcountersCommand` | The number of commands issued per minute. |
| `OpcountersDelete` | The number of delete operations issued per minute. |
| `OpcountersGetmore` | The number of get more issued per minute. |
| `OpcountersInsert` | The number of insert operations issued per minute. |
| `OpcountersUpdate` | The number of update operations issued per minute. |
| `DocumentsDeleted` | The number of documents deleted per minute. |
| `DocumentsInserted` | The number of documents inserted per minute. |
| `DocumentsReturned` | The number of documents returned per minute. |
| `DocumentsUpdated` | The number of documents updated per minute. |
| `TTLDeletedDocuments` | The number of documents deleted by TTLMonitor per minute. |
| `IndexBufferCacheHitRatio` | The percentage of index requests provided by the cache. After deleting indexes, collections, or databases, you might immediately see this metric spike above 100%. This will automatically correct itself after 60 seconds. This limitation will be fixed in future patch updates. |
| `BufferCacheHitRatio` | The percentage of requests provided by the buffer cache. |
| `DiskQueueDepth` | The number of concurrent write requests for the distributed storage volume. |
| `EngineUptime` | The length of time the instance has been running (in seconds). |


## Objects {#object}

The structure of the AWS DocumentDB objects collected can be viewed under "Infrastructure - Custom" for object data.

```json
{
  "measurement": "aws_documentdb",
  "tags": {
    "AvailabilityZone"          : "cn-north-1a",
    "CACertificateIdentifier"   : "rds-ca-2019",
    "DBClusterIdentifier"       : "docdb-2023-06",
    "DBInstanceArn"             : "arn:aws-cn:rds:cn-north-1:",
    "DBInstanceClass"           : "db.t3.medium",
    "DBInstanceIdentifier"      : "docdb-2023-07",
    "DBInstanceStatus"          : "available",
    "DbiResourceId"             : "db-CKJQ",
    "Engine"                    : "docdb",
    "EngineVersion"             : "3.6.0",
    "KmsKeyId"                  : "arn:aws-cn:kms:cn-north-1:",
    "cloud_provider"            : "aws",
    "name"                      : "docdb-2023-07"
  },
  "fields": {
    "DBSubnetGroup": "{}",
    "Endpoint": "{\"Address\": \".docdb.cn-north-1.amazonaws.com.cn\", \"HostedZoneId\": \"Z010911BG9\", \"Port\": 27017}",
    "InstanceCreateTime": "2023-07-28T05:45:10.004000Z",
    "PendingModifiedValues": "{}",
    "PubliclyAccessible": "False",
    "StatusInfos": "{}",
    "VpcSecurityGroups": "[{\"Status\": \"active\", \"VpcSecurityGroupId\": \"sg-08895f59\"}]",
    "message": "{Instance JSON information}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*