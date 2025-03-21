# Intelligent Monitoring
---

In the **Incident > Intelligent Monitoring** Explorer, you can view the complete list of events generated by intelligent monitoring within the current workspace.

In the Intelligent Monitoring Event Explorer, you can:

- View the number of events occurring at different time points under different rules through stacked bar charts;
- Perform keyword searches, tag filtering, field filtering, and associated searches based on tags, fields, and text;
- Conduct aggregated event analysis based on selected fields for grouping.

## Query and Analysis

In the Intelligent Monitoring Event Explorer, you can query event data through selecting time ranges, search keywords, and filtering methods. This helps you quickly locate specific events triggered by certain time ranges, features, or actions.

![](img/inte-monitoring-event01.png)

- Time Widget: By default, all Event Explorers display data from the past 15 minutes, but you can also customize the [time range](../getting-started/function-details/explorer-search.md#time).

- [Search and Filtering](../getting-started/function-details/explorer-search.md)

- In the analysis section of the Intelligent Monitoring Event Explorer, multi-dimensional analysis based on tag fields is supported to reflect aggregated event statistics across different dimensions. Clicking on an aggregated event allows you to view [Aggregated Event Details](./event-explorer/event-details.md).

- You can edit the [Quick Filters](../getting-started/function-details/explorer-search.md#quick-filter) on the left or add new filter fields.

- Filter History: <<< custom_key.brand_name >>> supports saving the `key:value` search conditions in the [Filter History](../getting-started/function-details/explorer-search.md#filter-history) for different Explorers within the current workspace.

- Event Export: In the Intelligent Monitoring Event Explorer, click **Export** to export the data from the current Event Explorer to CSV, dashboards, and notes.

- Save Snapshot: In the top-left corner of the Intelligent Monitoring Event Explorer, click **View Historical Snapshots** to directly save a snapshot of the current event data. Through the [Snapshot](../getting-started/function-details/snapshot.md) feature, you can quickly reproduce the copied data and restore it to a specific point in time and data presentation logic.

## Event Details Page

In the Intelligent Monitoring Event Explorer, clicking any event will slide open the side panel to view event details, including analysis reports, alert notifications, historical records, and related events. On the event details page, you can navigate to the associated monitors and export key event information to PDF or JSON files.

> For more details, refer to [Intelligent Monitoring](../monitoring/intelligent-monitoring/index.md).