---
title     : 'NodeJs'
summary   : 'Obtain metrics, APM traces, and log information for NodeJs applications'
__int_icon: 'icon/nodejs'
dashboard :
  - desc  : 'Not exist'
    path  : '-'
monitor   :
  - desc  : 'Not exist'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# NodeJs
<!-- markdownlint-enable -->

Report NodeJs application-related information to <<< custom_key.brand_name >>>:

- Collect custom Metrics data from the application;
- Collect APM trace data from the application;
- Manage all logs of the application.

## Trace {#tracing}

NodeJs provides an intrusive method to inject probe information.


[NodeJs DDTrace Integration](ddtrace-nodejs.md)

## Profiling {#profiling}

NodeJs Profiling can be used to collect performance data during program execution.

[DDTrace NodeJs profiling](profile-nodejs.md)