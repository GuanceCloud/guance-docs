# Event List
---

Enter **Events**, switch the top-left :material-format-list-bulleted: to **Event List**, and you can view all events generated under the current workspace.

![](../img/all-events.png)

In the event list, you can:

1. View the distribution of events in the current event Explorer by stacked bar charts, showing the number of events at different alert levels at different time points;
2. Perform keyword searches, tag filtering, field filtering, and related searches based on tags, fields, and text;
3. Conduct multi-dimensional analysis of events based on different analysis fields, including Monitor ID, Monitoring Type, Detection Rule Type, Host, Service, Container Name, Pod Name;
4. Check the notification status of an event, which includes the following three cases:

| Notification Status | Description |
| ------- | ----------- |
| Mute | This means that the alert event is in a muted state. |
| Silence | This means that the alert event is within a silence period. |
| Notification Target Identifier | Identifiers such as DingTalk bot, WeCom bot; this means that the alert event was sent normally to the [Notification Targets](../../monitoring/notify-object.md).

## Query and Analysis

You can manage all data under the event list through the following operations.


1. Time Widget: The event list defaults to displaying data from the last 15 minutes, but you can also customize the [time range](../../getting-started/function-details/explorer-search.md#time).

2. Search and Filter: In the event list search bar, support for [multiple search and filter methods](../../getting-started/function-details/explorer-search.md).

3. Analysis Mode: You can perform multi-dimensional analysis based on tag fields to reflect aggregated event statistics across different dimensions. Clicking on an aggregated event allows you to view [Aggregated Event Details](event-details.md).

4. Quick Filters: Through the quick filters on the left side of the list, you can edit [Quick Filters](../../getting-started/function-details/explorer-search.md#quick-filter) and add new filter fields.

5. Filter History: <<< custom_key.brand_name >>> supports saving `key:value` search condition history in the [Filter History](../../getting-started/function-details/explorer-search.md#filter-history) for different Explorers in the current workspace.

6. Event Export: In the event list, click :octicons-gear-24: to export the current event Explorer data as a CSV file or directly export it to dashboards and notes.

7. Save Snapshot: In the top-left corner of the event list, click **View Historical Snapshots** to save a snapshot of the current event data. Using the [Snapshot](../../getting-started/function-details/snapshot.md) feature, you can quickly recreate instant copies of data and restore data to a specific point in time and display logic.

8. Click the Incident icon in the bottom-right corner of the page to quickly [Create an Issue](../../exception/issue.md#manual).

9. Create Monitor: You can jump directly to the [Monitor Creation Page](../../monitoring/monitor/index.md#new) from the current Explorer to quickly set up anomaly detection rules for events.

<img src="../../img/explorer-monitor.png" width="60%" >

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Event Details</font>](event-details.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; The Power of Explorer</font>](../../getting-started/function-details/explorer-search.md)

</div>

</font>