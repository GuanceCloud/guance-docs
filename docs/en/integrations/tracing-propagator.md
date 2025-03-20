---
title     : 'Tracing Propagator'
summary   : 'Information propagation mechanism and usage in multiple tracing links'
tags      :
  - 'APM'
__int_icon: ''
---

This article mainly introduces products from multiple tracing vendors, as well as how to achieve trace information propagation between multiple languages or multiple products in distributed services.

The pass-through protocol is also called the propagation protocol, which refers to adding specific header information (usually HTTP headers) in service requests and responses to implement it. When one service requests another service, it carries specific request headers. When the next hop receives the request, it retrieves specific link information from the request header and inherits it, continuing to propagate until the end of the link. This can associate the entire call chain.

## Common propagation protocols {#propagators}

The following is a brief introduction to the differences of these pass-through protocols in HTTP headers:

### Trace Context {#propagators-w3c}

Trace Context is the [W3C](https://www.w3.org/TR/trace-context/){:target="_blank"} standardized tracking protocol, which defines two HTTP header fields: `traceparent` and `tracestate`:

- `traceparent` contains basic information about the current tracking, such as SpanID and ParentSpanID, for example: `traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-01`
- `tracestate` is used to pass metadata related to the trace. For example: `tracestate: congo=t61rcWkgMzE`

### 1 B3/B3Multi {#propagators-b3}

B3 is a popular tracking protocol that defines multiple HTTP header fields to identify trace information. B3Multi pass-through protocol is an extension of the B3 protocol, commonly used fields include: `X-B3-TraceId`, `X-B3-SpanId`, `X-B3-ParentSpanId`, `X-B3-Sampled`, `X-B3-Flags`, etc.

### 2 Jaeger {#propagators-jaeger}

Jaeger is a distributed tracing system that defines multiple HTTP header fields to pass trace information. Commonly used fields include: `uber-trace-id`, `jaeger-baggage`, etc.

### 3 OpenTracing {#propagators-ot}

OpenTracing is a pass-through protocol of OpenTelemetry that defines multiple HTTP header fields to pass link information:

- `ot-tracer-traceid`: used to pass the trace ID, representing a complete request link
- `ot-tracer-spanid`: used to pass the ID of the current Span, representing a single operation or event
- `ot-tracer-sampled`: used to indicate whether the request should be sampled to decide whether to record the tracking information of the request

### 4 Datadog {#propagators-datadog}

Datadog is a distributed tracing system that defines multiple HTTP header fields to pass trace information. Commonly used fields include: `x-datadog-trace-id`, `x-datadog-parent-id`, etc.

### 5 Baggage {#propagators-baggage}

Baggage is a concept introduced by the Jaeger tracing system, used to pass business-related context information. Baggage passes through the HTTP header field `x-b3-baggage-<key>`, where `key` is the key of the business context.

The real significance of Baggage is to propagate key-value pairs of the nature of `key:value`, often used to propagate AppID, Host-Name, Host-IP, etc.

<!-- markdownlint-disable MD046 -->
???+ attention

    It should be noted that the specific implementations and usage methods of these pass-through protocols may vary slightly, but they all aim to pass trace information and context information between different services through HTTP header fields to achieve distributed tracing and continuity.
<!-- markdownlint-enable -->

## Tracing vendor and product introduction {#tracing-info}

Products and vendors:

| Product          | Vendor              | Supported languages                                                                  |
| :---          | :---              | :---                                                                        |
| OpenTelemetry | CNCF              | Java, Python, Go, JavaScript, .NET, Ruby, PHP, Erlang, Swift, Rust, C++ etc.  |
| DDTrace       | Datadog           | Java, Python, Go, Ruby, JavaScript, PHP, .NET, Scala, Objective-C, Swift etc. |
| SkyWalking    | Apache SkyWalking | Java, .NET, Node.js, PHP, Python, Go, Ruby, Lua, OAP etc.                     |
| Zipkin        | OpenZipkin        | Java, Node.js, Ruby, Go, Scala, Python etc.                                   |
| Jaeger        | CNCF              | Java, Python, Go, C++, C#, Node.js etc.                                       |

Product open-source addresses:

- [OpenTelemetry](https://github.com/open-telemetry){:target="_blank"} is a product under CNCF. Guance has also [extended it](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
- [Jaeger](https://github.com/jaegertracing/jaeger){:target="_blank"} belongs to CNCF
- [Datadog](https://github.com/DataDog){:target="_blank"} multi-language tracing tool, where Guance has [extended it](https://github.com/GuanceCloud/dd-trace-java){:target="_blank"}
- [SkyWalking](https://github.com/apache?q=skywalking&type=all&language=&sort=){:target="_blank"} is an open-source product under the Apache Foundation
- [Zipkin](https://github.com/OpenZipkin){:target="_blank"} includes multiple language tracing tools.

## Propagation protocols of products {#use-propagators}

### OpenTelemetry {#use-otel}

List of Tracing propagation protocols supported by OTEL:

| Propagator List  | Reference                                                                                                                             |
|----------------|--------------------------------------------------------------------------------------------------------------------------------|
| `tracecontext` | [W3C Trace Context](https://www.w3.org/TR/trace-context/){:target="_blank"}                                                    |
| `baggage`      | [W3C Baggage](https://www.w3.org/TR/baggage/){:target="_blank"}                                                                |
| `b3`           | [B3](https://github.com/openzipkin/b3-propagation#single-header){:target="_blank"}                                             |
| `b3multi`      | [B3Multi](https://github.com/openzipkin/b3-propagation#multiple-headers){:target="_blank"}                                     |
| `jaeger`       | [Jaeger](https://www.jaegertracing.io/docs/1.21/client-libraries/#propagation-format){:target="_blank"}                        |
| `xray`         | [AWS X-Ray](https://docs.aws.amazon.com/xray/latest/devguide/xray-concepts.html#xray-concepts-tracingheader){:target="_blank"} |
| `opentracing`  | [OpenTracing](https://github.com/opentracing?q=basic&type=&language=){:target="_blank"}                                        |

Example format of distributed link header information during propagation:

```shell
# Command-line injection example (multiple propagation protocols separated by commas)
-Dotel.propagators="tracecontext,baggage"

# Environment variable injection example (Linux)
export OTEL_PROPAGATORS="tracecontext,baggage"

# Environment variable injection example (Windows)
$env:OTEL_PROPAGATORS="tracecontext,baggage"
```

### Datadog {#use-datadog}

| Supported Languages | Propagation Protocol Support                                 | Command                                                      |
|:--------|:---------------------------------------|:--------------------------------------------------------|
| Node.js | `datadog/b3multi/tracecontext/b3/none` | `DD_TRACE_PROPAGATION_STYLE`(default `datadog`)              |
| C++     | `datadog/b3multi/b3/none`              | `DD_TRACE_PROPAGATION_STYLE`(default `datadog`)              |
| .NET    | `datadog/b3multi/tracecontext/none`    | `DD_TRACE_PROPAGATION_STYLE`(default `datadog`)              |
| Java    | `datadog/b3multi/tracecontext/none`    | `DD_TRACE_PROPAGATION_STYLE`(default `tracecontext,datadog`) |

> Here `none` means no Tracing protocol propagation is set.

#### DD_TRACE_PROPAGATION_STYLE {#dd-pg-style}

Datadog Tracing can configure inbound settings regarding whether to inherit upstream protocols and whether to propagate its own protocol downstream. These are controlled by the following two environment variables:

- Inbound control: `export DD_TRACE_PROPAGATION_STYLE_EXTRACT=<XXX>`
- Outbound control: `export DD_TRACE_PROPAGATION_STYLE_INJECT=<YYY>`
- You can also control both inbound and outbound with a single ENV: `export DD_TRACE_PROPAGATION_STYLE="tracecontext,datadog"`

Example:

```shell
# On inbound, it will inherit X-Datadog-* and X-B3-* request headers (if any),
# On outbound, it will carry X-Datadog-* and X-B3-* request headers
$ export DD_TRACE_PROPAGATION_STYLE="datadog,b3" ...
```

<!-- markdownlint-disable MD046 -->
???+ attention

    Starting from version V1.7.0, the default supported protocol changed to `DD_TRACE_PROPAGATION_STYLE="tracecontext,datadog"`, B3 has been deprecated, please use B3multi.
<!-- markdownlint-enable -->

For more language examples, see [here](https://github.com/DataDog/documentation/blob/4ff75ed0bcaa1269bf98e9d185935cfda675b08c/content/en/tracing/trace_collection/trace_context_propagation/_index.md){:target="_blank"}.

### SkyWalking {#use-sw8}

SkyWalking's own [protocol (SW8)](https://skywalking.apache.org/docs/main/next/en/api/x-process-propagation-headers-v3/){:target="_blank"}

### Zipkin {#use-zipkin}

[Refer here](https://github.com/openzipkin/b3-propagation){:target="_blank"}

### Jaeger {#use-jaeger}

All supported protocols:

- [Jaeger Propagation Format](https://www.jaegertracing.io/docs/1.21/client-libraries/#propagation-format){:target="_blank"}
- [B3 propagation](https://github.com/openzipkin/b3-propagation){:target="_blank"}
- W3C Trace-Context

## Multi-link serialization {#series}

Request Header and vendor support list:

|               | W3C                         | b3multi                  | Jaeger                   | OpenTracing              | Datadog                  | sw8                      |
| :---          | :---                        | :---                     | :---                     | :---                     | :---                     | :---                     |
| header        | `tracecontext`/`tracestate` | `X-B3-*`                 | `uber-trace-id`          | `ot-tracer-*`            | `x-datadog-*`            | `xxx-xxx-xxx-xxx`        |
| OpenTelemetry | :heavy_check_mark:          | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_multiplication_x: |
| Datadog       | :heavy_check_mark:          | :heavy_check_mark:       | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_check_mark:       | :heavy_multiplication_x: |
| SkyWalking    | :heavy_multiplication_x:    | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_check_mark:       |
| Zipkin        | :heavy_multiplication_x:    | :heavy_check_mark:       | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: |
| Jaeger        | :heavy_check_mark:          | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_multiplication_x: | :heavy_multiplication_x: | :heavy_multiplication_x: |

You can use the corresponding propagation protocol according to the specific vendor tool used to achieve link serialization, ensuring the integrity of the link.

### Serialization Example: DD-to-OTEL {#dd-otel-example}

Here’s an example illustrating the serialization of trace data between DDTrace and OpenTelemetry. From the table above, we know that both DDTrace and OpenTelemetry support the W3C Trace Context protocol, so the link can be serialized through this protocol.

- The TraceID in DDTrace is a 64-bit int string, SpanID and ParentID are also 64-bit ints
- The TraceID in OTEL is a 128-bit hexadecimal representation of an int string, SpanID and ParentID are 64-bit int type strings

To associate the TraceID, DDTrace needs to be upgraded to 128 bits.

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

The client will send an HTTP request to the server, and DDTrace will pass the link information through the `tracecontext` request header to the server side.

However, in the "service call relationship", the data coming from the two tools cannot be connected because their SpanIDs are not unified. DDTrace is a decimal number string, while OpenTelemetry is a hexadecimal number string. Therefore, you need to modify the configuration in the `ddtrace` collector by enabling `compatible_otel` in the `ddtrace.conf`:

```toml
  ## compatible otel: It is possible to make OTEL Trace compatible with DDTrace trace.
  ## Convert span_id and parent_id to hex encoding.
  compatible_otel=true
```

After setting `compatible_otel=true`, all `span_id` and `parent_id` in DDTrace will become hexadecimal number strings.

<!-- markdownlint-disable MD046 -->
???+ tip "Convert `span_id` in logs to hexadecimal"

    The SpanId in DDTrace logs is still in decimal. You need to extract `span_id` in the log collection Pipeline script and convert it into a hexadecimal number string (without modifying the original log text):

    ```python
    # Convert string to int64
    fn parse_int(val: str, base: int) int64

    # Convert int64 to string
    fn format_int(val: int64, base: int) str
    ```
<!-- markdownlint-enable -->

Thus, DDTrace and OTEL have achieved serialization on the link, and service call relationships and logs can also be serialized:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://github.com/GuanceCloud/dd-trace-java/assets/31207055/9b599678-1ebc-4f1f-9993-f863fb25280b" style="height: 600px" alt="Link details">
  <figcaption> Link details </figcaption>
</figure>
<!-- markdownlint-enable -->