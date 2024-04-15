---
icon: zy/application-performance-monitoring
---
# APM
---

APM supports collectors using the Opentracing protocol to perform end-to-end link analysis of applications in distributed architectures. It also correlates with infrastructure, logs, RUM, quickly locates and solves faults, and improves user experience.

![](img/1.apm-2.png)

The best deployment plan is to deploy DataKit on each application server and hit the data to Guance through the DataKit of the server where the service is located. This can better gather metrics of application server hosts, application logs, system logs, application service link data, etc., and perform correlation analysis of various data.

## Use Cases

![](img/apm-usecase.png)

## Features

<div class="grid cards" markdown>

- :material-format-list-text: **[Services](../scene/service-manag.md)**: View service list, performance metrics and service call relationship map
- :fontawesome-solid-globe: **[Overview](overview.md)**: View the online services, P90 response time, maximum time-consuming service and other indicators
- :material-vector-line: **[Traces](explorer.md)**: Query and analyze all trace data reported based on tools such as flame graphs, etc.
- :material-weather-lightning-rainy: **[Error Tracking](error.md)**: View the historical trend and distribution of similar errors in the traces, quickly locating errors
- :fontawesome-solid-code-compare: **[Profiling](profile.md)**: View the application operation metrics, show the call relationship and efficiency in real time.
- :material-cloud-search: **[APM Metric Detection](../monitoring/monitor/application-performance-detection.md)**: Discover abnormal link data in time by configuring application performance monitors

</div>

## Data Storage and Billing

Guance provides three data storage durations for APM data: 3 days, 7 days, and 14 days. You can adjust in **Management > Settings > Change Data Storage Strategy** according to your needs.

> For more data storage strategies, see [Data Storage Strategy](../billing/billing-method/data-storage.md).


Based on the **pay-as-you-go** billing method, APM charges statistics the number of `trace_id` under the current space, and adopts the gradient pricing model.

> For more billing rules, see [Billing Methods](../billing/billing-method/index.md).
