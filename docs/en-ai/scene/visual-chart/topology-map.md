# Topology Graph

To enhance the visualization effect of dashboards, Guance modularizes components based on existing service maps and resource call graphs. This can be used to display relationships and relative positions between different entities.

## Chart Queries

### Service Relationship Graph

![Service Relationship Graph](../../img/resource-chart.png)

1. Service Name: Choose from all related view variables or specific values;
2. Color Fill: Includes request count, P50 response time, P75 response time, P99 response time, and error rate;
3. Filters: Selectable fields include `env`, `version`, `project`, and `source_type`.

Clicking on a service icon allows you to view upstream and downstream associations, service summaries, logs, and other information.

![Service Relation View](../../img/chart-relate.png)

> Cross-workspace queries for [Service Map](../../application-performance-monitoring/service-manag/service-map.md##servicemap) are also supported here.

### Resource Relationship Graph

![Resource Relationship Graph](../../img/service-chart.png)

1. Service Name: Choose from all related view variables or specific values;
2. Resource Name: Choose from all related view variables or specific values;
3. Color Fill: Includes P99 response time, request error rate, and event status;
4. Filters: Selectable fields include `env` and `version`.

**Note**: The resource relationship graph only supports drawing for a single resource. Therefore, when **Resource Name** is set to a single value, the service name must also be a single value. If the service name selects a view variable that contains multiple values, the chart will report an error.

Clicking on a resource icon allows you to view logs, user visits, events, and other information related to the current resource.

![Resource Relation View](../../img/chart-relate-1.png)

### External Data Query

By using external data queries, you only need to report data according to the system-specified data structure. You can then use any data to draw topology graphs and generate and display final charts through local Function functions.

![External Data Query](../../img/chart-relate-2.png)

> For details on how to process data via functions, refer to the [Func function detailed usage instructions and examples](../../studio-backend/tracing-service-map.md).
>
> For the required data structure for topology graphs, see the [relevant interface response data description](../../studio-backend/tracing-service-map.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

<!--

## Chart Links {#link}

Links help achieve navigation from the current chart to the target page. You can add internal platform links or external links. Template variables can modify corresponding variable values in the link to pass data information, enabling data linkage.

> For more related settings, refer to [Chart Links](chart-link.md).

### Title

1. Title: Set a title name for the chart. Once set, it appears in the top-left corner of the chart, with an option to hide it.
2. Description: Add descriptive information to the chart. After setting, an [i] hint appears after the chart title. If not set, it does not appear.

### Colors

1. Gradient Range

- Automatic:

    - Choose a level count ranging from 2 to 100; the default is 60.
    - Includes 4 types of gradient color schemes.
    - Supports custom maximum and minimum values. If not set, it automatically calculates the max and min values from the returned data.

- Custom: Choose a level count ranging from 2 to 5; the default is 5.

### [Legend](./timeseries-chart.md#legend)

1. Add aliases, and the legend names will change accordingly.
2. Choose the legend position, including options to hide it or place it at the bottom of the chart.

### Time

Lock Time: Fix the time range for querying data in the current chart, independent of the dashboard or other global time components. After successful setup, the current chart directly displays the time you have set, such as [xx minutes], [xx hours], [xx days].

-->