# APM Log Correlation
---

<<< custom_key.brand_name >>> supports RUM log correlation by injecting `span_id`, `trace_id`, `env`, `service`, and `version` into logs to correlate with APM. After correlation, specific related logs for a request can be viewed in **APM**.

![](../../img/13.apm_log.png)

## Configure Log Correlation

Before configuring log correlation, you need to:

:material-numeric-1-circle: [Install DataKit](../../../datakit/datakit-install.md);

:material-numeric-2-circle: After installing DataKit, enable DDtrace and configure the `env`, `service`, and `version` parameters for the trace to correlate logs. Additionally, inject log parameters `span_id`, `trace_id`, `env`, `service`, and `version` into the application code to associate with APM metrics.

> For more configuration details, see [DDtrace](../../../integrations/ddtrace.md).