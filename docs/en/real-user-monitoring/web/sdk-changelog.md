# Changelog
---

## 2022/9/29

The initialization parameter now includes a new `isIntakeUrl` configuration, which is used to determine whether to collect data for the corresponding resource based on the request resource URL. By default, all resources are collected.

## 2022/3/10

1. Added the `traceType` configuration for tracing tool types. If not configured, it defaults to `ddtrace`. Currently, six data types are supported: `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, and `w3c_traceparent`.

2. Added the `allowedTracingOrigins` configuration, which lists all requests allowed to inject the Trace collector headers. This can be either the request origin or a regular expression.

3. The original configuration item `allowedDDTracingOrigins` and the new configuration item `allowedTracingOrigins` belong to the same feature configuration. Either one can be configured, but if both are configured, `allowedTracingOrigins` takes precedence over `allowedDDTracingOrigins`.

## 2021/5/20

1. To align with changes in V2 Metrics data, DataKit must be upgraded to version 1.1.7-rc0 or later. For more details, refer to [DataKit Configuration](../../integrations/rum.md).

2. The SDK has been upgraded to V2, and the CDN address has changed to `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js`.

3. Removed the collection of `rum_web_page_performance`, `rum_web_resource_performance`, `js_error`, and `page` Metrics data, and added the collection of `view`, `action`, `long_task`, and `error` Metrics data.

4. A new `trackInteractions` configuration has been added during initialization to enable the collection of Action (user behavior data). It is disabled by default.