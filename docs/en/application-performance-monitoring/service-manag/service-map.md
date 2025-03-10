# Service Map

In this mode, you can view the invocation relationships between various services in the form of a topology graph.

## Topology Graph {#map}

1. Distinguish Environment and Version: Supports drawing link topology graphs based on two dimensions—service (`service`) and service environment version (`service+env+version`). After enabling the distinction between environments and versions, the service topology graph will be drawn according to different environment versions. For example, with canary releases, by enabling environment and version distinctions, you can view service invocation conditions under different environment versions.

2. Fill: Supports selecting different performance metrics such as request count, P50 response time, P75 response time, P99 response time, and error rate to determine the color of service nodes.

3. Custom Intervals: Customize the color interval range for the selected **fill metric**. The node colors are divided into 5 intervals based on the maximum and minimum values, each corresponding to five different colors.

4. Node Size: There are three sizes for the nodes. The service's requests per second **maximum value (Max)** and **minimum value (Min)** are divided into three intervals, which correspond to three different sizes.

**Note**: If the requests per second < 0.01, it is directly displayed as < 0.01, but the actual size of ⚪ should be based on real data. This only serves as a display (for example, if the maximum value queried is 0.009 and the minimum value is 0.0003, both less than 0.01, they will be displayed as Min < 0.01, Max < 0.01, but the actual sizes will still be calculated based on 0.009 and 0.0003).

![](../img/service-8.gif)

In the topology graph, you can perform the following operations:

<div class="grid" markdown>

=== "Query Node Metrics Data"

    Hovering over a service node highlights the corresponding service while other unrelated services and connection lines turn gray. You can view metrics data such as request count, error rate, average response time, and P99 response time for that service.

=== "Customize Color Intervals"

    Enable **custom intervals** to customize the color interval range for the selected **fill metric**. Choose different performance metrics such as request count, P50 response time, P75 response time, P99 response time, and error count to view the service node colors.

=== "View Thumbnail"

    Zoom in on the topology graph to view a small thumbnail in the lower left corner.

=== "View Upstream and Downstream"

    Click on the service icon and select **view upstream and downstream** to view the associated upstream and downstream services. Click on the **return to summary** in the top-left corner to go back to the original service topology graph. Use the search box or filters to narrow down related upstream and downstream services, displaying matches based on your search or filter results.

=== "View Service Overview"

    Click on the service icon to view detailed information about the service overview.

=== "Associated Queries"

    Click on the service icon to view related logs and traces.

</div>

![](../img/service-7.gif)

### Service Map Query {#servicemap}

**Prerequisite**: All Commercial Plan workspaces belong to the same [organization ID](../../management/attribute-claims.md), i.e., `organization` is the same.

If the same Trace data exists in分流情况, the data will belong to different workspaces. In this case, it is impossible to view complete trace data within a single workspace. Cross-workspace Service Map queries ensure continuous data querying. You can directly click the button in the current workspace to view the upstream and downstream call topology of the current service.

![](../img/servicemap.gif)

## Data Source Definitions and DQL Queries {#service-map-dql}

Please refer to [Service Map Data Source Definitions](./service-data-definitions.md#tsm-definitions)