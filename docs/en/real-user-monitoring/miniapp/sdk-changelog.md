# Changelog
---

## 2023/5/22

1. Added a new `query` parameter for launching mini-programs: `app_launch_query`;
2. Added custom Error handling.

## 2022/9/29

The initialization parameters now include the `isIntakeUrl` configuration, which is used to determine whether to collect data from the corresponding resource based on the request resource URL. By default, all resources are collected.

## 2022/3/29

1. Added the `traceType` configuration to specify the type of tracing tool. If not configured, it defaults to `ddtrace`. Currently supported types include `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, and `w3c_traceparent`, totaling six data types;

2. Added `allowedTracingOrigins` to allow headers required by Trace collectors for all requests. This can be either the origin of the request or a regular expression.