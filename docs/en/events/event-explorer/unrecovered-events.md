# Unrecovered Events
---

The Explorer aggregates all event records at the alert level within the current workspace, helping users comprehensively understand the context of alert events and accelerate their understanding and cognition of events. It also effectively reduces alert fatigue through associated monitors and alert strategies.

The data source for unrecovered events queries event data, aggregates it using `df_fault_id` as a unique identifier, and displays the most recent data results. You can use this visualization tool to intuitively understand a series of key data points from event levels to trigger threshold baselines, including event levels, duration, alert notifications, monitors, event content, and historical trigger trend charts. These pieces of information together form a comprehensive view, helping you analyze and understand events from different angles to make more informed response decisions.

![](../img/unrecovered_events_list.png)

## Event Card

![](../img/event-card.png)

### Event Level

Based on the trigger condition configuration of monitors, there are statistics for statuses such as **Unrecovered (df_status != ok)**, **Critical**, **Major**, **Minor**, and **No Data**.

In the Unrecovered Events Explorer, each event's level is defined as the level during the last trigger of the monitored object.

> For more details, refer to [Event Level Description](../../monitoring/monitor/event-level-description.md).

### Event Title

The event title displayed in the Unrecovered Events Explorer directly comes from the title set when configuring monitor rules [Set Title](../../monitoring/monitor/mutation-detection.md#event-content). It represents the title used during the last trigger of the monitored object.

### Duration

This indicates the time from the first trigger of an anomaly event for the current monitored object up to the end time of the current Time Widget, such as `5 minutes (08/20 17:53:00 ~ 17:57:38)`.

### Alert Notifications

The alert notification status for the last triggered event of the current monitored object. It mainly includes the following three states:

- Mute: Indicates that the current event is affected by mute rules but no external alert notifications have been sent;
- Identifiers of the actual [Notification Targets] sent: Includes DingTalk bots, WeCom bots, Lark bots, etc.;
- `-`: No external alert notifications were triggered.

### Monitor Detection Type

That is, the type of monitor.

### Monitored Object

When configuring monitor rules, if `by` group queries are used in the detection metrics, the event card will display filter conditions, such as `source:kodo-servicemap`.

### Event Content

The event content for the last triggered event of the current monitored object, sourced from the [preset content] configured when setting up monitor rules (../../monitoring/monitor/mutation-detection.md#event-content). It represents the event content during the last trigger of the monitored object.

### Historical Trigger Trend Chart {#exception}

This trend is displayed using Window functions, showing the historical trend of 60 detection results based on actual data.

Based on the detection results of the current unrecovered event, the historical event anomaly trend is displayed. The trigger threshold value set in the monitor detection rule is defined as a clear reference line. The system specially marks the detection result of the last triggered event for the current monitored object. Through the **vertical line** in the trend chart, you can quickly locate the exact time point of the event trigger. At the same time, the corresponding detection interval of the detection result is also displayed, providing you with an intuitive analysis tool to evaluate the development process and impact of the event.


## Management Card

### Display Preferences {#preference}

The unrecovered events list supports two display styles: Standard and Extended.

- Standard: Displays the event title, detection dimensions, and event content.

![](../img/event-1-1.png)

- Extended: In addition to standard information, it also displays the detection result values [Historical Trend](#exception) for unrecovered events.

![](../img/event.png)


### Issues & Create Issue {#issue}

You can [create an Issue] for unrecovered events (../../exception/issue.md#event) to notify relevant members to handle it promptly.
 
![](../img/event-2.png)

<img src="../../img/event-3.png" width="60%" >

If the current event is associated with an Incident, clicking the icon allows you to jump directly to the view:

<img src="../../img/event_jump_to_issue.png" width="80%" >

### Recovered Events {#recover}

An event is considered recovered when its status is normal (`df_sub_status = ok`). Recovery rules can be set in [Monitors](../../monitoring/monitor/index.md) or manually recovered.

Recovered events are divided into four types:

| <div style="width: 140px">Name</div>       | `df_status` | Description                                                    |
| :------------- | :-------- | :----------------------------------------------------------- |
| Recovered           | ok        | Previously detected "Critical", "Major", "Minor" anomalies, not triggered again within N detections, thus considered recovered. |
| Data Gap Recovery     | ok        | Data reporting resumes after stopping, judged as recovered. |
| Data Gap Considered Recovered | ok        | Data gaps in detection are considered normal state. |
| Manual Recovery       | ok        | User manually clicks recovery, supporting single/batch recovery.         |



## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Event Details</font>](event-details.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; All Event Explorers</font>](./event-list.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; The Power of the Explorer</font>](../../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Visualizing Event Data Analysis via Alert Statistics Charts</font>](../../scene/visual-chart/alert-statistics.md)

</div>



</font>