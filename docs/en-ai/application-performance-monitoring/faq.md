# Frequently Asked Questions
---

## How to Collect APM Data?

Guance currently supports collectors using the Opentracing protocol for trace data collection. After enabling the trace data reception service in DataKit, by completing the instrumentation in the code, DataKit will automatically handle the data format conversion and collection, finally reporting it to the Guance center. DataKit currently supports collecting Tracing data from third-party tools such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking`, and `Zipkin`.

> For more operations, refer to [APM](../application-performance-monitoring/index.md).

## How to Collect Profile Data?

Profile supports collecting dynamic performance data of applications running in different language environments such as Java, Python, and Go, helping users identify issues related to CPU, memory, and IO performance.

> For configuration details, refer to [Profile Collection Configuration](../integrations/profile.md).

## How to Correlate Log Data?

Guance supports correlating APM data by injecting `span_id`, `trace_id`, `env`, `service`, and `version` into logs. After correlation, you can view specific logs associated with requests in APM.

> For detailed steps, refer to [Java Log Correlation with Trace Data](../application-performance-monitoring/collection/connect-log/java.md) or [Python Log Correlation with Trace Data](../application-performance-monitoring/collection/connect-log/python.md).

## How to Correlate User Access Data?

User access monitoring through collectors like `ddtrace`, `zipkin`, `skywalking`, `jaeger`, and `opentelemetry` can track complete front-end to back-end request data for web applications. Using RUM data from the front end and injecting `trace_id` into the back end allows for quick identification of call stacks.

> For detailed steps, refer to [Correlate Web Application Access](../application-performance-monitoring/collection/connect-web-app.md).

## How to Configure APM Data Sampling?

By default, Guance collects APM data in full volume. You can set a sampling rate in your code or during collector configuration to save on data storage.

> If you use Python, refer to [How to Configure APM Sampling](../application-performance-monitoring/collection/sampling.md); if you use Java, refer to [DDTrace Sampling](../integrations/ddtrace.md).

## How Long Can APM Data Be Retained?

Guance offers three retention periods for APM data: 3 days, 7 days, and 14 days. You can adjust this in **Management > Settings > Change Data Storage Policy** according to your needs.

> For more data storage policies, refer to [Data Storage Policy](../billing-method/data-storage.md).

## How to Calculate APM Monitoring Costs?

Guance supports pay-as-you-go billing based on usage. APM billing is calculated based on the number of `trace_id` entries in the current workspace, using a tiered pricing model.

> For more billing rules, refer to [Billing Method](../billing-method/index.md).

## How to Configure the Service List?

The Service List allows you to configure ownership, dependencies, associated analysis, help documentation, etc., for different services, aiding teams in efficiently building and managing large-scale distributed applications. You can configure the Service List by selecting any **Service** in **APM > Services** and clicking the operation button on the right side.

> For more details, refer to [Service List](./service-manag/service-list.md).

## How to Quickly Identify Issues via Error Traces?

Guance supports quickly filtering error traces in the [Explorer](../application-performance-monitoring/explorer/explorer-analysis.md) or directly viewing historical trends and distribution of similar errors in the [Incident Explorer](../application-performance-monitoring/error.md), helping to quickly pinpoint performance issues.

## If the Above FAQs Do Not Solve Your Problem, How to Get Online Support?

Guance provides online ticket support.

> For more details, refer to [Support Center](../billing-center/support-center.md).