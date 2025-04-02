---
title: 'AWS DocumentDB'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS DocumentDB include read and write throughput, query latency, scalability, etc.'
__int_icon: 'icon/aws_documentdb'
dashboard:

  - desc: 'Built-in views for AWS DocumentDB'
    path: 'dashboard/en/aws_documentdb'

monitor:
  - desc: 'Monitor for AWS DocumentDB'
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

If you deploy Func manually, refer to [Manual Deployment of Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

#### Script for enabling the managed version

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information. If you have already configured cloud account information, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the relevant configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click the corresponding cloud account and enter the details page.
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS DocumentDB`, click the 【Install】 button, and install it via the installation interface.

#### Manual Enablement Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for: `guance_aws_documentdb`.
2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.
3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.
4. After enabling, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/documentdb/latest/developerguide/cloud_watch.html#cloud_watch-metrics_list){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization` | Percentage of CPU used by the instance. |
| `FreeableMemory` | Available amount of random access memory (in bytes). |
| `FreeLocalStorage` | This metric reports the storage available on each instance for temporary tables and logs. This value depends on the instance class. You can increase the amount of storage available to an instance by choosing a larger instance class for the instance. |
| `SwapUsage` | Size of swap space used on the instance. |
| `DatabaseConnections` | Number of connections opened per minute on the instance. |
| `DatabaseConnectionsMax` | Maximum number of database connections opened per minute on the instance. |
| `DatabaseCursors` | Number of cursors opened per minute on the instance. |
| `DatabaseCursorsMax` | Maximum number of cursors opened per minute on the instance. |
| `DatabaseCursorsTimedOut` | Number of cursors timed out per minute on the instance. |
| `LowMemThrottleQueueDepth` | Queue depth of requests throttled due to insufficient available memory, frequency per minute. |
| `LowMemThrottleMaxQueueDepth` | Maximum queue depth of requests throttled per minute due to insufficient available memory. |
| `LowMemNumOperationsThrottled` | Number of requests throttled per minute due to insufficient available memory. |
| `ReadThroughput` | Average number of bytes read per second from disk. |
| `WriteThroughput` | Average number of bytes written per second to disk. |
| `ReadIOPS` | Average number of disk read I/O operations per second. Amazon DocumentDB reports read and write IOPS separately each minute. |
| `NetworkThroughput` | Network throughput received from clients and sent to clients for each instance in an Amazon DocumentDB cluster, measured in bytes per second. This throughput does not include network traffic between instances in the cluster and the cluster volume. |
| `NetworkReceiveThroughput` | Network throughput received from clients for each instance in the cluster (measured in bytes per second). This throughput does not include network traffic between instances in the cluster and the cluster volume. |
| `NetworkTransmitThroughput` | Network throughput sent to clients for each instance in the cluster (measured in bytes per second). This throughput does not include network traffic between instances in the cluster and the cluster volume. |
| `WriteIOPS` | Average number of disk write I/O operations per second. When using `WriteIOPs` at the cluster level, it will be evaluated across all instances in the cluster. Read and write IOPS are reported separately each minute. |
| `ReadLatency` | Average time required for each disk I/O operation. |
| `WriteLatency` | Average time required for each disk I/O operation (in milliseconds). |
| `DBInstanceReplicaLag` | Total lag in milliseconds when replicating updates from the primary instance to the replica instance. |
| `OpcountersQuery` | Number of queries issued per minute. |
| `OpcountersCommand` | Number of commands issued per minute. |
| `OpcountersDelete` | Number of delete operations issued per minute. |
| `OpcountersGetmore` | Number of get more issued per minute. |
| `OpcountersInsert` | Number of insert operations issued per minute. |
| `OpcountersUpdate` | Number of update operations issued per minute. |
| `DocumentsDeleted` | Number of documents deleted per minute. |
| `DocumentsInserted` | Number of documents inserted per minute. |
| `DocumentsReturned` | Number of documents returned per minute. |
| `DocumentsUpdated` | Number of documents updated per minute. |
| `TTLDeletedDocuments` | Number of documents deleted by TTLMonitor per minute. |
| `IndexBufferCacheHitRatio` | Percentage of index requests provided by the cache. After deleting indexes, collections, or databases, you may immediately see a spike in this metric greater than 100%. This will automatically correct after 60 seconds. This limitation will be fixed in future patch updates. |
| `BufferCacheHitRatio` | Percentage of requests provided by buffer caching. |
| `DiskQueueDepth` | Number of concurrent write requests to the distributed storage volume. |
| `EngineUptime` | Length of time the instance has been running (in seconds). |


## Objects {#object}

The object data structure collected for AWS DocumentDB can be viewed under 「Infrastructure - Custom」

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
    "message": "{instance json information}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*