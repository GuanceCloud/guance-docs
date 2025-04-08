# Alert Statistics Chart
---

Displays unresolved alert events in list form to help quickly identify and respond to urgent issues in the system.

<img src="../../img/warning.png" width="70%" >

The alert statistics chart is based on alert events from anomaly detection and is divided into two parts:

- Chart: Groups events by severity level and counts the number of events for each level;
- Alert List: Displays all unresolved alert events generated within the selected time range.

You can enter keywords in the query box to search and locate, or add a `by` condition for data aggregation display.


In the alert list, hovering over an event data item allows you [to create an Issue related to that event](../../events/event-explorer/unrecovered-events.md#issue) or directly [recover that event](../../events/event-explorer/unrecovered-events.md#recover).


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Display Settings

- Display Items: Choose which part of the chart to display, including:

    - All
    - Chart Only
    - Alert List Only

- Pagination Quantity: Set the number of unresolved events displayed in the left alert list. Options are: 10 items, 20 items, 50 items, 100 items; default is 50 items.



## Further Reading

<font size=2>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Unrecovered Events Explorer</font>](../../events/event-explorer/unrecovered-events.md)

</div>



</font>