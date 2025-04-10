# Topology Graph

To enhance the visualization effect of the dashboard, <<< custom_key.brand_name >>> modularizes based on the existing service topology and resource invocation graphs. It can be used to display relationships and relative positions between different entities.



## Chart Query

### Service Relationship Graph

<img src="../../img/resource-chart.png" width="70%" >

1. Service Name: You can select all relevant view variables or specific values;
2. Color Filling: Includes request count, P50 response time, P75 response time, P99 response time, and error rate;
3. Filtering: You can choose from `env`, `version`, `project`, `source_type` four fields.

Clicking on the service icon allows you to view upstream and downstream associations, service summaries, logs, and other information.

<img src="../../img/chart-relate.png" width="70%" >

> This also supports [Service Map cross-workspace queries](../../application-performance-monitoring/service-manag/service-map.md##servicemap).



### Resource Relationship Graph

<img src="../../img/service-chart.png" width="70%" >

1. Service Name: You can select all relevant view variables or specific values;
2. Resource Name: You can select all relevant view variables or specific values;
3. Color Filling: Includes P99 response time, request error rate, event status;
4. Filtering: You can choose from `env`, `version` two fields.

???+ warning "Note"

    The resource relationship graph only supports drawing for a single resource. Therefore, when **Resource Name** is set to a single value, the service name must also be a single value. If the service name selects a view variable that contains multiple values, the chart will return an error.

Clicking on the resource icon allows you to view logs, user visits, events, and other related information for the current resource.

<img src="../../img/chart-relate-1.png" width="70%" >


### External Data Query

By querying external data, as long as the data is reported according to the system-defined data structure, you can use any data to draw the topology graph and generate and display the final chart using local Function functions.

<img src="../../img/chart-relate-2.png" width="70%" >

> For how to process data via functions, refer to [Func Functions Detailed Usage Instructions and Examples](../../studio-backend/tracing-service-map.md).
>
> For the required data structure for connecting data, see [Relevant Interface Response Data Description](../../studio-backend/tracing-service-map.md).


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).