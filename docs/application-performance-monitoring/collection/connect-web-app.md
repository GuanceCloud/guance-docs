# 关联 Web 应用访问

---

## 简介

APM 通过`ddtrace`、`zipkin`、`skywalking`、`jaeger`、`opentelemetry`采集器能够跟踪一个 web 端应用程序完整的前端到后端的请求数据

使用来自前端的 RUM 数据，以及注入到后端的`trace_id`，可以快速的定位调用堆栈。

## 前置条件

- 在对应的 web 应用目标服务器配置[ddtrace](../../datakit/ddtrace.md)、[skywalking](../../datakit/skywalking.md)、[opentelemetry](../../datakit/opentelemetry.md)、[jaeger](../../datakit/jaeger.md)、[zipkin](../../datakit/zipkin.md)
- 对于前后的分离的前端应用（有跨域的条件），需要对目标服务器允许跟踪的前端请求响应头设置 header 白名单。

  对应不同 APM 工具，具体 Access-Control-Allow-Headers 的请求头对应的 key 如下：

- ddtrace ：`x-datadog-parent-id`,`x-datadog-sampled`,`x-datadog-sampling-priority`,`x-datadog-trace-id`。
- skywalking: `sw8`。
- jaeger: `uber-trace-id`。
- zipkin: `X-B3-TraceId`、`X-B3-SpanId`、`X-B3-ParentSpanId`、`X-B3-Sampled`、`X-B3-Flags`。
- zipkin_single_header: `b3`。
- w3c_traceparent: `traceparent`。
- opentelemetry: 该类型支持 `zipkin_single_header`,`w3c_traceparent`,`zipkin`、`jaeger`三种类型的配置方式，根据在 rum sdk 中配置的 traceType 类型 添加对应的 header。

python 示例：

```python
app = Flask(__name__)
api = Api(app)
@app.after_request
def after_request(response):
 ...
 response.headers.add('Access-Control-Allow-Headers', 'x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')
 ....
 return response
 ....
```

. 目标服务器需要使用的是 HTTP 服务

### 前端 RUM 设置步骤

1. 在前端应用中引入 RUM SDK[RUM 引入](../../real-user-monitoring/web/app-access.md)
2. 在初始化配置中添加 `allowedTracingOrigins`参数，配置允许跟踪的前端请求 origin 白名单，可以是字符串数组，也可以是正则表达式。 origin 的定义：`<scheme> "://" <hostname> [ ":" <port> ]`

示例：

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '<DATAFLUX_APPLICATION_ID>',
  datakitOrigin: '<DATAKIT ORIGIN>',
  traceType: 'ddtrace', // ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent
  ... // 其他配置
  allowedTracingOrigins: ["https://api.example.com", /https:\/\/.*\.my-api-domain\.com/]
})
```

a
