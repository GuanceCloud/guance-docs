# FAQ

---

## How to collect APM data?

Guance's trace data collection currently supports collectors using the Opentracing protocol. After opening the trace data reception service in DataKit, by completing the collector's embedding in the code, DataKit will automatically complete the data format conversion and collection, and finally report to Guance. DataKit currently supports the collection of third-party Tracing data such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking`, `Zipkin`.

> For more operations, see [APM](../application-performance-monitoring/index.md).


## How to collect Profile data?

Profile supports the collection of dynamic performance data during the operation of applications in different language environments such as Java, Python, and Go, helping users view CPU, memory, IO performance issues.

> For collection configuration, see [Profile Collection Configuration](../integrations/profile.md).


## How to associate log data?

Guance supports the association of APM by injecting `span_id`, `trace_id`, `env`, `service`, `version` into the log. After the association, you can view the specific log associated with the request in the APM.

> For operation steps, see [Java Log Associated trace data](../application-performance-monitoring/collection/connect-log/java.md) or [Python Log Associated trace data](../application-performance-monitoring/collection/connect-log/python.md).


## How to associate user access data?

RUM can track a complete front-end to back-end request data of a web application through `ddtrace`, `zipkin`, `skywalking`, `jaeger`, `opentelemetry` collectors, using RUM data from the front end and `trace_id` injected into the back end, you can quickly locate the call stack.

> For operation steps, see [Associated Web Application Access](../application-performance-monitoring/collection/connect-web-app.md).


## How to configure application performance data sampling?

By default, Guance collects application performance data in full. You can save data storage by setting the sampling rate in the code or when configuring the collector.

> If you use Python, see [How to Configure APM Sampling](../application-performance-monitoring/collection/sampling.md); if you use Java, see [ddtrace Sampling](../integrations/ddtrace.md).


## How long can application performance data be stored?

Guance provides 3 days, 7 days, 14 days three data storage duration options, you can adjust in **Management > Settings > Change Data Storage Strategy** according to your needs.

> For more data storage strategies, see [Data Storage Policy](../billing/billing-method/data-storage.md).


## How to calculate the cost of APM?

Guance supports on-demand purchase and pay-as-you-go billing. The billing of APM counts the number of `trace_id` under the current space and uses a gradient billing mode.

> For more billing rules, see [Billing Methods](../billing/billing-method/index.md).


## How to configure the service list?

The service list supports you to configure the ownership, dependency, associated analysis, help documentation, etc. of different services, helping the team to efficiently build and manage large-scale end-to-end distributed applications. You can go to **APM > Service**, select any **Options** button on the right, you can open the service list for configuration.

> For more details, see [Service List](../application-performance-monitoring/service-catalog.md).


## How to quickly find problems through error links?

Guance supports quickly filtering error links in [Link Viewer](https://www.notion.so/application-performance-monitoring/explorer.md), or directly viewing the history trend and distribution of similar errors in the link in [Error Tracking Viewer](https://www.notion.so/application-performance-monitoring/error.md), helping to quickly locate performance problems.

## If the above common problems cannot solve your problem, how to get online support?

Guance provides online ticket support.

> For more details, see [Support Center](../billing/cost-center/support-center.md).
