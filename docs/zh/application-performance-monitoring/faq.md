# 常见问题
---

## 如何采集应用性能监测数据？

观测云的链路数据采集目前支持使用 Opentracing 协议的采集器。在 DataKit 中开启链路数据接收服务后，通过完成采集器在代码中的埋点，DataKit 将自动完成数据的格式转换和采集，最终上报到观测云中心。DataKit 目前支持采集 `DDTrace` 、`Apache Jaeger` 、`OpenTelemetry` 、`Skywalking` 、`Zipkin` 等第三方的 Tracing 数据。

> 更多操作，可参考 [应用性能监测 APM](../application-performance-monitoring/index.md)。

## 如何采集 Profile 数据？

Profile 支持采集使用 Java，Python 和 Go 等不同语言环境下应用程序运行过程中的动态性能数据，帮助用户查看 CPU、内存、IO 的性能问题。

> 关于采集配置，可参考 [Profile 采集配置](../integrations/profile.md)。

## 如何关联日志数据？

观测云支持通过在日志中注入 `span_id`、`trace_id`、`env`、`service`、`version` 来关联应用性能监测，关联后，在应用性能监测中可查看请求所在关联的特定日志。

> 关于操作步骤，可参考 [Java 日志关联链路数据](../application-performance-monitoring/collection/connect-log/java.md) 或者 [Python 日志关联链路数据](../application-performance-monitoring/collection/connect-log/python.md)。

## 如何关联用户访问数据？

用户访问监测通过 `ddtrace`、`zipkin`、`skywalking`、`jaeger`、`opentelemetry` 采集器能够跟踪一个 web 端应用程序完整的前端到后端的请求数据，使用来自前端的 RUM 数据，以及注入到后端的 `trace_id`，可以快速的定位调用堆栈。

> 关于操作步骤，可参考 [关联 Web 应用访问](../application-performance-monitoring/collection/connect-web-app.md)。

## 如何配置应用性能数据采样？

默认情况下，观测云按照全量的方式采集应用性能数据，您可以通过在代码中设置采样率或者在配置采集器时设置采样率来节约数据存储量。

> 若您采用 Python 语言，可参考 [如何配置应用性能监测采样](../application-performance-monitoring/collection/sampling.md)；若您采用 Java 语言，可参考 [ddtrace 采样](../integrations/ddtrace.md)。

## 应用性能数据最长可以保存多少天？

观测云为应用性能数据提供 3 天、7 天、14 天三种数据存储时长选择，您可以按照需求在**管理 > 设置 > 变更数据存储策略**中调整。

> 更多数据存储策略，可参考 [数据存储策略](../billing/billing-method/data-storage.md)。

## 如何计算应用性能监测的费用？

观测云支持按需购买，按量付费的计费方式。应用性能监测计费统计当前空间下，`trace_id` 的数量，采用梯度计费模式。

> 更多计费规则，可参考 [计费方式](../billing/billing-method/index.md)。

## 如何配置服务清单？

服务清单支持您配置不同服务的所有权、依赖关系、关联分析、帮助文档等，帮助团队高效地构建及管理大规模的端到端的分布式应用。您可以在**应用性能监测 > 服务**，选择任意**服务**右侧操作按钮，即可打开服务清单进行配置。

> 更多详情，可参考 [服务清单](./service-manag.md#list-deatils)。

## 如何通过错误链路来快速发现问题？

观测云支持在 [链路查看器](../application-performance-monitoring/explorer.md) 快速筛选错误链路，或者直接在 [错误追踪查看器](../application-performance-monitoring/error.md) 快速查看链路中的类似错误的产生历史趋势及其分布情况，帮助快速定位性能问题。

## 若以上常见问题无法解决您的问题，如何获得在线支持？

观测云提供在线工单支持。

> 更多详情，可参考 [支持中心](../billing-center/support-center.md)。
