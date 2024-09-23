---
title     : 'PHP'
summary   : 'Obtain metrics, link tracking, and log information for PHP applications'
__int_icon: 'icon/php'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!--markdownlint-disable MD025-->
# PHP
<!--markdownlint-enable -->

Report PHP application related information to the Observation Cloud:

- Collect custom metric data from the application;
- Collect link tracking data from the application;
- Manage all logs for the application.

## Trace {#tracing}

PHP provides a non-invasive way to inject probe information.

[DDTrace PHP integration](ddtrace-php.md)

## Profiling {#profiling}

PHP Profiling can be used to collect performance data during program execution.

[DDTrace PHP profiling integration](profile-php.md)

