---
title     : 'Golang'
summary   : '获取 Golang 应用的指标、链路追踪和日志信息'
__int_icon: 'icon/go'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Golang
<!-- markdownlint-enable -->

将 Golang 应用程序相关信息上报到{{{ custom_key.brand_name }}}：

- 从应用当中收集自定义指标数据；
- 从应用中收集链路追踪数据；
- 管理应用的所有日志。

## Trace {#tracing}

Golang 提供了侵入式方式注入探针信息。

<!-- markdownlint-disable MD046 -->
=== "OpenTelemetry"

    [OpenTelemetry 接入](opentelemetry-go.md)

=== "DDTrace"

    [DDTrace 接入](ddtrace-golang.md)

<!-- markdownlint-enable -->

## Profiling {#profiling}

Golang Profiling，可以用于采集程序运行中的性能数据。

<!-- markdownlint-disable MD046 -->

=== "DDTrace"

    [DDTrace Go profiling](profile-go.md)

<!-- markdownlint-enable -->