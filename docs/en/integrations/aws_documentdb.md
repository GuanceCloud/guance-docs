---
title: 'AWS DocumentDB'
tags: 
  - AWS
summary: 'The metrics displayed for AWS DocumentDB include read and write throughput, query latency, and scalability.'
__int_icon: 'icon/aws_documentdb'
dashboard:

  - desc: 'Built-in views for AWS DocumentDB'
    path: 'dashboard/en/aws_documentdb'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/en/aws_documentdb'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_documentdb'
---


<!-- markdownlint-disable MD025 -->
# AWS DocumentDB
<!-- markdownlint-enable -->

The metrics displayed for AWS DocumentDB include read and write throughput, query latency, and scalability.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from DocumentDB, we install the corresponding collection script: "Guance Integration (AWS DocumentDB Collection)" (ID: `guance_aws_documentdb`)

After clicking [Install], enter the required parameters: Amazon AK and Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm that the corresponding task has the automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/cloud_watch.html#cloud_watch-metrics_list){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization` | The percentage of CPU utilized by the instance. |
| `FreeableMemory` | The amount of available random access memory (in bytes). |
| `FreeLocalStorage` | This metric reports the storage available on each instance for temporary tables and logs. This value depends on the instance class. You can increase the storage space available to the instance by selecting a larger instance class. |
| `SwapUsage` | The size of the swap space used on the instance. |
| `DatabaseConnections` | The number of connections opened on the instance per minute. |
| `DatabaseConnectionsMax` | The maximum number of database connections opened on the instance per minute. |
| `DatabaseCursors` | The number of cursors opened on the instance per minute. |
| `DatabaseCursorsMax` | The maximum number of cursors opened on the instance per minute. |
| `DatabaseCursorsTimedOut` | The number of cursors timed out per minute. |
| `LowMemThrottleQueueDepth` | The depth of the queue of requests throttled due to insufficient available memory, measured per minute. |
| `LowMemThrottleMaxQueueDepth` | The maximum depth of the queue of requests throttled due to insufficient available memory per minute. |
| `LowMemNumOperationsThrottled` | The number of requests throttled due to insufficient available memory per minute. |
| `ReadThroughput` | The average number of bytes read from disk per second. |
| `WriteThroughput` | The average number of bytes written to disk per second. |
| `ReadIOPS` | The average number of disk read I/O operations per second. Amazon DocumentDB reports read and write IOPS separately every minute. |
| `NetworkThroughput` | The network throughput received from and sent to clients by each instance in the Amazon DocumentDB cluster, measured in bytes per second. This throughput does not include network traffic between instances and cluster volumes within the cluster. |
| `NetworkReceiveThroughput` | The network throughput received from clients by each instance in the cluster (in bytes per second). This throughput does not include network traffic between instances and cluster volumes within the cluster. |
| `NetworkTransmitThroughput` | The network throughput sent to clients by each instance in the cluster (in bytes per second). This throughput does not include network traffic between instances and cluster volumes within the cluster. |
| `WriteIOPS` | The average number of disk write I/O operations per second. When used at the cluster level, `WriteIOPs` evaluates across all instances in the cluster. Read and write IOPS are reported separately every minute. |
| `ReadLatency` | The average time required for each disk I/O operation. |
| `WriteLatency` | The average time required for each disk I/O operation (in milliseconds). |
| `DBInstanceReplicaLag` | The total lag in milliseconds when replicating updates from the primary instance to replica instances. |
| `OpcountersQuery` | The number of queries issued per minute. |
| `OpcountersCommand` | The number of commands issued per minute. |
| `OpcountersDelete` | The number of delete operations issued per minute. |
| `OpcountersGetmore` | The number of get more operations issued per minute. |
| `OpcountersInsert` | The number of insert operations issued per minute. |
| `OpcountersUpdate` | The number of update operations issued per minute. |
| `DocumentsDeleted` | The number of documents deleted per minute. |
| `DocumentsInserted` | The number of documents inserted per minute. |
| `DocumentsReturned` | The number of documents returned per minute. |
| `DocumentsUpdated` | The number of documents updated per minute. |
| `TTLDeletedDocuments` | The number of documents deleted by TTLMonitor per minute. |
| `IndexBufferCacheHitRatio` | The percentage of index requests served by the cache. After deleting indexes, collections, or databases, you may see a spike in this metric greater than 100%. This will automatically correct itself after 60 seconds. This limitation will be fixed in future patch updates. |
| `BufferCacheHitRatio` | The percentage of requests served by the buffer cache. |
| `DiskQueueDepth` | The number of concurrent write requests to the distributed storage volume. |
| `EngineUptime` | The length of time the instance has been running (in seconds). |


## Objects {#object}

The structure of AWS DocumentDB objects collected can be viewed under "Infrastructure - Custom"

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
    "message": "{instance JSON information}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
