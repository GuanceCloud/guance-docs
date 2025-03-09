# Performance Metrics

On the performance metrics page, you can quickly filter service performance based on service type, environment, version, project, and service name to quickly locate and view the average request count, average response time, P75 response time, P99 response time, error count, and associated monitors for the service.

In this page's list, relevant parameter data is clear at a glance, helping to identify services with potential risks with one click.

You can manage using the following operations:

1. Based on the [Time Widget](../../getting-started/function-details/explorer-search.md#time), select a time range to view corresponding performance data;

2. Hover over a specific service, click :octicons-search-16: to navigate to the trace details page; directly clicking a service will take you directly to the analysis dashboard for that service;

3. If the monitor label belongs to the current service, click to navigate to the corresponding monitor configuration page;

4. You can view event status, clicking on the status will open a new tab and redirect to the event Explorer page.

???- warning "Notes on Event Status"

    - The service status includes **Normal, Critical, Major, Data Gap**. It takes the status of the last unresolved event within 60 days for that service, if none exist it shows **Normal**;
    - This only includes services with **trace data reporting**.

![](../img/service-6.gif)

## Data Source Definition and DQL Query {#service-performance-dql}

Please refer to [Service Performance Data Source Definition](./service-data-definitions.md#tm-definitions)