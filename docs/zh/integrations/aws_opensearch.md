---
title: 'AWS OpenSearch'
tags: 
  - AWS
summary: 'AWS OpenSearch，包括连接数、请求数、时延、慢查询等。'
__int_icon: 'icon/aws_opensearch'
dashboard:

  - desc: 'AWS OpenSearch 内置视图'
    path: 'dashboard/zh/aws_opensearch'

monitor:
  - desc: 'AWS OpenSearch 监控器'
    path: 'monitor/zh/aws_opensearch'

---

<!-- markdownlint-disable MD025 -->
# AWS OpenSearch
<!-- markdownlint-enable -->


 AWS OpenSearch，包括连接数、请求数、时延、慢查询等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS OpenSearch 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-OpenSearch采集）」(ID：`guance_aws_open_search`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-open-search/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好AWS OpenSearch,默认的指标集如下, 可以通过配置的方式采集更多的指标 [AWS云监控指标详情](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html){:target="_blank"}



## 集群指标

亚马逊OpenSearch服务为集群提供以下指标。

| 指标                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `ClusterStatus.green`                                        | 值为 1 指示将所有索引分片分配给集群中的节点。相关统计数据：Maximum |
| `ClusterStatus.yellow`                                       | 值为 1 指示将所有索引的主要分片分配给集群中的节点，但是至少有一个索引的分片副本不是如此。有关更多信息，请参阅[黄色集群状态](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-yellow-cluster-status){:target="_blank"}：相关统计数据：Maximum |
| `ClusterStatus.red`                                          | 值为 1 指示至少一个索引的主分片和副本分片未分配给集群中的节点。有关更多信息，请参阅[红色集群状态](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-red-cluster-status){:target="_blank"}：相关统计数据：Maximum |
| `Shards.active`                                              | 活动主分区和副本分区的总数。相关统计数据：最大值、总计       |
| `Shards.unassigned`                                          | 未分配给集群中节点的分区数。相关统计数据：最大值、总计       |
| `Shards.delayedUnassigned`                                   | 其节点分配因超时设置已延迟的分区数。相关统计数据：最大值、总计 |
| `Shards.activePrimary`                                       | 活动主分区数。相关统计数据：最大值、总计                     |
| `Shards.initializing`                                        | 正在初始化的分区数。相关统计数据：总计                       |
| `Shards.relocating`                                          | 正在重新定位的分区数。相关统计数据：总计                     |
| `Nodes`                                                      | OpenSearch服务集群中的节点数量，包括专用主UltraWarm节点和节点。有关更多信息，请参阅[在亚马逊OpenSearch服务中更改配置](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/managedomains-configuration-changes.html){:target="_blank"}：相关统计数据：Maximum |
| `SearchableDocuments`                                        | 跨集群中所有数据节点的可搜索文档的总数。相关统计数据：最小值、最大值、平均值 |
| `CPUUtilization`                                             | 集群中数据节点的 CPU 利用率百分比。最大值显示 CPU 利用率最高的节点。平均值表示集群中的所有节点。此指标也可用于单独的节点。相关统计数据：Maximum、Average |
| `ClusterUsedSpace`                                           | 集群的已使用空间总量。您必须保留一分钟的时间来获取准确值。OpenSearch服务控制台以 GiB 为单位显示此值。亚马逊CloudWatch控制台将其显示在 MiB 中。相关统计数据：Minimum、Maximum |
| `ClusterIndexWritesBlocked`                                     | 指示您的集群是接受还是阻止传入的写入请求。值为 0 表示集群接受请求。值为 1 表示阻止请求。一些常见的因素包括：`FreeStorageSpace` 过低或 `JVMMemoryPressure` 过高。为了缓解这一问题，可以考虑增加磁盘空间或扩展集群。相关统计数据：Maximum |
| `FreeStorageSpace`                                                 | 集群中各数据节点的可用空间。Sum 显示集群的总可用空间，但您必须保留一分钟的时间来获取准确值。Minimum 和 Maximum 分别显示具有最小和最大可用空间的节点。此指标也可用于单独的节点。OpenSearchClusterBlockException当该指标达到0时，服务会抛出。要恢复，您必须删除索引，添加更大的实例，或向现有实例添加基于 EBS 的存储。要了解更多信息，请参阅 缺少可用存储空间。OpenSearch服务控制台以 GiB 为单位显示此值。亚马逊CloudWatch控制台将其显示在 MiB 中。 |
| `JVMMemoryPressure`                                          | 用于集群中所有数据节点的 Java 堆的最大百分比。OpenSearch服务将实例的一半 RAM 用于 Java 堆，最大堆大小为 32 GiB。您最多可以将实例的 RAM 垂直扩展至 64GiB，此时可以通过添加实例水平扩展。请参阅[亚马逊OpenSearch服务的推荐CloudWatch警报](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/cloudwatch-alarms.html){:target="_blank"}。相关统计数据：Maximum注意在服务软件 R20220323 中更改了此指标的逻辑。有关更多信息，请参阅[版本注释](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/release-notes.html){:target="_blank"}。 |
| `JVMGCYoungCollectionCount`                                  | “年老代”垃圾回收的运行次数。在具有足够资源的集群中，此数字应保持很小并且不会频繁增长。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `JVMGCOldCollectionTime`                                     | 集群执行“年老代”垃圾回收所花费的时间，以毫秒为单位。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `JVMGCYoungCollectionTime`                                   | 集群执行“年轻代”垃圾回收所花费的时间，以毫秒为单位。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `JVMGCOldCollectionCount`                                    | “年轻代”垃圾回收的运行次数。大量不断增长的运行数对于集群操作来说是正常的。此指标也在节点级别获取。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `IndexingLatency`                                            | 节点中所有索引操作在分钟 N 和分钟 (N-1) 之间所用的总时间（以毫秒为单位）的差值。 |
| `IndexingRate`                                               | 每分钟的索引操作数。 |
| `SearchLatency`                                              | 节点中所有搜索在分钟 N 和分钟 (N-1) 之间所用的总时间（以毫秒为单位）的差值。 |
| `SearchRate`                                                 | 数据节点上所有分片的每分钟搜索请求总数。 |
| `SegmentCount`                                               | 数据节点上的分段数。您拥有的分段越多，每次搜索所花费的时间就越长。OpenSearch有时会将较小的分段合并为较大的分段。相关节点统计数据：最大值、平均值 相关集群统计数据：Sum、Maximum、Average |
| `SysMemoryUtilization`                                       | 使用中的实例内存的百分比。此指标的值较高是正常的，通常不表示集群存在问题。有关潜在性能和稳定性问题的更好指示，请参阅 JVMMemoryPressure 指标。相关节点统计数据：Minimum、Maximum、Average 相关集群统计数据：Minimum、Maximum、Average |
| `OpenSearchDashboardsConcurrentConnections`                  | OpenSearch仪表板的活动并发连接数。如果此数字始终很高，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `OpenSearchDashboardsHeapTotal`                              | 在 MiB 中分配给OpenSearch仪表板的堆内存量。不同的 EC2 实例类型可能会影响精确的内存分配。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `OpenSearchDashboardsHeapUsed`                               | MiB 中OpenSearch仪表板使用的堆内存的绝对量。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `OpenSearchDashboardsHeapUtilization`                        | OpenSearch仪表板使用的最大可用堆内存百分比。如果此值超过 80%，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Minimum、Maximum、Average |
| `OpenSearchDashboardsResponseTimesMaxInMillis`               | OpenSearch仪表板响应请求所需的最大时间（以毫秒为单位）。如果请求一直花费很长时间才能返回结果，请考虑增加实例类型的大小。 相关节点统计数据：Maximum 相关集群统计数据：最大值、平均值|
| `OpenSearchDashboardsOS1MinuteLoad`                          | OpenSearch仪表板的一分钟 CPU 平均负载。理想情况下，CPU 负载应保持在 1.00 以下。虽然临时峰值很好，但如果此指标始终高于 1.00，我们建议增加实例类型的大小。相关节点统计数据：Average 相关集群统计数据：Average、Maximum |
| `OpenSearchDashboardsRequestTotal`                           | 向OpenSearch仪表板发出的 HTTP 请求总数。如果您的系统速度较慢，或者您看到大量的控制面板请求，请考虑增加实例类型的大小。相关节点统计数据：总计 相关集群统计数据：Sum |
| `ThreadpoolForce_mergeQueue`                                 | 强制合并线程池中的排队任务数。如果队列大小一直很大，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `ThreadpoolForce_mergeRejected`                              | 强制合并线程池中的已拒绝任务数。如果此数字持续增长，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Sum |
| `ThreadpoolForce_mergeThreads`                               | 强制合并线程池的大小。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `ThreadpoolSearchQueue`                                      | 搜索线程池中的排队任务数。如果队列大小一直很大，请考虑扩展您的集群。搜索队列的最大大小为 1000。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `ThreadpoolSearchRejected`                                   | 搜索线程池中的已拒绝任务数。如果此数字持续增长，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Sum |
| `ThreadpoolSearchThreads`                                    | 搜索线程池的大小。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `Threadpoolsql-workerQueue`                                  | SQL 搜索线程池中的排队任务数。如果队列大小一直很大，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Sum、Maximum、Average |
| `Threadpoolsql-workerRejected`                               | SQL 搜索线程池中的已拒绝任务数。如果此数字持续增长，请考虑扩展您的集群。相关节点统计数据：Maximum 相关集群统计数据：Sum |
| `Threadpoolsql-workerThreads`                                | SQL 搜索线程池的大小。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `ThreadpoolWriteQueue`                                       | 写入线程池中的排队任务数。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `ThreadpoolWriteRejected`                                    | 写入线程池中的已拒绝任务数。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `ThreadpoolWriteThreads`                                     | 写入线程池的大小。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum |
| `CoordinatingWriteRejected`                                  | 自上次OpenSearch服务进程启动以来，由于索引压力而在协调节点上发生的拒绝总数。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum 此指标在版本 7.1 及更高版本中可用。 |
| `ReplicaWriteRejected`                                       | 自上次OpenSearch服务进程启动以来，由于索引压力，副本分片上发生的拒绝总数。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum 此指标在版本 7.1 及更高版本中可用。 |
| `PrimaryWriteRejected`                                       | 自上次OpenSearch服务进程启动以来，由于索引压力而在主分片上发生的拒绝总数。相关节点统计数据：Maximum 相关集群统计数据：Average、Sum 此指标在版本 7.1 及更高版本中可用。 |
| `ReadLatency`                                                | EBS 卷上读取操作的延迟（以秒为单位）。此指标也可用于单独的节点。相关统计数据：最小值、最大值、平均值 |
| `ReadThroughput`                                             | BS 卷上读取操作的吞吐量（以字节/秒为单位）。此指标也可用于单独的节点。相关统计数据：最小值、最大值、平均值 |
| `ReadIOPS`                                                   | 针对 EBS 卷上的读取操作的每秒输入和输出 (I/O) 操作数。此指标也可用于单独的节点。 相关统计数据：最小值、最大值、平均值 |
| `WriteIOPS`                                                  | 针对 EBS 卷上的写入操作的每秒输入和输出 (I/O) 操作数。此指标也可用于单独的节点。相关统计数据：最小值、最大值、平均值 |
| `WriteLatency`                                               | EBS 卷上写入操作的延迟（以秒为单位）。此指标也可用于单独的节点。相关统计数据：最小值、最大值、平均值 |
| `BurstBalance`                                               | 一个 EBS 卷的可爆发存储桶中剩余输入和输出（I/O）积分的百分比。值为 100 表示该卷积累的积分数量已达最大数量。如果此百分比低于 70%，请参阅 EBS 可爆发容量余额低。对于具有 gp3 卷类型的域以及具有卷大小超过 1000 GiB 的 gp2 卷的域，突增余额保持在 0。相关统计数据：最小值、最大值、平均值 |
| `CurrentPointInTime`                                         | 节点中活跃 PIT 搜索上下文的数量。 |
| `TotalPointInTime`                                           | 自节点启动以来过期的 PIT 搜索上下文的数量。 |
| `HasActivePointInTime`                                       | 值为 1 表示自节点启动以来节点上存在活动的 PIT 上下文。值为 0 表示没有。 |
| `HasUsedPointInTime`                                         | 值为 1 表示自节点启动以来节点上存在过期的 PIT 上下文。值为 0 表示没有。 |
| `AsynchronousSearchInitializedRate`                          | 过去 1 分钟内初始化的异步搜索数。 |
| `AsynchronousSearchRunningCurrent`                           | 当前正在运行的异步搜索数。 |
| `AsynchronousSearchCompletionRate`                           | 过去 1 分钟内成功完成的异步搜索数。 |
| `AsynchronousSearchFailureRate`                              | 最后一分钟内完成和失败的异步搜索数。 |
| `AsynchronousSearchPersistRate`                              | 过去 1 分钟内持续存在的异步搜索数。 |
| `AsynchronousSearchRejected`                                 | 自节点启动时间以来拒绝的异步搜索总数。 |
| `AsynchronousSearchCancelled`                                | 自节点启动时间以来取消的异步搜索总数。 |
| `SQLRequestCount`                                            | 对 _SQL API 的请求数。相关统计数据：总计 |
| `SQLUnhealthy`                                               | 值为 1 表示 SQL 插件将返回 5xx 响应代码或将无效的查询 DSL 传递到 OpenSearch 来响应特定请求。其他请求将继续成功。值为 0 表示最近未失败。如果您看到持续值为 1，请排查您的客户端对插件发出的请求的问题。相关统计数据：Maximum |
| `SQLDefaultCursorRequestCount`                               | 类似于SQLRequestCount，但仅计算分页请求。相关统计数据：总计 |
| `SQLFailedRequestCountByCusErr`                              | 由于客户端问题而失败的对 _SQL API 的请求数。例如，请求可能会因 IndexNotFoundException 返回 HTTP 状态代码 400。相关统计数据：总计 |
| `SQLFailedRequestCountBySysErr`                              | 由于服务器问题或功能限制而失败的对 _SQL API 的请求数。例如，请求可能会因 VerificationException 返回 HTTP 状态代码 503。相关统计数据：总计 |
| `OldGenJVMMemoryPressure`                                    | 集群中所有数据节点上用于“上一代”的 Java 堆的最大百分比。此指标也在节点级别获取。相关统计数据：Maximum |
| `OpenSearchDashboardsHealthyNodes`（以前称之为 `KibanaHealthyNodes`） | OpenSearch仪表板的运行状况检查。如果最小值、最大值和平均值都等于 1，则控制面板运行正常。如果您有 10 个节点，最大值为 1，最小值为 0，平均值为 0.7，则意味着 7 个节点 (70%) 运行正常，3 个节点 (30%) 运行状况不佳。相关统计数据：最小值、最大值、平均值 |
| `InvalidHostHeaderRequests`                                  | 针对 OpenSearch 集群的包含无效（或缺少）主机标头的 HTTP 请求数。有效请求包括作为主机标头值的域主机名。OpenSearch服务拒绝对没有限制性访问策略的公共访问域提出的无效请求。我们建议对所有域应用限制性访问策略。如果您看到此指标的较大值，请确认您的 OpenSearch 客户端在其请求中包含域主机名（例如，而不是其 IP 地址）。相关统计数据：总计 |
| `OpenSearchRequests(previously ElasticsearchRequests)`       | 对 OpenSearch 集群发出的请求数。相关统计数据：总计           |
| `2xx, 3xx, 4xx, 5xx`                                         | 导致指定的 HTTP 响应代码（2*xx*、3*xx*、4*xx*、5*xx*）的对域的请求数。相关统计数据：总计 |

## 对象 {#object}

采集到的AWS OpenSearch 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"                  : "df-prd-es",
    "EngineVersion"         : "Elasticsearch_7.10",
    "DomainId"              : "5882XXXXX135/df-prd-es",
    "DomainName"            : "df-prd-es",
    "ClusterConfig"         : "{域中的实例类型和实例数量 JSON 数据}",
    "ServiceSoftwareOptions": "{服务软件的当前状态 JSON 数据}",
    "region"                : "cn-northwest-1",
    "RegionId"              : "cn-northwest-1"
  },
  "fields": {
    "EBSOptions": "{指定域的弹性块存储数据 JSON 数据}",
    "Endpoints" : "{用于提交索引和搜索请求的域端点的映射 JSON 数据}",
    "message"   : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
> 提示 2：本脚本`tags.name`对应的数据字段为`DomainName`，使用本脚本的时候需要注意多个 AWS 账户内不要出现重复的`DomainName`值。
> 提示 3：`tags.ClusterConfig`、`tags.Endpoint`、`tags.ServiceSoftwareOptions`、`fields.message`、`fields.EBSOptions`、`fields.Endpoints`、均为 JSON 序列化后字符串
