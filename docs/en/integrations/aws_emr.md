---
title: 'AWS EMR'
tags: 
  - AWS
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_emr'
dashboard:

  - desc: 'AWS EMR built-in view'
    path: 'dashboard/en/aws_emr'

monitor:
  - desc: 'AWS DocumentDB monitor'
    path: 'monitor/en/aws_emr'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_emr'
---


<!-- markdownlint-disable MD025 -->
# AWS EMR
<!-- markdownlint-enable -->

Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize EMR cloud resource monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS EMR Collection)" (ID: `guance_aws_emr)

Click 【Install】, then input the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

We default to collecting some configurations, for details, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, check under "Infrastructure / Custom" whether there is asset information.
3. On the <<< custom_key.brand_name >>> platform, check under "Metrics" whether there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/en_us/emr/latest/ManagementGuide/UsingEMR_ViewingMetrics.html){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `IsIdle` | Indicates that the cluster is no longer performing tasks but remains active and incurs costs. If there are no running or pending tasks, this metric is set to 1; otherwise, it is set to 0. The system checks this value every five minutes. A value of 1 only indicates that the cluster was idle at the time of inspection, not that it was idle for the entire five minutes. To avoid false alarms, you should raise an alert when multiple consecutive five-minute inspections result in a value of 1. For example, you should raise an alert if the value remains 1 for thirty minutes or longer. Use Case: Monitor cluster performance Unit: Boolean |
| `ContainerAllocated` | Number of allocated resource containers by ResourceManager. Use Case: Monitor cluster progress Unit: Count |
| `ContainerReserved` | Number of reserved containers. Use Case: Monitor cluster progress Unit: Count |
| `ContainerPending` | Number of unallocated containers in the queue. Use Case: Monitor cluster progress Unit: Count |
| `AppsCompleted` | Number of applications submitted to YARN and completed. Use Case: Monitor cluster progress Unit: Count |
| `AppsFailed` | Number of applications submitted to YARN and failed to complete. Use Case: Monitor cluster progress, Monitor cluster health Unit: Count |
| `AppsKilled` | Number of applications submitted to YARN and terminated. Use Case: Monitor cluster progress, Monitor cluster health Unit: Count |
| `AppsPending` | Number of applications submitted to YARN and in pending state. Use Case: Monitor cluster progress Unit: Count |
| `AppsRunning` | Number of applications submitted to YARN and currently running. Use Case: Monitor cluster progress Unit: Count |
| `AppsSubmitted` | Number of applications submitted to YARN. Use Case: Monitor cluster progress Unit: Count |
| `CoreNodesRunning` | Number of core nodes in running state. This metric's data points are reported only when the corresponding instance group exists. Use Case: Monitor cluster health Unit: Count |
| `LiveDataNodes` | Percentage of data nodes receiving tasks from Hadoop. Use Case: Monitor cluster health Unit: Percentage |
| `MRActiveNodes` | Number of nodes currently running MapReduce tasks or jobs. Equivalent to the YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRLostNodes` | Number of nodes assigned to MapReduce and marked as LOST. Equivalent to the YARN metric `mapred.resourcemanager.NoOfLostNodes`. Use Case: Monitor cluster health, Monitor cluster progress Unit: Count |
| `MRTotalNodes` | Number of nodes currently available for MapReduce jobs. Equivalent to the YARN metric `mapred.resourcemanager.TotalNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRActiveNodes` | Number of nodes currently running MapReduce tasks or jobs. Equivalent to the YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRRebootedNodes` | Number of available nodes that have been restarted and marked as "rebooted". Equivalent to the YARN metric `mapred.resourcemanager.NoOfRebootedNodes`. Use Case: Monitor cluster health, Monitor cluster progress Unit: Count |
| `MRUnhealthyNodes` | Number of nodes available for MapReduce jobs marked as "unhealthy". Equivalent to the YARN metric `mapred.resourcemanager.NoOfUnhealthyNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRDecommissionedNodes` | Number of nodes assigned to MapReduce applications marked as decommissioned. Equivalent to the YARN metric `mapred.resourcemanager.NoOfDecommissionedNodes`. Use Case: Monitor cluster health, Monitor cluster progress Unit: Count |
| `S3BytesWritten` | Number of bytes written to Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, Monitor cluster progress Unit: Count |
| `S3BytesRead` | Number of bytes read from Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, Monitor cluster progress Unit: Count |
| `HDFSUtilization` | Percentage of currently used `HDFS` storage. Use Case: Analyze cluster performance Unit: Percentage |
| `TotalLoad` | Total number of concurrent data transfers. Use Case: Monitor cluster health Unit: Count |
| `MemoryTotalMB` | Total memory in the cluster. Use Case: Monitor cluster progress Unit: Count |
| `MemoryReservedMB` | Reserved memory. Use Case: Monitor cluster progress Unit: Count |
| `HDFSBytesRead`               | Number of bytes read from `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, Monitor cluster progress Unit: Count |
| `HDFSBytesWritten`            | Number of bytes written to `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, Monitor cluster progress Unit: Count |
| `MissingBlocks`               | Number of data blocks in `HDFS` where no replicas exist. These blocks may be corrupted. Use Case: Monitor cluster health Unit: Count |
| `MemoryAvailableMB`           | Available memory for allocation. Use Case: Monitor cluster progress Unit: Count |
| `MemoryAllocatedMB` | Allocated memory for the cluster. Use Case: Monitor cluster progress Unit: Count |
| `PendingDeletionBlocks` | Number of blocks marked for deletion. Use Case: Monitor cluster progress, Monitor cluster health Unit: Count |
| `UnderReplicatedBlocks` | Number of blocks that need to be replicated one or more times. Use Case: Monitor cluster progress, Monitor cluster health Unit: Count |
| `DfsPendingReplicationBlocks` |   |
| `CapacityRemainingGB` | Remaining `HDFS` disk capacity. Use Case: Monitor cluster progress, Monitor cluster health Unit: Count |


## Objects {#object}

The collected AWS EMR object data structure can be seen in the "Infrastructure - Custom" section.

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

> *Note: The fields in `tags`, `fields` may change with subsequent updates*
```