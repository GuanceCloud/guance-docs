---
title     : 'Golang'
summary   : 'Obtain metrics, link tracking, and log information for Golang applications'
__int_icon: 'icon/go'
dashboard :
  - desc  : 'No'
    path  : -
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!--Markdownlint disable MD025-->

# Golang

<!--Markdownlint enable -->


Report relevant information about the Golang application to the Observation Cloud: 

- Collect custom indicator data from the application; 

- Collect link tracking data from the application; 

- Manage all logs for the application. 


## Trace {#tracing}


Golang provides invasive injection of probe information. 


<!-- Markdownlint disable MD046 -->

=== "OpenTelemetry"

    [OpenTelemetry](opentelemetry-go.md)

=== "DDTrace"

    [DDTrace](ddtrace-golang.md)

<!--Markdownlint enable -->


## Profiling {#profiling}

Golang Profiling can be used to collect performance data during program operation. 

<!--Markdownlint disable MD046-->

=== "DDTrace"

    [DDTrace Go profiling](profile-go.md)

<!--Markdownlint enable -->
