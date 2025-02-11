# Correlate Web Application Access

---

APM through collectors such as `DDTrace`, `Zipkin`, `Skywalking`, `Jaeger`, and `Opentelemetry` can trace complete request data from the front-end to the back-end of a web application.

Using RUM data from the front-end and the injected `trace_id` in the back-end, you can quickly pinpoint the call stack.

## Prerequisites

- Configure [DDTrace](../../integrations/ddtrace.md), [Skywalking](../../integrations/skywalking.md), [Opentelemetry](../../integrations/opentelemetry.md), [Jaeger](../../integrations/jaeger.md), and [Zipkin](../../integrations/zipkin.md) on the target server for the corresponding web application;
- For front-end applications separated from the back-end (with cross-origin conditions), you need to set up a Header whitelist for allowed front-end requests in the response headers of the target server.

For different APM tools, the specific keys for the `Access-Control-Allow-Headers` request header are as follows:

- ddtrace: `x-datadog-parent-id`, `x-datadog-origin`, `x-datadog-sampling-priority`, `x-datadog-trace-id`.
- skywalking: `sw8`.
- jaeger: `uber-trace-id`.
- zipkin: `X-B3-TraceId`, `X-B3-SpanId`, `X-B3-ParentSpanId`, `X-B3-Sampled`, `X-B3-Flags`.
- zipkin_single_header: `b3`.
- w3c_traceparent: `traceparent`.
- opentelemetry: This type supports three configuration methods: `zipkin_single_header`, `w3c_traceparent`, `zipkin`, and `jaeger`. Add the corresponding headers based on the `traceType` configured in the RUM SDK.

*Python Example:*

```python
app = Flask(__name__)
api = Api(app)
@app.after_request
def after_request(response):
    ...
    response.headers.add('Access-Control-Allow-Headers', 'x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')
    ...
    return response
    ...
```

**Note:** The target server must be an HTTP service.

### Frontend RUM Setup Steps

1. Integrate the [RUM SDK](../../real-user-monitoring/web/app-access.md) into your front-end application;
2. Add the `allowedTracingOrigins` parameter in the initialization configuration to configure the origin whitelist for allowed front-end requests. This can be an array of strings or a regular expression. *(Definition of origin: `<scheme> "://" <hostname> [ ":" <port> ]`)*

*Example:*

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '<DATAFLUX_APPLICATION_ID>',
  datakitOrigin: '<DATAKIT ORIGIN>',
  traceType: 'ddtrace', // ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
  ... // other configurations
  allowedTracingOrigins: ["https://api.example.com", /https:\/\/.*\.my-api-domain\.com/]
})
```