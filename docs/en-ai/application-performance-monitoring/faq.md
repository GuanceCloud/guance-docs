# Frequently Asked Questions
---

## How to Collect APM Data?

<<< custom_key.brand_name >>> currently supports collectors using the Opentracing protocol for trace data collection. After enabling the trace data reception service in DataKit, by completing the instrumentation in the code, DataKit will automatically handle the data format conversion and collection, ultimately reporting it to the <<< custom_key.brand_name >>> center. DataKit currently supports collecting tracing data from third-party tools such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking`, and `Zipkin`.

> For more operations, refer to [APM](../application-performance-monitoring/index.md).

## How to Collect Profile Data?

Profile supports collecting dynamic performance data of applications running in different language environments like Java, Python, and Go, helping users identify CPU, memory, and IO performance issues.

> For collection configuration, refer to [Profile Collection Configuration](../integrations/profile.md).

## How to Correlate Log Data?

<<< custom_key.brand_name >>> supports injecting `span_id`, `trace_id`, `env`, `service`, and `version` into logs to correlate with APM. After correlation, specific logs associated with requests can be viewed within APM.

> For operational steps, refer to [Java Log Correlation](../application-performance-monitoring/collection/connect-log/java.md) or [Python Log Correlation](../application-performance-monitoring/collection/connect-log/python.md).

## How to Correlate User Access Data?

User access monitoring through collectors like `ddtrace`, `zipkin`, `skywalking`, `jaeger`, and `opentelemetry` can track complete front-to-back-end request data for a web application. Using RUM data from the frontend and injecting `trace_id` into the backend allows for quick identification of call stacks.

> For operational steps, refer to [Correlate Web Application Access](../application-performance-monitoring/collection/connect-web-app.md).

## How to Configure Sampling for APM Data?

By default, <<< custom_key.brand_name >>> collects APM data in full volume. You can save storage space by setting the sampling rate in your code or during collector configuration.

> If you are using Python, refer to [Configuring APM Sampling](../application-performance-monitoring/collection/sampling.md); if you are using Java, refer to [DDTrace Sampling](../integrations/ddtrace.md).

## How Long Can APM Data Be Retained?

<<< custom_key.brand_name >>> offers three retention periods for APM data: 3 days, 7 days, and 14 days. You can adjust this in **Management > Settings > Change Data Storage Policy** according to your needs.

> For more data storage policies, refer to [Data Storage Policies](../billing-method/data-storage.md).

## How to Calculate APM Monitoring Costs?

<<< custom_key.brand_name >>> supports pay-as-you-go billing based on demand. APM billing counts the number of `trace_id`s in the current workspace, using a tiered pricing model.

> For more billing rules, refer to [Billing Method](../billing-method/index.md).

## How to Configure the Service List?

The service list allows you to configure ownership, dependencies, associated analysis, documentation, etc., for different services, helping teams efficiently build and manage large-scale end-to-end distributed applications. You can open the service list for configuration by selecting any **Service** and clicking the operation button on the right side under **APM > Services**.

> For more details, refer to [Service List](./service-manag/service-list.md).

## How to Quickly Identify Issues via Error Traces?

<<< custom_key.brand_name >>> supports quickly filtering error traces in the [Explorer](../application-performance-monitoring/explorer/explorer-analysis.md), or directly viewing similar error trends and distributions in the [Incident Explorer](../application-performance-monitoring/error.md) to help quickly pinpoint performance issues.

## If the Above FAQs Do Not Resolve Your Issue, How to Get Online Support?

<<< custom_key.brand_name >>> provides online ticket support.

> For more details, refer to [Support Center](../billing-center/support-center.md).