---
title: 'AWS DocumentDB'
summary: 'Use the「Guance  Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance。'
__int_icon: 'icon/aws_documentdb'
dashboard:

  - desc: 'AWS DocumentDB Monitoring View'
    path: 'dashboard/zh/aws_documentdb'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/zh/aws_documentdb'

---


<!-- markdownlint-disable MD025 -->
# AWS DocumentDB
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance。


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation.

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake, You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of DocumentDB cloud resources, we install the corresponding collection script：「Guance Integration（AWS-RDSCollect）」(ID：`guance_aws_documentdb`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

After configuring Amazon CloudWatch - cloud monitoring, the default set of metrics is as follows. You can collect more metrics by configuring [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/cloud_watch.html#cloud_watch-metrics_list){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization` | The percentage of CPU used by an instance.                   |
| `FreeableMemory` | The amount of available random access memory, in bytes.      |
| `FreeLocalStorage` | This metric reports the amount of storage available to each instance for temporary tables and logs. This value depends on the instance class. You can increase the amount of free storage space for an instance by choosing a larger instance class for your instance. |
| `SwapUsage` | The amount of swap space used on the instance.               |
| `DatabaseConnections` | The number of connections open on an instance taken at a one-minute frequency. |
| `DatabaseConnectionsMax` | The maximum number of open database connections on an instance in a one-minute period. |
| `DatabaseCursors` | The number of cursors open on an instance taken at a one-minute frequency. |
| `DatabaseCursorsMax` | The maximum number of open cursors on an instance in a one-minute period. |
| `DatabaseCursorsTimedOut` | The number of cursors that timed out in a one-minute period. |
| `LowMemThrottleQueueDepth` | The queue depth for requests that are throttled due to low available memory taken at a one-minute frequency. |
| `LowMemThrottleMaxQueueDepth` | The maximum queue depth for requests that are throttled due to low available memory in a one-minute period. |
| `LowMemNumOperationsThrottled` | The number of requests that are throttled due to low available memory in a one-minute period. |
| `ReadThroughput` | The average number of bytes read from disk per second.       |
| `WriteThroughput` | The average number of bytes written to disk per second.      |
| `ReadIOPS` | The average number of disk read I/O operations per second. Amazon DocumentDB reports read and write IOPS separately, and on one-minute intervals. |
| `NetworkThroughput` | The amount of network throughput, in bytes per second, both received from and transmitted to clients by each instance in the Amazon DocumentDB cluster. This throughput doesn't include network traffic between instances in the cluster and the cluster volume. |
| `NetworkReceiveThroughput` | The amount of network throughput, in bytes per second, received from clients by each instance in the cluster. This throughput doesn't include network traffic between instances in the cluster and the cluster volume. |
| `NetworkTransmitThroughput` | The amount of network throughput, in bytes per second, sent to clients by each instance in the cluster. This throughput doesn't include network traffic between instances in the cluster and the cluster volume. |
| `WriteIOPS` | The average number of disk write I/O operations per second. When used on a cluster level, `WriteIOPs` are evaluated across all instances in the cluster. Read and write IOPS are reported separately, on 1-minute intervals. |
| `ReadLatency` | The average amount of time taken per disk I/O operation.     |
| `WriteLatency` | The average amount of time, in milliseconds, taken per disk I/O operation. |
| `DBInstanceReplicaLag` | The amount of lag, in milliseconds, when replicating updates from the primary instance to a replica instance. |
| `OpcountersQuery` | The number of queries issued in a one-minute period.         |
| `OpcountersCommand` | The number of commands issued in a one-minute period.        |
| `OpcountersDelete` | The number of delete operations issued in a one-minute period. |
| `OpcountersGetmore` | The number of get mores issued in a one-minute period.        |
| `OpcountersInsert` | The number of insert operations issued in a one-minute period. |
| `OpcountersUpdate` | The number of updated documents in a one-minute period.      |
| `DocumentsDeleted` | The number of deleted documents in a one-minute period.      |
| `DocumentsInserted` | The number of inserted documents in a one-minute period.     |
| `DocumentsReturned` | The number of returned documents in a one-minute period.     |
| `DocumentsUpdated` | The number of updated documents in a one-minute period.      |
| `TTLDeletedDocuments` | The number of documents deleted by a TTLMonitor in a one-minute period. |
| `IndexBufferCacheHitRatio` | The percentage of index requests that are served by the buffer cache. You might see a spike greater than 100% for the metric right after you drop an index, collection or database. This will automatically be corrected after 60 seconds. This limitation will be fixed in a future patch update. |
| `BufferCacheHitRatio` | The percentage of requests that are served by the buffer cache. |
| `DiskQueueDepth` | the number of concurrent write requests to the distributed storage volume. |
| `EngineUptime` | The amount of time, in seconds, that the instance has been running. |


## Object {#object}

The collected AWS DocumentDB object data structure can be viewed in "Infrastructure - Custom" under the object data.

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
    "message": "{Instance json 信息}"
  }
}

```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
