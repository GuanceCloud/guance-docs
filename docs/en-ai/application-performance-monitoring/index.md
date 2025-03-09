---
icon: zy/application-performance-monitoring
---
# Application Performance Monitoring (APM)
---

<video controls="controls" poster="https://<<< custom_key.static_domain >>>/dataflux/help/video/apm.jpeg" >
      <source id="mp4" src="https://<<< custom_key.static_domain >>>/dataflux/help/video/apm.mp4" type="video/mp4">
</video>

APM supports collectors using the Opentracing protocol to achieve end-to-end tracing analysis for applications in a distributed architecture. It correlates with infrastructure, logs, and RUM data to quickly identify and resolve issues, enhancing user experience.

![](img/1.apm-2.png)

The optimal deployment strategy is to deploy DataKit on each application server. Data from the service host's DataKit is then sent to the <<< custom_key.brand_name >>> center, which better aggregates server metrics, application logs, system logs, and application service trace data for unified correlation and analysis.

## Use Cases

![](img/apm-usecase.png)

<!--
- Efficient management of large-scale distributed applications: Through the service list, you can view ownership, dependencies, and performance metrics of different services in real-time, quickly identifying and resolving performance issues;
- End-to-end distributed tracing analysis: Using flame graphs, you can easily observe the flow and execution efficiency of each Span in the entire trace;
- Data correlation analysis: Automatically correlate infrastructure, logs, and RUM data through rich tagging features for comprehensive analysis;
- Method-level code performance tracking: Collect Profile data to obtain related code execution snippets for traces, visually displaying performance bottlenecks to help developers find optimization directions.
-->

## Features

<div class="grid cards" markdown>

- :material-format-list-text: __[Service Management](./service-manag/index.md)__：View service lists, performance metrics, and service call relationship topology maps.
- :fontawesome-solid-globe: __[Overview](overview.md)__：View the number of online services, P90 service response time, maximum impact service response time, and other metrics.
- :material-vector-line: __[Traces](./explorer/index.md)__：Query and analyze all collected trace data using tools like flame graphs.
- :material-weather-lightning-rainy: __[Error Tracking](error.md)__：View historical trends and distribution of similar errors in traces to quickly locate issues.
- :fontawesome-solid-code-compare: __[Profiling](profile.md)__：View application runtime metrics, display call relationships and efficiency in real-time, and optimize code performance.
- :material-cloud-search: __[Application Performance Metrics Detection](../monitoring/monitor/application-performance-detection.md)__：Configure APM monitors to promptly detect abnormal trace data.

</div>

## Data Storage and Billing Rules

<<< custom_key.brand_name >>> offers three data retention periods for APM data: 3 days, 7 days, and 14 days. You can adjust this in **Manage > Settings > Change Data Retention Policy** based on your needs.

> For more details on data retention policies, refer to [Data Retention Policies](../billing-method/data-storage.md).

Billing for APM is based on a pay-as-you-go model, counting the number of `trace_id` entries within the current workspace. The billing follows a tiered pricing structure.

> For more details on billing rules, refer to [Billing Methods](../billing-method/index.md).