# Associate Web Application Access

---


APM tracks the complete front-end to back-end request data of a web-side application through `ddtrace`, `zipkin`, `skywalking`, `jaeger` and `opentelemetry` collectors.

Using RUM data from the front end and `trace_id` injected into the back end, you can quickly locate the call stack.

## Preconditions

- Configure [ddtrace](../../integrations/ddtrace.md), [skywalking](../../integrations/skywalking.md), [opentelemetry](../../integrations/opentelemetry.md), [jaeger](../../integrations/jaeger.md) and [zipkin](../../integrations/zipkin.md) on the corresponding web application target server.
- For separate front-end applications (with cross-domain conditions), a header whitelist is required for front-end request response headers that are allowed to be tracked by the target server.

Corresponding to different APM tools, the key corresponding to the request header of Access-Control-Allow-Headers is as follows:

- ddtrace: `x-datadog-parent-id`, `x-datadog-sampled`, `x-datadog-sampling-priority`, `x-datadog-trace-id`.
- skywalking: `sw8`.
- jaeger: `uber-trace-id`.
- zipkin: `X-B3-TraceId`, `X-B3-SpanId`, `X-B3-ParentSpanId`, `X-B3-Sampled`, `X-B3-Flags`.
- zipkin_single_header: `b3`.
- w3c_traceparent: `traceparent`.
- opentelemetry: This type supports three types of configuration: `zipkin_single_header`, `w3c_traceparent`, `zipkin`, `jaeger`, adding corresponding headers based on the traceType type configured in RUM SDK.

*Python Example:*

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

**Note**: The target server needs to use the HTTP service.

### Front End RUM Setup Steps

1. Introduce the RUM SDK into the front-end application [RUM Introducing](../../real-user-monitoring/web/app-access.md).
2. Add the `allowedTracingOrigins` parameter to the initialization configuration to configure the whitelist of front-end request origins that allow tracing, which can be either a string array or a regular expression.*(Definition of origin: `<scheme> "://" <hostname> [ ":" <port> ]`.)*

*Example:*

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '<DATAFLUX_APPLICATION_ID>',
  datakitOrigin: '<DATAKIT ORIGIN>',
  traceType: 'ddtrace', // ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent
  ... // other configurations
  allowedTracingOrigins: ["https://api.example.com", /https:\/\/.*\.my-api-domain\.com/]
})
```
