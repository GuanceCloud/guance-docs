# Topology Chart

In order to enhance the visualization of the dashboard, Guance is componentized according to the existing service topology and resource call graph.



## Chart Query

### Service Map

![](../img/resource-chart.png)

1. Service: You can select all relevant view variables or specific values;
2. Color: Includes the number of requests, P50 response time, P75 response time, P99 response time, and error rate;
3. Filter: You can choose `env`, `version`, `project`, `source_type` four fields.

Click on the service icon to view the up and down stream associations of the current service, service overview, logs, and other information.

<img src="../../img/chart-relate.png" width="70%" >

> This place also supports [Service Map cross workspace query](../service-manag.md#servicemap).

### Resource Map

![](../img/service-chart.png)

1. Service: You can select all relevant view variables or specific values;
2. Resource: You can select all relevant view variables or specific values;
3. Color: Includes P99 response time, request error rate, event status;
4. Filter: You can select `env`, `version` two fields.

**Note**: The resource relationship diagram only supports drawing for a single resource. Therefore, when the **resource name** selects a single value, the service name should also be a single value. If the service name selects a view variable that contains multiple values, the chart will report an error at this time.

Click on the resource icon to view the logs, user access, events and other information related to the current resource.

<img src="../../img/chart-relate-1.png" width="70%" >

## Basic Settings

| Option | Description |
| --- | --- |
| Title | Set a title for the chart. After setting, it will be displayed in the upper left corner of the chart. It supports hiding.|
| Description | Add a description to the chart, after setting, an "i" prompt will appear behind the chart title, if not set, it will not display. |
| Color | Color system: includes three gradient color systems; <br /> Maximum & Minimum: Customize the upper and lower limits of the number of requests. |
| Legend | See [Legend Explanation](./timeseries-chart.md#legend). |
| Lock Time | That is, fix the time range of the current chart query data, not subject to the restriction of the global time component. After the setting is successful, the user-set time will appear in the upper right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】. |