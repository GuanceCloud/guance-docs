# Event Correlation
---

Guance supports adding filter fields to match incidents related to selected fields, associating queried data with events. This helps in identifying whether any related events occur during data fluctuations while observing trends, assisting in multi-perspective problem localization.

**Note**: This feature currently only supports time series charts and histograms.

## Example

In the following diagram, the filter condition is:

```
M::`system`:(last(`cpu_total_usage`) AS `5m`) BY `host`
```

This means querying the latest CPU usage rate of each host within the last 15 minutes in the current workspace.

The added event correlation filter conditions are `-host:ivan-centos`, `df_status:critical`. This filters out all hosts except for the one named `ivan-centos`, and includes only events with a severity level of `critical`.

![Event Correlation Case](../../img/event_related_case.png)

On the time series, if there are event records, they will be marked with shaded blocks. Clicking on a highlighted shaded block under a query will display the incidents related to the current fields.

![Event Correlation Case 1](../../img/event_related_case-1.png)