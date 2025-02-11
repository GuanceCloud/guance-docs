---
icon: zy/application-performance-monitoring
---
# Application Performance Monitoring (APM)
---

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/apm.jpeg" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/apm.mp4" type="video/mp4">
</video>

APM supports collectors using the Opentracing protocol to achieve end-to-end trace analysis for distributed architecture applications, and correlates with infrastructure, logs, and user access monitoring (RUM) to quickly locate and resolve issues, enhancing user experience.

![](img/1.apm-2.png)

The optimal deployment strategy is to deploy DataKit on each application server. By sending data from the DataKit on the host where the service resides to the Guance center, this approach can better aggregate server metrics, application logs, system logs, and application service trace data for unified correlation analysis.

## Use Cases

![](img/apm-usecase.png)

<!--
- Efficient management of large-scale distributed applications: Through the service list, you can view ownership, dependencies, and performance metrics of different services in real-time, quickly identifying and resolving performance issues;
- End-to-end distributed trace analysis: Using flame graphs, you can easily observe the flow and execution efficiency of each Span in the entire trace;
- Data correlation analysis: Automatically correlate infrastructure, logs, and RUM data using rich tagging features for analysis;
- Method-level code performance tracing: Collect Profile data to obtain associated code execution snippets related to trace Spans, intuitively displaying performance bottlenecks to help developers find optimization directions.
-->

## Feature Introduction

<div class="grid cards" markdown>

- :material-format-list-text: __[Service Management](./service-manag/index.md)__：View service lists, performance metrics, and topology maps of service call relationships
- :fontawesome-solid-globe: __[Summary](overview.md)__：View metrics such as the number of online services, P90 service response time, and maximum impact service response time
- :material-vector-line: __[Explorer](./explorer/index.md)__：Query and analyze all collected trace data using tools like flame graphs
- :material-weather-lightning-rainy: __[Incident](error.md)__：Supports viewing historical trends and distribution of similar errors in traces for quick error localization
- :fontawesome-solid-code-compare: __[Profiling](profile.md)__：View application runtime metrics, display call relationships and efficiency in real-time, and optimize code performance
- :material-cloud-search: __[Application Performance Metrics Detection](../monitoring/monitor/application-performance-detection.md)__：Configure APM monitors to detect abnormal trace data promptly

</div>

## Data Storage and Billing Rules

Guance provides three data retention periods for APM data: 3 days, 7 days, and 14 days. You can adjust these settings in **Management > Settings > Change Data Retention Policy** according to your needs.

> For more data retention policies, refer to [Data Retention Policy](../billing-method/data-storage.md).

Based on a <u>pay-as-you-go</u> billing model, APM charges based on the number of `trace_id` entries in the current workspace, using a tiered pricing structure.

> For more billing rules, refer to [Billing Method](../billing-method/index.md).