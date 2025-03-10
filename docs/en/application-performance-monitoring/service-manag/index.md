# Service Management

???- quote "Change Log"

    **2024.5.15**: This document has been moved from the original 【Scenarios】section to 【APM】.

    **2023.11.16**: The 【Pod】page has been taken offline.

    **2023.9.7**: The service entry functions under Application Performance Monitoring have been consolidated here.

---

**Service Management** serves as a centralized management portal, providing a global view for accessing and viewing key information of all services within the current workspace. It links business attributes with trace data, allowing you to quickly locate code positions and solutions for urgent issues through associated repositories and documents.

In **APM > Service Management**, you can [add a service list](./service-list.md#create) as needed. After adding, you can view based on three dimensions: [performance metrics list](./service-manag/service-performance.md), [service list](./service-manag/service-list.md), and [service map](./service-manag/service-map.md). On the corresponding list pages, you can use global filters, quick filters, search, and time widgets to quickly locate the target service list, reducing query time. You can also save snapshots at any time to record query conditions; <<< custom_key.brand_name >>> provides various settings and operations to meet service data query requirements.

![](../img/service-2.png)

## Service Details {#details}

In each service list, clicking on a specific service will take you to its detail page. Clicking the tabs at the top of the page allows you to enter the analysis dashboard, resource calls, infrastructure dependencies, logs, traces, error tracking, and event explorer to query all relevant information under the associated service.

If you need to switch to another service's details, click the current service icon; in the opened window, you can directly input keywords to search:

<img src="../img/list.png" width="60%" >

### Analysis Dashboard

The overview page of the analysis dashboard opens by default. If you linked built-in views when [creating or editing a service](./service-list.md#create), you can switch views accordingly:

![](../img/service-5.gif)

### Resource Calls

In **Resource Calls**, <<< custom_key.brand_name >>> displays the top resources by call volume, showing the top-ranked resource information on the right side of the page by default. This includes request count, error rate, response time, response time distribution, and trace data. You can also perform global filtering based on environment and version. If resource information is empty, <<< custom_key.brand_name >>> shows related data for that service on the right side of the page.

![](../img/service-9.gif)

- The top 20 resource calls list supports querying and analyzing based on request count (default), error request count, requests per second, P75 response time, and P99 response time. You can sort by selected quantities.
- Hover over a resource and click the :fontawesome-regular-copy: button on the right to copy the full name of the current resource.
- In the detailed page on the right of the resource, you can view request count, error rate, response time, and response time distribution.
- You can query associated trace information, supporting [search](../../getting-started/function-details/explorer-search.md#search); clicking **Jump** takes you to the **Service Management > Traces** page.

#### Upstream and Downstream Topology

In the detailed page on the right of the resource, you can also view the upstream and downstream topology of the current resource.

<img src="../img/service-9.png" width="70%" >

In the upstream and downstream topology tab, you can:

- Event status legend: from left to right, the color blocks represent: data gap, information, warning, important, urgent, normal.
- On the card, you can view the average request rate, P99 response time, error request rate (requests), and associated monitors for each resource.
- Clicking the card allows you to view related logs, user visits, and events; if the resource is associated with a monitor, you can jump to the corresponding monitor to view monitor configurations and related events.

### Infrastructure Dependencies

On this page, <<< custom_key.brand_name >>> presents the associated hosts and Pod counts of the current service in a dashboard format.

![](../img/service-11.png)

Through the charts, you can quickly view the names, statuses, CPU usage, memory usage, and MEM usage of hosts and Pods, promptly addressing risk indicators.

> For more information on dashboard operations, refer to [Chart Settings](../../scene/visual-chart/index.md#settings).

### Associated Explorers

|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Click to go to other explorer tabs**</font>                         |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | 
| [Log Explorer](../../logs/explorer.md){ .md-button .md-button--primary } | [Trace Explorer](../explorer/index.md){ .md-button .md-button--primary } | 
| [Error Tracking Explorer](../../application-performance-monitoring/error.md){ .md-button .md-button--primary } | [Event Explorer](../../events/event-explorer/unrecovered-events.md){ .md-button .md-button--primary } |

<!--
**Note**: Since the Pods object data does not contain fields such as `service`, <<< custom_key.brand_name >>> uses `deployment:service name` for filtering.
-->