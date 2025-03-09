# Alert Statistics Chart
---

Displays unresolved alert events in a list format, allowing for quick identification and response to urgent issues in the system.

<img src="../../img/warning.png" width="70%" >

The alert events based on anomaly detection are divided into two sections in the alert statistics chart:

- Statistics Chart: Groups events by severity level and counts the number of events at each level;
- Alert List: Displays all unresolved alert events within the selected time range.



You can query and locate events by entering keywords or further add `by` conditions for data aggregation and display.

In the alert list, hovering over an event allows you to choose to [create an Issue related to that event](../../events/event-explorer/unrecovered-events.md#issue) or [recover the event directly](../../events/event-explorer/unrecovered-events.md#recover).


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Display Settings

:material-numeric-1-circle: Display Items: Choose which parts of the current chart to display, including:

- All
- Statistics Chart Only
- Alert List Only

:material-numeric-2-circle: Pagination Quantity: The number of unresolved events displayed in the alert list on the left side, with options of 10, 20, 50, or 100 events per page; the system default is 50 events per page.



## Further Reading

<font size=2>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Unrecovered Event Explorer</font>](../../events/event-explorer/unrecovered-events.md)

</div>



</font>