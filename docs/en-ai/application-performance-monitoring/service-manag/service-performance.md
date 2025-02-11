# Performance Metrics

In the performance metrics page, you can quickly filter service performance based on service type, environment, version, project, and service name to rapidly pinpoint and view key metrics such as average request count, average response time, P75 response time, P99 response time, error count, and associated monitors.

In this page's list, relevant parameter data is clearly displayed, assisting in one-click identification of services with potential risks.

You can manage using the following operations:

1. Select a time range to view corresponding performance data according to the [time control](../../getting-started/function-details/explorer-search.md#time);

2. Hover over a specific service and click :octicons-search-16: to navigate to the trace details page; clicking directly on a service entry will take you to its analysis dashboard;

3. If the monitor label matches the current service, you can click to navigate to the corresponding monitor configuration page;

4. You can view event status, and by clicking the status, you can open a new page to navigate to the event Explorer page.

???- warning "Notes on Event Status"

    - The service status includes **Normal, Critical, Major, Data Gap**. It reflects the status of the last unresolved event within the past 60 days for that service; if none exist, it shows **Normal**;
    - This section only includes services that have reported **trace data**.

![](../img/service-6.gif)

## Data Source Definition and DQL Query {#service-performance-dql}

Please refer to [Service Performance Data Source Definitions](./service-data-definitions.md#tm-definitions)