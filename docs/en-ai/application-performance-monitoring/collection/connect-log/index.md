# APM Log Correlation
---

Guance supports RUM log correlation by injecting `span_id`, `trace_id`, `env`, `service`, and `version` into logs to correlate with APM. After correlation, specific logs associated with requests can be viewed in **APM**.

![](../../img/13.apm_log.png)

## Configuring Log Correlation

Before configuring log correlation, you need to:

:material-numeric-1-circle: [Install DataKit](../../../datakit/datakit-install.md);

:material-numeric-2-circle: After installing DataKit, enable DDtrace and configure the `env`, `service`, `version` parameters for tracing to correlate logs. Additionally, inject log parameters `span_id`, `trace_id`, `env`, `service`, `version` into your application code to associate with APM metrics.

> For more configuration details, see [DDtrace](../../../integrations/ddtrace.md).