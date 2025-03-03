---
icon: zy/metrics
---
# Metrics

Guance is capable of collecting global data, and the metric data obtained by collectors would be automatically reported to the workbench. You can analyze and manage the metric data in your workspace uniformly through **Metrics**.

## Use Case

It is critical to ensure that systems are observable, maintainable and operational for teams to ensure business continuity and service delivery. Therefore, it is particularly important to use a large number of metrics to measure the running status and service efficiency of systems, applications and businesses. 

The metric function of Guance can help you:

- Realize metric observation requirements of various technology stacks, open source software and business
- Visualise metric change trend
- Manage measurements, metrics and tags in a unified way

## Features

- **[Metric Analysis](explorer.md)**: enabling you to visually query metric data in the form of timeseries based on **Simple Query**, **Expression Query**, **DQL Query** and **PromQL Query**.
- **[Metric Management](dictionary.md)**: supporting unified viewing of all measurements, metrics, tags, timelines and other saving strategies.

## Steps

- Step 1: Before using **Metrics**, you need to start the relevant integrated [metric collection](collection.md) through DataKit, and the successfully collected metric data would be automatically reported to the studio.
- Step 2: All metric data reported to the workspace by DataKit collector can be viewed through **Metric Management**, including measurement, metrics (metric name, field type, unit and description), tag, etc.
- Step 3: All metric data in the workspace can be queried and analyzed visually in **Metrics** and **[Dashboards](../scene/dashboard.md)** of the studio.

## More Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Use Four Methods to Query the Collected Data**</font>](../scene/visual-chart/chart-query.md)

</div>


