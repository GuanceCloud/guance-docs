---
icon: zy/application-performance-monitoring
---
# Application Performance Monitoring (APM)
---

<video controls="controls" poster="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/apm.jpeg" >
      <source id="mp4" src="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/apm.mp4" type="video/mp4">
</video>

APM supports collectors using the Opentracing protocol to achieve end-to-end trace analysis for distributed applications, and correlates this with infrastructure, logs, and RUM data to quickly identify and resolve issues, enhancing user experience.

![](img/1.apm-2.png)

The optimal deployment strategy is to deploy DataKit on each application server, sending data from the host's DataKit to the <<< custom_key.brand_name >>> center. This allows for better aggregation of server metrics, application logs, system logs, and service trace data, enabling comprehensive correlation and analysis of various data sources.

## Use Cases

![](img/apm-usecase.png)

<!--
- Efficient management of large-scale distributed applications: Through the service list, you can view ownership, dependencies, and performance metrics of different services in real-time, quickly identifying and resolving performance issues;
- End-to-end distributed trace analysis: Using flame graphs, you can easily observe the flow and execution efficiency of each Span in the entire trace;
- Data correlation analysis: Automatically correlate infrastructure, logs, and RUM data through rich tagging features for analysis;
- Method-level code performance tracking: Collecting Profile data helps obtain related code execution snippets for trace-related Spans, intuitively showing performance bottlenecks and helping developers find optimization directions.
-->

## Features

<div class="grid cards" markdown>

- :material-format-list-text: __[Service Management](./service-manag/index.md)__：View the service list, performance metrics, and service call relationship topology
- :fontawesome-solid-globe: __[Overview](overview.md)__：View the number of online services, P90 service response time, maximum impact service response time, and other metrics
- :material-vector-line: __[Traces](./explorer/index.md)__：Query and analyze all collected trace data using tools like flame graphs
- :material-weather-lightning-rainy: __[Error Tracking](error.md)__：View historical trends and distribution of similar errors in traces for quick error localization
- :fontawesome-solid-code-compare: __[Profiling](profile.md)__：View application runtime metrics, display call relationships and efficiency in real-time, and optimize code performance
- :material-cloud-search: __[Application Performance Detection](../monitoring/monitor/application-performance-detection.md)__：Configure APM monitors to detect abnormal trace data promptly

</div>

## Data Storage and Billing Rules

<<< custom_key.brand_name >>> offers three data retention periods for APM data: 3 days, 7 days, and 14 days. You can adjust these settings in **Manage > Settings > Change Data Retention Policy** according to your needs.

> For more details on data retention policies, refer to [Data Retention Policies](../billing-method/data-storage.md).

Based on a pay-as-you-go model, APM billing is calculated based on the number of `trace_id` entries within the current workspace, using a tiered pricing structure.

> For more details on billing rules, refer to [Billing Methods](../billing-method/index.md).