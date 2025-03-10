# Event
---

The alert events of anomaly detection, the alert statistics chart is divided into two parts, namely the statistics chart and the alert list.

- Statistics Chart: Group events by level and count the number of events at each level, support clicking on the statistics chart to query the details of the event;
- Alert List: Display the alert events that have not been recovered within the selected time range.

![](../img/warning.png)

## Chart Query

- Search: Enter keywords to query event content;
- Filter: Supports adding tags to filter log data.

## Basic Settings

| Option | Description |
| --- | --- |
| Title | Set the title name for the chart, after setting, it will be displayed in the upper left corner of the chart, and hiding is supported. |
| Description | Add a description to the chart, after setting, a [i] prompt will appear after the chart title, if not set, it will not be displayed. |
| Display Items | Display all, only statistics chart or only alert list. |

## Advanced Settings

| Option | Description |
| --- | --- |
| Lock Time | That is, fix the time range of the current chart query data, which is not restricted by the global time component. After the setting is successful, the upper right corner of the chart will display the user-set time, such as [xx minutes], [xx hours], [xx days]. If the lock time interval is 30 minutes, then no matter what time range view is queried when adjusting the time component, it will only display the latest 30 minutes of data. |

