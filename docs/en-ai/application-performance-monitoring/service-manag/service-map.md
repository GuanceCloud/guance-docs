# Service Map

In this mode, you can view the calling relationships between various services in the form of a topology diagram.

## Topology Diagram {#map}

1. **Distinguish Environment and Version**: Supports drawing link topology diagrams based on two dimensions: service (`service`) and service environment version (`service+env+version`). After enabling the distinction between environments and versions, the service topology diagram will be drawn according to different environment versions. For example, in Canary releases, by enabling the environment and version distinction, you can view the service call conditions under different environment versions.

2. **Filling**: Supports selecting different performance metrics such as request count, P50 response time, P75 response time, P99 response time, and error rate to determine the color of service nodes.

3. **Custom Range**: Customize the color range for the selected **filling metric**. The node colors are divided into 5 intervals based on the maximum and minimum values, with each interval automatically corresponding to five different colors.

4. **Node Size**: There are three sizes for the nodes, which are divided into three intervals based on the **maximum (Max)** and **minimum (Min)** request counts per second. These three intervals correspond to three different graphical sizes.

**Note**: If the requests per second < 0.01, it will be displayed as < 0.01, but the actual size of ⚪ is determined by the real data (for example, if the queried maximum value is 0.009 and the minimum value is 0.0003, both less than 0.01, they will be displayed as Min < 0.01, Max < 0.01, but the actual sizes are calculated based on 0.009 and 0.0003).

![](../img/service-8.gif)

In the topology diagram, you can perform the following actions:

<div class="grid" markdown>

=== "Query Node Metrics Data"

    Hovering over a service node highlights the corresponding service while other unrelated services and connection lines turn gray. You can view metrics data such as request count, error rate, average response time, and P99 response time for that service.

=== "Custom Color Intervals"

    Enable **custom intervals** to customize the color range for the selected **filling metric**. Select different performance metrics such as request count, P50 response time, P75 response time, P99 response time, and error count to view the service node colors.

=== "View Thumbnail"

    Zoom in on the topology diagram to view a small thumbnail in the lower left corner.

=== "View Upstream and Downstream"

    Click on the service icon and select **View Upstream and Downstream** to view the upstream and downstream services associated with the current service. Click **Return to Summary** in the upper left corner to return to the original service topology diagram. Use the search box to filter and display the associated upstream and downstream services based on your search or filtering results.

=== "View Service Overview"

    Click on the service icon to view detailed service overview information.

=== "Associated Queries"

    Click on the service icon to view related logs and traces.

</div>

![](../img/service-7.gif)

### Service Map Query {#servicemap}

**Prerequisite**: All Commercial Plan workspaces belong to the same [organization ID](../../management/attribute-claims.md), i.e., `organization` is the same.

If the same Trace data is split across different workspaces, the data will belong to different workspaces, making it impossible to view complete trace data within a single workspace. Cross-workspace Service Map queries ensure data query continuity, allowing you to view the upstream and downstream call topology of the current service directly from the current workspace by clicking a button.

![](../img/servicemap.gif)

## Data Source Definitions and DQL Queries {#service-map-dql}

Refer to [Service Map Data Source Definitions](./service-data-definitions.md#tsm-definitions)