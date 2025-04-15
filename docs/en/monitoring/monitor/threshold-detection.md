# Threshold Detection
---


Used to monitor abnormal situations in data such as Metrics, LOGs, and APM. You can set a threshold range, and when the data exceeds these thresholds, the system will trigger an alert and notify externally. Additionally, it supports simultaneous detection of multiple Measurements, with different alert levels configurable for each detection.


## Use Cases

Supports monitoring abnormalities in data related to Metrics, LOGs, infrastructure, Resource Catalog, events, APM, RUM, Security Check, and NETWORK aspects. For example, you can monitor whether the memory usage rate of HOSTs is abnormally high.


## Detection Configuration {#steps}


### Detection Frequency

The execution frequency of the detection rules; default is 5 minutes.

In addition to the specific options provided by the system above, you can also input a [**custom crontab task**](./detection-frequency.md), configuring scheduled tasks based on minutes, hours, days, months, weeks, etc.

When using a custom Crontab detection frequency, the detection intervals include the last 1 minute, the last 5 minutes, the last 15 minutes, the last 30 minutes, the last 1 hour, and the last 3 hours.

<img src="../../img/crontab.png" width="60%" >

### Detection Interval

The time range for querying the detection Metrics. Depending on the detection frequency, selectable detection intervals may vary.

| Detection Frequency | Detection Intervals (Dropdown Options) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |
| 12h | 12h/24h |
| 24h | 24h |

3) **Detection Metrics**: Setting the data to be detected.

| Field | Description |
| --- | --- |
| Data Type | The current data type being detected, supporting detection of Metrics, LOGs, infrastructure, Resource Catalog, events, APM, RUM, Security Check, and NETWORK data types. |
| Measurement | The Measurement set where the current detection Metric resides (example: "Metrics" data type). |
| Metric | The Metric currently being detected (example: "Metrics" data type). |
| Aggregation Algorithm | Includes Avg by (take average), Min by (take minimum), Max by (take maximum), Sum by (sum), Last (take the last value), First by (take the first value), Count by (count data points), Count_distinct by (count non-repeating data points), p50 (take median value), p75 (take the value at the 75% position), p90 (take the value at the 90% position), p99 (take the value at the 99% position). |
| Detection Dimensions | Any string type (`keyword`) field in the configured data can be selected as a detection dimension. Currently, up to three fields can be selected for detection dimensions. By combining multiple detection dimension fields, a specific detection object can be determined. The system will judge whether the statistical Metrics corresponding to a certain detection object meet the threshold conditions for triggering events. If the conditions are met, an event will be generated.<br />* (For example, selecting detection dimensions `host` and `host_ip`, the detection object could be {host: host1, host_ip: 127.0.0.1}. When the detection object is "LOG", the default detection dimensions are `status`, `host`, `service`, `source`, `filename`.)* |
| Filtering Conditions | Based on the labels of the Metrics, filter the data of the detection Metrics, limiting the scope of the detected data. One or more label filters can be added. Non-Metric data supports fuzzy matching and fuzzy non-matching filtering conditions. |
| Alias | Customize the name of the detection Metric. |
| [Query Method](../../scene/visual-chart/chart-query.md) | Supports simple query, expression query, and PromQL query. |

### Trigger Conditions

Set the trigger conditions for the alert level: You can configure any one of the urgent, important, warning, normal trigger conditions.

Configure trigger conditions and severity levels. When the query result contains multiple values, if any value meets the trigger condition, an event will be generated.

> For more details, refer to [Event Level Description](event-level-description.md).   


If **continuous trigger judgment is enabled**, you can configure the trigger condition to take effect after multiple consecutive judgments, and then generate events again. The maximum limit is 10 times.



???+ abstract "Alert Levels"

	1. **Alert Levels Urgent (Red), Important (Orange), Warning (Yellow)**: Based on configured condition operators.

    > For more operator details, refer to [Operator Description](operator-description.md);   
    >     
    > For details about the truth tables of `likeTrue` and `likeFalse`, refer to [Truth Table Description](table-description.md).


    2. **Alert Level Normal (Green)**: Based on the configured detection count, as follows:

    - Each execution of a detection task counts as 1 detection, for example, [Detection Frequency = 5 minutes], then 1 detection = 5 minutes;  
    - You can customize the detection count, for example, [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.  

    | Level | Description |
    | --- | --- |
    | Normal | After the detection rule takes effect, if critical, important, or warning abnormal events occur, and within the configured custom detection count, the data detection results return to normal, then a recovery alert event will be generated.<br/> :warning: Recovery alert events are not subject to [Alert Mute](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will always appear in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Recovery Conditions {#recover-conditions}

???+ warning "Prerequisite"

    Recovery conditions will only be displayed here if all trigger conditions are selected as >, >=, <, <=.

After enabling the configuration of recovery conditions, set recovery conditions and severity levels for the current Explorer. When the query result contains multiple values, if any value satisfies the trigger condition, a recovery event will be generated.


- Alert recovery logic: Each alert level corresponds to a recovery threshold, sending the corresponding recovery event after triggering the alert.

- Recovery event sending logic:           
    
    - When the alert level decreases from high to low, send the corresponding level recovery event and the next level alert event;           
    - When the alert level increases from low to high, send the corresponding level alert event;     
    - When the alert returns to normal, send the normal recovery event.   

???+ warning "Note"

    The recovery threshold for the corresponding level must be less than the trigger threshold (e.g., recovery threshold for urgent < trigger threshold for urgent).
  

### Data Gaps

For data gap states, seven strategies can be configured.

1. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection Metrics, **do not trigger events**;

2. Linked to the detection interval time range, judge the query results of the most recent minutes of the detection Metrics, **view the query results as 0**; At this point, the query results will be compared again with the thresholds configured in the **trigger conditions** above, thereby determining whether to trigger an abnormal event.

3. Custom fill-in detection interval values, **trigger data gap events, trigger urgent events, trigger important events, trigger warning events, and trigger recovery events**; If this type of configuration strategy is chosen, it is recommended that the custom data gap time configuration be **>= detection interval time**. If the configured time is <= the detection interval time, there may be cases where both data gaps and anomalies are satisfied simultaneously. In such cases, only the data gap processing results will apply.


### Information Generation

Enabling this option generates "information" events for detection results that do not match the above trigger conditions and writes them.

???+ warning "Note"

    If trigger conditions, data gaps, and information generation are configured simultaneously, the following priority order applies: data gaps > trigger conditions > information event generation.