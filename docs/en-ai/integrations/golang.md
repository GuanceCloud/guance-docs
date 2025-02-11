---
title     : 'Golang'
summary   : 'Collect metrics, trace data, and logs from Golang applications'
__int_icon: 'icon/go'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Golang
<!-- markdownlint-enable -->

Report information from Golang applications to Guance:

- Collect custom Metrics data from the application;
- Collect trace data from the application;
- Manage all logs from the application.

## Trace {#tracing}

Golang provides an intrusive method to inject probe information.

<!-- markdownlint-disable MD046 -->
=== "OpenTelemetry"

    [OpenTelemetry Integration](opentelemetry-go.md)

=== "DDTrace"

    [DDTrace Integration](ddtrace-golang.md)

<!-- markdownlint-enable -->

## Profiling {#profiling}

Golang Profiling can be used to collect performance data during program execution.

<!-- markdownlint-disable MD046 -->

=== "DDTrace"

    [DDTrace Go Profiling](profile-go.md)

<!-- markdownlint-enable -->