---
title: 'AWS EMR'
tags: 
  - AWS
summary: 'Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_emr'
dashboard:

  - desc: 'Built-in views for AWS EMR'
    path: 'dashboard/en/aws_emr'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/en/aws_emr'

---

<!-- markdownlint-disable MD025 -->
# AWS EMR
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> **Tip:** Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize EMR cloud resource monitoring data, install the corresponding collection script: "Guance Integration (AWS EMR Collection)" (ID: `guance_aws_emr`).

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see the metrics section [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/UsingEMR_ViewingMetrics.html){:target="_blank"}

| Metric                  | Description                                                         |
| :---------------------- | :------------------------------------------------------------------ |
| `IsIdle`                | Indicates that the cluster is not performing tasks but is still active and incurs costs. If there are no running or pending tasks, this metric is set to 1; otherwise, it is set to 0. The system checks this value every five minutes. A value of 1 only indicates that the cluster was idle at the time of the check, not for the entire five minutes. To avoid false alarms, you should raise an alert when multiple consecutive five-minute checks return a value of 1. For example, raise an alert when the value remains 1 for thirty minutes or longer. Use case: Monitoring cluster performance Unit: Boolean |
| `ContainerAllocated`    | Number of allocated resource containers by ResourceManager. Use case: Monitoring cluster progress Unit: Count |
| `ContainerReserved`     | Number of reserved containers. Use case: Monitoring cluster progress Unit: Count |
| `ContainerPending`      | Number of containers in the queue that have not yet been allocated. Use case: Monitoring cluster progress Unit: Count |
| `AppsCompleted`         | Number of applications submitted to YARN and completed. Use case: Monitoring cluster progress Unit: Count |
| `AppsFailed`            | Number of applications submitted to YARN and failed to complete. Use case: Monitoring cluster progress, cluster health Unit: Count |
| `AppsKilled`            | Number of applications submitted to YARN and terminated. Use case: Monitoring cluster progress, cluster health Unit: Count |
| `AppsPending`           | Number of applications submitted to YARN and in pending state. Use case: Monitoring cluster progress Unit: Count |
| `AppsRunning`           | Number of applications submitted to YARN and running. Use case: Monitoring cluster progress Unit: Count |
| `AppsSubmitted`         | Number of applications submitted to YARN. Use case: Monitoring cluster progress Unit: Count |
| `CoreNodesRunning`      | Number of core nodes in running state. This metric reports data points only when the corresponding instance group exists. Use case: Monitoring cluster health Unit: Count |
| `LiveDataNodes`         | Percentage of data nodes receiving tasks from Hadoop. Use case: Monitoring cluster health Unit: Percentage |
| `MRActiveNodes`         | Number of nodes currently running MapReduce tasks or jobs. Equivalent to YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use case: Monitoring cluster progress Unit: Count |
| `MRLostNodes`           | Number of nodes allocated to MapReduce and marked as LOST. Equivalent to YARN metric `mapred.resourcemanager.NoOfLostNodes`. Use case: Monitoring cluster health, progress Unit: Count |
| `MRTotalNodes`          | Number of nodes currently available for MapReduce jobs. Equivalent to YARN metric `mapred.resourcemanager.TotalNodes`. Use case: Monitoring cluster progress Unit: Count |
| `MRRebootedNodes`       | Number of available nodes that have been restarted and marked as "restarted". Equivalent to YARN metric `mapred.resourcemanager.NoOfRebootedNodes`. Use case: Monitoring cluster health, progress Unit: Count |
| `MRUnhealthyNodes`      | Number of nodes available for MapReduce jobs marked as "unhealthy". Equivalent to YARN metric `mapred.resourcemanager.NoOfUnhealthyNodes`. Use case: Monitoring cluster progress Unit: Count |
| `MRDecommissionedNodes` | Number of nodes allocated to decommissioned MapReduce applications. Equivalent to YARN metric `mapred.resourcemanager.NoOfDecommissionedNodes`. Use case: Monitoring cluster health, progress Unit: Count |
| `S3BytesWritten`        | Number of bytes written to Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use case: Analyzing cluster performance, monitoring cluster progress Unit: Count |
| `S3BytesRead`           | Number of bytes read from Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use case: Analyzing cluster performance, monitoring cluster progress Unit: Count |
| `HDFSUtilization`       | Percentage of current `HDFS` storage usage. Use case: Analyzing cluster performance Unit: Percentage |
| `TotalLoad`             | Total concurrent data transfers. Use case: Monitoring cluster health Unit: Count |
| `MemoryTotalMB`         | Total memory in the cluster. Use case: Monitoring cluster progress Unit: Count |
| `MemoryReservedMB`      | Reserved memory. Use case: Monitoring cluster progress Unit: Count |
| `HDFSBytesRead`         | Number of bytes read from `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use case: Analyzing cluster performance, monitoring cluster progress Unit: Count |
| `HDFSBytesWritten`      | Number of bytes written to `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use case: Analyzing cluster performance, monitoring cluster progress Unit: Count |
| `MissingBlocks`         | Number of data blocks in `HDFS` with no replicas. These blocks may be corrupted. Use case: Monitoring cluster health Unit: Count |
| `MemoryAvailableMB`     | Available allocatable memory. Use case: Monitoring cluster progress Unit: Count |
| `MemoryAllocatedMB`     | Allocated memory to the cluster. Use case: Monitoring cluster progress Unit: Count |
| `PendingDeletionBlocks` | Number of blocks marked for deletion. Use case: Monitoring cluster progress, health Unit: Count |
| `UnderReplicatedBlocks` | Number of blocks that need to be replicated one or more times. Use case: Monitoring cluster progress, health Unit: Count |
| `DfsPendingReplicationBlocks` |   |
| `CapacityRemainingGB`   | Remaining `HDFS` disk capacity. Use case: Monitoring cluster progress, health Unit: Count |

## Objects {#object}

The structure of collected AWS EMR object data can be viewed in "Infrastructure - Custom".

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*