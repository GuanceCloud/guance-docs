# Trace Data Collection
---

<<< custom_key.brand_name >>> currently supports collectors using the Opentracing protocol for trace data collection. After enabling the trace data reception service in DataKit, by completing the instrumentation in the code, DataKit will automatically complete the data format conversion and collection, and finally report it to <<< custom_key.brand_name >>>.


## Data Collection

DataKit currently supports collecting tracing data from third-party sources such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking`, `Zipkin`, etc.



### Prerequisites for Collection

1. [Install DataKit](../../datakit/datakit-install.md);

2. Configure all relevant collectors for trace data collection.

#### Collector Configuration   

<div class="grid" markdown>

=== "DDTrace"

    [:octicons-book-16: DDTrace](../../integrations/ddtrace.md)

    - [Python](../../integrations/ddtrace-python.md)

    - [Ruby](../../integrations/ddtrace-ruby.md)


    - [Golang](../../integrations/ddtrace-golang.md)


    - [PHP](../../integrations/ddtrace-php.md)

    - [NodeJS](../../integrations/ddtrace-nodejs.md)


    - [C++](../../integrations/ddtrace-cpp.md)


    - [Java](../../integrations/pinpoint-java.md)

        This programming language also includes the following information:

        1. [DDTrace JMX](../../integrations/ddtrace-jmxfetch.md)
            
        2. [Extended Features](../../integrations/ddtrace-ext-java.md)
    

=== "OpenTelemetry"

    [:octicons-book-16: OpenTelemetry](../../integrations/opentelemetry.md)

    - [Changelog](../../integrations/otel-ext-changelog.md)

    - [Python](../../integrations/opentelemetry-python.md)

    - [Java](../../integrations/opentelemetry-java.md)

    - [Golang](../../integrations/opentelemetry-go.md)

=== "Pinpoint"

    [:octicons-book-16: Pinpoint](../../integrations/opentelemetry.md)

    - [Java](../../integrations/pinpoint-java.md)

    - [Golang](../../integrations/pinpoint-go.md)

=== "Others"

    - [Host Instrumentation](../../datakit/datakit-install.md#apm-instrumentation)
    - [Skywalking](../../integrations/skywalking.md)    
    - [Jaeger](../../integrations/jaeger.md)     
    - [Zipkin](../../integrations/zipkin.md)    
    - [New Relic](../../integrations/newrelic.md)    
    - [eBPF Tracing](../../integrations/ebpftrace.md)     
    - [OpenLIT](../../integrations/openlit.md)     
    - [CAT](../../integrations/cat.md)     
    - [Tracing Propagator](../../integrations/tracing-propagator.md) 

</div>



## Field Description

DataKit converts the collected data into <<< custom_key.brand_name >>> trace data format while preserving tags and metrics based on the collector used. Below are descriptions of commonly used fields:


| Field Name | Description                                                         |
| --------- | ------------------------------------------------------------ |
| `host`      | Hostname, default global tag.                                         |
| `source`    | Source of the trace, if collected via Zipkin, this value is `zipkin`, if collected via Jaeger, this value is `jaeger`, and so on. |
| `service`   | Service name, it is recommended that users specify the name of the business system generating this trace data through this tag. |
| `parent_id` | ID of the previous `span` for the current `span`.                             |
| `operation` | Operation name of the current `span`, can also be understood as the Span name.                     |
| `span_id`   | Unique ID of the current `span`.                                        |
| `trace_id`  | Unique ID representing the current trace.                                        |
| `span_type` | Type of Span, currently supports: `entry`, `local`, `exit`, `unknow`.<br><li>`entry span` indicates a span created when entering a service, i.e., the endpoint where the service provides calls to other services; most spans should be entry spans. Only calls of `entry` type spans represent an independent request. <br><li>`local span` indicates that the span has no relation to remote calls and is created during local method invocation, such as a regular Java method.<br><li>`exit span` indicates a span created when exiting a service, such as initiating a remote call or when a message queue generates a message.<br><li>`unknow span` indicates an unknown Span. |
| `endpoint`  | Target address of the request, the network address used by the client to access the target service, e.g., `127.0.0.1:8080`, default: `null`. |
| `message`   | Raw data collected before trace transformation.                                 |
| `duration`  | Duration of the current trace span.                                      |
| `status`    | Trace status, info: informational, warning: warning, error: error, critical: critical, ok: success. |
| `env`       | Environment to which the trace belongs, for example, dev for development environment, prod for production environment, user-defined. |

> For more field lists, refer to [DataKit Tracing Data Structure](../../integrations/datakit-tracing-struct.md#point-proto).

<!--
## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Best Practices for Distributed Tracing (APM)**</font>](../../best-practices/monitoring/apm.md)

</div>

-->