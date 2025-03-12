---
title     : 'Tracing Propagator'
summary   : 'Mechanism and usage of information propagation in multiple traces'
tags      :
  - 'Trace Propagation'
__int_icon: ''
---

This article mainly introduces products from multiple tracing vendors and how to achieve trace information propagation between multiple languages or products in distributed services.

The transparent transmission protocol, also known as the propagation protocol, refers to adding specific header information (usually HTTP headers) in service requests and responses to achieve this. When one service requests another service, it carries specific request headers. When the next hop receives the request, it extracts specific trace information from the request headers and inherits it, continuing to propagate until the end of the trace. This allows the entire call chain to be associated.

## Common Propagation Protocols {#propagators}

The following is a brief introduction to the differences in these transparent transmission protocols in HTTP headers:

### Trace Context {#propagators-w3c}

Trace Context is the [W3C](https://www.w3.org/TR/trace-context/){:target="_blank"} standardized tracing protocol, which defines two HTTP header fields: `traceparent` and `tracestate`:

- `traceparent` contains basic information about the current trace, such as SpanID and ParentSpanID, for example: `traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-01`
- `tracestate` is used to pass metadata related to the trace. For example: `tracestate: congo=t61rcWkgMzE`

### 1 B3/B3Multi {#propagators-b3}

B3 is a popular tracing protocol that defines multiple HTTP header fields to identify trace information. B3Multi propagation protocol is an extension of the B3 protocol, commonly used fields include: `X-B3-TraceId`, `X-B3-SpanId`, `X-B3-ParentSpanId`, `X-B3-Sampled`, `X-B3-Flags`, etc.

### 2 Jaeger {#propagators-jaeger}

Jaeger is a distributed tracing system that defines multiple HTTP header fields to pass trace information. Commonly used fields include: `uber-trace-id`, `jaeger-baggage`, etc.

### 3 OpenTracing {#propagators-ot}

OpenTracing is a propagation protocol under OpenTelemetry, defining multiple HTTP header fields to pass trace information:

- `ot-tracer-traceid`: Used to pass the trace ID, representing a complete request trace
- `ot-tracer-spanid`: Used to pass the current Span's ID, representing a single operation or event
- `ot-tracer-sampled`: Indicates whether to sample the request to decide whether to record the trace information

### 4 Datadog {#propagators-datadog}

Datadog is a distributed tracing system that defines multiple HTTP header fields to pass trace information. Commonly used fields include: `x-datadog-trace-id`, `x-datadog-parent-id`, etc.

### 5 Baggage {#propagators-baggage}

Baggage is a concept introduced by the Jaeger tracing system, used to pass business-related context information. Baggage is passed through the HTTP header field `x-b3-baggage-<key>`, where `key` is the key of the business context.

The true significance of Baggage is to propagate key-value pairs, often used to propagate AppID, Host-Name, Host-IP, etc.

<!-- markdownlint-disable MD046 -->
???+ attention

    Note that the specific implementation and usage of these propagation protocols may vary slightly, but they all aim to pass trace and context information between different services via HTTP headers to achieve distributed tracing and continuity.
<!-- markdownlint-enable -->

## Vendor and Product Introduction {#tracing-info}

Products and vendors:

| Product          | Vendor              | Supported Languages                                                                  |
| :---          | :---              | :---                                                                        |
| OpenTelemetry | CNCF              | Java, Python, Go, JavaScript, .NET, Ruby, PHP, Erlang, Swift, Rust, C++ etc.  |
| DDTrace       | Datadog           | Java, Python, Go, Ruby, JavaScript, PHP, .NET, Scala, Objective-C, Swift etc. |
| SkyWalking    | Apache SkyWalking | Java, .NET, Node.js, PHP, Python, Go, Ruby, Lua, OAP etc.                     |
| Zipkin        | OpenZipkin        | Java, Node.js, Ruby, Go, Scala, Python etc.                                   |
| Jaeger        | CNCF              | Java, Python, Go, C++, C#, Node.js etc.                                       |

Product open-source addresses:

- [OpenTelemetry](https://github.com/open-telemetry){:target="_blank"} is a product under CNCF. Guance has [extended it](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
- [Jaeger](https://github.com/jaegertracing/jaeger){:target="_blank"} also belongs to CNCF
- [Datadog](https://github.com/DataDog){:target="_blank"} multi-language tracing tool, where Guance has [extended it](https://github.com/GuanceCloud/dd-trace-java){:target="_blank"}
- [SkyWalking](https://github.com/apache?q=skywalking&type=all&language=&sort=){:target="_blank"} is an open-source product under the Apache Foundation
- [Zipkin](https://github.com/OpenZipkin){:target="_blank"} includes multiple language tracing tools.

## Propagation Protocols of Products {#use-propagators}

### OpenTelemetry {#use-otel}

OTEL supported Tracing propagation protocols list:

| Propagator List  | Reference                                                                                                                             |
|----------------|--------------------------------------------------------------------------------------------------------------------------------|
| `tracecontext` | [W3C Trace Context](https://www.w3.org/TR/trace-context/){:target="_blank"}                                                    |
| `baggage`      | [W3C Baggage](https://www.w3.org/TR/baggage/){:target="_blank"}                                                                |
| `b3`           | [B3](https://github.com/openzipkin/b3-propagation#single-header){:target="_blank"}                                             |
| `b3multi`      | [B3Multi](https://github.com/openzipkin/b3-propagation#multiple-headers){:target="_blank"}                                     |
| `jaeger`       | [Jaeger](https://www.jaegertracing.io/docs/1.21/client-libraries/#propagation-format){:target="_blank"}                        |
| `xray`         | [AWS X-Ray](https://docs.aws.amazon.com/xray/latest/devguide/xray-concepts.html#xray-concepts-tracingheader){:target="_blank"} |
| `opentracing`  | [OpenTracing](https://github.com/opentracing?q=basic&type=&language=){:target="_blank"}                                        |

Example of distributed trace header format during propagation:

```shell
# Command line injection example (multiple propagation protocols separated by commas)
-Dotel.propagators="tracecontext,baggage"

# Environment variable injection example (Linux)
export OTEL_PROPAGATORS="tracecontext,baggage"

# Environment variable injection example (Windows)
$env:OTEL_PROPAGATORS="tracecontext,baggage"
```

### Datadog {#use-datadog}

| Supported Language | Propagation Protocol Support                                 | Command                                                      |
|:--------|:---------------------------------------|:--------------------------------------------------------|
| Node.js | `datadog/b3multi/tracecontext/b3/none` | `DD_TRACE_PROPAGATION_STYLE`(default `datadog`)              |
| C++     | `datadog/b3multi/b3/none`              | `DD_TRACE_PROPAGATION_STYLE`(default `datadog`)              |
| .NET    | `datadog/b3multi/tracecontext/none`    | `DD_TRACE_PROPAGATION_STYLE`(default `datadog`)              |
| Java    | `datadog/b3multi/tracecontext/none`    | `DD_TRACE_PROPAGATION_STYLE`(default `tracecontext,datadog`) |

> Here `none` means not setting any Tracing propagation protocol.

#### DD_TRACE_PROPAGATION_STYLE {#dd-pg-style}

Datadog Tracing can configure inbound settings for propagation behavior, i.e., whether to inherit upstream protocols and whether to propagate its own protocol downstream. This can be controlled by the following two environment variables:

- Inbound control: `export DD_TRACE_PROPAGATION_STYLE_EXTRACT=<XXX>`
- Outbound control: `export DD_TRACE_PROPAGATION_STYLE_INJECT=<YYY>`
- Or use a single ENV to control both inbound and outbound: `export DD_TRACE_PROPAGATION_STYLE="tracecontext,datadog"`

Example:

```shell
# Inbound will inherit X-Datadog-* and X-B3-* headers (if any),
# outbound will carry X-Datadog-* and X-B3-* headers
$ export DD_TRACE_PROPAGATION_STYLE="datadog,b3" ...
```

<!-- markdownlint-disable MD046 -->
???+ attention

    Starting from version V1.7.0, the default supported protocols have been changed to `DD_TRACE_PROPAGATION_STYLE="tracecontext,datadog"`, B3 has been deprecated, please use B3multi.
<!-- markdownlint-enable -->

For more language examples, refer to [here](https://github.com/DataDog/documentation/blob/4ff75ed0bcaa1269bf98e9d185935cfda675b08c/content/en/tracing/trace_collection/trace_context_propagation/_index.md){:target="_blank"}.

### SkyWalking {#use-sw8}

SkyWalking's own [protocol (SW8)](https://skywalking.apache.org/docs/main/next/en/api/x-process-propagation-headers-v3/){:target="_blank"}

### Zipkin {#use-zipkin}

[Refer here](https://github.com/openzipkin/b3-propagation){:target="_blank"}

### Jaeger {#use-jaeger}

All supported protocols:

- [Jaeger Propagation Format](https://www.jaegertracing.io/docs/1.21/client-libraries/#propagation-format){:target="_blank"}
- [B3 propagation](https://github.com/openzipkin/b3-propagation){:target="_blank"}
- W3C Trace-Context

## Multi-trace Linkage {#series}

Request Header and vendor support list:

|               | W3C                         | b3multi                  | Jaeger                   | OpenTracing              | Datadog                  | sw8                      |
| :---          | :---                        | :---                     | :---                     | :---                     | :---                     | :---                     |
| header        | `tracecontext`/`tracestate` | `X-B3-*`                 | `uber-trace-id`          | `ot-tracer-*`            | `x-datadog-*`            | `xxx-xxx-xxx-xxx`        |
| OpenTelemetry | :heavy_check_mark:          | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_multiplication_x: |
| Datadog       | :heavy_check_mark:          | :heavy_check_mark:       | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_check_mark:       | :heavy_multiplication_x: |
| SkyWalking    | :heavy_multiplication_x:    | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_check_mark:       |
| Zipkin        | :heavy_multiplication_x:    | :heavy_check_mark:       | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: |
| Jaeger        | :heavy_check_mark:          | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: |

Choose the appropriate propagation protocol based on the vendor tool being used to ensure trace linkage and integrity.

### Linkage Example: DD-to-OTEL {#dd-otel-example}

Here’s an example showing how DDTrace and OpenTelemetry trace data can be linked. From the table above, we know that both DDTrace and OpenTelemetry support the W3C Trace Context protocol, which can be used to link the traces.

- The TraceID in DDTrace is a 64-bit int string, while SpanID and ParentID are also 64-bit ints.
- In OTEL, the TraceID is a 128-bit hexadecimal int string, while SpanID and ParentID are 64-bit int strings.

To associate TraceIDs, DDTrace needs to be upgraded to 128 bits.

Regardless of which one initiates the request, DDTrace needs to enable 128-bit TraceID support (`dd.trace.128.bit.traceid.generation.enabled`):

```shell
# DDTrace startup example
$ java -javaagent:/usr/local/ddtrace/dd-java-agent.jar \
  -Ddd.service.name=client \
  -Ddd.trace.128.bit.traceid.generation.enabled=true \
  -Ddd.trace.propagation.style=tracecontext \
  -jar springboot-client.jar

# OTEL startup example
$ java -javaagent:/usr/local/ddtrace/opentelemetry-javaagent.jar \
  -Dotel.service.name=server \
  -jar springboot-server.jar
```

The client sends an HTTP request to the server, and DDTrace passes the trace information via the `tracecontext` header to the server.

However, in the "service invocation relationship," the data from the two tools does not connect because their SpanIDs are not unified. DDTrace uses a decimal number string, while OpenTelemetry uses a hexadecimal number string. Therefore, you need to modify the `ddtrace` collector configuration to set `compatible_otel` in `ddtrace.conf`:

```toml
  ## compatible otel: It is possible to compatible OTEL Trace with DDTrace trace.
  ## make span_id and parent_id to hex encoding.
  compatible_otel=true
```

Setting `compatible_otel=true` converts all DDTrace `span_id` and `parent_id` to hexadecimal strings.

<!-- markdownlint-disable MD046 -->
???+ tip "Converting `span_id` to Hexadecimal in Logs"

    In logs, the SpanId in DDTrace is still decimal. You need to convert `span_id` to a hexadecimal string in the log collection pipeline script (without modifying the original log text):

    ```python
    # Convert string to int64
    fn parse_int(val: str, base: int) int64

    # Convert int64 to string
    fn format_int(val: int64, base: int) str
    ```
<!-- markdownlint-enable -->

With this setup, DDTrace and OTEL are now linked in the trace, and service invocation relationships and logs can also be linked:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://github.com/GuanceCloud/dd-trace-java/assets/31207055/9b599678-1ebc-4f1f-9993-f863fb25280b" style="height: 600px" alt="Trace Details">
  <figcaption> Trace Details </figcaption>
</figure>
<!-- markdownlint-enable -->