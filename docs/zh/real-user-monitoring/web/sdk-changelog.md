# 更新日志
---


## 2022/9/29

初始化参数新增 `isIntakeUrl` 配置，用于根据请求资源 URL 判断是否需要采集对应资源数据，默认都采集。

## 2022/3/10

1. 新增 `traceType` 配置链路追踪工具类型，如果不配置，默认为`ddtrace`。目前支持 6 种数据类型：`ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent`。

2. 新增 `allowedTracingOrigins` 允许注入 Trace 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则。

3. 原配置项 `allowedDDTracingOrigins` 与新增配置项 `allowedTracingOrigins` 属于同一个功能配置。两者可以任取其一配置，如果两者都配置，则 `allowedTracingOrigins` 的权重高于`allowedDDTracingOrigins`。

## 2021/5/20

1. 配合 V2 版本指标数据变更，需要升级 DataKit 1.1.7-rc0之后的版本。更多详情，可参考 [DataKit 配置](../../integrations/rum.md)。

2. SDK 升级 V2 版本，CDN 地址变更为 `https://static.guance.com/browser-sdk/v2/dataflux-rum.js`。

3. 删除 `rum_web_page_performance`、`rum_web_resource_performance`、` js_error`、`page` 指标数据收集，新增 `view`, `action`, `long_task`, `error` 指标数据采集。

4. 初始化新增 `trackInteractions` 配置，用于开启 Action（用户行为数据）采集，默认为关闭状态。