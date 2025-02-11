---
skip: 'not-searchable-on-index-page'
title: '128-bit Trace ID'
---

[:octicons-tag-24: Datakit-1.8.0](../datakit/changelog.md#cl-1.8.0)
[:octicons-tag-24: DDTrace-1.4.0-guance](ddtrace-ext-changelog.md#cl-1.14.0-guance)

The default trace-id in the DDTrace agent is 64 bits, and the trace-id received by Datakit in tracing data is also 64 bits. Starting from version v1.11.0, support for the W3C protocol and reception of 128-bit trace-ids was added. However, the trace-id sent to the tracing data remains 64 bits.

To address this, Guance implemented a secondary development, adding `trace_128_bit_id` to the tracing data sent to Datakit. This enables the linking of traces between DDTrace and OTEL.

For more information, see: [GitHub issue](https://github.com/GuanceCloud/dd-trace-java/issues/37){:target="_blank"}

## Implementation Method {#how}
Starting from dd v1.11, support for 128-bit traceID has been added. The current version of Guance is 1.12.1. Startup command parameters:

```shell
-Ddd.trace.128.bit.traceid.generation.enabled=true
# Set propagation protocol
-Ddd.trace.propagation.style=tracecontext
```

However, only within dd can you obtain this 128-bit traceID. When serialized and sent out, it is still a uint64. To pass this 128-bit ID, the structure in the transmission protocol must be modified.
This would result in complete version incompatibility and significant code changes, potentially causing many issues.

Our approach is to add `"trace_128_bit_id":xxxxxx` to the span's tags. After DK receives the data packet and finds this key, it replaces the original `trace_id`.

In the `span.build` method:

```java
    private DDSpan buildSpan() {
      DDSpan span = DDSpan.create(timestampMicro, buildSpanContext());
      if (span.isLocalRootSpan()) {
        EndpointTracker tracker = tracer.onRootSpanStarted(span);
        span.setEndpointTracker(tracker);
      }
      span.setTag("trace_128_bit_id", span.getTraceId().toString()); 
      return span;
    }
```

Afterwards, all spans will include this key during initialization.

This alone is insufficient; Datakit must also filter for `trace_128_bit_id` and replace the old `trace-id`.

In the Guance tracing system, all trace IDs will become 128-bit.

Modify the collector configuration in `ddtrace.conf`:

```toml
# Uncomment to convert span_id and parent_id to hexadecimal strings.
compatible_otel=true
```

## Linking OTEL with DDTrace {#otel-to-ddtrace}
OTEL client sends an HTTP request to the dd server: OTEL includes `traceparent:00-815cf7a2d315279413e6ceb43971225f-14f64a9c3fb05612-01` (W3C standard) in the request header, which consists of version - trace-id - parent-id - trace-flags.

When dd receives the request and initializes the span, it uses the trace-id as the trace ID and parent-id as the parent spanID.

Effect:

<!-- markdownlint-disable MD046 MD033 -->
<figure>
  <img src="https://github.com/GuanceCloud/dd-trace-java/assets/31207055/9b599678-1ebc-4f1f-9993-f863fb25280b" style="height: 600px" alt="Trace Details">
  <figcaption> Trace Details </figcaption>
</figure>

## More {#more}
Currently, only the linkage between DDTrace and OTEL has been implemented, and testing with other APM vendors has not yet been conducted.