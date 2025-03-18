---
skip: 'not-searchable-on-index-page'
title: '128-bit Trace ID'
---

[:octicons-tag-24: Datakit-1.8.0](../datakit/changelog.md#cl-1.8.0)
[:octicons-tag-24: DDTrace-1.4.0-guance](ddtrace-ext-changelog.md#cl-1.14.0-guance)

The default trace-id for the DDTrace agent is 64 bits, and the trace-id in the trace data received by Datakit is also 64 bits. Starting from version 1.11.0, support for the W3C protocol and 128-bit trace-ids was added. However, the trace-id sent into the trace remains 64 bits.

To address this, Guance implemented a secondary development to include the `trace_128_bit_id` in the trace data sent to Datakit. This allows for the linking of traces between DDTrace and OTEL.

For more information, see: [GitHub issue](https://github.com/GuanceCloud/dd-trace-java/issues/37){:target="_blank"}

## Implementation Method {#how}
Support for 128-bit traceIDs has been available since dd version 1.11. The current version of Guance is 1.12.1. The startup command parameters are:

```shell
-Ddd.trace.128.bit.traceid.generation.enabled=true
# Set propagation protocol
-Ddd.trace.propagation.style=tracecontext
```

However, even with these settings, only a 64-bit traceID is serialized and sent out. To pass the 128-bit ID, the transmission protocol structure must be modified, which would result in complete version incompatibility and significant code changes, leading to many potential issues.

Our solution was to add `"trace_128_bit_id":xxxxxx` to the span's tags. When DK receives the data packet and detects this key, it replaces the original `trace_id`.

This is done in `span.build`:

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

After initialization, all spans will contain this key.

However, this alone is not sufficient. Datakit must also filter for `trace_128_bit_id` and replace the old `trace-id`.

In the Guance trace system, all trace IDs will become 128 bits.

Modify the collector configuration `ddtrace.conf`:

```toml
# Uncomment to convert span_id and parent_id to hexadecimal strings.
compatible_otel=true
```

## Linking OTEL and DDTrace {#otel-to-ddtrace}
OTEL clients send HTTP requests to the dd server. OTEL includes `traceparent:00-815cf7a2d315279413e6ceb43971225f-14f64a9c3fb05612-01` (W3C standard) in the request header, which contains the version, trace-id, parent-id, and trace-flags.

When dd receives the request and initializes the span, it uses the trace-id as the trace ID and the parent-id as the parent span ID.

Effect:

<!-- markdownlint-disable MD046 MD033 -->
<figure>
  <img src="https://github.com/GuanceCloud/dd-trace-java/assets/31207055/9b599678-1ebc-4f1f-9993-f863fb25280b" style="height: 600px" alt="Trace Details">
  <figcaption>Trace Details</figcaption>
</figure>

## More {#more}
Currently, only the linking between DDTrace and OTEL has been implemented; testing with other APM vendors has not yet been conducted.
