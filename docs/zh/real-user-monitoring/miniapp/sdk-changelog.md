# 更新日志
---

## 2023/5/22

1. 新增启动小程序的 `query` 参数：`app_launch_query`；
2. 新增自定义添加 Error。

## 2022/9/29

初始化参数新增 `isIntakeUrl` 配置，用于根据请求资源 URL 判断是否需要采集对应资源数据，默认都采集。 

## 2022/3/29

1. 新增 `traceType` 配置，配置链路追踪工具类型，如果不配置默认为 `ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型；  

2. 新增 `allowedTracingOrigins` 允许注入 Trace 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则。