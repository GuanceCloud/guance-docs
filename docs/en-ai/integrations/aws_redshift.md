---
title: 'AWS Redshift'
tags: 
  - AWS
summary: 'The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing data warehouse performance.'
__int_icon: 'icon/aws_redshift'
dashboard:

  - desc: 'Built-in Views for AWS Redshift'
    path: 'dashboard/en/aws_redshift'

monitor:
  - desc: 'AWS Redshift Monitor'
    path: 'monitor/en/aws_redshift'

---


<!-- markdownlint-disable MD025 -->
# AWS Redshift
<!-- markdownlint-enable -->


The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing data warehouse performance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize Redshift monitoring data, install the corresponding collection script: "Guance Integration (AWS-Redshift Collection)" (ID: `guance_aws_redshift`)

After clicking 【Install】, enter the required parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


We have collected some configurations by default; see the Metrics section for details [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has the automatic trigger configuration and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. In the Guance platform, under 「Metrics」check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default Mearsurement set is as follows. You can collect more Metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/redshift/latest/mgmt/metrics-listing.html){:target="_blank"}

### Redshift Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| CPUUtilization | Percentage of CPU used. For clusters, this metric represents the sum of CPU utilization values for all nodes (leader node and compute nodes) | % | ClusterIdentifier |
| HealthStatus | Cluster health check status | 1: Normal or 0: Abnormal | ClusterIdentifier |
| MaintenanceMode | Whether the cluster is in maintenance mode | 1: ON or 0: OFF | ClusterIdentifier |
| PercentageDiskSpaceUsed | Percentage of used disk space | % | ClusterIdentifier |
| DatabaseConnections | Number of database connections in the cluster | count | ClusterIdentifier |
| CommitQueueLength | Number of transactions waiting to commit at a given time | count | ClusterIdentifier |
| ConcurrencyScalingActiveClusters | Number of concurrent scaling clusters actively processing queries at any given time | count | ClusterIdentifier |
| NetworkReceiveThroughput | Rate at which nodes or clusters receive data | byte/s | ClusterIdentifier |
| NetworkTransmitThroughput | Rate at which nodes or clusters write data | byte/s | ClusterIdentifier |
| MaxConfiguredConcurrencyScalingClusters | Maximum number of concurrent scaling clusters configured from parameter groups | count | ClusterIdentifier |
| NumExceededSchemaQuotas | Number of schemas exceeding quotas | count | ClusterIdentifier |
| ReadIOPS | Average number of disk read operations per second | count/s | ClusterIdentifier |
| ReadLatency | Average time taken for disk read I/O operations | seconds | ClusterIdentifier |
| ReadThroughput | Average number of bytes read from disk per second | byte | ClusterIdentifier |
| TotalTableCount | Number of user tables open at a specific time | count | ClusterIdentifier |
| WriteIOPS | Average number of disk write operations per second | count/s | ClusterIdentifier |
| WriteLatency | Average time taken for disk write I/O operations | seconds | ClusterIdentifier |
| WriteThroughput | Average number of bytes written to disk per second | byte | ClusterIdentifier |


## Objects {#object}

The structure of collected AWS Redshift object data can be viewed in 「Infrastructure - Custom」

```json
{
  "measurement": "aws_redshift",
  "tags": {
    "ClusterAvailabilityStatus"         : "Modifying",
    "ClusterIdentifier"                 : "hn-test",
    "ClusterStatus"                     : "creating",
    "ClusterSubnetGroupName"            : "default",
    "ClusterVersion"                    : "1.0",
    "DBName"                            : "dev",
    "MasterUsername"                    : "awsuser",
    "NodeType"                          : "dc2.large",
    "PreferredMaintenanceWindow"        : "sat:19:30-sat:20:00",
    "RegionId"                          : "cn-northwest-1",
    "VpcId"                             : "vpc-b1ca3ff0fa4d",
    "name"                              : "hn-test"
  },
  "fields": {
    "AllowVersionUpgrade"               : true,
    "AutomatedSnapshotRetentionPeriod"  : 1,
    "ClusterNodes"                      : "[]",
    "ClusterParameterGroups"            : "[{\"ParameterApplyStatus\": \"in-sync\", \"ParameterGroupName\": \"default.redshift-1.0\"}]",
    "ClusterSecurityGroups"             : "[]",
    "Encrypted"                         : false,
    "Endpoint"                          : "{}",
    "ManualSnapshotRetentionPeriod"     : -1,
    "NumberOfNodes"                     : 1,
    "PendingModifiedValues"             : "{\"MasterUserPassword\": \"****\"}",
    "PubliclyAccessible"                : false,
    "VpcSecurityGroups"                 : "[{\"Status\": \"active\", \"VpcSecurityGroupId\": \"sg-467a\"}]",
    "message"                           : "{instance JSON data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
>
> Tip 2: `fields.message`, `fields.network_interfaces`, and `fields.blockdevicemappings` are JSON serialized strings.