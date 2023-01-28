# Application Performance Monitoring Association Log
---

## Introduction

Guance supports users to access the monitoring association log, and associates the application performance monitoring by injecting `span_id`, `trace_id`, `env`, `service` and `version` into the log. After association, the specific log associated with the request can be viewed in the application performance monitoring.

![](../../img/13.apm_log.png)

## Configure Association Log

Before configuring the association log, you need to [install DataKit](../../../datakit/datakit-install.md). After installing DataKit and opening DDtrace, configure the link's parameters such as `env`, `service` and `version` to associate logs, and inject log parameters `span_id`, `trace_id`, `env`, `service` and `version` to associate with application performance parameters in application code. See the document [DDtrace](../../../datakit/ddtrace.md).
