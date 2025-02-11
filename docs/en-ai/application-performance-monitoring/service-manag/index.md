# Service Management

???- quote "Change Log"

    **2024.5.15**: This document has been moved from 【Scenarios】to 【Application Performance Monitoring】.

    **2023.11.16**: The 【Pod】page has been taken offline.

    **2023.9.7**: The functionality of Application Performance Monitoring > Service Entry has been merged with this section.

---

**Service Management** serves as a centralized management portal, providing a global view to access and review key information for all services within the current workspace. Additionally, it links business attributes with trace data, allowing you to quickly locate code issues and solutions through associated repositories and documentation.

In **APM > Service Management**, you can [add service lists](./service-list.md#create) as needed. After adding, you can view them based on three dimensions: [performance metrics list](./service-manag/service-performance.md), [service list](./service-manag/service-list.md), and [service topology](./service-manag/service-map.md). On the corresponding list pages, you can use global filters, quick filters, search, and time controls to quickly locate the target service list, reducing query time. You can also save snapshots to record query conditions at any time. Guance provides various settings and operations to meet service data query requirements.

![](../img/service-2.png)


## Service Details {#details}

In each service list, clicking on a specific service will take you to its details page. Clicking on the tabs at the top of the page allows you to access the analysis dashboard, resource calls, infrastructure dependencies, logs, traces, error tracking, and event explorer, querying all related information for the associated service.

If you need to switch to another service's details, click the current service icon; in the opened window, you can directly input keywords to search:

<img src="../img/list.png" width="60%" >


### Analysis Dashboard

The default view is the summary page of the analysis dashboard. If you associated built-in views when [creating or editing a service](./service-list.md#create), you can switch between them:

![](../img/service-5.gif)

### Resource Calls

In **Resource Calls**, Guance displays a resource call ranking, showing by default the top-ranked resource information on the right side of the page, including request counts, error rates, response times, response time distributions, and trace data. You can apply global filters based on environment and version. If there is no resource information available, Guance displays relevant data for that service on the right side of the page.

![](../img/service-9.gif)

- The resource call ranking (TOP 20) list supports queries based on request count (default), error request count, requests per second, P75 response time, and P99 response time. You can sort the selected list items.
- Hover over a resource and click the :fontawesome-regular-copy: button on the right to copy the full name of the resource.
- In the details page on the right side of the resource, you can view request counts, error rates, response times, and response time distributions.
- You can query associated trace information, supporting [search](../../getting-started/function-details/explorer-search.md#search); clicking **Jump** will take you to the **Service Management > Traces** page.

#### Upstream and Downstream Topology

In the details page on the right side of the resource, you can also view the upstream and downstream topology of the current resource.

<img src="../img/service-9.png" width="70%" >

In the upstream and downstream topology tab, you can:

- Event status legend: From left to right, the colored blocks represent: data gaps, informational, warning, important, urgent, normal.
- On the cards, you can view the average request rate, P99 response time, error request rate (request count), and associated monitors.
- Clicking a card allows you to view related logs, user visits, and events; if the resource is associated with a monitor, you can jump to the corresponding monitor to view monitor configurations and related events.

### Infrastructure Dependencies

On this page, Guance presents the hosts and Pod counts associated with the current service in a dashboard format.

![](../img/service-11.png)

Through the charts, you can quickly view the names, statuses, CPU usage rates, memory usage rates, and MEM usage rates of hosts and Pods, enabling timely responses to risk indicators.

> For more information on dashboard operations, refer to [Chart Settings](../../scene/visual-chart/index.md#settings).

### Associated Explorers

| <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Click to go to other Explorer tabs**</font> |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | 
| [Log Explorer](../../logs/explorer.md){ .md-button .md-button--primary } | [Trace Explorer](../explorer/index.md){ .md-button .md-button--primary } | 
| [Error Tracking Explorer](../../application-performance-monitoring/error.md){ .md-button .md-button--primary } | [Event Explorer](../../events/event-explorer/unrecovered-events.md){ .md-button .md-button--primary } |

<!--
**Note**: Since the Pods object data does not contain fields such as `service`, Guance uses `deployment:service name` to filter and list them.
-->