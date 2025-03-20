---
title     : 'PHP'
summary   : '获取 PHP 应用的指标、链路追踪和日志信息'
__int_icon: 'icon/php'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# PHP
<!-- markdownlint-enable -->

将 PHP 应用程序相关信息上报到<<< custom_key.brand_name >>>：

- 从应用当中收集自定义指标数据；
- 从应用中收集链路追踪数据；
- 管理应用的所有日志。

## Trace {#tracing}

PHP 提供了非侵入式方式注入探针信息。


[DDTrace 接入](ddtrace-php.md)

## Profiling {#profiling}

PHP Profiling，可以用于采集程序运行中的性能数据。

[DDTrace PHP profiling](profile-php.md)
