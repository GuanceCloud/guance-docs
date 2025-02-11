---
skip: 'not-searchable-on-index-page'
title: 'Datakit Tracing Overview'
---

Currently, Datakit supports third-party Tracing data from:

- DDTrace
- Apache Jaeger
- OpenTelemetry
- SkyWalking
- Zipkin
- Cat
- PinPoint

---

## Datakit Tracing Frontend {#datakit-tracing-frontend}

The Tracing Frontend refers to the APIs that receive various types of Trace data. These APIs typically receive data from different Trace SDKs via HTTP or gRPC. After receiving this data, DataKit converts it into a [unified Span structure](datakit-tracing-struct.md) and then sends it to the [Backend](datakit-tracing.md#datakit-tracing-backend) for processing.

In addition to converting Span structures, the Tracing Frontend also configures filtering and computation units in the [Tracing Backend](datakit-tracing.md#datakit-tracing-backend).

## General Configuration for Tracing Data Collection {#tracing-common-config}

In the configuration file, `tracer` refers to the currently configured Tracing Agent. All supported Tracing Agents can use the following configuration:

```toml
  ## customer_tags is a list of keys set by client code like span.SetTag(key, value)
  ## that you want to send to the data center. Keys set by client code will take precedence over
  ## keys in [inputs.tracer.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
  customer_tags = ["key1", "key2", ...]

  ## Keep rare tracing resources list switch.
  ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
  ## to the data center and not considered by samplers or filters.
  keep_rare_resource = false

  ## By default, every error in a span will be sent to the data center and any filters or
  ## samplers will be ignored. If you want to ignore certain HTTP error statuses (e.g., 429 too many requests),
  ## you can set the error status list here.
  omit_err_status = ["404"]

  ## Ignore tracing resources map like service:[resources...].
  ## The service name is the full service name in the current application.
  ## The resource list is regular expressions used to block resource names.
  ## If you want to block some resources universally under all services, you can set the
  ## service name as "*". Note: double quotes "" cannot be omitted.
  [inputs.tracer.close_resource]
    service1 = ["resource1", "resource2", ...]
    service2 = ["resource1", "resource2", ...]
    "*" = ["close_resource_under_all_services"]

  ## Sampler config used to set global sampling strategy.
  ## sampling_rate used to set global sampling rate.
  [inputs.tracer.sampler]
    sampling_rate = 1.0

  [inputs.tracer.tags]
    key1 = "value1"
    key2 = "value2"

  ## Threads config controls how many goroutines an agent can start.
  ## buffer is the size of jobs' buffering of worker channel.
  ## threads is the total number of goroutines at running time.
  ## timeout is the duration(ms) before a job can return a result.
  [inputs.tracer.threads]
    buffer = 100
    threads = 8
    timeout = 1000
```

- `customer_tags`: By default, Datakit only picks up tags it is interested in (i.e., fields visible in Guance trace details except for message).

  If users are interested in other tags reported on the trace, they can add them to this configuration to inform Datakit to pick them up. This configuration has higher priority than `[inputs.tracer.tags]`.

- `keep_rare_resource`: If traces from a particular Resource have not appeared within the last hour, the system considers these traces rare and reports them directly to the Data Center.
- `omit_err_status`: By default, if a Span contains an Error state, the data is directly reported to the Data Center. Users can configure this option to ignore certain HTTP Error Statuses (e.g., 429 Too Many Requests).
- `[inputs.tracer.close_resource]`: Users can configure this to close Entry-type Resources with [span_type](datakit-tracing-struct.md).
- `[inputs.tracer.sampler]`: Configure the global sampling rate for the current Datakit instance, [configuration example](datakit-tracing.md#samplers).
- `[inputs.tracer.tags]`: Configure Datakit Global Tags, which have lower priority than `customer_tags`.
- `[inputs.tracer.threads]`: Configure the thread queue of the current Tracing Agent to control CPU and Memory resources during data processing.
    - buffer: Size of the worker channel's job buffer. Larger buffers consume more memory but increase the probability of successful queuing and faster response times; otherwise, requests will be discarded and return a 429 error.
    - threads: Maximum number of goroutines. More threads mean higher CPU usage; generally, it should be set to the number of CPU cores.
    - timeout: Task timeout. Longer timeouts occupy the buffer for longer periods.

## Datakit Tracing Backend {#datakit-tracing-backend}

The Datakit backend processes trace data according to the configuration. Currently supported operations include Tracing Filters and Samplers.

### Datakit Filters {#filters}

- `user_rule_filter`: Default filter triggered by user actions.
- `omit_status_code_filter`: When configured with `omit_err_status = ["404"]`, traces containing HTTP status code 404 errors will not be reported to the Data Center.
- `penetrate_error_filter`: Default filter triggered by trace errors.
- `close_resource_filter`: Configured in `[inputs.tracer.close_resource]`, where the service name is either the full service name or `*`, and the resource name is a regular expression.
    - Example 1: Configuration like `login_server = ["^auth\_.*\?id=[0-9]*"]` will close traces under the `login_server` service with resources like `auth_name?id=123`.
    - Example 2: Configuration like `"*" = ["heart_beat"]` will close `heart_beat` resources across all services under the current Datakit.
- `keep_rare_resource_filter`: When configured with `keep_rare_resource = true`, rare traces will be directly reported to the Data Center.

In the current version of Datakit, the execution order of Filters (Samplers are also a type of Filter) is fixed:

> error status penetration --> close resource filter --> omit certain http status code list --> rare resource keeper --> sampler <br>
> Each Datakit Filter can terminate the trace execution if it meets the termination condition, preventing subsequent Filters from executing.

### Datakit Samplers {#samplers}

Datakit respects the client-side sampling priority configuration, [DDTrace Sampling Rules](https://docs.datadoghq.com/tracing/faq/trace_sampling_and_storage){:target="_blank"}.

- Case 1

For DDTrace, if the DDTrace lib SDK or client configures sampling priority tags and sets the client sampling rate to 0.3 via environment variables (DD_TRACE_SAMPLE_RATE) or startup parameters (dd.trace.sample.rate) without specifying a Datakit sampling rate (inputs.tracer.sampler), the amount of data reported to the Data Center will be approximately 30% of the total.

- Case 2

If the client only configures the Datakit sampling rate (inputs.tracer.sampler), for example, `sampling_rate = 0.3`, the amount of data reported to the Data Center by this Datakit will be approximately 30% of the total.

**Note** In distributed deployments with multiple services and multiple Datakits, the Datakit sampling rate must be uniformly configured to achieve consistent sampling results.

- Case 3

If both the client sampling rate A and the Datakit sampling rate B are configured, where A and B are greater than 0 and less than 1, the amount of data reported to the Data Center will be approximately A * B% of the total.

**Note** In distributed deployments with multiple services and multiple Datakits, the Datakit sampling rate must be uniformly configured to achieve consistent sampling results.

## Span Structure Explanation {#about-span-structure}

Explanation of how Datakit uses the [DatakitSpan](datakit-tracing-struct.md) data structure.

- For detailed explanations of the Datakit Tracing data structure, refer to [Datakit Tracing Structure](datakit-tracing-struct.md).
- Multiple Datakit Span data are grouped into a Datakit Trace and uploaded to the Data Center, ensuring that all Spans have one and only one TraceID.
- For DDTrace, DDTrace data with the same TraceID may be reported in batches.
- In production environments (multiple services, multiple Datakit deployments), complete Trace data is uploaded to the Data Center in batches, not necessarily in the order of calls.
- `parent_id = 0` indicates the root span.
- `span_type = entry` indicates the caller of the first resource on the service, i.e., the first span on the current service.

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Why does the Span status remain OK even when there is a 4xx HTTP status in the trace? {#faq-logging}

The Span status in the trace system monitors the execution status of the target business system. Most of the time, the target system corresponds to the user's business system rather than the transport layer, network layer, or lower-level systems. Although HTTP is part of the business layer, 4xx errors do not enter the user's business layer but belong to the client side of the HTTP protocol stack. Therefore, the API corresponding to the user's business layer correctly identifies this client error, so the Span status remains OK.

<!-- markdownlint-enable -->