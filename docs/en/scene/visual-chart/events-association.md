# Event Correlation
---


By adding filter fields to match related incident events, the association display of time series data and events can be achieved. This helps users perceive related events during data fluctuations while viewing data trends, thus providing another perspective for problem identification.

???+ warning "Note"

    This feature currently only supports time series charts and histograms.

## Use Case Examples

Query statement: 

```
M::`system`:(last(`load5_per_core`) AS `5m`) { `host` = '#{host}' } BY `host`
```

This query retrieves the latest values of the `load5_per_core` metrics for each host over a recent period (determined by the parameter after AS, which is 5 minutes in this case). The query results will be grouped by host (`host`).

The added event correlation filter condition here is that `df_is_silent` (whether the event is muted) is `false`, meaning that only events that have not been muted are returned in the end.

On the timeline, areas with event records will be marked with shaded blocks. Clicking them allows you to view related incident events.


<img src="../../img/event_association.png" width="70%" >

<img src="../../img/event_association_1.png" width="70%" >