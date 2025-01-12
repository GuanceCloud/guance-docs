# 版本历史

## 1.100.185（2024 年 12 月 11 日） {#1.100.185}

pubrepo.guance.com/dataflux/1.100.185:launcher-d8e4c42-1734341625

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.100.185.tar.gz
    - MD5: `711b90a43b1e0c5e944d7210cc2edbce`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.100.185.tar.gz
    - MD5: `9fdc1001c8e90d380567bc74d6aec585`


### 观测云部署版更新 {#onpremise1211}

1. 在 Launcher 中修改 Registry Key 配置后，k8s 中对应的 registry-key 配置会实时更新。

### 功能更新 {#feature1211}

#### 场景

1. [拓扑图](../scene/visual-chart/topology-map.md)新增外部数据查询：允许用户通过 DataFlux Func 实现外部数据绘制拓扑图。用户只需按照图表结构接入数据，即可轻松实现外部数据的可视化展示。
2. [图表](../scene/visual-chart/index.md#type)优化
    - 图表显示效果优化：对图表的显示效果进行优化，调整为侧滑列出，分类展示，使图表的查找和使用更加便捷。
    - 图表描述及适用场景显示：图表列表中增加了图表描述及适用场景的显示，可以帮助用户更好地理解和选择合适的图表类型。
3. 视图变量优化
    - 视图变量支持配置值列出上限，避免数据列出过多导致页面加载性能问题。
    - 部署版默认列出上限为 50，支持自定义默认列出数量，注意：页面配置限制优先全局限制。

#### 基础设施

1. 资源目录优化：
    - 新增分组功能：为了提高资源管理的效率，新增资源分组功能。用户可以将具有共性的资源分类进行分组，便于管理和查看，从而优化资源的组织结构。
    - 查看器蜂窝图模式优化：支持配置“颜色填充”和“分组分析”的字段列表，用户可以根据需要自定义可选的字段。
2. 容器、资源目录查看器搜索优化：容器查看器新增 `container_name` 搜索，资源目录新增 `name` 搜索。

#### 监控

告警策略配置优化

- 支持通过告警策略入口[一键创建关联监控器](../monitoring/alert-setting.md#with_monitor)，新增以告警策略为中心的统一告警通知管理模式。
- 优化告警策略列表关联显示交互。

#### RUM

RUM 新增了对 React Native 应用类型的支持，并允许上传 SourceMap 以进行数据解析和还原。如果您需要为原本在 Android / iOS 类型下创建的 React Native 应用上传 SourceMap，请注意：

1. 在创建新应用时，选择 “React Native” 应用类型。在创建中，您可直接复制 Android / iOS 类型下已有的 React Native 应用的名称和应用 ID，然后点击“创建”按钮。完成创建后，您便可以在该应用下配置 SourceMap。这一变更仅涉及 React Native 应用的创建方式，不会对数据采集产生影响。

2. 如果您原先在 Android / iOS 类型下的 React Native 应用有关联的监控器，并且尚未在 “React Native” 类型下重新创建相同 ID 的 React Native 应用，原有的监控器可以继续正常工作。但如果您已经重新创建了 “React Native” 类型的应用，原有的监控器在“应用名称”项将无法获取数据，显示为空。在这种情况下，您需要选择应用类型为 “React Native” 并重新保存此监控器。

#### APM

APM 安装引导新增[自动注入方式](../application-performance-monitoring/explorer/auto_wire/apm_datakit_operator.md)：在 APM（应用性能监测）的安装引导中，新增了 Kubernetes Operator 自动注入的安装方式。这种方式简化了 APM 的部署流程，使得用户可以更快捷地在 Kubernetes 环境中安装和使用。


### 新增集成 {#inte1211}

- 新增 [HBASE region](../integrations/hbase_region.md) 集成；
- 新增 [HBASE master](../integrations/hbase_master.md) 集成；
- 优化 [NodeExporter](../integrations/node-exporter.md) 集成视图；
- 新增 [华为云 DCAAS 云专线](../integrations/huawei_dcaas.md) 集成；
- K8S dashboard 调整；
- 更新 [memcached](../integrations/memcached.md) 视图和监控器；
- 更新 [rabbitmq](../integrations/rabbitmq.md) 视图和监控器。

### Bug 修复 {#bug1211}

1. 解决了表达式查询数值异常的问题；
2. 解决了在图表用 PromQL 查询某一段时刻启动的 `pod` 的 cpu 使用率时，用时序图在时间范围内可以看到数据，但在转换为图表查询时数据查询不出来的问题。
3. 解决了告警事件不恢复的问题。
4. 解决了 PromQL 查询结果异常的问题。
5. 解决了私有化部署 > 管理后台修改热存储时长时报错 `warmretention` 字段缺少的问题。
6. 解决了部署版日志搜索结果和火山引擎 TLS 上搜索不一致的问题。
7. 解决了仪表板大屏在嵌入用户的 IFrame 页面时会出现随机缩放的问题。
8. 解决了用户管理新建分组将其加入多个空间后页面卡顿的问题。
9. 解决了首次进入观测云控制台 > 事件时报错 `df_fault_id` 的问题。
10. 解决了打开事件菜单时会提示超出内存限制的问题。
11. 解决了概览图表达式计算错误的问题。
12. 解决了监控器触发告警后未产生事件的问题。
13. 解决了部署版火山引擎底座日志查询功能异常的问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.99.184（2024 年 12 月 05 日） {#1.99.184}

pubrepo.guance.com/dataflux/1.99.184:launcher-71d4565-1733376363

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.99.184.tar.gz
    - MD5: `d7f759b7b25a1d50c721608f113588c7`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.99.184.tar.gz
    - MD5: `b6547a872bbf81bff77255d355ec77d5`

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 修复升级过程中，可能发生数据库结构升级失败的情况。


## 1.99.183（2024 年 11 月 27 日） {#1.99.183}

pubrepo.guance.com/dataflux/1.99.183:launcher-a0f6329-1733131478

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.99.183.tar.gz
    - MD5: `ddc63b16e02ed8473740fe97983c7c35`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.99.183.tar.gz
    - MD5: `e1b2ddfe419889a947d16b7e11204bb2`

### Breaking Changes {#breakingchanges1127}

1. OpenAPI：若通过 API 配置告警策略按成员配置通知规则模式，需注意通过 OpenAPI 方式[新增/修改](../open-api/alert-policy/add.md)成员类型的告警策略的参数结构调整。

2. 仪表板 > [可见范围](../scene/dashboard/index.md#range)：新增“自定义”选项，支持配置此仪表板的操作、查看权限成员。
    - 注意：若您先前在可见范围处添加了“团队”，团队配置将失效，需重新配置。

### 功能更新 {#feature1127}

#### 云账单

1. 新增功能引导页：提供简洁明了的步骤及说明，让用户能够迅速上手；
2. 新增支持[火山引擎、微软云数据接入](../cloud-billing/index.md#precondition)。


#### [外部数据源接入](../dataflux-func/external_data.md)

1. MySQL 数据存储系统支持：平台现已支持接入 MySQL 数据存储系统，用户可以利用此功能实现数据的实时查询和分析。

2. 原生查询语句直接使用：用户可以直接在图表中使用数据源的原生查询语句进行数据查询和展示，无需进行任何转换或适配。

3. 数据安全与隐私保护：为了保护用户的数据安全和隐私，平台不会存储任何添加的数据源信息。所有数据源配置将直接保存在用户的本地 Func 中，确保数据源信息的安全，避免数据泄漏风险。 

#### 监控 

1. 告警策略 > [按成员配置通知规则](../monitoring/alert-setting.md#member)：

    - 支持配置多组成员通知规则并行生效；
    - 成员配置通知规则支持定义生效的时间范围，若存在多组时间范围则按照序号顺序匹配，多组时间范围最终只会取第一个匹配到的时间范围内通知规则做告警发送。

2. 监控器：配置关联告警策略时支持搜索。

3. [静默时间](../monitoring/silent-management.md)：定义“重复”静默时间时，支持自定义静默开始时间、静默持续时长，支持配置“按天”、“按周”、“按月”的静默周期，帮助更灵活地定义静默时间。同时新增静默计划预览功能，可以查看当前定义的静默时间。

#### 付费计划与账单

[高消费预警](../billing/index.md#alert)：

- 支持自定义配置预警通知成员，当计费项超出设定阈值时，会向 Owner 和对应的通知成员发送邮件预警；    
- 支持在每一个计费项下设置此计费项的专属通知成员；    
- 支持回车创建外部邮箱作为通知成员。

#### 应用性能监测

1. RUM > [分析看板](../real-user-monitoring/app-analysis.md)、容器 > 分析看板：视图切换显示优化，用户在切换视图时能获得更流畅的体验。
2. 日志内置页面：在选择日志索引时支持搜索，优化操作体验。

#### 事件

1. 未恢复事件查看器支持通过时间控件调整查询事件范围；
2. 事件查看器支持自定义配置显示列。

#### 场景

图表优化：支持配置图表数据展示是否使用科学计数法进位。

#### 管理

[黑名单](../management/overall-blacklist.md)：新增名称和描述项，支持区分用途和其它关联场景。


#### 帮助中心

帮助文档优化：[集成](../integrations/integration-index.md)页面新增描述信息，帮助直观查看集成信息。

### 部署版更新 {#deployment1127}

1. 支持修改配置文件以自定义查看器默认时间范围；
2. 管理后台成员信息支持输入国际手机号码。

### 新增集成 {#inte1127}

- 新增 [Azure MySQL](../integrations/azure_mysql.md)；
- 新增 [华为云 Mariadb](../integrations/huawei_rds_mariadb.md) 集成；
- 新增 [华为云 EIP](../integrations/huawei_eip.md) 集成；
- 新增 [华为云 WAF](../integrations/huawei_waf.md) 集成；
- 新增 [Confluent cloud](../integrations/confluent_cloud.md) 集成；
- 更新 [阿里云 SAE](../integrations/aliyun_sae.md) 集成，添加 链路、日志部分的集成；
- 更新 [SQLSERVER](../integrations/sqlserver.md) 监控器。


### Bug 修复 {#bug1127}

1. 修复部分查看器列表列名无法通过 “显示列” 入口进行别名定义的问题；
2. 修复了 RUM 生成指标时，所列出应用未受数据访问规则影响的问题；
3. 修复了应用性能监控 > 错误追踪 > Issue 自动发现前端样式适配的问题；
4. 修复了仪表板 > 图表内资源目录查询时间的问题；  
5. 修复了账单分析账期列宽度无法调整的问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.98.182（2024 年 11 月 20 日） {#1.98.182}

pubrepo.guance.com/dataflux/1.98.182:launcher-a1381c3-1732173851

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.98.182.tar.gz
    - MD5: `93a3c271e6395318b98aafc14f668289`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.98.182.tar.gz
    - MD5: `5a34bb3b9810dfa5774e5b2eb1b48026`

### 功能更新 {#feature1120}

#### 微软云市场上架

观测云已在[海外微软云市场](../plans/commercial-azure.md)上架，同时商业版工作空间新增“微软云”结算方式。

#### 集成 -> 扩展

- Func 平台联动优化：可以在扩展中查看所有接入的 DataFlux Func列表，方便用户管理和监控所有已接入的外部数据源

### 部署版更新 {#deployment1120}

- 火山云 TLS 支持 JSON 索引和搜索

### Bug 修复 {#bug1120}

1. 解决了数据转发到 Kafka，消耗了过多 Kafka 出网流量的问题

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.98.181（2024 年 11 月 13 日） {#1.98.181}

pubrepo.guance.com/dataflux/1.98.181:launcher-475455f-1731916153

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.98.181.tar.gz
    - MD5: `2ebf51ebd9e2ac8d5ff30ac3e626f597`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.98.181.tar.gz
    - MD5: `23c290d7a651f8e8702808b3fea87983`

???+ attention 重要版本依赖更新说明

    ### 此部署版，对于 GuanceDB 组件的最低版本要求

    #### GuanceDB for Logs
    - guance-select: v1.9.6+
    - guance-insert: v1.9.6+

    #### GuanceDB for Metrics
    - guance-select: v1.9.6+
    - guance-insert: v1.9.6+
    - guance-storage: v1.9.6+

### 部署版更新 {#deployment1113}

1. 忘记密码：当忘记登录密码时，支持以账号关联的邮箱验证码的方式找回密码。注意：若账号未关联邮箱，则无法通过此方式找回密码。
2. [全局 DCA 配置](../deployment/setting.md#dca)：新增全局 DCA 地址配置，可一键配置所有工作空间的 DCA 地址。

### OpenAPI 更新 {#breakingchanges1113}

1. 快照：支持日志查看器以 OpenAPI 方式[创建快照](../open-api/snapshot/generate.md)。
2. 数据访问：OpenAPI 支持获取数据访问列表，支持[获取](../open-api/data-query-rule/get.md)/[新建](../open-api/data-query-rule/add.md)/[修改](../open-api/data-query-rule/modify.md)单个数据访问规则。


### 功能更新 {#feature1113}


#### 付费计划与账单

1. [高消费预警](../billing/index.md#billing)优化：高消费预警新增总消费预警功能，支持针对工作空间总消费设置预警金额。

#### 应用性能监测

- Java 应用支持[创建内存快照](../application-performance-monitoring/service-manag/service-list.md#jvm)，帮助开发者可以快速分析和优化应用性能。
- 安装引导优化：新增 K8S 部署[安装引导](../application-performance-monitoring/explorer/deploy_on_k8s.md)。

#### DQL 查询

支持直接指定 `[today]`、`[yesterday]`、`[this week]`、`[last week]`、`[this month]`、`[last month]` [时间参数](../dql/query.md#query_time)。

#### 管理

1. 邀请成员：新增换行分隔功能，多个邮箱之间可通过换行识别。
2. 数据转发规则拓展：数据转发到华为云 OBS [支持 AK、SK 方式访问](../management/backup/backup-huawei.md#ak)，提供更丰富的 OBS 访问方式。
3. 工作空间：
    - 工作空间删除或解散新增 7 天暂存逻辑，7 天后工作空间内数据再进行最终清除；
    - 支持配置个人账号级别的默认空间和置顶空间。

#### 监控

1. 监控器功能增强：检测指标选择日志时，支持搜索日志索引进行选取。
2. 监控器：监控器阈值触发判断配置追加到事件中做记录，关联事件字段：`df_monitor_checker_value_with_unit`，事件内容内可通过 `{{ Result_with_unit }}` 渲染附带单位的检测值。
3. 智能监控事件支持双语切换：当切换工作空间语言的时，智能监控事件支持随着工作空间语言更改。
4. 云账单监控视图：云账单视图支持更多实例视角的账单分析

#### 场景

1. 柱状图新增 Y 轴上下限设置，可以更精确地控制图表的显示效果；
2. 在进行跨工作空间查询时，支持选择“全部空间”，以便用户一次性获取全部信息。


### 新增集成 {#inte1113}


- 新增 [Azure SQL Servers](../integrations/azure_sqlserver.md)；
- 新增 [华为云 RDS SQLServer](../integrations/huawei_rds_sqlserver.md)；
- 新增 [华为云 DDS](../integrations/huawei_dds.md) 集成；
- [华为云 DCS（redis）](../integrations/huawei_dcs.md) 新增慢日志采集流程；
- [华为云 MongoDB](../integrations/huawei_mongodb.md) 慢日志采集流程；
- [华为云 RDS MYSQL](../integrations/huawei_rds_mysql.md) 慢日志采集流程；
- 优化 [Node Exporter](../integrations/node-exporter.md) 视图、文档；
- 优化 [EMQX](../integrations/emqx.md) 视图、文档，添加监控器；
- 优化 [Kubernates](../integrations/container.md) 视图；
- 优化 [SQLServer](../integrations/sqlserver.md) 视图和监控器；
- 优化 [Redis](../integrations/redis.md) 视图和监控器；
- 优化 [Kafka](../integrations/kafka.md) 视图和监控器。

### Bug 修复 {#bug1113}

1. 解决了告警策略设置过滤条件，使用事件信息中的扩展字段进行过滤，无法发送告警的问题。 
2. 解决了告警策略里面的过滤条件未展示所有内容的问题。
3. 解决了告警策略正则匹配导致监控器无法发出告警的问题。
4. 解决了配置告警投递到异常追踪，并通过异常追踪通知到指定 Webhook，但检查通知结果发现 `issue.add` 类型的创建通知未能正常发送的问题。
5. 解决了资源目录的二级菜单数据不稳定的问题。
6. 解决了资源目录 > 添加资源分类到二级菜单后，资源分类删除而二级菜单还在的问题。
7. 解决了资源目录的 JSON 在保存后，下次打开会清空掉配置的问题。
8. 解决了资源目录中，通过标签为资源关联仪表板，未命中标签的资源错误关联上该仪表板的问题。
9. 解决了选择资源目录，加载显示列不连贯，中间有明显的过渡显示列的问题。
10. 解决了版本升级后，日志流图中筛选条件丢失，视图无法正常加载的问题。
11. 解决了日志查看器 "添加筛选" 功能无法完整识别 `trace_id` 字串的问题。
12. 解决了 `-bpf_net_l7_log` 日志的关联网络日志不准确的问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.97.180（2024 年 11 月 08 日） {#1.97.180}

pubrepo.guance.com/dataflux/1.97.180:launcher-972c327-1731042264

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.97.180.tar.gz
    - MD5: `0a6a2bf00fbef5fb29fd2b6bbf544880`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.97.180.tar.gz
    - MD5: `cf961aa69c6e6d1635893b9813a7216b`

### 功能更新 {#feature1106}

#### 监控

告警策略新增根据[成员范围](../monitoring/alert-setting.md#member)定义通知规则，帮助用户更好的管理告警通知和问题处理边界。

#### 场景

[Rollup 函数](../scene/visual-chart/chart-query.md#rollup)仅适用于指标数据查询，在图表简单模式下，对其他数据类型的查询选择将做下线处理。


### Bug 修复 {#bug1106}

1. 解决了基础设施蜂窝图不显示具体的使用率的问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.97.179（2024 年 10 月 30 日） {#1.97.179}

pubrepo.guance.com/dataflux/1.97.179:launcher-743e11c-1730431656

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.97.179.tar.gz
    - MD5: `160fe9a8e9566221149a4a52ff4b0c2b`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.97.179.tar.gz
    - MD5: `7f52fa4bbf4342ebc052adf079dfcbf8`

???+ attention

    此版本依赖 v1.9.3 版本的 GuanceDB for logs 引擎，请同步升级 GuanceDB for logs 引擎的 guance-select、guance-insert 组件到至少 v1.9.3 版本

### 部署版更新

1. 管理后台新增监控器菜单：列出所有工作空间的监控器，支持搜索、筛选监控器；支持修改监控器的启用/禁用状态、删除、导出监控器等操作，同时支持克隆单个/批量监控器到选中工作空间。
    - 注意：组合检测监控器不支持跨工作空间克隆。
2. MFA 安全认证优化：新增隐藏 7 天自动登录选项的开关，支持配置免认证登陆选项是否开启。
3. CDN 域名配置： 可以在配置文件中配置 CDN 域名，RUM 应用接入页面将自动获取并显示

### 新增集成 {#inte1030}

- [阿里云 SAE](../integrations/aliyun_sae.md)；
- [Node Exporter](../integrations/node-exporter.md)；
- [Azure Public IP](../integrations/azure_public_ip.md)；
- [Grafana Guance Datasource](../integrations/grafana-guance-data-source.md)；
- [Grafana Dashboard](../integrations/quick-guide.md)；
- [Greenplum](../integrations/greenplum.md)。

### 功能更新 {#feature1030}

#### 云账单

新增[一级导航](../cloud-billing/index.md)菜单，针对云账单数据预置查看器和账单分析视图，优化用户查看体验。

注意：体验版暂不支持。

#### 监控

1. [主机智能监控](../monitoring/intelligent-monitoring/host-intelligent-detection.md)新增网络检测扩展：基于主机的网络监控提供了高效的网络性能监测，帮助用户实时监控主机的网络流量，识别异常流量和潜在的连接问题并及时预警，避免影响业务正常运行。系统支持多维度可视化功能，帮助用户深入分析和理解主机的网络使用情况，优化带宽分配和资源利用率，为未来的容量规划提供数据支持，从而确保网络资源的合理配置。
2. 监控器功能增强： 
    - 支持在监控器列表中[批量设置](../monitoring/monitor/monitor-list.md#options)关联告警策略。
    
    - 日志查看器可针对当前筛选和搜索条件[一键配置](../logs/manag-explorer.md)【日志检测】类型监控器。
    
    - 注意：只有在站点和工作空间级别都开启了 `左*` 查询的前提下，监控器才支持 `左*` 查询。否则日志查看器若配置 `左*` 查询，跳转到监控器会查询报错。

3. [通知对象](../monitoring/notify-object.md)列表：
    - 新增搜索、快捷筛选功能，支持快速检索通知对象；
    - 针对连续两天发送失败被系统禁用的通知对象，名称后展示标记。

4. [静默规则](../monitoring/silent-management.md)优化：
    - 新增规则名称和描述配置功能，提升规则管理的便捷性；
    - 事件属性支持不同字段的逻辑组合关系（AND 和 OR）；
    - 优化列表显示效果，支持自定义显示列，提升用户界面的个性化体验。

5. [告警策略](../monitoring/alert-setting.md)：
    - 通知规则内标签匹配逻辑支持不同字段自由组合 AND 和 OR 的关系，交互体验同查看器筛选搜索组件一致；
    - 新增自定义操作权限配置；
    - 新增告警策略描述填写。

#### 场景

1. 新增主机 NET 分析视图：通过对主机的网络使用情况，带宽分配和资源利用率等指标的汇聚，为未来的容量规划提供数据支持，从而确保网络资源的合理配置。
2. 图表查询优化：
    - `index` 不支持做 `by` 分组查询，优化 DQL 查询交互体验；
    - By 标签范围 / 筛选标签范围列出精确到指标级别；
    - DQL 查询新增获取日志索引的查询函数：`show_logging_index()`，可在仪表板视图变量处应用，同时图表查询索引配置支持视图变量填充；
    - 图表的表达式查询功能现已支持跨空间查询；
    - 优化组合图表的时间锁定显示，提供更加直观的用户体验。
3. 查看器页面优化：查看器详情页中绑定主机的 Tab 页追加 `host_ip` 显示。

#### Pipeline

[Pipeline](../pipeline/index.md) 文本处理优化：隔离“本地 Pipeline” 和“中心 Pipeline”，允许不同类型添加同一个数据源的处理脚本。并新增提示信息，帮助用户更直观地了解处理差异。

#### 管理

[数据访问](../management/logdata-access.md)功能整合：    

- 应用性能和指标新增数据访问功能；
- 管理中新增「数据访问」功能模块，整合所有数据类型，支持用户快速查询与过滤。

#### 可用性监测

拨测任务优化：Websocket 拨测内容框输入限制提升到 128k；拨测任务页面整体优化。

### Bug 修复 {#bug1030}

1. 解决了饼图的 0% 值显示歧义的问题，已优化 0% 值在画图时的占比和视觉效果。
2. 解决了查看“事件”菜单的默认页面加载报错的问题。
3. 解决了日志索引选择多索引时出现的问题。
4. 解决了通过“外部事件监控器”传入第三方工具的 Event 时 `extra_data` 字段缺失的问题。
5. 解决了日志查看器中通过快捷筛选方式切换主机，右侧数据不刷新的问题。
6. 解决了表格图中空值显示优化的需求。
7. 解决了 API 导入数据访问规则的查询条件在页面上不显示的问题。
8. 解决了拨测日志在日志功能中可以查看到，但在进行 PL 处理时找不到相关数据源的问题。
9. 解决了应用性能监测服务拓扑报错的问题。
10. 解决了 GuanceDB 升级到最新版本后 DQL 不支持 tag 计算的问题。
11. 解决了通过日志上下文点进来无法定位到当前日志的问题。
12. 调整应用智能监控灵敏度，减少请求数异常突降过多问题。
13. 改善突变检测监控器对高频 tags 的不适配问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.96.178（2024 年 10 月 16 日） {#1.96.178}

pubrepo.guance.com/dataflux/1.96.178:launcher-8f2b0c4-1729223560

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.96.178.tar.gz
    - MD5: `e7fb67ced822ca02ba4ede7220659d72`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.96.178.tar.gz
    - MD5: `7a0c55b6a013d1ce1867478088ba588e`

### 部署版更新

1. 仪表板视图变量下拉框列出值取消 `limit 50` 的限制，以满足不同的数据查询需求。
2. 管理后台更新：管理[菜单](../deployment/menu.md)隐藏项新增“帮助”、“头像”、“系统通知”和“快捷入口”选项，以提高管理效率。

### 新增集成 {#inte1016}

- [Hadoop hdfs datanode](../integrations/hadoop_hdfs_datanode.md)；
- [Hadoop hdfs namenode](../integrations/hadoop_hdfs_namenode.md)；
- [Hadoop yarn nodemanager](../integrations/hadoop_yarn_nodemanager.md)；
- [Hadoop yarn resourceManager](../integrations/hadoop_yarn_resourcemanager.md)；
- [Fluent Bit](../integrations/fluent_bit.md)；
- [Azure VM](../integrations/azure_vm.md)；
- [NPD](../integrations/npd.md)：新增事件模式采集&介绍。

### 功能更新 {#feature1016}

#### AI 智能助手

观测云引入 [AI 智能助手](../guance-ai/index.md)，提供快速响应，解答观测云相关的问题。

#### 云账单智能监控

1. 新增云账单查看器：当账单数据收集到观测云后，可以通过云账单查看器模版创建云账单查看器查看到云账单的全部数据
2. 新增云账单系统视图：通过对云账单的产品、地域、实例级别的消费分析，帮助用户快速分析和了解当前云资源的消费趋势，为未来云资源费用规划提供参考
3. 新增[云账单智能监控](../monitoring/intelligent-monitoring/index.md)：云账单智能监控提供高效的云成本管理工具，帮助用户实时监控云服务消费，识别异常费用并预警，避免不必要支出。它支持多维度可视化功能，帮助用户分析和理解云资源的消费模式，为未来预算规划提供依据，从而优化云资源配置，确保费用物尽其用。

#### 监控

1. [监控器配置](../monitoring/monitor/monitor-rule.md)交互优化：
    - 支持针对选中等级事件配置[异常追踪 Issue 关联](../monitoring/monitor/monitor-rule.md#issue)创建；
    - 优化 Crontab 自定义检测频率和检测区间配置交互；
    - 新增[通知内容自定义](../monitoring/monitor/monitor-rule.md#content)。
2. 告警策略配置优化：
    - 规则内针对事件过滤条件新增[正则匹配](../monitoring/alert-setting.md#filter)；
    - 优化过滤条件配置显示。
3. 数据采样优化：在监控器配置页面和指标分析页面，当图表因数据量过大自动触发数据采样时，用户可以手动关闭数据采样功能。

#### 日志

1. 日志新增[错误追踪](../logs/log-tracing.md)：支持错误日志追踪查看分析。


#### 场景

1. 仪表板[可见范围](../scene/dashboard/index.md#range)优化：仪表板可见范围在公开的基础上，支持自定义配置可见成员，同时支持批量设置仪表板可见范围，以提高仪表板管理效率。
2. [模板变量](../scene/visual-chart/chart-link.md#time)调整：新增 `#{startTime}`、`#{endTime}` 两个时间变量，支持获取到当前图表实际查询时间，可在图表查询、图表链接中应用此变量。
3. 日志流图显示列优化：日志流图的显示列若为 `@json` 格式切出字段，可对此字段设置单位，以统一图表数据的查看和分析体验。
4. 平台图表配色升级：平台图表配色得到升级，提供更佳的视觉效果。
5. 跨工作空间查询：所有图表内的表达式查询功能现已支持跨工作空间查询。

#### 管理

1. 黑名单功能增强：支持对所有数据类型的数据来源进行全选、单选、多选配置。
2. 自建索引/敏感数据扫描/数据转发：为优化数据处理和写入性能，涉及功能规则配置过滤条件去掉 ”match“ 和 ”not match“ 匹配模式。


#### 事件

1. [未恢复事件查看器](../events/event-explorer/unrecovered-events.md)优化：
    - 优化批量操作交互，新增**一键勾选当前页**和**一键勾选全部**选项，支持快速恢复当前选中的异常事件；
    - 手动恢复产生恢复后，OK 事件标题显示优化。

#### 基础设施

1. 资源目录优化：资源目录支持自定义资源分类图标，提供丰富的图标选择，以提升用户体验。

### Bug 修复 {#bug1016}

1. 解决了英文版集成无法搜索的问题。
2. 解决了 RUM 快照分享无法访问的问题。
3. 解决了组合监测 A&&B 不生效，A||B 生成的 Result 只有 A 的值，没有B的值的问题。
4. 解决了视图设置主从时匹配空值失败的问题。
5. 解决了排行榜图表展示的数据中只能保留 2 位小数，实际数值较小的数据直接被四舍五入丢弃的问题。
6. 解决了定时报告仪表板邮件显示不全的问题。
7. 解决了开启连续触发判断次数大于 10 次时无法保存的问题。
8. 解决了 APM 和日志迁入底座后数据无法聚合的问题。
9. 解决了管理后台同时开启本地和 LDAP 登录方式，前台只显示本地登录的问题。
10. 解决了可用性监测无数据的问题。
11. 解决了日志导出没有 `message` 内容这一列的问题。
12. 解决了日志排序异常的问题。
13. 解决了日志查看器中选择多索引就不显示上下文日志的问题。
14. 解决了 Grafana 图表转换工具转化效率兼容性低的问题。
15. 解决了可用性检测 > 数量统计配置时，添加的字段在输入框外的问题。
16. 解决了存储日志监控器获取不到检测维度的问题。
17. 解决了异常追踪配置 Issue 发现后在产生异常事件后没有产生 Issue 的问题。
18. 解决了仪表板视图变量下拉列表不支持关键字查询的问题。
19. 解决了文本无法正常写入 Doris 排查的问题。
20. 解决了同一时间段事件状态数量会变的问题。
21. 调整角色查询逻辑，解决了角色数量超出 100 时搜索不到的问题。


更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.95.177（2024 年 10 月 11 日） {#1.95.177}

pubrepo.guance.com/dataflux/1.95.177:launcher-0251748-1728623509

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.95.177.tar.gz
    - MD5: `a288172615e91267406fcda748f38e12`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.95.177.tar.gz
    - MD5: `fe8e78f55b5749abe2cf033d425f6586`

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 彻底移除 MessageDesk 组件，所有消息通过 Func 组件发送。升级此版本时注意将邮件服务信息配置到 Func 服务中，参考文档 [配置邮件服务](../deployment/configuration-mail.md)。

### BUG 修复 {#bugs.1.95.177}

- 修复一些安全问题。


## 1.95.176（2024 年 09 月 25 日） {#1.95.176}

pubrepo.guance.com/dataflux/1.95.176:launcher-b57597e-1727582952

### Breaking Changes {#breakingchanges0925}

拨测标签：字段名由 `tags.info` 调整为 `df_label`。

### 部署版更新 {#deployment0925}

1. [Datakit 管理](../deployment/setting.md#datakit)支持筛选在线主机：支持筛选最近 10 分钟、最近 15 分钟、最近 30 分钟、最近 1 小时、最近 3 小时内有数据上报的主机。
2. 管理后台：
    - 空间存储类型为“火山引擎”时，支持配置热数据保留时长。
    - 新建工作空间文案和交互优化，默认主引擎只有一个选项时用户无需额外指定。
3. 平台配色模板增强：支持定义导航栏及导航文字显示颜色配置。
4. License 使用和过期提醒：针对 License 即将到期、已过期和使用超量等状态新增控制台全局提示；针对平台组件版本升级新增控制台全局提示。

### 功能更新 {#feature0925}

#### 场景

1. 仪表板新增[历史版本记录](../scene/dashboard/history-version.md)：可查看此仪表板三个月内保存的版本记录，选中某版本后，可查看此版本图表详情，并以 JSON 格式、通过不同颜色标记选中版本的变更内容。
    - 支持将当前仪表板还原至选中的历史版本；
    - 支持克隆仪表板某个版本。
2. [自定义查看器](../scene/explorer/custom-explorer.md)支持变更显示列顺序：自定义查看器编辑配置时，可拖拽所选字段变更字段展示顺序。

#### 监控

监控器新增自定义操作权限：配置操作权限后，仅被赋予权限的对象可对此监控器进行启用/禁用、编辑、删除操作。

- 注意：若未配置操作权限，则监控器权限跟随“监控器配置管理”默认权限。

#### 用户访问监测

1. 会话重放增强：移动端上线会话重放功能，支持移动端应用通过会话重放的方式回溯用户行为轨迹、定位使用问题。
2. 数据访问增强：用户访问新增[数据访问](../real-user-monitoring/rumdata_access.md)功能，支持针对应用级别配置数据查看范围，精细化管理成员数据查询边界。

#### 管理

1. 跨空间授权优化：将登录空间的定义更新为“当前空间”，以简化用户在不同空间间的操作。
2. [数据转发规则](../management/backup/index.md)支持指定存储目录：存档类型为 AWS S3、华为云 OBS、阿里云 OSS时，支持将数据转发到存储桶下的对应目录中，帮助更好地管理转发数据。
    - 注意：请谨慎变更存储路径，由于更新配置存在 5 分钟左右的延迟，变更后可能会有部分数据依然转发到原目录下。
3. 数据转发查看器优化：
    - 时间控件调整：调整为查看器通用时间控件，可获取精确到分钟的转发数据。
    - SLS query logstore 数据存储位置调整：“数据转发”不再保留 SLS query logstore 的数据，可在“日志查看器”中查询。

#### 可用性监测

标签格式若为 `key:value`，在结果中会将 `key` 值提取到一级字段。

- 注意：若自定义的标签 key 值与其他拨测结果属性值重复，则做丢弃操作。

#### 基础设施

1. [资源目录](../infrastructure/custom/index.md)功能增强：优化了资源目录架构，支持用户自定义资源查看器模板，并提供列表和蜂窝图两种视图模式，以提升资源数据的查看和分析体验。
2. 容器交互优化：容器及 K8s 基础设施查看器切换查看时，筛选、搜索条件保留不重置。

### 帮助中心 {#helpcenter0925}

整合了帮助中心页面，允许用户通过统一入口访问所有[集成列表](../integrations/integration-index/)，并支持搜索及标签过滤功能，以提高查找效率。

### Bug 修复 {#bug0925}

1. 解决了视图中 PromQL 查询结果设置规则映射不生效的问题。
2. 解决了主机存活告警 v2 监控器偶发无法恢复的问题。
3. 解决了仪表板定时报告发送到邮件时，报告中仪表板打开失败的问题。
4. 解决了使用 OpenAPI 创建的拨测任务无法修改的问题。
5. 解决了付费计划中 PV 统计量和费用详情里的 PV 数量不一致的问题。
6. 解决了 Webhook 添加用户信息后未携带手机号码的问题。
7. 解决了视图变量的取值和仪表板中的取值不一致的问题。
8. 解决了共享工作空间的首页数据显示问题。
9. 解决了数据授权空间中，模板变量值下拉框获取的数据与实际获取的数据对不上的问题。
10. 解决了时序表格图在仪表板中时常加载不出来数据的问题。
11. 优化了若干页面显示问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.94.175（2024 年 09 月 19 日） {#1.94.175}

pubrepo.guance.com/dataflux/1.94.175:launcher-6a2027e-1726630662

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 对 OceanBase 数据库的兼容性优化调整

### BUG 修复 {#bugs.1.94.175}

- 将未恢复事件列表的获取逻辑修改为按被监控对象的维度，列出所有未恢复的事件。


## 1.94.174（2024 年 09 月 04 日） {#1.94.174}

pubrepo.guance.com/dataflux/1.94.174:launcher-923b174-1725591807

### 功能更新

#### 日志

1. 日志查看器新增交互：长按 Ctrl 可针对查看器列表文本分词进行 “添加到查询”、“从查询中排除”、“复制” 操作，便捷目标数据的快速查询追加。同理日志详情页内容区域也支持此交互。
2. 日志支持绑定[火山引擎 TLS 外部索引](../logs/multi-index/tls.md)：可绑定外部索引，在观测云平台直接查看及分析火山引擎日志数据。
3. 日志 > [数据访问](../management/logdata-access.md)优化：
    - 新增数据访问导航页，页面右上角新增帮助文档跳转链接；
    - 数据访问规则新增【名称】字段为唯一性 ID，新增规则【描述】字段，可自定义名称及描述以区分规则使用场景。
4. 日志查看器筛选项优化：日志查看器列表【日志索引】筛选项支持搜索，可关键字搜索索引并进行勾选。
5. 日志[状态自定义](../logs/manag-explorer.md#status-color)：支持自定义日志状态值，并在控制台中为每个状态值设置颜色，适应不同的日志接入场景，同时使日志的状态显示更加个性化和直观。


#### 场景

1. 新增图表类型[热力图](../scene/visual-chart/heatmap_scene.md)：用户可以通过颜色深浅直观地查看数据的分布和趋势，帮助更好地理解数据。
2. [图表链接重定向跳转](https://www.guance.com/learn/articles/Chart-Links)：联动 Function 函数结合仪表板数据实现链接重定向跳转。  
3. [告警统计图表](../scene/visual-chart/alert-statistics.md)组件升级：更换列出逻辑，新版本的告警统计图列出效果同未恢复事件查看器一致，统一用户查看体验。      
    - 注意：跨工作空间列出情况下不支持 “创建 Issue” 和 “手动恢复” 操作。   
4. 分组表格图自定义显示列：在分组表格图中，新增自定义显示列功能，支持对返回的列设置显示或隐藏，提供更灵活的数据展示方式。
5. 图表跨空间授权查询交互优化：开启空间授权功能后，可以直接在查询上方选择被授权的空间列表，操作更加直观和便捷。

#### 异常追踪

异常追踪 Issue 和监控器事件：内容若存在 `@ 成员`配置，则通过 Webhook 对外传递时 Issue 或事件会同步携带 `@成员`的账号属性信息。

#### 监控

1. 外部事件检测：支持自定义事件发生时间和标签属性追加。注意：
    - 字段值统一使用字符串类型；
    - 字段名称不支持以 `_` 下划线和 `df_` 前缀开头且不能与当前事件默认字段重名；
    - 自定义标签字段名不能与 `dimension_tags` 内定义字段名重名。
2. 名词调整：“无数据” 正式更新为 “数据断档”，保证页面配置查看体验统一。

#### Pipeline

将拨测数据和日志数据分离处理，并新增“可用性拨测”数据类型。避免在数据处理时的相互干扰，确保数据处理的准确性和效率。

注意：仅中心 Pipeline 支持“可用性拨测”数据类型，且拨测节点的 DataKit 版本必须 >= 1.28.0。

#### 其他

1. 工作空间列表显示优化：针对列表操作栏，新增显示创建人头像鼠标悬浮提示创建人、创建时间、更新人、更新时间；同时对操作项整体显示进行优化。
2. 列表新增跳转审计事件：列表操作栏新增审计事件跳转链接，点击可跳转查看对应审计事件。
3. 账号管理显示调整：单点登录用户【账号管理】菜单下不显示密码项。


### Bug 修复 {#bugs0904}

1. 解决了本地 Function 函数做为数据源 查询时时间范围未联动时间控件问题。
2. 解决了 PromQL 数据查询结果 展示顺序不正确的问题。
3. 解决了监控器和图表查询 的筛选组件不统一的问题。
4. 解决了从异常追踪入口点击智能监控的相关事件会在非智能监控事件列表中显示导致无查询结果的问题。
5. 解决了飞书异常追踪 Webhook 集成无数据、无回调的问题。
6. 解决了万进制单位显示数字的问题。
7. 解决了查看器分析模式下，添加筛选条件时无法搜索字段的问题。
8. 解决了从监控事件创建 Issue 无来源链接的问题。
9. 解决了日志导出到 CSV 失败的问题。
10. 解决了未收到高消费预警邮件通知的问题。
11. 解决了异常追踪切换频道，Issue 的列表无变化的问题。
12. 解决了日志索引 a、b 存在相同字段名(忽略大小写)时，日志查看器中勾选索引 a、b 出现报错 的问题。

### 部署版更新

1. 图表自定义返回数量：时序图、饼图、表格图、排行榜、矩形树图和地图支持自定义返回数据的数量，无最大限制，以满足不同的数据展示需求。
2. 管理后台 > Datakit 管理，支持导出 Datakit 清单。



更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.93.173（2024 年 8 月 21 日） {#1.93.173}

pubrepo.guance.com/dataflux/1.93.173:launcher-d71b2c4-1724400267

### 观测云部署版更新

- 优化了 Launcher 安装引导工具，在安装结束时，显示存储引擎与系统工作空间的初始化状态。

### Breaking Changes {#breakingchanges0821}

- OpenAPI / 全局 API：【事件】未恢复事件数据源从 `UE` 变更为 `E`。


### 新增功能 {#new0821}

- 管理：新增 [Client Token](../management/client-token.md) 统一管理入口，用户使用公网 DataWay 接入 RUM 应用时，可更换系统默认生成的 Token，使用自定义创建的 Token。

![](img/overall-token.png)


### 持续优化 {#consistent0821}

- 异常追踪：
    - 新增 [Issue 发现](../exception/config-manag/issue-discovery.md)页面。通过这一功能，您可以定制 Issue 发现的具体规则，对监控器检测规则触发的异常事件和相关数据进行统一管理和筛选。将一系列事件视为由单一原因引起，并为这些事件设置筛选条件，然后选择聚合维度来进一步细化数据。细化后，数据会根据您设定的检测频率进行聚合。最终，系统会根据您预设的 Issue 标题和描述，自动将这些信息推送到指定的频道，确保所有相关方都能及时接收并有效处理这些 Issue。
    - 配置管理 > 通知策略：通知策略列表新增创建/更新的信息显示。


### 常规更新 {#usual0821}

- 数据保存策略：
    - 原【应用性能】项拆分为【应用性能-链路】、【应用性能-Profile】，支持用户分别配置 Trace 数据和 Profile 数据的保存策略；
    - 原【数据转发】名称修改为【数据转发-观测云】。
- 监控 > 通知对象管理：连续一天发送失败会发系统通知；连续两天发送失败会发系统通知且自动禁用。
- [未恢复事件查看器](../events/event-explorer/unrecovered-events.md)：
    - 数据源变更为查询事件数据，以 `df_fault_id` 作为唯一标识进行聚合，获取最近一条数据结果返回展示。
    - 页面整体 UI 改造。
- 应用性能监测（APM）> 链路：[服务调用关系图](../application-performance-monitoring/explorer/explorer-analysis.md#call)新增绑定内置视图能力，点击服务的卡片，即可快速查看与该服务关联的相关用户视图。
- 管理：
    - 新增【工作空间描述】；
    - 编辑模式下，交互变更为打开新窗口；
    - 工作空间列表下支持通过工作空间的名称或描述来搜索定位。
- 日志 > BPF 日志 > 七层 BPF 网络日志：网络请求拓扑图 UI 优化，突出了服务端与客户端的区分。
- 可用性监测 > HTTP 监测 > 高级设置 > 请求设置默认添加 `Accept-Encoding:identity`。
  
### 部署版更新

- 新增[拨测节点管理](../deployment/task.md)入口，支持创建平台级别拨测节点，并通过节点列表统一管理所有节点。通过此入口创建的拨测节点支持配置中英文节点名，从而适配观测云的国内外站点显示和上报数据结果内容。

![](img/task.png)

- 数据保存策略：

    - 考虑到用户处于存储成本等因素的考量，需要自定义这些数据的保存时长，部署版管理后台新增【会话重放】配置项。
    - 原【数据转发】名称修改为【数据转发-默认存储】；
    - 原【应用性能】项拆分为【应用性能-链路】、【应用性能-Profile】，支持用户分别配置 Trace 数据和 Profile 数据的保存策略；
- 支持火山引擎 TLS 做为底层数据存储引擎。

### BUG 修复 {#bugs0821}

- 解决异常追踪的通知策略未生效的问题；
- 解决应用性能监测链路追踪导出异常的问题；
- 解决通过 OpenAPI 修改通知对象报错无权限配置显示的问题；
- 解决日志查看器重新设置时间范围后不能自动获取 `source` 筛选的问题；
- 解决查看器搜索栏已添加 `source` 筛选条件范围，但在“快捷筛选”中依旧显示过滤条件外的全部 `source` 的问题；
- 解决突变检测报错的问题；
- 解决通过 OpenAPI 写入数据访问规则后，UI 页面打开无法查看角色信息的问题；
- 解决图表设置的数据格式对图例中数据不生效的问题；
- 解决自建拨测节点下，关联的拨测任务删除后，实际拨测还在运行的问题。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.92.172（2024 年 08 月 07 日） {#1.92.172}

pubrepo.guance.com/dataflux/1.92.172:launcher-c46a1c6-1723477272

### 新增功能 {#1.92.172.new}

- 用户访问监测（RUM）：新增[热图](../real-user-monitoring/heatmap.md)。以视觉方式呈现访客与网站的互动情况，获取页面元素的点击数据和点击位置，了解用户的关注点。

- 应用性能监测（APM） > 链路：新增[安装引导](../application-performance-monitoring/explorer/index.md)页面。

- 监控：新增检测类型——[区间检测 V2](../monitoring/monitor/interval-detection-v2.md)，以检测指标的的历史数据建立的置信区间来预测正常波动范围。

### 持续优化 {#1.92.172.consistent}

- 异常追踪:
    - 配置管理 > 通知策略：新增[操作审计和执行日志](../exception/config-manag.md#check-events)查看入口。在接收 Issue 通知时，有时会遇到通知未正常发送或针对通知策略有疑议，此时可查看当前通知策略的操作审计事件和执行日志数据来进行判断。
    - APM / RUM [Issue 自动发现](../application-performance-monitoring/error.md#issue)支持添加筛选条件；
    - 针对部署版，新增[统一管理异常追踪等级](../deployment/setting.md#global-settings)入口；
    - 日程：
        - 在日程编辑页面，不同的通知对象会自动生成颜色；
        - 日程管理：【我的日程】与【所有日程】新增统计数量；

### 常规更新 {#1.92.172.usual}

- 监控 > [SLO](../monitoring/slo.md#slo)：
    - 新增标签配置，最终作用到产生的事件数据信息内；
    - 配置优化：通过设置【目标】和【最低目标】的 7 天达标率范围，判断生成警告或紧急事件；
    - 支持通过关联【告警策略】实现告警通知发送。
- 可用性监测：
    - 拨测任务新增标签配置；
    - 配置拨测任务页面的[测试模块](../usability-monitoring/request-task/http.md#test)优化；
    - 列表新增[快捷筛选](../usability-monitoring/request-task/index.md#manag)模块；
- 查看器：分析模式下支持导出 CSV 文件。
- 基础设施 > 容器：新增进程关联页面展示。

### BUG 修复 {#1.92.172.bugs}

- 解决【任务调用】计费统计次数未显示的问题；
- 解决图表查询时【左 * 匹配】问题；
- 解决 BPF 网络日志返回数据未包含容器等相关信息的问题；
- 解决中心 Pipeline 失效问题。 

### Breaking Changes {#1.92.172.breakingchanges}

- OpenAPI：
    - SLO 创建/修改接口新增 `tags`、`alertPolicyUUIDs` 并弃用 `alertOpt` 参数；
    - SLO 获取详情和列表接口返回结果中新增 `tagInfo`、`alertPolicyInfos` 字段，丢弃了 `alertOpt` 字段。


更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.91.171（2024 年 07 月 24 日） {#1.91.171}

pubrepo.guance.com/dataflux/1.91.171:launcher-c365f0b-1721884985

### 观测云更新

- 异常追踪：
    - 新增[分析看板](../exception/issue-view.md)：可视化展示不同指标数据。
    - 新增[日程](../exception/calendar.md)管理和[通知策略](../exception/config-manag.md#notify-strategy)：对 Issue 的内容范围做进一步通知分配。
- 场景：
    - 图表：新增[时间偏移](../scene/visual-chart/timeseries-chart.md#advanced-setting)设置。启用时间偏移后，当查询相对时间区间时，实际查询时间范围向前偏移 1 分钟，以防止入库延迟导致数据获取为空。
    - 仪表板：新增[历史快照](../scene/dashboard/config_list.md#history)入口。
    - 快照：保存快照时自动获取当前页面上选取的时间范围；分享快照时，可选择允许查看者更改时间范围。
- 监控：
    - 基础设施存活检测 V2：新增[附加信息](../monitoring/monitor/infrastructure-detection.md#config)。选定字段后，系统会做额外查询，但不会用于触发条件的判断。
    - 通知对象管理：新增【操作权限】选项配置，由开关控制通知对象的操作（编辑、删除）权限。


更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.90.170（2024 年 07 月 10 日） {#1.90.170}

pubrepo.guance.com/dataflux/1.90.170:launcher-3bbe7a1-1721136369

### 观测云部署版更新

> **注：如正在使用 message-desk 发送邮件服务，请将配置移植到 Func 服务中，查看 [如何配置](../deployment/configuration-mail.md)，下个版本将从系统中删除 message-desk 相关的服务，请务必在此版本移植相关配置。**

- 新增全局功能[菜单管理配置](../deployment/menu.md)，支持自定义控制台显示菜单范围，并同步至工作空间功能菜单栏。
- [模版管理](../deployment/integration.md)：自定义模板管理上传逻辑优化。
- 移除了对 message-desk（邮件、钉钉、企微、短信等通知发送）服务的依赖，功能已全部移植到 Func 服务中

### 观测云更新

- 场景：
    - [视图变量](../scene/view-variable.md#add)：
        - 新增配置项开关：包含 * 选项。
        - 选择隐藏视图变量时，列表新增隐藏标识。
    - 仪表板：[分组](../scene/dashboard/config_list.md#group)组件支持配置颜色。
    - 图表：别名功能覆盖排行榜、矩形树图、桑基图。
    - 仪表板/查看器/内置视图：新增[卡片属性](../scene/)信息，优化编辑配置。
- 监控：
    - 通知对象管理：配置 [Webhook 通知对象](../monitoring/notify-object.md#custom-webhook)，支持追加成员信息。
    - 应用智能检测：新增追踪历史变化，过滤周期性的异常数据突变；新增异常服务关联影响的用户数。
- 事件 >[ 事件列表查看器](../events/event-explorer/event-list.md)：显示列新增告警通知状态标识。
- 日志：
    - 索引：绑定 [SLS 外部索引](../logs/multi-index.md#sls)时，新增访问类型选择，支持自定义公网访问或者内网访问；
    - 日志查看器：[聚类分析](../logs/explorer.md#cluster)模式下，支持导出显示列数据及关联日志页面数据。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.89.169（2024 年 06 月 26 日） {#6.26}

pubrepo.guance.com/dataflux/1.89.169:launcher-d482589-1720014392

### 观测云部署版更新

> **注： 此版本依赖 GuanceDB v1.8.1 版本，升级前请先升级 GuanceDB for metrics 和 GuanceDB for logs 引擎到 [v1.8.1](https://static.guance.com/guancedb/guancedb-cluster-linux-amd64-v1.8.1.tar.gz) 或以上版本。**

- Profile：通过配置参数，支持文件存储和对象存储两种方式。 
- Launcher: 支持在部署时直接选择使用 Doris 引擎。

### 观测云更新

- [Pipelines](../pipeline/index.md)：支持选择中心 Pipeline 执行脚本。
- 付费计划与账单：新增[中心 Pipeline 计费项](../billing-method/index.md#pipeline)，统计所有命中中心 Pipeline 处理的原始日志的数据大小。
- 监控
    - 通知对象管理：新增[权限控制](../monitoring/notify-object.md#permission)。配置操作权限后，仅被赋予权限的对象可对此通知对象进行编辑、删除操作。
    - 智能监控 > 日志智能检测：新增追踪历史变化，过滤周期性的异常数据突变。
- 日志 
    - [数据访问](../management/logdata-access.md#config)：新增对被授权查看的日志索引做访问权限配置。
    - 日志查看器：显示列拓展，支持[添加 json 对象内字段内容](../logs/manag-explorer.md#json-content)到一级返回显示。
    - [BPF 网络日志](../logs/bpf-log.md)：
        - 连接展示效果优化；
        - 支持直接跳转至详情页；
        - 支持自定义添加显示列。
- 场景
    - 时序图：折线图、面积图新增[断点连接](../scene/visual-chart/timeseries-chart.md#breakpoint)设置，柱状图新增【显示返回值】按钮。
- [可用性监测](../usability-monitoring/request-task/index.md#manag)：任务列表新增表头排序。
- DataFlux Func：支持观测云异常追踪脚本[集成钉钉应用](https://func.guance.com/doc/script-market-guance-issue-dingtalk-integration/)。


更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.88.168（2024 年 06 月 13 日） {#1.88.168}

pubrepo.guance.com/dataflux/1.88.168:launcher-92bbf83-1718688126

### 观测云部署版更新

Profile：文件大小由原先的固定 5MB 修改为支持自定义，点击查看[如何配置](../deployment/application-configuration-guide.md#studio-front)。

### 观测云更新

- [BPF 网络日志](../logs/bpf-log.md)：优化 BPF 网络功能，增强 L4/L7 网络联动。
- APM/RUM：新增 【[Issue 自动发现](../application-performance-monitoring/error.md#issue)】功能。启用该配置后，观测云会将符合配置项规则的错误数据记录自动创建 Issue。
- 监控
    - 智能监控：新增 [Kubernetes 智能检测](../monitoring/intelligent-monitoring/k8s.md)：通过智能算法自动检测 Kubernetes 中的异常，检测指标包含 Pod 总数，Pod 重启，APIServer QPS 等。
    - 告警策略管理：
        - 新增[过滤](../monitoring/alert-setting.md#filter)功能。在进行告警规则配置时，该功能允许在原有等级基础上增加更细致的过滤条件，仅匹配等级+过滤条件的事件才会发送给对应的通知对象。
        - 支持选择外部邮箱做为通知对象。
    - 监控器 > 事件内容：支持自定义输入外部邮箱。
- 场景
    - 拓扑图：新增链接配置。
    - 桑基图：由原先支持最多 4 个节点配置改为 6 个。
- Pipeline：列表新增过滤条件显示。
- 日志 > 索引：列表显示优化。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.87.167（2024 年 06 月 05 日） {#1.87.167}

pubrepo.guance.com/dataflux/1.87.167:launcher-135ba54-1718086022

### 观测云更新

- **管理 > [跨工作空间授权](../management/data-authorization.md#site)**：添加页面新增【数据范围】，支持多选数据类型。
- **日志 > 日志查看器**：支持[跨工作空间索引查询](../logs/cross-workspace-index.md)，快速获取其它空间的日志数据，从而突破日志数据存储位置的限制，大幅度提升数据分析和故障定位的效率。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.86.166（2024 年 05 月 29 日）

pubrepo.guance.com/dataflux/1.86.166:launcher-edb908f-1717137436

### 观测云部署版更新

- [模版管理](../deployment/integration.md)：新增导入模版入口，模版范围包括视图模板、监控器模板、自定义查看器模板、Pipeline。支持部署版用户将自定义模板变更为平台级别模板供其他工作空间使用。
- 用户管理：批量操作交互优化。
- 支持部署时开启内部服务的 HTTPS（Beta 版）

### 观测云更新

- [DCA](../dca/index.md)
    - 支持私有化部署，可直接通过工作空间页面按钮前往 DCA 控制台。
    - 支持批量管理功能。
- 异常追踪：
    - Webhook 接收通道：支持 Issue 回复的新增、修改通知；
    - 支持选择团队或添加外部邮箱为 Issue 负责人。
- 日志 > [上下文日志](../logs/explorer-details.md#up-down)：查询逻辑修改；支持通过日志上下文详情页对相关数据作进一步查询管理。
- 场景
    - 视图变量：分组标题/图表标题支持配置 `#{视图变量}` 显示。
    - 时序图 > 分析模式：支持调整时间间隔 interval。
    - 仪表板/自定义查看器：当标签数量超过 20 个时，显示搜索框；标签名前显示颜色。
- 监控
    - 监控器/智能监控/静默管理 > 快捷筛选：当值超过 20 个时，出现搜索框，支持搜索定位。
    - 监控器：针对 PromQL 查询检测，事件通知中自动列出可使用的模板变量。
- 基础设施 > 网络：网络详情页 > 网络分析支持 `ip:端口` 和 `ip` 两种维度统计列出展示。
- 应用性能监测 > 服务 > 新建/修改服务清单：填写仓库链接、文档链接时增加格式校验。

#### Breaking Changes

- 管理 > 属性声明：自定义属性字段值调整为字符串类型进行存储。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.85.165（2024 年 05 月 24 日）

pubrepo.guance.com/dataflux/1.85.165:launcher-6462e65-1716477657

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 修复使用自定义镜像仓库时，仓库地址中如包含多层目录名时无法正确构建出服务镜像地址的 bug
- 修复其他的一些小 bug

## 1.85.164（2024 年 05 月 15 日）

pubrepo.guance.com/dataflux/1.85.164:launcher-0f0b2bb-1716275675

### 观测云部署版更新

> **注： 此版本依赖 GuanceDB-Logs v1.6.1 版本，升级前请先升级 GuanceDB-Logs 引擎到 [v1.6.1](https://static.guance.com/guancedb/guancedb-cluster-linux-amd64-v1.6.1.tar.gz) 或以上版本。**

- 新增 [DataKit 清单管理](../deployment/setting.md#datakit)页面。
- 部署版配置单点登录对接时，支持自定义登录[显示标题、描述和 logo](../deployment/azure-ad-pass.md#config)。
- [用户](../deployment/user.md#edit)：新增扩展属性配置。
    - 支持本地用户直接在编辑页面配置属性。
    - 支持单点登录时默认自动将第三方用户属性配置通过 userinfo 接口追加到观测云。

### 观测云更新

- 监控 
    - 监控器 > [突变检测](../monitoring/monitor/mutation-detection.md) > 检测指标：支持环比上期选项，从而实现某个固定时间段内的数据进行最终比较。
    - [静默管理](../monitoring/silent-management.md)：新增【附加信息】功能，支持针对静默规则添加解释说明，从而标识静默的原因或者来源等信息。
    - 智能监控 > 主机智能监控：新增网络流量、磁盘 IO 两项检测维度。
- 场景 > 仪表板：
    - [视图变量](../scene/view-variable.md)：编辑页面样式优化，支持定义下拉单选、多选。
    - 分组表格图、指标分析 > 表格图支持多列查询结果显示适配，如 
```
L::RE(`.*`):(count(*),message,host) {index = 'default' and status = 'error'} BY source,service
```
- 查看器：
    - 日志查看器 > [上下文日志](../logs/explorer-details.md#up-down)支持微秒级的数据查询过滤，解决出现同一时刻（毫秒）有多条数据，导致不能命中定位显示某条日志上下文的问题。
    - 所有查看器支持选择[导出](../getting-started/function-details/explorer-search.md#csv)数据量为 CSV 文件。
    - 新增查看器搜索查询审计事件，即由用户手动发起的查询操作会计入审计事件记录。
- 服务管理：由原来所属的路径【场景】迁移至【应用性能监测】，优化使用体验。
- 生成指标：支持配置多个 by 分组，不做数量限制。
- DQL 查询：表达式查询支持指定值填充，支持针对子查询做结果填充和最终值填充。
- 用户访问监测 > Android：应用配置显示优化。
- 事件：新增详情页关联查看跳转入口。在不存在检测维度数据的情况下，可在详情页跳转查看器查看。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.84.163（2024 年 04 月 24 日）

pubrepo.guance.com/dataflux/1.84.163:launcher-4606a02-1714100180

### 观测云部署版更新

- 管理 > 基本信息 > License 信息：DataKit 数量限制支持按照数据统计范围调整，变更为存活时间 >= 12 小时以上的主机或 DK 数量。
- 支持配置黑名单，自定义选择导入观测云集成、视图模板、监控器模板范围。

### 观测云更新

- 管理：
    - 新增[云账号管理](../management/cloud-account-manag.md)：将企业所有的云服务账号集中起来进行统一管理，并借由账号下某些配置的唯一性来进行区分。通过配置集成采集器，针对每个账号下的云服务进行独立管理，从而实现对业务数据的精细化控制。
    - 账号管理：[账号登录过期时间](../management/index.md#login-hold-time)调整。
- 新增[快速搜索](../management/index.md#quick-entry)弹窗，可快速查看当前工作空间内最近访问的页面和其他各功能相关页面。
- 基础设施 > 容器：新增 [Statefulset](../infrastructure/container.md#statefulset)、[Persistent Volumes](../infrastructure/container.md#persistent-volumes) 两种对象查看器。
- 异常追踪：
    - 新增 Issue 负责人配置，观测云会为负责人发送邮件通知。
    - 频道管理：支持[升级配置](../exception/channel.md#upgrade)。即，设置新 Issue 超过某特定分钟数时，若未指定负责人，则发送升级通知给对应的通知对象。
- 监控 > [静默管理](../monitoring/silent-management.md)：静默规则列表页展示优化：支持列出当前工作空间所有静默规则，可通过快捷筛选快速过滤列出目标规则。
- DQL `match` 函数的含义变更为`完全匹配`。此变更仅针对新引擎，分别应用查看器、监控器这两个场景。
    - 查看器场景示例：`host:~cn_hangzhou`。
    - 监控器场景示例：
    ```
    window("M::`cpu`:(avg(`load5s`)) { `host` = match('cn-hangzhou.172.16.***') } BY `host`", '1m')
    ```
- 场景 > 仪表板[图表](../scene/visual-chart/index.md#download)可直接下载为 PNG 图片，表格图还可导出为 CSV 文件。
- 日志 > 绑定索引：【字段映射】更改为非必填项。
- 集成/内置视图：模版新增标签管理。
- Service Map 跨工作空间节点[样式显示调整](../application-performance-monitoring/service-manag/)。

### OpenAPI 更新

- Pipelines [新增](../open-api/pipeline/add.md)/[修改](../open-api/pipeline/modify.md)：新增 profiling 类型；
- 用户视图[新增](../open-api/inner-dashboard/add.md)/[修改](../open-api/inner-dashboard/modify.md)：支持绑定仪表板配置。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.83.162（2024 年 04 月 17 日）

pubrepo.guance.com/dataflux/1.83.162:launcher-2fcb2e4-1713337267

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 修复部分服务镜像在 ARM64 架构下的打包问题
- 修复安装程序（Launcher）在全新部署观测云时，可能碰到的 Kubernetes Secret 创建失败的问题
- 修复一些其他小 Bug

## 1.83.161（2024 年 04 月 10 日）

pubrepo.guance.com/dataflux/1.83.161:launcher-a44ccb3-1713091048

### 观测云部署版更新

- 工作空间管理：新增[数据上报限制](../deployment/space.md#report-limit)，帮助利益相关方节约资源等使用成本。
- 安全性提升：
    - 新增管理后台管理员账号首次登录强制密码更改，提升平台账号安全性。
    - 安装程序（Launcher）默认将所有服务的 MySQL 连接信息放到 Kubernetes Secret 中，通过环境变量方式映射到服务中。

### 观测云更新

- 监控 > 监控器 > 新建：新增【数据断档】、【信息生成】配置区域，以便更好地区分异常数据和数据断档情况。
- 管理：新增[系统通知](../management/index.md#system-notice)页面，可查看当前账号下的工作空间所有配置的异常状态消息。
- 场景：
    - 图表查询：新增 [Rollup 函数](../dql/rollup-func.md)，该函数同样适用于【指标分析】与【查询工具】；
    - 仪表板/用户视图：新增 [pin 钉住](../scene/dashboard/config_list.md#pin)功能。在当前访问工作空间被授权查看若干其他工作空间数据的前提下，支持将查询其他工作空间数据设为默认选项。  
    - 系统视图：支持克隆创建为仪表板或者用户视图；
    - 自定义查看器：优化搜索模式；非编辑模式下，hover 在【数据范围】即可查看所有筛选条件。
- 查看器 > [快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)：
    - 新增【维度分析】按钮，点击后可快速切换到查看器分析模式；
    - 支持通过点击外部按钮直接将当前字段添加到显示列/从显示列移除。
- [体验版工作空间](../plans/trail.md#upgrade-entry) > 导航栏：新增【立即升级】按钮。
- 基础设施 > 容器 > 蜂窝图：新增 CPU 使用率（标准化）和 MEM 使用率（标准化）两种指标填充方式。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.82.160（2024 年 04 月 08 日）

pubrepo.guance.com/dataflux/1.82.160:launcher-f20b04d-1712582537

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复部分客户环境中，加入的工作空间列表无法搜索的问题。

## 1.82.158（2024 年 03 月 27 日）

pubrepo.guance.com/dataflux/1.82.158:launcher-c90f955-1711689089

### 观测云部署版更新

- 安全更新
- 数据保存策略：支持工作空间拥有者配置数据保存策略，且支持自定义输入保存时长。应用场景：
    - 指标管理 > 指标集；
    - 日志 > 索引 > 新建。
- 用户：支持[通过邮箱账号](../deployment/user.md#via-email)邀请成员。

### 观测云更新

- 监控：
    - 告警策略管理：每条通知规则（包含默认通知和自定义通知）配置新增[支持升级通知条件](../monitoring/alert-setting.md#upgrade)。
    - 监控器 > 事件内容：新增[自定义高级配置](../monitoring/monitor/threshold-detection.md#advanced-settings)，支持添加关联日志和错误堆栈；
    - 主机智能监控：将当前突变展示更改为基于周期以预测的方式进行异常告警，趋势图会展示当前指标及置信区间上下界，超出置信区间的异常会标红展示。
- 场景 > 图表：新增[拓扑图](../scene/visual-chart/topology-map.md)。
- APM > 链路详情页 > [服务调用关系](../../application-performance-monitoring/exp)：调整为服务拓扑展示，并展示服务与服务之间的调用次数。
- 数据保存策略：Session Reply 的数据保存策略与 RUM 的保存策略保持联动一致，即 RUM 数据保存 3 天，Session Reply 的数据也保存 3 天。
- 查看器：
    - 事件查看器 > 基础属性：新增检测指标是否显示配置，缓存到本地，全局适配；
    - APM > 错误追踪 > 聚类分析 > 详情页：支持创建异常追踪 Issue；
    - RUM > Error > 聚类分析 > 详情页：支持创建异常追踪 Issue；
    - RUM > View > 详情页：
        - 性能：新增【所有条目】选项，列出当前 View 下所有关联数据；
        - Fetch/XHR：点击数据行，支持打开对应链路详情页或 Resource 详情页。
    - 时间控件：获取 “当前时间” 时，精确到毫秒。
- 管理 > [工单管理](../management/work-order-management.md)：
    - 新增评星和评价；
    - 已反馈的工单需要调整为 7 天内无客户反馈则自动关单；
    - 支持工单列表导出；
    - 状态为【已完成】【已撤销】的工单可以进行重启操作；
    - 账号注销后其下提交的未关闭状态工单支持自动关闭处理。
- 云市场开通流程整体优化。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.81.157（2024 年 03 月 13 日）

pubrepo.guance.com/dataflux/1.81.157:launcher-14a874c-1710947837

### 观测云更新

- 监控 > 监控器：监控器类型【组合检测】上线。支持将多个监控器的结果通过表达式组合成一个监控器，最终基于组合后的结果进行告警。
- 场景 > 服务：支持跨工作空间 Servicemap 查询。

### 观测云部署版更新 

- 管理 > 基本信息：新增 “已用 DK 数量” 显示；
- 管理 > 用户：新增分组页面，基于组可配置关联工作空间及角色，用户可通过组获得对应工作空间的访问权限。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.80.156（2024 年 03 月 06 日）

pubrepo.guance.com/dataflux/1.80.156:launcher-3a2a6a9-1709822017

### 观测云部署版更新

- 新增登录方式选择，对登录方式进行统一管理；
- 增强部署时自动生成的 MySQL 业务数据库账号密码的强度；
- 针对本地账号和单点登录账号新增删除操作。

### 观测云更新

- 监控
    - 监控器 > 检测频率：新增 Crontab 自定义输入，满足仅需在特定的时间段执行检测的需求；
    - 突变检测：新增【最近 1 分钟】、【最近 5 分钟】的检测区间；
    - 静默管理：选择静默范围时“事件属性”为非必填项，可根据需要自行配置更细颗粒度的匹配规则。
- DataFlux Func：新增 Function 外部函数。允许第三方用户充分利用 Function 的本地缓存和本地文件管理服务接口编写函数，在工作空间内执行数据分析查询。
- APM > 链路：
    - Title 区域 UI 显示优化；
    - 针对火焰图、瀑布图、Span 列表超过 1 万的 Span 结果，支持通过偏移设置查看未展示 Span；
    - 新增 Error Span 筛选入口；支持输入 Span 对应的资源名称或 Span ID 进行搜索匹配。
- 场景
    - 图表：新增桑基图；
    - 视图变量：新增选中按钮，勾选后默认全选当前所有值，可按需再反选。
    - 账号管理：新增注销入口。
- 查看器：
    - UI 显示优化；
    - 筛选新增正则匹配 / 反向正则匹配模式；
    - Wildcard 筛选和搜索支持左 * 匹配。
- 事件 > 详情页：【告警通知】tab 页 UI 显示优化。

### DataKit 更新

- 新增功能
    - Datakit API 新增动态更新 Global Tag 的相关接口
    - 新增 Kubernetes PersistentVolume / PersistentVolumeClaim 资源的对象采集
    - 新增 Kubernetes dfpv（pv 使用率）指标和对象采集，需要添加额外的 RBAC
- 问题修复
    - 修复 SkyWalking RUM root-span 问题
    - 修复 Windows Event 采集不全问题
    - 修复 Pinpoint 采集中缺失 host 字段问题
    - 修复 RabbitMQ 指标采集问题
    - 修复 OpenTelemetry 老版本兼容性问题
    - 修复 Containerd 日志的分行解析错误
- 功能优化
    - StatsD 采集 count 类数据时，默认将其转换成浮点
    - 容器采集器支持 Docker 1.24+ 以上版本
    - 优化 SQLServer 采集器
    - 优化 Health Check 采集器
    - 日志采集的默认时间取值
    - 新增使用环境变量 ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB 关闭对 Kubernetes Job 资源的采集
    - 更新采集器内置视图：
    - ssh
    - etcd

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.79.155（2024 年 02 月 07 日）

pubrepo.guance.com/dataflux/1.79.155:launcher-df4a338-1707312493

### 观测云更新

- 修复一些小 Bug

## 1.79.154（2024 年 01 月 31 日）

pubrepo.guance.com/dataflux/1.79.154:launcher-26c05a5-1707056114

### 观测云部署版更新

- 工作空间管理 > 数据存储策略新增自定义选项，范围为<= 1800 天（ 5 年）；其中，指标新增可选项 720 天、1080 天等保存时长；在控制台中设置>编辑数据存储策略，修改保存后即可同步更新后台数据存储；
- 用户：支持为用户账号一键配置分配工作空间以及角色；
- 新增控制台审计事件查看入口，可快速查看所有工作空间相关操作审计；
- 新增【管理后台 MFA 认证】。

### 观测云更新

- 监控：
    - 智能监控：
        - 主机、日志、应用智能检测频率调整为每 10 分钟执行一次，每执行一次检测计算为 10 次调用费用；
        - 为提升算法精度，日志、应用智能检测采用数据转存的方式，开启一个智能监控后，会生成对应的指标集及指标数据。这一调整会产生额外的时间线，具体数量为为当前监控配置的过滤条件所过滤的检测维度数量(service、source) * 检测指标数量，由于没有对监控器的过滤条件进行存储，如果发生监控器过滤条件配置修改的情况，会生成新的等量时间线，所以在修改监控器过滤条件配置当日会有时间线重复计费的情况，修改后次日恢复正常。
    - 告警策略管理：
        - 新增自定义通知时间配置，按周期、时间区间细化告警通知配置；
        - 重复告警新增【永久】这一事件选项。
    - 监控器
        - 告警配置：支持配置多组告警策略；若配置多个，则 df_monitor_name 与 df_monitor_id 会以多个的形式呈现，并由 ";" 分隔开；
        - 联动异常追踪 Issue 改造：新增【事件恢复同步关闭 Issue】开关，当异常事件恢复时，则同步恢复异常追踪 Issue；
        - 监控器列表新增克隆按钮。
        - 通知对象管理：新增简单 HTTP 通知类型，直接通过 Webhook 地址接收告警通知；
- 场景：
    - 图表：单位新增【货币】选项；高级配置 > 同期对比更改为【同环比】；
    - 服务管理 > 资源调用：排行榜新增 TOP / Bottom 数量选择。
- 查看器：显示列设置新增【时间列】开关。
- 付费计划与账单：
    - 工作空间锁定弹窗页面新增新建工作空间入口，优化操作体验；
    - AWS 注册流程优化。

### DataKit 更新

- 新增功能
    - 新增主机 Health Check 采集器
- 问题修复
    - 修复 Windows Event 采集可能导致的崩溃问题
    - 修复数据录制功能问题并完善相关文档
    - 修复 DDTrace 多链路传播串联问题
    - 修复 Socket 日志采集截断问题
    - 修复 Datakit 升级时主配置文件残留问题
    - 修复更新脚本覆盖问题
- 功能优化
    - 优化主机安装中，Linux 非 root 安装时资源限制功能
    - 优化分流和黑名单匹配性能，大幅度（10X）减少内存消耗
    - Log Streaming 采集支持 FireLens 类型
    - Log Forward 采集日志中增加字段 log_read_lines
    - 优化 K8s 中对 tag cluster_name_k8s 的处理
    - K8s Pod 时序指标中增加重启次数（restarts）指标
    - 优化时序指标集 kubernetes，增加容器统计数
    - 优化 Kubelet 指标采集逻辑

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.78.153（2024 年 01 月 17 日）

pubrepo.guance.com/dataflux/1.78.153:launcher-54a571c-1706259428

### 私有部署版更新

- 部署工具 Launcher 支持中英文语言切换


## 1.78.151（2024 年 01 月 11 日）

pubrepo.guance.com/dataflux/1.78.151:launcher-fdacafd-1705323861

### 观测云更新

- 日志：
    - 新增 BPF 网络日志采集及日志详情页，支持 JSON 格式转化；详情页新增可读的展示模式；
    - 新增绑定【关联网络日志】；
- 数据访问：新增批量操作。
- 定时报告：新增可选分享方式【公开分享】或【加密分享】。
- 仪表板：
    - 视图变量新增【所有变量值】传参选项；
    - 时序图：新增排序逻辑（仅限新引擎），支持针对返回结果进行排序。
- 生成指标：支持批量操作；标准及以上权限成员支持克隆。
- 监控器：
    - 通知对象管理：适配新的钉钉机器人，创建时「密钥」选项非必填，快速关联钉钉机器人。
    - SLO 扣分逻辑优化。
- 用户访问监测（RUM）：公网 Dataway 支持 ip 转换成地理位置信息。

### DataKit 更新

- 新增功能：
    - Kubernetes 部署时支持通过环境变量（ENV_DATAKIT_INPUTS）配置任何采集器配置
    - 新增容器采集器 AS_TAG_V2 版本，支持更精细的配置 Labels 到 Tags
- 问题修复：
    - 修复容器采集器的 deployment 和 daemonset 字段偶发错误的问题
    - 修复容器日志采集在容器短暂运行并退出后，会丢失最后几行日志的问题
    - 修复 Oracle 采集器慢查询 SQL 时间错误
    - 修复 Prom 采集器 instance 设置问题
- 功能优化：
    - 优化 Prometheus Remote Write 采集
    - eBPF 采集支持设置资源占用
    - 优化 Profiling 数据采集流程
    - MongoDB 采集器支持用户名和密码单独配置
    - SQLServer 采集器支持配置实例名称
    - 优化 ElasticSearch 采集器视图和监控器
    - KafkaMQ 采集器支持多线程模式
    - SkyWalking 采集器增加支持 Meter 数据类型
    - 更新一部分采集器文档以及其他 bug 修复
    - 优化 Proxy 代理安装时的升级命令
    - 优化非 root 用户安装时资源限制功能

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.77.150（2023 年 12 月 28 日）

pubrepo.guance.com/dataflux/1.77.150:launcher-e2e6b96-1704173035

### 私有部署版更新

- 针对自动化任务队列，实施优化策略：将所有 Func worker 的队列分散到不同的 Deployment 中，以提升系统的分布式处理能力和效率。
- 支持外部平台嵌套观测云页面，可使用 URL 里的参数设置隐藏左侧和头部菜单栏、支持隐藏悬浮操作；
- 支持外部平台通过 iframe 嵌套观测云仪表板或查看器页面。

### 观测云更新

- 监控：
    - 新增用户访问智能检测：支持网站/ APP 的性能异常、错误分析,相关检测指标有 LCP、FID、CLS 等;
    - 基础设施存活检测 V2：新增基础设施存活 V2 版本，优化检测逻辑，解决 V1 和进程检测相关的若干触发问题。
- 应用性能监测 （APM）：
    - 优化服务拓扑图：调整查看上下游、节点、服务名等展示样式；
    - 优化服务详情：绑定性能视图仪表板展示当前服务性能指标，同样支持自定义同名用户视图覆盖更新，支持下钻分析；
    - 优化链路详情火焰图、瀑布图展示：火焰图新增执行时间和执行占比显示；瀑布图支持相对时间和绝对时间切换展示。
- 图表优化：
    - 时序表格图新增显示列配置：支持用户设置查询数据显示列，同时支持用户自定义手输列名；支持用户在编辑模式下手动调整列宽，保存后可根据列宽展示列表信息；支持拖拽调整显示列顺序；
    - 图表链接新增值变量做链接跳转使用。
- 仪表板：
    - 仪表板新增主页仪表板：支持工作空间配置主页仪表板；
- 基础设施：
    - 主机查看器新增仅显示在线主机开关过滤：获取主机在线列表逻辑优化，支持选择是否仅列出最近 10 分钟有数据上报的主机列表。

### DataKit 更新

- 新增功能
    - 新增 OceanBase 自定义 SQL 采集
    - 新增 Promremote 黑名单/白名单
    - Kubernetes 资源数量采集添加 node_name tag（仅支持 Pod 资源）
    - Kubernetes Pod 指标新增 cpu_limit_millicores/mem_limit/mem_used_percent_base_limit 字段
    - eBPF 采集器新增 bpf-netlog 插件
- 问题修复
    - 修复 external 采集器僵尸进程问题
    - 修复容器日志 tags 冲突问题
    - 数据 record 功能支持环境变量开启
    - 修复虚拟网卡信息获取失败问题
    - 修复 Pipeline Refer table 和 ipdb 功能失效问题
- 功能优化
    - 优化 DDTrace 和 OTEL 字段提取白名单功能
    - 优化 SQLServer 采集器的 sqlserver_lock_dead 指标获取 SQL
    - 优化 PostgreSQL 采集器的连接库
    - 优化 ElasticSearch 采集器的配置文件，设置 local 默认为 false
    - K8s 安装时增加更多 ENV 配置项
    - 优化 Datakit 自身指标暴露
    - 更新部分采集器集成文档

### 集成更新

- 新增集成 Kubecost

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.76.149（2023 年 12 月 20 日）

pubrepo.guance.com/dataflux/1.76.149:launcher-c15108e-1703085794

### 私有部署版更新

- 后台管理平台英文语言支持

## 1.76.148（2023 年 12 月 19 日）

pubrepo.guance.com/dataflux/1.76.148:launcher-696a3e0-1702992814

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- OpenApi 监控器告警策略相关接口更新
- 修复部署版使用 OpenSearch 引擎时，新接入数据工作空间偶发的 Query Faild 错误。

## 1.76.147（2023 年 12 月 14 日）

pubrepo.guance.com/dataflux/1.76.147:launcher-5616d5e-170882012

### 观测云部署版更新

- 管理后台调整：
    - 新增告警通知独立发送配置：开启此配置后，告警策略选择【告警不聚合】选项时，每条事件都会发送一份告警通知，帮助您高效管理告警通知。
    - 新增事件链接免登查看配置：开启此配置后，所有工作空间发送的告警通知内置的事件关联链接都可以免登访问。若关闭该配置，则历史发送的免登链接都会失效，保障数据安全。
- 优化【定时报告】：支持查询范围自定义配置，上限由 30 天调整为 360 天，满足您所需定时报告的拓展需求。

### 观测云更新

- 监控：
	- 新增智能监控：
        - 主机智能检测：支持 CPU 的突增/突降/区间上升，内存的突增/突降/区间上升检测；
        - 日志智能检测：支持日志数量的突增/突降，错误日志的突增检测；
        - 应用智能检测：支持请求数量突增/突降，错误请求数量突增，请求延迟的突增/突降/区间上升检测。
        - 突变检测：新增触发规则前提条件，当检测值满足该条件时进行突变检测规则，提升监控精准度。
- 付费计划与账单：
	- 新增数据转发使用分析列表：查看当前工作空间所有数据转发规则的转发数量。若转发规则是到观测云备份日志的模块，会显示对应的保存策略。同时，支持时间控件筛选所需的数据转发情况列表，方便快速查看历史日志的备份整体情况。
- 事件：
	- 新增智能监控事件查看器：可查看智能监控产生的全部事件信息。
- 日志：
	- 数据访问新增【仅显示跟我相关规则】配置：开启后仅显示影响当前账号数据查询的访问规则。
	- 日志 > 查看器：新增数据访问规则限制提示。
	- 基础设施 > 容器 > Kubernetes：
    	- 新增 Kubernetes 分析看板：容器对象分析看板，帮助您从不同维度了解 Kubernetes 中的各基础设施情况。
    - 容器 > 查看器：页面 UI 优化。
- 指标：
	- 指标 > 查看器：
	- 表格图新增【查询工具】模式：返回结果与快捷入口 > 查询工具保持一致；若添加多个查询，默认返回第一条查询结果；该模式下支持最多导出 1000 条查询记录。
	- 新增查询条件【复制】功能，优化页面体验。
	- 查询组件优化：简单查询的【by 分组】支持自由拖动调整顺序。
- 查看器：
	- 调整所有查看器，分析模式下隐藏趋势图显示。
- SSO：
	- 优化 SSO 用户工作空间列出逻辑，修复因无访问权限自动退出登录的问题。

### DataKit 更新

- 新加功能
	- 添加 ECS Fargate 采集模式
	- 添加 promremote 采集器 tag 白名单
- 问题修复
	- 修复 PostgreSQL 采集器版本检测问题
	- 修复 ElasticSearch 采集器帐号权限设置问题
	- 修复 hostdir 采集器采集磁盘根目录崩溃问题
- 功能优化
	- 优化 DDTrace 采集器：去除 message.Mate 中重复的标签
	- 优化容器内日志文件的路径搜寻策略
	- 优化拨测采集器，指标增加 datakit_version 字段以及采集时间设置为任务开始执行的时间
	- 优化二进制包大小，移除了 datakit export 命令
	- 优化时间线算法，调试采集器配置 中增加采集点的时间线数量
	- 优化 hostdir 采集器采集时间戳同步
	- 优化 profile 使用磁盘缓存实现异步化上报

### 集成更新

- 新增集成：APISIX

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.75.146（2023 年 12 月 05 日）

pubrepo.guance.com/dataflux/1.75.146:launcher-fabca4a-1701858102

### 私有部署版更新

- 部署版中心 Pipeline 支持，增加系统及工作空间级别控制开关

### 观测云更新

- 数据访问规则相关优化，支持日志查看器选择索引时根据当前账号角色关联的数据访问规则范围列出可选索引列表
- 其他一些 bug 修复

## 1.75.145（2023 年 11 月 30 日）

pubrepo.guance.com/dataflux/1.75.145:launcher-1d8dd47-1701400875

### 私有部署版更新

- 管理后台调整：
    - 新增支持自定义邮件首尾以及 Logo 等显示文案；
    - 观测云将取消 Banner 信息的设置，不再提供维护 Banner 信息的相关支持。

### 观测云更新

- 监控：
    - 新建监控器 > 事件内容 > 插入链接：支持根据检测指标自动生成跳转链接，可在插入链接后调整过滤条件和时间范围；支持自定义跳转链接。
    - 告警策略管理：新增【智能聚合】模式，您可以根据 "标题" 或 "内容" 聚类分组周期内产生的事件，每个分组将产生一条告警通知。
    - 管理：
        - 该模块菜单页面整体风格优化。
        - 新增【属性声明】：通过固定字段 organization、business 帮助在全局中快速识别并进行联动查询。
        - 新增【正则表达式】：可切换查看【自定义】和【模版库】列表；其中支持用户自定义正则表达式模板并应用到【快照分享】和【数据访问规则】。
    - 工单管理：
        - 工单由“账号级别”调整为“工作空间级别”，所有成员都可以查看工作空间内的全部工单；
        - 新增【所有工单】列表、【提交人】以及【我的工单】列表。
        - 空间管理：解散空间操作新增风险确认提示。
        - 工作空间【描述】功能下线处理。
    - 数据转发：查询和统计调整优化
    - 查询侧：调整内容显示数据范围，默认显示除 time 以外的其他数据内容；
    - 针对数据转发功能做了一些健壮性优化。
- 日志：
    - 数据访问：
        - 新增数据脱敏规则，支持配置多个字段并应用多个正则表达式；
        - 支持配置全部【索引】和【角色】；
        - 新增脱敏预览，以便判断规则是否能满足需求。
    - 快照 > 分享快照：
        - 分享链接有效时间新增 1、3、7天，默认选中 1 天；
        - 数据脱敏：支持配置多个字段并应用多个正则表达式；
        - 支持预览快照，您可以提前查看所有已配置的页面效果。
- RUM：【新建应用】页面布局调整，优化使用体验。
    - 聚类分析：
    - RUM > Error 查看器 & APM > 错误追踪：聚类分析模式下调整为 drain() 算法聚合逻辑；新增输入框可修改聚类字段，默认为 error_message，最多可输入3个字段，也可根据需要自定义聚类字段。

### DataKit 更新

- 新加功能
    - Redis 采集器新增 hotkey 指标
    - monitor 命令支持播放 bug report 中的指标数据
    - Oracle 采集器增加自定义查询
    - Container 容器内的日志文件支持通配采集
    - Kubernetes Pod 指标支持 network 和 storage 字段采集
    - RUM 新增配置支持对会话重放进行过滤
- 问题修复
    - 修复 cgroup 在某些而环境下出现的 panic 错误
    - 修复 Windows 安装脚本在低版本 PowerShell 下执行失败
    - 修复磁盘缓存默认开启问题
    - 调整 Kubernetes Auto-Discovery 的 Prom 指标集命名风格
- 功能优化
    - 优化内置采集器模板视图和监控器视图导出逻辑以及更新 MySQL / PostgreSQL / SQLServer 视图模板
    - 优化 Prom 采集器自身指标名称
    - 优化 Proxy 采集器，提供基本性能测试基准
    - 容器日志采集支持添加所属 Pod 的 Labels
    - 采集 Kubernetes 数据时默认使用 NODE_LOCAL 模式，需要添加额外的 RBAC
    - 优化链路处理流程
    - 重构 PinPoint 采集器，优化上下级关系
    - API 支持丢弃 message 字段以节约存储

### 集成更新

- 新增集成：logstash

### 最佳实践更新

- 新增最佳实践：异常追踪与 JIRA 实现双向联动最佳实践

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.74.143（2023 年 11 月 16 日）

pubrepo.guance.com/dataflux/1.74.143:launcher-b218b62-1700553377

### 观测云更新

- 监控器:
    - 【告警沉默】功能回归，仍可通过告警沉默配置定义重复告警通知的时间间隔。
    - 删除 ”紧急“、”重要“、”警告“触发条件必须配置任意一项的限制，现支持任意配置紧急、重要、警告、数据断档、信息的其中一种触发条件。
    - 基础设施存活监测：支持指标配置基础设施的存活检测，可通过此模式定义检测频率更高的存活检测配置。
- 场景：
    - 图表：
        - 高级设置：【原始间隔】参数配置下线，默认配置调整为【自动对齐】，支持自定义选择图表默认情况下数据的时间间隔。
        - 时序图：【显示密度】调整为【最大返回点数】，默认值为 720，支持定义 2-1000 之间的任意整数。
        - 修复了 PromQL 联动视图变量后导致别名功能失效的问题。
- 服务管理：
    - 新增内置切换下拉框，您可直接在此处选择切换服务无需回到清单列表。
    - 详情页中 POD 页面下线。
    - 【资源调用】性能图表变更为组合图表显示，优化页面展示体验
- 管理
    - SSO 管理：
        - SSO 登录时，工作空间支持列出当前【身份提供商 ID】下所有授权的工作空间；支持通过【搜索】功能直接定位目标工作空间。
        - 【用户 SSO】 新增【导入/导出】功能，从而快速配置多个工作空间单点登录配置。
    - 工作空间语言：
        - 控制台默认显示语言逻辑调整，默认跟随浏览器语言显示配置。
        - 当修改工作空间语言版本时，事件、告警、短信等通知模版也将使用修改后的语言模版。
    - 事件关联异常追踪新增联动标识：
        - 未恢复事件列表中可通过图标了解当前事件是否关联了某个异常追踪。
        - 异常追踪：若存在由监控器同步创建关联的事件信息，可通过图标快速了解关联的事件数量。
        - 基础设施 > 主机：优化主机查看器指标数据排序不准的问题。
    - Pipeline 使用体验的若干优化：
        - 数据来源选择列新增已配置过 Pipeline 脚本的文案提示
        - 日志数据获取测试样本新增 ”索引“ 选择，解决用户未使用默认索引导致获取不到样本数据问题

### 观测云部署版更新

- 单点登录：支持用户账号通过 OIDC 登录时，根据返回的用户信息动态追加手机号信息。

### DataKit 更新

- 新加功能
    - 支持 OceanBase MySQL 模式采集
    - 新增数据录制/播放功能
- 问题修复
    - 修复 Windows 低版本资源限制无效问题
- 功能优化
    - 优化 statsd 采集
    - 优化 Datakit 安装脚本
    - 优化 MySQL 内置视图
    - 完善 Datakit 自身指标暴露，增加完整 Golang 运行时等多项指标
    - 其它文档优化以及单元测试优化
    - 完善 Redis 指标采集，增加更多指标
    - TCP 拨测中允许增加报文（只支持 ASCII 文本）检测
    - 优化非 root 用户安装时的问题
    - 可能因 ulimit 设置失败无法启动
    - 完善文档，增加非 root 安装时的受限功能描述
    - 调整非 root 安装时的前置操作，改为用户手动配置，避免不同操作系统可能存在的命令差异
    - MongoDB 采集器增加对老版本 2.8.0 的支持
    - RabbitMQ 采集器增加对低版本（3.6.X/3.7.X）的支持
    - 优化 Kubernates 中 Pod 指标采集，以替换原始 Metric Server 方式
    - Kubernates 下采集 Prometheus 指标时允许增加指标集名称配置

### 集成更新

- 新增集成 argocd 、 fluentd
- 更新集成 redis-sentinel

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.73.142（2023 年 11 月 02 日）

pubrepo.guance.com/dataflux/1.73.142:launcher-546eb3e-1699281153

### 观测云部署版更新

- 支持账号会话失效时长自定义配置，对前台用户统一设置登录会话保持时间。

### 观测云更新

- 管理：
    - SSO 管理：支持 OIDC / Oauth2.0 协议的单点登录配置；
    - 数据权限管理：添加授权时新增【角色】，配置角色后，被授权的工作空间做数据查看时会根据选择的角色范围，判断数据的查询访问限制和脱敏限制。
- 数据转发：
    - 导航位置调整至【管理】模块，仍可通过原【日志】、【用户访问监测】、【应用性能监测】的导航栏二级菜单进入【数据转发】；
    - AWS S3 和阿里云 OSS 支持“跨账号授权”配置，实现两个账号之间互相授权数据权限，简化了配置流程。
- 付费计划与账单：
    - 支持数据转发到观测云内部存储，统计每天出账时工作空间内保存到观测云存储对象的数据容量大小；
- 事件 > 未恢复事件：
    - 目前，未恢复事件列表保存近 24 小时内的事件数据；
    - 新增显示偏好：默认展示【标准】模式，支持选择【扩展】模式来打开事件检测结果值历史趋势；
    - 支持将当前事件列表导出 CSV；
    - 事件详情页新增扩展字段 Tab 页；基础属性Tab 页页面优化。
- 基础设施 > 网络：
    - 优化【总览】模板，新增快捷筛选，用户可以过滤查看网络路径。新增 5 个统计图表，支持分析发送/接收字节数、TCP 重传等网络指标信息；
    - 新增【网络流】查看器，可以查看时间线上的所有 L4(netflow)、L7(httpflow) 网络流数据；
    - 其他查看器详情页新增【拓扑】模式展示，可直接查看当前对象的网络上下游关系以及一些网络关键指标。
- 场景：
    - 视图变量：支持添加 PromQL 方式查询；
    - 图表：
    - 针对 Doris 数据存储的工作空间新增【数据采样】；
    - 时间自动对齐功能优化：针对所有指标数据和 Doris 数据的图表查询，当开启时间自动对齐功能时，返回数据的时间点将按“整秒/整分/整小时”对齐；
    - 排行榜、概览图、表格图：新增【规则映射】，可为映射数值范围内的数据配置相应的字体色/背景色。
    - 查看器：分析模式优化，在支持基于数据自由地进行聚合查询，并以图表形式展示分析；
    - 服务管理 > 资源调用：资源排行榜新增【每秒请求数】选项。
- 可用性监测 > 任务：支持导入、导出。
- Doris 日志数据引擎下暂不支持 with_labels 联动查询。

### DataKit 更新

- 新加功能
    - 新增 OceanBase 采集
- 问题修复
    - 修复 Tracing 数据中较大 Tag 值兼容，现已调至 32MB
    - 修复 RUM session replay 脏数据问题
    - 修复指标信息导出问题
- 功能优化
    - 主机目录采集和磁盘采集中，新增挂载点等指标
    - KafkaMQ 支持 OpenTelemetry Tracing 数据处理
    - Bug Report 新增更多信息收集
    - 完善 Prom 采集过程中自身指标暴露
    - 更新默认 IP 库以支持 IPv6
    - 更新镜像名下载地址为 pubrepo.guance.com
    - 优化日志采集文件位置功能
    - Kubernetes
    - 支持 Node-Local Pod 信息采集，以缓解选举节点压力
    - 容器日志采集支持更多粒度的过滤
    - 增加 service 相关的指标采集
    - 支持筛选 PodMonitor 和 ServiceMonitor 上的 Label 功能
    - 支持将 Node Label 转换为 Node 对象的 Tag
- 兼容调整
    - Kubernetes 不再采集 Job/CronJob 创建的 Pod 的 CPU/内存指标

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.72.141（2023 年 10 月 28 日）

pubrepo.guance.com/dataflux/1.72.141:launcher-9c1d6ec-1698481094

### 私有部署版更新

- 修复安装程序的一些 bug

## 1.72.140（2023 年 10 月 24 日）

pubrepo.guance.com/dataflux/1.72.140:launcher-b2acabc-1698160292

### 私有部署版更新

- 支持在部署时选择 GuanceDB 作为默认时序引擎
- 一些其他已知 bug 修复

## 1.72.139（2023 年 10 月 19 日）

pubrepo.guance.com/dataflux/1.72.139:launcher-27b5e0f-1697980093

### 私有部署版更新

- 新增自定义映射规则配置：启用该配置后，对应工作空间可以自定义映射规则。工作空间的自定义映射规则优先级大于管理后台的映射规则；
- 新增查询数量上限：针对不同用户的工作空间的查询数量有定制化的限制，避免因查询数据量过大导致集群查询性能低，影响产品使用体验；
- 本地账号新增更换密码。

### 观测云更新

- 付费计划与账单：计费项【数据转发】目前按照数据转发规则，分别统计转发数据量进行计费。
- 管理
- SSO 管理：支持创建多个 SSO 的 IDP 配置，并支持针对单个 IDP 配置进行启用、禁用操作、开启 SAML 映射。
- 数据权限管理 > 敏感数据脱敏：支持基于角色级别配置敏感数据屏蔽规则，配置时可采用正则表达式脱敏，支持针对某个数据类型下的字段做脱敏规则配置，并由此新增脱敏规则预览测试。
- 监控器：新增外部事件检测，将第三方系统产生的异常事件或记录通过指定 URL 地址，以 POST 请求方式发送到 HTTP 服务器后生成观测云的事件数据。
- 场景
- 服务管理 > 资源调用：新增针对对应列表进行数量排序，默认从大到小；
- 图表链接：新增基于当前选中数据点的开始时间和结束时间做传参，变量分别为 #{timestamp.start}、#{timestamp.end}；
- 图表别名：基于图例序列进行配置；
- 表格图：新增【时序表格图】。
- 指标 > 指标分析：表格图新增【时序模式】。

### DataKit 更新

- Pod 添加 cpu_limit 指标
- New Relic 链路数据接入
- 优化 logfwd 的退出逻辑，避免因为配置错误导致程序退出影响到业务 Pod
- 优化 ElasticSearch采集器，增加索引指标集 elasticsearch_indices_stats 分片和副本等指标
- 增加 disk 集成测试
- DataKit monitor 支持 HTTPS
- Oracle 采集器添加慢查询日志
- 优化采集器 point 实现
- MongoDB 采集器集成测试增加检测授权功能
- 修复日志单行数据太长可能导致的内存问题
- 修复 disk 采集器磁盘挂载点获取失败问题
- 修复 helm 和 yaml 中的 Service 名称不一致问题
- 修复 pinpoint span 中缺失 agentid 字段
- 修复采集器中 goroutine group 错误处理问题
- 修复MongoDB 采集器空数据上报问题
- 修复 rum 采集器请求中出现大量 408 和 500 状态码

### 集成更新

- PagerDuty：当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.71.138（2023 年 10 月 13 日）

pubrepo.guance.com/dataflux/1.71.138:launcher-74c9d6a-1697164060

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 优化各个类型的数据查看器查询性能
- 修复一些其他已知 bug

## 1.71.137（2023 年 09 月 21 日）

pubrepo.guance.com/dataflux/1.71.137:launcher-ee43f34-1695727144

### 观测云更新

- 日志：
    - 数据转发：新增外部存储转发规则数据查询；支持启用/禁用转发规则；
    - 绑定索引：日志易新增标签绑定，从而实现更细颗粒度的数据范围查询授权能力。
    - 基础设施 > 自定义：
    - 【默认属性】这一概念更改为【必有属性】：上报的数据中必须包含该属性字段，否则将会上报失败；
    - 支持将资源目录添加至二级菜单，便于查看。
    - 自定义查看器新增快捷筛选。
- 场景：
    - 定时报告：新增【钉钉】【企业微信】【飞书】三种通知方式；
    - 图表：【时序图、饼图、柱状图、直方图、散点图、气泡图、表格图、矩形树图、漏斗图、排行榜、地图、蜂窝图】新增数据格式，可以定义【小数位数】以及【千分位分隔符】。
    - 监控 > 通知对象管理：邮件组类型下架，已创建的不受影响。
    - 快照：分享快照：新增 IP 白名单访问限制。
    - 异常追踪：【等级】支持自定义创建；支持启用/禁用默认等级。
    - 集成 > 扩展：DataFlux Func 托管版和 RUM Headless 现支持海外站点：俄勒冈，法兰克福，新加坡。

### DataKit 更新

- 新增 Neo4j 采集器
- RUM 采集器新增 sourcemap 文件上传、删除和校验接口，并移除 DCA 服务中 sourcemap 上传和删除接口
- 新增 IBM Db2 采集器的监控视图和检测库
- 修复环境变量 ENV_GLOBAL_HOST_TAGS 中使用 __datakit_hostname 无法获取主机 hostname 的问题 
- 修复 host_processes 采集器指标数据缺少 open_files 字段
- 修复 Pinpoint 采集器 resource 大量为空的情况和 Pinpoint 占用内存过高问题 
- 优化 Kubernetes 指标采集和对象采集的效率
- 优化日志采集的 metrics 输出 
- Kubernetes Node 对象采集添加 unschedulable 和 node_ready 两个新字段 
- Oracle 采集器支持 Linux ARM64 架构
- logstreaming 采集器增加集成测试
- Datakit 开发文档中增加 IBM Db2 采集器内容
- Kafka、MongoDB 采集器文档完善
- MySQL 采集器监控帐号创建时，MySQL 8.0+ 默认采用caching_sha2_password 加密方式
- 优化 bug report 命令采集 syslog 文件过大问题
- 删除 DCA 服务中的 sourcemap 文件上传和删除接口，相关接口移至 RUM 采集器

### 集成更新

- Huawei CCE：观测云支持对 CCE 中各类资源的运行状态和服务能力进行监测，包括 Containers、Pods、Services、Deployments、Clusters、Nodes、Replica Sets、Jobs、Cron Jobs 等。您可以在 Kubernetes 中通过 DaemonSet 方式安装 DataKit，进而完成对 Kubernetes 资源的数据采集。最终，在观测云中实时监测 Kubernetes 各类资源的运行情况。
- Huawei CSS(Elasticsearch)：华为云搜索服务 CSS for Elasticsearch 的核心性能指标包括查询延迟、索引速度、搜索速度、磁盘使用率和 CPU 使用率，这些都是评估和优化 Elasticsearch 性能的关键指标。
- Huawei SYS.AS：华为 SYS.AS 的核心性能指标包括 CPU 利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。
- Huawei ASM：华为云的 ASM 的链路追踪数据输出到观测云，进行查看、分析。
- AWS CloudFront：AWS CloudFront 的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。
- AWS MediaConvert：AWS MediaConvert 包括数据传输、视频报错、作业数、填充等。
- AWS Aurora Serverless V2：AWS Aurora Serverless V2，包括连接数、IOPS、队列、读写延迟、网络吞吐量等。
- AWS Redshift：AWS Redshift 的核心性能指标包括查询性能、磁盘空间使用率、CPU 利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。
- AWS Simple Queue Service：AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。
- AWS Timestream：AWS Timestream 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量以及存储在磁存储器中的数据量等。
- AWS Neptune Cluster：AWS Neptune Cluster 的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了 Neptune Cluster函数的响应速度、可扩展性和资源利用情况。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.70.136（2023 年 09 月 07 日）

pubrepo.guance.com/dataflux/1.70.136:launcher-6ccb06b-1694354213

### 观测云更新

- 场景 > 仪表板/查看器：新增全局跨工作空间查询配置。
- 场景 > 图表查询：时间控件范围小于等于【最近 15 分钟】，自动对齐时间间隔新增 “1 秒”显示。
- 场景 > 服务管理：
- 服务清单新增绑定多个内置视图到分析看板；新增关联、团队信息；
- 新增资源调用分析看板；
- 支持保存快照。
- 日志 > 备份日志：
- 正式更改为数据转发；
- 新增链路、用户访问数据源；
- 原备份日志计费项名称更改为数据转发计费项。
- 日志 > 查看器：新增新建监控器入口；支持针对查看器详情页做快照保存。
- 管理：
- 全局标签：新增全局标签功能，对标签进行统一管理；
- 字段管理：新增别名、设置显示列；
- 空间管理：功能整合和页面优化；
- 成员管理：原成员组的定义正式更改为团队；
- 敏感数据扫描：新增扫描规则数量统计；新增跳转链接。
- 监控：
- 可用性数据检测：新增拨测指标，可以基于【指标】维度进行检测；
- 突变、离群、区间检测：支持选择所有数据源。

### DataKit 更新

- 新加功能：
    - Windows 支持内存/CPU 限制
    - 新增 IBM Db2 采集器
- 问题修复：
    - 修复容器采集配置 include/exclude 的 double star 问题
    - 修复一处 k8s Service 对象数据的字段错误
- 功能优化：
    - DataKit 精简版支持 logging 模块
    - bug report 支持禁用 profile 数据采集
    - 增加不同 Trace 传递说明的文档
    - Pipeline 增加函数 parse_int 和 format_int
    - Pipeline 数据聚合函数 agg_create 和 agg_metric 支持输出任意类别的数据
    - 优化 Datakit 镜像大小
    - 优化 --bug-report 命令，可关闭 Profile 收集（避免给当前 Datakit 造成压力）
    - 增加Datakit 指标性能测试报告
    - 增加external 采集器的使用文档

### 集成更新

- 阿里云：
    - aliyun_analyticdb_postgresql：阿里云 AnalyticDB PostgreSQL 指标展示，包括 CPU、内存、磁盘、协调节点、实例查询等。
    - aliyun_clickhouse_community：阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。
    - aliyun_kafka：阿里云 KafKa 包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。
    - aliyun_lindorm：包括高吞吐量、低延迟的数据读写能力，支持高并发的事务处理，以及强一致性和高可靠性的数据存储和查询服务。
    - aliyun_polardb_1.0：阿里云 PolarDB 分布式 1.0 展示指标包括CPU利用率、内存利用率、网络带宽和磁盘 IOPS。
    - aliyun_polardb_2.0：阿里云 PolarDB 分布式 2.0 展示计算层和存储节点的指标，包括 CPU 利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。
    - aliyun_rds_postgresql：阿里云 RDS PostgreSQL 指标展示，包括 CPU 使用率、内存使用率等。
    - aliyun_rocketmq5：阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。
- AWS：
    - aws_dynamodb_DAX：AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。
    - aws_memorydb：AWS MemoryDB 的核心性能指标包括低延迟的内存读写能力、高并发的事务处理能力，以及可线性扩展的存储容量和吞吐量。
- 华为云：
    - huawei_functiongraph：HUAWEI FunctionGraph 的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了 FunctionGraph 函数运行情况。
    - huawei_kafka：包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。
    - huaweiyun_SYS_DDMS：'华为云 SYS.DDMS 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 DDMS 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。
- 腾讯云：
    - tencent_keewidb：腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等。
    - tencent_mariadb：包括高性能的读写能力、低延迟的查询响应时间，以及支持高并发的事务处理和扩展性能。
    - tencent_memcached：包括高速的内存读写能力、低延迟的数据访问时间，以及高并发的访问处理能力。
    - tencent_tdsql_c_mysql：包括高吞吐量的读写能力、低延迟的查询响应时间，以及支持高并发的事务处理和可扩展性能。
- 其他：
    - openai：OpenAI的展示指标包括请求总数，响应时间，，请求数量，请求错误数和消耗token数。
    - monitor_jira：当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 Jira 中创建事件，这样我们就可以在 Jira 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 Jira 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.69.135（2023 年 08 月 24 日）

pubrepo.guance.com/dataflux/1.69.135:launcher-7130e81-1693313758

### 部署版更新

- 管理后台映射规则新增仅针对新加入成员应用适配规则，用户启用选择该选项时，映射规则适配仅针对首次加入成员生效。

### 观测云更新

- 计费项：
    - 备份日志：新增 OSS、OBS、AWS S3、Kafka 四种存档类型计费项，基于用户选择的对应存档类型统计汇总转发的流量大小，并根据数据对应出账；
    - 应用性能 Trace、用户访问 PV 新增 30天/60天的数据存储策略。
- 监控：
    - 静默规则：支持基于不同维度配置告警沉默。
    - 监控器：支持为监控器添加标签，根据标签过滤列表；监控器列表增加快捷筛选列，并对列表进行了一些优化；
- SLO：新增故障时间显示列。
- 日志 > 备份日志：新增 Kafka 消息队列外部存储。
- 查看器/仪表板：新增自动刷新功能。
- 查看器详情页：新增绑定内置视图入口。
- 场景 > SLO 图表：新增故障时间显示。

### DataKit 更新

- 新增采集器 NetFlow
- 新增黑名单调试器
- 新增 Kubernetes StatefulSet 指标和对象采集，新增 replicas_desired 对象字段
- 新增 DK_LITE 环境变量，用于安装 DataKit 精简版
- 修复 Container 和 Kubernetes 采集没有正确添加 HostTags 和 ElectionTags 的问题
- 修复 MySQL 自定义采集 Tags 为空时指标无法采集的问题
- 增加 System 采集器中的 process_count 指标表示当前机器的进程数
- 去掉 Process 采集器中的 open_files_list 字段
- 增加主机对象采集器文档中指标丢失的处理案例
- 优化 Datakit 视图，完善 Datakit Prometheus 指标文档
- 优化 Pod/容器 日志采集的 mount 方式
- 增加 Process、System 采集器集成测试
- 优化 etcd 集成测试
- 升级 Golang 1.19.12
- 增加通过 ash 命令安装 DataKit
- RUM 采集支持自定义指标集，默认的指标集新增 telemetry
- 移除 Datakit 端的 Sinker 功能，将其功能转移到 Dataway 侧实现
- 移除 Kubernetes Deployment 指标数据的 pasued 和 condition 字段，新增对象数据 paused 字段

### 智能巡检更新

- 阿里云 RDS MariaDB：阿里云 RDS MariaDB 的展示指标包括响应时间、并发连接数、QPS 和 TPS 等。
- 阿里云 RocketMQ4：阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。
- 阿里云 Tair 社区版：阿里云 Tair 社区版指标展示包括 CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。
- AWS DynamoDB：AWS DynamoDB 的展示指标包括吞吐量容量单位（Capacity Units）、延迟、并发连接数和读写吞吐量，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。
- AWS EventBridge：AWS EventBridge 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 EventBridge 在处理大规模事件流和实时数据传递时的性能表现和可靠性。
- AWS Lambda：AWS Lambda 的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了 Lambda 函数的响应速度、可扩展性和资源利用情况。
- HUAWEI SYS.AS：HUAWEI SYS.AS 的展示指标包括响应时间、并发连接数、吞吐量和可靠性，这些指标反映了 SYS.AS 在处理应用程序请求和数据交互时的性能表现和稳定性。
- HUAWEI SYS.CBR：HUAWEI SYS.CBR 的展示指标包括带宽利用率、延迟、丢包率和网络吞吐量，这些指标反映了CBR在网络传输和带宽管理方面的性能表现和质量保证。
- 华为云 GaussDB-Cassandra：华为云 GaussDB-Cassandra 的展示指标包括读写吞吐量、延迟、数据一致性和可扩展性，这些指标反映了 GaussDB-Cassandra 在处理大规模分布式数据存储和访问时的性能表现和可靠性。
- 华为云 GaussDB for MySQL：华为云 GaussDB for MySQL 的展示指标包括响应时间、并发连接数、读写吞吐量和可扩展性，这些指标反映了 GaussDB for MySQL 在处理大规模关系型数据库操作时的性能表现和可靠性。
- 华为云 GaussDB-Influx：华为云 GaussDB-Influx 的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了 GaussDB-Influx 在处理大规模时序数据存储和查询时的性能表现和可靠性。
- 华为云 GaussDB-Redis：华为云 GaussDB-Redis 的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了 GaussDB-Redis 在处理高并发数据存储和缓存时的性能表现和可靠性。
- 华为云 GaussDB SYS.GAUSSDBV5：华为云 GaussDB SYS.GAUSSDBV5，提供 CPU、内存、磁盘、死锁、SQL 响应时间指标等数据。
- 华为云 MongoDB：华为云 MongoDB 的展示指标包括读写吞吐量、延迟、并发连接数和数据可靠性，这些指标反映了 MongoDB 在处理大规模文档存储和查询时的性能表现和可扩展性。
- 华为云 RDS PostgreSQL：华为云 RDS PostgreSQL 的展示指标包括查询性能、事务吞吐量、并发连接数和数据可靠性，这些指标反映了 RDS PostgreSQL 在处理大规模关系型数据存储和事务处理时的性能表现和可靠性。
- 腾讯云 CKafka：腾讯云 CKafka 的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了 CKafka 在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。
- Zadigx：Zadigx 展示包括概览、自动化构建、自动化部署、自动化测试等。
- 飞书与异常追踪联动：为方便更加及时可方便的获取异常追踪中的新 Issue，可以通过在内部群中创建一个飞书、钉钉或者企业微信的机器人来接受异常追踪中的新 Issue 或新回复的提醒，帮助及时处理 Issue；也可以通过 @机器人的这种方式来快速进行 Issue 回复，提高我们的异常处理效率。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.68.134（2023 年 08 月 10 日）

pubrepo.guance.com/dataflux/1.68.134:launcher-9651bb3-1691936534

### 观测云更新

- 新增计费项定时报告：按工作空间内定时报告单日发送的次数出账计费。
- 场景新增服务管理：服务管理是一个用于访问所有服务关键信息的集中入口，用户可查看当前工作空间内不同服务的性能和业务数据及所有的关联分析等信息，快速定位并解决服务的相关问题。
- 场景图表均支持 PromQL 查询和表达式查询。
- 日志：支持在日志详情页直接查看上下文日志；可选择上下文检索范围。
- 查看器：打开某条数据详情页，支持一键导出当前数据为 JSON 文件。
- 应用性能监测 > 服务 > 调用拓扑：新增当前服务的上下游调用关系表格，展示服务单向关系的请求数、平均响应时间和错误数。
- 监控器 > 阈值检测：检测指标新增转换为 PromQL 查询。
- 基础设施 > 容器：Pods、Services、Deployments、Nodes、Replica Sets、Cron Jobs、Daemonset 详情页新增 Kubernets 事件组件。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.67.133（2023 年 07 月 27 日）

pubrepo.guance.com/dataflux/1.67.133:launcher-3840753-1690897331

### 私有部署版更新

- 在进行版本升级时，不再更新整个 Workload 的 YAML 文件，这意味着升级版本不会导致 Workload 的个性化配置被重置

### 观测云更新

- 场景 > 仪表板：新增定时报告功能，支持用户创建基于某仪表板的报告，并可以配置定时邮件发送；
- 导航栏新增 邀请成员 入口，可通过该入口快速邀请成员。在管理页面，新增邀请审批按钮。该按钮开启情况下，向成员发送邀请后，须移至邀请记录审批管理成员加入申请。
- 日志 > 备份日志有以下调整：
- 观测云默认存档类型下线：
- 新创建的备份规则中将不再支持【观测云】默认选项；
- 历史已创建的备份规则依然生效。
- 新增支持备份到外部存储阿里云 OSS。
- 监控 > 新建：支持将监控器保存为自定义模板库，以便后续用户快速创建同类型监控器检测。
- 监控 > 新建监控器 > 自定义新建：除【突变检测】【区间检测】【离群检测】以外，所有检测规则的检测频率新增【最近 12 小时】【最新 24 小时】选项。
- 异常追踪：新建 Issue 页面新增投递频道配置入口，支持多选；等级新增未知选项，默认选中该选项。
- 为满足用户数据合规性要求，快照支持针对字段通过正则语法对某些内容脱敏。
- 场景 >日志流图：新增 Copy as cURL、导出为 CSV 文件功能。
- 用户访问监测 > 查看器 > Error：新增 聚类分析 功能，方便查看发生频次较高的错误。
- 新增数据上限提示：即日志、链路等数据量到达今日上限，将停止数据接收，如需调整，请联系客户经理。

### DataKit 更新

- 新加功能
    - HTTP API 增加 sourcemap 文件上传
    - 新增 .net Profiling 接入支持
    - 新增 Couchbase 采集器

- 问题修复
    - 修复拨测采集器缺失 owner 字段问题
    - 修复 DDTrace 采集器缺失 host 问题，同时各类 Trace 的 tag 采集改为黑名单机制
    - 修复 RUM API 跨域问题

- 功能优化
    - 优化 SNMP 采集器加密算法识别方法；优化 SNMP 采集器文档，增加更多示例解释
    - 增加 Pythond 采集器 Kubernetes 部署示例，增加 gitrepo 部署示例
    - 增加 InfluxDB、Solr、NSQ、Net 采集器集成测试
    - 增加 Flink 指标
    - 扩展 Memcached、MySQL 指标采集
    - 更新 Datakit 自身指标暴露
    - Pipeline 增加更多运算符支持
    - 拨测采集器
    - 增加拨测采集器内置仪表板
    - 优化拨测任务启动，避免资源集中消耗
    - 文档更新
    - 其它优化

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.66.132（2023 年 07 月 11 日）

pubrepo.guance.com/dataflux/1.66.132:launcher-2c2a83a-1689171482

### 观测云更新

- 观测云国际站“EU1(Frankfurt)”正式上线。
- 集成升级：点击任意集成方案，即可在同一页面上了解从配置接入、数据采集到数据应用的全链路使用方案。
- 监控器 > 模板 功能优化：支持基于单个检测规则创建或批量创建；支持基于检测库进行筛选。
- 应用性能监测 > 链路：Span 列表页面新增瀑布图模式，帮助用户以更直观的视角分析 Span 数据信息；服务调用关系 从服务（service）变更为服务资源（service / resource）级别，通过下钻到接口级别来更好地分析对应的性能及调用问题，从而通过接口级别的调用帮助用户更快发现问题点。
- 图表 > 概览图：新增千位分隔符；单位 > 数值中，“默认”改为“万进制”；值映射中新增空值映射。
- 图表 > 矩形树图：新增显示值选项，选中可在图中直接显示查询结果值。
- 图表 > 添加链接：新增 query 参数，删除 tags、search 两个参数。
- 应用性能监测 > 服务列表支持导出。

### 智能巡检更新

- 功能优化
    - 应用性能巡检：新增默认检测阈值更改入口，现在在开启巡检时可以同步需改需要检测服务的触发值。
    - RUM 性能巡检：对页面详情模块中根因展示逻辑进行优化，优化后，根因定位更加准确。
    - 工作空间资产巡检：新增默认配置(7 天)，现在开启巡检不需要参数也可以运行。

- 新增脚本
    - 云消息队列 RocketMQ4.0
    - 华为云-CSS
    - 华为云-RocketMQ
    - 华为云-RabbitMQ
    - 华为云-WAF-事件列表
    - 华为云-WAF-事件概览

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.65.131（2023 年 06 月 20 日）

pubrepo.guance.com/dataflux/1.65.131:launcher-d6c2ef5-1687506944

### 观测云更新

- RUM (Real User Monitoring) 采集器用于收集网页端或移动端上报的用户访问监测数据。现提供 RUM Headless一键开通服务，实现自动化安装部署在观测云的云主机中，自动完成 DataKit 安装，RUM 采集器部署。只需要手动接入应用即可。
- 查看器：优化筛选、搜索的交互转化等逻辑，让用户真正做到所见即所得，且能够在 UI 和手写模式自由切换。另：日志查看器支持的 DQL 手写模式新版本上线后将会做下线处理。
- 日志 > 备份日志：新增外部存储类型选择，支持写入 S3(AWS) 对象存储、支持华为云 OBS 数据写入。
- 日志 > 索引：新增日志易数据绑定配置入口。
- 仪表板/内置视图支持根因分析和下钻分析。
- 管理 > 角色管理：支持克隆已有用户角色减少操作步骤，快速增减权限并创建角色。
- 基础设施 > 容器：新增 Daemonset 对象数据显示，可拖拽改变对象分类显示顺序。
- 基础设施 > 容器：Deployments、Pods 支持直接关联 kubernetes 事件日志，在详情页可直接查看具体日志信息。
- 新增异常追踪 OpenAPI 接口。
- 管理 > 成员管理列表、监控 > 通知对象管理 > 邮件组、异常追踪 > 查看成员、所有选择通知对象处均支持按成员昵称进行检索。
- 工单状态更新或有新回复时，通过界面或者邮件提醒客户关注。
- 文本输入框输入不合法的字符或长度限制提示优化。

### DataKit 更新

- 新增 Chrony 采集器
- 新增 RUM Headless 支持
- Pipeline
- 新增 offload 功能
- 调整已有的文档结构
- 在 Datakit HTTP API 返回中增加更多信息，便于错误排查
- RUM 采集器增加更多 Prometheus 指标暴露
- 默认开启 Datakit 的 pprof 功能，便于问题排查

### 智能巡检更新

- 新增巡检
- AWS Cloudtrail 异常事件巡检：帮助快速识别问题并采取适当的纠正措施，以减少服务中断时间和业务影响。
- 新增脚本
- 观测云集成（阿里云-RDS错误日志）：收集阿里云的 RDS 错误日志，用于 RDS 的错误信息诊断；
- filebeats 数据采集器：收集 FileBeats 性能数据用于观测 FileBeats 性能、延迟等场景；
- logstash 数据采集器：收集 Logstash 性能数据用于观测 Logstash 性能、延迟等场景。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.64.130（2023 年 06 月 12 日）

pubrepo.guance.com/dataflux/1.64.130:launcher-e504618-1686575695

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 修复私有部署版 OIDC 对接的一些 bug。
- 修复其他一些小 bug。


更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.64.129（2023 年 06 月 08 日）

pubrepo.guance.com/dataflux/1.64.129:launcher-ad357b8-1686206775

### 观测云部署版更新

- 管理后台新增密码安全策略：新增密码 8 位长度限制及密码有效期功能。

### 观测云更新

- 为进一步满足用户数据查看需求，商业版付费计划与账单新增设置高消费预警功能，新增消费分析列表，支持查看各类支出消费统计。
- 创建工作空间时新增菜单风格选择，支持选择不同的工作空间风格属性。
- 优化日志数据访问权限相关规则适配，进一步明确多角色数据查询权限及权限控制对应关系。
- 事件详情页下的基础属性下的检测维度新增关联查询，支持查看筛选当前检测维度下全部字段值的关联数据。
- 告警策略管理支持不同级别告警到不同的通知对象。
- 成员管理新增添加昵称备注功能，规范工作空间内的成员用户名，支持通过昵称备注搜索成员。
- 仪表板、查看器、监控、成员管理、分享管理等页面列表新增批量操作功能。
- 应用性能监测服务支持修改颜色，支持表头排序调整。
- 日志、应用性能监测 > 错误追踪查看器聚类分析支持对文档数量排序，默认倒叙。
- 支持保存登录选择语言版本到浏览器本地，再次登录自动显示上一次登录选择语言版本。
- 生成指标频率选项调整，支持选择 1 分钟、5 分钟、15 分钟。

### 智能巡检更新

- 新增巡检
- 工作空间资产巡检
- 新增脚本
- gitlab 研发效能分析：根据 gitlab 的代码提交频率和每次代码量，分团队、个人、时间维度展示团队的研发效能。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.63.128（2023 年 05 月 22 日）

pubrepo.guance.com/dataflux/1.63.128:launcher-d07d641-1685285792

### 私有部署版更新

- 支持选择使用私有拨测服务或 SaaS 拨测服务中心

### 观测云更新

- RUM 应用配置新增自定义类型和关联视图查看分析
- DQL 函数支持正则聚合数据统计显示返回
- 新增 PromQL 语法查询入口，支持通过 PromQL 查询时序数据
- show_tag_value() 函数支持查询对应指标字段的关联标签
- 小程序 SDK 支持采集启动参数相关的信息；新增自定义添加 Error
- Status Page 支持订阅故障通知
- 新增字段管理功能，在监控器、图表查询、查看器等位置若选择了相关字段则显示对应的描述和单位信息
- 指标分析新增表格功能，支持下载
- 工单状态调整
- 新增异常追踪引导页，频道新增时间范围筛选
- 备份日志优化：
    - 新增备份规则入口移至备份日志 > 备份管理
    - 新增全部备份逻辑：不添加筛选即表示保存全部日志数据

### 智能巡检更新

- 新增巡检
    - 云上闲置资源巡检
    - 主机重启巡检
- 功能优化
    - 闲置主机巡检：新增对云主机类型关联添加费用相关信息。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.62.127（2023 年 04 月 20 日）

pubrepo.guance.com/dataflux/1.62.127:launcher-c737a19-1683555353

### 观测云更新

- 计费更新
    - 观测云自研时序引擎 GuanceDB 全新上线，时序数据存储及计费将会做如下调整：
    - 基础设施（DataKit）计费项下线，原 “DataKit + 时间线”、“仅时间线” 两种计费模式按照仅 GuanceDB 时间线作为出账逻辑使用；
    - GuanceDB 时间线：统计当天活跃的时间线数量计费，单价低至 ￥0.6 / 每千条时间线。
    - 用户访问监测 “会话重放” 正式启动付费，按照实际采集会话重放数据的 session 数量计费，￥10 / 每千个 Session。
- 功能更新
    - GuanceDB 时序引擎全新上线
    - 异常追踪新功能上线
    - 跨站点工作空间授权功能上线
    - SLS 新增第三方授权开通或绑定
    - 绑定索引配置页面优化，支持自定义添加映射字段配置
    - 命令面板新增本地 Func 的自定义函数选择
    - 时序图新增高级函数，支持本地 Func 根据 DQL 查询结果二次处理后返回显示
    - 工作空间新增时区配置，用户可自定义配置当前工作空间查询时间的时区
    - 智能巡检优化脚本集开启步骤，新增新增 AWS 同步多种认证方式、AWS Cloudwatch Logs 同步
    - 集成 - DataKit 页面引导优化
    - 查看器柱状分布图新增统计时间区间显示
    - 导航菜单支持右键选择新页打开
    - 黑名单重名导入问题修复
- 私有部署版更新
    - 新增账号登录映射规则配置，根据不同的映射规则动态分配成员加入的工作空间及对应的角色。

### DataKit 更新

- 新增 Pinpoint API 接入
- 优化 Windows 安装脚本和升级脚本输出方式，便于在终端直接黏贴复制
- 优化 Datakit 自身文档构建流程
- 优化 OpenTelemetry 字段处理
- Prom 采集器支持采集 info 类型的 label 并将其追加到所有关联指标上（默认开启）
- 在 system 采集器 中，新增 CPU 和内存占用百分比指标
- Datakit 在发送的数据中，增加数据点数标记（X-Points），便于中心相关指标构建
- 优化 Datakit HTTP 的 User-Agent 标记，改为 datakit-<os>-<arch>/<version> 形态
- KafkaMQ：
- 支持处理 Jaeger 数据
- 优化 SkyWalking 数据的处理流程
- 新增第三方 RUM 接入功能
- SkyWalking 新增 HTTP 接入功能

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.61.126（2023 年 04 月 06 日）

pubrepo.guance.com/dataflux/1.61.126:launcher-d290e0d-1681300585

### 观测云更新

- 日志新增 3 天数据保存策略和定价，计费相关请参考文档计费方式。
- 日志新增数据访问权限控制，支持将某个范围内的日志数据查看权限授予给相关角色
- 角色权限清单新增各功能模块数据查询权限，支持自定义角色配置对应模块的数据查询权限入口
- 标准成员新增 “快照管理” 权限，支持快照增删操作
- 快照分享支持搜索功能。（日志 DQL 查询模式下不支持调整搜索范围）
- 支持本地 Func 通过 websocket 协议创建自定义的通知对象，实现外部通知渠道接收告警通知
- 查看器新增copy as cURL数据查询功能
- 仪表板图表配置交互优化
- 概览图新增数值单位选项配置，支持选择中国科学记数法进位（default）和短级差制（short scale）
- 新增视图变量是否应用到图表效果显示
- 图表存在分组条件时，支持将某个分组条件值反向应用到视图变量实现联动筛选
- 图表存在分组条件时，选中某个分组条件对应时间线或数据点时支持其他图表中相同分组联动高亮显示
- 图表拖拽效果优化
- 账号无操作会话过期时间默认调整为 3 小时，此次调整仅针对未编辑过无操作会话过期时间配置的账号，不影响已编辑过的无操作会话过期时间配置的账号。
- 筛选历史新增搜索条件保存
- 用户访问监测应用 SDK 接入引导优化
- 生成指标配置优化，支持针对新生成的指标配置单位和描述
- 主机查看器支持多行显示，多行模式下 label 将另起一行显示
- 时序图、饼图新增返回显示数量配置

### DataKit 更新 

- 新加功能
    - 新增伺服服务，用来管理 Datakit 升级
    - 新增故障排查功能
- 功能优化
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
- 兼容调整
    - 本次移除了大部分 Sinker 功能，只保留了 Dataway 上的 Sinker 功能。同时 sinker 的主机安装配置以及 Kubernetes 安装配置都做了调整，其中的配置方式也跟之前不同，请大家升级的时候，注意调整
    - 老版本的发送失败磁盘缓存由于性能问题，我们替换了实现方式。新的实现方式，其缓存的二进制格式不再兼容，如果升级的话，老的数据将不被识别。建议先手动删除老的缓存数据（老数据可能会影响新版本磁盘缓存），然后再升级新版本的 Datakit。尽管如此，新版本的磁盘缓存，仍然是一个实验性功能，请谨慎使用
    - Datakit 自身指标体系做了更新，原有 DCA 获取到的指标将有一定的缺失，但不影响 DCA 本身功能的运行


更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.60.125（2023 年 03 月 23 日）

pubrepo.guance.com/dataflux/1.60.125:launcher-6723827-1679932675

### 私有部署版更新

- 解决了在部署过程中无法使用包含复杂字符密码的中间件的问题
- 提升了在部署过程中自动生成的数据库账号密码的复杂度

### 观测云更新

- 帮助文档搜索功能优化
- 备份日志新增扩展字段保存逻辑
- 查看器/仪表板时间控件新增“时区选择”和“全局锁定”功能
- 监控器优化
- 支持查看上次的历史配置，支持点击还原到历史配置版本
- 列表和页面新增创建、变更信息显示
- 突变检测新增对比维度，支持选择跟“昨日”“上一小时”统计指标比对逻辑
- 智能巡检事件新增效果反馈入口
- 快照分享支持添加“创建人”水印显示
- 注册开通流程优化，云市场开通路径新增站点选择
- 笔记创建逻辑和添加内容交互调整
- 图表查询新增 label 反选逻辑
- 链路详情页 Span 列表显示逻辑调整，按“持续时间”倒序显示
- 成员管理触发审核流程后角色修改逻辑调整
- 查看器列宽度保存、日志显示多行等逻辑调整

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.59.124（2023 年 03 月 09 日）

pubrepo.guance.com/dataflux/1.59.124:launcher-cfaec26-1679407401

### 观测云更新

- 数据存储策略变更优化
- 图表链接配置优化
- 新增支持创建重名的仪表板、笔记、自定义查看器
- DQL 参数生效优先级调整
- 日志 Message 数据展示优化
- 监控配置页面优化
- SSO 相关优化
- 其他功能优化
    - 商业版开通流程支持 “观测云直接开通”、“阿里云市场开通“和“亚马逊云市场开通“三种方式任意选择；
    - 查看器左 * 查询功能范围调整，新开通的工作空间不再默认支持左 * 查询，如有需求请联系客户经理；
    - SLIMIT 限制调整，时序图查询若存在 group by 分组时，默认返回最多 20 条数据；
    - 新创建的工作空间新手引导流程优化。

### DataKit 更新 

- 新加功能
    - Pipeline 支持 key 删除
    - Pipeline 增加新的 KV 操作
    - Pipeline 增加时间函数
    - netstat 支持 IPV6
    - diskio 支持 io wait 指标
    - 容器采集允许 Docker 和 Containerd 共存
    - 整合 Datakit Operator 配置文档
- 功能优化
    - 优化 Point Checker
    - 优化 Pipeline replace 性能
    - 优化 Windows 下 Datakit 安装流程
    - 优化 confd 配置处理流程
    - 添加 Filebeat 集成测试能力
    - 添加 Nginx 集成测试能力
    - 重构 OTEL Agent
    - 重构 Datakit Monitor 信息

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## v1.58.123（2023 年 03 月 07 日）

pubrepo.guance.com/dataflux/1.58.123:launcher-a4e6282-1678200092

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复 Profiling 的数据过期清理的 bug
- 修复 DQL series_sum 函数计算逻辑的 bug

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.58.122（2023 年 03 月 04 日）

pubrepo.guance.com/dataflux/1.58.122:launcher-08db157-1677907360

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复 RUM Session Replay 功能播放时 bug
- 一些其他小 bug 修复

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.58.121（2023 年 02 月 23 日）

pubrepo.guance.com/dataflux/1.58.121:launcher-105a217-1677566915

### 观测云更新

- 用户访问监测优化
    - 新增用户访问监测自动化追踪
    - 用户访问监测应用列表、查看器、分析看板布局整体调整
    - 新增 CDN 质量分析
- 场景优化
    - 新增自定义查看器导航菜单
    - 增强场景视图变量级联功能
    - 饼图新增合并配置选项
- 其他功能优化
    - 观测云商业版注册流程支持绑定观测云费用中心账号；
    - 配置监控器时，「检测维度」支持非必选。
    - 图表查询中 match / not match 运算符翻译逻辑调整，日志类数据中 match 去除默认右 * 匹配逻辑。

### DataKit 更新

- 新加功能
    - 命令行增加解析行协议功能
    - Datakit yaml 和 helm 支持资源 limit 配置
    - Datakit yaml 和 helm 支持 CRD 部署
    - 添加 SQL-Server 集成测试
    - RUM 支持 resource CDN 标注
- 功能优化
    - 优化拨测逻辑
    - 优化 Windows 下安装提示
    - 优化 powershell 安装脚本模板
    - 优化 k8s 中 Pod, ReplicaSet, Deployment 的关联方法
    - 重构 point 数据结构及功能
    - Datakit 自带 eBPF 采集器二进制安装

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.57.120（2023 年 01 月 12 日）

pubrepo.guance.com/dataflux/1.57.120:launcher-e5345d3-1675061598

### 观测云更新

- 观测云英文语言支持
- 新增观测云站点服务 Status Page
- 新增绑定自建 Elasticsearch / OpenSearch 索引
- 新增网络查看器列表模式
- 新增前端应用 Span 请求耗时分布显示
- 优化用户访问监测 Session 交互逻辑
- Pod 指标数据采集默认关闭
- 其他功能优化
    - 绑定 MFA 认证调整为邮箱验证
    - 注册时调整手机验证为邮箱验证
    - 登录时安全验证调整为滑块验证
    - 创建工作空间新增观测云专属版引导
    - 工作空间新增备注显示功能
    - 云账号结算用户新增在观测云付费计划与账单查看账单列表
    - 表格图支持基于 「by 分组」设置别名
    - 优化监控器配置中的时序图，仅在选择维度后显示
    - 优化日志类数据数据断档告警配置
    - OpenAPI 新增创建接口

### 最佳实践更新

- 云平台接入：AWS - EKS 部署 DataKit。
- 监控 Monitoring：应用性能监控 (APM) - 调用链 - 使用 datakit-operator 注入 dd-java-agent。

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.56.119（2022 年 12 月 29 日）

pubrepo.guance.com/dataflux/1.56.119:launcher-e4d9302-1672825365

### 观测云更新

- 新增工作空间 MFA 认证管理
- 新增工作空间 IP 访问登录白名单
- 新增 Service 网络拓扑
- 其他功能优化
    - Pipeline 使用优化
    - 日志聚类分析支持自定义字段
    - 超大日志切割后支持查看其关联日志
    - 备份日志显示优化
    - 数据授权敏感字段支持除指标以外所有类型的数据

### DataKit 更新

- Prometheus 采集器支持通过 Unix Socket 采集数据
- 允许非 root 用户运行 DataKit
- 优化 eBPF 中 httpflow 协议判定
- 优化 Windows 下 Datakit 安装升级命令
- 优化 Pythond 使用封装
- Pipeline 提供更详细的操作报错信息
- Pipeline reftable 提供基于 SQLite 的本地化存储实现

### 智能巡检更新

- 官方智能巡检「内存泄露」、「应用性能检测」、「磁盘使用率」下线
- 新增云账户实例维度账单巡检
- 新增阿里云抢占式实例存活巡检

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.55.117（2022 年 12 月 15 日）

pubrepo.guance.com/dataflux/1.55.117:launcher-f4f56ef-1672025178

### 观测云更新

- 新增 Profile、network 计费
- 观测云注册流程优化
- 新增作战室功能
- 新增仪表板轮播功能
- 工作空间绑定外部 SLS 索引
- 链路查看器图表显示优化
- 其他功能优化
    - 视图变量交互优化
    - 绑定内置视图配置交互优化
    - 工作空间欠费锁定流程优化
    - 工作空间邀请用户体验优化
    - 帮助文档新增评价系统，包括文档较好和较差
    - 监控器批量功能优化
    - SLO新增启用/禁用功能
    - 模糊匹配 Wildcard 左 * 匹配查询限制优化

### DataKit 更新

- 新增 Golang Profiling 接入
- logfwd 支持通过 LOGFWD_TARGET_CONTAINER_IMAGE 来支持 image 字段注入
- trace 采集器：
- 优化 error-stack/error-message 格式问题
- SkyWalking 兼容性调整，支持 8.X 全序列
- eBPF httpflow 增加 pid/process_name 字段，优化内核版本支持
- datakit.yaml 有调整，建议更新 yaml
- GPU 显卡采集支持远程模式

### 智能巡检更新

- 智能巡检新增引导页
- 智能巡检组件支持配置自定义跳转链接

### 最佳实践更新

- 场景 (Scene) - SpringBoot 项目外置 Tomcat 场景链路可观测

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.54.116（2022 年 12 月 01 日）

pubrepo.guance.com/dataflux/1.54.116:launcher-56de9cd-1670394824

### 观测云更新

- 应用性能新增服务清单功能
- 仪表板图表使用体验优化
    - 新增图表单位、颜色、别名的手动输入，您可以按照当前的规范自定义预设单位、颜色和别名，如单位的输入格式为：聚合函数(指标)，如 last(usage_idle)
    - 时序图新增 Y 轴配置，您可以手动配置 Y 轴的最大值和最小值
    - 时序图、饼图新增分组显示，开启后图例中仅显示标签值
    - 蜂窝图、中国地图、世界地图新增渐变区间，包括自动和自定义
    - 柱状图、直方图显示优化
- 视图变量使用体验优化
    - 视图变量新增支持多选
    - 视图变量配置时新增是否设置多个默认值
- 用户访问监测 Session 查看器调整
- 事件新增移动端跳转选项
- 其他功能优化
    - 新手引导页优化，支持最小化
    - 用户访问监测应用列表优化，新增时间控件自定义区间切换查询
    - 主机添加 Label 交互优化

### 智能巡检更新

- Kubernetes Pod 异常重启巡检
- MySQL 性能巡检
- 服务端应用错误巡检
- 内存泄漏巡检
- 磁盘使用率巡检
- 应用性能巡检
- 前端应用日志错误巡检

### 最佳实践更新

- 应用性能监控 (APM) - 性能优化 - 利用 async-profiler 对应用性能调优

### 私有部署版更新

- 支持使用自定义镜像仓库
- 支持在部署时，一键创建中件间基础设施：MySQL、Redis、OpenSearch、TDengine 等
- 支持 MySQL 8.x

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## v1.53.115（2022年11月17日）

pubrepo.guance.com/dataflux/1.53.115:launcher-0da0220-1669271832

### 观测云更新

- Pipeline 使用体验优化
    - Pipeline 支持过滤条件配置多选
    - 支持将任意一个 Pipeline 脚本设置为“默认 Pipeline 脚本“
    - 脚本函数归类
- 事件优化
    - 支持写入用户的自定义事件
    - 未恢复事件查看器左侧新增快捷筛选
- 自定义查看器支持选择更多类型的数据
- 成员管理新增成员分组功能
- 优化内置视图绑定功能
- 新增一键导入导出工作空间内的仪表板、自定义查看器、监控器
- 应用性能监测日志页面新增自定义关联字段
- 其他功能优化
    - 当筛选条件使用模糊匹配和模糊不匹配的时候，支持左 \* 匹配
    - 基础设施分析维度优化，在主机详情页主机最后上报时间
    - 支持用户快速登录到上一次单点登录
    - 黑名单的应用性能监测新增支持过滤“全部服务”
    - “中国区4（广州）”站点注册的用户升级到商业版流程优化
    - 字段描述支持在快捷筛选、显示列等处查看

### DataKit 更新

- 新增 SNMP 采集器
- 新增 IPMI 采集器
- 新增批量注入 DDTrace-Java 工具
- 最新 DDTrace-Java SDK 增强了 SQL 脱敏功能
- Pipeline 支持来源映射关系配置，便于实现 Pipeline 和数据源之间的批量配置
- Pipeline 提供了函数分类信息，便于远程 Pipeline 编写
- 优化 Kafka 消息订阅，不再局限于获取 SkyWalking 相关的数据，同时支持限速、多版本覆盖、采样以及负载均衡等设定
- 通过提供额外配置参数（ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL），缓解短生命周期 Pod 日志采集问题
- 纯容器环境下，支持 通过 label 方式 配置容器内日志采集
- 新增 Pipeline 函数

### 最佳实践更新

- 观测云小妙招(Skills) - DataKit 配置 HTTPS
- 应用性能监控 (APM) - ddtrace 常见参数用法
- 应用性能监控 (APM) - ddtrace-api 使用指南
- 应用性能监控 (APM) - ddtrace 采样
- 应用性能监控 (APM) - ddtrace log 关联

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.52.114（2022年11月03日）

pubrepo.guance.com/dataflux/1.52.114:launcher-86c0c1f-1668062771

### 观测云更新

- 新增观测云、SLS 联合解决方案
- 优化新手引导页面
- 新增 3 个智能巡检配置文档
- 新增链路错误追踪查看器
- 优化时序图、概览图同期对比功能
- 其他功能优化
    - 仪表板/笔记/查看器在「设置」里面新增 “保存快照” 的按钮；
    - 时间控件新增更多选项；
    - Pipeline 和黑名单功能，新增导入、批量导出、批量删除功能；
    - 智能巡检新增仪表盘、柱状图图表组件；
    - 集成菜单下 Func 页面优化。

### DataKit 更新

- 完善 Prometheus 生态兼容，增加 ServiceMonitor 和 PodMonitor 采集识别
- 增加基于 async-profiler 的 Java Profiling 接入
- eBPF 采集增加 interval 参数，便于调节采集的数据量
- 所有远程采集器默认以其采集地址作为 host 字段的取值，避免远程采集时可能误解 host 字段的取值
- DDTrace 采集到的 APM 数据，能自动提取 error 相关的字段，便于中心做更好的 APM 错误追踪
- MySQL 采集器增加额外字段 Com_commit/Com_rollback 采集

### 最佳实践更新

- 监控 Monitoring
- 应用性能监控 (APM) - Kafka 可观测最佳实践
- 云平台接入
- 阿里云 - 阿里云 ACK 接入观测云

### 私有部署版更新

- 私有部署版本，支持了 Profiling 功能

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.51.112（2022年10月20日）

pubrepo.guance.com/dataflux/1.51.112:launcher-43db8d3-1667315533

此版本是产品迭代版本，主要有如下更新:

### 观测云更新

- 监控优化
    - 新增离群检测
    - 突变检测逻辑优化
    - 区间检测逻辑优化
    - 数据断档配置选择“触发数据断档事件”与“触发恢复事件”配置调整为时间范围配置，并根据输入的时间范围提供建议。
    - 支持基于 “事件” 数据配置监控器检测。
    - 告警配置新增“信息”事件通知等级选择
- 场景图表优化
    - 新增直方图图表组件
    - 概览图、矩形树图、漏斗图新增时间分片功能
    - 时序图“查看相似趋势指标”从仅支持指标查询调整为支持所有数据类型，包括日志、应用性能、用户访问等
    - 排行榜支持查看超出图表宽度全部内容
    - 蜂窝图显示优化
- 查看器优化
    - 查看器支持分析模式
    - 优化关联日志查看体验
- 日志索引优化
- 优化指标分析的图表查询
- 其他功能优化
    - 在用户访问监测应用列表，点击进入应用，在左上角新增下拉菜单选项，帮助用户快速切换查看不同的应用数据
    - 在指标、用户访问监测、应用性能监测、基础设施、安全巡检目录新增 Pipelines 快捷入口

### DataKit 更新

- DataKit 采集器配置和 Pipeline 支持通过 etcd/Consul 等配置中心来同步
- Prometheus Remote Write 优化
- 采集支持通过正则过滤 tag
- 支持通过正则过滤指标集名称
- Pipeline 优化
- 优化 grok() 等函数，使得其可以用在 if/else 语句中，以判定操作是否生效
- 增加 match() 函数
- 增加 cidr() 函数
- 进程采集器增加打开的文件列表详情字段
- 完善外部接入类数据（T/R/L）的磁盘缓存和队列处理
- Monitor 上增加用量超支提示：在 monitor 底部，如果当前空间用量超支，会有红色文字 Beyond Usage 提示
- 优化日志采集 position 功能，在容器环境下会将该文件外挂到宿主机，避免 DataKit 重启后丢失原有 position 记录
- 优化稀疏日志场景下采集延迟问题

### 最佳实践更新

-  基础设施监控 (ITIM) - Ansible 批处理实战
-  日志 - 观测云采集 Amazon ECS 日志

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.50.111（2022年10月12日）

pubrepo.guance.com/dataflux/1.50.111:launcher-a3b4793-1665543227

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复 Pipeline 测试器无法正常使用的问题


## v1.50.110（2022年9月29日）

pubrepo.guance.com/dataflux/1.50.110:launcher-bf5e4a7-1664640281

### 观测云更新

- 新增字段管理
- 指标查看器改造，原「指标查看器」更改为「指标分析」
- 优化指标管理
- 新增以 PDF 格式导出事件内容
- 监控器调整
- 静默规则支持动态配置
- 优化 Pipeline 配置页面
- 其他功能优化
    - 笔记新增全局锁定时间配置，配置好全局锁定时间后，该笔记页面的所有图表都按照该锁定时间显示数据
    - 未恢复事件查询修改成最近 48 小时数据，支持手动刷新
    - 用户访问监测支持同名用户视图覆盖逻辑
    - 智能巡检新增支持自建巡检
    - 生成指标页面操作列调整，新增“在指标分析中打开”和“在指标管理中打开”操作图标
    - 管理导航菜单位置调整，SSO 管理迁移至成员管理，通知对象管理迁移至监控，内置视图迁移至场景

### 最佳实践更新

- 云原生：多个 Kubernetes 集群指标采集最佳实践

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.49.108 (2022年9月23日)

pubrepo.guance.com/dataflux/1.49.108:launcher-833084a-1663915927

### 观测云更新

- 修复几个小 bug

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.49.107 (2022年9月15日)

pubrepo.guance.com/dataflux/1.49.107:launcher-e550301-1663603951

### 观测云更新

- 优化笔记文本组件 Markdown 格式
- 新增基础设施 YAML 显示
- 新增日志查看器 DQL 搜索模式
- 优化应用性能监测，包括链路和Profile 查看器详情页优化
- 优化监控器事件通知内容编辑模式
- 新增静默管理支持配置周期性静默
- 其他功能优化
    - 场景仪表板分组显示优化
    - 基础设施查看器显示优化，新增显示列 CPU 使用率、MEM 使用率等提示信息
    - 指标查看器删除列表查看模式，保留平铺查看模式和混合查看模式
    - 日志多索引支持跳转查看
    - 查看器快捷筛选值 TOP 5 支持查看占比数量，查看器时间字段格式优化，默认显示格式为 2022/09/15 20:53:40
    - 链路查看器时序图新增图例显示、快捷筛选新增 HTTP 相关字段

### 最佳实践更新

- 监控 Monitoring- 中间件（Middleware） - 洞见 MySQL

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.48.106(2022年9月1日)

pubrepo.guance.com/dataflux/1.48.106:launcher-e40becc-1662478572

### 观测云更新

- 计费更新
- 帮助文档目录更新
- 新增 DEMO 工作空间
- 时序图新增事件关联分析
- 日志新增多索引模式
- 优化备份日志规则
- 优化日志上下文
- 优化用户访问监测
    - 新增自定义用户访问监测应用 ID
    - 新增用户访问监测网络请求 ERROR 错误关联链路查看
- 智能巡检全面升级
- 优化监控
    - 调整分组为告警策略
    - 优化监控器配置
    - 新增「基础设施存活检测」
    - 新增「进程异常检测」
    - 优化「应用性能指标检测」
- 优化成员管理
- 其他功能优化
    - 图表中指标聚合函数从默认的 last 变更为 avg，日志类数据聚合函数从默认的 last 变更为 count
    - 优化时序图、饼图图例复制体验
    - 优化笔记编辑模式下的交互显示
    - 快照支持保存当前查看器的显示列信息
    - 链路详情页针对时间的字段做格式化显示，把时间戳转换成日期格式显示
    - 部署版管理后台支持修改工作空间的数据保存策略

### DataKit 更新

**1.Breaking changes**

- Gitlab 以及 Jenkins 采集器中，CI/CD 数据有关的时间字段做了调整，以统一前端页面的数据展示效果

**2.采集器功能调整**

- 优化 IO 模块的数据处理，提升数据吞吐效率
- 在各类 Trace 上加上的磁盘缓存功能
- DataKit 自身指标集增加 goroutine 使用有关的指标集（`datakit_goroutine`）
- MySQL 采集器增加 `mysql_dbm_activity` 指标集
- 增加netstat 采集器
- TDengine 增加日志采集
- 优化磁盘采集器中的 fstype 过滤，默认只采集常见的文件系统
- 日志采集器中，针对每条日志，增加字段 `message_length` 表示当前日志长度，便于通过长度来过滤日志
- CRD 支持通过 DaemonSet 来定位 Pod 范围
- eBPF 移除 go-bindata 依赖
- 容器采集器中默认会打开k8s 和容器相关的指标，这在一定程度上会消耗额外的时间线

**3.Bug 修复**

- 修复 DataKit 自身 CPU 使用率计算错误
- 修复 SkyWalking 中间件识别问题
- 修复 Oracle 退出问题
- 修复 Sink DataWay 失效问题
- 修复 HTTP /v1/write/:category 接口 JSON 写入问题

**4.文档调整**

- 几乎每个章节都增加了跳转标签，便于其它文档永久性引用
- pythond 文档已转移到自定义开发目录
- 采集器文档从原来「集成」迁移到 「DataKit」文档库
- DataKit 文档目录结构调整，减少了目录层级
- 几乎每个采集器都增加了 k8s 配置入口
- 调整文档头部显示，除了操作系统标识外，对支持选举的采集器，增加选举标识

更多 DataKit 更新可参考 [DataKit 版本历史](https://docs.guance.com/datakit/changelog/)。

### 最佳实践更新

- 云原生
    - [使用 CRD 开启您的 Ingress 可观测之路](https://docs.guance.com/best-practices/cloud-native/ingress-crd/)
- 监控 Monitoring
    - 应用性能监控 (APM) - [DDtrace 自定义 Instrumentation](https://docs.guance.com/best-practices/monitoring/ddtrace-instrumentation/)
    - 应用性能监控 (APM) - [DDtrace 观测云二次开发实践](https://docs.guance.com/developers/ddtrace-guance/)

更多最佳实践更新可参考 [最佳实践版本历史](https://docs.guance.com/best-practices/)。

## v1.47.103(2022年8月18日)

pubrepo.guance.com/dataflux/1.47.103:launcher-e472ac9-1661174654 

### 观测云计费更新

- 观测云计费项应用性能、用户访问、日志新增数据保存策略以及对应单价

### 观测云更新

- 优化查看器
    - 新增筛选历史
    - 新增快捷筛选值排序
    - 新增时间控件输入格式提示页
    - 新增显示列字段分割线及文案提示
- 新增场景仪表板**/**笔记**/**查看器的查看权限。
- 新增快照的查看权限
- 优化监控器和事件
    - 新增监控器测试
    - 优化智能巡检信息展示
    - 优化事件详情页
- 其他功能优化
    - 观测云新增支持邮箱验证方式认证
    - 查看器详情页关联网络页面优化主机、Pod、Deployment 类型显示；
    - 仪表板和内置视图等地方添加图表时新增切换图标，调整视图变量编辑按钮位置；
    - 时序图图例值新增 sum 求和统计，同时优化图例显示和交互；
    - 监控器、图表查询日志类数据时筛选条件新增 wildcard 和 not wildcard 。

### DataKit 更新

- Pipeline 中新增 reftable 功能
- DataKit 9529 HTTP 支持绑定到 domain socket
    - 对应的 eBPF 采集和 Oracle 采集，其配置方式也需做对应变更。
- RUM sourcemap 增加 Android R8 支持
- CRD 增加日志配置支持
    - 完整示例
- 优化容器采集器文档
- 新增常见 Tag 文档
- 优化选举的配置和一些相关的命名
- 选举类采集器在 DataKit 开启选举的情况下，仍然支持在特定的采集器上关闭选举功能
- 支持指定数据类型的 io block 配置
- DDTrace 采集器的采样增加 meta 信息识别
- DataKit 自身指标集增加 9529 HTTP 请求相关指标
- 优化 Zipkin 采集的内存使用
- DDTrace 采集器在开启磁盘缓存后，默认变成阻塞式 IO feed
- eBPF 增加进程名（process_name）字段
- DCA 新版本发布
- 日志类 HTTP 数据写入（logstreaming/Jaeger/OpenTelemetry/Zipkin）均增加队列支持
- 日志采集增加自动多行支持
- 修复 MySQL 采集器连接泄露问题
- 修复 Pipeline Json 取值问题
- 修复 macOS 上 ulimit 设置无效问题
- 修复 sinker-Dataway 在 Kubernetes 中无效问题
- 修复 HTTP 数据写入类接口数据校验问题
- 修复 eBPF 采集器因内核变更后结构体偏移计算失败问题
- 修复 DDTrace close-resource 问题

### 最佳实践更新

- 监控 Monitoring
    - 使用 extract + TextMapAdapter 实现了自定义 traceId
- 洞见 Insight
    - 场景(Scene) - CDB
    - 场景(Scene) - CLB
    - 场景(Scene) - COS
    - 场景(Scene) - CVM
    - 场景(Scene) - 内网场景 Dubbo 微服务接入观测云

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.46.102(2022年8月10日)

pubrepo.guance.com/dataflux/1.46.102:launcher-9765d09-1660104260 

### 观测云更新
- Func 平台小 bug 修复

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.46.101(2022年8月9日)

pubrepo.guance.com/dataflux/1.46.101:launcher-a785aaa-1660058667 

### 观测云更新
- DCA Web 端上线
- 优化查看器搜索、快捷筛选、时间控件、显示列
- 优化查看器详情页
- 新增全局的查看器自动刷新配置
- 新增全局黑名单功能
- 新增自定义功能菜单
- 新增图表查询别名
- 新增时序图、饼图图例样式
- 优化对象历史数据保存策略
- 调整保存快照的位置
- 其他功能优化
    - 时序图时间间隔新增到毫秒级
    - 管理后台新增工作空间级别的索引配置调整入口
    - 日志查看器分布图新增支持自定义选择时间间隔
    - RUM查看器页面新增当前数据扩展字段页面展示

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.45.100(2022年8月4日)

pubrepo.guance.com/dataflux/1.45.100:launcher-38e7844-1659597427 

### 观测云更新

- 优化链路写入性能
- 其他的一些 bug 修复

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.45.99(2022年7月26日)

pubrepo.guance.com/dataflux/1.45.99:launcher-fe8f074-1658756821 

### 观测云更新
- 新增智能巡检功能：内存泄漏、磁盘使用率、应用性能检测
- 优化查看器搜索和筛选功能：搜索新增「not wildcard 反向模糊匹配」、快捷筛选新增空间级和个人级筛选方式
- 新增修改** URL **中的时间范围进行数据查询
- 新增仪表板视图变量日志、应用性能、用户访问、安全巡检数据来源配置
- 优化图表查询交互
- 新增用户访问指标检测事件通知模板变量
- 优化事件内容一键打开链接

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

### 最佳实践更新

- [Rancher部署DataKit最佳实践](https://preprod-docs.cloudcare.cn/best-practices/partner/rancher-datakit-install/)
- [腾讯云产品可观测最佳实践(Function)](https://preprod-docs.cloudcare.cn/best-practices/partner/tencent-prod-func/)

更多详情可参考最佳实践帮助文档：[https://docs.guance.com/best-practices/](https://docs.guance.com/best-practices/)

### DataKit 更新

- prom 采集器的内置超时时长为 3 秒
- 日志相关问题修复：
    - 添加日志采集的 log_read_offset 字段
    - 修复日志文件在 rotate 后没有正确 readAll 的 bug
- 容器采集相关问题修复：
    - 修复对环境变量 NODE_NAME 的不兼容问题
    - k8s 自动发现的 prom 采集器改为串行式的、node 分散采集
    - 添加日志 source 和多行的的映射配置
    - 修复容器日志替换 source 后还使用之前的 multiline 和 pipeline 的 bug
    - 修正容器日志，设置文件活跃时长是 12 小时
    - 优化 docker 容器日志的 image 字段
    - 优化 k8s pod 对象的 host 字段
    - 修复容器指标和对象采集没有添加 host tag 的问题
- eBPF 相关：
    - 修复 uprobe event name 命名冲突问题
    - 增加更多环境变量配置，便于云 k8s 环境的部署
- 优化 APM 数据接收接口的数据处理，缓解卡死客户端以及内存占用问题
- SQLServer 采集器修复：
    - 恢复 TLS1.0 支持
    - 支持通过 instance 采集过滤，以减少时间线消耗
- Pipeline 函数 adjust_timezone() 有所调整
- IO 模块优化，提高整体数据处理能力，保持内存消耗的相对可控
- Monitor 更新：
    - 修复繁忙时 Monitor 可能导致的长时间卡顿
    - 优化 Monitor 展示，增加 IO 模块的信息展示，便于用于调整 IO 模块参数
- 修复 Redis 奔溃问题
- 去掉部分繁杂的冗余日志
- 修复选举类采集器在非选举模式下不追加主机 tag 的问题

更多详情可参考 DataKit 帮助文档：[https://docs.guance.com/datakit/changelog/](https://docs.guance.com/datakit/changelog/) 

## v1.44.98(2022年7月7日)

pubrepo.guance.com/dataflux/1.44.98:launcher-75d7974-1657638696 

### 观测云更新

- 优化查看器正选、反选、模糊匹配三种筛选模式
- 优化查看器快捷筛选
- 新增查看器显示列多种快捷操作
- 优化查看器详情页属性/字段快捷筛选
- 优化历史快照功能，支持三种时间保存策略
- 新增 Pipeline 一键获取样本测试数据
- 新增场景自定义查看器文本分析模式
- 新增日志查看器详情页关联网络 pod 和 deployment 视图
- 新增查看器详情页关联网络 48 小时数据回放功能
- 调整未恢复事件保存策略，支持手动恢复事件
- 其他功能优化
  - 图表锁定时间新增【最新5分钟】时间范围，时间间隔新增【5s】【10s】【30s】三个秒级时间选择
  - 场景查看器显示列、视图变量基础对象字段属性/标签支持自定义输入
  - 调整事件详情关联仪表板位置
  - 在指标管理新增时间线数量统计
  - 优化日志详情页关联链路，根据日志当中的 trace_id 和 span_id 显示火焰图并选中对应span的所有数据
  - 优化用户访问监测服务显示及交互
  - RUM、网络、可用性监测、CI 查看器下拉选项调整为平铺显示
  - 监控器事件通知内容支持配置模版变量字段映射，支持通过在 DQL 查询语句配置模版变量对应值。
  - 帮助中心首页新增重点功能快捷跳转入口

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

### DataKit 更新

- 调整全局 tag 的行为，避免选举类采集的 tag 分裂
- SQLServer 采集器增加选举支持
- 行协议过滤器支持所有数据类型
- 9529 HTTP 服务增加超时机制
- MySQL：dbm 指标集名字调整、service 字段冲突问题
- 容器对象增加字段 container_runtime_name 以区分不同层次的容器名
- Redis 调整 slowlog 采集，将其数据改为日志存储
- 优化 TDEngine 采集
- 完善 Containerd 日志采集
- Pipeline 增加 Profile 类数据支持
- 容器/Pod 日志采集支持在 Label/Annotation 上额外追加 tag
- 修复 Jenkins CI 数据采集的时间精度问题
- 修复 Tracing resource-type 值不统一的问题
- eBPF 增加 HTTPS 支持
- 修复日志采集器可能的奔溃问题
- 修复 prom 采集器泄露问题
- 支持通过环境变量配置 io 磁盘缓存
- 增加 Kubernetes CRD 支持

更多详情可参考 DataKit 帮助文档：[https://docs.guance.com/datakit/changelog/](https://docs.guance.com/datakit/changelog/)

### 最佳实践更新

- Skywalking 采集 JVM 可观测最佳实践
- Minio 可观测最佳实践

更多详情可参考最佳实践帮助文档：[https://docs.guance.com/best-practices/](https://docs.guance.com/best-practices/) 

## v1.43.97(2022年6月22日)

pubrepo.guance.com/dataflux/1.43.97:launcher-508cfe1-1656344897 

### 观测云更新
- 观测云帮助文档全新上线
- 新增 Profile 可观测
- Pipeline 覆盖了全数据的文本分析处理
- 新增 Deployment 网络详情及网络分布
- 优化事件检测维度跳转到其他查看器
- 新增日志查看器 JSON 格式的 message 信息搜索
- 新增用户访问监测新建应用时支持用户自定义输入 app_id 信息
- 优化进程检测为基础设施对象检测
- 其他功能优化
    - 基础设施POD查看器蜂窝模式下新增 CPU 使用率、内存使用量填充指标
    - 优化日志黑名单配置。支持手动输入日志来源，作为日志黑名单的来源
    - 优化应用性能监测服务列表数据查询时间组件，支持自定义时间范围选择
    - 优化在 K8S 上安装 DataKit 引导文案，配置 DataWay 数据网关地址中自动增加当前工作空间的 token
    - 优化监控器配置 UI 样式 

### DataKit 更新

- gitrepo 支持无密码模式
- prom 采集器
- 支持日志模式采集
- 支持配置 HTTP 请求头
- 支持超 16KB 长度的容器日志采集
- 支持 TDEngine 采集器
- Pipeline
- 支持 XML 解析
- 远程调试支持多类数据类型
- 支持 Pipeline 通过 use() 函数调用外部 Pipeline 脚本
- 新增 IP 库（MaxMindIP）支持
- 新增 DDTrace Profile 集成
- Containerd 日志采集支持通过 image 和 K8s Annotation 配置过滤规则
- 文档库整体切换 

### 最佳实践更新

- APM：GraalVM 与 Spring Native 项目实现链路可观测
- 接入集成：主机可观测最佳实践 (Linux) 

### 集成模版更新
- 新增文档
    - 阿里云 NAT
    - 阿里云 CDN
- 新增视图
    - 阿里云 NAT
    - 阿里云 CDN 

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.42.95(2022年6月10日)
pubrepo.guance.com/dataflux/1.42.95:launcher-8478e83-1654839989 

### 观测云计费更新

- 优化时间线计费逻辑，以及指标数据的数据保存策略

### 观测云更新

- 新增 Jenkins CI 可观测
- 新增自定义查看器图表同步搜索
- 新增网络拓扑和服务拓扑下钻分析
- 新增删除资源目录的数据及索引
- 新增查看器快照查看入口
- 新增查看器筛选条件编辑功能
- 优化用户访问 View 查看器关联链路为 Fetch/XHR
- 新增图表数据加载高性能模式
- 新增告警配置事件通知等级
- 其他功能优化
    - 场景仪表板组合图表支持隐藏/显示大标题
    - 优化事件详情页事件类型文案显示
    - 基础设施列表查看新增按照字段排序功能
    - 日志查看器新增隐藏分布图按钮
    - 查看器支持通过关键字搜索显示列，支持自定义显示列作为预设字段，后续通过Pipeline切割字段并上报数据后可直接显示上报的数据。
    - 在内置模板库和内置视图增加一键查看对应的集成文档，帮助您快速配置对应的采集器
    - 内置视图除支持在查看器绑定链路服务、应用、日志源、项目、标签等相关视图外，新增支持自定义 key 和 value 绑定相关视图，同时支持服务侧滑详情页绑定内置视图
    - 优化通知对象飞书机器人，支持自定义是否需要密钥安全校验
    - 配置监视器时，若配置的数据范围小于检测频率，触发提示配置会存在数据空洞问题

### DataKit 更新（2022/5/12）

- Pipeline 做了调整，所有数据类型，均可通过配置 Pipeline 来额外处理数据
- grok() 支持直接将字段提取为指定类型，无需再额外通过 cast() 函数进行类型转换
- Pipeline 增加多行字符串支持，对于很长的字符串（比如 grok 中的正则切割），可以通过将它们写成多行，提升了可读性
- 每个 Pipeline 的运行情况，通过 datakit monitor -V 可直接查看
- 增加 Kubernetes Pod 对象 CPU/内存指标
- Helm 增加更多 Kubernetes 版本安装适配
- 优化 OpenTelemetry，HTTP 协议增加 JSON 支持
- DataKit 在自动纠错行协议时，对纠错行为增加了日志记录，便于调试数据问题
- 移除时序类数据中的所有字符串指标
- 在 DaemonSet 安装中，如果配置了选举的命名空间，对参与选举的采集器，其数据上均会新增特定的 tag（election_namespace）
- CI 可观测，增加 Jenkins 支持

### 最佳实践更新

- APM
    - 基于观测云，使用 SkyWalking 实现 RUM、APM 和日志联动分析
- 监控最佳实践
    - OpenTelemetry 可观测建设
    - OpenTelemetry to Jaeger 、Grafana、ELK
    - OpenTelemetry to Grafana
    - OpenTelemetry to 观测云
- 观测云小妙招
    - OpenTelemetry 采样最佳实践

### 集成模版更新

- 新增文档和视图
    - Opentelemetry Collector
    - Kubernetes Scheduler
    - Kubernetes Controller Manager
    - Kubernetes API Server
    - Kubernetes Kubelet
- 新增视图
    - Kubernetes Nodes Overview
    - JVM Kubernetes

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.41.94(2022年5月28日)

pubrepo.guance.com/dataflux/1.41.94:launcher-249ba21-1653737335 

### 观测云更新

- 优化观测云商业版注册流程
- 新增场景仪表板用户视图模版库
- 新增场景自定义查看器日志来源及筛选联动
- 新增事件详情页内容复制为Json格式
- 新增日志数据脱敏处理
- 优化日志查看器及详情页
- 新增网络数据检测监控器
- 优化内置视图绑定功能
- 其他功能优化
    - 付费计划与账单新增预购卡余额
    - 基础设施详情样式优化
    - 链路详情页属性换行显示优化
    - 监控器配置模版变量显示优化
    - 增加快捷入口，DQL查询和快照菜单移至快捷入口下
    - 观测云管理后台补充模版管理分类信息

### DataKit 更新（2022/5/12）

- eBPF 增加 arm64 支持
- 行协议构造支持自动纠错
- DataKit 主配置增加示例配置
- Prometheus Remote Write 支持 tag 重命名
- 合并部署版 DataKit 已有的功能，主要包含 Sinker 功能以及 filebeat 采集器
- 调整容器日志采集，DataKit 直接支持 containerd 下容器 stdout/stderr 日志采集
- 调整 DaemonSet 模式下主机名获取策略
- Trace 采集器支持通过服务名（service）通配来过滤资源（resource）

### 最佳实践更新

- 云原生
    - 利用观测云一键开启Rancher可观测之旅
- 微服务可观测最佳实践
    - Kubernetes 集群 应用使用 SkyWalking 采集链路数据
    - Kubernetes 集群日志上报到同节点的 DataKit 最佳实践
- Gitlab-CI 可观测最佳实践

### 集成模版更新

- 新增文档和视图
    - Resin
    - Beats
    - Procstat
- 新增视图
    - Istio Service
    - ASM Service

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.40.93(2022年5月9日)

pubrepo.guance.com/dataflux/1.40.93:launcher-aa97377-1652102035 

### 观测云更新

- 优化观测云商业版升级流程
- 新增进程、日志、链路详情页关联网络
- 场景模块优化
    - 优化仪表板，去掉编辑模式
    - 新增图表链接显示开关
    - 优化 DQL 查询与简单查询转换
- 监控器和事件模块优化
    - 新增事件关联信息
    - 新增数据断档事件名称和内容配置
    - 优化可用性数据检测
    - 优化告警通知模版，增加关联跳转链接
- 其他功能优化
    - 优化服务 servicemap 指标查询性能
    - 新增查看器数值型字段支持5种写法
    - 新增指标查看器标签支持级联筛选
    - 优化 DQL 查询返回报错提示

### DataKit 更新

- 进程采集器的过滤功能仅作用于指标采集，对象采集不受影响
- 优化 DataKit 发送 DataWay 超时问题
- 优化 Gitlab 采集器 
- 修复日志采集截断的问题
- 修复各种 trace 采集器 reload 后部分配置不生效的问题

### 集成模版更新

- 新增数据存储 Redis Sentinel 集成文档和视图

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.39.92(2022年5月5日)

pubrepo.guance.com/dataflux/1.39.92:launcher-ffcd8f2-1651715327 

### 安装器 Launcher：

- 支持更换域名的 TLS 证书
- 适配 Ingress Kind 的 networking.k8s.i0/v1、extensions/v1beta1 两种 apiVersion
- 其他一些小 Bug 修复

## v1.39.91(2022年4月26日)

pubrepo.guance.com/dataflux/1.39.91:launcher-8943ead-1650979666 

### 观测云更新

- 一些前端 Bug 修复

## v1.39.90(2022年4月25日)

pubrepo.guance.com/dataflux/1.39.90:launcher-23f161d-1650898148 

### 观测云更新

- 新增 Gitlab CI 可观测
- 新增在线帮助手册
- 新增仪表板设置刷新频率
- 新增进程 48 小时回放
- 新增集成 DataKit Kubernetes(Helm)安装引导页
- 新增应用性能全局概览、服务分类筛选、服务拓扑图区分环境和版本
- 其他功能优化
    - 新增链路详情页中关联日志“全部来源”选项 
    - 新增指标筛选支持反选，聚合函数位置调整
    - 优化日志、应用性能、用户访问、安全巡检生成指标，“频率”所选时间也作为聚合周期
    - 优化观测云部署版工作空间拥有者移交权限功能取消，支持管理后台设置
    - 优化告警通知短信模版
    - 优化可用性监测新建拨测列表，支持直接选择 HTTP、TCP、ICMP、WEBSOCKET 拨测
    - SSO登录配置用户白名单调整为邮箱域名，用于校验单点登录处输入邮箱后缀是否匹配，匹配的邮箱可以在线获取SSO的登录链接

### DataKit 更新

- Pipeline 模块修复 Grok 中动态多行 pattern 问题
- DaemonSet 优化 Helm 安装，增加开启 pprof 环境变量配置，DaemonSet 中所有默认开启采集器各个配置均支持通过环境变量配置
- Tracing 采集器初步支持 Pipeline 数据处理，参考 DDtrace 配置示例。
- 拨测采集器增加失败任务退出机制
- 日志新增 unknown 等级（status），对于未指定等级的日志均为 unknown
- 容器采集器修复：
    - 修复 cluster 字段命名问题
    - 修复 namespace 字段命名问题
    - 容器日志采集中，如果 Pod Annotation 不指定日志 source，那么 source 默认的取值顺序依次为
    - 对象上报不再受 32KB 字长限制（因 Annotation 内容超 32KB），所有 Kubernetes 对象均删除 annotation 
    - 修复 prom 采集器不因 Pod 退出的问题

### 最佳实践更新

- 微服务可观测最佳实践
    - service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)
    - service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(下)
    - service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(中)
- 监控最佳实践
    - JAVA OOM异常可观测最佳实践

### 集成模版更新

- 新增文档
    - 应用性能监测 (APM)：Node.JS
    - 中间件：RocketMQ
- 新增视图
    - 容器编排：K8s Pods Overview 和 Istio Mesh
    - 阿里云：阿里云 ASM Mesh、阿里云 ASM Control Plane 和 阿里云 ASM Workload
    - 中间件：RocketMQ

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.38.89(2022年4月10日)

pubrepo.guance.com/dataflux/1.38.89:launcher-db22a51-1649942760 

### 观测云计费更新

- 新增阿里云账户结算方式

### 观测云更新

- 新增 DQL 查询查看器
- 可用性监测新增 TCP/ICMP/Websocket 拨测协议
- 新增基础设施网络模块
- 基础设施容器 Pod 新增 HTTP 七层网络数据展示
- 新增查看器快捷筛选“反选”和“重置”功能
- 优化日志黑名单
- 其他功能优化
    - 新增链路详情页 span 数量统计
    - 优化链路关联主机时间线绘制方式
    - 优化概览图时间分片，取消选项，若之前的概览图开启了时间分片，优化后默认更改为不开启时间分片
    - 优化组合图表在浏览器缩放情况下，进入编辑后无法实现组合图表切换编辑不同的图表查询
    - 优化日志查看器手动暂停页面刷新后，滚轴滑动到顶部不触发自动刷新 

### DataKit 更新

- 增加宿主机运行时的内存限制，安装阶段即支持内存限制配置，
- CPU 采集器增加 load5s 指标
- 支持观测云优化的日志黑名单功能，调整 monitor 布局，增加黑名单过滤情况展示
- DaemonSet 安装增加 Helm 支持，新增 DaemonSet 安装最佳实践
- eBPF 增加 HTTP 协议采集，主机安装时，eBPF 采集器默认不再会安装，如需安装需用特定的安装指令，DaemonSet 安装不受影响

### 观测云移动端 APP 更新

- 新增站点登陆的能力，优化场景、事件查看器，保持了与网页端查看器相同的访问体验。 

### 最佳实践更新

- 观测云小妙招
    - 多微服务项目的性能可观测实践
    - ddtrace 高级用法
    - Kubernetes 集群使用 ExternalName 映射 DataKit 服务
- 接入(集成)最佳实践
    - OpenTelemetry 链路数据接入最佳实践
- 微服务可观测最佳实践
    - 基于阿里云 ASM 实现微服务可观测最佳实践

### 集成模版更新

- 新增阿里云 PolarDB Oracle 集成文档、视图和监控器
- 新增阿里云 PolarDB PostgreSQL 集成文档、视图和监控器
- 新增阿里云 RDS SQLServer 集成文档、视图和检测库
- 新增阿里云 DataKit 集成文档、视图和监控器
- 新增阿里云 Nacos 集成文档、视图

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.37.86(2022年3月28日)

pubrepo.guance.com/dataflux/1.37.86:launcher-bd2650e-1648456839

### 观测云站点更新

- 新增“海外区1（俄勒冈）”站点，原“中国区1（阿里云）”变更为“中国区1（杭州）”，原“中国区2（AWS）”变更为“中国区2（宁夏）”。

### 观测云更新

- 新增工作空间数据授权
- 新增保存在线 Pipeline 样本测试数据
- 优化资源目录查看器
- 优化快照分享支持永久有效的链接
- 优化图表时间间隔
- 优化进程、应用性能、用户访问检测数据断档触发策略
- 其他功能优化
    - 优化集成DataKit、Func 安装引导页
    - 优化日志查看器单条日志完全展示
    - 新增查看器关联搜索 NOT 组合
    - 优化编辑成员权限显示

### DataKit 更新

- 增加 DataKit 命令行补全功能，帮助您在终端操作的时候进行命令提示和补全参数
- 允许 DataKit 升级到非稳定版，体验最新的试验性功能，若您是生产环境，请谨慎升级
- 初步支持 Kubernetes/Containerd 架构的数据采集
- 网络拨测增加 TCP/UDP/ICMP/Websocket 几种协议支持
- 调整 Remote Pipeline 的在 DataKit 本地的存储，避免不同文件系统差异导致的文件名大小写问题
- Pipeline新增 decode() 函数，可以避免在日志采集器中去配置编码，在 Pipeline 中实现编码转换；add_pattern() 增加作用域管理

### 最佳实践更新

- 场景最佳实践：RUM 数据上报 DataKit 集群最佳实践
- 日志最佳实践：Pod 日志采集最佳实践

### 集成模板更新

- 新增阿里云 PolarDB Mysql 集成文档、视图和检测库

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.36.85(2022年3月14日)

pubrepo.guance.com/dataflux/1.36.85:launcher-d8e6ee9-1647272237 

### 观测云计费更新

- 新增观测云计费预购卡

### 观测云更新

- 新增用户访问监测 resource（资源）、action（操作）、long_task（长任务）、error（错误）查看器
-  新增 Pod 网络详情及网络分布

### DataKit 更新

- DataKit 采集器新增支持 SkyWalking、Jaeger、Zipkin 数据配置采样策略，更多详情可参考 Datakit Tracing Frontend 。
- DataKit 采集器新增支持 OpenTelemetry 数据接入 。
- DataKit 文档库新增文档 DataKit 整体日志采集介绍，包括从磁盘文件获取日志、通过调用环境 API 获取日志、远程推送日志给 DataKit、Sidecar 形式的日志采集四种方式。

### SDK 更新

- 用户访问监测兼容 Opentracing 协议链路追踪工具，Web、小程序、Android、iOS SDK 支持 OTEL、SkyWalking、Jaeger 等链路追踪工具数据联动。

### 最佳实践更新

- 快速上手 pythond 采集器的最佳实践
- 阿里云“云监控数据”集成最佳实践
- logback socket 日志采集最佳实践

### 场景模板更新

- 新增场景自定义查看器 MySQL 数据库查看器模板

### 集成模板更新

- 新增主机系统 EthTool 集成文档和视图
- 新增主机系统 Conntrack 集成文档和视图

## v1.35.84(2022年2月22日)

pubrepo.guance.com/dataflux/1.35.84:launcher-191ef71-1645780061 

- 新增日志配置 **pipeline** 脚本
- 新增 **IFrame** 图表组件
- 新增事件详情历史记录、关联 **SLO**
- 新增保存快照默认开启绝对时间
- 优化监控器数据断档触发事件配置及触发条件单位提示
- 优化图表查询表达式计算单位
- 新增“时间线”按量付费模式
- 其他优化功能
    - 图表查询数据来源日志、应用性能、安全巡检和网络支持全选（*）;
    - 图表查询文案、按钮样式以及文字提示优化；
    - 工作空间操作按钮图标化，如编辑、删除等等。
    - 其他 UI 显示优化
