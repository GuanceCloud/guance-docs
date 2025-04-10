---
title: 'AWS RDS MySQL'
tags: 
  - AWS
summary: 'Use the script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_rds_mysql'
dashboard:

  - desc: 'AWS RDS MySQL built-in views'
    path: 'dashboard/en/aws_rds_mysql'

monitor:
  - desc: 'AWS RDS MySQL monitors'
    path: 'monitor/en/aws_rds_mysql'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_rds_mysql'
---


<!-- markdownlint-disable MD025 -->
# AWS RDS MySQL
<!-- markdownlint-enable -->


Use the script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Script Installation

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

#### Hosted Edition Script Activation

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If you have already configured cloud account information before, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS RDS MySQL`, click the 【Install】 button, and follow the prompts to complete the installation.

#### Manual Script Activation

1. Log in to the Func console, click 【Script Market】, go to the official script market, and search for: `guance_aws_rds`.

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts automatically.

4. After activation, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. Confirm under 「Management / Automatic Trigger Configuration」 whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon - CloudWatch, the default measurement sets are as follows. More metrics can be collected through configuration. Refer to [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Monitoring.html){:target="_blank"}

### Amazon RDS Instance-level Metrics in Amazon CloudWatch

The `AWS/RDS` namespace in Amazon CloudWatch includes the following instance-level metrics.

Note:

The Amazon RDS console may display metrics in units different from those sent to Amazon CloudWatch. For example, the Amazon RDS console might display a metric in megabytes (MB), while sending it to Amazon CloudWatch in bytes.

| Metric                            | Console Name                                                   | Description                                                         | Unit              |
| :-------------------------------- | :------------------------------------------------------------- | :------------------------------------------------------------------ | :---------------- |
| `BinLogDiskUsage`                 | **Binary Log Disk Usage (MB)**                                  | The amount of disk space occupied by binary logs. Binary logs are created if automatic backups are enabled for MySQL and MariaDB instances (including read replicas). | Bytes             |
| `BurstBalance`                    | **Burst Balance (Percentage)**                                   | Percentage of available General Purpose SSD (GP2) burst bucket I/O credits. | Percentage        |
| `CheckpointLag`                   | **Checkpoint Lag (Milliseconds)**                                 | Time since the last checkpoint. Only applicable to RDS for PostgreSQL. | Milliseconds      |
| `ConnectionAttempts`              | **Connection Attempts (Count)**                                  | Number of attempts made to connect to the instance, regardless of success. | Count            |
| `CPUUtilization`                  | **CPU Utilization (Percentage)**                                 | Percentage of CPU usage.                                              | Percentage        |
| `CPUCreditUsage`                 | **CPU Credit Usage (Count)**                                    | (T2 Instances) CPU credits spent by the instance to sustain CPU usage. One CPU credit equals one vCPU running at 100% utilization for one minute or equivalent combinations of vCPU, utilization, and time. For example, you could have one vCPU running at 50% utilization for two minutes, or two vCPUs running at 25% utilization for two minutes. CPU credits are provided only every five minutes. If you specify a time period greater than five minutes, use the `Sum` statistic instead of the `Average` statistic. | Credits (vCPU Minutes) |
| `CPUCreditBalance`               | **CPU Credit Balance (Count)**                                  | (T2 Instances) CPU credits accumulated by the instance since launch. For T2 Standard, `CPUCreditBalance` also includes accumulated launch credits. After gaining credits, they accumulate in the credit balance; after spending credits, they are deducted from the credit balance. The credit balance has a maximum limit determined by the instance size. After reaching the limit, any newly gained credits are discarded. T2 Standard launch credits do not count towards the limit. Instances can spend credits from `CPUCreditBalance` to burst above the baseline CPU utilization. During instance operation, credits in `CPUCreditBalance` do not expire. When the instance stops, `CPUCreditBalance` is not retained, and all accumulated credits are lost. CPU credit metrics are provided only every five minutes. Launch credits work in Amazon RDS the same way they do in Amazon EC2. For more information, see *Launch Credits* in the [Amazon Elastic Compute Cloud User Guide for Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-standard-mode-concepts.html#launch-credits){:target="_blank"}. | Credits (vCPU Minutes) |
| `DatabaseConnections`            | **Database Connections (Count)**                                 | Number of client network connections to the database instance. The number of database sessions may be higher than the metric value because the metric value does not include the following: Sessions that no longer have a network connection but have not yet been cleaned up by the database, Sessions created by the database engine for its own purposes, Sessions created by the database engine's parallel execution feature, Sessions created by the database engine's task scheduler, Amazon RDS connections | Count             |
| `DiskQueueDepth`                | **Queue Depth (Count)**                                          | Number of pending I/O (read/write requests) waiting to access the disk. | Count            |
| `EBSByteBalance%`               | **EBS Byte Balance (Percentage)**                                 | Percentage of remaining throughput credits in the RDS database burst bucket. This metric is only available for basic monitoring. The metric value is based on the throughput and IOPS of all volumes, including the root volume, not just the volumes containing database files. To find the instance sizes that support this metric, see the instance sizes marked with an asterisk (*) in the [Default Optimized EBS Table](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} in the *Amazon EC2 User Guide (for Linux Instances)*. `Sum` statistics are not applicable to this metric. | Percentage        |
| `EBSIOBalance%`                 | **EBS IO Balance (Percentage)**                                    | Percentage of remaining I/O credits in the RDS database burst bucket. This metric is only available for basic monitoring. The metric value is based on the throughput and IOPS of all volumes, including the root volume, not just the volumes containing database files. To find the instance sizes that support this metric, see the instance sizes marked with an asterisk (*) in the [Default Optimized EBS Table](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"} in the *Amazon EC2 User Guide (for Linux Instances)*. This metric differs from `BurstBalance`. For more information on how to use this metric, see [Improving Application Performance and Reducing Costs with Amazon EBS Optimized Instance Burst Capability](http://aws.amazon.com/blogs/compute/improving-application-performance-and-reducing-costs-with-amazon-ebs-optimized-instance-burst-capability/){:target="_blank"}. | Percentage        |
| `FailedSQLServerAgentJobsCount` | **Failed SQL Server Agent Jobs Count (Count/Minute)**           | Number of failed Microsoft SQL Server Agent jobs in the past 1 minute. | Count per Minute |
| `FreeableMemory`                | **Freeable Memory (MB)**                                         | Available size of random access memory. For MariaDB, MySQL, Oracle, and PostgreSQL database instances, this metric reports the value of the `/proc/meminfo` field `MemAvailable`. | Bytes             |
| `FreeLocalStorage`              | **Free Local Storage (MB)**                                      | Size of available local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. (This does not apply to Aurora Serverless v2.) | Bytes             |
| `FreeStorageSpace`              | **Free Storage Space (MB)**                                       | Size of available storage space.                                     | Bytes             |
| `MaximumUsedTransactionIDs`     | **Maximum Used Transaction IDs (Count)**                           | Maximum used transaction ID. Only applicable to PostgreSQL.          | Count             |
| `NetworkReceiveThroughput`      | **Network Receive Throughput (MB/Second)**                        | Incoming (receive) network traffic for the database instance, including customer database traffic and Amazon RDS traffic used for monitoring and replication. | Bytes per Second  |
| `NetworkTransmitThroughput`     | **Network Transmit Throughput (MB/Second)**                        | Outgoing (transmit) network traffic for the database instance, including customer database traffic and Amazon RDS traffic used for monitoring and replication. | Bytes per Second  |
| `OldestReplicationSlotLag`      | **Oldest Replication Slot Lag (MB)**                               | Lag size of the replica that is most behind in receiving Write-Ahead Log (WAL) data. Applicable to PostgreSQL. | Bytes             |
| `ReadIOPS`                      | **Read IOPS (Count/Second)**                                       | Average number of disk read I/O operations per second.             | Count per Second  |
| `ReadIOPSLocalStorage`          | **Read IOPS Local Storage (Count/Second)**                          | Average number of disk read input/output operations per second to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Count per Second  |
| `ReadLatency`                   | **Read Latency (Milliseconds)**                                     | Average time required for each disk I/O operation.                 | Milliseconds      |
| `ReadLatencyLocalStorage`       | **Read Latency Local Storage (Milliseconds)**                       | Average time required for each disk input/output operation to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Milliseconds      |
| `ReadThroughput`                | **Read Throughput (MB/Second)**                                    | Average number of bytes read from disk per second.                | Bytes per Second  |
| `ReadThroughputLocalStorage`    | **Read Throughput Local Storage (MB/Second)**                      | Average number of bytes read from disk to local storage per second. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Bytes per Second  |
| `ReplicaLag`                    | **Replica Lag (Milliseconds)**                                      | Amount of time that a read replica database instance lags behind the source database instance for read-only replica configurations. Applicable to MariaDB, Microsoft SQL Server, MySQL, Oracle, and PostgreSQL read-only replicas. For Multi-AZ database clusters, the time difference between the latest transaction on the writer database instance and the latest applied transaction on the reader database instance. | Milliseconds      |
| `ReplicationSlotDiskUsage`      | **Replication Slot Disk Usage (MB)**                               | Disk space used by replication slot files. Applicable to PostgreSQL. | Bytes             |
| `SwapUsage`                     | **Swap Usage (MB)**                                                | Size of swap space used on the database instance. This metric is not available for SQL Server. | Bytes             |
| `TransactionLogsDiskUsage`      | **Transaction Logs Disk Usage (MB)**                                | Disk space used by transaction logs. Applicable to PostgreSQL.      | Bytes             |
| `TransactionLogsGeneration`     | **Transaction Logs Generation (MB/Second)**                          | Size of transaction logs generated per second. Applicable to PostgreSQL. | Bytes per Second  |
| `WriteIOPS`                     | **Write IOPS (Count/Second)**                                       | Average number of disk write I/O operations per second.           | Count per Second  |
| `WriteIOPSLocalStorage`         | **Write IOPS Local Storage (Count/Second)**                         | Average number of disk write input/output operations per second to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Count per Second  |
| `WriteLatency`                  | **Write Latency (Milliseconds)**                                     | Average time required for each disk I/O operation.                | Milliseconds      |
| `WriteLatencyLocalStorage`      | **Write Latency Local Storage (Milliseconds)**                       | Average time required for each disk input/output operation to local storage. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Milliseconds      |
| `WriteThroughput`               | **Write Throughput (MB/Second)**                                    | Average number of bytes written to disk per second.               | Bytes per Second  |
| `WriteThroughputLocalStorage`   | **Write Throughput Local Storage (MB/Second)**                      | Average number of bytes written to disk to local storage per second. This metric only applies to database instance classes with NVMe SSD instance store volumes. For information about Amazon EC2 instances with NVMe SSD instance store volumes, see [Instance Store Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}. Equivalent RDS database instance classes have the same instance store volumes. For example, db.m6gd and db.r6gd database instance classes have NVMe SSD instance store volumes. | Bytes per Second  |

### Amazon RDS Usage Metrics in Amazon CloudWatch

The `AWS/Usage` namespace in Amazon CloudWatch includes account-level usage metrics for Amazon RDS service quotas. CloudWatch automatically collects usage metrics for all AWS regions.

For more information, see [CloudWatch Usage Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Usage-Metrics.html){:target="_blank"} in the *Amazon CloudWatch User Guide*. For more information about quotas, see [Quotas and Limits for Amazon RDS](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Limits.html){:target="_blank"} and [Requesting an Increase in Quota](https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html){:target="_blank"} in the *Service Quotas User Guide*.

| Metric                       | Description                                                         | Unit*    |
| :--------------------------- | :------------------------------------------------------------------ | :------- |
| `AllocatedStorage`           | Total storage space for all database instances. The sum excludes temporary migration instances. | Gigabytes |
| `DBClusterParameterGroups`   | Number of DB cluster parameter groups in your AWS account. This count excludes default parameter groups. | Count    |
| `DBClusters`                 | Number of Amazon Aurora DB clusters in your AWS account.            | Count    |
| `DBInstances`                | Number of DB instances in your AWS account.                        | Count    |
| `DBParameterGroups`          | Number of DB parameter groups in your AWS account. This count excludes default DB parameter groups. | Count    |
| `DBSecurityGroups`           | Number of security groups in your AWS account. This count excludes default security groups and default VPC security groups. | Count    |
| `DBSubnetGroups`             | Number of DB subnet groups in your AWS account. This count excludes default subnet groups. | Count    |
| `ManualClusterSnapshots`     | Number of manual DB cluster snapshots in your AWS account. This count excludes invalid snapshots. | Count    |
| `ManualSnapshots`            | Number of manual DB snapshots in your AWS account. This count excludes invalid snapshots. | Count    |
| `OptionGroups`               | Number of option groups in your AWS account. This count excludes default option groups. | Count    |
| `ReservedDBInstances`        | Number of reserved DB instances in your AWS account. This count excludes deactivated or rejected instances. | Count    |

\* Amazon RDS does not publish the units of usage metrics to CloudWatch. These units appear only in the documentation.

## Objects {#object}

Collected AWS RDS MySQL object data structure can be viewed under 「Infrastructure - Custom」

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
    "Endpoint"            : "{JSON Data for Connection Address}",
    "AllocatedStorage"    : 100,
    "message"             : "{JSON Serialized Instance Data}",
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as unique identification.
>
> Tip 2: `fields.message` and `fields.Endpoint` are JSON serialized strings.