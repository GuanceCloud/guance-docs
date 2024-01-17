# APM Association Logs
---

Guance allows APM assoictaed logs, by injecting `span_id`, `trace_id`, `env`, `service` and `version` into the logs to associate with APM. After association, you can view the specific logs associated with the request in **APM**.

![](../../img/13.apm_log.png)

## Configure 

Before configuring the associated logs, you need to:

:material-numeric-1-circle: [Install DataKit](https://www.notion.so/datakit/datakit-install.md);

:material-numeric-2-circle: After installing DataKit, enable DDtrace, configure the chain's `env`, `service`, `version` parameters to associate logs, and inject log parameters `span_id`, `trace_id`, `env`, `service`, `version` and application performance parameters at the same time.

> For more configuration content, you can check [DDtrace](../../../integrations/ddtrace.md).
