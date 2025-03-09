# Web Application Access Correlation

---

APM through collectors such as `DDTrace`, `Zipkin`, `Skywalking`, `Jaeger`, and `Opentelemetry` can trace the entire request data from frontend to backend for a web application.

Using RUM data from the frontend along with the injected `trace_id` in the backend, you can quickly locate the call stack.

## Prerequisites

- Configure [DDTrace](../../integrations/ddtrace.md), [Skywalking](../../integrations/skywalking.md), [Opentelemetry](../../integrations/opentelemetry.md), [Jaeger](../../integrations/jaeger.md), and [Zipkin](../../integrations/zipkin.md) on the target servers of the corresponding web applications;
- For front-end applications separated from the backend (under cross-origin conditions), configure the target server to allow tracking of frontend requests by setting a Header whitelist in the response headers.

For different APM tools, the specific keys for the `Access-Control-Allow-Headers` header are as follows:

- ddtrace: `x-datadog-parent-id`, `x-datadog-origin`, `x-datadog-sampling-priority`, `x-datadog-trace-id`.
- skywalking: `sw8`.
- jaeger: `uber-trace-id`.
- zipkin: `X-B3-TraceId`, `X-B3-SpanId`, `X-B3-ParentSpanId`, `X-B3-Sampled`, `X-B3-Flags`.
- zipkin_single_header: `b3`.
- w3c_traceparent: `traceparent`.
- opentelemetry: This type supports configurations for `zipkin_single_header`, `w3c_traceparent`, `zipkin`, and `jaeger`. Add the corresponding headers based on the `traceType` configured in the RUM SDK.

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

### Frontend RUM Configuration Steps

1. Integrate the [RUM SDK](../../real-user-monitoring/web/app-access.md) into your frontend application;
2. Add the `allowedTracingOrigins` parameter in the initialization configuration to set up a whitelist of origins allowed for tracing frontend requests. This can be an array of strings or a regular expression. *(`origin` definition: `<scheme> "://" <hostname> [ ":" <port> ]`)*

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