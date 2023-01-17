# Service Map
---

## Introduction

In the "Application Performance Monitoring" "Services" list, support click ![](img/1.apm_9.png) to switch the list to "Map" mode to see the invocation relationships between services.

### Map Description

- Distinguish environment and version: it supports to draw link map based on service and service+env+version. After "Distinguish environment and version", service map will be drawn according to different environment versions. For example, Canary Publishing can view service calls under different environment versions by opening environment and version.

- Filling: it supports to select different performance metrics "Request Number", "P50 Response Time", "P75 Response Time", "P99 Response Time" and "Error Number" to view the service node color.

- Custom Interval: Customize the service node color interval range for the selected "Fill Metrics". The color of the node is divided into five intervals according to the maximum value and the minimum value, and each interval will automatically correspond to five different colors.

- Node Size: There are three sizes of node size, and the "Max" and "Min" of the number of requests per second of service are divided into three equal parts, and the obtained three intervals correspond to three graphic sizes.

  **Note: If the number of requests per second is <0.01, it will be displayed as <0.01 directly, but the actual size of ⚪ should be based on the real data, which is only displayed here (for example, the maximum value and the minimum value are 0.009 and 0.0003, which are all less than 0.01, then it will be displayed as Min <0.01 and Max <0.01, but the real size is still calculated by 0.009 and 0.0003).**

![](img/1.apm_8.png)



### Operating Instructions

=== "Node Metric Data Query"

    When you hover the mouse over the service node, the corresponding service is highlighted, and other unrelated services and connecting lines are grayed out. You can view the metric data such as "Number of Requests", "Error Rate", "Average Response Time" and "P99 Response Time" for this service.

=== "Custom Color Interval"

    Open "Custom Interval" to customize the service node color interval range for the selected "Fill Metric". Select different performance metrics "Request Number", "P50 Response Time", "P75 Response Time", "P99 Response Time" and "Error Number" through "Fill" to view the service node color.

=== "View Thumbnails"

    Enlarge the map to view small thumbnails in the lower left corner.

=== "View upstream and downstream"

    In the service map, click the service icon and click "View Upstream and Downstream" to view the upstream and downstream service association of the current service; Click "Return Overview" in the upper left corner to return to the original service map, search or filter the associated upstream and downstream services in the search box, and display the matching associated upstream and downstream services according to the search or screening results.

=== "Associate Query"

    In the service map, click the service icon to view "Association Log" and "Association Link".

![](img/1.apm_10.gif)

