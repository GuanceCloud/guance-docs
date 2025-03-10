---
title: 'AWS EMR'
tags: 
  - AWS
summary: 'Use the cloud synchronization script package from the Script Market to sync cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_emr'
dashboard:

  - desc: 'Built-in view for AWS EMR'
    path: 'dashboard/en/aws_emr'

monitor:
  - desc: 'AWS DocumentDB monitor'
    path: 'monitor/en/aws_emr'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_emr'
---


<!-- markdownlint-disable MD025 -->
# AWS EMR
<!-- markdownlint-enable -->

Use the cloud synchronization script package from the Script Market to sync cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualifying Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize EMR cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (AWS EMR Collection)" (ID: `guance_aws_emr`)

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for specifics, see the metrics section [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/UsingEMR_ViewingMetrics.html){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `IsIdle` | Indicates that the cluster is not performing tasks but is still active and incurring costs. If no tasks or steps are running, this metric is set to 1; otherwise, it is set to 0. The system checks this value every five minutes. A value of 1 only indicates that the cluster was idle at the time of the check, not for the entire five minutes. To avoid false positives, you should raise an alert when multiple consecutive 5-minute checks result in a value of 1. For example, when this value remains 1 for thirty minutes or longer, you should raise an alert. Use Case: Monitoring cluster performance Unit: Boolean |
| `ContainerAllocated` | Number of allocated resource containers by ResourceManager. Use Case: Monitoring cluster progress Unit: Count |
| `ContainerReserved` | Number of reserved containers. Use Case: Monitoring cluster progress Unit: Count |
| `ContainerPending` | Number of containers in the queue that have not yet been allocated. Use Case: Monitoring cluster progress Unit: Count |
| `AppsCompleted` | Number of applications submitted to YARN and completed. Use Case: Monitoring cluster progress Unit: Count |
| `AppsFailed` | Number of applications submitted to YARN and failed to complete. Use Case: Monitoring cluster progress, Monitoring cluster health Unit: Count |
| `AppsKilled` | Number of applications submitted to YARN and terminated. Use Case: Monitoring cluster progress, Monitoring cluster health Unit: Count |
| `AppsPending` | Number of applications submitted to YARN and in pending state. Use Case: Monitoring cluster progress Unit: Count |
| `AppsRunning` | Number of applications submitted to YARN and currently running. Use Case: Monitoring cluster progress Unit: Count |
| `AppsSubmitted` | Number of applications submitted to YARN. Use Case: Monitoring cluster progress Unit: Count |
| `CoreNodesRunning` | Number of core nodes in running state. This metric's data points are reported only when the corresponding instance group exists. Use Case: Monitoring cluster health Unit: Count |
| `LiveDataNodes` | Percentage of data nodes receiving tasks from Hadoop. Use Case: Monitoring cluster health Unit: Percentage |
| `MRActiveNodes` | Number of nodes currently running MapReduce tasks or jobs. Equivalent to the YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use Case: Monitoring cluster progress Unit: Count |
| `MRLostNodes` | Number of nodes assigned to MapReduce marked as LOST state. Equivalent to the YARN metric `mapred.resourcemanager.NoOfLostNodes`. Use Case: Monitoring cluster health, Monitoring cluster progress Unit: Count |
| `MRTotalNodes` | Number of nodes currently available for MapReduce jobs. Equivalent to the YARN metric `mapred.resourcemanager.TotalNodes`. Use Case: Monitoring cluster progress Unit: Count |
| `MRActiveNodes` | Number of nodes currently running MapReduce tasks or jobs. Equivalent to the YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use Case: Monitoring cluster progress Unit: Count |
| `MRRebootedNodes` | Number of available nodes that have been restarted and marked as "restarted" status. Equivalent to the YARN metric `mapred.resourcemanager.NoOfRebootedNodes`. Use Case: Monitoring cluster health, Monitoring cluster progress Unit: Count |
| `MRUnhealthyNodes` | Number of nodes available for MapReduce jobs marked as "unhealthy" status. Equivalent to the YARN metric `mapred.resourcemanager.NoOfUnhealthyNodes`. Use Case: Monitoring cluster progress Unit: Count |
| `MRDecommissionedNodes` | Number of nodes assigned to MapReduce applications marked as decommissioned status. Equivalent to the YARN metric `mapred.resourcemanager.NoOfDecommissionedNodes`. Use Case: Monitoring cluster health, Monitoring cluster progress Unit: Count |
| `S3BytesWritten` | Number of bytes written to Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyzing cluster performance, Monitoring cluster progress Unit: Count |
| `S3BytesRead` | Number of bytes read from Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyzing cluster performance, Monitoring cluster progress Unit: Count |
| `HDFSUtilization` | Percentage of current used `HDFS` storage. Use Case: Analyzing cluster performance Unit: Percentage |
| `TotalLoad` | Total number of concurrent data transfers. Use Case: Monitoring cluster health Unit: Count |
| `MemoryTotalMB` | Total memory in the cluster. Use Case: Monitoring cluster progress Unit: Count |
| `MemoryReservedMB` | Reserved memory. Use Case: Monitoring cluster progress Unit: Count |
| `HDFSBytesRead`               | Number of bytes read from `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyzing cluster performance, Monitoring cluster progress Unit: Count |
| `HDFSBytesWritten`            | Number of bytes written to `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyzing cluster performance, Monitoring cluster progress Unit: Count |
| `MissingBlocks`               | Number of data blocks in `HDFS` that do not have replicas. These blocks may be corrupted. Use Case: Monitoring cluster health Unit: Count |
| `MemoryAvailableMB`           | Available allocatable memory. Use Case: Monitoring cluster progress Unit: Count |
| `MemoryAllocatedMB` | Allocated memory to the cluster. Use Case: Monitoring cluster progress Unit: Count |
| `PendingDeletionBlocks` | Number of blocks marked for deletion. Use Case: Monitoring cluster progress, Monitoring cluster health Unit: Count |
| `UnderReplicatedBlocks` | Number of blocks needing one or more replications. Use Case: Monitoring cluster progress, Monitoring cluster health Unit: Count |
| `DfsPendingReplicationBlocks` |   |
| `CapacityRemainingGB` | Remaining `HDFS` disk capacity. Use Case: Monitoring cluster progress, Monitoring cluster health Unit: Count |


## Objects {#object}

Data structure of collected AWS EMR objects, which can be viewed under "Infrastructure - Custom"

```json
{
  "measurement": "aws_emr",
  "tags": {
    "Id"                 : "xxxxx",
    "ClusterName"        : "xxxxx",
    "ClusterArn"         : "xxxx",
    "RegionId"           : "cn-north-1",
    "OutpostArn"         : "xxxx",
  },
  "fields": {
    "Status"               : "{Instance status JSON data}",
    "message"              : "{Instance JSON data}"
  }
}

```

> *Note: Fields in `tags` and `fields` may change with subsequent updates*