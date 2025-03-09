# Event Details
---

In the [Unrecovered Events Explorer](./unrecovered-events.md) or the [All Events Explorer](./event-list.md), click any event to view its details, including basic attributes, extended fields, alert notifications, history, related events, and associated SLOs.

<!--
On the event details page, you can:

- Click **Jump to Monitor** in the top-right corner to view and adjust [monitor configurations](../../monitoring/monitor/index.md);
- Click the **Export** button in the top-right corner to export the current event's key data as a **JSON file** or a **PDF file**.
-->

## Basic Attributes {#attribute}

Displays the detection dimensions, metrics, historical trends, and event content of the viewed event.

![](../img/5.event_8.png)

:material-numeric-1-circle-outline: Detection Dimensions: You can query all detection dimensions by clicking; this will display related detection content.

| Action      | Description               |
| ----------- | ------------------------- |
| Filter Field Value | Adds this tag to the event explorer to view all event data related to the host. |
| Inverse Filter Field Value | Adds this tag to the event explorer to view all event data from other hosts except this one. |
| Copy | Copies the tag content to the clipboard. |

<img src="../../img/event-1.png" width="80%" >

**Note**: If you click on a single detection dimension, actions based on that dimension are displayed; if you click on a blank area, it triggers all detection dimensions.

:material-numeric-2-circle-outline: Event Content: The event content description defined on the monitor configuration page as described in [Event Content](../../monitoring/monitor/mutation-detection.md#event-content).

:material-numeric-3-circle-outline: Detection Metrics: The query statement for the metrics configured in the monitor.

:material-numeric-4-circle-outline: Historical Trends: The historical trend of the detection results for the current unrecovered event. Click **Get Chart Query** to obtain the current query statement.

<img src="../../img/event-query.png" width="80%" >

## Extended Fields {#event-extension}

You can manage the attribute fields included in this event data through the following operations:

![](../img/event-extension-1.gif)

1. In the search bar, enter the field name or value to quickly locate;

2. After selecting the field alias, it will appear after the field name; choose as needed.

3. On the event details page, you can view the relevant field attributes of the current event under **Extended Fields**:

| <div style="width: 110px">Field</div>      | Property                          |
| ----------- | ------------------------------------ |
| Filter Field Value | Adds this field to the explorer search bar to view all data related to this field, which can be filtered in the [Trace Explorer](../../application-performance-monitoring/explorer/explorer-analysis.md) to view the list of related traces. |
| Inverse Filter Field Value | Adds this field to the explorer search bar to view all data except those related to this field. |
| Copy | Copies the field to the clipboard. |

![](../img/event-extension.png)

## Alert Notifications {#alarm}

Displays information such as notification target type, notification target name, and whether the notification was successfully sent. Click to expand and view detailed information about the alert notification object, with support for hover-to-copy.

![](../img/5.event_10.png)

- If the alert is muted, it will display "Muted";
- If the alert is normally sent, it will display the corresponding notification target icon, hovering over which shows the specific notification target name.

**Note**: During the mute period, alert notifications will not be resent to the related targets.


<!--

### Status & Trend

Displays the status distribution trend, DQL functions, and window function line charts of the event.

- Status Distribution: Shows the event status (critical, major, warning, data gap) within the selected time range (default is the last 6 hours);
- DQL Query Statement: Custom query statements based on anomaly detection rules returning real-time metric data, default showing the last 6 hours of real-time metric data;
- Window Function: Based on anomaly detection rules, using the selected time range as the window (record set) and detection frequency as the offset, re-executes statistical calculations for each record, returning real-time anomaly detection metric data used to trigger alerts. Defaults to displaying the last 6 hours of real-time anomaly detection metric data.

![](img/image.png)

???+ warning "<<< custom_key.brand_name >>> supports selecting a time range to view event data"

    - When the selected time range is less than or equal to 6 hours, **Status Distribution**, **DQL Functions**, and **Window Functions** will display data and metric trends within the current time range;
    - When the selected time range is greater than 6 hours, **Status Distribution** and **DQL Functions** will display data within the current time range, and a resizable slider (minimum support 15 minutes, maximum support 6 hours) will appear. By moving the slider, you can view the **Window Function** corresponding to the selected time range.

-->

## History {#history}

Displays the detected host, abnormal/recovery times, and duration.

![](../img/5.event_11.png)

Clicking on a data entry opens the corresponding explorer and automatically queries and filters based on its `df_fault_id`.

![](../img/3.event_13.1.png)

<!--
### Related Information {#relevance}

Displays information related to triggering the current event, such as viewing logs that triggered the event. This **Related Information** only supports events generated by four types of monitors: **log detection, security check anomaly detection, process anomaly detection, and synthetic testing anomaly detection**.

**Note**: If log detection includes multiple expression queries, the related information supports tab switching for multiple expression queries. For example, if there are two expression queries A and B, the related information contains two tabs A and B for switching views.

![](../img/3.event_13.png)

-->

## Related Events {#relevance}

Supports viewing related events within a certain time frame based on four filtering fields.

| Filtering Field      | Description           |
| :------- | :----------- |
| Same Fault ID      | `df_fault_id`; a special ID marking the entire process from when an anomaly event is triggered until it returns to normal.           |
| Same Monitor      | `df_monitor_checker_id`           |
| Same Detection Dimension      | `df_dimension_tags`           |
| Same Level      | `df_status`           |

![](../img/5.event_12.gif)

## Related SLO {#relevance}

If SLO is configured in the monitor, you can view the associated SLO, including SLO name, monitor, achievement rate, error budget, and target information.

![](../img/5.event_14.png)

## Related Dashboards {#relevance}

If dashboards are configured in the monitor, you can view the associated dashboards.

![](../img/5.event_13.png)

## Related Queries {#related-query}

In the related queries section, you can view all queries associated with the current event.

![](../img/5.event_9.png)

## Bind Built-in Views {#inner_view}

<<< custom_key.brand_name >>> supports binding or deleting built-in views (user views) to the event details page. Clicking "Bind Built-in View" adds a new view to the current event details page.

<img src="../../img/event-view.png" width="70%" >