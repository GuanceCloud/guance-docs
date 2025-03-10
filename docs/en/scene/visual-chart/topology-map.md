# Topology Diagram

To enhance the visualization effect of dashboards, <<< custom_key.brand_name >>> modularizes based on existing service topology and resource invocation diagrams. This can be used to display relationships and relative positions between different entities.


## Chart Query

### Service Relationship Diagram

<img src="../../img/resource-chart.png" width="70%" >

1. Service Name: You can choose all relevant view variables or specific values;
2. Color Fill: Includes request count, P50 response time, P75 response time, P99 response time, and error rate;
3. Filtering: Options include `env`, `version`, `project`, `source_type`.

Clicking on a service icon allows you to view upstream and downstream associations, service summary, logs, and other information.

<img src="../../img/chart-relate.png" width="70%" >

> Cross-workspace queries for [Service Map](../../application-performance-monitoring/service-manag/service-map.md##servicemap) are also supported here.


### Resource Relationship Diagram

<img src="../../img/service-chart.png" width="70%" >

1. Service Name: You can choose all relevant view variables or specific values;
2. Resource Name: You can choose all relevant view variables or specific values;
3. Color Fill: Includes P99 response time, request error rate, event status;
4. Filtering: Options include `env`, `version`.

**Note**: The resource relationship diagram only supports drawing for a single resource. Therefore, when **Resource Name** is set to a single value, the service name must also be a single value. If the service name is set to a view variable that contains multiple values, the chart will result in an error.

Clicking on a resource icon allows you to view logs, user access, events, and other information related to the current resource.

<img src="../../img/chart-relate-1.png" width="70%" >


### External Data Query

By querying external data, you only need to report data according to the system-specified data structure. You can then use any data to draw topology diagrams and generate and display final charts using local Function functions.

<img src="../../img/chart-relate-2.png" width="70%" >

> For more details on how to process data via functions, refer to the [Func function detailed usage instructions and examples](../../studio-backend/tracing-service-map.md).
>
> For the required data structure for topology diagrams, see the [relevant interface response data description](../../studio-backend/tracing-service-map.md).


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

<!--


## Chart Links {#link}

Links help achieve navigation from the current chart to the target page. You can add internal links within the platform or external links, and modify the corresponding variable values in the link to pass data information, enabling data interactivity.

> For more settings, refer to [Chart Links](chart-link.md).

### Title

1. Title: Set a title for the chart, which will be displayed in the top-left corner of the chart and can be hidden.
2. Description: Add a description to the chart. After setting it, an [i] hint will appear after the chart title. If not set, it will not be displayed.

### Colors

1. Gradient Range

- Automatic:

    - Choose a number of levels from 2 to 100, defaulting to 60;
    - Includes 4 gradient color schemes;
    - Supports custom maximum and minimum values; if not set, the system automatically calculates them based on the returned data's max and min values.

- Custom: Choose a number of levels from 2 to 5, defaulting to 5.


### [Legend](./timeseries-chart.md#legend)

1. Add aliases, and the legend names will change accordingly;
2. Choose the legend position, including hiding it or placing it at the bottom of the chart.

### Time

Lock Time: Fix the time range for querying data in the current chart, independent of the dashboard or other global time components. After setting it successfully, the current chart directly displays the specified time, such as 【xx minutes】, 【xx hours】, 【xx days】.

-->