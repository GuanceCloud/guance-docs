# Alert Statistics Chart
---

Displays unresolved alert events in list form to quickly identify and respond to urgent issues in the system.

![Warning](../../img/warning.png)

Alert events based on anomaly detection, the alert statistics chart is divided into two sections:

- **Chart**: Groups events by severity level and counts the number of events at each level.
- **Alert List**: Shows all unresolved alert events within the selected time range.

You can search and locate events by entering keywords in the query or further add `by` conditions for data aggregation display.

In the alert list, hover over a specific event to choose to [create an Issue related to that event](../../events/event-explorer/unrecovered-events.md#issue) or directly [recover the event](../../events/event-explorer/unrecovered-events.md#recover).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Display Settings

:material-numeric-1-circle: **Display Items**: Select which parts of the current chart to display, including:

- All
- Chart Only
- Alert List Only

:material-numeric-2-circle: **Pagination Quantity**: The number of unresolved events displayed in the alert list on the left side. Options include 10, 20, 50, and 100 items per page; the system default is 50 items per page.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Unrecovered Events Explorer</font>](../../events/event-explorer/unrecovered-events.md)

</div>

</font>