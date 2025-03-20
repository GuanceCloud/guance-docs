---
title     : 'PHP'
summary   : 'Get metrics, APM, and LOG information for PHP applications'
__int_icon: 'icon/php'
dashboard :
  - desc  : 'Not exist'
    path  : '-'
monitor   :
  - desc  : 'Not exist'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# PHP
<!-- markdownlint-enable -->

Report relevant information of PHP applications to Guance:

- Collect custom Metrics data from the application;
- Collect APM data from the application;
- Manage all LOGs of the application.

## Trace {#tracing}

PHP provides a non-intrusive way to inject probe information.


[DDTrace Integration](ddtrace-php.md)

## Profiling {#profiling}

PHP Profiling can be used to collect performance data during program execution.

[DDTrace PHP profiling](profile-php.md)