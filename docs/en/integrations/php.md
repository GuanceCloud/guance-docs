---
title     : 'PHP'
summary   : 'Get metrics, trace data, and log information from PHP applications'
__int_icon: 'icon/php'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# PHP
<!-- markdownlint-enable -->

Report relevant information from PHP applications to Guance:

- Collect custom Metrics data from the application;
- Collect trace data from the application;
- Manage all logs from the application.

## Trace {#tracing}

PHP provides a non-intrusive way to inject probe information.


[DDTrace Integration](ddtrace-php.md)

## Profiling {#profiling}

PHP Profiling can be used to collect performance data during program execution.

[DDTrace PHP Profiling](profile-php.md)