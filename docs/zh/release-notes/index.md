---
icon: zy/release-notes
---
# 更新日志（2023 年）
---

本文档记录观测云每次上线发布的更新内容说明，包括 DataKit、观测云最佳实践、观测云集成文档和观测云。

## 2023 年 10 月 19 日

### 观测云更新

- 付费计划与账单：计费项【[数据转发](../billing/billing-method/billing-item.md#backup)】统计逻辑变更为 “按照数据转发规则” 统计转发数据量大小。
- 管理
    - [SSO 管理](../management/sso/index.md#corporate)：支持创建多个 SSO 的 IDP 配置，并支持针对单个 IDP 配置进行启用、禁用操作、开启 SAML 映射。
    - 数据权限管理 > [敏感数据脱敏](../management/data-authorization.md#data-mask)：支持基于角色级别配置敏感数据屏蔽规则，配置时可采用正则表达式脱敏，支持针对某个数据类型下的字段做脱敏规则配置，并由此新增脱敏规则预览测试。
- 监控器：新增[外部事件检测](../monitoring/monitor/third-party-event-detection.md)，将第三方系统产生的异常事件或记录通过指定 URL 地址，以 POST 请求方式发送到 HTTP 服务器后生成观测云的事件数据。
- 场景
    - 服务管理 > 资源调用：新增针对对应列表进行数量排序，默认从大到小；
    - 图表链接：新增基于当前选中数据点的开始时间和结束时间做传参，变量分别为 `#{timestamp.start}`、`#{timestamp.end}`；
    - 图表别名：基于图例序列进行配置；
    - 表格图：新增【时序表格图】。
- 指标 > 指标分析：表格图新增【时序模式】。



### 观测云部署版更新

- [新增自定义映射规则配置](../deployment/space.md#others)：启用该配置后，对应工作空间可以自定义映射规则。工作空间的自定义映射规则优先级大于管理后台的映射规则；
- [新增查询数量上限](../deployment/space.md#others)：针对不同用户的工作空间的查询数量有定制化的限制，避免因查询数据量过大导致集群查询性能低，影响产品使用体验；
- 本地账号新增更换密码。

### 集成更新

- [异常事件与 PagerDuty 联动](../integrations/pagerduty.md)：当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。

## 2023 年 9 月 26 日

### 观测云更新

- 场景 > 服务管理：资源调用新增【上下游拓扑】组件，用户可查看当前资源的上下游资源调用关系。
- 日志 > 数据转发：数据转发规则查询支持 RUM、APM 数据。

## 2023 年 9 月 21 日

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230921.jpg" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230921.mp4" type="video/mp4">
</video>

### 观测云更新

- 日志：
    - 数据转发：新增外部存储转发规则数据查询；支持启用/禁用转发规则；
    - 绑定索引：日志易新增标签绑定，从而实现更细颗粒度的数据范围查询授权能力。
- 基础设施 > [自定义](../infrastructure/custom/index.md)：
    - 【默认属性】这一概念更改为【必有属性】：上报的数据中必须包含该属性字段，否则将会上报失败；
    - 支持将自定义对象添加至二级菜单，便于查看。
    - 自定义查看器新增快捷筛选。
- 场景：
    - [定时报告](../scene/report.md)：新增【钉钉】【企业微信】【飞书】三种通知方式；
    - 图表：【时序图、饼图、柱状图、直方图、散点图、气泡图、表格图、矩形树图、漏斗图、排行榜、地图、蜂窝图】新增数据格式，可以定义【小数位数】以及【千分位分隔符】。
- 监控 > [通知对象管理](../monitoring/notify-object.md)：邮件组类型下架，已创建的不受影响。
- 快照：[分享快照](../getting-started/function-details/snapshot.md#share)：新增 IP 白名单访问限制。
- [异常追踪](../exception/issue.md#level)：【等级】支持自定义创建；支持启用/禁用默认等级。
- **集成 > 扩展**：DataFlux Func 托管版和 RUM Headless 现支持海外站点：俄勒冈，法兰克福，新加坡。


### 集成更新

华为云：

- [Huawei CCE](../integrations/huawei_cce.md)：观测云支持对 CCE 中各类资源的运行状态和服务能力进行监测，包括 Containers、Pods、Services、Deployments、Clusters、Nodes、Replica Sets、Jobs、Cron Jobs 等。您可以在 Kubernetes 中通过 DaemonSet 方式安装 `DataKit`，进而完成对 Kubernetes 资源的数据采集。最终，在观测云中实时监测 Kubernetes 各类资源的运行情况。

- [Huawei CSS(Elasticsearch)](../integrations/huawei_css_es.md)：华为云搜索服务 CSS for Elasticsearch 的核心性能指标包括查询延迟、索引速度、搜索速度、磁盘使用率和 CPU 使用率，这些都是评估和优化 Elasticsearch 性能的关键指标。

- [Huawei SYS.AS](../integrations/huawei_SYS.AS.md)：华为 SYS.AS 的核心性能指标包括 CPU 利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。

- [Huawei ASM](../integrations/huawei_asm.md)：华为云的 ASM 的链路追踪数据输出到观测云，进行查看、分析。

AWS：

- [AWS CloudFront](../integrations/aws_cloudfront.md)：AWS CloudFront 的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。

- [AWS MediaConvert](../integrations/aws_mediaconvert.md)：AWS MediaConvert 包括数据传输、视频报错、作业数、填充等。

- [AWS Aurora Serverless V2](../integrations/aws_aurora_serverless_v2.md)：AWS Aurora Serverless V2，包括连接数、IOPS、队列、读写延迟、网络吞吐量等。

- [AWS Redshift](../integrations/aws_redshift.md)：AWS Redshift 的核心性能指标包括查询性能、磁盘空间使用率、CPU 利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。

- [AWS Simple Queue Service](../integrations/aws_sqs.md)：AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。

- [AWS Timestream](../integrations/aws_timestream.md)：AWS Timestream 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量以及存储在磁存储器中的数据量等。

- [AWS Neptune Cluster](../integrations/aws_neptune_cluster.md)：AWS Neptune Cluster 的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了 Neptune Cluster函数的响应速度、可扩展性和资源利用情况。


## 2023 年 9 月 7 日

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230907.jpeg" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230907.mp4" type="video/mp4">
</video>


### 观测云更新

- 场景 > 仪表板/查看器：新增全局[跨工作空间查询](../scene/dashboard.md#cross-workspace)配置。  
- 场景 > 图表查询：时间控件范围小于等于【最近 15 分钟】，自动对齐时间间隔新增 “1 秒”显示。
- 场景 > [服务管理](../scene/service-manag.md)：
    - 服务清单新增绑定多个内置视图到分析看板；新增关联、团队信息；
    - 新增资源调用分析看板；
    - 支持保存快照。
- 日志 > 备份日志：
    - 正式更改为[数据转发](../logs/backup.md)；
    - 新增链路、用户访问数据源；
    - 原备份日志计费项名称更改为数据转发计费项。  
- 日志 > 查看器：新增新建监控器入口；支持针对查看器详情页做快照保存。
- 管理：
    - [全局标签](../management/global-label.md)：新增全局标签功能，对标签进行统一管理；
    - [字段管理](../management/field-management.md)：新增别名、设置显示列；
    - [空间管理](../management/space-management.md)：功能整合和页面优化；
    - 成员管理：原成员组的定义正式更改为团队；
    - 敏感数据扫描：新增扫描规则数量统计；新增跳转链接。
- 监控：
    - 可用性数据检测：新增拨测指标，可以基于【指标】维度进行检测；
    - 突变、离群、区间检测：支持选择所有数据源。 

### 集成更新

阿里云：

- [aliyun_analyticdb_postgresql](../integrations/aliyun_analyticdb_postgresql.md)：阿里云 AnalyticDB PostgreSQL 指标展示，包括 CPU、内存、磁盘、协调节点、实例查询等。  
- [aliyun_clickhouse_community](../integrations/aliyun_clickhouse_community.md)：阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。  
- [aliyun_kafka](../integrations/aliyun_kafka.md)：阿里云 `KafKa` 包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。  
- [aliyun_lindorm](../integrations/aliyun_lindorm.md)：包括高吞吐量、低延迟的数据读写能力，支持高并发的事务处理，以及强一致性和高可靠性的数据存储和查询服务。  
- [aliyun_polardb_1.0](../integrations/aliyun_polardb_1.0.md)：阿里云 PolarDB 分布式 1.0 展示指标包括CPU利用率、内存利用率、网络带宽和磁盘 IOPS。  
- [aliyun_polardb_2.0](../integrations/aliyun_polardb_2.0.md)：阿里云 PolarDB 分布式 2.0 展示计算层和存储节点的指标，包括 CPU 利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。  
- [aliyun_rds_postgresql](../integrations/aliyun_rds_postgresql.md)：阿里云 RDS PostgreSQL 指标展示，包括 CPU 使用率、内存使用率等。  
- [aliyun_rocketmq5](../integrations/aliyun_rocketmq5.md)：阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。  

AWS：

- [aws_dynamodb_DAX](../integrations/aws_dynamodb_DAX.md)：AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。  
- [aws_memorydb](../integrations/aws_memorydb.md)：AWS MemoryDB 的核心性能指标包括低延迟的内存读写能力、高并发的事务处理能力，以及可线性扩展的存储容量和吞吐量。

华为云：

- [huawei_functiongraph](../integrations/huawei_FunctionGraph.md)：HUAWEI FunctionGraph 的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了 FunctionGraph 函数运行情况。  
- [huawei_kafka](../integrations/huawei_kafka.md)：包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。  
- [huaweiyun_SYS_DDMS](../integrations/huaweiyun_SYS_DDMS.md)：'华为云 SYS.DDMS 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 DDMS 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。  

腾讯云：

- [tencent_keewidb](../integrations/tencent_keewidb.md)：腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等。    
- [tencent_mariadb](../integrations/tencent_mariadb.md)：包括高性能的读写能力、低延迟的查询响应时间，以及支持高并发的事务处理和扩展性能。    
- [tencent_memcached](../integrations/tencent_memcached.md)：包括高速的内存读写能力、低延迟的数据访问时间，以及高并发的访问处理能力。    
- [tencent_tdsql_c_mysql](../integrations/tencent_tdsql_c_mysql.md)：包括高吞吐量的读写能力、低延迟的查询响应时间，以及支持高并发的事务处理和可扩展性能。    

其他：

- [openai](../integrations/openai.md)：OpenAI的展示指标包括请求总数，响应时间，请求数量，请求错误数和消耗token数。  
- [monitor_jira](../integrations/monitor_jira.md)：当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 Jira 中创建事件，这样我们就可以在 Jira 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 Jira 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。  




## 2023 年 8 月 29 日

### 观测云更新

- 场景 > SLO 图表：新增故障时间显示。
- 部署版：管理后台[映射规则](../deployment/setting.md#mapping)新增仅针对新加入成员应用适配规则，用户启用选择该选项时，映射规则适配仅针对首次加入成员生效。

## 2023 年 8 月 24 日

### 观测云更新

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230824.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230824.mp4" type="video/mp4">
</video>

- [计费项](../billing/billing-method/index.md)：
    - 备份日志：新增 OSS、OBS、AWS S3、Kafka 四种存档类型计费项，基于用户选择的对应存档类型统计汇总转发的流量大小，并根据数据对应出账；
    - 应用性能 Trace、用户访问 PV 新增 30天/60天的数据存储策略。
- 监控：
    - [静默规则](../monitoring/silent-management.md)：支持基于不同维度配置告警沉默。
    - [监控器](../monitoring/monitor/index.md#list)：支持为监控器添加标签，根据标签过滤列表；监控器列表增加快捷筛选列，并对列表进行了一些优化；
    - SLO：新增**故障时间**显示列。
- 日志 > 备份日志：新增 [Kafka 消息队列](../logs/backup.md#kafka)外部存储。
- 查看器/仪表板：新增[自动刷新功能](../getting-started/function-details/explorer-search.md#refresh)。
- 查看器详情页：新增[绑定内置视图](../infrastructure/host.md#view)入口。

### 集成更新

- [阿里云 RDS MariaDB](../integrations/aliyun_rds_mariadb.md)：阿里云 RDS MariaDB 的展示指标包括响应时间、并发连接数、QPS 和 TPS 等。
- [阿里云 RocketMQ4](../integrations/aliyun_rocketmq4.md)：阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。
- [阿里云 Tair 社区版](../integrations/aliyun_tair.md)：阿里云 Tair 社区版指标展示包括 CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。
- [AWS DynamoDB](../integrations/aws_dynamodb.md)：AWS DynamoDB 的展示指标包括吞吐量容量单位（Capacity Units）、延迟、并发连接数和读写吞吐量，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。
- [AWS EventBridge](../integrations/aws_eventbridge.md)：AWS EventBridge 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 EventBridge 在处理大规模事件流和实时数据传递时的性能表现和可靠性。
- [AWS Lambda](../integrations/aws_lambda.md)：AWS Lambda 的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了 Lambda 函数的响应速度、可扩展性和资源利用情况。
- [HUAWEI SYS.AS](../integrations/huawei_SYS.AS.md)：HUAWEI SYS.AS 的展示指标包括响应时间、并发连接数、吞吐量和可靠性，这些指标反映了 SYS.AS 在处理应用程序请求和数据交互时的性能表现和稳定性。
- [HUAWEI SYS.CBR](../integrations/huawei_SYS.CBR.md)：HUAWEI SYS.CBR 的展示指标包括带宽利用率、延迟、丢包率和网络吞吐量，这些指标反映了CBR在网络传输和带宽管理方面的性能表现和质量保证。
- [华为云 GaussDB-Cassandra](../integrations/huawei_gaussdb_cassandra.md)：华为云 GaussDB-Cassandra 的展示指标包括读写吞吐量、延迟、数据一致性和可扩展性，这些指标反映了 GaussDB-Cassandra 在处理大规模分布式数据存储和访问时的性能表现和可靠性。
- [华为云 GaussDB for MySQL](../integrations/huawei_gaussdb_for_mysql.md)：华为云 GaussDB for MySQL 的展示指标包括响应时间、并发连接数、读写吞吐量和可扩展性，这些指标反映了 GaussDB for MySQL 在处理大规模关系型数据库操作时的性能表现和可靠性。
- [华为云 GaussDB-Influx](../integrations/huawei_gaussdb_influx.md)：华为云 GaussDB-Influx 的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了 GaussDB-Influx 在处理大规模时序数据存储和查询时的性能表现和可靠性。
- [华为云 GaussDB-Redis](../integrations/huawei_gaussdb_redis.md)：华为云 GaussDB-Redis 的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了 GaussDB-Redis 在处理高并发数据存储和缓存时的性能表现和可靠性。
- [华为云 GaussDB SYS.GAUSSDBV5](../integrations/huawei_gaussdb_sys.gaussdbv5.md)：华为云 GaussDB `SYS.GAUSSDBV5`，提供 CPU、内存、磁盘、死锁、`SQL` 响应时间指标等数据。
- [华为云 MongoDB](../integrations/huawei_mongodb.md)：华为云 MongoDB 的展示指标包括读写吞吐量、延迟、并发连接数和数据可靠性，这些指标反映了 MongoDB 在处理大规模文档存储和查询时的性能表现和可扩展性。
- [华为云 RDS PostgreSQL](../integrations/huawei_rds_postgresql.md)：华为云 RDS PostgreSQL 的展示指标包括查询性能、事务吞吐量、并发连接数和数据可靠性，这些指标反映了 RDS PostgreSQL 在处理大规模关系型数据存储和事务处理时的性能表现和可靠性。
- 腾讯云 CKafka：腾讯云 CKafka 的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 CKafka 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。
- [Zadigx](../integrations/zadigx.md)：Zadigx 展示包括概览、自动化构建、自动化部署、自动化测试等。
- [飞书与异常追踪联动](../integrations/feishu_im.md)：为方便更加及时可方便的获取异常追踪中的新 Issue，可以通过在内部群中创建一个飞书、钉钉或者企业微信的机器人来接受异常追踪中的新 Issue 或新回复的提醒，帮助及时处理 Issue；也可以通过 @机器人的这种方式来快速进行 Issue 回复，提高我们的异常处理效率。

## 2023 年 8 月 17 日

### 观测云更新

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230817.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230817.mp4" type="video/mp4">
</video>

- 管理：新增[敏感数据扫描](../management/data-scanner.md)功能：通过为数据创建脱敏规则的方式，实现信息屏蔽。
- 新增计费项：[敏感数据扫描流量](../billing/billing-method/index.md#scanned-data)：基于扫描规则统计扫描到的敏感数据原始流量大小（每 GB / 天）。
- 付费计划与账单：消费分析板块因作改造优化处理，暂时下架。

## 2023 年 8 月 10 日

### 观测云更新

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230810.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230810.mp4" type="video/mp4">
</video>


- 新增计费项：
    - [定时报告](../billing/billing-method/index.md#report)：按工作空间内定时报告单日发送的次数出账计费；
- 场景：
    - 新增 **[服务管理](../scene/service-manag.md)**：服务管理是一个用于访问所有服务关键信息的集中入口，用户可查看当前工作空间内不同服务的性能和业务数据及所有的关联分析等信息，快速定位并解决服务的相关问题。
    - 图表均支持 PromQL 查询和表达式查询。
- 日志：支持在日志详情页直接查看[上下文日志](../logs/explorer.md#up-down)；可选择上下文检索范围。
- 查看器：打开某条数据详情页，支持一键[导出](../getting-started/function-details/explorer-search.md#export)当前数据为 JSON 文件。
- 应用性能监测 > 服务 > [调用拓扑](../application-performance-monitoring/service-catalog.md#map)：新增当前服务的上下游调用关系表格，展示服务单向关系的请求数、平均响应时间和错误数。
- 监控器 > 阈值检测：检测指标新增**转换为 PromQL 查询**。
- 基础设施 > 容器：Pods、Services、Deployments、Nodes、Replica Sets、Cron Jobs、Daemonset 详情页新增 **Kubernets 事件**组件。

## 2023 年 7 月 27 日

### 观测云更新

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230727.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230727.mp4" type="video/mp4">
</video>

- **场景 > 仪表板**：新增[定时报告功能](../scene/report.md)，支持用户创建基于某仪表板的报告，并可以配置定时邮件发送。
- 导航栏新增 **[邀请成员](../management/invite-member.md#navigation)** 入口，可通过该入口快速邀请成员。在管理页面，新增**邀请审批**按钮。该按钮开启情况下，向成员发送邀请后，须移至邀请记录审批管理成员加入申请。
- **日志 > 备份日志**有以下调整：
    - 观测云默认存档类型下线：
        - 新创建的备份规则中将不再支持【观测云】默认选项；
        - 历史已创建的备份规则依然生效。
    - 新增支持备份到外部存储[阿里云 OSS](../logs/backup.md#oss)。
- **监控 > 新建**：支持将监控器保存为[自定义模板库](../monitoring/monitor/custom-template.md)，以便后续用户快速创建同类型监控器检测。
- **监控 > 新建监控器 > 自定义新建**：除【突变检测】【区间检测】【离群检测】以外，所有检测规则的检测频率新增【最近 12 小时】【最新 24 小时】选项。
- **[异常追踪](../exception/issue.md#manual)**：新建 Issue 页面新增**投递频道**配置入口，支持多选；等级新增**未知**选项，默认选中该选项。
- 为满足用户数据合规性要求，[快照](../getting-started/function-details/snapshot.md#sensitive)支持针对字段通过正则语法对某些内容脱敏。
- **场景 >日志流图**新增 Copy as cURL、导出为 CSV 文件功能。
- **用户访问监测 > 查看器 > Error**：新增 **[聚类分析](../real-user-monitoring/explorer/error.md#analysis)** 功能，方便查看发生频次较高的错误。
- 新增数据上限提示：即日志、链路等数据量到达今日上限，将停止数据接收，如需调整，请联系客户经理。

<!--
- **付费计划与账单 > [消费分析](../billing/commercial.md#consume)**：仅支持统计分析 6 月之后的消费数据。

- 支持备份日志导出至 [Kafka 消息队列](../logs/backup.md#kafka)。
-->
## 2023 年 7 月 11 日

### 观测云更新

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/20230711.jpeg" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/20230711.mp4" type="video/mp4">
</video>


- **集成**升级：点击任意集成方案，即可在同一页面上了解从配置接入、数据采集到数据应用的全链路使用方案。
- **[监控器 > 模板](../monitoring/monitor/template.md#create)** 功能优化：支持基于单个检测规则创建或批量创建；支持基于检测库进行筛选。
- **应用性能监测 > 链路**：**Span 列表**页面新增[瀑布图模式](../application-performance-monitoring/explorer.md#waterfall)，帮助用户以更直观的视角分析 Span 数据信息；**[服务调用关系](../application-performance-monitoring/explorer.md#call)** 从服务（service）变更为服务资源（service / resource）级别，通过下钻到接口级别来更好地分析对应的性能及调用问题，从而通过接口级别的调用帮助用户更快发现问题点。
- **[图表 > 概览图](../scene/visual-chart/overview-chart.md)**：新增千位分隔符；**单位 > 数值**中，“默认”改为“万进制”；**值映射**中新增空值映射。
- **[图表 > 矩形树图](../scene/visual-chart/treemap.md#ui)**：新增显示值选项，选中可在图中直接显示查询结果值。
- **[图表 > 添加链接](../scene/visual-chart/chart-link.md#description)**：新增 `query` 参数，删除 `tags`、`search` 两个参数。
- **应用性能监测 > 服务**列表支持导出。

### 智能巡检更新

功能优化：

- 应用性能巡检：新增默认检测阈值更改入口，现在在开启巡检时可以同步需改需要检测服务的触发值。
- RUM 性能巡检：对页面详情模块中根因展示逻辑进行优化，优化后，根因定位更加准确。
- 工作空间资产巡检：新增默认配置(7 天)，现在开启巡检不需要参数也可以运行。

新增脚本：

- [云消息队列 RocketMQ4.0](https://func.guance.com/doc/script-market-guance-aliyun-rocketmq4/)
- [华为云-CSS](https://func.guance.com/doc/script-market-guance-huaweicloud-css/)
- [华为云-RocketMQ](https://func.guance.com/doc/script-market-guance-huaweicloud-rocketmq/)
- [华为云-RabbitMQ](https://func.guance.com/doc/script-market-guance-huaweicloud-rabbitmq/)
- 华为云-WAF-事件列表
- 华为云-WAF-事件概览

## 2023 年 6 月 29 日

### 观测云更新

本次更新简化了注册流程：

- [国际站观测云产品服务](https://www.guance.one/)正式上线，用户可前往 AWS 海外云市场购买。
- [国际站观测云](https://docs.guance.com/en/billing/inter-commercial/)产品采用[以美元为单位的计价体系](../billing/billing-method/index.md#item)。中国站原俄勒冈站点注册的工作空间数据将按照调整后的价格计费。

- 观测云**企业账号**这一概念正式更改为**费用中心账号**；

其他更新：

- 快照[权限](../management/role-list.md)：只读成员支持创建和删除**仅自己可见**的快照。

## 2023 年 6 月 20 日

### 观测云更新

- RUM (Real User Monitoring) 采集器用于收集网页端或移动端上报的用户访问监测数据。现提供 [RUM Headless一键开通服务](../dataflux-func/headless.md)，实现自动化安装部署在观测云的云主机中，自动完成 DataKit 安装，RUM 采集器部署。只需要手动接入应用即可。
- **查看器**：[优化筛选、搜索的交互转化](../getting-started/function-details/explorer-search.md#search)等逻辑，让用户真正做到所见即所得，且能够在 UI 和手写模式自由切换。另：日志查看器支持的 DQL 手写模式新版本上线后将会做下线处理。
- **日志 > 备份日志**：新增外部存储类型选择，支持[写入 S3(AWS) 对象存储](../logs/backup.md#aws)、支持[华为云 OBS 数据写入](../logs/backup.md#obs)。
- **日志 > 索引**：新增[日志易数据绑定配置入口](../logs/multi-index.md#rizhiyi)。
- 仪表板/内置视图支持[根因分析和下钻分析](../scene/visual-chart/index.md#analysis)。
- **管理 > 角色管理**：支持[克隆已有用户角色](../management/role-management.md#operations)减少操作步骤，快速增减权限并创建角色。
- **基础设施 > 容器**：新增 [Daemonset 对象数据](../infrastructure/contrainer.md#daemonsets)显示，可拖拽改变对象分类显示顺序。
- **基础设施 > 容器**：Deployments、Pods 支持直接关联 kubernetes 事件日志，在详情页可直接查看具体日志信息。
- 新增[异常追踪 OpenAPI 接口](../open-api/channel/add)。
- **管理 > 成员管理**列表、**监控 > 通知对象管理 > 邮件组**、**异常追踪** > 查看成员、所有选择通知对象处均支持按成员昵称进行检索。
- 工单状态更新或有新回复时，通过界面或者邮件提醒客户关注。
- 文本输入框输入不合法的字符或长度限制提示优化。

### 智能巡检更新

- 新增巡检

    - [AWS Cloudtrail 异常事件巡检](../monitoring/bot-obs/aws_ak_errorlog.md)：AWS CloudTrail 是一项用于跟踪、日志记录和监控AWS账户活动的服务。它记录了 AWS 账户中进行的操作，包括管理控制台访问、API 调用、资源变更等，我们可以通过监控 CloudTrail 的错误事件，及时发现潜在的安全问题。例如，非授权的 API 调用、访问被拒绝的资源、异常的身份验证尝试等。这有助于保护您的 AWS 账户和资源免受未经授权的访问和恶意活动；还可以了解到系统中发生的故障类型、频率和影响范围。这有助于您快速识别问题并采取适当的纠正措施，以减少服务中断时间和业务影响。

- 新增脚本

    - [观测云集成（阿里云-RDS错误日志）](https://func.guance.com/doc/script-market-guance-aliyun-rds-errorlog/)：收集阿里云的 RDS 错误日志，用于 RDS 的错误信息诊断；
    - [filebeats 数据采集器](https://func.guance.com/doc/script-market-guance-middleware-filebeats/)：收集 FileBeats 性能数据用于观测 FileBeats 性能、延迟等场景；
    - [logstash 数据采集器](https://func.guance.com/doc/script-market-guance-middleware-logstash/)：收集 Logstash 性能数据用于观测 Logstash 性能、延迟等场景。


## 2023 年 6 月 6 日

### 观测云更新

- 为进一步满足用户数据查看需求，商业版付费计划与账单新增[设置高消费预警功能](../billing/commercial.md#account)，新增[消费分析列表](../billing/commercial.md#consume)，支持查看各类支出消费统计。
- 创建工作空间时新增[菜单风格选择](../management/index.md#create)，支持选择不同的工作空间风格属性。
- 优化日志数据访问[权限相关规则](../logs/logdata-access.md#config)适配，进一步明确多角色数据查询权限及权限控制对应关系。
- 事件详情页下的基础属性下的[检测维度](../events/event-details.md#attribute)新增关联查询，支持查看筛选当前检测维度下全部字段值的关联数据。
- 告警策略管理支持[不同级别告警到不同的通知对象](../monitoring/alert-setting.md#create)。
- [成员管理](../management/member-management.md)新增添加昵称备注功能，规范工作空间内的成员用户名，支持通过昵称备注搜索成员。
- 仪表板、查看器、监控、成员管理、分享管理等页面列表新增批量操作功能。
- 应用性能监测服务支持[修改颜色，支持表头排序调整](../application-performance-monitoring/service.md#operations)。
- 日志、应用性能监测 > 错误追踪查看器聚类分析支持对文档数量排序，默认倒序。
- 支持保存登录选择语言版本到浏览器本地，再次登录自动显示上一次登录选择语言版本。
- 生成指标频率选项调整，支持选择 1 分钟、5 分钟、15 分钟。


### 观测云部署版更新

- 管理后台新增[密码安全策略](../deployment/setting.md#security)：新增密码 8 位长度限制及密码有效期功能。

### 智能巡检更新

- 新增巡检

    - [工作空间资产巡检](../monitoring/bot-obs/workspace-weekly-report.md)：针对于服务巡检应当确保服务正常运行，及时发现故障或异常，降低业务损失。其次，巡检有助于提高服务可用性和稳定性，发现并解决潜在问题。还可以巡检提高运维效率，加速问题诊断和解决，优化资源配置。保障业务安全。通过对主机、K8s、容器等服务的定期巡检，运维人员可以确保这些服务能够高效、稳定地支持业务，为企业提供持续可靠的运行环境。

- 新增脚本

    - Gitlab 研发效能分析：根据 Gitlab 的代码提交频率和每次代码量，分团队、个人、时间维度展示团队的研发效能。

## 2023 年 6 月 1 日

### 观测云更新

DataFlux Func 是观测云的扩展编程平台，可用于同步云平台数据、函数开发、管理和执行。现支持 DataFlux Func 托管版在国内所有站点[一键开通](../dataflux-func/index.md)服务，开通完成后即可在云主机中自动化部署 Func，在工作空间的**集成**可以快速登录对应 Func 平台。

## 2023 年 5 月 22 日

### 观测云更新

- RUM 应用配置新增[自定义类型](../real-user-monitoring/index.md#create)和关联视图查看分析
- DQL 函数支持[正则聚合](../dql/funcs.md#regular-1)数据统计显示返回，新增字符串正则表达式解析函数，根据正则表达式提取字段、判断字段中是否有符合正则的子串
- 新增 PromQL 语法查询入口，支持通过 [PromQL 查询](../dql/promql.md)时序数据
- [show_tag_value() 函数](../dql/funcs.md#show)支持查询对应指标字段的关联标签
- [小程序 SDK](../real-user-monitoring/miniapp/app-access.md) 支持采集启动参数相关的信息；[新增自定义添加 Error](../real-user-monitoring/miniapp/custom-sdk/add-error.md)。
- Status Page 支持[订阅故障通知](../management/status-page.md)
- 新增字段管理功能，在[监控器、图表查询、查看器](../management/field-management.md#case)等位置若选择了相关字段则显示对应的描述和单位信息
- [指标分析](../metrics/explorer.md)新增表格功能，支持下载
- [工单状态](../management/work-order-management.md#state)调整
- 新增异常追踪引导页，频道新增[时间范围筛选](../exception/channel.md#time)
- 备份日志优化：
    - **新增备份**规则入口移至[备份日志](../logs/backup.md) > 备份管理；
    - 新增全部备份逻辑：不添加筛选即表示保存全部日志数据
### 观测云部署版更新

- 管理后台新增[审计事件](../deployment/setting.md#audit)记录

### 智能巡检更新

- 新增巡检

    - 云上闲置资源巡检：云计算作为一种全新的IT服务方式发展迅猛，为企业和个人提供了方便、快捷、弹性的IT基础设施和应用服务，并带来极高的效率和经济性。然而，随着云资源逐渐成为企业数据中心的主要组成部分之后，云上资源的巨大浪费问题也愈加显著。尤其是在企业范围内，因为需求波动和部门之间的隔离等原因，导致部分云上资源无法得到充分利用，形成了大量的闲置资源。这种情况会使企业的云服务成本直线上升、资源效率下降，还有可能降低安全和性能水平。为了更好地管理和优化云上闲置资源，以提升云计算的使用效益和资源利用率，进行云上闲置资源巡检是非常有必要的。通过巡检，可以发现当前云服务中的不必要资源，及时进行处理，避免长时间不必要的资源使用而带来的费用开销、数据泄露、性能不佳等问题。

    - 主机重启巡检：主机异常重启监控是现代互联网系统运维中的一个重要环节。一方面，计算机系统的稳定性和可靠性对于业务的平稳运行和用户的体验至关重要。当主机发生异常重启等问题时，会导致系统崩溃、服务中断和数据丢失等风险，进而影响业务运营和用户满意度。另一方面，在云计算和虚拟化环境中，主机的数量和规模不断增多，系统复杂度也在不断提高，出现问题的概率也在不断增加，这就需要系统管理员使用相关的系统监控工具进行实时监控，并及时发现解决异常重启等问题。因此，合理地实现主机异常重启监控，能够帮助企业快速诊断问题、降低业务风险、提升运维效率和用户体验。

- 功能优化

    - 闲置主机巡检：新增对云主机类型关联添加费用相关信息。

更多智能巡检更新可参考 [智能巡检版本历史](../monitoring/bot-obs/index.md)。

## 2023 年 4 月 27 日

### 观测云更新

- 概览图支持同时展示多个同期对比维度（日同比/周同比/月同比/...）
- 标准成员新增快照分享功能
- DQL 查询更名为[查询工具](../dql/query.md)，新增执行按钮
- 主机列表显示优化，处于告警沉默的主机新增静默提示
- SLO 告警通知内容优化，新增工作空间和站点的信息
- 优化工作空间 ID 和 Token 的显示逻辑，默认隐藏，支持查看和复制
- 体验版工作空间新增 Session Replay、Profile 的使用限制

## 2023 年 4 月 23 日

### 观测云计费更新：

- 观测云自研时序数据库 GuanceDB 全新上线，时序数据存储及计费将会做如下调整：
    - 基础设施（DataKit）计费项下线，原 “DataKit + 时间线”、“仅时间线” 两种计费模式按照仅 GuanceDB 时间线作为出账逻辑使用；
    - GuanceDB 时间线：统计当天活跃的时间线数量计费，单价低至 ￥0.6 / 每千条时间线。

- 用户访问监测 “会话重放” 正式启动付费，按照实际采集会话重放数据的 session 数量计费，￥10 / 每千个 Session。

更多详情可参考文档[计费方式](../billing/billing-method/index.md)。

### 观测云功能更新：

- [GuanceDB 时序数据库](../billing/billing-method/gauncedb.md)全新上线
- [异常追踪](../exception/index.md) 新功能上线
- [跨站点工作空间授权](../management/data-authorization.md#data-authorization) 功能上线
- SLS 新增[第三方授权](../billing/commercial-aliyun-sls.md#method)开通
- 绑定索引配置页面优化，支持自定义添加映射字段配置
- 图表优化
    - [命令面板](../scene/visual-chart/command-panel.md) 新增本地 Func 的自定义函数选择
    - 时序图新增 [高级函数](../dql/advanced-funcs/index.md)，支持本地 Func 根据 DQL 查询结果二次处理后返回显示
- 工作空间新增[时区配置](../management/account-management.md#workspace)，用户可自定义配置当前工作空间查询时间的时区
- 集成 > DataKit 页面引导优化
- 查看器柱状分布图新增统计时间区间显示
- 导航菜单支持右键选择新页打开
- 黑名单重名导入问题修复

### 观测云部署版更新

- 新增[账号登录映射规则配置](../deployment/setting.md#mapping)，根据不同的映射规则动态分配成员加入的工作空间及对应的角色。


### DataKit 更新

**新加功能：**

- 新增 [Pinpoint](../datakit/pinpoint.md) API 接入

**功能优化：**

- 优化 Windows 安装脚本和升级脚本输出方式，便于在终端直接黏贴复制
- 优化 Datakit 自身文档构建流程
- 优化 OpenTelemetry 字段处理
- [Prom](../datakit/prom.md) 采集器支持采集 `info` 类型的 label 并将其追加到所有关联指标上（默认开启）
- 在 [system 采集器](../datakit/system.md)中，新增 CPU 和内存占用百分比指标
- Datakit 在发送的数据中，增加数据点数标记（`X-Points`），便于中心相关指标构建
    - 另外优化了 Datakit HTTP 的 `User-Agent` 标记，改为 `datakit-<os>-<arch>/<version>` 这种形态
- [KafkaMQ](../datakit/kafkamq.md)：
    - 支持处理 Jaeger 数据
    - 优化 SkyWalking 数据的处理流程
    - 新增第三方 RUM 接入功能
- [SkyWalking](../datakit/skywalking.md) 新增 HTTP 接入功能
- 增加如下集成测试：
    - [Apache](../datakit/apache.md)
    - [JVM](../datakit/jvm.md)
    - [Memcached](../datakit/memcached.md)
    - [MongoDB](../datakit/mongodb.md)
    - [RabbitMQ](../datakit/rabbitmq.md)
    - [Statsd](../datakit/statsd.md)
    - [Tomcat](../datakit/tomcat.md)
    - [etcd](../datakit/etcd.md)

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md)。

## 2023 年 4 月 13 日

### 智能巡检更新

- 脚本市场智能巡检脚本集:
    - 优化开启步骤，无须新创建脚本，无须新建调度，从官方脚本市场点击安装后，自动完成创建与调度，配置参数后即可开启；
    - 更新磁盘使用率巡检：对磁盘使用率巡检趋势判断算法优化，为用户提供更精准的问题定位。

- 脚本市场云同步脚本集:
    - 优化开启步骤，无须新创建脚本，无须新建调度，从官方脚本市场点击安装后，自动完成创建与调度，配置参数后即可开启；
    - 新增 AWS 同步多种认证方式；
    - 新增 AWS Cloudwatch Logs 同步。

更多智能巡检更新可参考 [智能巡检版本历史](../monitoring/bot-obs/index.md)。

## 2023 年 4 月 11 日

### 观测云更新

#### 新增华为云云商店开通流程

- 观测云新增华为云云商店一键开通观测云的流程，在华为云云商店订阅观测云商品后，可直接开通使用观测云。更多详情可参考文档[华为云云商店开通观测云商业版](../billing/commercial-huaweiyun.md)。

## 2023 年 4 月 6 号

### 观测云更新

- 日志新增 3 天数据保存策略和定价，计费相关请参考文档 [计费方式](../billing/billing-method/index.md)。
- 日志新增 [数据访问](../logs/logdata-access.md) 权限控制，支持将某个范围内的日志数据查看权限授予给相关角色
- [角色权限清单](../management/role-list.md) 新增各功能模块数据查询权限，支持自定义角色配置对应模块的数据查询权限入口
- 标准成员新增 “快照管理” 权限，支持快照增删操作
- [快照分享](../logs/logdata-access.md#snapshot) 支持搜索功能。（日志 DQL 查询模式下不支持调整搜索范围）
- 支持本地 Func 通过 websocket 协议创建 [自定义的通知对象](../monitoring/notify-object.md#custom)，实现外部通知渠道接收告警通知
- 查看器新增 [copy as cURL](../logs/explorer.md#copy-as-curl) 数据查询功能
- 仪表板图表配置交互优化
    - [概览图](../scene/visual-chart/overview-chart.md) 新增数值单位选项配置，支持选择中国科学记数法进位（default）和短级差制（short scale）
    - 新增 [视图变量](../scene/view-variable.md) 是否应用到图表效果显示
    - 图表存在分组条件时，支持将某个分组条件值反向应用到视图变量实现联动筛选
    - 图表存在分组条件时，选中某个分组条件对应时间线或数据点时支持其他图表中相同分组联动高亮显示
    - 图表拖拽效果优化
- [账号无操作会话过期时间](../management/account-management.md#login-hold-time) 默认调整为 3 小时，此次调整仅针对未编辑过无操作会话过期时间配置的账号，不影响已编辑过的无操作会话过期时间配置的账号。
- [筛选历史](../getting-started/function-details/explorer-search.md#filter-history) 新增搜索条件保存
- 用户访问监测 [应用 SDK 接入](../real-user-monitoring/web/app-access.md) 引导优化
- [生成指标](../logs/generate-metrics.md) 配置优化，支持针对新生成的指标配置单位和描述
- [主机查看器](../infrastructure/host.md#label) 支持多行显示，多行模式下 label 将另起一行显示
- [时序图](../scene/visual-chart/timeseries-chart.md)、[饼图](../scene/visual-chart/pie-chart.md)新增返回显示数量配置

### DataKit 更新

**新加功能**

- 新增伺服服务，用来管理 Datakit 升级
- 新增故障排查功能

**功能优化**

- 优化升级功能，避免 datakit.conf 文件被破坏
- 优化 cgroup 配置，移除 CPU 最小值限制
- 优化 self 采集器，我们能选择是否开启该采集器，同时对其采集性能做了一些优化
- Prom 采集器允许增加 instance tag，以保持跟原生 Prometheus 体系一致
- DCA 增加 Kubernetes 部署方式
- 优化日志采集的磁盘缓存性能
- 优化 Datakit 自身指标体系，暴露更多 Prometheus 指标
- 优化 /v1/write
- 优化安装过程中 token 出错提示
- monitor 支持自动从 datakit.conf 中获取连接地址
- 取消 eBPF 对内核版本的强制检查，尽量支持更多的内核版本
- Kafka 订阅采集支持多行 json 功能
- 优化 IO 模块的配置，新增上传 worker 数配置字段

**兼容调整**

- 本次移除了大部分 Sinker 功能，只保留了 Dataway 上的 Sinker 功能。同时 sinker 的主机安装配置以及 Kubernetes 安装配置都做了调整，其中的配置方式也跟之前不同，请大家升级的时候，注意调整
- 老版本的发送失败磁盘缓存由于性能问题，我们替换了实现方式。新的实现方式，其缓存的二进制格式不再兼容，如果升级的话，老的数据将不被识别。建议先手动删除老的缓存数据（老数据可能会影响新版本磁盘缓存），然后再升级新版本的 Datakit。尽管如此，新版本的磁盘缓存，仍然是一个实验性功能，请谨慎使用
- Datakit 自身指标体系做了更新，原有 DCA 获取到的指标将有一定的缺失，但不影响 DCA 本身功能的运行

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md)。

## 2023 年 3 月 23 号

### 观测云更新


- 帮助文档搜索功能优化

- [备份日志](../logs/backup.md) 新增扩展字段保存逻辑，默认仅备份 message 内容到备份日志，若勾选“同步备份扩展字段”，将备份符合筛选条件的整条日志数据

![](img/5.log_backup_3.png)

- 查看器/仪表板 [时间控件](../getting-started/function-details/explorer-search.md#time) 新增“时区选择”和“全局锁定”功能

![](img/12.time_1.png)

- 监控器优化
    - 支持查看上次的历史配置，支持点击还原到 [历史配置版本](../monitoring/monitor/index.md#recover)
    - 列表和页面新增创建、变更信息显示
    - [突变检测](../monitoring/monitor/mutation-detection.md) 新增对比维度，支持选择跟“昨日”“上一小时”统计指标比对逻辑

- [智能巡检](../monitoring/bot-obs/index.md) 事件新增效果反馈入口
- [快照](../getting-started/function-details/snapshot.md) 分享支持添加“创建人”水印显示
- 注册开通流程优化，云市场开通路径新增站点选择
- [笔记](../scene/note.md) 创建逻辑和添加内容交互调整
- [图表查询](../scene/visual-chart/chart-query.md) 新增 label 反选逻辑
- [链路](../application-performance-monitoring/explorer.md) 详情页 Span 列表显示逻辑调整，按“持续时间”倒序显示
- [成员管理](../management/role-management.md) 触发审核流程后角色修改逻辑调整
- 查看器列宽度保存、日志显示多行等逻辑调整


## 2023 年 3 月 9 号

### 观测云更新

#### 数据存储策略变更优化

取消数据存储策略每天只能修改 1 次的逻辑，支持用户当天内多次调整数据存储策略。

> 注意：数据存储策略除当天内第一次修改会立即生效，其他的修改操作将按照最后一次调整记录次日生效。关于如何变更，可参考文档 [数据存储策略](../billing/billing-method/data-storage.md)。

#### 图表链接配置优化

图表链接配置交互升级，在文本框输入基础上，支持通过参数配置自由组合生成最终图表关联链接 URL。更多详情可参考文档 [自定义链接](../scene/visual-chart/chart-link.md#custom-link)。

![](img/6.link_5.1.png)

#### 新增支持创建重名的仪表板、笔记、自定义查看器

优化仪表板、笔记、自定义查看器导入功能，若发现文件重名时支持自定义选择「跳过」、「仍然创建」、「取消」等操作。涉及导入模块：

- 场景：仪表板、笔记、查看器
- 管理：设置 - 配置迁移

> 注意：若选择「取消」导入后，当次选中的文件均不会做导入操作。更多详情可参考文档 [配置迁移](../management/index.md#export-import)。

![](img/5.input_rename_1.png)

#### DQL 参数生效优先级调整

若您使用手写 DQL 模式查询数据时，DQL 中的时间参数配置将会优先于时间控件的输入范围。涉及功能：

- 仪表板：视图变量默认值查询、图表查询
- 指标分析
- DQL 查询工具

#### 日志 Message 数据展示优化

日志查看列表支持选择显示全部 message 内容。涉及功能：

- 日志查看器
- 各查看器详情页关联日志页面

![](img/7.log_column_4.png)

#### 监控配置页面优化

在配置监控器事件通知时：

- 支持自定义「无数据」事件通知模板
- 事件内容支持添加跳转链接，除官方提供的默认链接，您还可以自定义跳转链接

更多详情可参考文档 [监控器配置](../monitoring/monitor/threshold-detection.md#notification)。

#### SSO 相关优化

- SSO 用户支持修改账户信息和会话保持时间等策略
- SAML 账号映射规则配置优化，兼容 “Email” 多种大小写格式
- 单点登录链接获取逻辑优化，针对已经加入过工作空间的 SSO 用户优先列出已加入的工作空间登录链接

#### 其他功能优化

- 商业版开通流程支持 “[观测云直接开通](../billing/billing-account/enterprise-account.md)”、“[阿里云市场开通](../billing/billing-account/aliyun-account.md)“和“[亚马逊云市场开通](../billing/billing-account/aws-account.md)“三种方式任意选择；
- 查看器左 * 查询功能范围调整，新开通的工作空间不再默认支持左 * 查询，如有需求请联系客户经理；
- SLIMIT 限制调整，时序图查询若存在 `group by` 分组时，默认返回最多 20 条数据；
- 新创建的工作空间新手引导流程优化。

### DataKit 更新

**新加功能**

- Pipeline 支持 key 删除
- Pipeline 增加新的 KV 操作
- Pipeline 增加时间函数
- netstat 支持 IPV6
- diskio 支持 io wait 指标
- 容器采集允许 Docker 和 Containerd 共存
- 整合 Datakit Operator 配置文档

**功能优化**

- 优化 Point Checker
- 优化 Pipeline replace 性能
- 优化 Windows 下 Datakit 安装流程
- 优化 confd 配置处理流程
- 添加 Filebeat 集成测试能力
- 添加 Nginx 集成测试能力
- 重构 OTEL Agent
- 重构 Datakit Monitor 信息

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md)。

## 2023 年 2 月 28 号

### 观测云更新

#### 新增会话重放功能

会话重放是用户体验网站的重建演示，通过捕获单击、鼠标移动和页面滚动等内容，生成视频记录，深入了解用户的操作体验。更多详情可参考文档 [会话重放](../real-user-monitoring/session-replay/index.md)。

#### 优化 AWS 开通流程

观测云优化 AWS 云市场一键开通观测云的流程，在 AWS 云市场订阅观测云商品后，可直接开通使用观测云。更多详情可参考文档 [在 AWS 开通观测云](../billing/commercial-aws.md)。

## 2023 年 2 月 23 号

### 观测云更新

#### 用户访问监测优化

##### 新增用户访问监测自动化追踪

用户访问监测新增自动化追踪，通过“浏览器插件”的实现方式，使用浏览器记录用户访问行为，创建无代码的端到端测试。更多详情可参考文档 [自动化追踪](../real-user-monitoring/self-tracking.md#auto-tracking)。

##### 用户访问监测应用列表、查看器、分析看板布局整体调整

- 用户访问监测应用列表显示布局调整，支持在应用列表跳转查看当前应用的“分析看板”和“查看器”内容详情。

![](img/11.rum_1.png)

- 用户访问监测“查看器”支持查看所有应用的用户访问数据，您可以通过筛选 “应用ID” 来查看和分析不同应用的数据。

![](img/11.rum_2.png)

- 用户访问监测“分析看板“支持切换查看 Web 端、移动端、小程序的场景分析视图。

![](img/11.rum_3.png)

##### 新增 CDN 质量分析

用户访问监测新增 CDN 厂商信息采集，通过分析图表对不同厂商的 CDN 进行质量分析。更多配置可参考 [用户访问监测采集器配置](../integrations/rum.md#cdn-resolve)。

##### 新增 UniAPP 应用接入

用户访问监测新增 UniAPP 应用接入，当前版本支持 Android 和 iOS 平台。更多详情可参考 [UniApp 应用接入](../real-user-monitoring/uni-app/app-access.md)。

#### 场景优化

##### 新增自定义查看器导航菜单

在场景查看器列表，新增支持将当前查看器添加至基础设施、指标、日志、应用性能监测、用户访问监测、可用性监测、安全巡检、CI 可视化导航菜单。更多详情可参考 [添加查看器导航菜单](../scene/explorer/index.md#menu)。

##### 增强场景视图变量级联功能

在场景视图变量配置级联查询时，支持使用 `=` 、`!=` 精确匹配变量值，支持使用 `match（re）` 、`not match（re）` 、`wildcard` 、`not wildcard` 模糊匹配变量值。更多详情可参考文档 [视图变量](../scene/view-variable.md#query)。

##### 饼图新增合并配置选项

饼图新增合并配置选项，支持用户将冗余的数据点合并到 “其他” 显示，提高饼图的可读性。更多详情可参考文档 [饼图](../scene/visual-chart/pie-chart.md)。

#### 调整图表查询运算符翻译逻辑

图表查询中 match / not match 运算符翻译逻辑调整，日志类数据中 match 去除默认添加右 * 匹配逻辑，若有需求可手动在输入框中添加。

![](img/13.query_1.png)

#### 其他功能优化

- 观测云 [商业版注册](../billing/commercial-register.md)  流程支持绑定观测云费用中心账号；
- 配置 [监控器](../monitoring/monitor/index.md) 时，「检测维度」支持非必选。


### DataKit 更新

**新加功能**

- 命令行增加解析行协议功能
- Datakit yaml 和 helm 支持资源 limit 配置
- Datakit yaml 和 helm 支持 CRD 部署
- 添加 SQL-Server 集成测试
- RUM 支持 resource CDN 标注

**功能优化**

- 优化拨测逻辑
- 优化 Windows 下安装提示
- 优化 powershell 安装脚本模板
- 优化 k8s 中 Pod, ReplicaSet, Deployment 的关联方法
- 重构 point 数据结构及功能
- Datakit 自带 eBPF 采集器二进制安装

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md)。

## 2023 年 2 月 16 号

### 观测云更新

#### 优化工作空间权限管理

##### 新增成员角色及权限清单管理

观测云新增角色管理功能，支持对企业中的员工设置不同的观测云功能访问权限，以达到不同员工之间的权限隔离。

观测云默认提供四种成员角色，分别为“Owner”、“Administrator”、“Standard”和“Read-only”，除了默认角色以外，观测云支持在角色管理创建新的角色，并为角色赋予权限范围，满足不同用户的权限需要。更多详情可参考文档 [角色管理](../management/role-management.md)。

![](img/8.member_6.png)

##### 优化成员邀请，增加选择成员权限

在当前空间内，邀请的新成员，默认权限为只读成员，新增支持选择一个或多个角色来设置新成员的权限，更多详情可参考文档 [成员管理](../management/member-management.md)。

![](img/8.member_1.png)

##### 新增批量修改成员权限

在成员管理，新增批量修改权限功能，点击「批量修改权限」，选择需要批量修改权限的成员，点击「确定」，在弹出的对话框中为成员选择权限后「确定」即可。更多详情可参考文档 [成员管理](../management/member-management.md)。

![](img/8.member_3.png)

##### 优化 SSO 管理，新增 SAML 映射功能

观测云新增基于配置 SAML 映射关系，为企业提供更精细的单点登录方案，开启 SAML 映射后，支持为企业员工动态的分配访问权限，员工可根据被分配的角色权限来访问观测云。

在观测云工作空间「管理」-「成员管理」-「SSO管理」-「SSO 登录」，启用 「SAML 映射」，并在「SAML 映射」配置映射关系。更多详情可参考文档 [SSO管理](../management/sso/index.md)。

![](img/5.sso_mapping_10.png)

##### 成员管理页面显示优化

在成员管理，新增自定义角色管理功能，调整搜索、快捷筛选等布局。更多详情可参考文档 [成员管理](../management/member-management.md)。

![](img/8.member_5.png)

##### 权限变更审核优化

基于新增的角色权限管理，调整费用中心审核的触发条件，当用户角色被赋予 Token 的查看、操作权限，即触发观测云费用中心的审核。更多详情可参考文档 [权限变更审核](../management/role-management.md#upgrade)。

#### 新增登录会话保持时间设置

观测云支持为登录到工作空间的账号设置会话保持时间，包括 SSO 单点登录的账号和工作空间注册的账号，支持为登录账号设置“无操作登录会话保持时间”和“登录会话最大保持时间”，设置以后，超时登录会话会失效。

- 无操作登录会话保持时间：支持设置范围 30 ～ 1440 分钟，默认为 30 分钟；
- 登录会话最大保持时间：支持设置范围 0 ～ 7 天，其中 0 表示永不超时，默认为 7 天。

#### 新增工单管理

针对在观测云中遇到的问题，用户可以通过提交工单的方式进行咨询与建议，官方会进行及时的处理与反馈。例如：使用过程中遇到难以解决的问题、购买以及费用相关的咨询、向观测云提出需求建议等等。

工单系统是基于个人账号级别的，用户可以在工单管理中查看由本人提交的所有工单，不区分工作空间。工单管理入口：左下角「账号」-「工单管理」。更多详情可参考文档 [工单管理](../management/work-order-management.md)。

![](img/1.work_order_1.png)

#### 其他功能优化

- 工作空间创建时新增语言选择，语言选项影响工作空间内事件、告警、短信等模板，若选择英文，上述对应模板将默认使用英文模板；
- 优化工作空间锁定功能，若费用中心账号欠费或云市场订阅异常等情况会导致工作空间锁定，工作空间锁定以后，新数据将停止上报，观测云提供 14 天的缓冲期，您可以在这期间继续查看和分析历史数据，并通过解除锁定状态，继续使用观测云。更多详情可参考文档 [工作空间锁定](../management/index.md#lock)。


### 智能巡检更新

- **RUM 性能巡检：**支持影响用户的会话 ID 跳转查看问题 Session，在巡检事件报告中提供更专业的优化手段。
- **云账户实例维度账单巡检：**新增对 AWS 账户实例维度账单巡检支持。

更多智能巡检更新可参考 [智能巡检更新日志](../monitoring/bot-obs/index.md)。

### 最佳实践更新

- 云平台接入
    - 阿里云 - [阿里云事件总线 EventBridge 最佳实践](../best-practices/partner/aliyun_eventbridge.md)

更多最佳实践更新可参考 [最佳实践版本历史](../best-practices/index.md)。


## 2023 年 2 月 9 号

### DataKit 更新

**新加功能**

- Datakit 主机安装可自定义默认采集器开启
- 提供 OTEL 的错误追踪
- 提供 RUM Session 回放能力

**功能优化**

- Datakit pyroscope profiling 多程序语言识别
- 优化 CPU, Disk, EBPF, Net 等中英文文档
- 优化 elasticsearch, postgresql, dialtesting 等英文文档
- 优化 DCA, Profiling 文档
- 优化日志采集流程
- iploc yaml 配置方法文档支持

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md)。

### 智能巡检更新

#### 新增巡检

- **RUM 性能巡检：**Real User Monitoring（RUM）是一种应用性能监测技术，旨在通过模拟真实用户在浏览网站时的行为来评估网站性能。RUM 的目的是从用户的角度了解网站性能，了解网站加载时间，网页呈现的效果，页面元素的加载情况以及交互的反应。RUM 性能巡检的使用场景主要是对于客户端类型的网站，例如：电子商务网站、金融网站、娱乐网站等等，这些网站都需要向用户呈现一个快速和流畅的访问体验。通过对 RUM 性能结果分析，可以快速帮助开发人员可以了解用户的实际体验，以便快速改进网站的性能。
- **Kubernetes 健康巡检：**现如今 Kubernetes 已经席卷了整个容器生态系统，它充当着容器分布式部署的大脑，旨在使用跨主机集群分布的容器来管理面向服务的应用程序。Kubernetes 提供了用于应用程序部署、调度、更新、服务发现和扩展的机制，但是该如何来保障 Kubernetes 节点的健康呢，通过智能巡检可以根据当前节点的资源状态、应用性能管理、服务故障日志等信息的检索和问题发现，从而加快事件调查、减轻工程师的压力、减少平均修复时间并改善最终用户体验。

更多智能巡检更新可参考 [智能巡检更新日志](../monitoring/bot-obs/index.md)。

## 2023 年 1 月 17 号

### 观测云英文版上线

## 2023 年 1 月 12 号

### 观测云更新

#### 新增观测云站点服务 Status Page

观测云提供 Status Page，帮助您实时查看观测云不同站点的服务状态。若您已经登录到观测云，您可以通过点击左下角的**帮助 > Status Page**来查看观测云各个站点的服务状态。更多详情可参考文档 [Status Page](../management/status-page)。

![](img/6.status_page_4.png)

#### 新增绑定自建 Elasticsearch / OpenSearch 索引

观测云新增支持绑定自建 Elasticsearch / OpenSearch 索引，帮助您统一快速查看和分析您的日志数据。更多详情可参考文档 [绑定索引](../logs/multi-index.md#binding-index)。

![](img/9.log_index_2.png)

#### 新增网络查看器列表模式

在「基础设施」-「网络」，选择「主机 / Pod / Deployment / Service」，支持切换至对应网络列表查看源 IP/端口和目标 IP/端口之间的 TCP 重传次数、TCP 连接数、TCP 关闭次数、TCP 延时、发送字节数、接收字节数、状态码等。更多详情可参考文档 [网络](../infrastructure/network.md)。

![](img/4.network_2.png)



#### 新增前端应用 Span 请求耗时分布显示

在链路详情页，若当前的链路属于前端应用调用产生的 Span，您可以在链路详情查看请求耗时分布，包括 Queueing（队列）、First Byte（首包）、Download（下载）的请求耗时占比，帮助您直观的查看前端某个 Span 的过程消耗占比。

> 注意：用户访问监测 SDK 必须是 2.2.10 以及上才可以看到这部分数据显示，如存在跨域情况需要调整 header 配置，更多详情可参考文档 [Web 应用接入](../real-user-monitoring/web/app-access.md#header)。

![](img/8.apm_browser_2.png)

#### 优化用户访问监测 Session 交互逻辑

- Session 查看器去掉所有记录列表；
- Session 会话详情页显示优化：类型显示优化、支持切换会话发生的绝对时间、增加服务列、详情页显示优化、错误信息优化
- Session 会话更新逻辑优化：Session 数据更新从追加的逻辑调整为基于 session_id 覆盖的逻辑
- 链路中若存在前端应用调用产生的 Span，该 Span 对应的 service 值会根据当前用户访问数据中的 service 值做填充，若用户访问数据中不存在 service 的信息，则默认填充 "browser"

更多详情可参考文档 [Session（会话）](../real-user-monitoring/explorer/session.md)。

![](img/7.rum_session.png)

#### Pod 指标数据采集默认关闭

在最新的 DataKit 版本中，`container` 采集器的 Pod 指标数据配置调整为默认关闭 `enable_pod_metric = false` 。更多详情可参考文档 [容器数据采集](../datakit/container.md#config)。

#### 其他功能优化

- 绑定 MFA 认证调整为邮箱验证
- 注册时调整手机验证为邮箱验证
- 登录时安全验证调整为滑块验证
- 创建工作空间新增观测云专属版引导
- 工作空间新增备注显示功能
- 云账号结算用户新增在观测云付费计划与账单查看账单列表
- 表格图支持基于 「by 分组」设置别名
- 优化监控器配置中的时序图，仅在选择维度后显示
- [优化日志类数据无数据告警配置](../monitoring/monitor/log-detection.md)
- OpenAPI 新增创建工作空间接口

### DataKit 更新

- [confd 增加 Nacos 后端](../datakit/confd.md)
- 日志采集器添加 LocalCache 特性
- 支持 C/C++ Profiling 数据
- RUM Session Replay 文件上报
- WEB DCA 支持远程更新 config

- 优化 SQL 数据资源占用较高问题
- 优化 Datakit Monitor

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md)。

### 最佳实践更新

- 云平台接入
    - AWS - [EKS 部署 DataKit](../best-practices/partner/eks.md)。
- 监控 Monitoring
    - 应用性能监控 (APM) - 调用链 - [使用 datakit-operator 注入 dd-java-agent](../best-practices/monitoring/datakit-operator.md)。

更多最佳实践更新可参考 [最佳实践版本历史](../best-practices/index.md)。
