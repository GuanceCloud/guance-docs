# Trace Data Collection
---

Trace data collection currently supports collectors using the Opentracing protocol. After enabling the trace data receiving service in DataKit, by completing the collector's embedding in the code, DataKit will automatically complete the format conversion and collection of the data, and finally report it to Guance.



## Data Collection

DataKit currently supports collecting Tracing data from third parties such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking` and `Zipkin`.

Before collecting data, you need to:

1. [Install DataKit](../../datakit/datakit-install.md);
2. After installation, you need to open the configuration file of the trace collector. Enter the **Guance Console > Integration** page, enter the search **Application Performance Monitoring**, you can view all the related collectors of trace data collection, open the configuration instructions of the collector, and configure according to the steps in the document.

Or you can directly click the link below to view the corresponding collector configuration:

|                          Collector Configuration                          |                                                              |                                                              |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [DDTrace](../../integrations/ddtrace.md){ .md-button .md-button--primary } | [Skywalking](../../integrations/skywalking.md){ .md-button .md-button--primary } | [OpenTelemetry](../../integrations/opentelemetry.md){ .md-button .md-button--primary } | [Zipkin](../../integrations/zipkin.md){ .md-button .md-button--primary } | [Jaeger](../../integrations/jaeger.md){ .md-button .md-button--primary } |

### Data Collection Steps

1. [Install host DataKit](../../datakit/datakit-install.md) or [install Kubernetes DataKit](../../datakit/datakit-daemonset-deploy.md);
2. Open the trace data receiving service in the DataKit;
3. Report data to Endpoint of DataKit's tracing service by integrating an SDK for open source trace data collection, such as Zipkin or Jaeger or Skywalking, into the business system;
4. DataKit will automatically clean the data into the trace data format of Guance itself and report it to the Guance;
5. Conduct trace analysis and view service-related performance metrics at the console of Guance.

![](../img/1.apm-1.png)

## Field Description

DataKit will convert the reported data into the format of Guance trace data according to the different collectors, preserving tags and metrics. The following are the explanations of commonly used fields:

| Field Name    | Description                                                    |
| --------- | ------------------------------------------------------------ |
| `host`      | Hostname, default global. label                                         |
| `source`    | The source of the trace is `zipkin` if it is collected by zipkin, `jaeger` if it is collected by jaeger, and so on. |
| `service`   | The name of the service through which the user is advised to specify the name of the service system that generates the trace data. |
| `parent_id` | ID of the previous `span` of the current `span`.                            |
| `operation` | The name of the current `span` operation, which can also be understood as the span name.                     |
| `span_id`   | Unique ID of the current `span`.                                        |
| `trace_id`  | Represent the unique ID of the current trace.                                        |
| `span_type` | The type of span, currently supported: `entry`, `local`, `exit`, `unknow`. <br><li>`entry span` represents the span created by the entry service, the endpoint of that service that provides invocation requests to other services, and most of the spans should be entry spans. Only calls with span of type `entry` are a separate request. <br><li>`local span` indicates that the span has nothing to do with the remote call and is created when the local method is called, such as a normal Java method. <br><li>`exit span` indicates leaving a span created by a service, such as when a remote call is initiated, or when a message queue generates a message. <br><li>`unknow span` denotes an unknown span. |
| `endpoint`  | The destination address of the request, the network address the client uses to access the destination service, such as `127.0.0.1:8080`, default: `null` |
| `message`   | Raw data collected before trace conversion                                 |
| `duration`  | The duration of the current trace span                                      |
| `status`    | Trace state, info: prompt, warning: warning, error: error, critical: critical, ok: successful |
| `env`       | The environment to which the trace belongs, for example, dev can be used to represent the development environment, prod can be used to represent the production environment, and users can customize it. |

> For more field listings, see [DataKit Tracing Data Structure](../../integrations/datakit-tracing-struct.md#point-proto).

## More Reading


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Distributed Tracing (APM) Best Practices**</font>](../../best-practices/monitoring/apm.md)

</div>
