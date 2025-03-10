---
title     : 'NodeJs'
summary   : 'Collect metrics, trace data, and logs from NodeJs applications'
__int_icon: 'icon/node_js'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# NodeJs
<!-- markdownlint-enable -->

Report information from NodeJs applications to Guance:

- Collect custom Metrics data from the application;
- Collect trace data from the application;
- Manage all logs from the application.

## Trace {#tracing}

NodeJs provides an intrusive method to inject probe information.


[NodeJs DDTrace Integration](ddtrace-nodejs.md)

## Profiling {#profiling}

NodeJs Profiling can be used to collect performance data during program execution.

[DDTrace NodeJs Profiling](profile-nodejs.md)