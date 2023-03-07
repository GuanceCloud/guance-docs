---
icon: zy/release-notes
---

# 更新日志（2023年）
---

本文档记录观测云每次上线发布的更新内容说明，包括 DataKit、观测云最佳实践、观测云集成文档和观测云。

## 2023 年 3 月 9 号

### 观测云更新

#### 数据存储策略变更优化

若您在同一天内多次变更数据存储策略，仅第一次修改当天生效，二次及以上修改，将以最后一次修改的结果为准，在第二天生效。关于如何变更，可参考文档 [数据存储策略](../billing/billing-method/data-storage.md) 。

#### 场景相关优化

- 新增支持创建重名的仪表板、笔记、自定义查看器
- 图表链接支持选择参数类型快速添加到 url 中
- 视图变量使用 DQL 语句查询时，支持以 [xx:xx:xx] 的格式添加数据查询的时间范围，若在 DQL 查询中添加了时间范围，则优先使用 DQL 查询中的时间范围；若 DQL 查询中未添加时间范围，则默认使用仪表板时间控件所选的时间范围，如需要查询最近 10 分钟的容器主机列表，则 DQL 查询语句为 `O::docker_containers:(distinct(`host`)) [10m]`。更多详情可参考 [视图变量](../scene/view-variable.md) 。

#### 日志 Message 数据展示优化

日志数据显示列新增“全部”显示行数来展开查看日志 Message 数据，涉及的功能包括[日志查看器](../logs/explorer.md) 显示列和查看器详情页关联日志页面的显示列。

![](img/.png)

#### 监控相关优化

- 新增支持配置无数据事件通知内容


- 新增支持内置跳转链接，用于查看相关日志、链路等

监控器支持添加链接，解析dql数据，拼接url，支持中文

- 从监控配置页面返回监控器列表时，保留进入监控器编辑前的筛选条件以及页码

#### 新增一键导入仪表板、自定义查看器、监控器重名提示

在「管理」-「设置」-「配置迁移」一键导入时，若当前工作空间存在重名的仪表板、查看器、监控器，提示导入文件存在重名，用户可以根据实际的需求来选择是否“跳过”、“仍然创建”和“取消”。更多详情可参考文档 [配置迁移](../management/index.md##export-import) 。

![](img/5.input_rename_1.png)

#### SSO 单点登录相关优化

- SSO 用户新增“账号管理”
- SSO 单点登录配置映射规则时，Email 字段兼容大小写

##### 新手引导优化

用户首次注册进入工作空间及新创建工作空间时，新增邀请成员引导功能，您可以通过邮箱直接邀请公司的其他成员加入到当前的工作空间进行协作，支持为邀请的成员设置初始的访问权限，更多详情可参考 [成员管理](../management/member-management.md) 。

![](img/4.new.png)

#### 其他功能优化

- [观测云注册](../billing/commercial-register.md) 优化，注册开通方式不区分站点，包括“[观测云直接开通](../billing/billing-account/enterprise-account.md)”、“[阿里云市场开通](../billing/billing-account/aliyun-account.md)“和“[亚马逊云市场开通](../billing/billing-account/aws-account.md)“三种方式；
- 创建工作空间文案提示优化？新创建的工作空间默认不支持左 * 查询；
- 可用性监测拨测任务配置新增字符长度限制？
- 时序图、DQL 查询工具、查看器分析模式下的时序图 slimit 从 10 调整为 20？


## 2023 年 2 月 28 号

### 观测云更新

#### 新增会话重放功能

会话重放是用户体验网站的重建演示，通过捕获单击、鼠标移动和页面滚动等内容，生成视频记录，深入了解用户的操作体验。更多详情可参考文档 [会话重放](../real-user-monitoring/session-replay/index.md) 。

#### 优化 AWS 开通流程

观测云优化 AWS 云市场一键开通观测云的流程，在 AWS 云市场订阅观测云商品后，可直接开通使用观测云。更多详情可参考文档 [在 AWS 开通观测云](../billing/commercial-aws.md) 。

## 2023 年 2 月 23 号

### 观测云更新

#### 用户访问监测优化

##### 新增用户访问监测自动化追踪

用户访问监测新增自动化追踪，通过“浏览器插件”的实现方式，使用浏览器记录用户访问行为，创建无代码的端到端测试。更多详情可参考文档 [自动化追踪](../real-user-monitoring/self-tracking.md#auto-tracking) 。

##### 用户访问监测应用列表、查看器、分析看板布局整体调整

- 用户访问监测应用列表显示布局调整，支持在应用列表跳转查看当前应用的“分析看板”和“查看器”内容详情。

![](img/11.rum_1.png)

- 用户访问监测“查看器”支持查看所有应用的用户访问数据，您可以通过筛选 “应用ID” 来查看和分析不同应用的数据。

![](img/11.rum_2.png)

- 用户访问监测“分析看板“支持切换查看 Web 端、移动端、小程序的场景分析视图。

![](img/11.rum_3.png)

##### 新增 CDN 质量分析 

用户访问监测新增 CDN 厂商信息采集，通过分析图表对不同厂商的 CDN 进行质量分析。更多配置可参考 [用户访问监测采集器配置](../datakit/rum.md#cdn-resolve) 。

##### 新增 UniAPP 应用接入

用户访问监测新增 UniAPP 应用接入，当前版本支持 Android 和 iOS 平台。更多详情可参考 [UniApp 应用接入](../real-user-monitoring/uni-app/app-access.md) 。

#### 场景优化

##### 新增自定义查看器导航菜单

在场景查看器列表，新增支持将当前查看器添加至基础设施、指标、日志、应用性能监测、用户访问监测、可用性监测、安全巡检、CI 可视化导航菜单。更多详情可参考 [添加查看器导航菜单](../scene/explorer/index.md#menu) 。

##### 增强场景视图变量级联功能

在场景视图变量配置级联查询时，支持使用 `=` 、`!=` 精确匹配变量值，支持使用 `match（re）` 、`not match（re）` 、`wildcard` 、`not wildcard` 模糊匹配变量值。更多详情可参考文档 [视图变量](../scene/view-variable.md#query) 。

##### 饼图新增合并配置选项

饼图新增合并配置选项，支持用户将冗余的数据点合并到 “其他” 显示，提高饼图的可读性。更多详情可参考文档 [饼图](../scene/visual-chart/pie-chart.md) 。

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

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md) 。

## 2023 年 2 月 16 号

### 观测云更新

#### 优化工作空间权限管理

##### 新增成员角色及权限清单管理

观测云新增角色管理功能，支持对企业中的员工设置不同的观测云功能访问权限，以达到不同员工之间的权限隔离。

观测云默认提供四种成员角色，分别为“Owner”、“Administrator”、“Standard”和“Read-only”，除了默认角色以外，观测云支持在角色管理创建新的角色，并为角色赋予权限范围，满足不同用户的权限需要。更多详情可参考文档 [角色管理](../management/role-management.md) 。

![](img/8.member_6.png)

##### 优化成员邀请，增加选择成员权限

在当前空间内，邀请的新成员，默认权限为只读成员，新增支持选择一个或多个角色来设置新成员的权限，更多详情可参考文档 [成员管理](../management/member-management.md) 。

![](img/8.member_1.png)

##### 新增批量修改成员权限

在成员管理，新增批量修改权限功能，点击「批量修改权限」，选择需要批量修改权限的成员，点击「确定」，在弹出的对话框中为成员选择权限后「确定」即可。更多详情可参考文档 [成员管理](../management/member-management.md) 。

![](img/8.member_3.png)

##### 优化 SSO 管理，新增 SAML 映射功能

观测云新增基于配置 SAML 映射关系，为企业提供更精细的单点登录方案，开启 SAML 映射后，支持为企业员工动态的分配访问权限，员工可根据被分配的角色权限来访问观测云。

在观测云工作空间「管理」-「成员管理」-「SSO管理」-「SSO 登录」，启用 「SAML 映射」，并在「SAML 映射」配置映射关系。更多详情可参考文档 [SSO管理](../management/sso/index.md) 。

![](img/5.sso_mapping_10.png)

##### 成员管理页面显示优化

在成员管理，新增自定义角色管理功能，调整搜索、快捷筛选等布局。更多详情可参考文档 [成员管理](../management/member-management.md) 。

![](img/8.member_5.png)

##### 权限变更审核优化

基于新增的角色权限管理，调整费用中心审核的触发条件，当用户角色被赋予 Token 的查看、操作权限，即触发观测云费用中心的审核。更多详情可参考文档 [权限变更审核](../management/role-management.md#upgrade) 。

#### 新增登录会话保持时间设置

观测云支持为登录到工作空间的账号设置会话保持时间，包括 SSO 单点登录的账号和工作空间注册的账号，支持为登录账号设置“无操作登录会话保持时间”和“登录会话最大保持时间”，设置以后，超时登录会话会失效。

- 无操作登录会话保持时间：支持设置范围 30 ～ 1440 分钟，默认为 30 分钟；
- 登录会话最大保持时间：支持设置范围 0 ～ 7 天，其中 0 表示永不超时，默认为 7 天。

#### 新增工单管理

针对在观测云中遇到的问题，用户可以通过提交工单的方式进行咨询与建议，官方会进行及时的处理与反馈。例如：使用过程中遇到难以解决的问题、购买以及费用相关的咨询、向观测云提出需求建议等等。

工单系统是基于个人账号级别的，用户可以在工单管理中查看由本人提交的所有工单，不区分工作空间。工单管理入口：左下角「账号」-「工单管理」。更多详情可参考文档 [工单管理](../management/work-order-management.md) 。

![](img/1.work_order_1.png)

#### 其他功能优化

- 工作空间创建时新增语言选择，语言选项影响工作空间内事件、告警、短信等模板，若选择英文，上述对应模板将默认使用英文模板；
- 优化工作空间锁定功能，若费用中心账号欠费或云市场订阅异常等情况会导致工作空间锁定，工作空间锁定以后，新数据将停止上报，观测云提供 14 天的缓冲期，您可以在这期间继续查看和分析历史数据，并通过解除锁定状态，继续使用观测云。更多详情可参考文档 [工作空间锁定](../management/index.md#lock) 。


### 智能巡检更新

- **RUM 性能巡检：**支持影响用户的会话 ID 跳转查看问题 Session，在巡检事件报告中提供更专业的优化手段。
- **云账户实例维度账单巡检：**新增对 AWS 账户实例维度账单巡检支持。

更多智能巡检更新可参考 [智能巡检更新日志](../monitoring/bot-obs/index.md) 。

### 最佳实践更新

- 云平台接入
    - 阿里云 - [阿里云事件总线 EventBridge 最佳实践](../best-practices/partner/aliyun_eventbridge.md)

更多最佳实践更新可参考 [最佳实践版本历史](../best-practices/index.md) 。


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

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md) 。

### 智能巡检更新

#### 新增巡检

- **RUM 性能巡检：**Real User Monitoring（RUM）是一种应用性能监测技术，旨在通过模拟真实用户在浏览网站时的行为来评估网站性能。RUM 的目的是从用户的角度了解网站性能，了解网站加载时间，网页呈现的效果，页面元素的加载情况以及交互的反应。RUM 性能巡检的使用场景主要是对于客户端类型的网站，例如：电子商务网站、金融网站、娱乐网站等等，这些网站都需要向用户呈现一个快速和流畅的访问体验。通过对 RUM 性能结果分析，可以快速帮助开发人员可以了解用户的实际体验，以便快速改进网站的性能。
- **Kubernetes 健康巡检：**现如今 Kubernetes 已经席卷了整个容器生态系统，它充当着容器分布式部署的大脑，旨在使用跨主机集群分布的容器来管理面向服务的应用程序。Kubernetes 提供了用于应用程序部署、调度、更新、服务发现和扩展的机制，但是该如何来保障 Kubernetes 节点的健康呢，通过智能巡检可以根据当前节点的资源状态、应用性能管理、服务故障日志等信息的检索和问题发现，从而加快事件调查、减轻工程师的压力、减少平均修复时间并改善最终用户体验。

更多智能巡检更新可参考 [智能巡检更新日志](../monitoring/bot-obs/index.md) 。

## 2023 年 1 月 17 号

### 观测云英文版上线

## 2023 年 1 月 12 号

### 观测云更新

#### 新增观测云站点服务 Status Page

观测云提供 Status Page，帮助您实时查看观测云不同站点的服务状态。若您已经登录到观测云，您可以通过点击左下角的「帮助」-「Status Page」来查看观测云各个站点的服务状态。更多详情可参考文档 [Status Page](../management/status-page) 。

![](img/6.status_page_4.png)

#### 新增绑定自建 Elasticsearch / OpenSearch 索引

观测云新增支持绑定自建 Elasticsearch / OpenSearch 索引，帮助您统一快速查看和分析您的日志数据。更多详情可参考文档 [绑定索引](../logs/multi-index.md#binding-index) 。

![](img/9.log_index_2.png)

#### 新增网络查看器列表模式

在「基础设施」-「网络」，选择「主机 / Pod / Deployment / Service」，支持切换至对应网络列表查看源 IP/端口和目标 IP/端口之间的 TCP 重传次数、TCP 连接数、TCP 关闭次数、TCP 延时、发送字节数、接收字节数、状态码等。更多详情可参考文档 [网络](../infrastructure/network.md) 。

![](img/4.network_2.png)



#### 新增前端应用 Span 请求耗时分布显示

在链路详情页，若当前的链路属于前端应用调用产生的 Span，您可以在链路详情查看请求耗时分布，包括 Queueing（队列）、First Byte（首包）、Download（下载）的请求耗时占比，帮助您直观的查看前端某个 Span 的过程消耗占比。

> 注意：用户访问监测 SDK 必须是 2.2.10 以及上才可以看到这部分数据显示，如存在跨域情况需要调整 header 配置，更多详情可参考文档 [Web 应用接入](../real-user-monitoring/web/app-access.md#header) 。

![](img/8.apm_browser_2.png)

#### 优化用户访问监测 Session 交互逻辑

- Session 查看器去掉所有记录列表；
- Session 会话详情页显示优化：类型显示优化、支持切换会话发生的绝对时间、增加服务列、详情页显示优化、错误信息优化
- Session 会话更新逻辑优化：Session 数据更新从追加的逻辑调整为基于 session_id 覆盖的逻辑
- 链路中若存在前端应用调用产生的 Span，该 Span 对应的 service 值会根据当前用户访问数据中的 service 值做填充，若用户访问数据中不存在 service 的信息，则默认填充 "browser"

更多详情可参考文档 [Session（会话）](../real-user-monitoring/explorer/session.md) 。

![](img/7.rum_session.png)

#### Pod 指标数据采集默认关闭

在最新的 DataKit 版本中，`container` 采集器的 Pod 指标数据配置调整为默认关闭 `enable_pod_metric = false` 。更多详情可参考文档 [容器数据采集](../datakit/container.md#config) 。

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

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md) 。

### 最佳实践更新

- 云平台接入
    - AWS - [EKS 部署 DataKit](../best-practices/partner/eks.md)。
- 监控 Monitoring
    - 应用性能监控 (APM) - 调用链 - [使用 datakit-operator 注入 dd-java-agent](../best-practices/monitoring/datakit-operator.md)。

更多最佳实践更新可参考 [最佳实践版本历史](../best-practices/index.md) 。

