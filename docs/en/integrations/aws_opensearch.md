---
title: 'AWS OpenSearch'
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_opensearch'
dashboard:

  - desc: 'AWS OpenSearch Monitoring View'
    path: 'dashboard/zh/aws_opensearch'

monitor:
  - desc: 'AWS OpenSearch Monitor'
    path: 'monitor/zh/aws_opensearch'

---

<!-- markdownlint-disable MD025 -->
# AWS OpenSearch
<!-- markdownlint-enable -->


AWS OpenSearch, including number of connections, number of requests, latency, slow query, etc.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（AWS-OpenSearchCollect）」(ID：`guance_aws_open_search`)

Click 【Install】 and enter the corresponding parameters: Aws AK, Aws account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configuring Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-open-search/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS OpenSearch monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aws Cloud Monitor Metrics Details](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html){:target="_blank"}



| Metric                                                         | Metric Description                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `ClusterStatus.green`                                        | The value of 1 indicates that all index shards are allocated to nodes in the cluster. Relevant statistical data: Maximum |
| `ClusterStatus.yellow`                                       | The value of 1 indicates that all primary shards of the indexes are allocated to nodes in the cluster, but at least one replica shard of an index is not. For more information, please refer to Yellow Cluster Status{:target="_blank"}: Relevant statistical data: Maximum |
| `ClusterStatus.red`                                          | The value of 1 indicates that at least one primary shard and replica shard of an index are not allocated to nodes in the cluster. For more information, please refer to Red Cluster Status{:target="_blank"}: Relevant statistical data: Maximum |
| `Shards.active`                                              | The total number of active primary and replica shards. Relevant statistical data: Maximum, Total      |
| `Shards.unassigned`                                          | The number of shards that are not allocated to nodes in the cluster. Relevant statistical data: Maximum, Total       |
| `Shards.delayedUnassigned`                                   | The number of shards whose allocation has been delayed due to timeout settings on their nodes. Relevant statistical data: Maximum, Total |
| `Shards.activePrimary`                                       | The number of active primary shards. Relevant statistical data: Maximum, Total                     |
| `Shards.initializing`                                        | The number of shards that are currently initializing. Relevant statistical data: Total                       |
| `Shards.relocating`                                          | The number of shards that are currently relocating. Relevant statistical data: Total                     |
| `Nodes`                                                      | The number of nodes in the OpenSearch service cluster, including dedicated master nodes and data nodes. For more information, please refer to Change Configuration in Amazon OpenSearch Service{:target="_blank"}: Relevant statistical data: Maximum |
| `SearchableDocuments`                                        | The total number of searchable documents across all data nodes in the cross-cluster. Relevant statistical data: Minimum, Maximum, Average|
| `CPUUtilization`                                             | The CPU utilization percentage of data nodes in the cluster. The maximum value represents the node with the highest CPU utilization. The average value represents all nodes in the cluster. This metric can also be used for individual nodes. Relevant statistical data: Maximum, Average |
| `ClusterUsedSpace`                                           | The total amount of used space in the cluster. You must allow one minute to obtain an accurate value. The OpenSearch service console displays this value in GiB, while the Amazon CloudWatch console displays it in MiB. Relevant statistical data: Minimum, Maximum |
| `ClusterIndexWritesBlocked`                                     | Indicates whether your cluster is accepting or blocking incoming write requests. A value of 0 means the cluster is accepting requests, while a value of 1 means requests are blocked. Some common factors include low FreeStorageSpace or high JVMMemoryPressure. To address this issue, consider increasing disk space or scaling the cluster. Relevant statistical data: Maximum |
| `FreeStorageSpace`                                                 | The available space for each data node in the cluster. The Sum value displays the total available space for the cluster, but you must allow one minute to obtain an accurate value. Minimum and Maximum values represent the nodes with the smallest and largest available space, respectively. This metric can also be used for individual nodes.When this metric reaches 0, the service throws an OpenSearchClusterBlockException. To recover, you must delete indexes, add larger instances, or add EBS-based storage to existing instances. For more information, please refer to "Lack of Available Storage Space" documentation.The OpenSearch service console displays this value in GiB, while the Amazon CloudWatch console displays it in MiB |
| `JVMMemoryPressure`                                          | The maximum percentage of Java heap used for all data nodes in the cluster. The OpenSearch service allocates half of the instance's RAM for the Java heap, with a maximum heap size of 32 GiB. You can vertically scale the instance's RAM up to 64 GiB, and horizontal scaling is possible by adding instances. For recommended CloudWatch alarms for Amazon OpenSearch service, please refer to Amazon OpenSearch Service Recommended CloudWatch Alarms{:target="_blank"}.Relevant statistical data: Maximum. Note that there have been changes to the logic of this metric in service software R20220323. For more information, please see the Release Notes{:target="_blank"} |
| `JVMGCYoungCollectionCount`                                  | The number of "Old Gen" garbage collection runs. In a cluster with sufficient resources, this number should remain small and not grow frequently. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `JVMGCOldCollectionTime`                                     | The time taken for "Old Gen" garbage collection in the cluster, measured in milliseconds. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `JVMGCYoungCollectionTime`                                   | The time taken for "Young Gen" garbage collection in the cluster, measured in milliseconds. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `JVMGCOldCollectionCount`                                    | The number of "Young Gen" garbage collection runs. A large number of continuously increasing runs is normal for cluster operations. This metric is also available at the node level. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `IndexingLatency`                                            | The difference in total time (measured in milliseconds) for all index operations in the node between minute N and minute (N-1) |
| `IndexingRate`                                               | The number of index operations per minute |
| `SearchLatency`                                              | The difference in total time (measured in milliseconds) for all search operations in the node between minute N and minute (N-1) |
| `SearchRate`                                                 | The total number of search requests for all shards on the data nodes per minute |
| `SegmentCount`                                               | The number of shards on the data nodes. The more shards you have, the longer it takes for each search. OpenSearch sometimes merges smaller shards into larger ones. Relevant node statistical data: Maximum, Average. Relevant cluster statistical data: Sum, Maximum, Average |
| `SysMemoryUtilization`                                       | The percentage of used instance memory. A higher value for this metric is normal and usually does not indicate any issues with the cluster. For better indications of potential performance and stability problems, refer to the JVMMemoryPressure metric. Relevant node statistical data: Minimum, Maximum, Average. Relevant cluster statistical data: Minimum, Maximum, Average |
| `OpenSearchDashboardsConcurrentConnections`                  | The active concurrent connection count on the OpenSearch dashboard. If this number is consistently high, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapTotal`                              | The amount of heap memory allocated to the OpenSearch dashboard, measured in MiB (`Mebibytes`). The precise memory allocation may vary based on different EC2 instance types. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUsed`                               | The absolute amount of heap memory used by the OpenSearch dashboard, measured in MiB (`Mebibytes`). Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUtilization`                        | The maximum available heap memory percentage used by the OpenSearch dashboard. If this value exceeds 80%, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Minimum, Maximum, Average |
| `OpenSearchDashboardsResponseTimesMaxInMillis`               | The maximum time (measured in milliseconds) required for the OpenSearch dashboard to respond to requests. If requests consistently take a long time to return results, consider increasing the instance type size. Relevant node statistical data: Maximum. Relevant cluster statistical data: Maximum, Average|
| `OpenSearchDashboardsOS1MinuteLoad`                          | The one-minute average CPU load on the OpenSearch dashboard. Ideally, the CPU load should be kept below 1.00. While temporary spikes are acceptable, if this metric consistently stays above 1.00, we recommend increasing the instance type size. Relevant node statistical data: Average. Relevant cluster statistical data: Average, Maximum |
| `OpenSearchDashboardsRequestTotal`                           | The total number of HTTP requests sent to the OpenSearch dashboard. If your system is slow or you notice a large number of dashboard requests, consider increasing the instance type size. Relevant node statistical data: Total. Relevant cluster statistical data: Sum |
| `ThreadpoolForce_mergeQueue`                                 | The number of queued tasks in the force merge thread pool. If the queue size is consistently large, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `ThreadpoolForce_mergeRejected`                              | The number of rejected tasks in the force merge thread pool. If this number continues to grow, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum |
| `ThreadpoolForce_mergeThreads`                               | The size of the force merge thread pool. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `ThreadpoolSearchQueue`                                      | The number of queued tasks in the search thread pool. If the queue size is consistently large, consider scaling your cluster. The maximum size of the search queue is 1000. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `ThreadpoolSearchRejected`                                   | The number of rejected tasks in the search thread pool. If this number continues to grow, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum |
| `ThreadpoolSearchThreads`                                    | The size of the search thread pool. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `Threadpoolsql-workerQueue`                                  | The number of queued tasks in the SQL search thread pool. If the queue size is consistently large, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum, Maximum, Average |
| `Threadpoolsql-workerRejected`                               | The number of rejected tasks in the SQL search thread pool. If this number continues to grow, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Sum |
| `Threadpoolsql-workerThreads`                                | The size of the SQL search thread pool. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `ThreadpoolWriteQueue`                                       | The number of queued tasks in the write thread pool. If the queue size is consistently large, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `ThreadpoolWriteRejected`                                    | The number of rejected tasks in the write thread pool. If this number continues to increase, consider scaling your cluster. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `ThreadpoolWriteThreads`                                     | The size of the write thread pool. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum |
| `CoordinatingWriteRejected`                                  | The total number of rejections that occurred on the coordinating node due to index pressure since the last OpenSearch service process startup. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum. This metric is available in version 7.1 and higher |
| `ReplicaWriteRejected`                                       | The total number of rejections that occurred on replica shards due to index pressure since the last OpenSearch service process startup. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum. This metric is available in version 7.1 and higher |
| `PrimaryWriteRejected`                                       | The total number of rejections that occurred on primary shards due to index pressure since the last OpenSearch service process startup. Relevant node statistical data: Maximum. Relevant cluster statistical data: Average, Sum. This metric is available in version 7.1 and higher |
| `ReadLatency`                                                | The latency of read operations on EBS volumes in seconds. This metric is also available for individual nodes. Relevant statistical data: Minimum, Maximum, Average |
| `ReadThroughput`                                             | The throughput of read operations on EBS volumes in bytes per second. This metric is also available for individual nodes. Relevant statistical data: Minimum, Maximum, Average |
| `ReadIOPS`                                                   | The number of input and output (I/O) operations per second for read operations on EBS volumes. This metric is also available for individual nodes. Relevant statistical data: Minimum, Maximum, Average |
| `WriteIOPS`                                                  | The number of input and output (I/O) operations per second for write operations on EBS volumes. This metric is also available for individual nodes. Relevant statistical data: Minimum, Maximum, Average |
| `WriteLatency`                                               | The latency of write operations on EBS volumes, measured in seconds. This metric is also available for individual nodes. Relevant statistical data: Minimum, Maximum, Average |
| `BurstBalance`                                               | The percentage of remaining burst balance of an EBS volume, which represents the accumulated I/O credits. A value of 100 indicates that the volume has reached the maximum number of credits. If this percentage is below 70%, please refer to the "EBS Burst Balance Low" issue. For domains with gp3 volume type and domains with gp2 volumes larger than 1000 GiB in size, the burst balance will stay at 0. Relevant statistical data: Minimum, Maximum, Average |
| `CurrentPointInTime`                                         | The number of active PIT (Point-in-Time) search contexts in a node |
| `TotalPointInTime`                                           | The number of PIT (Point-in-Time) search contexts that have expired since the node started |
| `HasActivePointInTime`                                       | A value of 1 indicates that there are active PIT (Point-in-Time) search contexts on the node since it started. A value of 0 indicates that there are no active PIT search contexts |
| `HasUsedPointInTime`                                         | A value of 1 indicates that there are expired PIT (Point-in-Time) search contexts on the node since it started. A value of 0 indicates that there are no expired PIT search contexts |
| `AsynchronousSearchInitializedRate`                          | The number of asynchronous searches that were initiated in the past 1 minute |
| `AsynchronousSearchRunningCurrent`                           | The number of asynchronous searches that are currently running |
| `AsynchronousSearchCompletionRate`                           | The number of asynchronous searches that were successfully completed in the past 1 minute |
| `AsynchronousSearchFailureRate`                              | The number of asynchronous searches that were completed and the number that failed in the last minute |
| `AsynchronousSearchPersistRate`                              | The number of asynchronous searches that have been continuously running in the last minute |
| `AsynchronousSearchRejected`                                 | The total number of asynchronous searches that have been rejected since the node started |
| `AsynchronousSearchCancelled`                                | The total number of asynchronous searches that have been cancelled since the node started |
| `SQLRequestCount`                                            | The total number of requests to the _SQL API. Relevant statistic: Sum |
| `SQLUnhealthy`                                               | A value of 1 indicates that the SQL plugin returned a 5xx response code or passed an invalid query DSL to OpenSearch in response to a specific request. Other requests will continue to succeed. A value of 0 indicates no recent failures. If you see a continuous value of 1, investigate the issues with your client's requests to the plugin. Relevant statistic: Maximum |
| `SQLDefaultCursorRequestCount`                               | Similar to SQLRequestCount, but only counts paginated requests. Relevant statistic: Total |
| `SQLFailedRequestCountByCusErr`                              | The number of requests to the _SQL API that failed due to client issues. For example, requests may fail with an HTTP status code 400 if there's an IndexNotFoundException. Relevant statistic: Total |
| `SQLFailedRequestCountBySysErr`                              | The number of requests to the _SQL API that failed due to server issues or feature limitations. For example, requests may fail with an HTTP status code 503 if there's a VerificationException. Relevant statistic: Total |
| `OldGenJVMMemoryPressure`                                    | The maximum percentage of the Java heap used for "old generation" on all data nodes in the cluster. This metric is also available at the node level. Relevant statistic: Maximum |
| `OpenSearchDashboardsHealthyNodes`（以前称之为 `KibanaHealthyNodes`） | Health check of the OpenSearch dashboard. If the minimum, maximum, and average values are all equal to 1, then the dashboard is running normally. For example, if you have 10 nodes and the maximum value is 1, the minimum value is 0, and the average value is 0.7, it means that 7 nodes (70%) are running normally, and 3 nodes (30%) are not in good health. Relevant statistics: Minimum, Maximum, Average |
| `InvalidHostHeaderRequests`                                  | The number of HTTP requests to the OpenSearch cluster that contain invalid (or missing) host headers. Valid requests include domain `hostnames` as the host header value. OpenSearch service rejects invalid requests made to public access domains without restrictive access policies. It is recommended to apply restrictive access policies to all domains. If you see a large value for this metric, please verify that your OpenSearch client includes the domain hostname in its requests (e.g., instead of its IP address). Relevant statistics: Total |
| `OpenSearchRequests(previously ElasticsearchRequests)`       | The number of requests made to the OpenSearch cluster. Relevant Statistics: Total         |
| `2xx, 3xx, 4xx, 5xx`                                         | The number of requests to the domain that resulted in the specified HTTP response code (2*xx*, 3*xx*, 4*xx*, 5*xx*). Relevant Statistics: Total |


## Object {#object}
The data structure of collected Tencent Cloud Redis object can be viewed in 'Infrastructure - Custom' where object data is available

```json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"        : "crs-xxxx",
    "BillingMode" : "0",
    "Engine"      : "Redis",
    "InstanceId"  : "crs-xxxx",
    "InstanceName": "solution",
    "Port"        : "6379",
    "ProductType" : "standalone",
    "ProjectId"   : "0",
    "RegionId"    : "ap-shanghai",
    "Status"      : "2",
    "Type"        : "6",
    "WanIp"       : "172.x.x.x",
    "ZoneId"      : "200002"
  },
  "fields": {
    "ClientLimits"    : "10000",
    "Createtime"      : "2022-07-14 13:54:14",
    "DeadlineTime"    : "0000-00-00 00:00:00",
    "InstanceNodeInfo": "{Instance node info}",
    "InstanceTitle"   : "instance",
    "Size"            : 1024,
    "message"         : "{Instance JSON data}"
  }
}
```


