# Event Details
---

In the [Unrecovered Events Explorer](./unrecovered-events.md) or the [All Events Explorer](./event-list.md), click on any event to view detailed information about the event, including basic attributes, extended fields, alert notifications, history, related events, and associated SLOs.

<!--
On the event details page, you can:

- Click **Jump to Monitor** in the top-right corner to view and adjust the [monitor configuration](../../monitoring/monitor/index.md);
- Click the **Export** button in the top-right corner to export the current event's key data as a **JSON file** or a **PDF file**.
-->

## Basic Attributes {#attribute}

Displays the detection dimensions, metrics, historical trends, and event content of the viewed event.

![](../img/5.event_8.png)

:material-numeric-1-circle-outline: Detection Dimensions: You can query all associated detection dimensions; clicking will display relevant detection content.

| Action               | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| Filter Field Value    | Adds this tag to the event explorer to view all event data related to this host. |
| Inverse Filter        | Adds this tag to the event explorer to view all event data from other hosts except this one. |
| Copy                 | Copies the tag content to the clipboard. |

<img src="../../img/event-1.png" width="80%" >

**Note**: If you click on a single detection dimension, it displays related operations based on that dimension; if you click on an empty area, it triggers all detection dimensions.

:material-numeric-2-circle-outline: Event Content: Defined in the [Event Content Description](../../monitoring/monitor/mutation-detection.md#event-content) on the monitor configuration page.

:material-numeric-3-circle-outline: Detection Metrics: The query statement configured for the monitor.

:material-numeric-4-circle-outline: Historical Trends: The historical trend of detection results for the current unrecovered event. Click **Get Chart Query** to obtain the current query statement.

<img src="../../img/event-query.png" width="80%" >

## Extended Fields {#event-extension}

You can manage the attribute fields included in this event data using the following operations:

![](../img/event-extension-1.gif)

1. In the search bar, you can quickly search and locate by entering the field name or value;
2. After checking the field alias, it will be displayed after the field name; you can choose as needed.
3. On the event details page, you can view the relevant field attributes of the current event under **Extended Fields**:

| <div style="width: 110px">Field</div>      | Attribute                          |
| ----------- | ------------------------------------ |
| Filter Field Value      | Adds this field to the explorer search bar to view all data related to this field, which can be filtered in the [Trace Explorer](../../application-performance-monitoring/explorer/explorer-analysis.md) to view the trace list related to this field.                         |
| Inverse Filter Field Value      | Adds this field to the explorer search bar to view all data except for this field.                          |
| Copy      | Copies this field to the clipboard.                          |

![](../img/event-extension.png)

## Alert Notifications {#alarm}

Displays notification object type, notification object name, whether the notification was sent successfully, etc. Click to expand and view detailed information about the alert notification object, with support for hover-to-copy.

![](../img/5.event_10.png)

- If the alert is muted, it will display "Mute";
- If the alert is sent normally, it will display the corresponding notification object marker; hovering over the icon will show the specific notification object name.

**Note**: During the mute period, alert notifications will not be resent to related objects.


<!--

### Status & Trends

Displays the status distribution trend, DQL functions, and window function line charts of the event.

- Status Distribution: Shows the event status (urgent, important, warning, data interruption) within the selected time range (default is the last 6 hours);
- DQL Query Statement: Custom query statement based on anomaly detection rules, returning real-time metric data (default is the last 6 hours);
- Window Function: Based on anomaly detection rules, recalculates each record within the selected time range (record set) with the detection frequency as the offset, returning real-time anomaly detection metric data used to trigger alerts (default is the last 6 hours).

![](img/image.png)

???+ warning "In event details, Guance supports selecting a time range to view event data"

    - When the selected time range is less than or equal to 6 hours, **Status Distribution**, **DQL Functions**, and **Window Functions** will display data and trend indicators within the current time range;
    - When the selected time range is greater than 6 hours, **Status Distribution** and **DQL Functions** will display data within the current time range, and a resizable slider will appear (minimum support 15 minutes, maximum support 6 hours). By moving the slider, you can view the **Window Function** data corresponding to the selected time range.

-->

## History {#history}

Displays the detected host, anomaly/recovery times, and duration.

![](../img/5.event_11.png)

Clicking on a piece of data opens the corresponding explorer, automatically querying and filtering with its `df_fault_id`.

![](../img/3.event_13.1.png)

<!--
### Related Information {#relevance}

Displays information that triggered the current event, such as viewing logs related to the triggering event. This **Related Information** only supports events generated by four types of monitors: **log detection, security check anomaly detection, process anomaly detection, and synthetic testing anomaly detection**.

**Note**: If log detection includes multiple expression queries, the related information supports tab switching between multiple expression queries. If there are two expression queries A and B, then tabs A and B can be switched in the related information for viewing.

![](../img/3.event_13.png)

-->

## Related Events {#relevance}

Supports viewing related events within a certain time frame based on four filter fields.

| Filter Field          | Description                                                                                                                                                   |
| :-------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Same Fault ID         | `df_fault_id`; a special ID marking the entire process from triggering an anomaly event to triggering a recovery event in a certain detection dimension.     |
| Same Monitor          | `df_monitor_checker_id`                                                                                                                                       |
| Same Detection Dimension | `df_dimension_tags`                                                                                                                                          |
| Same Level            | `df_status`                                                                                                                                                    |

![](../img/5.event_12.gif)

## Related SLO {#relevance}

If SLO is configured in the monitor, you can view related SLO information, including the SLO name, monitor, compliance rate, error budget, target, etc.

![](../img/5.event_14.png)

## Related Dashboards {#relevance}

If dashboards are configured in the monitor, you can view related dashboards.

![](../img/5.event_13.png)

<!--
## Aggregated Event Details Page

In the event explorer, after selecting an analysis dimension (e.g., monitor ID), you can view aggregated events based on that dimension. Clicking on an aggregated event allows you to view its detailed information, including basic attributes, status & trends, alert notifications, related events, and related dashboards. Refer to the sections above for more details.

![](img/5.event_15.png)

## Intelligent Inspection Event Details Page

If the event originates from an intelligent inspection event, you can view detailed information about the intelligent inspection event on the event details page, such as the event overview, abnormal Pod, container status, error logs, etc. The following diagram shows an intelligent inspection of a Pod, where you can view the event overview, abnormal Pod, container status, error logs, etc.

> For more details, refer to [Intelligent Inspection](../monitoring/bot-obs/index.md).

![](../img/5.event_16.png)

You can also view Kubernetes metric views added to this intelligent inspection (associated field: `df_dimension_tags`).

> For more details, refer to [Bind Built-in Views](../scene/built-in-view/bind-view.md).

![](../img/5.event_17.png)

-->

## Related Queries {#related-query}

In the related queries section, you can view all queries associated with the current event.

![](../img/5.event_9.png)