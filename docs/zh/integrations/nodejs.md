---
title     : 'NodeJs'
summary   : '获取 NodeJs 应用的指标、链路追踪和日志信息'
__int_icon: 'icon/node_js'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# NodeJs
<!-- markdownlint-enable -->

将 NodeJs 应用程序相关信息上报到{{{ custom_key.brand_name }}}：

- 从应用当中收集自定义指标数据；
- 从应用中收集链路追踪数据；
- 管理应用的所有日志。

## Trace {#tracing}

NodeJs 提供了侵入式方式注入探针信息。


[NodeJs DDTrace 接入](ddtrace-nodejs.md)

## Profiling {#profiling}

NodeJs Profiling，可以用于采集程序运行中的性能数据。

[DDTrace NodeJs profiling](profile-nodejs.md)
