---
title: 'AWS OpenSearch'
tags: 
  - AWS
summary: 'AWS OpenSearch, including connection counts, request counts, latency, slow queries, etc.'
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


 AWS OpenSearch, including connection counts, request counts, latency, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Hosted Version Activation Script

1. Log in to the <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu and select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【AWS】, and fill in the required information on the interface; if cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test click 【Save】, if the test fails, check whether the relevant configuration information is correct and retest
5. In the 【Cloud Account Management】 list, you can see the added cloud account. Click the corresponding cloud account to enter the details page
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS OpenSearch`, click the 【Install】 button, and install by following the installation interface.

#### Manual Activation Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aws_open_search`
2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.
3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.
4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】, which can immediately execute once without waiting for the regular time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」 whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, check under 「Infrastructure / Custom」 whether asset information exists.
3. In <<< custom_key.brand_name >>>, under 「Metrics」 check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring AWS OpenSearch, the default metric set is as follows. You can collect more metrics via configuration [AWS Cloud Monitoring Metric Details](https://docs.aws.amazon.com/en_us/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html){:target="_blank"}



## Cluster Metrics

Amazon OpenSearch service provides the following metrics for clusters.

| Metrics                                                     | Description                                                     |
| :---------------------------------------------------------- | :-------------------------------------------------------------- |
| `ClusterStatus.green`                                       | A value of 1 indicates that all index shards are assigned to nodes in the cluster. Related statistics: Maximum |
| `ClusterStatus.yellow`                                      | A value of 1 indicates that all primary index shards are assigned to nodes in the cluster, but at least one index's replica shards are not. For more information, see [Yellow Cluster Status](https://docs.aws.amazon.com/en_us/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-yellow-cluster-status){:target="_blank"}: Related statistics: Maximum |
| `ClusterStatus.red`                                         | A value of 1 indicates that at least one index's primary shard and replica shards are not assigned to nodes in the cluster. For more information, see [Red Cluster Status](https://docs.aws.amazon.com/en_us/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-red-cluster-status){:target="_blank"}: Related statistics: Maximum |
| `Shards.active`                                             | The total number of active primary shards and replica shards. Related statistics: Maximum, Total |
| `Shards.unassigned`                                         | The number of shards not assigned to nodes in the cluster. Related statistics: Maximum, Total |
| `Shards.delayedUnassigned`                                  | The number of shards whose node assignment has been delayed due to timeout settings. Related statistics: Maximum, Total |
| `Shards.activePrimary`                                      | The number of active primary shards. Related statistics: Maximum, Total |
| `Shards.initializing`                                       | The number of shards currently initializing. Related statistics: Total |
| `Shards.relocating`                                         | The number of shards currently relocating. Related statistics: Total |
| `Nodes`                                                     | The number of nodes in the OpenSearch service cluster, including dedicated master UltraWarm nodes and nodes. For more information, see [Changing Configurations in Amazon OpenSearch Service](https://docs.aws.amazon.com/en_us/opensearch-service/latest/developerguide/managedomains-configuration-changes.html){:target="_blank"}: Related statistics: Maximum |
| `SearchableDocuments`                                       | The total number of searchable documents across all data nodes in the cluster. Related statistics: Minimum, Maximum, Average |
| `CPUUtilization`                                            | The percentage of CPU utilization for data nodes in the cluster. The maximum shows the node with the highest CPU utilization. The average represents all nodes in the cluster. This metric can also be used for individual nodes. Related statistics: Maximum, Average |
| `ClusterUsedSpace`                                          | The total amount of used space in the cluster. You must wait one minute to get an accurate value. The OpenSearch service console displays this value in GiB. The Amazon CloudWatch console displays it in MiB. Related statistics: Minimum, Maximum |
| `ClusterIndexWritesBlocked`                                 | Indicates whether your cluster accepts or blocks incoming write requests. A value of 0 means the cluster accepts requests. A value of 1 means blocking requests. Some common factors include: `FreeStorageSpace` too low or `JVMMemoryPressure` too high. To mitigate this issue, consider increasing disk space or expanding the cluster. Related statistics: Maximum |
| `FreeStorageSpace`                                          | The available space across all data nodes in the cluster. Sum shows the total available space in the cluster, but you must wait one minute to get an accurate value. Minimum and Maximum show the nodes with the least and most available space respectively. This metric can also be used for individual nodes. When this metric reaches 0, the service throws an `OpenSearchClusterBlockException`. To recover, you must delete indices, add larger instances, or add EBS-based storage to existing instances. For more information, see Missing Available Storage Space. The OpenSearch service console displays this value in GiB. The Amazon CloudWatch console displays it in MiB. |
| `JVMMemoryPressure`                                         | The maximum percentage of Java heap used across all data nodes in the cluster. The OpenSearch service allocates half of the instance's RAM to the Java heap, with a maximum heap size of 32 GiB. You can vertically scale the instance's RAM up to 64GiB, at which point you can horizontally scale by adding instances. See Recommended CloudWatch Alarms for Amazon OpenSearch Service. Related statistics: Maximum Note: The logic for this metric was changed in service software R20220323. For more information, see Release Notes. |
| `JVMGCYoungCollectionCount`                                 | The number of times "young generation" garbage collection runs. In a cluster with sufficient resources, this number should remain small and not increase frequently. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCOldCollectionTime`                                    | The time spent by the cluster performing "old generation" garbage collection, in milliseconds. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCYoungCollectionTime`                                  | The time spent by the cluster performing "young generation" garbage collection, in milliseconds. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `JVMGCOldCollectionCount`                                   | The number of times "old generation" garbage collection runs. A large continuously growing number is normal for cluster operations. This metric is also obtained at the node level. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `IndexingLatency`                                          | The difference in the total time (in milliseconds) taken by all indexing operations on the node between minute N and minute (N-1). |
| `IndexingRate`                                              | The number of indexing operations per minute. |
| `SearchLatency`                                             | The difference in the total time (in milliseconds) taken by all searches on the node between minute N and minute (N-1). |
| `SearchRate`                                                | The total number of search requests per minute across all shards on data nodes. |
| `SegmentCount`                                              | The number of segments on data nodes. The more segments you have, the longer each search takes. OpenSearch sometimes merges smaller segments into larger ones. Related node statistics: Maximum, Average Related cluster statistics: Sum, Maximum, Average |
| `SysMemoryUtilization`                                      | The percentage of memory used on the instance. A higher value for this metric is normal and usually does not indicate a problem with the cluster. For better indications of potential performance and stability issues, see JVMMemoryPressure metrics. Related node statistics: Minimum, Maximum, Average Related cluster statistics: Minimum, Maximum, Average |
| `OpenSearchDashboardsConcurrentConnections`                 | The number of active concurrent connections to OpenSearch dashboards. If this number remains high consistently, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapTotal`                            | The total heap memory allocated to OpenSearch dashboards in MiB. Different EC2 instance types may affect precise memory allocation. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUsed`                             | The absolute amount of heap memory used by OpenSearch dashboards in MiB. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `OpenSearchDashboardsHeapUtilization`                       | The percentage of maximum available heap memory used by OpenSearch dashboards. If this value exceeds 80%, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Minimum, Maximum, Average |
| `OpenSearchDashboardsResponseTimesMaxInMillis`              | The maximum time (in milliseconds) it takes for OpenSearch dashboards to respond to requests. If requests consistently take a long time to return results, consider increasing the size of the instance type. Related node statistics: Maximum Related cluster statistics: Maximum, Average |
| `OpenSearchDashboardsOS1MinuteLoad`                        | The one-minute CPU average load for OpenSearch dashboards. Ideally, the CPU load should stay below 1.00. While temporary peaks are fine, if this metric consistently stays above 1.00, we recommend increasing the size of the instance type. Related node statistics: Average Related cluster statistics: Average, Maximum |
| `OpenSearchDashboardsRequestTotal`                         | The total number of HTTP requests made to OpenSearch dashboards. If your system is slow or you see a large number of dashboard requests, consider increasing the size of the instance type. Related node statistics: Total Related cluster statistics: Sum |
| `ThreadpoolForce_mergeQueue`                                | The number of queued tasks in the force merge thread pool. If the queue size remains large, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `ThreadpoolForce_mergeRejected`                             | The number of rejected tasks in the force merge thread pool. If this number continues to grow, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `ThreadpoolForce_mergeThreads`                              | The size of the force merge thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolSearchQueue`                                     | The number of queued tasks in the search thread pool. If the queue size remains large, consider scaling your cluster. The maximum size of the search queue is 1000. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolSearchRejected`                                  | The number of rejected tasks in the search thread pool. If this number continues to grow, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `ThreadpoolSearchThreads`                                   | The size of the search thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `Threadpoolsql-workerQueue`                                 | The number of queued tasks in the SQL search thread pool. If the queue size remains large, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum, Maximum, Average |
| `Threadpoolsql-workerRejected`                              | The number of rejected tasks in the SQL search thread pool. If this number continues to grow, consider scaling your cluster. Related node statistics: Maximum Related cluster statistics: Sum |
| `Threadpoolsql-workerThreads`                               | The size of the SQL search thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteQueue`                                      | The number of queued tasks in the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteRejected`                                   | The number of rejected tasks in the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `ThreadpoolWriteThreads`                                    | The size of the write thread pool. Related node statistics: Maximum Related cluster statistics: Average, Sum |
| `CoordinatingWriteRejected`                                 | The total number of rejections on the coordinating node since the last OpenSearch service process started due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in version 7.1 and higher. |
| `ReplicaWriteRejected`                                       | The total number of rejections on replica shards since the last OpenSearch service process started due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in version 7.1 and higher. |
| `PrimaryWriteRejected`                                       | The total number of rejections on primary shards since the last OpenSearch service process started due to index pressure. Related node statistics: Maximum Related cluster statistics: Average, Sum This metric is available in version 7.1 and higher. |
| `ReadLatency`                                               | The latency (in seconds) of read operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `ReadThroughput`                                            | The throughput (in bytes per second) of read operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `ReadIOPS`                                                  | The number of input and output (I/O) operations per second for read operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `WriteIOPS`                                                 | The number of input and output (I/O) operations per second for write operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `WriteLatency`                                              | The latency (in seconds) of write operations on EBS volumes. This metric can also be used for individual nodes. Related statistics: Minimum, Maximum, Average |
| `BurstBalance`                                              | The percentage of remaining input and output (I/O) credits in the burst bucket of an EBS volume. A value of 100 means the volume has accumulated the maximum number of credits. If this percentage drops below 70%, see Low EBS Burst Capacity Balance. For domains with gp3 volume types and domains with gp2 volumes larger than 1000 GiB, the burst balance remains at 0. Related statistics: Minimum, Maximum, Average |
| `CurrentPointInTime`                                        | The number of active PIT search contexts on the node. |
| `TotalPointInTime`                                          | The number of expired PIT search contexts since the node started. |
| `HasActivePointInTime`                                      | A value of 1 indicates that there is an active PIT context on the node since it started. A value of 0 indicates none. |
| `HasUsedPointInTime`                                        | A value of 1 indicates that there is an expired PIT context on the node since it started. A value of 0 indicates none. |
| `AsynchronousSearchInitializedRate`                          | The number of asynchronous searches initialized in the past 1 minute. |
| `AsynchronousSearchRunningCurrent`                           | The number of asynchronous searches currently running. |
| `AsynchronousSearchCompletionRate`                           | The number of asynchronous searches successfully completed in the past 1 minute. |
| `AsynchronousSearchFailureRate`                              | The number of asynchronous searches completed and failed in the last minute. |
| `AsynchronousSearchPersistRate`                              | The number of asynchronous searches persisted in the past 1 minute. |
| `AsynchronousSearchRejected`                                 | The total number of asynchronous searches rejected since the node started. |
| `AsynchronousSearchCancelled`                                | The total number of asynchronous searches cancelled since the node started. |
| `SQLRequestCount`                                           | The number of requests to the _SQL API. Related statistics: Total |
| `SQLUnhealthy`                                              | A value of 1 indicates that the SQL plugin will return a 5xx response code or pass invalid query DSL to OpenSearch in response to specific requests. Other requests will continue to succeed. A value of 0 indicates no recent failures. If you see a consistent value of 1, investigate issues with the requests your client sends to the plugin. Related statistics: Maximum |
| `SQLDefaultCursorRequestCount`                              | Similar to SQLRequestCount, but only counts paginated requests. Related statistics: Total |
| `SQLFailedRequestCountByCusErr`                             | The number of requests to the _SQL API that failed due to client issues. For example, requests might return an HTTP status code 400 due to IndexNotFoundException. Related statistics: Total |
| `SQLFailedRequestCountBySysErr`                             | The number of requests to the _SQL API that failed due to server issues or functional limitations. For example, requests might return an HTTP status code 503 due to VerificationException. Related statistics: Total |
| `OldGenJVMMemoryPressure`                                    | The maximum percentage of Java heap used for "old generation" across all data nodes in the cluster. This metric is also obtained at the node level. Related statistics: Maximum |
| `OpenSearchDashboardsHealthyNodes` (previously called `KibanaHealthyNodes`) | Health check for OpenSearch dashboards. If the minimum, maximum, and average values are all equal to 1, the dashboard is functioning properly. If you have 10 nodes, the maximum is 1, the minimum is 0, and the average is 0.7, it means 7 nodes (70%) are functioning properly and 3 nodes (30%) are unhealthy. Related statistics: Minimum, Maximum, Average |
| `InvalidHostHeaderRequests`                                 | The number of HTTP requests to the OpenSearch cluster containing invalid (or missing) host headers. Valid requests include the domain hostname as the host header value. The OpenSearch service rejects invalid requests for public access domains without restrictive access policies. We recommend applying restrictive access policies to all domains. If you see large values for this metric, confirm that your OpenSearch clients include the domain hostname (e.g., instead of its IP address) in their requests. Related statistics: Total |
| `OpenSearchRequests(previously ElasticsearchRequests)`       | The number of requests issued to the OpenSearch cluster. Related statistics: Total           |
| `2xx, 3xx, 4xx, 5xx`                                         | The number of requests to the domain resulting in the specified HTTP response codes (2*xx*, 3*xx*, 4*xx*, 5*xx*). Related statistics: Total |

## Objects {#object}

The collected AWS OpenSearch object data structure can be viewed from 「Infrastructure - Custom」

```json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"                  : "df-prd-es",
    "EngineVersion"         : "Elasticsearch_7.10",
    "DomainId"              : "5882XXXXX135/df-prd-es",
    "DomainName"            : "df-prd-es",
    "ClusterConfig"         : "{JSON data of instance types and instance numbers in the domain}",
    "ServiceSoftwareOptions": "{JSON data of the current state of the service software}",
    "region"                : "cn-northwest-1",
    "RegionId"              : "cn-northwest-1"
  },
  "fields": {
    "EBSOptions": "{JSON data of elastic block storage for the specified domain}",
    "Endpoints" : "{JSON data mapping of domain endpoints for submitting index and search requests}",
    "message"   : "{instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates*
> Tip 1: The value of `tags.name` is the instance ID, serving as a unique identifier
> Tip 2: The data field corresponding to `tags.name` in this script is `DomainName`. When using this script, ensure that `DomainName` values do not duplicate across multiple AWS accounts.
> Tip 3: `tags.ClusterConfig`, `tags.Endpoint`, `tags.ServiceSoftwareOptions`, `fields.message`, `fields.EBSOptions`, `fields.Endpoints`, are all serialized JSON strings