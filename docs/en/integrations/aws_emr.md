---
title: 'AWS EMR'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_emr'
dashboard:

  - desc: 'AWS EMR Monitoring View'
    path: 'dashboard/zh/aws_emr'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/zh/aws_emr'

---


<!-- markdownlint-disable MD025 -->
# AWS EMR
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config  {#config}

### Install  Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of EMR cloud resources, we install the corresponding collection script：「Guance Integration（AWS EMRCollect）」(ID：`guance_aws_emr`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/UsingEMR_ViewingMetrics.html){:target="_blank"}


| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `IsIdle` | Indicates that a cluster is no longer performing work, but is still alive and accruing charges. It is set to 1 if no tasks are running and no jobs are running, and set to 0 otherwise. This value is checked at five-minute intervals and a value of 1 indicates only that the cluster was idle when checked, not that it was idle for the entire five minutes. To avoid false positives, you should raise an alarm when this value has been 1 for more than one consecutive 5-minute check. For example, you might raise an alarm on this value if it has been 1 for thirty minutes or longer. Use case: Monitor cluster performance Units: Boolean |
| `ContainerAllocated` | The number of resource containers allocated by the ResourceManager. Use case: Monitor cluster progress Units: Count |
| `ContainerReserved` | The number of containers reserved. Use case: Monitor cluster progress Units: Count |
| `ContainerPending` | The number of containers in the queue that have not yet been allocated. Use case: Monitor cluster progress Units: Count |
| `AppsCompleted` | The number of applications submitted to YARN that have completed. Use case: Monitor cluster progress Units: Count |
| `AppsFailed` | The number of applications submitted to YARN that have failed to complete. Use case: Monitor cluster progress, Monitor cluster health Units: Count |
| `AppsKilled` | The number of applications submitted to YARN that have been killed. Use case: Monitor cluster progress, Monitor cluster health Units: Count |
| `AppsPending` | The number of applications submitted to YARN that are in a pending state. Use case: Monitor cluster progress Units: Count |
| `AppsRunning` | The number of applications submitted to YARN that are running. Use case: Monitor cluster progress Units: Count |
| `AppsSubmitted` | The number of applications submitted to YARN. Use case: Monitor cluster progress Units: Count |
| `CoreNodesRunning` | The number of core nodes working. Data points for this metric are reported only when a corresponding instance group exists. Use case: Monitor cluster health Units: Count |
| `LiveDataNodes` | The percentage of data nodes that are receiving work from Hadoop. Use case: Monitor cluster health Units: Percent |
| `MRActiveNodes` | The number of nodes presently running MapReduce tasks or jobs. Equivalent to YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use case: Monitor cluster progress Units: Count |
| `MRLostNodes` | The number of nodes allocated to MapReduce that have been marked in a LOST state. Equivalent to YARN metric `mapred.resourcemanager.NoOfLostNodes.` Use case: Monitor cluster health, Monitor cluster progress Units: Count |
| `MRTotalNodes` | The number of nodes presently available to MapReduce jobs. Equivalent to YARN metric `mapred.resourcemanager.TotalNodes`. Use ase: Monitor cluster progress Units: Count |
| `MRActiveNodes` | The number of nodes presently running MapReduce tasks or jobs. Equivalent to YARN metric `mapred.resourcemanager.NoOfActiveNodes`. Use case: Monitor cluster progress Units: Count |
| `MRRebootedNodes` | The number of nodes available to MapReduce that have been rebooted and marked in a REBOOTED state. Equivalent to YARN metric `mapred.resourcemanager.NoOfRebootedNodes.` Use case: Monitor cluster health, Monitor cluster progress Units: Count |
| `MRUnhealthyNodes` | The number of nodes available to MapReduce jobs marked in an UNHEALTHY state. Equivalent to YARN metric `mapred.resourcemanager.NoOfUnhealthyNodes`. Use case: Monitor cluster progress Units: Count |
| `MRDecommissionedNodes` | The number of nodes allocated to MapReduce applications that have been marked in a DECOMMISSIONED state. Equivalent to YARN metric `mapred.resourcemanager.NoOfDecommissionedNodes`. Use ase: Monitor cluster health, Monitor cluster progress Units: Count |
| `S3BytesWritten` | The number of bytes written to Amazon S3. This metric aggregates MapReduce jobs only, and does not apply for other workloads on Amazon EMR. Use case: Analyze cluster performance, Monitor cluster progress Units: Count |
| `S3BytesRead` | The number of bytes read from Amazon S3. This metric aggregates MapReduce jobs only, and does not apply for other workloads on Amazon EMR. Use case: Analyze cluster performance, Monitor cluster progress Units: Count |
| `HDFSUtilization` | The percentage of `HDFS` storage currently used. Use case: Analyze cluster performance Units: Percent |
| `TotalLoad` | The total number of concurrent data transfers. Use case: Monitor cluster health Units: Count |
| `MemoryTotalMB` | The total amount of memory in the cluster. Use case: Monitor cluster progress Units: Count |
| `MemoryReservedMB` | The amount of memory reserved. Use case: Monitor cluster progress Units: Count |
| `HDFSBytesRead`               | The number of bytes read from `HDFS`. This metric aggregates MapReduce jobs only, and does not apply for other workloads on Amazon EMR. Use case: Analyze cluster performance, Monitor cluster progress Units: Count |
| `HDFSBytesWritten`            | The number of bytes written to `HDFS`. This metric aggregates MapReduce jobs only, and does not apply for other workloads on Amazon EMR. Use case: Analyze cluster performance, Monitor cluster progress Units: Count |
| `MissingBlocks`               | The number of blocks in which `HDFS` has no replicas. These might be corrupt blocks. Use case: Monitor cluster health Units: Count |
| `MemoryAvailableMB`           | The amount of memory available to be allocated. Use case: Monitor cluster progress Units: Count |
| `MemoryAllocatedMB` | The amount of memory allocated to the cluster. Use case: Monitor cluster progress Units: Count |
| `PendingDeletionBlocks` | The number of blocks marked for deletion. Use case: Monitor cluster progress, Monitor cluster health Units: Count |
| `UnderReplicatedBlocks` | The number of blocks that need to be replicated one or more times. Use case: Monitor cluster progress, Monitor cluster health Units: Count |
| `CapacityRemainingGB` | The amount of remaining `HDFS` disk capacity. Use case: Monitor cluster progress, Monitor cluster health Units: Count |


## Object {#object}

The collected AWS EMR object data structure can be viewed in "Infrastructure - Custom" under the object data.

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

> *Note: The fields in `tags` and `fields` may be subject to changes in subsequent updates.*
