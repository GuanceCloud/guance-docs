---
skip: 'not-searchable-on-index-page'
title: 'Datakit Tracing Overview'
---

Currently, Datakit supports third-party Tracing data including:

- DDTrace
- Apache Jaeger
- OpenTelemetry
- SkyWalking
- Zipkin
- Cat
- PinPoint

---

## Datakit Tracing Frontend {#datakit-tracing-frontend}

Tracing Frontend refers to the APIs that receive various types of Trace data. These generally accept data from various Trace SDKs via HTTP or gRPC. After DataKit receives this data, it converts them into [a unified Span structure](datakit-tracing-struct.md). The data is then sent to the [Backend](datakit-tracing.md#datakit-tracing-backend) for processing.

In addition to converting the Span structure, the Tracing Frontend also configures the filtering and computing units in the [Tracing Backend](datakit-tracing.md#datakit-tracing-backend).

## General Configuration for Tracing Data Collection {#tracing-common-config}

In the configuration file, `tracer` refers to the currently configured Tracing Agent. All supported Tracing Agents can use the following configuration:

```toml
  ## customer_tags is a list of keys set by client code like span.SetTag(key, value)
  ## that want to send to data center. Those keys set by client code will take precedence over
  ## keys in [inputs.tracer.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
  customer_tags = ["key1", "key2", ...]

  ## Keep rare tracing resources list switch.
  ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
  ## to data center and do not consider samplers and filters.
  keep_rare_resource = false

  ## By default, every error in a span will be sent to data center and omit any filters or
  ## sampler. If you want to get rid of some error statuses, you can set the error status list here.
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

- `customer_tags`: By default, Datakit only picks up Tags that it is interested in (i.e., fields visible in <<< custom_key.brand_name >>> APM details except message),

  If users are interested in other tags reported on the trace, they can add them to this configuration to inform Datakit to pick them up. This configuration has higher priority than `[inputs.tracer.tags]`.

- `keep_rare_resource`: If traces from a certain Resource have not appeared in the last hour, the system considers this trace rare and reports it directly to the Data Center.
- `omit_err_status`: By default, if a Span in the trace contains an Error state, the data will be reported directly to the Data Center. Users can ignore specific HTTP Error Statuses (e.g., 429 too many requests) by configuring this option to inform Datakit to ignore them.
- `[inputs.tracer.close_resource]`: Users can configure this to close Entry-type Resources in the [span_type](datakit-tracing-struct.md).
- `[inputs.tracer.sampler]`: Configure the global sampling rate for the current Datakit, [configuration example](datakit-tracing.md#samplers).
- `[inputs.tracer.tags]`: Configure Datakit Global Tags, lower priority than `customer_tags`.
- `[inputs.tracer.threads]`: Configure the thread queue of the current Tracing Agent to control the CPU and Memory resources available during data processing.
    - buffer: Worker queue cache, larger configuration consumes more memory but increases the probability that requests sent to the Agent will successfully enter the queue and quickly return; otherwise, they will be discarded and return a 429 error.
    - threads: Maximum number of threads in the worker queue, larger configuration starts more threads and uses more CPU, usually configured as the number of CPU cores.
    - timeout: Task timeout, longer configuration occupies the buffer for a longer time.

## Datakit Tracing Backend {#datakit-tracing-backend}

The Datakit backend is responsible for operating on trace data according to configurations. Currently supported operations include Tracing Filters and Samplers.

### Datakit Filters {#filters}

- `user_rule_filter`: Default Datakit filter triggered by user actions.
- `omit_status_code_filter`: When configured with `omit_err_status = ["404"]`, then if there are errors with a status code of 404 in HTTP service traces, they will not be reported to the Data Center.
- `penetrate_error_filter`: Default Datakit filter triggered by trace errors.
- `close_resource_filter`: Configured in `[inputs.tracer.close_resource]`, service name is the full service name or `*`, resource name is a regular expression for the resource.
    - Example one: If configured as `login_server = ["^auth\_.*\?id=[0-9]*"]`, then traces under the `login_server` service name with `resource` like `auth_name?id=123` will be closed.
    - Example two: If configured as `"*" = ["heart_beat"]`, then all `heart_beat` resources across all services in the current Datakit will be closed.
- `keep_rare_resource_filter`: When configured with `keep_rare_resource = true`, traces deemed rare will be directly reported to the Data Center.

In the current version of Datakit, the execution order of Filters (Samplers are also a type of Filter) is fixed:

> error status penetration --> close resource filter --> omit certain http status code list --> rare resource keeper --> sampler <br>
> Each Datakit Filter has the ability to terminate the execution chain, meaning Filters that meet termination conditions will not execute subsequent Filters.

### Datakit Samplers {#samplers}

Currently, Datakit respects the client's sampling priority configuration, [DDTrace Sampling Rules](https://docs.datadoghq.com/tracing/faq/trace_sampling_and_storage){:target="_blank"}.

- Case One

Using DDTrace as an example, if the DDTrace lib sdk or client is configured with sampling priority tags and the client sampling rate is set to 0.3 via environment variables (DD_TRACE_SAMPLE_RATE) or startup parameters (dd.trace.sample.rate) without specifying a Datakit sampling rate (`inputs.tracer.sampler`), then approximately 30% of the data will be reported to the Data Center.

- Case Two

If the client only configures the Datakit sampling rate (`inputs.tracer.sampler`), for example, `sampling_rate = 0.3`, then approximately 30% of the data from this Datakit will be reported to the Data Center.

**Note** In multi-service, multi-Datakit distributed deployment scenarios, the Datakit sampling rate must be uniformly configured to the same sampling rate to achieve the desired sampling effect.

- Case Three

If both the client sampling rate is set to A and the Datakit sampling rate is set to B, where A and B are greater than 0 and less than 1, then approximately A * B % of the data will be reported to the Data Center.

**Note** In multi-service, multi-Datakit distributed deployment scenarios, the Datakit sampling rate must be uniformly configured to the same sampling rate to achieve the desired sampling effect.

## Span Structure Description {#about-span-structure}

Business explanation of how Datakit uses the [DatakitSpan](datakit-tracing-struct.md) data structure.

- For detailed descriptions of the Datakit Tracing data structure, please refer to [Datakit Tracing Structure](datakit-tracing-struct.md).
- Multiple Datakit Span data are placed in a Datakit Trace to form a single Tracing data upload to the Data Center, ensuring that all Spans have exactly one TraceID.
- For DDTrace, DDTrace data with the same TraceID may be reported in batches.
- In production environments (multiple services, multiple Datakit deployments), complete Trace data is uploaded to the Data Center in batches rather than in the order of calls.
- `parent_id = 0` represents the root span.
- `span_type = entry` represents the caller of the first resource on the service, i.e., the first span on the current service.

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Why does the Span status remain OK even though the HTTP status in the trace shows a 4xx error? {#faq-logging}

The Span status in the trace system monitors the execution status of the target business system. Most of the time, the target system corresponds to the user's business system, rather than the transport layer, network layer, or lower-level systems. Although HTTP operates at the business layer, 4xx errors have not yet entered the user's business layer but belong to the client side within the HTTP protocol stack. Therefore, the corresponding API in the user's business layer has correctly identified this client error, so the Span status remains OK.

<!-- markdownlint-enable -->