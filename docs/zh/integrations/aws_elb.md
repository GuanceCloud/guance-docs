---
title: 'AWS ELB'
tags: 
  - AWS
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/aws_elb'

dashboard:
  - desc: 'AWS Application ELB 内置视图'
    path: 'dashboard/zh/aws_application_elb'
  - desc: 'AWS Network ELB 内置视图'
    path: 'dashboard/zh/aws_network_elb'

monitor:
  - desc: 'AWS Application ELB 监控器'
    path: 'monitor/zh/aws_application_elb'
  - desc: 'AWS Network ELB 监控器'
    path: 'monitor/zh/aws_network_elb'

---


<!-- markdownlint-disable MD025 -->
# AWS ELB
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予CloudWatch只读权限`CloudWatchReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：

AWS 应用程序负载均衡器（ AWS Application ELB ）请选择「观测云集成（AWS-ApplicationELB采集）」(ID：`guance_aws_applicationelb`)

AWS 网络负载均衡器（ AWS Network ELB ）请选择「观测云集成（AWS-NetworkELB采集）」(ID：`guance_aws_networkelb`)

AWS 网关负载均衡器（ AWS Gateway ELB ）请选择「观测云集成（AWS-GatewayELB采集）」(ID：`guance_aws_gatewayelb`)

AWS Classic 负载均衡器 请选择「观测云集成（AWS-ELB采集）」(ID：`guance_aws_elb`)

点击【安装】后，输入相应的参数：亚马逊云 AK、亚马逊云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。在启动脚本中，需要注意'regions' 与 ELB 实际所在 regions 保持一致。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下.可以通过配置的方式采集更多的指标:

[亚马逊云监控 Application Load Balancer 指标详情](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[亚马逊云监控 Network Load Balancer 指标详情](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/network/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[亚马逊云监控 Gateway Load Balancer 指标详情](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/gateway/cloudwatch-metrics.html){:target="_blank"}

[亚马逊云监控 Classic Load Balancer 指标详情](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/classic/elb-cloudwatch-metrics.html){:target="_blank"}

### Application Load Balancer 指标

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveConnectionCount`                           | 从客户端到负载均衡器以及从负载均衡器到目标的并发活动 TCP 连接的总数。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ClientTLSNegotiationErrorCount`                  | 由因 TLS 错误而未能与负载均衡器建立会话的客户端发起的 TLS 连接数。可能的原因包括密码或协议不匹配或者客户端因无法验证服务器证书而关闭了连接。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                                    | 负载均衡器使用的负载均衡器容量单位 (LCU) 数量。您需要为每小时使用的 LCU 数量付费。有关更多信息，请参阅 [Elastic Load Balancing 定价](http://aws.amazon.com/elasticloadbalancing/pricing/){:target="_blank"}。**报告标准**：始终报告**统计数据**：全部维度`LoadBalancer` |
| `DesyncMitigationMode_NonCompliant_Request_Count` | 不符合 RFC 7230 标准的请求数。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `DroppedInvalidHeaderRequestCount`                | 负载均衡器在路由请求之前删除具有无效标头字段的 HTTP 标头的请求数。仅当 `routing.http.drop_invalid_header_fields.enabled` 属性设置为 `true` 时，负载均衡器才会删除这些标头。**报告标准**：有非零值**统计数据**：全部维度`AvailabilityZone`, `LoadBalancer` |
| `ForwardedInvalidHeaderRequestCount`              | 由负载均衡器路由的具有无效 HTTP 标头字段的 HTTP 标头的请求数。只有当 `routing.http.drop_invalid_header_fields.enabled` 属性设置为 `false` 时，负载均衡器才会转发带有这些标头的请求。**报告标准**：始终报告**统计数据**：全部维度`AvailabilityZone`, `LoadBalancer` |
| `GrpcRequestCount`                                | 通过 IPv4 和 IPv6 处理的 gRPC 请求数量。**报告标准**：有非零值**统计数据**：最有用的统计数据是 `Sum`. `Minimum`、`Maximum` 以及 `Average` 全部返回 1。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTP_Fixed_Response_Count`                       | 成功的固定响应操作的次数。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Count`                             | 成功的重定向操作的次数。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Url_Limit_Exceeded_Count`          | 由于响应位置标头中的 URL 大于 8K 而无法完成的重定向操作数。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_3XX_Count`                          | 源自负载均衡器的 HTTP 3XX 重定向代码数。该计数不包含目标生成的响应代码。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_4XX_Count`                          | 源自负载均衡器的 HTTP 4XX 客户端错误代码的数量。该计数不包含目标生成的响应代码。如果请求格式错误或不完整，则会生成客户端错误。除了负载均衡器返回 [HTTP 460 错误代码](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/application/load-balancer-troubleshooting.html#http-460-issues){:target="_blank"}的情况之外，目标不会收到这些请求。该计数不包含目标生成的任何响应代码。**报告标准**：有非零值**统计数据**：最有用的统计数据是 `Sum`. `Minimum`、`Maximum` 以及 `Average` 全部返回 1。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_5XX_Count`                          | 源自负载均衡器的 HTTP 5XX 服务器错误代码的数量。该计数不包含目标生成的任何响应代码。**报告标准**：有非零值**统计数据**：最有用的统计数据是 `Sum`. `Minimum`、`Maximum` 以及 `Average` 全部返回 1。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_500_Count`                          | 源自负载均衡器的 HTTP 500 错误代码的数量。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_502_Count`                          | 源自负载均衡器的 HTTP 502 错误代码的数量。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_503_Count`                          | 源自负载均衡器的 HTTP 503 错误代码的数量。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_504_Count`                          | 源自负载均衡器的 HTTP 504 错误代码的数量。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `IPv6ProcessedBytes`                              | 负载均衡器通过 IPv6 处理的总字节数。此计数包含在 `ProcessedBytes` 中。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `IPv6RequestCount`                                | 负载均衡器收到的 IPv6 请求的数量。**报告标准**：有非零值**统计数据**：最有用的统计数据是 `Sum`. `Minimum`、`Maximum` 以及 `Average` 全部返回 1。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `NewConnectionCount`                              | 从客户端到负载均衡器以及从负载均衡器到目标建立的新 TCP 连接的总数。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `NonStickyRequestCount`                           | 负载均衡器因其无法使用现有粘性会话而选择新目标的请求的数目。例如，请求是来自新客户端的第一个请求且未提供粘性 Cookie，提供了粘性 Cookie 但未指定已注册到此目标组的目标，粘性 Cookie 的格式错误或已过期，或者出现内部错误，导致负载均衡器无法读取粘性 Cookie。**报告标准**：已在目标组上启用粘性。**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                                  | 负载均衡器通过 IPv4 和 IPv6（HTTP 标头和 HTTP 有效负载）处理的总字节数。此计数包括到和来自客户端和 Lambda 函数的流量，以及来自身份提供程序 (IdP) 的流量（如果启用了用户身份验证）。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `RejectedConnectionCount`                         | 由于负载均衡器达到连接数上限被拒绝的链接的数量。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `RequestCount`                                    | 通过 IPv4 和 IPv6 处理的请求的数量。此指标仅在负载均衡器节点能够选择目标的请求中递增。在选择目标之前拒绝的请求不会反映在此指标中。**报告标准**：始终报告**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `RuleEvaluations`                                 | 在给定 1 小时的平均请求速率的情况下，负载均衡器处理的规则的数量。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer` |



`AWS/ApplicationELB` 命名空间包括目标的以下指标。

| 指标                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `HealthyHostCount`                                           | 被视为正常运行的目标数量。**报告标准**：在启用了运行状况检查时报告**统计数据**：最有用的统计工具是 `Average`、`Minimum` 和 `Maximum`。维度`TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `HTTPCode_Target_2XX_Count`, `HTTPCode_Target_3XX_Count`, `HTTPCode_Target_4XX_Count`, `HTTPCode_Target_5XX_Count` | 目标生成的 HTTP 响应代码的数量。它不包括负载均衡器生成的任何响应代码。**报告标准**：有非零值**统计数据**：最有用的统计数据是 `Sum`. `Minimum`、`Maximum` 以及 `Average` 全部返回 1。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCountPerTarget`                                      | 目标组中每个目标收到的平均请求数量。您必须使用 `TargetGroup` 维度指定目标组。如果目标是 Lambda 函数，则此指标不适用。**报告标准**：始终报告**统计**：唯一有效的统计数据是 `Sum`。这代表平均值，而不是总和。维度`TargetGroup``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `TargetConnectionErrorCount`                                 | 负载均衡器和目标之间连接建立不成功的次数。如果目标是 Lambda 函数，则此指标不适用。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetResponseTime`                                         | 请求离开负载均衡器直至收到来自目标的响应所用的时间（以秒为单位）。这与访问日志中的 `target_processing_time` 字段是等效的。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Average` 和 `pNN.NN`（百分比）。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetTLSNegotiationErrorCount`                             | 由未与目标建立会话的负载均衡器发起的 TLS 连接数。可能的原因包括密码或协议不匹配。如果目标是 Lambda 函数，则此指标不适用。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                                         | 被视为未正常运行的目标数量。**报告标准**：在启用了运行状况检查时报告**统计数据**：最有用的统计工具是 `Average`、`Minimum` 和 `Maximum`。维度`TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |



`AWS/ApplicationELB` 命名空间包括目标组运行状况的以下指标。有关更多信息，请参阅[目标组运行状况](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/application/target-group-health.html){:target="_blank"}。

| 指标                           | 描述                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `HealthyStateDNS`              | 符合 DNS 运行状况良好状态要求的区域数量。**Statistics**：最有用的统计工具是 `Min`。维度`LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `HealthyStateRouting`          | 符合路由运行状况良好状态要求的区域数量。**Statistics**：最有用的统计工具是 `Min`。维度`LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyRoutingRequestCount` | 使用路由故障转移操作（失败时开放）路由的请求数。**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateDNS`            | 不符合 DNS 运行状况良好状态要求，因此在 DNS 中被标记为运行状况不佳的区域数量。**Statistics**：最有用的统计工具是 `Min`。维度`LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateRouting`        | 不符合路由运行状况良好状态要求，因此负载均衡器会将流量分配到区域中的所有目标（包括运行状况不佳的目标）的区域数量。**Statistics**：最有用的统计工具是 `Min`。维度`LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |



`AWS/ApplicationELB` 命名空间包括已注册为目标的 Lambda 函数的以下指标。

| 指标                         | 描述                                                         |
| :--------------------------- | :----------------------------------------------------------- |
| `LambdaInternalError`        | 因负载均衡器或 AWS Lambda 内部出现问题而导致失败的对 Lambda 函数的请求数。要获取错误原因代码，请查看访问日志的 error_reason 字段。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`TargetGroup``TargetGroup`, `LoadBalancer` |
| `LambdaTargetProcessedBytes` | 负载均衡器为针对 Lambda 函数的请求和来自该函数的响应处理的字节的总数。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer` |
| `LambdaUserError`            | 因 Lambda 函数出现问题而导致失败的对 Lambda 函数的请求数。例如，负载均衡器没有调用该函数的权限，负载均衡器从格式错误或缺少必填字段的函数接收 JSON，或者请求正文或响应的大小超过了 1 MB 的最大大小。要获取错误原因代码，请查看访问日志的 error_reason 字段。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`TargetGroup``TargetGroup`, `LoadBalancer` |

`AWS/ApplicationELB` 命名空间包括用户身份验证的以下指标。

| 指标                            | 描述                                                         |
| :------------------------------ | :----------------------------------------------------------- |
| `ELBAuthError`                  | 由于身份验证操作配置错误、负载均衡器无法与 IdP 建立连接，或负载均衡器因内部错误无法完成身份验证流程，所导致的无法完成用户身份验证的次数。要获取错误原因代码，请查看访问日志的 error_reason 字段。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthFailure`                | 由于 IdP 拒绝用户访问或授权代码多次使用导致的无法完成用户身份验证的次数。要获取错误原因代码，请查看访问日志的 error_reason 字段。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthLatency`                | 向 IdP 查询 ID 令牌和用户信息所用的时间（毫秒）。如果这些操作中有一项或多项操作失败，这表示失败时间。**报告标准**：有非零值**统计数据**：所有统计数据均有意义。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthRefreshTokenSuccess`    | 负载均衡器使用 IdP 提供的刷新令牌成功刷新用户声明的次数。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthSuccess`                | 成功的身份验证操作的次数。负载均衡器从 IdP 检索用户身份声明后，验证工作流结束时此指标会递增。**报告标准**：有非零值**Statistics**：最有用的统计工具是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthUserClaimsSizeExceeded` | 配置的 IdP 返回大小超过 11K 字节的用户声明的次数。**报告标准**：有非零值**统计数据**：唯一有意义的统计数据是 `Sum`。维度`LoadBalancer``AvailabilityZone`, `LoadBalancer` |

### Network Load Balancer 指标

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveFlowCount`                           | 客户端至目标的并发流（或连接）的总数。此指标包含处于 SYN_SENT 和 ESTABLISHED 状态的连接。TCP 连接未在负载均衡器上终止，因此，一个开放与目标的 TCP 连接的客户端将计为一个流。**报告标准**：始终报告。**统计数据**：最有用的统计工具是 Average、Maximum 和 Minimum。**维度**：`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ActiveFlowCount_TCP`                           | 客户端至目标的并发 TCP 流（或连接）的总数。此指标包含处于 SYN_SENT 和 ESTABLISHED 状态的连接。TCP 连接未在负载均衡器上终止，因此，一个开放与目标的 TCP 连接的客户端将计为一个流。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Average、Maximum 和 Minimum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ConsumedLCUs`                           | 负载均衡器使用的负载均衡器容量单位 (LCU) 数量。您需要为每小时使用的 LCU 数量付费。**报告标准**：始终报告。**统计数据**：全部。**维度**：`LoadBalancer` |
| `ConsumedLCUs_TCP`                           | 负载均衡器为 TCP 使用的负载均衡器容量单位 (LCU) 数量。您需要为每小时使用的 LCU 数量付费。**报告标准**：有非零值。**统计数据**：全部。**维度**：`LoadBalancer` |
| `NewFlowCount`                           | 时段内建立的客户端至目标的新流（或连接）的总数。**报告标准**：始终报告。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `NewFlowCount_TCP`                           | 时段内建立的客户端至目标的新 TCP 流 (或连接) 的总数。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。 **维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `PeakPacketsPerSecond`                           | 最高平均数据包速率（每秒处理的数据包数），在采样窗口期间每 10 秒计算一次。此指标包含运行状况检查流量。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Maximum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes`                           | 负载均衡器处理的字节总数，包括 TCP/IP 标头。此计数包括往返目标的流量，减去运行状况检查流量。**报告标准**：始终报告。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes_TCP`                           | TCP 侦听器处理的字节的总数。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedPackets`                           | 负载均衡器处理的总数据包数。此计数包含往返目标的流量，以及运行状况检查流量。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Client_Reset_Count`                           | 从客户端发送至目标的重置 (RST) 数据包的总数。这些重置由客户端生成，然后由负载均衡器转发。**报告标准**：始终报告。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_ELB_Reset_Count`                           | 负载均衡器生成的重置 (RST) 数据包的总数。**报告标准**：始终报告。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Target_Reset_Count`                           | 从目标发送至客户端的重置 (RST) 数据包的总数。这些重置由目标生成，然后由负载均衡器转发。**报告标准**：始终报告。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `UnhealthyRoutingFlowCount`                           | 使用路由失效转移操作（失败时开放）路由的流（或连接）数量。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

### Gateway Load Balancer 指标

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveFlowCount`                           | 客户端至目标的并发流（或连接）的总数。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Average、Maximum 和 Minimum。**维度**：`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                           | 负载均衡器使用的负载均衡器容量单位 (LCU) 数量。您需要为每小时使用的 LCU 数量付费。**报告标准**：始终报告。**统计数据**：全部。**维度**：`LoadBalancer` |
| `HealthyHostCount`                           | 被视为正常运行的目标数量。**报告标准**：在启用了运行状况检查时报告。**统计数据**：最有用的统计工具为 Maximum 和 Minimum。**维度**：`LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |
| `NewFlowCount`                           | 时段内建立的客户端至目标的新流（或连接）的总数。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                           | 负载均衡器处理的总字节数。此计数包含往返目标的流量，但不包括运行状况检查流量。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                           | 被视为未正常运行的目标数量。**报告标准**：在启用了运行状况检查时报告。**统计数据**：最有用的统计工具为 Maximum 和 Minimum。**维度**：`LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |

### Classic Load Balancer 指标

| 指标                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `BackendConnectionErrors`                                    | 负载均衡器和注册实例之间连接建立不成功的次数。因为负载均衡器在发生错误时会重试连接，所以此计数会超过请求速率。请注意，此计数还包含与运行状况检查有关的所有连接错误。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。请注意，Average、Minimum 和 Maximum 针对每个负载均衡器节点报告，一般并无用处。然而，最小值与最大值（或者峰值到平均值、平均值到谷底）之间的差异可用于确定负载均衡器节点是否存在异常。**示例**：假设您的负载均衡器在 us-west-2a 和 us-west-2b 各有 2 个实例，并且向 us-west-2a 中 1 个实例的连接尝试导致出现后端连接错误。us-west-2a 的 sum 值包含这些连接错误，而 us-west-2b 的 sum 值不包含。因此，负载均衡器的 sum 值等于 us-west-2a 的 sum 值。 |
| `DesyncMitigationMode_NonCompliant_Request_Count`            | [HTTP 侦听器] 不符合 RFC 7230 标准的请求数。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。**维度**：`LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HealthyHostCount`                                           | 向负载均衡器注册的运行状况良好的实例的数量。新注册的实例在通过第一次运行状况检查后被视为运行状况良好。如果启用跨可用区负载均衡，则会跨所有可用区为 LoadBalancerName 维度计算运行状况良好的实例的数量。否则，将为每个可用区域计算该数量。**报告标准**：有注册的实例。**统计数据**：最有用的统计工具为 Average 和 Maximum。这些统计数据由负载均衡器节点决定。请注意，某些负载均衡器节点可能在短时间内认为某实例运行状况不佳，而其他节点将该实例视为运行状况良好。**示例**：假设您的负载均衡器在 us-west-2a 和 us-west-2b 各有 2 个实例，并且 us-west-2a 的 1 个实例运行状况不佳，而 us-west-2b 没有运行状况不佳的实例。对于 AvailabilityZone 维度，us-west-2a 平均有 1 个运行状况良好和 1 个运行状况不佳的实例，us-west-2b 平均有 2 个运行状况良好和 0 个运行状况不佳的实例。 |
| `HTTPCode_Backend_2XX, HTTPCode_Backend_3XX, HTTPCode_Backend_4XX, HTTPCode_Backend_5XX` | [HTTP 侦听器] 注册实例生成的 HTTP 响应代码的数量。该计数不包含负载均衡器生成的任何响应代码。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。请注意，Minimum、Maximum 和 Average 均为 1。**示例**：假设您的负载均衡器在 us-west-2a 和 us-west-2b 各有 2 个实例，并且发送到 us-west-2a 中的 1 个实例的请求导致了 HTTP 500 响应。us-west-2a 的 sum 值包含这些错误响应，而 us-west-2b 的 sum 值不包含。因此，负载均衡器的 sum 值等于 us-west-2a 的 sum 值。 |
| `HTTPCode_ELB_4XX`                                           | [HTTP 侦听器] 负载均衡器生成的 HTTP 4XX 客户端错误代码的数量。如果请求格式错误或不完整，则会生成客户端错误。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。请注意，Minimum、Maximum 和 Average 均为 1。**示例**：假设您的负载均衡器启用了 us-west-2a 和 us-west-2b，并且客户端请求包含格式错误的请求 URL。结果可能导致所有可用区中客户端错误增加。负载均衡器的 sum 值为各可用区的值的总和。 |
| `HTTPCode_ELB_5XX`                                           | [HTTP 侦听器] 负载均衡器生成的 HTTP 5XX 服务器错误代码的数量。此计数不包括注册实例生成的任何响应代码。如果没有运行状况良好的实例注册到负载均衡器，或者请求速率超过实例或负载均衡器的容量（溢出），则会报告该指标。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。请注意，Minimum、Maximum 和 Average 均为 1。**示例**：假设您的负载均衡器启用了 us-west-2a 和 us-west-2b，并且 us-west-2a 中的实例具有较高的延迟，对请求的响应较慢。结果，us-west-2a 中的负载均衡器节点波动队列填满，客户端收到 503 错误。如果 us-west-2b 继续正常响应，则负载均衡器的 sum 值将等于 us-west-2a 的 sum 值。 |
| `Latency`                                                    | [HTTP 侦听器] 从负载均衡器将请求发送到已注册实例到该实例开始发送响应标头所用的总时间 (以秒为单位)。[TCP 侦听器] 负载均衡器成功与注册实例建立连接所用的总时间 (以秒为单位)。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Average。Maximum 可用于确定某些请求的耗时是否大大超过平均时间。请注意，Minimum 一般没什么用处。**示例**：假设您的负载均衡器在 us-west-2a 和 us-west-2b 各有 2 个实例，并且发送到 us-west-2a 中的 1 个实例的请求具有较高的延迟。us-west-2a 的 average 值将高于 us-west-2b 的 average 值。 |
| `RequestCount`                                               | 在指定的时间段（1 或 5 分钟）完成的请求或者发出的连接的数量。[HTTP 侦听器] 收到和路由的请求数，包括来自注册实例的 HTTP 错误响应。[TCP 侦听器] 向注册实例发出的连接的数量。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。请注意，Minimum、Maximum 和 Average 均返回 1。**示例**：假设您的负载均衡器在 us-west-2a 和 us-west-2b 各有 2 个实例，并有 100 个请求发送至该负载均衡器。有 60 个请求发送至 us-west-2a，每个实例接收 30 个请求，有 40 个请求发送至 us-west-2b，每个实例接收 20 个请求。对于 AvailabilityZone 维度，us-west-2a 总计有 60 个请求，us-west-2b 总计有 40 个请求。对于 LoadBalancerName 维度，总计有 100 个请求。 |
| `SpilloverCount`                                             | 因波动队列填满而拒绝的请求的总数。[HTTP 侦听器] 负载均衡器返回 HTTP 503 错误代码。[TCP 侦听器] 负载均衡器关闭连接。**报告标准**：有非零值。**统计数据**：最有用的统计工具是 Sum。请注意，Average、Minimum 和 Maximum 针对每个负载均衡器节点报告，一般并无用处。**示例**：假设您的负载均衡器启用了 us-west-2a 和 us-west-2b，并且 us-west-2a 中的实例具有较高的延迟，对请求的响应较慢。结果是 us-west-2a 中的负载均衡器节点波动队列填满，导致溢出。如果 us-west-2b 继续正常响应，则负载均衡器的 sum 值将与 us-west-2a 的 sum 值相同。 |
| `SurgeQueueLength`                                           | 正在等待路由到正常实例的请求（HTTP 侦听器）或连接（TCP 侦听器）总数。队列的最大大小为 1024。队列填满后，额外的请求或连接将被拒绝。有关更多信息，请参阅SpilloverCount。**报告标准**：有非零值。**统计数据**：最有价值的统计数据是 Maximum，因为它代表排队请求的峰值。结合使用 Average 统计数据与 Minimum 和 Maximum 可以确定排队请求的范围。请注意，Sum 并无用处。**示例**：假设您的负载均衡器启用了 us-west-2a 和 us-west-2b，并且 us-west-2a 中的实例具有较高的延迟，对请求的响应较慢。结果是 us-west-2a 中的负载均衡器节点波动队列填满，很可能导致客户端的响应时间增加。如果这种情况继续存在，负载均衡器可能溢出（参阅 SpilloverCount 指标）。如果 us-west-2b 继续正常响应，则负载均衡器的 max 将与 us-west-2a 的 max 相同。 |
| `UnHealthyHostCount`                                         | 向负载均衡器注册的运行状况不良的实例的数量。如果实例超过运行状况检查所配置的不佳阈值，则认为实例运行状况不佳。不佳实例在符合运行状况检查所配置的良好阈值之后，被重新视为运行状况良好。**报告标准**：有注册的实例。**统计数据**：最有用的统计工具为 Average 和 Minimum。这些统计数据由负载均衡器节点决定。请注意，某些负载均衡器节点可能在短时间内认为某实例运行状况不佳，而其他节点将该实例视为运行状况良好。**示例**：请参阅HealthyHostCount。 |

### 负载均衡器的指标维度

要筛选 Application / Network / Gateway 负载均衡器的指标，请使用以下维度。

| 维度               | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| `AvailabilityZone` | 按可用区筛选指标数据。                                       |
| `LoadBalancer`     | 按负载均衡器筛选指标数据。按以下方式指定负载均衡器：`app/load-balancer-name/1234567890123456`（负载均衡器 ARN 的结尾部分）。 |
| `TargetGroup`      | 按目标组筛选指标数据。按以下方式指定目标组：`targetgroup/target-group-name/1234567890123456`（目标组 ARN 的结尾部分）。 |

要筛选 Classic 负载均衡器的指标，请使用以下维度。

| 维度               | 描述                                                        |
| :----------------- | :--------------------------------------------------------- |
| `AvailabilityZone` | 按可用区筛选指标数据。                                       |
| `LoadBalancerName` | 按指定的负载均衡器筛选指标数据。                              |

## 对象 {#object}

采集到的AWS ELB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_aelb",
  "tags": {
    "name"                 : "app/openway/8e8d762xxxxxx",
    "RegionId"             : "cn-northwest-1",
    "LoadBalancerArn"      : "arn:aws-cn:elasticloadbalancing:cn-northwest-1:588271xxxxx:loadbalancer/app/openway/8e8d762xxxxxx",
    "State"                : "active",
    "Type"                 : "application",
    "VpcId"                : "vpc-2exxxxx",
    "Scheme"               : "internet-facing",
    "DNSName"              : "openway-203509xxxx.cn-northwest-1.elb.amazonaws.com.cn",
    "LoadBalancerName"     : "openway",
    "CanonicalHostedZoneId": "ZM7IZAIxxxxxx"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON 数据}",
    "AvailabilityZones"   : "{可用区 JSON 数据}",
    "message"             : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`*中的字段可能会随后续更新有所变动*
>
> > 提示 1：AWS ELB 指标集根据不同类型的负载均衡分四种：
> >
> > 1. Application ELB 对应指标集 `aws_aelb`
> > 2. Network ELB 对应指标集 `aws_nelb`
> > 3. Gateway ELB 对应指标集 `aws_gelb`
> > 4. Classic ELB 对应指标集 `aws_elb`
> >
> > 提示 2：`tags.name` 取值方式分两种：
> >
> > 1. Classic Load Balancers 取 LoadBalancerName 字段。
> > 2. Application、Network、Gateway 三类 Load Balancers 截取负载均衡器 ARN 的结尾部分（LoadBalancerArn）。
> >
> > 以 Network Load Balancer 为例：
> >
> > ```txt
> > `LoadBalancerArn`为`arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> > ```
> >
> > 对应的`tags.name`为`net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> >
> > 提示 3：
> >
> > - `fields.message`、`tags.AvailabilityZones` 为 JSON 序列化后字符
> > - `tags.state`字段表示 Load Balancers 状态，取值：`active`、`provisioning`、`active_impaired`、`failed` （"classic" 类型负载均衡实例没有该字段）
> > - `tags.Type`字段表示 Load Balancers 类型，取值：`application`、`network`、`gateway`、`classic`
> > - `tags.Scheme`字段表示 Load Balancers 模式，取值：`internet-facing`、`internal`
> > - `fields.ListenerDescriptions`字段为该负载均衡的监听器列表
> > - `fields.AvailabilityZones` 字段表示负载均衡器关联的 Amazon Route 53 可用区信息
