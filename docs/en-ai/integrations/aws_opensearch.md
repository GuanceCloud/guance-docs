---
title: 'AWS OpenSearch'
tags: 
  - AWS
summary: 'AWS OpenSearch, including connection counts, request numbers, latency, and slow queries.'
__int_icon: 'icon/aws_opensearch'
dashboard:

  - desc: 'Built-in views for AWS OpenSearch'
    path: 'dashboard/en/aws_opensearch'

monitor:
  - desc: 'Monitors for AWS OpenSearch'
    path: 'monitor/en/aws_opensearch'

---

# AWS OpenSearch

 AWS OpenSearch, including connection counts, request numbers, latency, and slow queries.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from AWS OpenSearch, we install the corresponding collection script: "Guance Integration (AWS-OpenSearch Collection)" (ID: `guance_aws_open_search`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details on customizing cloud object metrics, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-open-search/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring AWS OpenSearch, the default metric set is as follows. More metrics can be collected through configuration [AWS Cloud Monitoring Metrics Details](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html){:target="_blank"}



## Cluster Metrics

Amazon OpenSearch Service provides the following metrics for clusters.

| Metric                                                       | Description                                                         |
| :----------------------------------------------------------- | :------------------------------------------------------------------ |
| `ClusterStatus.green`                                        | A value of 1 indicates that all index shards are allocated to nodes in the cluster. Related statistics: Maximum |
| `ClusterStatus.yellow`                                       | A value of 1 indicates that all primary shards of indexes are allocated to nodes in the cluster, but at least one index's replica shards are not. For more information, see [Yellow Cluster Status](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-yellow-cluster-status){:target="_blank"}: Related statistics: Maximum |
| `ClusterStatus.red`                                          | A value of 1 indicates that at least one index's primary shard and replica shards are not allocated to nodes in the cluster. For more information, see [Red Cluster Status](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-red-cluster-status){:target="_blank"}: Related statistics: Maximum |
| `Shards.active`                                              | Total number of active primary and replica shards. Related statistics: Maximum, Total |
| `Shards.unassigned`                                          | Number of shards not assigned to nodes in the cluster. Related statistics: Maximum, Total |
| `Shards.delayedUnassigned`                                   | Number of shards whose node allocation has been delayed due to timeout settings. Related statistics: Maximum, Total |
| `Shards.activePrimary`                                       | Number of active primary shards. Related statistics: Maximum, Total |
| `Shards.initializing`                                        | Number of shards currently initializing. Related statistics: Total |
| `Shards.relocating`                                          | Number of shards currently relocating. Related statistics: Total |
| `Nodes`                                                      | Number of nodes in the OpenSearch service cluster, including dedicated master UltraWarm nodes and nodes. For more information, see [Changing Configuration in Amazon OpenSearch Service](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/managedomains-configuration-changes.html){:target="_blank"}: Related statistics: Maximum |
| `SearchableDocuments`                                        | Total number of searchable documents across all data nodes in the cluster. Related statistics: Minimum, Maximum, Average |
| `CPUUtilization`                                             | Percentage of CPU utilization on data nodes in the cluster. The maximum shows the highest CPU utilization node. The average represents all nodes in the cluster. This metric can also be used for individual nodes. Related statistics: Maximum, Average |
| `ClusterUsedSpace`                                           | Total used space in the cluster. You must wait one minute to get accurate values. The OpenSearch service console displays this value in GiB. The Amazon CloudWatch console displays it in MiB. Related statistics: Minimum, Maximum |
| `ClusterIndexWritesBlocked`                                  | Indicates whether your cluster accepts or blocks incoming write requests. A value of 0 means the cluster accepts requests. A value of 1 means it blocks requests. Common factors include low `FreeStorageSpace` or high `JVMMemoryPressure`. To mitigate this issue, consider increasing disk space or expanding the cluster. Related statistics: Maximum |
| `FreeStorageSpace`                                           | Available space on each data node in the cluster. Sum shows the total available space in the cluster, but you must wait one minute to get accurate values. Minimum and Maximum display the nodes with the least and most available space respectively. This metric can also be used for individual nodes. An OpenSearchClusterBlockException is thrown when this metric reaches 0. To recover, you must delete indices, add larger instances, or add EBS-based storage to existing instances. For more information, see Missing Available Storage Space. The OpenSearch service console displays this value in GiB. The Amazon CloudWatch console displays it in MiB. |
| `JVMMemoryPressure`                                          | Maximum percentage of Java heap used by all data nodes in the cluster. OpenSearch service allocates half of the instance RAM to the Java heap, with a maximum heap size of 32 GiB. You can vertically scale the instance RAM up to 64 GiB, after which you can horizontally scale by adding instances. See [Recommended CloudWatch Alarms for Amazon OpenSearch Service](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/cloudwatch-alarms.html){:target="_blank"}. Related statistics: Maximum Note that the logic for this metric was changed in service software R20220323. For more information, see [Release Notes](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/release-notes.html){:target="_blank"}. |
| `JVMGCYoungCollectionCount`                                  | Number of times young generation garbage collection runs. In a well-resourced cluster, this number should remain small and not frequently increase. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCOldCollectionTime`                                     | Time spent by the cluster on old generation garbage collection, in milliseconds. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCYoungCollectionTime`                                   | Time spent by the cluster on young generation garbage collection, in milliseconds. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCOldCollectionCount`                                    | Number of times old generation garbage collection runs. A consistently growing number of runs is normal for cluster operations. This metric is also obtained at the node level. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `IndexingLatency`                                            | Difference in total time taken by all indexing operations between minute N and minute (N-1), in milliseconds. |
| `IndexingRate`                                               | Number of indexing operations per minute. |
| `SearchLatency`                                              | Difference in total time taken by all searches between minute N and minute (N-1), in milliseconds. |
| `SearchRate`                                                 | Total number of search requests per minute across all shards on data nodes. |
| `SegmentCount`                                               | Number of segments on data nodes. The more segments you have, the longer each search takes. OpenSearch sometimes merges smaller segments into larger ones. Related node statistics: Maximum, Average Related cluster statistics: Sum, Maximum, Average |
| `SysMemoryUtilization`                                       | Percentage of instance memory in use. High values for this metric are normal and typically do not indicate issues with the cluster. For better indicators of potential performance and stability issues, see the JVMMemoryPressure metric. Related node statistics: Minimum, Maximum, Average Related cluster statistics: Minimum, Maximum, Average |
| `OpenSearchDashboardsConcurrentConnections`                  | Number of active concurrent connections to OpenSearch Dashboards. If this number is consistently high, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapTotal`                              | Heap memory allocated to OpenSearch Dashboards in MiB. Different EC2 instance types may affect precise memory allocation. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUsed`                               | Absolute amount of heap memory used by OpenSearch Dashboards in MiB. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUtilization`                        | Percentage of maximum available heap memory used by OpenSearch Dashboards. If this value exceeds 80%, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Minimum, Maximum, Average |
| `OpenSearchDashboardsResponseTimesMaxInMillis`               | Maximum time taken by OpenSearch Dashboards to respond to requests, in milliseconds. If requests consistently take a long time to return results, consider increasing the instance type size. Related node statistics: Maximum Related cluster statistics: Maximum, Average |
| `OpenSearchDashboardsOS1MinuteLoad`                          | One-minute average CPU load on OpenSearch Dashboards. Ideally, the CPU load should stay below 1.00. While temporary spikes are acceptable, if this metric consistently stays above 1.00, we recommend increasing the instance type size. Related node statistics: Average Related cluster statistics: Average, Maximum |
| `OpenSearchDashboardsRequestTotal`                           | Total number of HTTP requests issued to OpenSearch Dashboards. If your system is slow or you see many dashboard requests, consider increasing the instance type size. Related node statistics: Total Related cluster statistics: Sum |
| `ThreadpoolForce_mergeQueue`                                 | Number of queued tasks in the force merge thread pool. If the queue size remains large, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `ThreadpoolForce_mergeRejected`                              | Number of rejected tasks in the force merge thread pool. If this number continuously grows, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `ThreadpoolForce_mergeThreads`                               | Size of the force merge thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolSearchQueue`                                      | Number of queued tasks in the search thread pool. If the queue size remains large, consider scaling your cluster. The maximum queue size for the search thread pool is 1000. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolSearchRejected`                                   | Number of rejected tasks in the search thread pool. If this number continuously grows, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `ThreadpoolSearchThreads`                                    | Size of the search thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `Threadpoolsql-workerQueue`                                  | Number of queued tasks in the SQL search thread pool. If the queue size remains large, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `Threadpoolsql-workerRejected`                               | Number of rejected tasks in the SQL search thread pool. If this number continuously grows, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `Threadpoolsql-workerThreads`                                | Size of the SQL search thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteQueue`                                       | Number of queued tasks in the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteRejected`                                    | Number of rejected tasks in the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteThreads`                                     | Size of the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `CoordinatingWriteRejected`                                  | Total number of rejections on the coordinating node since the last OpenSearch service process start due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in version 7.1 and higher. |
| `ReplicaWriteRejected`                                       | Total number of rejections on replica shards since the last OpenSearch service process start due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in version 7.1 and higher. |
| `PrimaryWriteRejected`                                       | Total number of rejections on primary shards since the last OpenSearch service process start due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in version 7.1 and higher. |
| `ReadLatency`                                                | Latency of read operations on EBS volumes, in seconds. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `ReadThroughput`                                             | Throughput of read operations on EBS volumes, in bytes per second. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `ReadIOPS`                                                   | Number of input/output (I/O) operations per second for read operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `WriteIOPS`                                                  | Number of input/output (I/O) operations per second for write operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `WriteLatency`                                               | Latency of write operations on EBS volumes, in seconds. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `BurstBalance`                                               | Percentage of remaining I/O credits in the burst bucket of an EBS volume. A value of 100 indicates that the volume has accumulated the maximum number of credits. If this percentage is below 70%, see Low Burst Balance for EBS Volumes. For domains with gp3 volumes and domains with gp2 volumes over 1000 GiB, the burst balance remains at 0. Related statistics: Minimum, Maximum, Average |
| `CurrentPointInTime`                                         | Number of active PIT search contexts on the node. |
| `TotalPointInTime`                                           | Number of expired PIT search contexts since the node started. |
| `HasActivePointInTime`                                       | A value of 1 indicates that there is an active PIT context on the node since it started. A value of 0 indicates none. |
| `HasUsedPointInTime`                                         | A value of 1 indicates that there is an expired PIT context on the node since it started. A value of 0 indicates none. |
| `AsynchronousSearchInitializedRate`                          | Number of asynchronous searches initialized in the past minute. |
| `AsynchronousSearchRunningCurrent`                           | Number of asynchronous searches currently running. |
| `AsynchronousSearchCompletionRate`                           | Number of asynchronous searches successfully completed in the past minute. |
| `AsynchronousSearchFailureRate`                              | Number of asynchronous searches completed and failed in the past minute. |
| `AsynchronousSearchPersistRate`                              | Number of asynchronous searches persisted in the past minute. |
| `AsynchronousSearchRejected`                                 | Total number of asynchronous searches rejected since the node started. |
| `AsynchronousSearchCancelled`                                | Total number of asynchronous searches canceled since the node started. |
| `SQLRequestCount`                                            | Number of requests to the _SQL API. Related statistics: Total |
| `SQLUnhealthy`                                               | A value of 1 indicates that the SQL plugin will return 5xx response codes or pass invalid query DSL to OpenSearch for specific requests. Other requests will continue to succeed. A value of 0 indicates no recent failures. If you see consistent values of 1, investigate issues with requests your client sends to the plugin. Related statistics: Maximum |
| `SQLDefaultCursorRequestCount`                               | Similar to SQLRequestCount but only counts paginated requests. Related statistics: Total |
| `SQLFailedRequestCountByCusErr`                              | Number of requests to the _SQL API failed due to client issues. For example, requests might return an HTTP status code 400 due to IndexNotFoundException. Related statistics: Total |
| `SQLFailedRequestCountBySysErr`                              | Number of requests to the _SQL API failed due to server issues or functional limitations. For example, requests might return an HTTP status code 503 due to VerificationException. Related statistics: Total |
| `OldGenJVMMemoryPressure`                                    | Maximum percentage of Java heap used for "old generation" on all data nodes in the cluster. This metric is also obtained at the node level. Related statistics: Maximum |
| `OpenSearchDashboardsHealthyNodes` (previously `KibanaHealthyNodes`) | Health check for OpenSearch Dashboards. If minimum, maximum, and average all equal 1, the dashboard is running normally. If you have 10 nodes, the maximum is 1, the minimum is 0, and the average is 0.7, it means 7 nodes (70%) are running normally, and 3 nodes (30%) are unhealthy. Related statistics: Minimum, Maximum, Average |
| `InvalidHostHeaderRequests`                                  | Number of HTTP requests to the OpenSearch cluster containing invalid (or missing) host headers. Valid requests include the domain hostname as the host header value. OpenSearch service rejects invalid requests for public access domains without restrictive access policies. We recommend applying restrictive access policies to all domains. If you see large values for this metric, confirm that your OpenSearch client includes the domain hostname (e.g., instead of its IP address) in its requests. Related statistics: Total |
| `OpenSearchRequests` (previously `ElasticsearchRequests`)     | Number of requests to the OpenSearch cluster. Related statistics: Total           |
| `2xx, 3xx, 4xx, 5xx`                                         | Number of requests to the domain resulting in specified HTTP response codes (2*xx*, 3*xx*, 4*xx*, 5*xx*). Related statistics: Total |

## Objects {#object}

The structure of AWS OpenSearch objects collected can be viewed in 「Infrastructure - Custom」

```json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"                  : "df-prd-es",
    "EngineVersion"         : "Elasticsearch_7.10",
    "DomainId"              : "5882XXXXX135/df-prd-es",
    "DomainName"            : "df-prd-es",
    "ClusterConfig"         : "{JSON data of instance types and instance counts in the domain}",
    "ServiceSoftwareOptions": "{JSON data of current service software state}",
    "region"                : "cn-northwest-1",
    "RegionId"              : "cn-northwest-1"
  },
  "fields": {
    "EBSOptions": "{JSON data of elastic block storage for the specified domain}",
    "Endpoints" : "{JSON mapping of domain endpoints for submitting index and search requests}",
    "message"   : "{JSON data of instance}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
> Note 2: The data field corresponding to `tags.name` in this script is `DomainName`. When using this script, ensure that multiple AWS accounts do not have duplicate `DomainName` values.
> Note 3: `tags.ClusterConfig`, `tags.Endpoint`, `tags.ServiceSoftwareOptions`, `fields.message`, `fields.EBSOptions`, `fields.Endpoints` are all JSON serialized strings.