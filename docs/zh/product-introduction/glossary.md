# 概念先解
---

包括<<< custom_key.brand_name >>>组件、功能、客户端、移动端、版本、计费等名词解释。

## 组件

<<< custom_key.brand_name >>>的组件包括前端控制台 Studio、数据网关 DataWay、数据采集 Agent DataKit、可扩展编程平台 Func。

| 组件                                 | 说明                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| Studio                               | Studio 是<<< custom_key.brand_name >>>的控制台，支持对采集的数据进行全方位的查询和分析。 |
| DataWay                              | DataWay 是<<< custom_key.brand_name >>>的数据网关，主要用于接收 DataKit 发送的数据，然后上报到 DataFlux 中心进行存储。 |
| [DataKit](../datakit/index.md)       | DataKit 是<<< custom_key.brand_name >>>的实时数据采集 Agent，支持上百种数据采集，DataKit 采集数据后会先发送到 DataWay 数据网关，再经由 DataWay 上报到中心进行存储和分析。DataKit 需部署到用户自己的 IT 环境中，支持多个操作系统。<br/>默认采集频率：5分钟 |
| [Func](../dataflux-func/index.md) | Func 即 DataFlux Func，是<<< custom_key.brand_name >>>的扩展编程平台，可用于函数开发、管理和执行。简单易用、只需编写代码并发布，自动为函数生成 HTTP API 接口，官方内置各种开箱即用的脚本库，轻松供<<< custom_key.brand_name >>>调用。 |

<<<% if custom_key.brand_key == 'guance' %>>>

## 存储引擎套件 {#storage-suite}


| 组件                                 | 说明                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| GuanceDB | 是指<<< custom_key.brand_name >>>研发的存储引擎套件总称，包含 GuanceDB for metrics、GuanceDB for logs，以及套件中的所有子组件。 |
| GuanceDB for metrics | <<< custom_key.brand_name >>>的时序指标引擎，专用于时序指标数据的存储与分析，包括 guance-select、guance-insert 和 guance-storage 三个组件。 |
| GuanceDB for logs | <<< custom_key.brand_name >>>的非时序数据存储与分析引擎，适用于日志、APM、RUM 和事件等数据，包括 guance-select、guance-insert 和当前支持的存储引擎 Doris。 |
| guance-select | <<< custom_key.brand_name >>>存储套件中的子组件，专门负责可观测数据的查询与分析。 |
| guance-insert | <<< custom_key.brand_name >>>存储套件中的子组件，专门负责可观测数据的写入。 |
| guance-storage | <<< custom_key.brand_name >>>的时序指标数据存储引擎，负责时序指标数据的存储。 |
| Doris | <<< custom_key.brand_name >>>的非时序数据存储引擎，适用于日志、APM、RUM 和事件等数据。 |

关系架构图：

![](img/glossary.png)

<<<% endif %>>>

## 功能

包括场景、事件、基础设施、指标、日志、应用性能、用户访问、可用性监测、安全巡检等，针对采集上来的数据提供全链路级别的数据分析和洞察能力。

| 功能                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [集成](../integrations/integration-index.md)                             | <<< custom_key.brand_name >>>支持超过上百种数据采集器，包括主机、容器、日志、Nginx、APM、RUM 等，只需安装 DataKit 即可开启不同数据的实时采集，并上报到<<< custom_key.brand_name >>>工作空间进行数据分析。您可以在集成查看如何安装 Datakit、Func、DCA、移动端。 |
| [场景](../scene/index.md)                                    | 在场景中支持对采集上来的数据进行可视化的图表展示，现支持三种展示方式，分别为**仪表板**、**笔记**、**查看器**。<br><li>[仪表板](../scene/dashboard/index.md)：仪表板是由多个可视化图表组合而成，用于同时查看和分析主题相关的各种数据，获得较为全面的信息，可自由调整布局和图表大小；<br/><li>[笔记](../scene/note.md)：笔记是由文本文档和其他可视化图表组成，布局固定，由上至下。可通过图文结合进行数据分析和总结报告；<br/><li>[查看器](../scene/explorer/index.md)：在这里你可以快速搭建日志查看器，支持自定义添加统计图表，设置默认显示属性及筛选条件，定制化你的日志查看需求。<br/><li>[内置视图](../scene/built-in-view/index.md)：包括**系统视图**和**用户视图**两部分，系统视图为官方提供的视图模板，用户视图为用户自定义创建并保存作为模板使用的视图，支持从系统视图克隆，可用于场景和查看器详情绑定视图。 |
| [事件](../events/index.md)                                   | 事件是由监控器、智能巡检、SLO、系统操作以及 Open API 写入所产生的，支持对所有来源触发的事件进行实时监控、统一查询、未恢复事件统计和数据导出，基于事件数据可追溯过去某个时间阶段发生的异常情况 |
| [基础设施](../infrastructure/index.md)                       | 数据采集的实体基础设施，当前支持主机、容器、进程、K8s等实体对象的采集。 |
| [指标](../metrics/index.md)                                  | <li>[指标集](../metrics/dictionary.md)：同一类型指标的集合，一般同一个指标集里面指标标签是相同的，一个指标集可以包含多个指标。<br/><li>[指标](../metrics/dictionary.md)：指标可以帮助了解系统的整体可用性，比如：服务器 CPU 使用情况，网站的加载耗时、剩余磁盘空间等。指标分为指标名和指标值两部分，指标名是标识该指标的一个别名，指标值指采集时指标的具体数值。<br/><li>[标签](../metrics/dictionary.md)：标识一个数据点采集对象属性的集合，标签分为标签名和标签值，一个数据点可以有多个标签。例如采集的指标 `CPU 使用率` 时会标识 `host`、`os`、`product` 等属性信息，这些属性统称为标签。<br/><li>[时间线](../metrics/dictionary.md)：当前工作空间，上报的指标数据中基于标签可以组合而成的所有组合数量。在<<< custom_key.brand_name >>>中时间线是由指标、标签（字段）、数据存储时长组合而成的，“指标”和“标签（字段）的组合”是数据存储的主键。 |
| [日志](../logs/index.md)                                     | 用来记录系统或软件运行中产生的实时运行或行为数据，支持前端可视化查看、过滤和分析。 |
| [应用性能监测](../application-performance-monitoring/index.md) | 追踪统计服务处理请求所花费的时间、请求状态以及其他属性信息，可用于应用性能的监控。 |
| [用户访问监测](../real-user-monitoring/index.md)             | 用户访问监测是指在真实用户与您的网站和应用交互时，采集与其真实体验和行为有关的数据。<<< custom_key.brand_name >>>支持 Web、移动端（Android & IOS）、小程序四种用户访问监测类型。 |
| [可用性监测](../usability-monitoring/index.md)               | 利用分布在全球的拨测节点，通过 HTTP、TCP、ICMP 等协议对网站、域名、API 接口等进行周期性监控，支持通过查看可用率和延时的趋势变化来帮助分析站点质量情况。 |
| [安全巡检](../scheck/index.md)                               | 通过新型安全脚本方式对系统，软件，日志等一系列进行巡检，支持数据实时输出，异常问题实时同步，掌握设备运行状况及周围环境的变化，发现设施缺陷和安全隐患，及时采取有效措施。 |
| [CI](../ci-visibility/index.md)                              | <<< custom_key.brand_name >>>支持为 Gitlab 内置的 CI 过程和结果进行可视化，可以在<<< custom_key.brand_name >>>查看所有 CI 可视化的 Pipeline 及其成功率、失败原因、具体失败环节，帮助您提供代码更新保障。 |
| [监控](../monitoring/index.md)                               | <li>[监控器](../monitoring/monitor/index.md)：通过配置检测规则、触发条件和事件通知，第一时间接收告警通知，及时发现发现问题、解决问题。包括阈值检测、突变检测、区间检测、离群检测、日志检测、进程异常检测、基础设施存活检测、应用性能指标检测、用户访问指标检测、安全巡检异常检测、可用性数据检测和网络数据检测。<br/><li>[智能巡检](../monitoring/bot-obs/index.md)：基于<<< custom_key.brand_name >>>的智能算法，自动检测及预见基础设施和应用程序问题，帮助用户发现 IT 系统运行过程中发生的问题，通过根因分析，快速定位异常问题原因。<br/><li>[SLO](../monitoring/slo.md)：SLO 监控是围绕 DevOps 各类指标，测试系统服务可用性是否满足目标需要，不仅可以帮助使用者监控服务商提供的服务质量，还可以保护服务商免受 SLA 违规的影响。 |
| [工作空间](../management/index.md)                           | <<< custom_key.brand_name >>>数据洞察的协作空间，每个工作空间都是相互独立的。用户可以在工作空间进行数据查询与分析，支持通过创建/邀请的方式加入一个或多个工作空间。 |
| [DQL](../dql/query.md)                                       | DQL（Debug Query Language）是<<< custom_key.brand_name >>>的数据查询语言。用户在<<< custom_key.brand_name >>>中可以使用 DQL 查询语法，查询指标型/日志型数据，再进行数据图表可视化。 |
| [Pipeline](../pipeline/index.md)                | Pipeline 是<<< custom_key.brand_name >>>的数据处理工具，通过定义解析规则，支持将指标、日志、用户访问、应用性能、基础对象、资源目录、网络、安全巡检等数据切割成符合要求的结构化数据。 |

## 客户端 DCA

[客户端 DCA (DataKit Control App)](../datakit/dca.md) 是 DataKit 在线管理平台，支持查看 DataKit 运行情况，对采集器、黑名单、Pipeline 进行统一管理配置。

## 移动端 APP

[<<< custom_key.brand_name >>>移动端 APP](../mobile/index.md) 支持在移动设备上接收事件的告警通知，查看工作空间所有场景视图、日志数据，随时随地轻松完成数据分析洞察。

## 版本

<<< custom_key.brand_name >>>提供体验版、商业版、部署版三个版本。

| 版本                                               | 说明                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [体验版](https://<<< custom_key.studio_main_site_auth >>>/businessRegister) | 注册即可体验<<< custom_key.brand_name >>>的功能模块。                               |
| [商业版](../plans/commercial-register.md)        | 云上的 SaaS 公有版本，按量付费，开箱即用，只需要安装 DataKit 后，配置相关数据采集器即完成可观测接入。<br/>关于计费规则，可参考 [计费方式](../billing-method/index.md)。 |
| [部署版](../deployment/index.md)                   | SaaS 云上独立部署和 PaaS 本地部署，需要用户自己准备服务资源，数据安全级别最高，提供更多的服务支持。 |

## 计费

<<< custom_key.brand_name >>>提供专属的计费账户管理平台 **[费用中心](../billing-center/index.md)**，您可以在费用中心为账户充值、查看账户余额及账单明细、绑定工作空间、更换结算方式等操作。

> 关于计费方式和计费项的名词解释，可参考文档 [计费方式](../billing-method/index.md)。

| 功能                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [结算方式](../billing/billing-account/index.md)              | <<< custom_key.brand_name >>>费用结算的方式，支持<<< custom_key.brand_name >>>企业账号、云账号等多种结算方式。<br/><li><<< custom_key.brand_name >>>企业账号：<<< custom_key.brand_name >>>费用中心专用于管理使用<<< custom_key.brand_name >>>产品产生的计费相关的独立账号，一个企业账号可以关联多个工作空间计费。<br/><li>云账号：<<< custom_key.brand_name >>>费用中心支持亚马逊云账号、阿里云账号和华为云账号三种云账号。用户可以选择绑定的云账号来进行费用结算。 |
| [账户管理](../billing-center/account-management.md)     | <<< custom_key.brand_name >>>费用中心账户管理，包括账户资料变更、密码修改、实名认证以及云账号管理。 |
| [工作空间管理](../billing-center/workspace-management.md#workspace-lock) | <<< custom_key.brand_name >>>费用中心账户绑定的工作空间管理，一个账户可绑定多个<<< custom_key.brand_name >>>工作空间。在工作空间管理可修改<<< custom_key.brand_name >>>工作空间的结算方式。 |
| [账单管理](../billing-center/billing-management.md)     | <<< custom_key.brand_name >>>费用中心账单管理，包括月账单、消费明细、收支明细、代金券明细和套餐明细管理。 |
| [支持中心](../billing-center/support-center.md)         | <<< custom_key.brand_name >>>的支持中心，用户可以在支持中心提交和管理工单，<<< custom_key.brand_name >>>技术专家团队收到工单后会及时联系用户解决问题。 |
