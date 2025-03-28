# Unresolved Events
---

<<< custom_key.brand_name >>> consolidates all event records at the alert level within the current workspace through an Explorer. This not only helps observers comprehensively understand the context of alert events, accelerating their understanding and awareness, but also effectively reduces alert fatigue by associating Monitors and Alert Strategies.

The data source for unresolved events aggregates event data using `df_fault_id` as a unique identifier and displays the most recent results. You can use this visualization tool to intuitively understand a series of key data points from event levels to baseline thresholds that trigger alerts. From event levels and durations to alert notifications, Monitors, and event content, along with historical trigger trend charts, these pieces of information collectively form a comprehensive view that helps you analyze and understand events from different angles, thus enabling more informed response decisions.

![](../img/unrecovered_events_list.png)

## Event Cards

![](../img/event-card.png)

### Event Level

Based on the trigger condition configuration of Monitors, statuses such as **Unresolved (df_status != ok)**, **Critical**, **Major**, **Minor**, and **No Data** are counted.

In <<< custom_key.brand_name >>>'s unresolved event Explorer, the level of each event is defined as the level during the most recent trigger for that detection object.

> For more details, refer to [Event Level Description](../../monitoring/monitor/event-level-description.md).

### Event Title

The event title displayed in the unresolved event Explorer directly originates from the [title set](../../monitoring/monitor/mutation-detection.md#event-content) when configuring Monitor rules. It represents the title used during the last event trigger for that detection object.

### Duration

Indicates the duration from the first trigger of an anomaly event for the current detection object up to the end time of the current Time Widget, such as `5 minutes (08/20 17:53:00 ~ 17:57:38)`.

### Alert Notifications

The status of the last alert notification triggered by the current detection object. It mainly includes the following three states:

- Mute: Indicates that the current event is affected by mute rules but no external alert notifications have been sent;
- Identifiers for actually sent [Notification Targets]: including DingTalk bots, WeCom bots, Lark bots, etc.;
- `-`: No external alert notifications were triggered.

### Monitor Detection Type

This refers to the type of Monitor.

### Detection Object

When configuring Monitor rules, if a `by` group query is used for detecting Metrics, the event card will display filter conditions, such as `source:kodo-servicemap`.

### Event Content

The content of the last event triggered by the current detection object originates from the [preset content](../../monitoring/monitor/mutation-detection.md#event-content) configured when setting up Monitor rules. It represents the content of the last triggered event for that detection object.

### Historical Trigger Trend Chart {#exception}

This trend is displayed using Window functions, showing the historical trends of 60 detection results.

Based on the detection results of unresolved events, the historical abnormal trend of events is displayed. The trigger threshold value within the configured Monitor detection rule is set as a clear reference line. The system specially marks the detection result of the last event triggered by the current detection object, and through the **vertical line** in the trend chart, you can quickly locate the exact time point when the event was triggered. Additionally, the corresponding detection interval for that detection result is also displayed, providing you with an intuitive analysis tool to evaluate the development process and impact of the event.


## Management Cards

### Display Preferences {#preference}

The list of unresolved events supports two display styles: Standard and Extended.

- Standard: Displays event titles, detection dimensions, and event content.

![](../img/event-1-1.png)

- Extended: In addition to standard information, it also displays the historical trend of detection results for unresolved events.

![](../img/event.png)


### Issues & Create Issue {#issue}

You can [Create an Issue](../../exception/issue.md#event) related to unresolved events to notify relevant members for timely handling.
 
![](../img/event-2.png)

<img src="../../img/event-3.png" width="60%" >

If the current event is associated with an Incident, clicking the icon allows you to directly jump to the view:

<img src="../../img/event_jump_to_issue.png" width="80%" >

### Resolved Events {#recover}

An event's status is normal (`df_sub_status = ok`) when it becomes a resolved event. Recovery rules can be set in [Monitors](../../monitoring/monitor/index.md) or manually resolved.

Resolved events are divided into four types:

| <div style="width: 140px">Name</div>       | `df_status` | Description                                                    |
| :------------- | :-------- | :----------------------------------------------------------- |
| Resolved           | ok        | Previously detected "Critical", "Major", "Minor" anomalies; if they don't re-trigger within N detections, it is considered resolved. |
| Data Gap Resolved     | ok        | If data reporting stops and then resumes, it is judged as resolved. |
| Data Gap Treated as Resolved | ok        | If detection data shows a gap, it is treated as a normal state. |
| Manually Resolved       | ok        | Users can manually click to resolve, supporting single or batch recovery.         |



## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Event Details</font>](event-details.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; All Event Explorers</font>](./event-list.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; The Power of Explorers</font>](../../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Visualizing Event Data Through Alert Statistics Charts</font>](../../scene/visual-chart/alert-statistics.md)

</div>



</font>