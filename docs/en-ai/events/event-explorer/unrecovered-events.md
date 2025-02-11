# Unresolved Incidents
---

Guance provides a centralized Explorer to display all incident records at the alert level within the current workspace. This approach not only helps observers gain a comprehensive understanding of the context of alert incidents, accelerating the comprehension and cognition of incidents, but also effectively reduces alert fatigue by associating monitors and alert policies.

The data source for unresolved incidents aggregates event data using `df_fault_id` as a unique identifier and displays the most recent data results. You can use the Explorer, this visualization tool, to intuitively understand a series of key data points from incident levels to baseline trigger thresholds, including incident levels, duration, alert notifications, monitors, incident content, and historical trigger trend charts. This information collectively forms a comprehensive view, helping you analyze and understand incidents from different angles to make more informed response decisions.

![](../img/5.event_6.png)

## Incident Card

![](../img/event-card.png)

### Incident Level

Based on the trigger conditions configured in the monitor, the following status statistics are generated: **Unresolved (df_status != ok)**, **Critical**, **Major (error)**, **Minor (warning)**, and **No Data**.

In Guance's unresolved incident Explorer, each incident's level is defined as the level at the last trigger event of the monitored object.

> For more details, refer to [Incident Level Description](../../monitoring/monitor/event-level-description.md).

### Incident Title

The title displayed in the unresolved incident Explorer comes directly from the [title set](../../monitoring/monitor/mutation-detection.md#event-content) when configuring the monitor rule. It represents the title used in the last triggered event of the monitored object.

### Duration

This indicates the duration from the first trigger of an anomaly event up to the end time of the current time control, such as `5 minutes (08/20 17:53:00 ~ 17:57:38)`.

### Alert Notifications

The alert notification status of the last triggered event for the current monitored object. It mainly includes the following three states:

- Mute: Indicates that the current event is affected by mute rules but no alert notification has been sent externally;
- Silence: Indicates that the current event is affected by repeated alert configurations but no alert notification has been sent externally;
- Actual [Notification Targets](../../monitoring/notify-object.md) identifiers: Including DingTalk bots, WeChat Work bots, Feishu bots, etc.

### Monitor Type

Refers to the type of monitor.

### Monitored Object

When configuring monitor rules, if a `by` group query is used in the detection metrics, the event card will display filter conditions, such as `source:kodo-servicemap`.

### Incident Content

The content of the last triggered event for the current monitored object, sourced from the [preset content](../../monitoring/monitor/mutation-detection.md#event-content) configured in the monitor rule. It represents the content of the last triggered event of the monitored object.

### Historical Trigger Trend Chart {#exception}

This trend is displayed using Window functions, showing 60 historical detection results.

Based on the detection result values of unresolved incidents, it displays the historical abnormal trend of events. The threshold condition value set in the configured monitor detection rule is marked as a clear reference line. The system specifically highlights the detection result of the last triggered event of the current monitored object, and through the **vertical lines** in the trend chart, you can quickly locate the exact time point of the event trigger. Additionally, the corresponding detection interval is also displayed, providing you with an intuitive analysis tool to evaluate the development process and impact of the event.


## Management Cards

You can manage unresolved incidents through the following operations:

1. Time Control: By default, the unresolved incident Explorer queries data from the last 48 hours and does not support customizing the time range for data display.

2. Search and Filter: In the search bar of the unresolved incident Explorer, it supports [multiple search and filter methods](../../getting-started/function-details/explorer-search.md).

3. Quick Filters: Through the quick filters on the left side of the list, you can edit [quick filters](../../getting-started/function-details/explorer-search.md#quick-filter) and add new filter fields.

    - **Note**: Custom addition of filter fields is not supported in the unresolved incident Explorer.

4. Save Snapshot: Click **View Historical Snapshots** in the upper-left corner of the incident Explorer to save the current event snapshot data. Using the [Snapshot](../../getting-started/function-details/snapshot.md) feature, you can quickly reproduce instant copies of data and restore data to a specific point in time and a specific data display logic.

5. Filter History: Guance supports saving and viewing the history of `key:value` search conditions in [Filter History](../../getting-started/function-details/explorer-search.md#filter-history), which can be applied to different Explorers in the current workspace.

6. Export: You can export unresolved incidents as a CSV file.

7. Batch Operations: Click "Batch" to select multiple events for [Recovery](#recover) operations. You can also directly recover all events with one click.

8. [Display Preferences](#preference).

### Display Preferences {#preference}

You can choose the display style of the unresolved incident list, supporting two options: Standard and Expanded.

:material-numeric-1-circle-outline: When choosing Standard: Display the event title, detection dimensions, and event content;

![](../img/event-1-1.png)

:material-numeric-2-circle-outline: When choosing Expanded: In addition to the information displayed in Standard mode, open all unresolved incident detection result values [Historical Trends](#exception).

![](../img/event.png)


### Issue & Create New Issue {#issue}

For the current unresolved incident, you can [create an Issue](../../exception/issue.md#event) to notify relevant members to track and handle it promptly.
 
![](../img/event-2.png)

<img src="../../img/event-3.png" width="60%" >

If the current incident is associated with a specific Incident, you can click the icon to directly navigate to view it:

![](../img/event-6.png)

### Recover Incident {#recover}

An incident whose status is normal (`df_sub_status = ok`). You can set recovery rules when configuring trigger conditions in [Monitors](../../monitoring/monitor/index.md) or manually recover incidents.

Recovering incidents include four scenarios: **Recover, No Data Recovery, Treat No Data as Recovery, Manual Recovery**. See the table below:

| <div style="width: 140px">Name</div>       | `df_status` | Description                                                    |
| :------------- | :-------- | :----------------------------------------------------------- |
| Recover           | ok        | If any of the "Critical", "Major", "Minor" events were previously triggered during detection, based on the N times configured in the frontend, if no "Critical", "Major", "Minor" events occur within the detection count, it is considered recovered and generates a normal recovery event. |
| No Data Recovery     | ok        | If a no data anomaly event was triggered due to data stop reporting during previous detection, and new data is reported again, it is judged as recovered and generates a no data recovery event. |
| Treat No Data as Recovery | ok        | If there is a no data situation in the detection data, this situation is considered normal and generates a recovery event. |
| Manual Recovery       | ok        | An OK event generated by users clicking to recover, supporting single/batch recovery.                            |

In the unresolved incident Explorer, hovering over an incident shows the recovery button grayed out on the right side of the incident.

![](../img/5.event_4.png)


## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Incident Details</font>](event-details.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; All Incident Explorers</font>](./event-list.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; The Power of Explorers</font>](../../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Visualize Event Data with Alert Statistics Charts</font>](../../scene/visual-chart/alert-statistics.md)

</div>

</font>