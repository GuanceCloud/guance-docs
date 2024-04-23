---
title: 'AWS RDS MySQL'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_rds_mysql'
dashboard:

  - desc: 'AWS RDS MySQL Monitoring View'
    path: 'dashboard/zh/aws_rds_mysql'

monitor:
  - desc: 'AWS RDS MySQL Monitor'
    path: 'monitor/zh/aws_rds_mysql'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_rds_mysql'
---


<!-- markdownlint-disable MD025 -->
# AWS RDS MySQL
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of RDS MySQL cloud resources, we install the corresponding collection script：「Guance Integration（AWS-RDSCollect）」(ID：`guance_aws_rds`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
After configuring Amazon CloudWatch - cloud monitoring, the default set of metrics is as follows. You can collect more metrics by configuring [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Monitoring.html){:target="_blank"}

<!-- markdownlint-disable MD013 -->
### The Amazon CloudWatch instance-level metrics for Amazon RDS
<!-- markdownlint-enable -->

The `AWS/RDS` namespace in Amazon CloudWatch includes the following instance-level metrics.

Attention:

Amazon RDS console, metrics may be displayed in units different from those sent to Amazon CloudWatch. For example, the RDS console may display a metric in megabytes (MB), while the same metric is sent to Amazon CloudWatch in bytes.

| Metric                          | Console name                                          | Description                                                  | Applies to                   | Units                  |
| :------------------------------ | :---------------------------------------------------- | :----------------------------------------------------------- | :--------------------------- | :--------------------- |
| `BinLogDiskUsage`               | **Binary Log Disk Usage (MB)**                        | The amount of disk space occupied by binary logs. If automatic backups are enabled for MySQL and MariaDB instances, including read replicas, binary logs are created. | MariaDBMySQL                 | Bytes                  |
| `BurstBalance`                  | **Burst Balance (Percent)**                           | The percent of General Purpose SSD (gp2) burst-bucket I/O credits available. | All                          | Percent                |
| `CheckpointLag`                 | **Checkpoint Lag (Seconds)**                          | The amount of time since the most recent checkpoint.         |                              | Seconds                |
| `ConnectionAttempts`            | **Connection Attempts (Count)**                       | The number of attempts to connect to an instance, whether successful or not. |                              | Count                  |
| `CPUUtilization`                | **CPU Utilization (Percent)**                         | The percentage of CPU utilization.                           | All                          | Percentage             |
| `CPUCreditUsage`                | **CPU Credit Usage (Count)**                          | (T2 instances) The number of CPU credits spent by the instance for CPU utilization. One CPU credit equals one vCPU running at 100 percent utilization for one minute or an equivalent combination of vCPUs, utilization, and time. For example, you might have one vCPU running at 50 percent utilization for two minutes or two vCPUs running at 25 percent utilization for two minutes.CPU credit metrics are available at a five-minute frequency only. If you specify a period greater than five minutes, use the `Sum` statistic instead of the `Average` statistic. |                              | Credits (vCPU-minutes) |
| `CPUCreditBalance`              | **CPU Credit Balance (Count)**                        | (T2 instances) The number of earned CPU credits that an instance has accrued since it was launched or started. For T2 Standard, the `CPUCreditBalance` also includes the number of launch credits that have been accrued.Credits are accrued in the credit balance after they are earned, and removed from the credit balance when they are spent. The credit balance has a maximum limit, determined by the instance size. After the limit is reached, any new credits that are earned are discarded. For T2 Standard, launch credits don't count towards the limit.The credits in the `CPUCreditBalance` are available for the instance to spend to burst beyond its baseline CPU utilization.When an instance is running, credits in the `CPUCreditBalance` don't expire. When the instance stops, the `CPUCreditBalance` does not persist, and all accrued credits are lost.CPU credit metrics are available at a five-minute frequency only.Launch credits work the same way in Amazon RDS as they do in Amazon EC2. For more information, see [Launch credits](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-standard-mode-concepts.html#launch-credits){:target="_blank"} in the *Amazon Elastic Compute Cloud User Guide for Linux Instances*. |                              | Credits (vCPU-minutes) |
| `DatabaseConnections`           | **DB Connections (Count)**                            | The number of client network connections to the database instance.The number of database sessions can be higher than the metric value because the metric value does not include the following:Sessions that no longer have a network connection but which the database has not cleaned upSessions created by the database engine for its own purposesSessions created by the database engine's parallel execution capabilitiesSessions created by the database engine job schedulerAmazon RDS connections | All                          | Count                  |
| `DiskQueueDepth`                | **Queue Depth (Count)**                               | The number of outstanding I/Os (read/write requests) waiting to access the disk. | All                          | Count                  |
| `EBSByteBalance%`               | **EBS Byte Balance (Percent)**                        | The percentage of throughput credits remaining in the burst bucket of your RDS database. This metric is available for basic monitoring only.The metric value is based on the throughput and IOPS of all volumes, including the root volume, rather than on only those volumes containing database files.To find the instance sizes that support this metric, see the instance sizes with an asterisk (`*`) in the [EBS optimized by default](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} table in *Amazon EC2 User Guide for Linux Instances*. The `Sum` statistic is not applicable to this metric. | All                          | Percentage             |
| `EBSIOBalance%`                 | **EBS IO Balance (Percent)**                          | The percentage of I/O credits remaining in the burst bucket of your RDS database. This metric is available for basic monitoring only.The metric value is based on the throughput and IOPS of all volumes, including the root volume, rather than on only those volumes containing database files.To find the instance sizes that support this metric, see the instance sizes with an asterisk (`*`) in the [EBS optimized by default](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current) table in *Amazon EC2 User Guide for Linux Instances*. The `Sum` statistic is not applicable to this metric.This metric is different from `BurstBalance`. To learn how to use this metric, see [Improving application performance and reducing costs with Amazon EBS-Optimized Instance burst capability](http://aws.amazon.com/blogs/compute/improving-application-performance-and-reducing-costs-with-amazon-ebs-optimized-instance-burst-capability/){:target="_blank"}. | All                          | Percentage             |
| `FailedSQLServerAgentJobsCount` | **Failed SQL Server Agent Jobs Count (Count/Minute)** | The number of failed Microsoft SQL Server Agent jobs during the last minute. | Microsoft SQL Server         | Count per minute       |
| `FreeableMemory`                | **Freeable Memory (MB)**                              | The amount of available random access memory.For MariaDB, MySQL, Oracle, and PostgreSQL DB instances, this metric reports the value of the `MemAvailable` field of `/proc/meminfo`. | All                          | Bytes                  |
| `FreeStorageSpace`              | **Free Storage Space (MB)**                           | The amount of available storage space.                       | All                          | Bytes                  |
| `MaximumUsedTransactionIDs`     | **Maximum Used Transaction IDs (Count)**              | The maximum transaction IDs that have been used.             | PostgreSQL                   | Count                  |
| `NetworkReceiveThroughput`      | **Network Receive Throughput (MB/Second)**            | The incoming (receive) network traffic on the DB instance, including both customer database traffic and Amazon RDS traffic used for monitoring and replication. | All                          | Bytes per second       |
| `NetworkTransmitThroughput`     | **Network Transmit Throughput (MB/Second)**           | The outgoing (transmit) network traffic on the DB instance, including both customer database traffic and Amazon RDS traffic used for monitoring and replication. | All                          | Bytes per second       |
| `OldestReplicationSlotLag`      | **Oldest Replication Slot Lag (MB)**                  | The lagging size of the replica lagging the most in terms of write-ahead log (WAL) data received. | PostgreSQL                   | Bytes                  |
| `ReadIOPS`                      | **Read IOPS (Count/Second)**                          | The average number of disk read I/O operations per second.   | All                          | Count per second       |
| `ReadLatency`                   | **Read Latency (Seconds)**                            | The average amount of time taken per disk I/O operation.     | All                          | Seconds                |
| `ReadThroughput`                | **Read Throughput (MB/Second)**                       | The average number of bytes read from disk per second.       | All                          | Bytes per second       |
| `ReplicaLag`                    | **Replica Lag (Seconds)**                             | For read replica configurations, the amount of time a read replica DB instance lags behind the source DB instance. Applies to MariaDB, Microsoft SQL Server, MySQL, Oracle, and PostgreSQL read replicas.For Multi-AZ DB clusters, the difference in time between the latest transaction on the writer DB instance and the latest applied transaction on a reader DB instance. |                              | Seconds                |
| `ReplicationSlotDiskUsage`      | **Replica Slot Disk Usage (MB)**                      | The disk space used by replication slot files.               | PostgreSQL                   | Bytes                  |
| `SwapUsage`                     | **Swap Usage (MB)**                                   | The amount of swap space used on the DB instance.            | MariaDBMySQLOraclePostgreSQL | Bytes                  |
| `TransactionLogsDiskUsage`      | **Transaction Logs Disk Usage (MB)**                  | The disk space used by transaction logs.                     | PostgreSQL                   | Bytes                  |
| `TransactionLogsGeneration`     | **Transaction Logs Generation (MB/Second)**           | The size of transaction logs generated per second.           | PostgreSQL                   | Bytes per second       |
| `WriteIOPS`                     | **Write IOPS (Count/Second)**                         | The average number of disk write I/O operations per second.  | All                          | Count per second       |
| `WriteLatency`                  | **Write Latency (Seconds)**                           | The average amount of time taken per disk I/O operation.     | All                          | Seconds                |
| `WriteThroughput`               | **Write Throughput (MB/Second)**                      | The average number of bytes written to disk per second.      | All                          | Bytes per second       |


### Amazon CloudWatch usage metrics for Amazon RDS

The `AWS/Usage` namespace in Amazon CloudWatch includes account-level usage metrics for your Amazon RDS service quotas. CloudWatch collects usage metrics automatically for all AWS Regions.

For more information, see [CloudWatch usage metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Usage-Metrics.html){:target="_blank"} in the *Amazon CloudWatch User Guide*. For more information about quotas, see [Quotas and constraints for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html){:target="_blank"} and [Requesting a quota increase](https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html){:target="_blank"} in the *Service Quotas User Guide*.

| Metric                     | Description                                                  | Units*    |
| :------------------------- | :----------------------------------------------------------- | :-------- |
| `AllocatedStorage`         | The total storage for all DB instances. The sum excludes temporary migration instances. | Gigabytes |
| `DBClusterParameterGroups` | The number of DB cluster parameter groups in your AWS account. The count excludes default parameter groups. | Count     |
| `DBClusters`               | The number of Amazon Aurora DB clusters in your AWS account. | Count     |
| `DBInstances`              | The number of DB instances in your AWS account.              | Count     |
| `DBParameterGroups`        | The number of DB parameter groups in your AWS account. The count excludes the default DB parameter groups. | Count     |
| `DBSecurityGroups`         | The number of security groups in your AWS account. The count excludes the default security group and the default VPC security group. | Count     |
| `DBSubnetGroups`           | The number of DB subnet groups in your AWS account. The count excludes the default subnet group. | Count     |
| `ManualClusterSnapshots`   | The number of manually created DB cluster snapshots in your AWS account. The count excludes invalid snapshots. | Count     |
| `ManualSnapshots`          | The number of manually created DB snapshots in your AWS account. The count excludes invalid snapshots. | Count     |
| `OptionGroups`             | The number of option groups in your AWS account. The count excludes the default option groups. | Count     |
| `ReservedDBInstances`      | The number of reserved DB instances in your AWS account. The count excludes retired or declined instances. | Count     |

\* Amazon RDS doesn't publish units for usage metrics to CloudWatch. The units only appear in the documentation.

## Object {#object}

The collected AWS RDS MySQL object data structure can be viewed in "Infrastructure - Custom" under the object data.

```json
{
  "measurement": "aws_rds",
  "tags": {
    "name"                     : "xxxxx",
    "RegionId"                 : "cn-northwest-1",
    "Engine"                   : "mysql",
    "DBInstanceClass"          : "db.t3.medium",
    "DBInstanceIdentifier"     : "xxxxxx",
    "AvailabilityZone"         : "cn-northwest-1c",
    "SecondaryAvailabilityZone": "cn-northwest-1d"
  },
  "fields": {
    "InstanceCreateTime"  : "2018-03-28T19:54:07.871Z",
    "LatestRestorableTime": "2018-03-28T19:54:07.871Z",
    "Endpoint"            : "{连接地址 JSON data}",
    "AllocatedStorage"    : 100,
    "message"             : "{Instance JSON data}",
  }
}
```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.Endpoint`、 are JSON serialized strings.


