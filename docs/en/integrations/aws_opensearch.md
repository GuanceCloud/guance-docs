---
title: 'AWS OpenSearch'
tags: 
  - AWS
summary: 'AWS OpenSearch, including connection counts, request numbers, latency, slow queries, etc.'
__int_icon: 'icon/aws_opensearch'
dashboard:

  - desc: 'AWS OpenSearch built-in views'
    path: 'dashboard/en/aws_opensearch'

monitor:
  - desc: 'AWS OpenSearch monitors'
    path: 'monitor/en/aws_opensearch'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_opensearch'
---

<!-- markdownlint-disable MD025 -->
# AWS OpenSearch
<!-- markdownlint-enable -->


 AWS OpenSearch, including connection counts, request numbers, latency, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for AWS OpenSearch, we install the corresponding collection script: 「Guance Integration (AWS-OpenSearch Collection)」(ID: `guance_aws_open_search`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default to collecting some configurations, for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-open-search/){:target="_blank"}



### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have corresponding automatic trigger configurations, and you can also check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring AWS OpenSearch, the default metric sets are as follows, and more metrics can be collected through configuration [AWS Cloud Monitoring Metric Details](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html){:target="_blank"}



## Cluster Metrics

Amazon OpenSearch service provides the following metrics for clusters.

| Metrics                                                       | Description                                                         |
| :------------------------------------------------------------ | :------------------------------------------------------------------ |
| `ClusterStatus.green`                                         | A value of 1 indicates that all index shards are assigned to nodes in the cluster. Related statistics: Maximum |
| `ClusterStatus.yellow`                                        | A value of 1 indicates that all primary shards of the indexes are assigned to nodes in the cluster, but at least one index does not have its shard replicas assigned. For more information, see [Yellow Cluster Status](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-yellow-cluster-status){:target="_blank"}: Related statistics: Maximum |
| `ClusterStatus.red`                                           | A value of 1 indicates that the primary and replica shards of at least one index are not assigned to nodes in the cluster. For more information, see [Red Cluster Status](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-red-cluster-status){:target="_blank"}: Related statistics: Maximum |
| `Shards.active`                                               | The total number of active primary and replica shards. Related statistics: Maximum, Total |
| `Shards.unassigned`                                           | The number of shards not assigned to nodes in the cluster. Related statistics: Maximum, Total |
| `Shards.delayedUnassigned`                                    | The number of shards whose node assignment has been delayed due to timeout settings. Related statistics: Maximum, Total |
| `Shards.activePrimary`                                        | The number of active primary shards. Related statistics: Maximum, Total |
| `Shards.initializing`                                         | The number of shards being initialized. Related statistics: Total |
| `Shards.relocating`                                           | The number of shards being relocated. Related statistics: Total |
| `Nodes`                                                       | The number of nodes in the OpenSearch service cluster, including dedicated master UltraWarm nodes and nodes. For more information, see [Changing Configuration in Amazon OpenSearch Service](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/managedomains-configuration-changes.html){:target="_blank"}: Related statistics: Maximum |
| `SearchableDocuments`                                         | The total number of searchable documents across all data nodes in the cluster. Related statistics: Minimum, Maximum, Average |
| `CPUUtilization`                                              | The percentage of CPU utilization on data nodes in the cluster. The maximum shows the node with the highest CPU utilization. The average represents all nodes in the cluster. This metric can also be used for individual nodes. Related statistics: Maximum, Average |
| `ClusterUsedSpace`                                            | The total amount of space used by the cluster. You must wait one minute to get an accurate value. The OpenSearch service console displays this value in GiB. The Amazon CloudWatch console displays it in MiB. Related statistics: Minimum, Maximum |
| `ClusterIndexWritesBlocked`                                   | Indicates whether your cluster accepts or blocks incoming write requests. A value of 0 means the cluster accepts requests. A value of 1 means blocking requests. Some common factors include: `FreeStorageSpace` too low or `JVMMemoryPressure` too high. To mitigate this issue, consider increasing disk space or expanding the cluster. Related statistics: Maximum |
| `FreeStorageSpace`                                            | The available space on each data node in the cluster. Sum shows the total available space in the cluster, but you must wait one minute to get an accurate value. Minimum and Maximum respectively show the nodes with the least and most available space. This metric can also be used for individual nodes. An OpenSearchClusterBlockException is thrown when this metric reaches 0. To recover, you must delete indices, add larger instances, or add EBS-based storage to existing instances. For more information, see Missing Available Storage Space. The OpenSearch service console displays this value in GiB. The Amazon CloudWatch console displays it in MiB. |
| `JVMMemoryPressure`                                           | The maximum percentage of Java heap used on all data nodes in the cluster. The OpenSearch service uses half of the instance's RAM for the Java heap, with a maximum heap size of 32 GiB. You can vertically scale the instance's RAM up to 64GiB, after which you can horizontally scale by adding instances. See [Recommended CloudWatch Alarms for Amazon OpenSearch Service](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/cloudwatch-alarms.html){:target="_blank"}. Related statistics: Maximum Note that the logic of this metric was changed in service software R20220323. For more information, see [Release Notes](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/release-notes.html){:target="_blank"}. |
| `JVMGCYoungCollectionCount`                                   | The number of times "young generation" garbage collection runs. In a cluster with sufficient resources, this number should remain small and not grow frequently. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCOldCollectionTime`                                      | The time spent by the cluster performing "old generation" garbage collection, in milliseconds. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCYoungCollectionTime`                                    | The time spent by the cluster performing "young generation" garbage collection, in milliseconds. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCOldCollectionCount`                                     | The number of times "old generation" garbage collection runs. A large continuously growing number is normal for cluster operations. This metric is also obtained at the node level. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `IndexingLatency`                                             | The difference in the total time used by all indexing operations on the node between minute N and minute (N-1), in milliseconds. |
| `IndexingRate`                                                | The number of indexing operations per minute. |
| `SearchLatency`                                               | The difference in the total time used by all searches on the node between minute N and minute (N-1), in milliseconds. |
| `SearchRate`                                                  | The total number of search requests per minute across all shards on data nodes. |
| `SegmentCount`                                                | The number of segments on data nodes. The more segments you have, the longer each search takes. OpenSearch sometimes merges smaller segments into larger ones. Related node statistics: Maximum, Average Related cluster statistics: Sum, Maximum, Average |
| `SysMemoryUtilization`                                        | The percentage of instance memory in use. A higher value for this metric is normal and usually does not indicate issues with the cluster. For better indications of potential performance and stability problems, see JVMMemoryPressure metrics. Related node statistics: Minimum, Maximum, Average Related cluster statistics: Minimum, Maximum, Average |
| `OpenSearchDashboardsConcurrentConnections`                   | The number of active concurrent connections to OpenSearch dashboards. If this number remains consistently high, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapTotal`                              | The heap memory allocated to OpenSearch dashboards in MiB. Different EC2 instance types may affect precise memory allocation. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUsed`                               | The absolute amount of heap memory used by OpenSearch dashboards in MiB. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUtilization`                        | The percentage of maximum available heap memory used by OpenSearch dashboards. If this value exceeds 80%, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Minimum, Maximum, Average |
| `OpenSearchDashboardsResponseTimesMaxInMillis`               | The maximum time taken by OpenSearch dashboards to respond to requests in milliseconds. If requests consistently take a long time to return results, consider increasing the instance type size. Related node statistics: Maximum Related cluster statistics: Maximum, Average |
| `OpenSearchDashboardsOS1MinuteLoad`                          | The one-minute average CPU load of OpenSearch dashboards. Ideally, the CPU load should remain below 1.00. While temporary spikes are fine, if this metric consistently stays above 1.00, we recommend increasing the instance type size. Related node statistics: Average Related cluster statistics: Average, Maximum |
| `OpenSearchDashboardsRequestTotal`                           | The total number of HTTP requests issued to OpenSearch dashboards. If your system is slow or you see a large number of dashboard requests, consider increasing the instance type size. Related node statistics: Total Related cluster statistics: Sum |
| `ThreadpoolForce_mergeQueue`                                 | The number of queued tasks in the force merge thread pool. If the queue size remains consistently large, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `ThreadpoolForce_mergeRejected`                              | The number of rejected tasks in the force merge thread pool. If this number continues to grow, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `ThreadpoolForce_mergeThreads`                               | The size of the force merge thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolSearchQueue`                                      | The number of queued tasks in the search thread pool. If the queue size remains consistently large, consider scaling your cluster. The maximum size of the search queue is 1000. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolSearchRejected`                                   | The number of rejected tasks in the search thread pool. If this number continues to grow, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `ThreadpoolSearchThreads`                                    | The size of the search thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `Threadpoolsql-workerQueue`                                  | The number of queued tasks in the SQL search thread pool. If the queue size remains consistently large, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `Threadpoolsql-workerRejected`                               | The number of rejected tasks in the SQL search thread pool. If this number continues to grow, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `Threadpoolsql-workerThreads`                                | The size of the SQL search thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteQueue`                                       | The number of queued tasks in the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteRejected`                                    | The number of rejected tasks in the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteThreads`                                     | The size of the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `CoordinatingWriteRejected`                                  | The total number of rejections at the coordinating node since the last OpenSearch service process started due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in versions 7.1 and higher. |
| `ReplicaWriteRejected`                                       | The total number of rejections at the replica shard since the last OpenSearch service process started due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in versions 7.1 and higher. |
| `PrimaryWriteRejected`                                       | The total number of rejections at the primary shard since the last OpenSearch service process started due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in versions 7.1 and higher. |
| `ReadLatency`                                                | The latency of read operations on EBS volumes (in seconds). This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `ReadThroughput`                                             | The throughput of read operations on EBS volumes (in bytes/second). This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `ReadIOPS`                                                   | The number of input/output (I/O) operations per second for read operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `WriteIOPS`                                                  | The number of input/output (I/O) operations per second for write operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `WriteLatency`                                               | The latency of write operations on EBS volumes (in seconds). This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `BurstBalance`                                               | The percentage of remaining input/output (I/O) credits in the burst bucket of an EBS volume. A value of 100 indicates that the volume has accumulated the maximum number of credits. If this percentage drops below 70%, see Low Burst Balance for EBS Volumes. For domains with gp3 volume types and domains with gp2 volumes larger than 1000 GiB, the burst balance remains at 0. Related statistics: Minimum, Maximum, Average |
| `CurrentPointInTime`                                         | The number of active PIT search contexts on the node. |
| `TotalPointInTime`                                           | The number of expired PIT search contexts since the node started. |
| `HasActivePointInTime`                                       | A value of 1 indicates that there is an active PIT context on the node since it started. A value of 0 indicates none. |
| `HasUsedPointInTime`                                         | A value of 1 indicates that there is an expired PIT context on the node since it started. A value of 0 indicates none. |
| `AsynchronousSearchInitializedRate`                          | The number of asynchronous searches initialized in the past one minute. |
| `AsynchronousSearchRunningCurrent`                           | The current number of asynchronous searches running. |
| `AsynchronousSearchCompletionRate`                           | The number of asynchronous searches successfully completed in the past one minute. |
| `AsynchronousSearchFailureRate`                              | The number of asynchronous searches completed and failed in the last one minute. |
| `AsynchronousSearchPersistRate`                              | The number of asynchronous searches persisted in the past one minute. |
| `AsynchronousSearchRejected`                                 | The total number of asynchronous searches rejected since the node started. |
| `AsynchronousSearchCancelled`                                | The total number of asynchronous searches canceled since the node started. |
| `SQLRequestCount`                                            | The number of requests to the _SQL API. Related statistics: Total |
| `SQLUnhealthy`                                               | A value of 1 indicates that the SQL plugin will return 5xx response codes or pass invalid query DSL to OpenSearch to respond to specific requests. Other requests will continue to succeed. A value of 0 indicates no recent failures. If you see persistent values of 1, investigate issues with the requests your client sends to the plugin. Related statistics: Maximum |
| `SQLDefaultCursorRequestCount`                               | Similar to SQLRequestCount, but only counts paginated requests. Related statistics: Total |
| `SQLFailedRequestCountByCusErr`                              | The number of requests to the _SQL API that failed due to client issues. For example, a request might return an HTTP status code 400 due to IndexNotFoundException. Related statistics: Total |
| `SQLFailedRequestCountBySysErr`                              | The number of requests to the _SQL API that failed due to server issues or feature limitations. For example, a request might return an HTTP status code 503 due to VerificationException. Related statistics: Total |
| `OldGenJVMMemoryPressure`                                    | The maximum percentage of Java heap used for "old generation" on all data nodes in the cluster. This metric is also obtained at the node level. Related statistics: Maximum |
| `OpenSearchDashboardsHealthyNodes` (previously called `KibanaHealthyNodes`) | Health check for OpenSearch dashboards. If the minimum, maximum, and average are all equal to 1, the dashboard is running normally. If you have 10 nodes, the maximum is 1, the minimum is 0, and the average is 0.7, it means 7 nodes (70%) are running normally and 3 nodes (30%) are unhealthy. Related statistics: Minimum, Maximum, Average |
| `InvalidHostHeaderRequests`                                  | The number of HTTP requests to the OpenSearch cluster containing invalid (or missing) host headers. Valid requests include the domain hostname as the host header value. OpenSearch service rejects invalid requests for public access domains without restrictive access policies. We recommend applying restrictive access policies to all domains. If you see a large value for this metric, confirm that your OpenSearch client includes the domain hostname (e.g., instead of its IP address) in its requests. Related statistics: Total |
| `OpenSearchRequests(previously ElasticsearchRequests)`       | The number of requests issued to the OpenSearch cluster. Related statistics: Total           |
| `2xx, 3xx, 4xx, 5xx`                                         | The number of requests to the domain resulting in specified HTTP response codes (2*xx*, 3*xx*, 4*xx*, 5*xx*). Related statistics: Total |

## Objects {#object}

The collected AWS OpenSearch object data structure can be viewed from 「Infrastructure-Custom」.

```json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"                  : "df-prd-es",
    "EngineVersion"         : "Elasticsearch_7.10",
    "DomainId"              : "5882XXXXX135/df-prd-es",
    "DomainName"            : "df-prd-es",
    "ClusterConfig"         : "{JSON data of instance types and instance counts in the domain}",
    "ServiceSoftwareOptions": "{JSON data of the current state of service software}",
    "region"                : "cn-northwest-1",
    "RegionId"              : "cn-northwest-1"
  },
  "fields": {
    "EBSOptions": "{JSON data of elastic block storage options for the specified domain}",
    "Endpoints" : "{Mapping JSON data of domain endpoints used to submit index and search requests}",
    "message"   : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Tip 1: The value of `tags.name` is the instance ID, used as unique identification.
> Tip 2: The data field corresponding to `tags.name` in this script is `DomainName`. When using this script, ensure that there are no duplicate `DomainName` values across multiple AWS accounts.
> Tip 3: `tags.ClusterConfig`, `tags.Endpoint`, `tags.ServiceSoftwareOptions`, `fields.message`, `fields.EBSOptions`, `fields.Endpoints`, are all serialized JSON strings.