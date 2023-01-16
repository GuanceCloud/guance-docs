---
icon: zy/release-notes
---

# 更新日志（2023年）
---

本文档记录观测云每次上线发布的更新内容说明，包括 DataKit、观测云最佳实践、观测云集成文档和观测云。

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

