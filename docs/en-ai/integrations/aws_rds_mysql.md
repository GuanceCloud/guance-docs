---
title: 'AWS RDS MySQL'
tags: 
  - AWS
summary: 'Use the "Guance Cloud Sync" series script package from the script market to synchronize cloud monitoring and cloud asset data to Guance'
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


Use the "Guance Cloud Sync" series script package from the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare the required Amazon AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize AWS RDS monitoring data, we install the corresponding collection script: "Guance Integration (AWS-RDS Collection)" (ID: `guance_aws_rds`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for more details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric sets are as follows. You can collect more metrics through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Monitoring.html){:target="_blank"}

### Amazon RDS Instance-Level Metrics in Amazon CloudWatch

The `AWS/RDS` namespace in Amazon CloudWatch includes the following instance-level metrics.

Note:

The Amazon RDS console might display metrics in different units than those sent to Amazon CloudWatch. For example, the Amazon RDS console might display a metric in megabytes (MB), while sending it to Amazon CloudWatch in bytes.

| Metric                            | Console Name                                                   | Description                                                         | Unit              |
| :------------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- | :---------------- |
| `BinLogDiskUsage`               | **Binary Log Disk Usage (MB)**                              | Size of disk space occupied by binary logs. If automatic backups are enabled for MySQL and MariaDB instances (including read replicas), binary logs are created. | Bytes              |
| `BurstBalance`                  | **Burst Balance (Percentage)**                                       | Percentage of available I/O credits in the burst bucket for General Purpose SSD (GP2).         | Percentage            |
| `CheckpointLag`                 | **Checkpoint Lag (Milliseconds)**                                       | Time since the last checkpoint. Only applicable to RDS for PostgreSQL.    | Milliseconds              |
| `ConnectionAttempts`            | **Connection Attempts (Count)**           | Number of attempts to connect to the instance, regardless of success or failure.                           | Count              |
| `CPUUtilization`                | **CPU Utilization (Percentage)**                                     | Percentage of CPU usage.                                             | Percentage            |
| `CPUCreditUsage`                | **CPU Credit Usage (Count)**                                     | (T2 instances) Number of CPU credits spent by the instance to maintain CPU utilization. One CPU credit equals one vCPU running at 100% utilization for one minute or equivalent combinations of vCPU, utilization, and time. For example, you can have one vCPU running at 50% utilization for two minutes, or two vCPUs running at 25% utilization for two minutes. CPU credit metrics are only provided every 5 minutes. If you specify a time period greater than five minutes, use `Sum` statistics rather than `Average` statistics. | Credits (vCPU minutes)  |
| `CPUCreditBalance`              | **CPU Credit Balance (Count)**                                     | (T2 instances) Number of CPU credits accumulated by the instance since launch. For T2 Standard, `CPUCreditBalance` also includes accumulated launch credits. After credits are earned, they accumulate in the credit balance; after credits are spent, they are deducted from the credit balance. The credit balance has a maximum limit determined by the instance size. After reaching the limit, any newly earned credits are discarded. For T2 Standard, launch credits do not count towards the limit. Instances can spend credits from `CPUCreditBalance` to burst above the baseline CPU utilization. While the instance is running, credits in `CPUCreditBalance` do not expire. When the instance stops, `CPUCreditBalance` is not retained, and all accumulated credits are lost. CPU credit metrics are only provided every 5 minutes. Launch credits work the same way in Amazon RDS as they do in Amazon EC2. For more information, see *Launch Credits* in the [Amazon Elastic Compute Cloud User Guide for Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-standard-mode-concepts.html#launch-credits){:target="_blank"}. | Credits (vCPU minutes) |
| `DatabaseConnections`           | **Database Connections (Count)**                                       | Number of client network connections to the database instance. The number of database sessions may be higher because this metric does not include sessions that no longer have a network connection but have not yet been cleaned up by the database, sessions created by the database engine for its own purposes, sessions created by the database engine's parallel execution feature, or sessions created by the database engine's task scheduler. Amazon RDS connections | Count              |
| `DiskQueueDepth`                | **Queue Depth (Count)**                                         | Number of pending I/O (read/write requests) waiting to access the disk.            | Count              |
| `EBSByteBalance%`               | **EBS Byte Balance (Percentage)**                                   | Percentage of remaining throughput credits in the RDS database burst bucket. This metric is only available for basic monitoring. The metric value is based on throughput and IOPS across all volumes, including the root volume, not just those containing database files. To find instance sizes that support this metric, see the instances marked with an asterisk (*) in the [Default Optimized EBS Table](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} in the *Amazon EC2 User Guide for Linux Instances*. `Sum` statistics are not applicable to this metric. | Percentage            |
| `EBSIOBalance%`                 | **EBS IO Balance (Percentage)**                                    | Percentage of remaining I/O credits in the RDS database burst bucket. This metric is only available for basic monitoring. The metric value is based on throughput and IOPS across all volumes, including the root volume, not just those containing database files. To find instance sizes that support this metric, see the instances marked with an asterisk (*) in the [Default Optimized EBS Table](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} in the *Amazon EC2 User Guide for Linux Instances*. This metric differs from `BurstBalance`. For more information on how to use this metric, see [Improving Application Performance and Reducing Costs with Amazon EBS Optimized Instance Burst Capability](http://aws.amazon.com/blogs/compute/improving-application-performance-and-reducing-costs-with-amazon-ebs-optimized-instance-burst-capability/){:target="_blank"}. | Percentage            |
| `FailedSQLServerAgentJobsCount` | **Failed SQL Server Agent Jobs Count (Count/Minute)** | Number of Microsoft SQL Server Agent jobs failed in the past 1 minute.  | Count per minute        |
| `FreeableMemory`                | **Available Memory (MB)**                                            | Size of available random access memory. For MariaDB, MySQL, Oracle, and PostgreSQL database instances, this metric reports the value of the `MemAvailable` field in `/proc/meminfo`. | Bytes              |
| `FreeLocalStorage`              | **Free Local Storage (MB)**             | Size of available local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. (This does not apply to Aurora Serverless v2.) | Bytes              |
| `FreeStorageSpace`              | **Available Storage Space (MB)**                                        | Size of available storage space.                                         | Bytes              |
| `MaximumUsedTransactionIDs`     | **Maximum Used Transaction IDs (Count)**                                  | Maximum transaction ID used. Only applicable to PostgreSQL.                   | Count              |
| `NetworkReceiveThroughput`      | **Network Receive Throughput (MB/Second)**                                  | Incoming (received) network traffic to the database instance, including customer database traffic and Amazon RDS traffic for monitoring and replication. | Bytes per second        |
| `NetworkTransmitThroughput`     | **Network Transmit Throughput (MB/Second)**                                  | Outgoing (transmitted) network traffic from the database instance, including customer database traffic and Amazon RDS traffic for monitoring and replication. | Bytes per second        |
| `OldestReplicationSlotLag`      | **Oldest Replication Slot Lag (MB)**                                      | Lag size of the most lagging replica in receiving prewritten log (WAL) data. Applicable to PostgreSQL. | Bytes              |
| `ReadIOPS`                      | **Read IOPS (Count/Second)**                                     | Average number of disk read I/O operations per second.                                | Count per second          |
| `ReadIOPSLocalStorage`          | **Read IOPS Local Storage (Count/Second)** | Average number of disk read I/O operations per second to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Count per second          |
| `ReadLatency`                   | **Read Latency (Milliseconds)**                                         | Average time required for each disk I/O operation.                            | Milliseconds              |
| `ReadLatencyLocalStorage`       | **Read Latency Local Storage (Milliseconds)** | Average time required for each disk I/O operation to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Milliseconds              |
| `ReadThroughput`                | **Read Throughput (MB/Second)**                                      | Average number of bytes read from disk per second.                                 | Bytes per second        |
| `ReadThroughputLocalStorage`    | **Read Throughput Local Storage (MB/Second)** | Average number of bytes read from disk to local storage per second. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Bytes per second        |
| `ReplicaLag`                    | **Replica Lag (Milliseconds)**                                         | Amount of time a read replica database instance lags behind the source database instance in a read replica configuration. Applicable to MariaDB, Microsoft SQL Server, MySQL, Oracle, and PostgreSQL read replicas. For multi-AZ DB clusters, it is the time difference between the latest transaction on the writer DB instance and the latest applied transaction on the reader DB instance. | Milliseconds              |
| `ReplicationSlotDiskUsage`      | **Replication Slot Disk Usage (MB)**                                | Disk space used by replication slot files. Applicable to PostgreSQL.                | Bytes              |
| `SwapUsage`                     | **Swap Usage (MB)**                                      | Size of swap space used on the database instance. This metric is not available for SQL Server. | Bytes              |
| `TransactionLogsDiskUsage`      | **Transaction Logs Disk Usage (MB)**                                | Disk space used by transaction logs. Applicable to PostgreSQL.                  | Bytes              |
| `TransactionLogsGeneration`     | **Transaction Logs Generation (MB/Second)**                                    | Size of transaction logs generated per second. Applicable to PostgreSQL.                | Bytes per second        |
| `WriteIOPS`                     | **Write IOPS (Count/Second)**                                      | Average number of disk write I/O operations per second.                                | Count per second          |
| `WriteIOPSLocalStorage`         | **Write IOPS Local Storage (Count/Second)** | Average number of disk write I/O operations per second to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Count per second          |
| `WriteLatency`                  | **Write Latency (Milliseconds)**                                         | Average time required for each disk I/O operation.                            | Milliseconds              |
| `WriteLatencyLocalStorage`      | **Write Latency Local Storage (Milliseconds)** | Average time required for each disk I/O operation to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Milliseconds              |
| `WriteThroughput`               | **Write Throughput (MB/Second)**                                      | Average number of bytes written to disk per second.                                   | Bytes per second        |
| `WriteThroughputLocalStorage`   | **Write Throughput Local Storage (MB/Second)** | Average number of bytes written to disk to local storage per second. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Bytes per second        |

### Amazon RDS Usage Metrics in Amazon CloudWatch

The `AWS/Usage` namespace in Amazon CloudWatch includes account-level usage metrics for Amazon RDS service quotas. CloudWatch automatically collects usage metrics for all AWS regions.

For more information, see [CloudWatch Usage Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Usage-Metrics.html){:target="_blank"} in the *Amazon CloudWatch User Guide*. For more information about quotas, see [Quotas and Limits for Amazon RDS](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Limits.html){:target="_blank"} and [Requesting an Increase in Quota](https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html){:target="_blank"} in the *Service Quotas User Guide*.

| Metric                       | Description                                                         | Unit*    |
| :------------------------- | :----------------------------------------------------------- | :------- |
| `AllocatedStorage`         | Total allocated storage space for all DB instances. The sum does not include temporary migration instances.         | Gigabytes |
| `DBClusterParameterGroups` | Number of DB cluster parameter groups in your AWS account. This count does not include default parameter groups. | Count     |
| `DBClusters`               | Number of Amazon Aurora DB clusters in your AWS account.            | Count     |
| `DBInstances`              | Number of DB instances in your AWS account.                           | Count     |
| `DBParameterGroups`        | Number of DB parameter groups in your AWS account. This count does not include default DB parameter groups. | Count     |
| `DBSecurityGroups`         | Number of security groups in your AWS account. This count does not include default security groups and default VPC security groups. | Count     |
| `DBSubnetGroups`           | Number of DB subnet groups in your AWS account. This count does not include default subnet groups. | Count     |
| `ManualClusterSnapshots`   | Number of manual DB cluster snapshots in your AWS account. This count does not include invalid snapshots. | Count     |
| `ManualSnapshots`          | Number of manual DB snapshots in your AWS account. This count does not include invalid snapshots. | Count     |
| `OptionGroups`             | Number of option groups in your AWS account. This count does not include default option groups.       | Count     |
| `ReservedDBInstances`      | Number of reserved DB instances in your AWS account. This count does not include disabled or rejected instances. | Count     |

\* Amazon RDS does not publish the units of usage metrics to CloudWatch. These units appear only in the documentation.

## Objects {#object}

Structure of collected AWS RDS MySQL object data, which can be viewed under "Infrastructure - Custom"

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

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: `tags.name` value is the instance ID, used for unique identification.
>
> Tip 2: `fields.message`, `fields.Endpoint` are serialized JSON strings.