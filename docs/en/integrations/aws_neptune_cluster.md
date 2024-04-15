---
title: 'AWS Neptune Cluster'
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_neptune_cluster'

dashboard:
  - desc: 'AWS Neptune Cluster Monitoring View'
    path: 'dashboard/zh/aws_neptune_cluster'

monitor:
  - desc: 'AWS Neptune Cluster Monitor'
    path: 'monitor/zh/aws_neptune_cluster'

---


<!-- markdownlint-disable MD025 -->
# AWS Neptune Cluster
<!-- markdownlint-enable -->

The display metrics for the AWS Neptune Cluster include cold start time, execution time, number of concurrent executions, and memory usage, which reflect the responsiveness, scalability, and resource utilization of the Neptune Cluster functions.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of Neptune Cluster cloud resources, we install the corresponding collection script：「Guance Integration（AWS-Neptune ClusterCollect）」(ID：`guance_aws_neptune_cluster`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

After configuring Amazon CloudWatch - cloud monitoring, the default set of metrics is as follows. You can collect more metrics by configuring [Amazon Neptune Cluster Metrics Details](https://docs.aws.amazon.com/zh_cn/neptune/latest/userguide/cw-metrics.html){:target="_blank"}

### Metric

| Metric                                              | Describe                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `BackupRetentionPeriodStorageUsed`                           | The total amount of backup storage supported in bytes from the backup retention window of the Neptune data library cluster. Included in the total number of reports in the TotalBackupStorage Billed Metric. |
| `BufferCacheHitRatio`                           | The percentage of requests provided by the buffer cache. This Metric can be used to diagnose query latency, as cache errors can cause significant delays. If the cache hit rate is below 99.9, please consider upgrading the Instance type to cache more data in memory.|
| `ClusterReplicaLag`                           | For read-only replicas, the total amount of latency (in milliseconds) when replicating updates from the primary instance. |
| `ClusterReplicaLagMaximum`                           | The maximum latency, in milliseconds, between the main instance and each Neptune data repository instance in the data repository cluster. |
| `ClusterReplicaLagMinimum`                           | The minimum latency, in milliseconds, between the main instance and each Neptune data repository instance in the data repository cluster. |
| `CPUUtilization`                           | CPU usage percentage. |
| `EngineUptime`                           | The length of the instance runtime in seconds.|
| `FreeableMemory`                           | The available amount of random access memory in bytes. |
| `GlobalDbDataTransferBytes`                           | The number of bytes of redo log data transmitted from the primary server in the AWS region to the secondary AWS region in the Neptune global data library. |
| `GlobalDbReplicatedWriteIO`                           | The number of write I/O operations replicated from the primary server is stored in the global data library in the cluster volume AWS area in the secondary data library.|
| `Neptune` | The billing calculation for each data repository cluster in the global data repository uses VolumeWriteIOPS to measure the metric of write operations performed within that cluster. For the primary data repository cluster, the billing calculation uses GlobalDbReplicatedWriteIO to consider cross regional replication of the secondary data repository cluster.|
| `GlobalDbProgressLag`                           | For user and system transactions, the secondary cluster lags behind the primary cluster in milliseconds. |
| `GremlinRequestsPerSec`                           | The number of requests to the Gremlin engine per second. |
| `GremlinWebSocketOpenConnections`                           | The number of times WebSocket is connected to Neptune. |
| `LoaderRequestsPerSec`                           | The number of loader requests per second. |
| `MainRequestQueuePendingRequests`                           | The number of requests waiting to be executed in the input queue. When the request exceeds the maximum queue capacity, Neptune will start restricting the request. |
| `NCUUtilization`                           | At the cluster level, NCUUtilization reports the percentage of maximum capacity used by the entire cluster.|
| `NetworkThroughput`                           | The network throughput, in bytes per second, of each instance in the Neptune data library cluster received and transmitted from the client to the client. This throughput does not include the network traffic between instances in the data library cluster and cluster volumes. |


## Object {#object}

The collected AWS Neptune Cluster object data structure can be viewed in "Infrastructure - Custom" under the object data.

```json
{
  "measurement": "aws_neptune_cluster",
  "tags": {
    "DBClusterIdentifier"      :"test",
    "class"             :"aws_neptune_cluster",
    "cloud_provider"    :"aws",
    "FunctionName"      :"dataflux-alb",
    "name"              :"dataflux-alb",
    "PackageType"       :"Zip",
    "RegionId"          :"cn-northwest-1",
    "RevisionId"        :"5e52ff51-615a-4ecb-96b7-40083a7b4b62",
    "Role"              :"arn:aws-cn:iam::294654068288:role/service-role/s3--guance-role-3w34zo42",
    "Runtime"           :"python3.7",
    "Version"           :"$LATEST"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON data}",
    "AvailabilityZones"   : "{Availability Zone JSON data}",
    "message"             : "{Instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may be subject to changes in subsequent updates.*
>
