---
title     : 'NodeJs'
summary   : 'Obtain metrics, link tracking, and log information for NodeJs applications'
__int_icon: 'icon/nodejs'
dashboard :
  - desc  : 'No'
    path  : -
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# NodeJs
<!-- markdownlint enable -->

Report NodeJs application related information to the Observation Cloud:

- Collect custom metric data from the application;
- Collect link tracking data from the application;
- Manage all logs for the application.

## Trace {#tracing}

PHP provides a invasive way to inject probe information.

[DDTrace NodeJs integration](ddtrace-nodejs.md)

## Profiling {#profiling}

NodeJs Profiling can be used to collect performance data during program execution.

[DDTrace NodeJs profiling integration](profile-nodejs.md)

