# Unrecovered Events
---

![](../img/unrecovered_events_list.png)

Enter **Events** and Guance will show you the **Unrecovered Event Explorer** by default. You can view all unresolved events that are continuously triggered in the workspace, as well as data statistics for unresolved events under different alert levels and details of alert information.

Here, you can:

- Count the number of events under different alert statuses by clicking on the alert status for quick filtering, including **Unrecovered (`df_status != ok`)**, **Critical**, **Error**, **Warning**, **No Data**.
- Search events based on tags, fields and text, and filter events based on keywords, tags, fields, and associations.
- View the current alert event information, including the detection dimension of the event, the start time of the alert, the duration of the alert, and the event occurrence trend in the past 6 hours.


## Data Status

In the Unrecovered Event Explorer, based on the trigger condition configuration of the monitor, statistics of Unrecovered (`df_status != ok`), Critical, Error, Warning, and No Data statuses are generated. You can also refer to [Threshold Detection](../../monitoring/monitor/threshold-detection.md) to configure a monitor and set trigger conditions for the monitor.

> See [Event Severity Description](../../monitoring/monitor/event-level-description.md).

## Event Information

In the Unrecovered Event Explorer, you can view the current alert event information, including the severity of the event, the duration of the event (generation time), the alert notification, detection type, detection dimension, event content, event content detection query statement, and expand to view the abnormal trend of the event occurrence in the past 6 hours.

### Event Abnormal Trend {#exception}

This trend is displayed using the Window function:

- The historical trend of the detection result value shows the actual data of 60 detections;
- The current event trigger time can be quickly identified by the **vertical line** in the chart, and the actual data is displayed above it;
- The baseline is displayed based on the threshold configured for the monitor;
- When the detection library rule type is threshold, log, APM, RUM, security check, abnormal process, or cloud dial, the color blocks corresponding to different alert levels can be used to view related abnormal detection indicator data, including critical, error, and warning.


## Detection Dimension

In the Unrecovered Event Explorer, you can click on the event detection dimension to jump to the relevant viewer based on the triggered detection dimension. If there is no relevant detection query data, you cannot jump.

**Note**: If you click on a single detection dimension, the relevant operation will be based on that dimension; if you click on a blank area, all detection dimensions will be triggered.

| Operation      | Description               |
| ----------- | ------------------------- |
| Filter      | Add the tag to the event viewer to view all event data related to that host.               |
| Reverse filter      | Add the tag to the event viewer to view all event data related to hosts other than that host.               |
| Copy      | Copy the tag content to the clipboard.               |

![](../img/event003.png)

## Query and Analysis


- Time Widget: The Unrecovered Event Explorer defaults to query the data of the past 48 hours. You can also customize the [time range](../../getting-started/function-details/explorer-search.md#time) for data display.

- Search and Filter: The search bar supports [multiple search and filter methods](../../getting-started/function-details/explorer-search.md).

- Quick Filter: You can edit [quick filters](../../getting-started/function-details/explorer-search.md#quick-filter) through the quick filters on the left side of the list to add new filtering fields.

    - **Note**: Custom adding of filter fields is not supported in the Unrecovered Event Explorer.

- Save Snapshot: In the top-left corner of the event viewer, click View Historical Snapshot to directly save the snapshot data of the current event. With [Snapshot](../../getting-started/function-details/snapshot.md), you can quickly reproduce the data copy information saved at a specific time point and with specific data display logic.

- Filter History: Guance supports saving the search condition history of the explorer `key:value` in the [filter history](../../getting-started/function-details/explorer-search.md#filter-history), which can be applied to different explorers in the current workspace.

- Export: Guance supports exporting unresolved events as CSV files.

### Display Preferences

You can choose the display style of the unresolved event list, which supports two options: Standard and Expanded.

:material-numeric-1-circle-outline: When selecting Standard: you can see the event title, detection dimension and event content of the current event;

![](../img/event-1-1.png)

:material-numeric-2-circle-outline: When selecting Expanded: you can also open the [historical trend](#exception) of the detection result values for all unresolved events.

![](../img/event.png)


### Create Issue {#issue}

You can [create an Issue](../../exception/issue.md#event) for the current unresolved event and notify relevant members to track and process it.
 
![](../img/event-2.png)

![](../img/event-3.png)

If the current event is associated with a specific exception trace, you can click the icon in the event list to directly jump to view it:

![](../img/event-6.png)

### Recover Event {#recover}

In the case of events with a status of "ok" (`df_sub_status = ok`), you can configure event recovery rules in the [monitor](../../monitoring/monitor/index.md) to trigger conditions or manually recover the event.

Recovering events includes four use cases: recovery, no data recovery, no data treated as recovery, and manual recovery, as shown in the following table:

| Type       | `df_status` | Description                                                    |
| :------------- | :-------- | :----------------------------------------------------------- |
| recovery           | ok        | If "Critical", "Error" and "Warning" events were triggered during the previous detection process, based on the N detections configured on the frontend, if no "critical", "error", or "warning" events are generated within the detection times, it is considered as recovery and a normal recovery event is generated. |
| no data recovery     | ok        | If the data stopped reporting during the previous detection process and new data is reported again, it is considered as recovery and a no data recovery event is generated. |
| no data treated as recovery | ok        | If no data is found in the detection data, it is considered as a normal state and a recovery event is generated. |
| manual recovery       | ok        | An OK event generated by manually clicking the recovery button.                             |

In the Unrecovered Event Explorer, you can hover over an event and view the grayed-out recovery button on the right side of the event.

![](../img/5.event_4.png)


## More Readings

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Event Details</font>](event-details.md)

</div>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Powerful Explorer</font>](../../getting-started/function-details/explorer-search.md)

</div>