---
title: 'AWS S3'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_s3'
dashboard:

  - desc: 'AWS S3 内置视图'
    path: 'dashboard/zh/aws_s3'

monitor:
  - desc: 'AWS S3 监控器'
    path: 'monitor/zh/aws_s3'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_s3'
---


<!-- markdownlint-disable MD025 -->
# AWS S3
<!-- markdownlint-enable -->

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS S3`，点击【安装】按钮，弹出安装界面安装即可。

#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_s3`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/metrics-dimensions.html){:target="_blank"}

### CloudWatch 中桶的 Amazon S3 每日存储指标

`AWS/S3` 命名空间包含桶的以下每日存储指标。

| 指标              | 描述                                                         |
| :---------------- | :----------------------------------------------------------- |
| `BucketSizeBytes` | 存储在以下存储类的桶中的数据量（以字节为单位）：S3 Standard (`STANDARD`)S3 Intelligent-Tiering (`INTELLIGENT_TIERING`)S3 Standard-Infrequent Access (`STANDARD_IA`)S3 OneZone-Infrequent Access (`ONEZONE_IA`)低冗余存储（RRS）（`REDUCED_REDUNDANCY`）S3 Glacier Instant Retrieval (`GLACIER_IR`)S3 Glacier Deep Archive (`DEEP_ARCHIVE`)S3 Glacier Flexible Retrieval (`GLACIER`)此值通过汇总桶中所有对象和元数据（当前对象和非当前对象）的大小计算得出，包括所有向桶进行分段上传而未完成的所有部分的大小。有效的存储类型筛选条件：`StandardStorage`、`IntelligentTieringFAStorage`、`IntelligentTieringIAStorage`、`IntelligentTieringAAStorage`、`IntelligentTieringAIAStorage`、`IntelligentTieringDAAStorage`、`StandardIAStorage`、`StandardIASizeOverhead`、`StandardIAObjectOverhead`、`OneZoneIAStorage`、`OneZoneIASizeOverhead`、`ReducedRedundancyStorage`、`GlacierInstantRetrievalSizeOverhead`、`GlacierInstantRetrievalStorage`、`GlacierStorage`、`GlacierStagingStorage`、`GlacierObjectOverhead`、`GlacierS3ObjectOverhead`、`DeepArchiveStorage`、`DeepArchiveObjectOverhead`、`DeepArchiveS3ObjectOverhead` 和 `DeepArchiveStagingStorage`（请参阅 `StorageType` 维度）单位：字节有效统计数据：Average |
| `NumberOfObjects` | 桶中存储的所有存储类的对象的总数。此值通过对桶中的所有对象（包括当前对象和非当前对象）、删除标记以及所有向桶进行分段上传而未完成的所有分段的总数进行计数而计算得出。有效的存储类型筛选条件：`AllStorageTypes` (请参阅 `StorageType` 维度)单位：计数有效统计数据：Average |

### CloudWatch 中的 Amazon S3 CloudWatch 请求指标

`AWS/S3` 命名空间包含以下请求指标。这些指标包括不可计费的请求（如果是来自 COPY 和 Replication 的 GET 请求）。

| 指标                  | 说明                                                         |
| :-------------------- | :----------------------------------------------------------- |
| `AllRequests`         | 向 Amazon S3 桶提出的 HTTP 请求（不论类型如何）的总数。如果您要将某个指标配置用于某个筛选条件，则该指标将仅返回符合该筛选条件要求的 HTTP 请求。单位：计数有效统计数据：Sum |
| `GetRequests`         | 向 Amazon S3 存储桶中的对象提出的 HTTP GET 请求的数量。这不包括列表操作。对于每个 COPY 对象请求的来源，此指标会递增。单位：计数有效统计数据：Sum注意面向分页列表的请求（例如，[列出分段上传](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html){:target="_blank"}、[列出分段](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html){:target="_blank"}、[获取桶对象版本](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html){:target="_blank"}和其他请求）未包含在此指标中。 |
| `PutRequests`         | 向 Amazon S3 存储桶中的对象提出的 HTTP PUT 请求的数量。对于每个 COPY 对象请求的目标，此指标会递增。单位：计数有效统计数据：Sum |
| `DeleteRequests`      | 向 Amazon S3 桶中的对象发出的 HTTP `DELETE` 请求的数量。此指标还包括[删除多个对象](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"}请求。此指标显示发出的请求数量，而不是删除的对象数量。单位：计数有效统计数据：Sum |
| `HeadRequests`        | 向 Amazon S3 桶发出的 HTTP `HEAD` 请求的数量。单位：计数有效统计数据：Sum |
| `PostRequests`        | 向 Amazon S3 桶发出的 HTTP `POST` 请求的数量。单位：计数有效统计数据：Sum注意[删除多个对象](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"}和 [SELECT 对象内容](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"}请求未包含在此指标中。 |
| `SelectRequests`      | 为 Amazon S3 桶中的对象发出的 Amazon S3 [SELECT 对象内容](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"}请求的数量。单位：计数有效统计数据：Sum |
| `SelectBytesScanned`  | 使用 Amazon S3 桶中的 Amazon S3 [SELECT 对象内容](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"}请求扫描的数据字节数。单位：字节有效统计数据：Average (每个请求的字节数)、Sum (每个周期的字节数)、Sample Count、Min、Max（与 p100 相同）、任何在 p0.0 和 p99.9 之间的百分位数 |
| `SelectBytesReturned` | 使用 Amazon S3 桶中的 Amazon S3 [SELECT 对象内容](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"}请求返回的数据字节数。单位：字节有效统计数据：Average (每个请求的字节数)、Sum (每个周期的字节数)、Sample Count、Min、Max（与 p100 相同）、任何在 p0.0 和 p99.9 之间的百分位数 |
| `ListRequests`        | 列出桶内容的 HTTP 请求的数量。单位：计数有效统计数据：Sum    |
| `BytesDownloaded`     | 为向 Amazon S3 桶提出的请求下载的字节数（请求的响应包含正文）。单位：字节有效统计数据：Average (每个请求的字节数)、Sum (每个周期的字节数)、Sample Count、Min、Max（与 p100 相同）、任何在 p0.0 和 p99.9 之间的百分位数 |
| `BytesUploaded`       | 为向 Amazon S3 桶发出的请求上载的字节数（请求包含正文）。单位：字节有效统计数据：Average (每个请求的字节数)、Sum (每个周期的字节数)、Sample Count、Min、Max（与 p100 相同）、任何在 p0.0 和 p99.9 之间的百分位数 |
| `4xxErrors`           | 向 Amazon S3 桶提出的值为 0 或 1 的 HTTP 4xx 客户端错误状态代码请求数。Average 统计数据显示了错误率，Sum 统计数据显示了每个周期内该类型的错误的计数。单位：计数有效统计数据：Average (每个请求的报告数)、Sum (每个周期的报告数)、Min、Max、Sample Count |
| `5xxErrors`           | 向 Amazon S3 桶提出的值为 0 或 1 的 HTTP 5xx 服务器错误状态代码请求数。Average 统计数据显示了错误率，Sum 统计数据显示了每个周期内该类型的错误的计数。单位：计数有效统计数据：Average (每个请求的报告数)、Sum (每个周期的报告数)、Min、Max、Sample Count |
| `FirstByteLatency`    | 从 Amazon S3 桶收到完整请求到开始返回响应的每请求时间。单位：毫秒有效统计数据：Average、Sum、Min、Max（与 p100 相同）、Sample Count、任何在 p0.0 和 p100 之间的百分位数 |
| `TotalRequestLatency` | 从收到第一个字节到将最后一个字节发送到 Amazon S3 桶的已用每请求时间。此指标包括接收请求正文和发送响应正文所耗的时间（未包含在 `FirstByteLatency` 中）。单位：毫秒有效统计数据：Average、Sum、Min、Max（与 p100 相同）、Sample Count、任何在 p0.0 和 p100 之间的百分位数 |

### CloudWatch 中的 S3 复制指标

您可以使用 S3 复制指标，通过跟踪待处理的字节、待处理的操作和复制延迟，监控复制的进度。有关详细信息，请参阅[使用复制指标监控进度](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-metrics.html){:target="_blank"}。

注意:

您可以在 Amazon CloudWatch 中对复制指标启用告警。为复制指标设置警报时，请将 **Missing data treatment (丢失数据处理)** 字段设置为 **Treat missing data as ignore (maintain the alarm state) [将丢失的数据视为忽略（保持警报状态）]**。

| 指标                           | 描述                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `ReplicationLatency`           | 对于给定的复制规则，复制目标 AWS 区域落后于源 AWS 区域的最大秒数。单位：秒有效统计数据：Max |
| `BytesPendingReplication`      | 给定复制规则的待复制对象的总字节数。单位：字节有效统计数据：Max |
| `OperationsPendingReplication` | 给定复制规则的待复制操作数。单位：计数有效统计数据：Max      |
| `OperationsFailedReplication`  | 给定复制规则的复制失败的操作数。单位：计数有效统计信息：总和（失败操作总数）、平均值（失败率）、样本数（复制操作总数） |

### CloudWatch 中的 S3 Storage Lens 存储统计管理工具指标

您可以将 S3 Storage Lens 存储统计管理工具使用情况和活动指标发布到 Amazon CloudWatch，以便在 CloudWatch [dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html){:target="_blank"}（控制面板）中创建运营状况的统一视图。S3 Storage Lens 存储统计管理工具指标已发布到 CloudWatch 中的 `AWS/S3/Storage-Lens` 命名空间。CloudWatch 发布选项可用于已升级为 advanced metrics and recommendations（高级指标和建议）的 S3 Storage Lens 存储统计管理工具控制面板。

有关发布到 CloudWatch 的 S3 Storage Lens 存储统计管理工具指标列表，请参阅 [Amazon S3 Storage Lens 存储统计管理工具指标词汇表](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html){:target="_blank"}。有关维度的完整列表，请参阅 [维度](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}。

### CloudWatch 中的 S3 Object Lambda 请求指标

S3 Object Lambda 包含以下请求指标。

| 指标                     | 描述                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `AllRequests`            | 使用对象 Lambda 接入点向 Amazon S3 桶发出的 HTTP 请求总数。单位：计数有效统计数据：Sum |
| `GetRequests`            | 使用对象 Lambda 接入点对于对象发出的 HTTP `GET` 请求的数量。该指标不包括列出操作。单位：计数有效统计数据：Sum |
| `BytesUploaded`          | 使用对象 Lambda 接入点上传到 Amazon S3 桶的字节数（请求包含正文）。单位：字节有效统计数据：Average (每个请求的字节数)、Sum (每个周期的字节数)、Sample Count、Min、Max（与 p100 相同）、任何在 p0.0 和 p99.9 之间的百分位数 |
| `PostRequests`           | 使用对象 Lambda 接入点向 Amazon S3 桶发出的 HTTP `POST` 请求的数量。单位：计数有效统计数据：Sum |
| `PutRequests`            | 使用对象 Lambda 接入点对于 Amazon S3 桶中的对象发出的 HTTP `PUT` 请求的数量。单位：计数有效统计数据：Sum |
| `DeleteRequests`         | 使用对象 Lambda 接入点对于 Amazon S3 桶中的对象发出的 HTTP `DELETE` 请求的数量。此指标包括[删除多个对象](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"}请求。此指标显示发出的请求数量，而不是删除的对象数量。单位：计数有效统计数据：Sum |
| `BytesDownloaded`        | 为使用对象 Lambda 接入点向 Amazon S3 桶发出的请求下载的字节数（响应包括正文）。单位：字节有效统计数据：Average (每个请求的字节数)、Sum (每个周期的字节数)、Sample Count、Min、Max（与 p100 相同）、任何在 p0.0 和 p99.9 之间的百分位数 |
| `FirstByteLatency`       | 从 Amazon S3 桶通过对象 Lambda 接入点收到完整请求到开始返回响应的每请求时间。此指标取决于在 AWS Lambda 函数将字节返回给对象 Lambda 接入点之前，该函数对于对象进行转换的运行时间。单位：毫秒有效统计数据：Average、Sum、Min、Max（与 p100 相同）、Sample Count、任何在 p0.0 和 p100 之间的百分位数 |
| `TotalRequestLatency`    | 从收到第一个字节到将最后一个字节发送到对象 Lambda 接入点的已用每请求时间。此指标包括接收请求正文和发送响应正文所耗的时间（未包含在 `FirstByteLatency` 中）。单位：毫秒有效统计数据：Average、Sum、Min、Max（与 p100 相同）、Sample Count、任何在 p0.0 和 p100 之间的百分位数 |
| `HeadRequests`           | 使用对象 Lambda 接入点向 Amazon S3 桶发出的 HTTP `HEAD` 请求的数量。单位：计数有效统计数据：Sum |
| `ListRequests`           | 列出 Amazon S3 桶内容的 HTTP `GET` 请求的数量。该指标同时包含 `List` 和 `ListV2` 操作。单位：计数有效统计数据：Sum |
| `4xxErrors`              | 使用对象 Lambda 接入点向 Amazon S3 桶发出的值为 0 或 1 的 HTTP 4xx 服务器错误状态代码请求数。Average 统计数据显示了错误率，Sum 统计数据显示了每个周期内该类型的错误的计数。单位：计数有效统计数据：Average (每个请求的报告数)、Sum (每个周期的报告数)、Min、Max、Sample Count |
| `5xxErrors`              | 使用对象 Lambda 接入点向 Amazon S3 桶发出的值为 0 或 1 的 HTTP 5xx 服务器错误状态代码请求数。Average 统计数据显示了错误率，Sum 统计数据显示了每个周期内该类型的错误的计数。单位：计数有效统计数据：Average (每个请求的报告数)、Sum (每个周期的报告数)、Min、Max、Sample Count |
| `ProxiedRequests`        | 向返回标准 Amazon S3 API 响应的对象 Lambda 接入点发出的 HTTP 请求的数量。（此类请求没有配置 Lambda 函数。）单位：计数有效统计数据：Sum |
| `InvokedLambda`          | 对在其中调用 Lambda 函数的 S3 对象的 HTTP 请求数。单位：计数有效统计数据：Sum |
| `LambdaResponseRequests` | Lambda 函数发出的 `WriteGetObjectResponse` 请求的数量。此指标仅适用于 `GetObject` 请求。 |
| `LambdaResponse4xx`      | 从 Lambda 函数调用 `WriteGetObjectResponse` 时发生的 HTTP 4xx 客户端错误的数量。此指标提供的信息与 `4xxErrors` 相同，但仅适用于 `WriteGetObjectResponse` 调用。 |
| `LambdaResponse5xx`      | 从 Lambda 函数调用 `WriteGetObjectResponse` 时发生的 HTTP 5xx 服务器错误的数量。此指标提供的信息与 `5xxErrors` 相同，但仅适用于 `WriteGetObjectResponse` 调用。 |

### CloudWatch 中 Amazon S3 on Outposts 的指标

有关 CloudWatch 中用于 S3 on Outposts 的指标列表，请参阅[CloudWatch metrics（CloudWatch 指标）](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/S3OutpostsCapacity.html#S3OutpostsCloudWatchMetrics){:target="_blank"}。

### CloudWatch 中的 Amazon S3 维度

下列维度用于筛选 Amazon S3 指标。

| 维度          | 描述                                                         |
| :------------ | :----------------------------------------------------------- |
| `BucketName`  | 此维度筛选您仅为已识别桶请求的数据。                         |
| `StorageType` | 此维度按以下存储类型筛选您存储在桶中的数据：`StandardStorage` – 用于 `STANDARD` 存储类中的对象的字节数。`IntelligentTieringAAStorage` – 用于 `INTELLIGENT_TIERING` 存储类的归档访问层中的对象的字节数。`IntelligentTieringAIAStorage` – 用于 `INTELLIGENT_TIERING` 存储类的归档即时访问层中的对象的字节数。`IntelligentTieringDAAStorage` – 用于 `INTELLIGENT_TIERING` 存储类的深层归档访问层中的对象的字节数。`IntelligentTieringFAStorage` – 用于 `INTELLIGENT_TIERING` 存储类的频繁访问层中的对象的字节数。`IntelligentTieringIAStorage` – 用于 `INTELLIGENT_TIERING` 存储类的不频繁访问层中的对象的字节数。`StandardIAStorage` – 用于“标准 - 不频繁访问层（`STANDARD_IA`）”存储类中的对象的字节数。`StandardIASizeOverhead` – 用于 `STANDARD_IA` 存储类中小于 128KB 的对象的字节数。`IntAAObjectOverhead` – 对于归档访问层中 `INTELLIGENT_TIERING` 存储类的每个对象，S3 Glacier 为索引和相关元数据添加了 32KB 的存储空间。标识和还原对象需要此额外数据。将按照 S3 Glacier 费率对此附加存储收费。`IntAAS3ObjectOverhead` – 对于归档访问层中 `INTELLIGENT_TIERING` 存储类的每个对象，Amazon S3 使用 8KB 的存储空间作为对象和其他元数据的名称。将按照 S3 Standard 标准费率对此附加存储收费。`IntDAAObjectOverhead` – 对于深度归档访问层中 `INTELLIGENT_TIERING` 存储类的每个对象，S3 Glacier 为索引和相关元数据添加了 32KB 的存储空间。标识和还原对象需要此额外数据。按照 S3 Glacier Deep Archive 存储费率对此附加存储收费。`IntDAAS3ObjectOverhead` – 对于深度归档访问层中 `INTELLIGENT_TIERING` 存储类的每个对象，Amazon S3 为索引和相关元数据添加了 8KB 的存储空间。标识和还原对象需要此额外数据。将按照 S3 Standard 标准费率对此附加存储收费。`OneZoneIAStorage` – 用于“S3 单区 - 不频繁访问层（`ONEZONE_IA`）”存储类中的对象的字节数。`OneZoneIASizeOverhead` – 用于 `ONEZONE_IA` 存储类中小于 128KB 的对象的字节数。`ReducedRedundancyStorage` – 用于低冗余存储 (RRS) 类中的对象的字节数。`GlacierInstantRetrievalSizeOverhead` – 用于 S3 Glacier Instant Retrieval 存储类中小于 128KB 的对象的字节数。`GlacierInstantRetrievalStorage` – 用于 S3 Glacier 即时检索存储类中的对象的字节数。`GlacierStorage` – 用于 S3 Glacier Flexible Retrieval 存储类中的对象的字节数。`GlacierStagingStorage` – 在 S3 Glacier Flexible Retrieval 存储类中的对象上完成 `CompleteMultipartUpload` 请求之前，用于多分段对象的各个分段的字节数。`GlacierObjectOverhead` – 对于每个归档对象，S3 Glacier 为索引及相关元数据添加 32KB 存储。标识和还原对象需要此额外数据。按照 S3 Glacier Flexible Retrieval 费率对此附加存储收费。`GlacierS3ObjectOverhead` – 对于归档到 S3 Glacier Flexible Retrieval 的每个对象，Amazon S3 将 8KB 存储用于对象和其他元数据的名称。将按照 S3 Standard 标准费率对此附加存储收费。`DeepArchiveStorage` – 用于 S3 Glacier Deep Archive 存储类中的对象的字节数。`DeepArchiveObjectOverhead` – 对于每个归档对象，S3 Glacier 为索引及相关元数据添加 32KB 存储。标识和还原对象需要此额外数据。按照 S3 Glacier Deep Archive 费率对此附加存储收费。`DeepArchiveS3ObjectOverhead` – 对于归档到 S3 Glacier Deep Archive 的每个对象，Amazon S3 将 8KB 存储用于对象和其他元数据的名称。将按照 S3 Standard 标准费率对此附加存储收费。`DeepArchiveStagingStorage` - 在 S3 Glacier Deep Archive 存储类中的对象上完成 `CompleteMultipartUpload` 请求之前，用于多分段对象的各个分段的字节数。 |
| `FilterId`    | 此维度将筛选您为桶上的请求指标指定的指标配置。创建指标配置时，需要指定筛选条件 ID（例如，前缀、标签或接入点）。有关详细信息，请参阅[创建指标配置](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metrics-configurations.html){:target="_blank"}。 |

### CloudWatch 中的 S3 Storage Lens 存储统计管理工具维度

有关用于在 CloudWatch 中筛选 S3 Storage Lens 存储统计管理工具指标的维度列表，请参阅[维度](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}。

### CloudWatch 中的 S3 Object Lambda 请求维度

以下维度用于筛选来自对象 Lambda 接入点的数据。

| 维度              | 描述                                                         |
| :---------------- | :----------------------------------------------------------- |
| `AccessPointName` | 正在向其发出请求的接入点的名称。                             |
| `DataSourceARN`   | 对象 Lambda 接入点正从中检索数据的来源。如果请求调用 Lambda 函数，则这指的是 Lambda ARN。否则，这指接入点 ARN。 |

## 对象 {#object}

采集到的AWS S3 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_s3",
  "tags": {
    "name"              : "dataxxxx",
    "RegionId"          : "cn-northwest-1",
    "LocationConstraint": "cn-northwest-1",
    "Name"              : "dataxxxx"
  },
  "fields": {
    "CreationDate": "2022-03-09T06:13:31Z",
    "Grants"      : "{JSON 数据}",
    "message"     : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例名称，作为唯一识别
>
> 提示 2：`fields.message`为 JSON 序列化后字符串
>
> 提示 3: `fields.Grants`为 bucket 访问控制列表
