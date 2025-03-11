---
skip: 'not-searchable-on-index-page'
title: 'Datakit Tracing Data Structure'
---

## Introduction {#intro}

This document explains the data structures of mainstream Telemetry platforms and their mapping relationships with the Datakit platform data structure. Currently supported data structures: DataDog/Jaeger/OpenTelemetry/SkyWalking/Zipkin/PinPoint

Data transformation steps:

1. External Tracing data ingestion, where data is received via multiple protocols and then deserialized.
2. Deserialized objects are converted to `Line Protocol` (line protocol format).
3. Span data operations include: sampling, filtering, adding specific tags, etc.

---

## Datakit Point Protocol Data Structure {#point-proto}

- Tags

| Tag                | Description                                                          |
| ---                | ---                                                                  |
| `container_host`   | Host name of container                                               |
| `endpoint`         | Endpoint of resource                                                 |
| `env`              | Environment arguments                                                |
| `http_host`        | HTTP host                                                            |
| `http_method`      | HTTP method                                                          |
| `http_route`       | HTTP route                                                           |
| `http_status_code` | HTTP status code                                                     |
| `http_url`         | HTTP URL                                                             |
| `operation`        | Operation of resource                                                |
| `pid`              | Process ID                                                           |
| `project`          | Project name                                                         |
| `service`          | Service name                                                         |
| `source_type`      | Source types [`app/framework/cache/message_queue/custom/db/web/...`] |
| `span_type`        | Span types                                                           |
| `status`           | Span status                                                          |

- Field

| Metric        | Description                            | Type   | Unit |
| ---           | ---                                    | ---    | ---  |
| `create_time` | Guancedb storage create timestamp [^1] | int    | s    |
| `duration`    | Span duration                          | int    | us   |
| `message`     | Raw data content                       | string |      |
| `parent_id`   | Parent ID of span                      | string |      |
| `priority`    | Priority rules                         | string |      |
| `resource`    | Resource of service                    | string |      |
| `span_id`     | Span ID                                | string |      |
| `start`       | Span start timestamp                   | int    | us   |
| `time`        | Datakit received timestamp             | int    | ns   |
| `trace_id`    | Trace ID                               | string |      |

[^1]: This field does not exist during Datakit collection; it is only appended after being stored in the database.

The `span_type` indicates the relative position of the current Span within the Trace. The values are as follows:

- `entry`: The current API is the entry point, i.e., the first call after entering the service.
- `local`: The current API is between the entry and exit points.
- `exit`: The current API is the last call in the trace on the service.
- `unknown`: The relative position of the current API is unclear.

The `priority` represents the client-side sampling priority rules:

- `PRIORITY_USER_REJECT = -1` User chooses to reject reporting
- `PRIORITY_AUTO_REJECT = 0` Client sampler chooses to reject reporting
- `PRIORITY_AUTO_KEEP = 1` Client sampler chooses to report
- `PRIORITY_USER_KEEP = 2` User chooses to report


## OpenTelemetry Tracing Data Structure {#otel-trace-struct}

When Datakit collects data sent from the OpenTelemetry Exporter (OTLP), the simplified raw data serialized in JSON format is as follows:

```text
resource_spans:{
    resource:{
        attributes:{key:"message.type"  value:{string_value:"message-name"}}
        attributes:{key:"service.name"  value:{string_value:"test-name"}}
    }
    instrumentation_library_spans:{instrumentation_library:{name:"test-tracer"}
    spans:{
        trace_id:"\x94<\xdf\x00zx\x82\xe7Wy\xfe\x93\xab\x19\x95a"
        span_id:".\xbd\x06c\x10ɫ*"
        parent_span_id:"\xa7*\x80Z#\xbeL\xf6"
        name:"Sample-0"
        kind:SPAN_KIND_INTERNAL
        start_time_unix_nano:1644312397453313100
        end_time_unix_nano:1644312398464865900
        status:{}
    }
    spans:{
           ...
        }
}
```

The correspondence between `resource_spans` in OpenTelemetry and DKProto is as follows:

| Field Name           | Data Type           | Unit | Description    | Correspond To                                                                                                                                                       |
| -------------------- | ------------------- | ---- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| trace_id             | `[16]byte`          |      | Trace ID       | `DKProto.TraceID`                                                                                                                                                    |
| span_id              | `[8]byte`           |      | Span ID        | `DKProto.SpanID`                                                                                                                                                     |
| parent_span_id       | `[8]byte`           |      | Parent Span ID | `DKProto.ParentID`                                                                                                                                                   |
| name                 | `string`            |      | Span Name      | `DKProto.Operation`                                                                                                                                                  |
| kind                 | `string`            |      | Span Type      | `DKProto.SpanType`                                                                                                                                                   |
| start_time_unix_nano | `int64`             | Nanoseconds | Span Start Time  | `DKProto.Start`                                                                                                                                                      |
| end_time_unix_nano   | `int64`             | Nanoseconds | Span End Time  | `DKProto.Duration = end - start`                                                                                                                                     |
| status               | `string`            |      | Span Status    | `DKProto.Status`                                                                                                                                                     |
| name                 | `string`            |      | Resource Name  | `DKProto.Resource`                                                                                                                                                   |
| resource.attributes  | `map[string]string` |      | Resource Tags  | `DKProto.tags.service, DKProto.tags.project, DKProto.tags.env, DKProto.tags.version, DKProto.tags.container_host, DKProto.tags.http_method, DKProto.tags.http_status_code` |
| span.attributes      | `map[string]string` |      | Span Tags      | `DKProto.tags`                                                                                                                                                       |

OpenTelemetry has some unique fields that do not have corresponding fields in DKProto, so they are placed in the tags. These values are only displayed when non-zero, such as:

| Field                         | Data Type | Unit | Description             | Correspond                             |
| :---------------------------- | :-------- | :--- | :---------------------- | :------------------------------------- |
| span.dropped_attributes_count | `int`     |      | Number of dropped span attributes | `DKProto.tags.dropped_attributes_count` |
| span.dropped_events_count     | `int`     |      | Number of dropped span events   | `DKProto.tags.dropped_events_count`     |
| span.dropped_links_count      | `int`     |      | Number of dropped span links   | `DKProto.tags.dropped_links_count`      |
| span.events_count             | `int`     |      | Number of associated span events | `DKProto.tags.events_count`             |
| span.links_count              | `int`     |      | Number of associated spans | `DKProto.tags.links_count`              |

---

## Jaeger Tracing Data Structure {#jaeger-trace-struct}

### Jaeger Thrift Protocol Batch Data Structure {#jaeger-thrift-batch-struct}

| Field Name | Data Type        | Unit | Description      | Corresponds To       |
| ---------- | ---------------- | ---- | ---------------- | ------------------- |
| Process    | `struct pointer` |      | Process-related data structure | `DKProto.Service`    |
| SeqNo      | `int64 pointer`  |      | Sequence number           | No direct correspondence with DKProto |
| Spans      | `array`          |      | Span array structure    | See table below              |
| Stats      | `struct pointer` |      | Client statistics structure   | Does not directly correspond to DKProto   |

### Jaeger Thrift Protocol Span Data Structure {#jaeger-thrift-span-struct}

| Field Name    | Data Type | Unit | Description                               | Corresponds To      |
| ------------- | --------- | ---- | ----------------------------------------- | ------------------ |
| TraceIdHigh   | `int64`   |      | High bits of Trace ID combined with TraceIdLow to form Trace ID  | `DKProto.TraceID`   |
| TraceIdLow    | `int64`   |      | Low bits of Trace ID combined with TraceIdHigh to form Trace ID | `DKProto.TraceID`   |
| ParentSpanId  | `int64`   |      | Parent Span ID                            | `DKProto.ParentID`  |
| SpanId        | `int64`   |      | Span ID                                   | `DKProto.SpanID`    |
| OperationName | `string`  |      | Method name that generated this Span                    | `DKProto.Operation` |
| Flags         | `int32`   |      | Span Flags                                | Does not directly correspond to DKProto  |
| Logs          | `array`   |      | Span Logs                                 | Does not directly correspond to DKProto  |
| References    | `array`   |      | Span References                           | Does not directly correspond to DKProto  |
| StartTime     | `int64`   | Nanoseconds | Span start time                             | `DKProto.Start`     |
| Duration      | `int64`   | Nanoseconds | Duration                                      | `DKProto.Duration`  |
| Tags          | `array`   |      | Span Tags currently only take Span state fields          | `DKProto.Status`    |

---

## SkyWalking Tracing Data Data Structure {#sw-trace-struct}

<!-- markdownlint-disable MD013 -->
### Segment Object Generated By Protobuf Protocol V3 {#sw-v3-pb-struct}
<!-- markdownlint-enable -->

| Field Name      | Data Type | Unit | Description                                     | Corresponds To        |
| --------------- | --------- | ---- | ----------------------------------------------- | -------------------- |
| TraceId         | `string`  |      | Trace ID                                        | `DKProto.TraceID`     |
| TraceSegmentId  | `string`  |      | Segment ID used together with Span ID to uniquely identify a Span | `DKProto.SpanID` high bits |
| Service         | `string`  |      | Service name                                          | `DKProto.Service`     |
| ServiceInstance | `string`  |      | Logical relationship name of node                                  | Unused field           |
| Spans           | `array`   |      | Tracing Span array                               | See table below               |
| IsSizeLimited   | `bool`    |      | Whether all Spans on the path are included                         | Unused field           |

### SkyWalking Span Object Data Structure in Segment Object {#sw-span-struct}

| Field Name    | Data Type | Unit | Description                                                   | Corresponds To          |
| ------------- | --------- | ---- | ------------------------------------------------------------- | ---------------------- |
| ComponentId   | `int32`   |      | Numerical definition of third-party frameworks                                          | Unused field             |
| Refs          | `array`   |      | Stores Parent Segment in cross-thread cross-process scenarios                         | `DKProto.ParentID` high bits |
| ParentSpanId  | `int32`   |      | Parent Span ID used together with Segment ID to uniquely identify a Parent Span | `DKProto.ParentID` low bits |
| SpanId        | `int32`   |      | Span ID used together with Segment ID to uniquely identify a Span               | `DKProto.SpanID` low bits   |
| OperationName | `string`  |      | Span Operation Name                                           | `DKProto.Operation`     |
| Peer          | `string`  |      | Communication peer                                                      | `DKProto.Endpoint`      |
| IsError       | `bool`    |      | Span status field                                                 | `DKProto.Status`        |
| SpanType      | `int32`   |      | Numerical definition of Span Type                                          | `DKProto.SpanType`      |
| StartTime     | `int64`   | Milliseconds | Span start time                                                 | `DKProto.Start`         |
| EndTime       | `int64`   | Milliseconds | Span end time subtracted from StartTime represents duration                        | `DKProto.Duration`      |
| Logs          | `array`   |      | Span Logs                                                     | Unused field             |
| SkipAnalysis  | `bool`    |      | Skip backend analysis                                                  | Unused field             |
| SpanLayer     | `int32`   |      | Numerical definition of Span technology stack                                         | Unused field             |
| Tags          | `array`   |      | Span Tags                                                     | Unused field             |

---

## Zipkin Tracing Data Data Structure {#zk-trace-struct}

### Zipkin Thrift Protocol Span Data Structure V1 {#zk-thrift-v1-span-struct}

| Field Name        | Data Type | Unit | Description         | Corresponds To      |
| ----------------- | --------- | ---- | ------------------- | ------------------ |
| TraceIDHigh       | `uint64`  |      | High bits of Trace ID       | No direct correspondence     |
| TraceID           | `uint64`  |      | Trace ID            | `DKProto.TraceID`   |
| ID                | `uint64`  |      | Span ID             | `DKProto.SpanID`    |
| ParentID          | `uint64`  |      | Parent Span ID      | `DKProto.ParentID`  |
| Annotations       | `array`   |      | Get Service Name   | `DKProto.Service`   |
| Name              | `string`  |      | Span Operation Name | `DKProto.Operation` |
| BinaryAnnotations | `array`   |      | Get Span status field  | `DKProto.Status`    |
| Timestamp         | `uint64`  | Microseconds | Span start time       | `DKProto.Start`     |
| Duration          | `uint64`  | Microseconds | Span duration           | `DKProto.Duration`  |
| Debug             | `bool`    |      | Debug status field      | Unused field         |

### Zipkin Span Data Structure V2 {#zk-thrift-v2-span-struct}

| Field Name     | Data Type | Unit | Description                      | Corresponds To      |
| -------------- | --------- | ---- | -------------------------------- | ------------------ |
| TraceID        | `struct`  |      | Trace ID                         | `DKProto.TraceID`   |
| ID             | `uint64`  |      | Span ID                          | `DKProto.SpanID`    |
| ParentID       | `uint64`  |      | Parent Span ID                   | `DKProto.ParentID`  |
| Name           | `string`  |      | Span Operation Name              | `DKProto.Operation` |
| Debug          | `bool`    |      | Debug status                     | Unused field         |
| Sampled        | `bool`    |      | Sampling status field                     | Unused field         |
| Err            | `string`  |      | Error Message                    | Does not directly correspond to DKProto  |
| Kind           | `string`  |      | Span Type                        | `DKProto.SpanType`  |
| Timestamp      | `struct`  | Microseconds | Microsecond-level time structure representing Span start time | `DKProto.Start`     |
| Duration       | `int64`   | Microseconds | Span duration                        | `DKProto.Duration`  |
| Shared         | `bool`    |      | Shared status                         | Unused field         |
| LocalEndpoint  | `struct`  |      | Used to get Service Name            | `DKProto.Service`   |
| RemoteEndpoint | `struct`  |      | Communication peer                         | `DKProto.Endpoint`  |
| Annotations    | `array`   |      | Used to explain delay-related events           | Unused field         |
| Tags           | `map`     |      | Used to get Span status               | `DKProto.Status`    |
