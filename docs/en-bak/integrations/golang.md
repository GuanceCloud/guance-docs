---
title     : 'Golang'
summary   : 'Obtain metrics, link tracking, and log information for Golang applications'
__int_icon: 'icon/go'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Golang
<!-- markdownlint enable -->

Report relevant information about the Golang application to the Observation Cloud:

- Collect custom metric data from the application;
- Collect link tracking data from the application;
- Manage all logs for the application.

## Trace {#tracing}


Golang provides invasive injection of probe information.


<!-- markdownlint-disable MD046 MD009 MD051 -->

=== "OpenTelemetry"

    [OpenTelemetry](opentelemetry-go.md)

=== "DDTrace"

    [DDTrace](ddtrace-golang.md)

<!-- markdownlint-enable -->


## Profiling {#profiling}

Golang Profiling can be used to collect performance data during program operation.

<!-- markdownlint-disable MD046 MD009 MD051-->

=== "DDTrace"

    [DDTrace Go profiling](profile-go.md)

<!--markdownlint-enable -->
