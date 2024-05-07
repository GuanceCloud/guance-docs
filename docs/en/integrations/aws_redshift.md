---
title: 'AWS Redshift'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance .'
__int_icon: 'icon/aws_redshift'
dashboard:
  - desc: 'AWS Redshift Dashboard'
    path: 'dashboard/zh/aws_redshift'
monitor:
  - desc: 'AWS Redshift Monitor'
    path: 'monitor/zh/aws_redshift'

---


<!-- markdownlint-disable MD025 -->
# AWS Redshift
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance .



## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of EC2 cloud resources, we install the corresponding collection script：「Guance Integration（AWS EC2 Collect）」(ID：`guance_aws_ec2`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance  platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance  platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/redshift/latest/mgmt/metrics-listing.html){:target="_blank"}

### Redshift Metric

| Metric Name | Description | Unit | Dimension  |
| :---: | :---: | :---: | :---: |
| CPUUtilization | CPU Utilization Percentage. For clusters, this metric represents the sum of the CPU utilization values of all nodes (leader and compute nodes) | % | ClusterIdentifier |
| HealthStatus | Operational status check of the cluster | 1: healthy or 0: unhealthy | ClusterIdentifier |
| MaintenanceMode  | Whether the cluster is in maintenance mode | 1：ON or 0：OFF | ClusterIdentifier |
| PercentageDiskSpaceUsed | Percentage of used disk space | % | ClusterIdentifier |
| DatabaseConnections | Number of database connections in the cluster | count | ClusterIdentifier |
| CommitQueueLength | Number of transactions waiting to commit at a given point in time | count | ClusterIdentifier |
| ConcurrencyScalingActiveClusters | Number of concurrent extended clusters actively processing queries at any given time | count | ClusterIdentifier |
| NetworkReceiveThroughput | The rate at which a node or cluster receives data | byte/s | ClusterIdentifier |
| NetworkTransmitThroughput | The rate at which a node or cluster writes data | byte/s | ClusterIdentifier |
| MaxConfiguredConcurrencyScalingClusters | Maximum number of concurrently expanding clusters configured from the parameter group | count | ClusterIdentifier |
| NumExceededSchemaQuotas | Number of schemas over quota | count | ClusterIdentifier |
| ReadIOPS | Average number of disk read operations per second | count/s | ClusterIdentifier |
| ReadLatency | Average time required for disk read I/O operations | second  | ClusterIdentifier |
| ReadThroughput | Average number of bytes read from disk per second | byte | ClusterIdentifier |
| TotalTableCount | Number of user tables open at a given point in time | count | ClusterIdentifier |
| WriteIOPS | Average number of disk write operations per second | count/s | ClusterIdentifier |
| WriteLatency | Average time required for disk write I/O operations | second | ClusterIdentifier |
| WriteThroughput | Average number of bytes written to disk per second | byte | ClusterIdentifier |


## Object {#object}

The collected AWS Redshift object data structure can see the object data from 「Infrastructure - Customization」


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
    "message"                           : "{Instance JSON data}"
  }
}

```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, and `fields.BlockDeviceMappings` are JSON serialized strings.
