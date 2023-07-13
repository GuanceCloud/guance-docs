---
title: 'AWS ELB'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
<<<<<<< HEAD
<<<<<<< HEAD
icon: 'icon/aws_elb'
=======
__int_icon: 'icon/aws_elb'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
=======
__int_icon: 'icon/aws_elb'
>>>>>>> c66e8140414e8da5bc40d96d0cea42cd2412a7c6
dashboard:

  - desc: 'AWS ELB 内置视图'
    path: 'dashboard/zh/aws_elb'

monitor:
  - desc: 'AWS ELB 监控器'
    path: 'monitor/zh/aws_elb'

---



# AWS ELB

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
- 「观测云集成（AWS-ELB采集）」(ID：`guance_aws_elb`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

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

### Application Load Balancer 的指标维度

要筛选 Application Load Balancer 的指标，请使用以下维度。

| 维度               | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| `AvailabilityZone` | 按可用区筛选指标数据。                                       |
| `LoadBalancer`     | 按负载均衡器筛选指标数据。按以下方式指定负载均衡器：app/*load-balancer-name*/*1234567890123456*（负载均衡器 ARN 的结尾部分）。 |
| `TargetGroup`      | 按目标组筛选指标数据。按以下方式指定目标组：targetgroup/*target-group-name*/*1234567890123456*（目标组 ARN 的结尾部分）。 |

## 对象 {#object}

采集到的AWS ELB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
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
> > ```
> > LoadBalancerArn`为`arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2
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
