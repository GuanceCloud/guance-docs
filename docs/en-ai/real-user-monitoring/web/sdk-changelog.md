# Changelog
---

## 2022/9/29

The initialization parameters have added the `isIntakeUrl` configuration, which is used to determine whether to collect data for the corresponding resource based on the request resource URL. By default, all resources are collected.

## 2022/3/10

1. Added the `traceType` configuration for tracing tool types. If not configured, it defaults to `ddtrace`. Currently supports 6 data types: `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, and `w3c_traceparent`.

2. Added the `allowedTracingOrigins` configuration, which lists all requests allowed to inject Trace collector headers. This can be a request origin or a regular expression.

3. The original configuration item `allowedDDTracingOrigins` and the new configuration item `allowedTracingOrigins` belong to the same functional configuration. Either one can be chosen; if both are configured, `allowedTracingOrigins` takes precedence over `allowedDDTracingOrigins`.

## 2021/5/20

1. To align with changes in V2 Metrics data, DataKit needs to be upgraded to version 1.1.7-rc0 or later. For more details, refer to [DataKit Configuration](../../integrations/rum.md).

2. The SDK has been upgraded to V2, and the CDN address has changed to `https://<<< custom_key.static_domain >>>/browser-sdk/v2/dataflux-rum.js`.

3. Removed data collection for `rum_web_page_performance`, `rum_web_resource_performance`, `js_error`, and `page` metrics, and added data collection for `view`, `action`, `long_task`, and `error` metrics.

4. The initialization parameters have added the `trackInteractions` configuration to enable Action (user behavior data) collection, which is disabled by default.