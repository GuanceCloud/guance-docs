---
title: 'AWS RDS MySQL'
tags: 
  - AWS
summary: 'Use script packages from the script market in the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_rds_mysql'
dashboard:

  - desc: 'Built-in views for AWS RDS MySQL'
    path: 'dashboard/en/aws_rds_mysql'

monitor:
  - desc: 'AWS RDS MySQL Monitor'
    path: 'monitor/en/aws_rds_mysql'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_rds_mysql'
---


<!-- markdownlint-disable MD025 -->
# AWS RDS MySQL
<!-- markdownlint-enable -->


Use script packages from the script market in the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize AWS RDS monitoring data, we install the corresponding collection script: "Guance Integration (AWS-RDS Collection)" (ID: `guance_aws_rds`)

After clicking [Install], enter the required parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts automatically.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We have collected some configurations by default; for details, see [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. More metrics can be collected through configuration. For more details, see [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Monitoring.html){:target="_blank"}

### Amazon RDS Instance-Level Metrics in Amazon CloudWatch

The `AWS/RDS` namespace in Amazon CloudWatch includes the following instance-level metrics.

Note:

The Amazon RDS console might display metrics in units different from those sent to Amazon CloudWatch. For example, the Amazon RDS console might display a metric in megabytes (MB), while sending the same metric in bytes to Amazon CloudWatch.

| Metric                            | Console Name                                                   | Description                                                         | Unit              |
| :------------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- | :---------------- |
| `BinLogDiskUsage`               | **Binary Log Disk Usage (MB)**                              | The amount of disk space used by binary logs. Binary logs are created if automatic backups are enabled for MySQL and MariaDB instances (including read replicas). | Bytes              |
| `BurstBalance`                  | **Burst Balance (Percentage)**                                       | The percentage of available burst I/O credits in the general-purpose SSD (GP2) burst bucket.         | Percentage            |
| `CheckpointLag`                 | **Checkpoint Lag (Milliseconds)**                                       | Time since the last checkpoint. Applies only to RDS for PostgreSQL.    | Milliseconds              |
| `ConnectionAttempts`            | **Connection Attempts (Count)**           | Number of attempts to connect to the instance, regardless of success or failure.                           | Count              |
| `CPUUtilization`                | **CPU Utilization (Percentage)**                                     | CPU usage as a percentage.                                             | Percentage            |
| `CPUCreditUsage`                | **CPU Credit Usage (Count)**                                     | (T2 instances) CPU credits spent by the instance to maintain CPU utilization. One CPU credit equals one vCPU running at 100% utilization for one minute or equivalent combinations of vCPU, utilization, and time. For example, you can have one vCPU running at 50% utilization for two minutes, or two vCPU running at 25% utilization for two minutes. CPU credits are provided only every 5 minutes. If you specify a period greater than five minutes, use `Sum` statistics instead of `Average` statistics. | Credits (vCPU minutes)  |
| `CPUCreditBalance`              | **CPU Credit Balance (Count)**                                     | (T2 instances) CPU credits accumulated by the instance since launch. For T2 Standard, `CPUCreditBalance` also includes accumulated launch credits. Credits accumulate in the credit balance after they are earned; credits are deducted from the credit balance when they are spent. The credit balance has a maximum limit determined by the instance size. Any new credits earned after reaching this limit are discarded. For T2 Standard, launch credits do not count towards the limit. Instances can spend credits in `CPUCreditBalance` to burst above the baseline CPU utilization. While the instance is running, credits in `CPUCreditBalance` do not expire. When the instance stops, `CPUCreditBalance` is not retained, and all accumulated credits are lost. CPU credit metrics are provided only every 5 minutes. Launch credits in Amazon RDS work the same way as in Amazon EC2. For more information, see *Launch Credits* in the [Amazon Elastic Compute Cloud User Guide for Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-standard-mode-concepts.html#launch-credits){:target="_blank"}. | Credits (vCPU minutes) |
| `DatabaseConnections`           | **Database Connections (Count)**                                       | Number of client network connections to the database instance. The number of database sessions may be higher than the metric value because the metric value does not include the following: sessions that no longer have a network connection but have not yet been cleaned up by the database; sessions created by the database engine for its own purposes; sessions created by the parallel execution feature of the database engine; sessions created by the database engine scheduler. Amazon RDS connections | Count              |
| `DiskQueueDepth`                | **Queue Depth (Count)**                                         | Number of outstanding I/O operations (read/write requests) waiting to access the disk.            | Count              |
| `EBSByteBalance%`               | **EBS Byte Balance (Percentage)**                                   | Percentage of remaining throughput credits in the RDS database burst bucket. This metric is available only for basic monitoring. The metric value is based on the throughput and IOPS of all volumes, including the root volume, rather than just those containing database files. To find instance sizes supporting this metric, see the instances marked with an asterisk (*) in the [Default Optimized EBS Table](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} in the *Amazon EC2 User Guide for Linux Instances*. `Sum` statistics are not applicable to this metric. | Percentage            |
| `EBSIOBalance%`                 | **EBS IO Balance (Percentage)**                                    | Percentage of remaining I/O credits in the RDS database burst bucket. This metric is available only for basic monitoring. The metric value is based on the throughput and IOPS of all volumes, including the root volume, rather than just those containing database files. To find instance sizes supporting this metric, see the instances marked with an asterisk (*) in the [Default Optimized EBS Table](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} in the *Amazon EC2 User Guide for Linux Instances*. This metric differs from `BurstBalance`. For more information on using this metric, see [Improving Application Performance and Reducing Costs with Amazon EBS Optimized Instance Burst Capability](http://aws.amazon.com/blogs/compute/improving-application-performance-and-reducing-costs-with-amazon-ebs-optimized-instance-burst-capability/){:target="_blank"}. | Percentage            |
| `FailedSQLServerAgentJobsCount` | **Failed SQL Server Agent Jobs Count (Count/Minute) (失败的 SQL Server Agent 作业计数（计数/分钟）)** | Number of Microsoft SQL Server Agent jobs failed in the past minute.  | Count per minute        |
| `FreeableMemory`                | **Freeable Memory (MB)**                                            | Size of available random access memory. For MariaDB, MySQL, Oracle, and PostgreSQL database instances, this metric reports the value of the `MemAvailable` field in `/proc/meminfo`. | Bytes              |
| `FreeLocalStorage`              | **Free Local Storage (MB)**（可用本地存储 (MB)）             | Size of available local storage space. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. (This does not apply to Aurora Serverless v2.) | Bytes              |
| `FreeStorageSpace`              | **Free Storage Space (MB)**                                        | Size of available storage space.                                         | Bytes              |
| `MaximumUsedTransactionIDs`     | **Maximum Used Transaction IDs (Count)**                                  | Maximum transaction ID used. Applies only to PostgreSQL.                   | Count              |
| `NetworkReceiveThroughput`      | **Network Receive Throughput (MB/Second)**                                  | Incoming (received) network traffic to the database instance, including customer database traffic and Amazon RDS traffic for monitoring and replication. | Bytes per second        |
| `NetworkTransmitThroughput`     | **Network Transmit Throughput (MB/Second)**                                  | Outgoing (transmitted) network traffic from the database instance, including customer database traffic and Amazon RDS traffic for monitoring and replication. | Bytes per second        |
| `OldestReplicationSlotLag`      | **Oldest Replication Slot Lag (MB)**                                      | Lag size of the most lagging replica in receiving prewritten log (WAL) data. Applies to PostgreSQL. | Bytes              |
| `ReadIOPS`                      | **Read IOPS (Count/Second)**                                     | Average number of disk read I/O operations per second.                                | Count per second          |
| `ReadIOPSLocalStorage`          | **Read IOPS Local Storage (Count/Second)**（读取 IOPS 本地存储（计数/秒）） | Average number of disk read input/output operations per second to local storage. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. | Count per second          |
| `ReadLatency`                   | **Read Latency (Milliseconds)**                                         | Average time taken per disk I/O operation.                            | Milliseconds              |
| `ReadLatencyLocalStorage`       | **Read Latency Local Storage (Milliseconds)**（读取延迟本地存储（毫秒）） | Average time taken per disk I/O operation to local storage. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. | Milliseconds              |
| `ReadThroughput`                | **Read Throughput (MB/Second)**                                      | Average number of bytes read from disk per second.                                 | Bytes per second        |
| `ReadThroughputLocalStorage`    | **Read Throughput Local Storage (MB/Second)**（读取吞吐量本地存储（MB/秒）） | Average number of bytes read from disk to local storage per second. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. | Bytes per second        |
| `ReplicaLag`                    | **Replica Lag (Milliseconds)**                                         | Amount of time the read replica database instance lags behind the source database instance. Applies to read replicas of MariaDB, Microsoft SQL Server, MySQL, Oracle, and PostgreSQL. For Multi-AZ DB clusters, the difference in time between the latest transaction on the writer DB instance and the latest applied transaction on the reader DB instance. | Milliseconds              |
| `ReplicationSlotDiskUsage`      | **Replication Slot Disk Usage (MB)**                                | Disk space used by replication slot files. Applies to PostgreSQL.                | Bytes              |
| `SwapUsage`                     | **Swap Usage (MB)**                                      | Size of swap space used on the database instance. This metric is not available for SQL Server. | Bytes              |
| `TransactionLogsDiskUsage`      | **Transaction Logs Disk Usage (MB)**                                | Disk space used by transaction logs. Applies to PostgreSQL.                  | Bytes              |
| `TransactionLogsGeneration`     | **Transaction Logs Generation (MB/Second)**                                    | Size of transaction logs generated per second. Applies to PostgreSQL.                | Bytes per second        |
| `WriteIOPS`                     | **Write IOPS (Count/Second)**                                      | Average number of disk write I/O operations per second.                                | Count per second          |
| `WriteIOPSLocalStorage`         | **Write IOPS Local Storage (Count/Second)**（写入 IOPS 本地存储（计数/秒）） | Average number of disk write I/O operations per second to local storage. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. | Count per second          |
| `WriteLatency`                  | **Write Latency (Milliseconds)**                                         | Average time taken per disk I/O operation.                            | Milliseconds              |
| `WriteLatencyLocalStorage`      | **Write Latency Local Storage (Milliseconds)**（写入延迟本地存储（毫秒）） | Average time taken per disk I/O operation to local storage. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. | Milliseconds              |
| `WriteThroughput`               | **Write Throughput (MB/Second)**                                      | Average number of bytes written to disk per second.                                   | Bytes per second        |
| `WriteThroughputLocalStorage`   | **Write Throughput Local Storage (MB/Second)**（写入吞吐量本地存储（MB/秒）） | Average number of bytes written to disk per second to local storage. This metric applies only to database instance classes with NVMe SSD instance storage volumes. For information about Amazon EC2 instances with NVMe SSD instance storage volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance storage volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance storage volumes. | Bytes per second        |

### Amazon RDS Usage Metrics in Amazon CloudWatch

The `AWS/Usage` namespace in Amazon CloudWatch includes account-level usage metrics for Amazon RDS service quotas. CloudWatch automatically collects usage metrics for all AWS regions.

For more information, see [CloudWatch Usage Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Usage-Metrics.html){:target="_blank"} in the *Amazon CloudWatch User Guide*. For more information on quotas, see [Quotas and Limits for Amazon RDS](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Limits.html){:target="_blank"} and [Requesting a Quota Increase](https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html){:target="_blank"} in the *Service Quotas User Guide*.

| Metric                       | Description                                                         | Unit*    |
| :------------------------- | :----------------------------------------------------------- | :------- |
| `AllocatedStorage`         | Total allocated storage space for all database instances. Sum does not include temporary migration instances.         | Gigabytes |
| `DBClusterParameterGroups` | Number of DB cluster parameter groups in your AWS account. This count does not include default parameter groups. | Count     |
| `DBClusters`               | Number of Amazon Aurora DB clusters in your AWS account.            | Count     |
| `DBInstances`              | Number of DB instances in your AWS account.                           | Count     |
| `DBParameterGroups`        | Number of DB parameter groups in your AWS account. This count does not include default DB parameter groups. | Count     |
| `DBSecurityGroups`         | Number of security groups in your AWS account. This count does not include default security groups and default VPC security groups. | Count     |
| `DBSubnetGroups`           | Number of DB subnet groups in your AWS account. This count does not include default subnet groups. | Count     |
| `ManualClusterSnapshots`   | Number of manually created DB cluster snapshots in your AWS account. This count does not include invalid snapshots. | Count     |
| `ManualSnapshots`          | Number of manually created DB snapshots in your AWS account. This count does not include invalid snapshots. | Count     |
| `OptionGroups`             | Number of option groups in your AWS account. This count does not include default option groups.       | Count     |
| `ReservedDBInstances`      | Number of reserved DB instances in your AWS account. This count does not include disabled or rejected instances. | Count     |

\* Amazon RDS does not publish units for usage metrics to CloudWatch. These units appear only in the documentation.

## Objects {#object}

Data structure of collected AWS RDS MySQL objects, which can be viewed under "Infrastructure - Custom"

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
    "Endpoint"            : "{connection address JSON data}",
    "AllocatedStorage"    : 100,
    "message"             : "{instance JSON data}",
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Tip 2: `fields.message`, `fields.Endpoint` are JSON serialized strings.