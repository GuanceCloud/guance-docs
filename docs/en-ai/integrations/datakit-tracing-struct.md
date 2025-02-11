---
skip: 'not-searchable-on-index-page'
title: 'Datakit Tracing Data Structure'
---

## Overview {#intro}

This document explains the data structures of mainstream Telemetry platforms and their mapping to the Datakit platform's data structure. Currently supported data structures include: DataDog/Jaeger/OpenTelemetry/SkyWalking/Zipkin/PinPoint

Data transformation steps:

1. External Tracing data is ingested through multiple protocols, then deserialized.
2. The deserialized objects are converted into `Line Protocol` (line protocol format).
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

[^1]: This field does not exist during Datakit collection and is only appended after it is stored in the database.

`span_type` indicates the relative position of the current Span within a Trace, with the following values:

- `entry`: Current API is the entry point, i.e., the first call after entering the service
- `local`: Current API is between the entry and exit points
- `exit`: Current API is the last call within the service
- `unknown`: The relative position of the current API is unclear

`priority` represents the client-side sampling priority rules:

- `PRIORITY_USER_REJECT = -1` User chooses to reject reporting
- `PRIORITY_AUTO_REJECT = 0` Client sampler chooses to reject reporting
- `PRIORITY_AUTO_KEEP = 1` Client sampler chooses to report
- `PRIORITY_USER_KEEP = 2` User chooses to report


## OpenTelemetry Tracing Data Structure {#otel-trace-struct}

When Datakit collects data sent from the OpenTelemetry Exporter (OTLP), the simplified raw data, serialized in JSON, looks as follows:

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

The correspondence between OpenTelemetry's `resource_spans` and DKProto is as follows:

| Field Name           | Data Type           | Unit | Description    | Correspond To                                                                                                                                                       |
| -------------------- | ------------------- | ---- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| trace_id             | `[16]byte`          |      | Trace ID       | `DKProto.TraceID`                                                                                                                                                    |
| span_id              | `[8]byte`           |      | Span ID        | `DKProto.SpanID`                                                                                                                                                     |
| parent_span_id       | `[8]byte`           |      | Parent Span ID | `DKProto.ParentID`                                                                                                                                                   |
| name                 | `string`            |      | Span Name      | `DKProto.Operation`                                                                                                                                                  |
| kind                 | `string`            |      | Span Type      | `DKProto.SpanType`                                                                                                                                                   |
| start_time_unix_nano | `int64`             | ns   | Span start time| `DKProto.Start`                                                                                                                                                      |
| end_time_unix_nano   | `int64`             | ns   | Span end time  | `DKProto.Duration = end - start`                                                                                                                                     |
| status               | `string`            |      | Span Status    | `DKProto.Status`                                                                                                                                                     |
| name                 | `string`            |      | Resource Name  | `DKProto.Resource`                                                                                                                                                   |
| resource.attributes  | `map[string]string` |      | Resource tags  | `DKProto.tags.service, DKProto.tags.project, DKProto.tags.env, DKProto.tags.version, DKProto.tags.container_host, DKProto.tags.http_method, DKProto.tags.http_status_code` |
| span.attributes      | `map[string]string` |      | Span tags      | `DKProto.tags`                                                                                                                                                       |

OpenTelemetry has some unique fields that do not have corresponding fields in DKProto, so they are placed in the tags and only shown when these values are non-zero, such as:

| Field                         | Data Type | Unit | Description             | Correspond                             |
| :---------------------------- | :-------- | :--- | :---------------------- | :------------------------------------- |
| span.dropped_attributes_count | `int`     |      | Number of dropped span tags | `DKProto.tags.dropped_attributes_count` |
| span.dropped_events_count     | `int`     |      | Number of dropped events | `DKProto.tags.dropped_events_count`     |
| span.dropped_links_count      | `int`     |      | Number of dropped links | `DKProto.tags.dropped_links_count`      |
| span.events_count             | `int`     |      | Number of associated events | `DKProto.tags.events_count`             |
| span.links_count              | `int`     |      | Number of associated spans | `DKProto.tags.links_count`              |

---

## Jaeger Tracing Data Structure {#jaeger-trace-struct}

### Jaeger Thrift Protocol Batch Data Structure {#jaeger-thrift-batch-struct}

| Field Name | Data Type        | Unit | Description      | Correspond to       |
| ---------- | ---------------- | ---- | ---------------- | ------------------- |
| Process    | `struct pointer` |      | Process-related data structure | `DKProto.Service`    |
| SeqNo      | `int64 pointer`  |      | Sequence number  | No direct mapping to DKProto |
| Spans      | `array`          |      | Array of Span structures | See table below          |
| Stats      | `struct pointer` |      | Client statistics structure | No direct mapping to DKProto |

### Jaeger Thrift Protocol Span Data Structure {#jaeger-thrift-span-struct}

| Field Name    | Data Type | Unit | Description                               | Correspond To      |
| ------------- | --------- | ---- | ----------------------------------------- | ------------------ |
| TraceIdHigh   | `int64`   |      | High part of Trace ID combined with TraceIdLow | `DKProto.TraceID`   |
| TraceIdLow    | `int64`   |      | Low part of Trace ID combined with TraceIdHigh | `DKProto.TraceID`   |
| ParentSpanId  | `int64`   |      | Parent Span ID                            | `DKProto.ParentID`  |
| SpanId        | `int64`   |      | Span ID                                   | `DKProto.SpanID`    |
| OperationName | `string`  |      | Method name generating this Span          | `DKProto.Operation` |
| Flags         | `int32`   |      | Span flags                                | No direct mapping to DKProto  |
| Logs          | `array`   |      | Span logs                                 | No direct mapping to DKProto  |
| References    | `array`   |      | Span references                           | No direct mapping to DKProto  |
| StartTime     | `int64`   | ns   | Span start time                           | `DKProto.Start`     |
| Duration      | `int64`   | ns   | Duration                                  | `DKProto.Duration`  |
| Tags          | `array`   |      | Span tags, currently only takes Span status | `DKProto.Status`    |

---

## SkyWalking Tracing Data Structure {#sw-trace-struct}

<!-- markdownlint-disable MD013 -->
### Segment Object Generated By Protobuf Protocol V3 {#sw-v3-pb-struct}
<!-- markdownlint-enable -->

| Field Name      | Data Type | Unit | Description                                     | Correspond To        |
| --------------- | --------- | ---- | ----------------------------------------------- | -------------------- |
| TraceId         | `string`  |      | Trace ID                                        | `DKProto.TraceID`     |
| TraceSegmentId  | `string`  |      | Segment ID used with Span ID to uniquely identify a Span | `DKProto.SpanID` 高位 |
| Service         | `string`  |      | Service name                                    | `DKProto.Service`     |
| ServiceInstance | `string`  |      | Logical relationship name of node               | Unused field         |
| Spans           | `array`   |      | Array of Tracing Spans                          | See table below      |
| IsSizeLimited   | `bool`    |      | Whether it contains all Spans on the path       | Unused field         |

### SkyWalking Span Object Data Structure in Segment Object {#sw-span-struct}

| Field Name    | Data Type | Unit | Description                                                   | Correspond To          |
| ------------- | --------- | ---- | ------------------------------------------------------------- | ---------------------- |
| ComponentId   | `int32`   |      | Numerical definition of third-party frameworks                | Unused field           |
| Refs          | `array`   |      | Stores Parent Segment in cross-thread, cross-process scenarios | `DKProto.ParentID` 高位 |
| ParentSpanId  | `int32`   |      | Parent Span ID used with Segment ID to uniquely identify a Parent Span | `DKProto.ParentID` 低位 |
| SpanId        | `int32`   |      | Span ID used with Segment ID to uniquely identify a Span      | `DKProto.SpanID` 低位   |
| OperationName | `string`  |      | Span operation name                                           | `DKProto.Operation`     |
| Peer          | `string`  |      | Communication peer                                            | `DKProto.Endpoint`      |
| IsError       | `bool`    |      | Span status field                                             | `DKProto.Status`        |
| SpanType      | `int32`   |      | Numerical definition of Span type                             | `DKProto.SpanType`      |
| StartTime     | `int64`   | ms   | Span start time                                               | `DKProto.Start`         |
| EndTime       | `int64`   | ms   | Span end time, subtracted from StartTime for duration         | `DKProto.Duration`      |
| Logs          | `array`   |      | Span logs                                                     | Unused field           |
| SkipAnalysis  | `bool`    |      | Skips backend analysis                                        | Unused field           |
| SpanLayer     | `int32`   |      | Numerical definition of Span technology stack                 | Unused field           |
| Tags          | `array`   |      | Span tags                                                     | Unused field           |

---

## Zipkin Tracing Data Structure {#zk-trace-struct}

### Zipkin Thrift Protocol Span Data Structure V1 {#zk-thrift-v1-span-struct}

| Field Name        | Data Type | Unit | Description         | Correspond To      |
| ----------------- | --------- | ---- | ------------------- | ------------------ |
| TraceIDHigh       | `uint64`  |      | High part of Trace ID | No direct mapping  |
| TraceID           | `uint64`  |      | Trace ID            | `DKProto.TraceID`   |
| ID                | `uint64`  |      | Span ID             | `DKProto.SpanID`    |
| ParentID          | `uint64`  |      | Parent Span ID      | `DKProto.ParentID`  |
| Annotations       | `array`   |      | Gets Service Name   | `DKProto.Service`   |
| Name              | `string`  |      | Span operation name | `DKProto.Operation` |
| BinaryAnnotations | `array`   |      | Gets Span status    | `DKProto.Status`    |
| Timestamp         | `uint64`  | us   | Span start time     | `DKProto.Start`     |
| Duration          | `uint64`  | us   | Span duration       | `DKProto.Duration`  |
| Debug             | `bool`    |      | Debug status        | Unused field        |

### Zipkin Span Data Structure V2 {#zk-thrift-v2-span-struct}

| Field Name     | Data Type | Unit | Description                      | Correspond To      |
| -------------- | --------- | ---- | -------------------------------- | ------------------ |
| TraceID        | `struct`  |      | Trace ID                         | `DKProto.TraceID`   |
| ID             | `uint64`  |      | Span ID                          | `DKProto.SpanID`    |
| ParentID       | `uint64`  |      | Parent Span ID                   | `DKProto.ParentID`  |
| Name           | `string`  |      | Span operation name              | `DKProto.Operation` |
| Debug          | `bool`    |      | Debug status                     | Unused field        |
| Sampled        | `bool`    |      | Sampling status                  | Unused field        |
| Err            | `string`  |      | Error message                    | No direct mapping   |
| Kind           | `string`  |      | Span type                        | `DKProto.SpanType`  |
| Timestamp      | `struct`  | us   | Microsecond-level time structure indicating Span start time | `DKProto.Start`     |
| Duration       | `int64`   | us   | Span duration                    | `DKProto.Duration`  |
| Shared         | `bool`    |      | Shared status                    | Unused field        |
| LocalEndpoint  | `struct`  |      | Used to get Service Name         | `DKProto.Service`   |
| RemoteEndpoint | `struct`  |      | Communication peer               | `DKProto.Endpoint`  |
| Annotations    | `array`   |      | Used to explain delay-related events | Unused field        |
| Tags           | `map`     |      | Used to get Span status          | `DKProto.Status`    |