---
title: 'AWS Redshift'
tags: 
  - AWS
summary: 'The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing the performance of a data warehouse.'
__int_icon: 'icon/aws_redshift'
dashboard:

  - desc: 'AWS Redshift built-in views'
    path: 'dashboard/en/aws_redshift'

monitor:
  - desc: 'AWS Redshift monitors'
    path: 'monitor/en/aws_redshift'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_redshift'
---


<!-- markdownlint-disable MD025 -->
# AWS Redshift
<!-- markdownlint-enable -->


The core performance Metrics of AWS Redshift include query performance, disk space usage, CPU utilization, database connections, and disk I/O operations. These are key Metrics for evaluating and optimizing the performance of a data warehouse.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Script for enabling managed version

1. Log in to the <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu and select 【Cloud Account Management】
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface; if cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test click 【Save】. If the test fails, check whether the relevant configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page.
6. On the cloud account details page, click the 【Integration】 button, find `AWS Redshift` under the `Not Installed` list, click the 【Install】 button, and install it from the pop-up installation interface.

#### Manual Enablement Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for: `guance_aws_redshift`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration. [Amazon Cloud Monitoring Metrics Details](https://docs.aws.amazon.com/en_us/redshift/latest/mgmt/metrics-listing.html){:target="_blank"}

### Redshift Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| CPUUtilization | Percentage of CPU used. For clusters, this metric represents the sum of the CPU usage values for all nodes (leader node and compute nodes) | % | ClusterIdentifier |
| HealthStatus | The health check status of the cluster | 1: Normal or 0: Abnormal | ClusterIdentifier |
| MaintenanceMode | Whether the cluster is in maintenance mode | 1: ON or 0: OFF | ClusterIdentifier |
| PercentageDiskSpaceUsed | Percentage of disk space used | % | ClusterIdentifier |
| DatabaseConnections | Number of database connections in the cluster | count | ClusterIdentifier |
| CommitQueueLength | Number of transactions waiting to commit at a given point in time | count | ClusterIdentifier |
| ConcurrencyScalingActiveClusters | The number of concurrency scaling clusters actively processing queries at any given time | count | ClusterIdentifier |
| NetworkReceiveThroughput | The rate at which nodes or clusters receive data | byte/s | ClusterIdentifier |
| NetworkTransmitThroughput | The rate at which nodes or clusters write data | byte/s | ClusterIdentifier |
| MaxConfiguredConcurrencyScalingClusters | Maximum number of concurrency scaling clusters configured from the parameter group | count | ClusterIdentifier |
| NumExceededSchemaQuotas | Number of schemas exceeding quotas | count | ClusterIdentifier |
| ReadIOPS | Average number of disk read operations per second | count/s | ClusterIdentifier |
| ReadLatency | Average time required for disk read I/O operations | seconds | ClusterIdentifier |
| ReadThroughput | Average number of bytes read from disk per second | byte | ClusterIdentifier |
| TotalTableCount | Number of user tables open at a specific point in time | count | ClusterIdentifier |
| WriteIOPS | Average number of disk write operations per second | count/s | ClusterIdentifier |
| WriteLatency | Average time required for disk write I/O operations | seconds | ClusterIdentifier |
| WriteThroughput | Average number of bytes written to disk per second | byte | ClusterIdentifier |


## Objects {#object}

The collected Amazon AWS Redshift object data structure can be viewed in the 「Infrastructure - Custom」 section.

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
    "message"                           : "{JSON instance data}"
  }
}

```

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are JSON serialized strings.