---
skip: 'not-searchable-on-index-page'
title: '128-bit Trace ID'
---

[:octicons-tag-24: Datakit-1.8.0](../datakit/changelog.md#cl-1.8.0)
[:octicons-tag-24: DDTrace-1.4.0-guance](ddtrace-ext-changelog.md#cl-1.14.0-guance)

The default trace-id of the DDTrace agent is 64 bits, and the trace-id in the link data received by Datakit is also 64 bits. Starting from version v1.11.0, W3C protocol support was added, enabling reception of 128-bit trace-ids. However, the trace-id sent into the link remains 64 bits.

For this reason, <<< custom_key.brand_name >>> made a secondary development by placing `trace_128_bit_id` into the link data and sending it to Datakit together, thus achieving the linkage between DDTrace and OTEL.

You can refer to: [GitHub issue](https://github.com/GuanceCloud/dd-trace-java/issues/37){:target="_blank"}


## Implementation Method {#how}
Starting from dd version 1.11, 128-bit traceID is supported. Currently, the version of <<< custom_key.brand_name >>> is 1.12.1. The startup command parameters are:

```shell
-Ddd.trace.128.bit.traceid.generation.enabled=true
# Set transparent transmission protocol
-Ddd.trace.propagation.style=tracecontext
```

However, only within dd can you obtain this 128-length traceID. When serialized and sent out, it is still actually a uint64. To pass this 128-bit ID, the structure in the transmission protocol must be modified.
The consequence of this is complete version incompatibility, with significant code changes, leading to many potential issues.

Our approach is to place `"trace_128_bit_id":xxxxxx` in the tags of spans. After DK receives the data packet, if this key is found, the original `trace_id` will be replaced.

Placement location span.build:

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

Afterward, all spans will include this key during initialization.

This is still not sufficient; Datakit must also perform filtering. If there is `trace_128_bit_id`, then the old `trace-id` will be replaced.

In the <<< custom_key.brand_name >>> link, all link IDs will become 128 bits.

Modify the collector's `ddtrace.conf` configuration:

```toml
# Remove comments, span_id and parent_id will both be converted to hexadecimal strings.
compatible_otel=true
```

## Linking OTEL and DDTrace {#otel-to-ddtrace}
OTEL client sends an HTTP request to the dd server: OTEL defaults to including `traceparent:00-815cf7a2d315279413e6ceb43971225f-14f64a9c3fb05612-01` (W3C standard) sequentially as version - trace-id - parent-id - trace-flags


Thus, when dd receives the request and initializes the span, it uses the trace-id as the link ID and the parent-id as the parent spanID.

Effect:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://github.com/GuanceCloud/dd-trace-java/assets/31207055/9b599678-1ebc-4f1f-9993-f863fb25280b" style="height: 600px" alt="Link Details">
  <figcaption> Link Details </figcaption>
</figure>



## More {#more}
Currently, only the linking of DDTrace and OTEL has been implemented, with no testing done for other APM vendors yet.

