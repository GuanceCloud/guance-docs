# Event List
---

Enter **Incident**, switch the top-left corner :material-format-list-bulleted: to **Event List**, and you can view all events generated under the current workspace.

![](../img/all-events.png)

In the event list, you can:

1. View the distribution chart within the current event Explorer using a stacked bar chart to see the number of events at different time points with different alert levels;
2. Perform keyword search, label filtering, field filtering, and associated searches based on tags, fields, and text for events;
3. Conduct aggregated event analysis based on different analytical fields, including Monitor ID, Monitoring Type, Detection Rule Type, Host, Service, Container Name, Pod Name;
4. Check the notification status of an event, which includes the following three scenarios:

| Notification Status | Description |
| ------- | ----------- |
| Mute | This means the alert event is in a muted state. |
| Silence | This means the alert event is within a silent period. |
| Notification Target Identifier | Such as DingTalk bot, Enterprise WeChat bot identifiers; this means the alert event has been sent normally to [Notification Targets](../../monitoring/notify-object.md).

## Query and Analysis

You can manage all data under the event list through the following operations.

![](../img/5.event_7.gif)

1. Time Control: The event list defaults to displaying data from the last 15 minutes, but you can also customize the [time range](../../getting-started/function-details/explorer-search.md#time) for data display.
2. Search and Filter: In the event list search bar, support for [various search methods and filter methods](../../getting-started/function-details/explorer-search.md).
3. Analysis Mode: Multi-dimensional analysis can be performed based on tag fields to reflect aggregated event statistics across different dimensions. Clicking on aggregated events allows you to view [Aggregated Event Details](event-details.md).
4. Quick Filters: Through quick filters on the left side of the list, you can edit [quick filters](../../getting-started/function-details/explorer-search.md#quick-filter) and add new filter fields.
5. Filter History: Guance supports saving `key:value` search condition history for different Explorers in the [filter history](../../getting-started/function-details/explorer-search.md#filter-history) for use in different Explorers within the current workspace.
6. Event Export: In the event list, click :octicons-gear-24: to export the current event Explorer data as a CSV file or directly export it to dashboards and notes.
7. Save Snapshot: At the top-left corner of the event list, click **View Historical Snapshots** to save a snapshot of the current event data. Using the [Snapshot](../../getting-started/function-details/snapshot.md) feature, you can quickly reproduce instant copies of data and restore data to a specific point in time and data display logic.
8. Click the Incident icon at the bottom-right corner of the current page to quickly [Create an Issue](../../exception/issue.md#manual).
9. Create a Monitor: You can jump directly to the [Monitor Creation Page](../../monitoring/monitor/index.md#new) from the current Explorer to quickly set up anomaly detection rules for events.

<img src="../../img/explorer-monitor.png" width="60%" >

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Event Details</font>](event-details.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; The Power of Explorer</font>](../../getting-started/function-details/explorer-search.md)

</div>