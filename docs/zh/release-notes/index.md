---
icon: zy/release-notes
---

# 更新日志（2023年）
---

本文档记录观测云每次上线发布的更新内容说明，包括 DataKit、观测云最佳实践、观测云集成文档和观测云。

## 2023 年 2 月 16 号

### 观测云更新

#### 优化工作空间权限管理

##### 新增成员角色及权限清单管理

观测云新增角色管理功能，支持对企业中的员工设置不同的观测云功能访问权限，以达到不同员工之间的权限隔离。

观测云默认提供四种成员角色，分别为“拥有者”、“管理员”、“标准成员”和“只读成员”，除了默认角色以外，观测云支持在角色管理创建新的角色，并为角色赋予权限范围，满足不同用户的权限需要。更多详情可参考文档 [角色管理](../management/role-management.md) 。

![](img/8.member_6.png)

##### 优化成员邀请，增加选择成员权限

在当前空间内，拥有者、管理员以及被授权了“成员管理”权限的自定义角色支持邀请观测云的注册用户成为工作空间内的新成员。

邀请的新成员，默认权限为只读成员，新增支持选择一个或多个自定义角色来设置新成员的权限。

![](img/8.member_1.png)

##### 新增批量修改成员权限

在成员管理，新增批量修改权限功能，点击「批量修改权限」，选择需要批量修改权限的成员，点击「确定」，在弹出的对话框中为成员选择权限后「确定」即可。

> 仅拥有者和管理员可以批量修改成员权限。

![](img/8.member_3.png)

##### 优化 SSO 管理，新增 SAML 映射功能

观测云新增基于配置 SAML 映射关系，为企业提供更精细的单点登录方案，开启 SAML 映射后，支持为企业员工动态的分配访问权限，员工可根据被分配的角色权限来访问观测云。

在观测云工作空间「管理」-「成员管理」-「SSO管理」-「SSO 登录」，启用 「SAML 映射」，并在「SAML 映射」配置映射关系。更多详情可参考文档 [SSO管理](../management/sso/index.md) 。

![](img/5.sso_mapping_10.png)

##### 成员管理页面显示优化

在成员管理，新增角色管理功能，调整搜索、快捷筛选、操作等功能。更多详情可参考文档 [成员管理](../management/member-management.md) 。

![](img/8.member_5.png)

##### 权限变更审核优化

基于新增的角色权限管理，调整费用中心审核的触发条件，当用户角色被赋予 Token 的查看、操作权限，即触发费用中心的审核。更多详情可参考文档 [权限变更审核](../management/role-management.md#upgrade) 。

#### 新增登录会话保持时间设置

观测云新增为 [SSO 单点登录](../management/sso/index.md#login-hold-time) 和 [工作空间账号登录](../management/account-management.md#login-hold-time) 设置登录会话保持时间，包括无操作登录会话保持时间和登录会话最大保持时间，设置以后，超时登录会话会失效。

- 无操作登录会话保持时间：支持设置范围 30 ～ 1440 分钟，默认为 30 分钟；
- 登录会话最大保持时间：支持设置范围 0 ～ 7 天，其中 0 表示永不超时，默认为 7 天。

#### 新增工单管理

针对在观测云中遇到的问题，用户可以通过提交工单的方式进行咨询与建议，官方会进行及时的处理与反馈。例如：使用过程中遇到难以解决的问题、购买以及费用相关的咨询、向观测云提出需求建议等等。

工单系统是基于个人账号级别的，用户可以在工单管理中查看由本人提交的所有工单，不区分工作空间。工单管理入口：左下角「账号」-「工单管理」。更多详情可参考文档 [工单管理](../management/work-order-management.md) 。

![](img/1.work_order_1.png)

#### 其他功能优化

- 工作空间创建时新增语言选择，语言选项影响工作空间内事件、告警、短信等模板，若选择英文，上述对应模板将默认使用英文模板；
- 优化工作空间锁定功能，若费用中心账号欠费或云市场订阅异常等情况会导致工作空间锁定，工作空间锁定以后，新数据将停止上报，观测云提供 14 天的缓冲期，您可以在这期间继续查看和分析历史数据，并通过解除锁定状态，继续使用观测云。更多详情可参考文档 [工作空间锁定](../management/index.md#lock) 。

## 2023 年 2 月 9 号

### DataKit 更新

**新加功能**

- Datakit 主机安装可自定义默认采集器开启
- 提供 OTEL 的错误追踪
- 提供 RUM Session 回放能力

**问题修复**

- 修复日志堆积问题
- 修复 conf.d 重复启动采集器问题
- 修复 OTEL 数据关联问题
- 修复 OTEL 采集数据字段覆盖问题
- 修复 Nginx Host 识别错误
- 修复拨测超时
- 修复云厂商实例识别

**功能优化**

- Datakit pyroscope profiling 多程序语言识别
- 优化 CPU, Disk, EBPF, Net 等中英文文档
- 优化 elasticsearch, postgresql, dialtesting 等英文文档
- 优化 DCA, Profiling 文档
- 优化日志采集流程
- iploc yaml 配置方法文档支持

更多 DataKit 更新可参考 [DataKit 版本历史](../datakit/changelog.md) 。


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

