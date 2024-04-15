# 链路数据采集
---



观测云的链路数据采集目前支持使用 Opentracing 协议的采集器。在 DataKit 中开启链路数据接收服务后，通过完成采集器在代码中的埋点，DataKit 将自动完成数据的格式转换和采集，最终上报到观测云。


## 数据采集

DataKit 目前支持采集 `DDTrace`、`Apache Jaeger`、`OpenTelemetry`、`Skywalking`、`Zipkin` 等第三方的 Tracing 数据。

采集数据前，您需要：

1. [安装 DataKit](../../datakit/datakit-install.md)；

2. 安装完成后需要开启链路采集器的配置文件。进入**观测云控制台 > 集成**页面，输入搜索**应用性能监测**，即可查看所有链路数据采集的相关采集器，打开采集器的配置说明文档，按照文档中的步骤进行配置即可。

或者您可以直接点击以下链接查看对应的采集器配置：

|                          采集器配置                          |                                                              |                                                              |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [DDTrace](../../integrations/ddtrace.md){ .md-button .md-button--primary } | [Skywalking](../../integrations/skywalking.md){ .md-button .md-button--primary } | [OpenTelemetry](../../integrations/opentelemetry.md){ .md-button .md-button--primary } | [Zipkin](../../integrations/zipkin.md){ .md-button .md-button--primary } | [Jaeger](../../integrations/jaeger.md){ .md-button .md-button--primary } |

### 数据采集步骤

1. [安装主机 DataKit](../../datakit/datakit-install.md) 或者 [安装 Kubernetes DataKit](../../datakit/datakit-daemonset-deploy.md)；  
2. 在 DataKit 中开启链路数据接收服务；  
3. 通过在业务系统中集成 Zipkin 或 Jaeger 或 Skywalking 等开源链路数据采集的 SDK，将数据上报到 DataKit 的链路追踪服务的 Endpoint；  
4. DataKit 会将数据自动清洗为观测云本身的链路数据格式，并上报到观测云中心；  
5. 在观测云的控制台进行链路分析和查看服务相关性能指标。

![](../img/1.apm-1.png)

## 字段说明

DataKit 会根据采集器的不同将上报的数据转换为观测云链路数据的格式保留标签和指标。下面是常用的字段说明：


| 字段名    | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| `host`      | 主机名，默认全局标签。                                         |
| `source`    | 链路的来源，如果是通过 Zipkin 采集的则该值为 `zipkin`，如果是 Jaeger 采集的该值为 `jaeger`，依次类推。 |
| `service`   | 服务的名称，建议用户通过该标签指定产生该链路数据的业务系统的名称。 |
| `parent_id` | 当前 `span` 的上一个 `span` 的 ID。                             |
| `operation` | 当前 `span` 操作名，也可理解为 Span 名称。                     |
| `span_id`   | 当前 `span` 的唯一 ID。                                        |
| `trace_id`  | 表示当前链路的唯一 ID。                                        |
| `span_type` | Span 的类型，目前支持 ：`entry` 、 `local` 、`exit` 、 `unknow` 。<br><li>`entry span` 表示进入服务创建的 span，即该服务的对其他服务提供调用请求的端点，大部分 span 应该都是 entry span。只有 span 是 `entry` 类型的调用才是一个独立的请求。 <br><li>`local span` 表示该 span 和远程调用没有任何关系，是本地方法调用的时候创建的 span，例如一个普通的 Java 方法。<br><li>`exit span` 表示离开服务创建的 span，例如发起远程调用的时候，或者消息队列产生消息的时候。<br><li>`unknow span` 表示未知的 Span。 |
| `endpoint`  | 请求的目标地址，客户端用于访问目标服务的网络地址，例如 `127.0.0.1:8080`，默认：`null`。 |
| `message`   | 链路转换之前的采集的原始数据。                                 |
| `duration`  | 当前链路 span 的持续时间。                                      |
| `status`    | 链路状态，info：提示，warning：警告，error：错误，critical：严重，ok：成功。 |
| `env`       | 链路的所属环境，比如可用 dev 表示开发环境，prod 表示生产环境，用户可自定义。 |


> 更多字段列表，可参考 [DataKit Tracing 数据结构](../../integrations/datakit-tracing-struct.md#point-proto)。

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **分布式链路追踪 (APM) 最佳实践**</font>](../../best-practices/monitoring/apm.md)

</div>



