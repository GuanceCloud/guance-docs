# Changelog
---

## 2023/5/22

1. Added a new `query` parameter for launching the mini program: `app_launch_query`;
2. Added custom Error configuration.

## 2022/9/29

A new initialization parameter `isIntakeUrl` has been added, which is used to determine whether to collect data for corresponding resources based on the request resource URL. By default, all resources are collected.

## 2022/3/29

1. Added the `traceType` configuration to specify the type of tracing tool. If not configured, it defaults to `ddtrace`. Currently, six data types are supported: `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, and `w3c_traceparent`;
   
2. Added the `allowedTracingOrigins` configuration to allow headers required by the Trace collector for all requests. This can be either an origin or a regular expression.