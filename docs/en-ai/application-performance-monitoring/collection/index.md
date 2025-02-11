# Link Data Collection
---

Guance currently supports collectors using the Opentracing protocol for link data collection. After enabling the link data reception service in DataKit, by completing the instrumentation of the collector in the code, DataKit will automatically complete data format conversion and collection, ultimately reporting to Guance.

## Data Collection

DataKit currently supports collecting tracing data from third parties such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking`, and `Zipkin`.

Before collecting data, you need to:

1. [Install DataKit](../../datakit/datakit-install.md);
2. After installation, enable the configuration file for the trace collector. Enter the **Guance Console > Integrations** page, search for **APM**, and view all relevant collectors for link data collection. Open the configuration documentation for the collector and follow the steps in the document to configure it.

Alternatively, you can directly click on the following links to view the corresponding collector configurations:

|                          Collector Configuration                          |                                                              |                                                              |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [DDTrace](../../integrations/ddtrace.md){ .md-button .md-button--primary } | [Skywalking](../../integrations/skywalking.md){ .md-button .md-button--primary } | [OpenTelemetry](../../integrations/opentelemetry.md){ .md-button .md-button--primary } | [Zipkin](../../integrations/zipkin.md){ .md-button .md-button--primary } | [Jaeger](../../integrations/jaeger.md){ .md-button .md-button--primary } |

### Data Collection Steps

1. [Install Host DataKit](../../datakit/datakit-install.md) or [Install Kubernetes DataKit](../../datakit/datakit-daemonset-deploy.md);  
2. Enable the link data reception service in DataKit;  
3. Integrate Zipkin, Jaeger, or Skywalking SDKs into your business system to report data to the DataKit's trace service endpoint;  
4. DataKit will automatically clean and convert the data into Guance’s link data format and report it to the Guance center;  
5. Perform trace analysis and view related service performance metrics in the Guance console.

![](../img/1.apm-1.png)

## Field Description

DataKit converts the reported data into Guance's link data format based on different collectors while retaining tags and metrics. Below is a description of commonly used fields:

| Field Name   | Description                                                         |
| ------------ | ------------------------------------------------------------------- |
| `host`       | Hostname, default global tag.                                       |
| `source`     | Source of the trace, if collected via Zipkin, this value is `zipkin`, if via Jaeger, it is `jaeger`, and so on. |
| `service`    | Service name, it is recommended that users specify the name of the business system generating the trace data using this tag. |
| `parent_id`  | The ID of the previous `span` of the current `span`.                 |
| `operation`  | Operation name of the current `span`, also understood as Span name.  |
| `span_id`    | Unique ID of the current `span`.                                     |
| `trace_id`   | Unique ID representing the current trace.                           |
| `span_type`  | Type of Span, currently supports: `entry`, `local`, `exit`, `unknow`.<br><li>`entry span` indicates a span created when entering a service, i.e., the endpoint where the service provides calls to other services. Most spans should be entry spans. Only spans of type `entry` represent an independent request. <br><li>`local span` indicates that the span has no relation to remote calls, created during local method calls, e.g., a regular Java method.<br><li>`exit span` indicates a span created when leaving a service, such as initiating a remote call or producing messages in a message queue.<br><li>`unknow span` indicates an unknown Span. |
| `endpoint`   | Target address of the request, the network address used by the client to access the target service, e.g., `127.0.0.1:8080`, default: `null`. |
| `message`    | Raw data collected before trace transformation.                     |
| `duration`   | Duration of the current trace span.                                  |
| `status`     | Trace status, info: informational, warning: warning, error: error, critical: critical, ok: success. |
| `env`        | Environment of the trace, e.g., `dev` for development environment, `prod` for production environment, customizable by users. |

> For more field lists, refer to [DataKit Tracing Data Structure](../../integrations/datakit-tracing-struct.md#point-proto).

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Distributed Tracing (APM) Best Practices**</font>](../../best-practices/monitoring/apm.md)

</div>