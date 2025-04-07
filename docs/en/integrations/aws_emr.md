---
title: 'AWS EMR'
tags: 
  - AWS
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_emr'
dashboard:

  - desc: 'AWS EMR built-in views'
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

Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - Managed Func: All prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Managed Version Activation Script

1. Log in to <<< custom_key.brand_name >>> Console
2. Click on the 【Manage】 menu and select 【Cloud Account Management】
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface; if you have already configured cloud account information before, skip this step
4. Click 【Test】, after a successful test, click 【Save】; if the test fails, check whether the relevant configuration information is correct and retest
5. In the 【Cloud Account Management】 list, you can see the added cloud account. Click the corresponding cloud account and go to the details page
6. Click the 【Integration】 button on the cloud account detail page. Under the `Not Installed` list, find `AWS EMR`, click the 【Install】 button, and install it by following the installation interface.

#### Manual Activation Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for: `guance_aws_emr`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】, and you can immediately execute once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」 whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, 「Metrics」 check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon Cloud Monitoring Metric Details](https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/UsingEMR_ViewingMetrics.html){:target="_blank"}

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `IsIdle` | Indicates that the cluster is no longer executing tasks but remains active and incurs charges. If there are no running or pending tasks, this metric is set to 1; otherwise, it is set to 0. The system checks this value every five minutes, and a value of 1 only indicates that the cluster was idle at the time of the check, not that it was idle for the entire five-minute period. To avoid false alarms, you should raise an alert when multiple consecutive five-minute checks result in a value of 1. For example, you should raise an alert when the value has been 1 for thirty minutes or longer. Use Case: Monitor cluster performance Unit: Boolean |
| `ContainerAllocated` | Number of resource containers allocated by ResourceManager. Use Case: Monitor cluster progress Unit: Count |
| `ContainerReserved` | Number of reserved containers. Use Case: Monitor cluster progress Unit: Count |
| `ContainerPending` | Number of containers in the queue that have not yet been allocated. Use Case: Monitor cluster progress Unit: Count |
| `AppsCompleted` | Number of applications submitted to YARN and completed. Use Case: Monitor cluster progress Unit: Count |
| `AppsFailed` | Number of applications submitted to YARN and failed to complete. Use Case: Monitor cluster progress, monitor cluster health Unit: Count |
| `AppsKilled` | Number of applications submitted to YARN and terminated. Use Case: Monitor cluster progress, monitor cluster health Unit: Count |
| `AppsPending` | Number of applications submitted to YARN and in pending state. Use Case: Monitor cluster progress Unit: Count |
| `AppsRunning` | Number of applications submitted to YARN and currently running. Use Case: Monitor cluster progress Unit: Count |
| `AppsSubmitted` | Number of applications submitted to YARN. Use Case: Monitor cluster progress Unit: Count |
| `CoreNodesRunning` | Number of core nodes in the running state. This metric's data points are reported only when the corresponding instance group exists. Use Case: Monitor cluster health Unit: Count |
| `LiveDataNodes` | Percentage of data nodes receiving tasks from Hadoop. Use Case: Monitor cluster health Unit: Percentage |
| `MRActiveNodes` | Number of nodes currently running MapReduce tasks or jobs. Equivalent to the YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRLostNodes` | Number of nodes assigned to MapReduce and marked as LOST status. Equivalent to the YARN metric `mapred.resourcemanager.NoOfLostNodes`. Use Case: Monitor cluster health, monitor cluster progress Unit: Count |
| `MRTotalNodes` | Number of nodes currently available for MapReduce jobs. Equivalent to the YARN metric `mapred.resourcemanager.TotalNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRActiveNodes` | Number of nodes currently running MapReduce tasks or jobs. Equivalent to the YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRRebootedNodes` | Number of available nodes that have been restarted and marked as "rebooted". Equivalent to the YARN metric `mapred.resourcemanager.NoOfRebootedNodes`. Use Case: Monitor cluster health, monitor cluster progress Unit: Count |
| `MRUnhealthyNodes` | Number of nodes available for MapReduce jobs marked as "unhealthy". Equivalent to the YARN metric `mapred.resourcemanager.NoOfUnhealthyNodes`. Use Case: Monitor cluster progress Unit: Count |
| `MRDecommissionedNodes` | Number of nodes assigned to decommissioned MapReduce applications. Equivalent to the YARN metric `mapred.resourcemanager.NoOfDecommissionedNodes`. Use Case: Monitor cluster health, monitor cluster progress Unit: Count |
| `S3BytesWritten` | Number of bytes written to Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, monitor cluster progress Unit: Count |
| `S3BytesRead` | Number of bytes read from Amazon S3. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, monitor cluster progress Unit: Count |
| `HDFSUtilization` | Percentage of currently used `HDFS` storage. Use Case: Analyze cluster performance Unit: Percentage |
| `TotalLoad` | Total number of concurrent data transfers. Use Case: Monitor cluster health Unit: Count |
| `MemoryTotalMB` | Total memory in the cluster. Use Case: Monitor cluster progress Unit: Count |
| `MemoryReservedMB` | Reserved memory. Use Case: Monitor cluster progress Unit: Count |
| `HDFSBytesRead`               | Number of bytes read from `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, monitor cluster progress Unit: Count |
| `HDFSBytesWritten`            | Number of bytes written to `HDFS`. This metric aggregates only MapReduce tasks and does not apply to other workloads on Amazon EMR. Use Case: Analyze cluster performance, monitor cluster progress Unit: Count |
| `MissingBlocks`               | Number of data blocks in `HDFS` where there are no replicas. These blocks may be corrupted. Use Case: Monitor cluster health Unit: Count |
| `MemoryAvailableMB`           | Available memory for allocation. Use Case: Monitor cluster progress Unit: Count |
| `MemoryAllocatedMB` | Allocated memory to the cluster. Use Case: Monitor cluster progress Unit: Count |
| `PendingDeletionBlocks` | Number of data blocks marked for deletion. Use Case: Monitor cluster progress, monitor cluster health Unit: Count |
| `UnderReplicatedBlocks` | Number of data blocks that need to be replicated one or more times. Use Case: Monitor cluster progress, monitor cluster health Unit: Count |
| `DfsPendingReplicationBlocks` |   |
| `CapacityRemainingGB` | Remaining `HDFS` disk capacity. Use Case: Monitor cluster progress, monitor cluster health Unit: Count |


## Objects {#object}

The structure of collected AWS EMR object data can be viewed under 「Infrastructure - Custom」

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