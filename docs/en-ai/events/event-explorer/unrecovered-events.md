# Unresolved Incidents
---

<<< custom_key.brand_name >>> provides a centralized Explorer to display all incident records at the alert level within the current workspace. This method not only helps observers gain a comprehensive understanding of the context of alert incidents, accelerating their comprehension and cognition of events, but also effectively reduces alert fatigue by associating monitors and alert strategies.

The data source for unresolved incidents aggregates event data using `df_fault_id` as the unique identifier and displays the latest data results. You can use the Explorer, this visualization tool, to intuitively understand a series of key data points from event levels to baseline trigger thresholds, including event levels, duration, alert notifications, monitors, event content, and historical trigger trend charts. This information collectively forms a comprehensive view, helping you analyze and understand events from different angles to make more informed response decisions.

![](../img/5.event_6.png)

## Incident Card

![](../img/event-card.png)

### Event Level

Based on the trigger conditions configured in the monitor, the following status statistics are generated: **Unresolved (df_status != ok)**, **Critical**, **Major (error)**, **Minor (warning)**, **No Data**.

In <<< custom_key.brand_name >>>'s unresolved incident Explorer, each incident's level is defined as the level during the most recent trigger event for that detection object.

> For more details, refer to [Event Level Description](../../monitoring/monitor/event-level-description.md).

### Event Title

The event title displayed in the unresolved incident Explorer comes directly from the [title set](../../monitoring/monitor/mutation-detection.md#event-content) when configuring the monitor rule. It represents the title used during the last trigger event for that detection object.

### Duration

This indicates the duration from the first trigger event until the end time of the current Time Widget, such as `5 minutes (08/20 17:53:00 ~ 17:57:38)`.

### Alert Notifications

The alert notification status for the last triggered event of the current detection object. It mainly includes three states:

- Mute: Indicates that the current event is affected by a mute rule but no external alert notifications have been sent.
- Silenced: Indicates that the current event is affected by repeated alert configurations but no external alert notifications have been sent.
- Actual [Notification Targets](../../monitoring/notify-object.md) identifiers: Including DingTalk bots, WeCom bots, Lark bots, etc.

### Monitor Detection Type

The type of monitor.

### Detection Object

If the `by` grouping query was used in the detection metrics when configuring the monitor rule, the event card will display the filter conditions, such as `source:kodo-servicemap`.

### Event Content

The event content of the last triggered event for the current detection object, sourced from the [preset content](../../monitoring/monitor/mutation-detection.md#event-content) configured in the monitor rule. It represents the event content during the last trigger event for that detection object.

### Historical Trigger Trend Chart {#exception}

This trend is displayed using a Window function, showing the actual data of 60 detection results. Based on the detection results of the current unresolved incident, it shows the historical anomaly trends of events. The trigger threshold condition values set in the configured monitor detection rules are designated as clear reference lines. The system specially marks the detection result of the last triggered event for the current detection object, and through the **vertical line** in the trend chart, you can quickly locate the exact time point of the event trigger. Additionally, the corresponding detection interval for that detection result is also displayed, providing you with an intuitive analysis tool to evaluate the development process and impact of the event.

## Management Cards

You can manage unresolved incidents through the following operations:

1. Time Widget: The unresolved incident Explorer defaults to querying data for the last 48 hours and does not support customizing the time range for data display.

2. Search and Filtering: In the search bar of the unresolved incident Explorer, multiple search methods and filtering methods are supported [here](../../getting-started/function-details/explorer-search.md).

3. Quick Filters: Through the quick filters on the left side of the list, you can edit [quick filters](../../getting-started/function-details/explorer-search.md#quick-filter) and add new filter fields.

    - **Note**: Adding custom filter fields is not supported in the unresolved incident Explorer.

4. Save Snapshot: In the upper-left corner of the incident Explorer, click **View Historical Snapshots** to save the current event snapshot data. Using the [snapshot](../../getting-started/function-details/snapshot.md) feature, you can quickly reproduce instant copies of data and restore it to a specific time point and data display logic.

5. Filter History: <<< custom_key.brand_name >>> supports saving the `key:value` search condition history in [filter history](../../getting-started/function-details/explorer-search.md#filter-history) for different Explorers in the current workspace.

6. Export: You can export unresolved incidents as a CSV file.

7. Click Batch to select multiple events for [recovery](#recover) operations. You can also directly recover all events with one click.

8. [Display Preferences](#preference).

### Display Preferences {#preference}

You can choose the display style of the unresolved incident list, supporting two options: Standard and Expanded.

:material-numeric-1-circle-outline: When choosing Standard: Only the event title, detection dimensions, and event content are visible;

![](../img/event-1-1.png)

:material-numeric-2-circle-outline: When choosing Expanded: In addition to the information displayed in standard mode, you can open the [historical trend](#exception) of the detection results for all unresolved events.

![](../img/event.png)

### Issue & Create Issue {#issue}

For the current unresolved incident, you can [create an Issue](../../exception/issue.md#event) to notify relevant members to track and handle it promptly.

![](../img/event-2.png)

<img src="../../img/event-3.png" width="60%" >

If the current incident is associated with an Incident, you can click the icon to directly navigate to view it:

![](../img/event-6.png)

### Recover Incident {#recover}

An incident whose status is normal (`df_sub_status = ok`). You can set recovery rules when configuring the trigger conditions in [Monitors](../../monitoring/monitor/index.md), or manually recover incidents.

Recovering incidents include four scenarios: **Recover**, **Data Gap Recovery**, **Data Gap Considered as Recovery**, and **Manual Recovery**. See the table below:

| <div style="width: 140px">Name</div>       | `df_status` | Description                                                    |
| :------------- | :-------- | :----------------------------------------------------------- |
| Recover           | ok        | If "Critical", "Major", or "Minor" events were previously triggered during detection, based on the N times detection configured on the frontend, if no "Critical", "Major", or "Minor" events occur within the detection times, it is considered recovered, and a normal recovery event is generated. |
| Data Gap Recovery     | ok        | If a data gap incident was triggered due to stopped data reporting during previous detection, a recovery event is generated once new data starts reporting again. |
| Data Gap Considered as Recovery | ok        | If there is a data gap in the detection data, this situation is considered normal, and a recovery event is generated. |
| Manual Recovery       | ok        | An OK event generated by user manually clicking to recover, supporting single and batch recovery.                            |

In the unresolved incident Explorer, when you hover over an incident, the recovery button on the right side of the incident is grayed out.

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

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Visualize and Analyze Event Data with Alert Statistics Charts</font>](../../scene/visual-chart/alert-statistics.md)

</div>

</font>