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

![](img/6.status_page_2.1.png)

#### 新增绑定自建 Elasticsearch / Open Search 索引

观测云新增支持绑定自建 Elasticsearch / Open Search 索引，帮助您统一快速查看和分析您的日志数据。更多详情可参考文档 [绑定索引](../logs/multi-index.md#binding-index) 。

![](img/9.log_index_2.png)

#### 新增网络查看器列表模式

在「基础设施」-「网络」，选择「主机 / Pod / Deployment / Service」，支持切换至对应网络列表查看「源」和「目标」之间的 TCP 重传次数、TCP 连接数、TCP 关闭次数、TCP 延时、发送字节数、接收字节数、状态码等。更多详情可参考文档 [网络](../infrastructure/network.md) 。

![](img/4.network_2.png)



#### 新增 Browser Span 请求耗时分布

在链路详情页，若当前的链路属于前端 Browser，您可以在链路详情查看请求耗时分布，包括 Queueing（队列）、First Byte（首包）、Download（下载）的请求耗时占比，帮助您直观的查看前端某个 Span 的过程消耗占比。

![](img/8.apm_browser_2.png)

#### 优化用户访问监测 Session 交互逻辑

- Session 会话详情页显示优化：类型显示优化、支持切换会话发生的绝对时间、增加服务列、详情页显示优化、错误信息优化
- Session 会话更新逻辑优化
- Browser Span 的 Service 字段值根据 SDK 侧配置值做填充，用于和链路进行关联分析

更多详情可参考文档 [Session（会话）](../real-user-monitoring/explorer/session.md) 。

![](img/7.rum_session.png)



#### 其他功能优化

- 绑定 MFA 认证调整为邮箱验证
- 注册时调整手机验证为邮箱验证
- 登录时安全验证调整为滑块验证
- 创建工作空间新增观测云专属版引导
- 工作空间新增备注显示功能
- 云账号结算用户新增在观测云付费计划与账单查看账单列表
- 表格图支持基于 「by 分组」设置别名
- 优化监控器配置中的时序图，仅在选择维度后显示
- 优化日志类数据无数据告警配置
- OpenAPI 新增创建接口

### 最佳实践更新

- 云平台接入
    - AWS - [EKS 部署 DataKit](../best-practices/partner/eks.md)。
- 监控 Monitoring
    - 应用性能监控 (APM) - 调用链 - [使用 datakit-operator 注入 dd-java-agent](../best-practices/monitoring/datakit-operator.md)。

更多最佳实践更新可参考 [最佳实践版本历史](../best-practices/index.md) 。

