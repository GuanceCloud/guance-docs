# Changelog
---

## 2022/9/29

The initialization parameters have added the `isIntakeUrl` configuration, which is used to determine whether to collect data for the corresponding resource based on the request resource URL. By default, all resources are collected.

## 2022/3/10

1. Added the `traceType` configuration for the type of trace tool. If not configured, it defaults to `ddtrace`. Currently supports 6 types of data: `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.

2. Added the `allowedTracingOrigins` configuration to allow a list of all requests that need headers injected by the Trace collector. This can be the origin of the request or a regular expression.

3. The original configuration item `allowedDDTracingOrigins` and the new configuration item `allowedTracingOrigins` belong to the same feature configuration. Either one can be chosen; if both are configured, the priority of `allowedTracingOrigins` is higher than `allowedDDTracingOrigins`.

## 2021/5/20

1. To align with changes in V2 Metrics data, DataKit must be upgraded to version 1.1.7-rc0 or later. For more details, refer to [DataKit Configuration](../../integrations/rum.md).

2. The SDK has been upgraded to V2, and the CDN address has changed to `https://static.guance.com/browser-sdk/v2/dataflux-rum.js`.

3. Removed the collection of `rum_web_page_performance`, `rum_web_resource_performance`, `js_error`, `page` Metrics data, and added the collection of `view`, `action`, `long_task`, `error` Metrics data.

4. Added the `trackInteractions` configuration during initialization to enable Action (user behavior data) collection. It is disabled by default.