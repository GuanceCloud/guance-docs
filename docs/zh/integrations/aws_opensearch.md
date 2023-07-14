---
title: 'AWS OpenSearch'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
<<<<<<< HEAD
<<<<<<< HEAD
icon: 'icon/aws_opensearch'
=======
__int_icon: 'icon/aws_opensearch'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
=======
__int_icon: 'icon/aws_opensearch'
>>>>>>> c66e8140414e8da5bc40d96d0cea42cd2412a7c6
dashboard:

  - desc: 'AWS OpenSearch 内置视图'
    path: 'dashboard/zh/aws_opensearch'

monitor:
  - desc: 'AWS OpenSearch 监控器'
    path: 'monitor/zh/aws_opensearch'

---



# AWS OpenSearch

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func ](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（AWS-CloudWatch采集）」(ID：`guance_aws_cloudwatch`)
- 「观测云集成（AWS-OpenSearch采集）」(ID：`guance_aws_open_search`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/monitoring.html){:target="_blank"}

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
| `DeletedDocuments`                                           | 跨集群的所有数据节点已标记为删除的文档总数。这些文档不会再出现在搜索结果中，但 OpenSearch 只会在分段合并期间将已删除的文档从磁盘中移除。此指标在提出删除请求后会增加，在分段合并后会减少。相关统计数据：最小值、最大值、平均值 |
| `CPUUtilization`                                             | 集群中数据节点的 CPU 利用率百分比。最大值显示 CPU 利用率最高的节点。平均值表示集群中的所有节点。此指标也可用于单独的节点。相关统计数据：Maximum、Average |
| `FreeStorageSpace`                                           | 集群中各数据节点的可用空间。`Sum` 显示集群的总可用空间，但您必须保留一分钟的时间来获取准确值。`Minimum` 和 `Maximum` 分别显示具有最小和最大可用空间的节点。此指标也可用于单独的节点。OpenSearch`ClusterBlockException`当该指标达到`0`时，服务会抛出。要恢复，您必须删除索引，添加更大的实例，或向现有实例添加基于 EBS 的存储。要了解更多信息，请参阅 [缺少可用存储空间](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/handling-errors.html#handling-errors-watermark){:target="_blank"}。OpenSearch服务控制台以 GiB 为单位显示此值。亚马逊CloudWatch控制台将其显示在 MiB 中。注意`FreeStorageSpace`将始终低于OpenSearch`_cluster/stats`和 `_cat/allocation` API 提供的值。OpenSearch服务会在每个实例上为内部操作预留一定比例的存储空间。有关更多信息，请参阅[计算存储要求](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/sizing-domains.html#bp-storage){:target="_blank"}。相关统计数据：Minimum、Maximum、Average、Sum |
| `ClusterUsedSpace`                                           | 集群的已使用空间总量。您必须保留一分钟的时间来获取准确值。OpenSearch服务控制台以 GiB 为单位显示此值。亚马逊CloudWatch控制台将其显示在 MiB 中。相关统计数据：Minimum、Maximum |
| `ClusterIndexWritesBlocked`                                  | 指示您的集群是接受还是阻止传入的写入请求。值为 0 表示集群接受请求。值为 1 表示阻止请求。一些常见的因素包括：`FreeStorageSpace` 过低或 `JVMMemoryPressure` 过高。为了缓解这一问题，可以考虑增加磁盘空间或扩展集群。相关统计数据：Maximum |
| `JVMMemoryPressure`                                          | 用于集群中所有数据节点的 Java 堆的最大百分比。OpenSearch服务将实例的一半 RAM 用于 Java 堆，最大堆大小为 32 GiB。您最多可以将实例的 RAM 垂直扩展至 64GiB，此时可以通过添加实例水平扩展。请参阅[亚马逊OpenSearch服务的推荐CloudWatch警报](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/cloudwatch-alarms.html){:target="_blank"}。相关统计数据：Maximum注意在服务软件 R20220323 中更改了此指标的逻辑。有关更多信息，请参阅[版本注释](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/release-notes.html){:target="_blank"}。 |
| `OldGenJVMMemoryPressure`                                    | 集群中所有数据节点上用于“上一代”的 Java 堆的最大百分比。此指标也在节点级别获取。相关统计数据：Maximum |
| `AutomatedSnapshotFailure`                                   | 集群的失败的自动快照的数量。值 `1` 指示在过去的 36 个小时内未为域拍摄自动快照。相关统计数据：Minimum、Maximum |
| `CPUCreditBalance`                                           | 集群中的数据节点可用的剩余 CPU 积分。一个 CPU 信用提供一个完整 CPU 核心性能一分钟。有关更多信息，请参阅 [Amazon EC2 开发人员指南](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-credits-baseline-concepts.html){:target="_blank"}中的 *CPU 组*。此指标仅对 T2 实例类型有效。相关统计数据：Minimum |
| `OpenSearchDashboardsHealthyNodes`（以前称之为 `KibanaHealthyNodes`） | OpenSearch仪表板的运行状况检查。如果最小值、最大值和平均值都等于 1，则控制面板运行正常。如果您有 10 个节点，最大值为 1，最小值为 0，平均值为 0.7，则意味着 7 个节点 (70%) 运行正常，3 个节点 (30%) 运行状况不佳。相关统计数据：最小值、最大值、平均值 |
| `KibanaReportingFailedRequestSysErrCount`                    | 由于服务器问题或功能限制而失败的生成OpenSearch仪表板报告的请求数。相关统计数据：总计 |
| `KibanaReportingFailedRequestUserErrCount`                   | 由于客户端问题而失败的生成OpenSearch仪表板报告的请求数。相关统计数据：总计 |
| `KibanaReportingRequestCount`                                | 生成OpenSearch仪表板报告的请求总数。相关统计数据：总计       |
| `KibanaReportingSuccessCount`                                | 成功生成OpenSearch仪表板报告的请求数。相关统计数据：总计     |
| `KMSKeyError`                                                | 值 1 表示已禁用用于加密静态数据的 AWS KMS 密钥。要将域还原为正常操作，请重新启用该密钥。控制台仅对该加密静态数据的域显示此指标。相关统计数据：Minimum、Maximum |
| `KMSKeyInaccessible`                                         | 值为 1 表示用于加密静态数据的AWS KMS密钥已被删除或撤消了其对OpenSearch服务的授权。您无法恢复处于此状态的域。但如果您具有手动快照，则可以使用它将该域的数据迁移到新域。控制台仅对该加密静态数据的域显示此指标。相关统计数据：Minimum、Maximum |
| `InvalidHostHeaderRequests`                                  | 针对 OpenSearch 集群的包含无效（或缺少）主机标头的 HTTP 请求数。有效请求包括作为主机标头值的域主机名。OpenSearch服务拒绝对没有限制性访问策略的公共访问域提出的无效请求。我们建议对所有域应用限制性访问策略。如果您看到此指标的较大值，请确认您的 OpenSearch 客户端在其请求中包含域主机名（例如，而不是其 IP 地址）。相关统计数据：总计 |
| `OpenSearchRequests(previously ElasticsearchRequests)`       | 对 OpenSearch 集群发出的请求数。相关统计数据：总计           |
| `2xx, 3xx, 4xx, 5xx`                                         | 导致指定的 HTTP 响应代码（2*xx*、3*xx*、4*xx*、5*xx*）的对域的请求数。相关统计数据：总计 |
| `ThroughputThrottle`                                         | 表示磁盘是否受到限制。当和的总吞吐量高于最大吞吐量时 `ReadThroughputMicroBursting``WriteThroughputMicroBursting`，就会发生节流。最大吞吐量是实例吞吐量或预置卷吞吐量的较低值。值为 1 表示磁盘已受到限制。值为 0 表示行为正常。有关实例吞吐量的信息，请参阅 [Amazon EBS 优化实](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html){:target="_blank"}例。有关卷吞吐量的信息，请参阅 [Amazon EBS 卷类型](http://aws.amazon.com/ebs/volume-types/){:target="_blank"}。相关统计数据：Minimum、Maximum |

## 对象 {#object}

采集到的AWS OpenSearch 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
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
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
> 
> 提示 2：本脚本`tags.name`对应的数据字段为`DomainName`，使用本脚本的时候需要注意多个 AWS 账户内不要出现重复的`DomainName`值。
> 
> 提示 3：`tags.ClusterConfig`、`tags.Endpoint`、`tags.ServiceSoftwareOptions`、`fields.message`、`fields.EBSOptions`、`fields.Endpoints`、均为 JSON 序列化后字符串
