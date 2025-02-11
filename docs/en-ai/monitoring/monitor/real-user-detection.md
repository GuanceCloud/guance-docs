# User Access Metrics Monitoring
---

This feature is used to monitor metrics related to user access within the workspace. Threshold ranges can be set, and when the metrics exceed these thresholds, the system will automatically trigger alerts. Additionally, it supports configuring alert rules for individual metrics and allows customization of alert severity levels.


## Application Scenarios

It supports monitoring metrics data for various application types including Web, Android, iOS, and Miniapp. For example, you can monitor JS error rates based on city dimensions for web applications.


## Monitoring Configuration

![](../img/5.monitor_10.png)

### Monitoring Frequency

This refers to the execution frequency of the monitoring rules; the default is set to 5 minutes.

### Monitoring Interval

This refers to the time range for querying the monitored metrics. Depending on the monitoring frequency, different intervals are available.

| Monitoring Frequency | Monitoring Intervals (Dropdown Options) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |
| 12h | 12h/24h |
| 24h | 24h |

### Monitoring Metrics

Set the metrics for the monitored data. It supports setting metrics data for all or single applications under a specific application type within the current workspace over a certain time period. For example, metrics data for all Web-type applications in the current workspace.

| Field | Description |
| --- | --- |
| Application Type | Supported application types by **RUM**, including Web, Android, iOS, Miniapp |
| Application Name | Retrieve the corresponding application list based on the application type, supporting both full selection and individual selection |
| Metrics | Retrieve the metrics list based on the application type:<br>**Web/Miniapp** (including JS error count, JS error rate, resource error count, resource error rate, average first paint time, average page load time, LCP(largest_contentful_paint), FID(first_input_delay), CLS(cumulative_layout_shift), FCP(first_contentful_paint), etc.)<br>**Android/IOS** (including launch duration, total crash count, total crash rate, resource error count, resource error rate, FPS, average page load time, etc.). |
| Filtering Conditions | Filter the monitored metric data based on metric labels, limiting the scope of the monitored data. Supports adding one or multiple label filters, including fuzzy matching and fuzzy non-matching conditions. |
| Monitoring Dimensions | Any string type (`keyword`) fields in the configuration can be selected as monitoring dimensions. Currently, up to three fields can be chosen. By combining multiple dimension fields, a specific monitoring object can be determined. Guance will evaluate whether the statistical metrics for a particular monitoring object meet the threshold conditions, generating an event if they do.<br />* (For example, selecting monitoring dimensions `host` and `host_ip` would result in a monitoring object `{host: host1, host_ip: 127.0.0.1}`).*

#### [**Web**](../../real-user-monitoring/web/app-data-collection.md) / [**Miniapp**](../../real-user-monitoring/miniapp/app-data-collection.md) **Metrics Description**

<table>
<tr>
<td> Metric </td> <td> Query Example </td>
</tr>

<tr>
<td> JS Error Count </td> 
<td> 

R::error:(count(`__docid`) as `JS Error Count`) { `app_id` = '<Application ID>' }

</td>
</tr>

<tr>
<td> JS Error Rate </td> 
<td> 

Web: eval(A/B, alias='Page JS Error Rate', A="R::view:(count(`view_url`)) {`view_error_count` > 0, `app_id` = '<Application ID>'}",B="R::view:(count(`view_url`)) { `app_id` = '<Application ID>'} ")

Miniapp: eval(A/B, alias='JS Error Rate', A="R::view:(count(`view_name`)) {`view_error_count` > 0, `app_id` = '<Application ID>' }",B="R::view:(count(`view_name`)) { `app_id` = '<Application ID>' }")

</td>
</tr>

<tr>
<td> Resource Error Count </td> 
<td> 

R::resource:(count(`resource_url`) as `Resource Error Count`) {`resource_status` >=400, `app_id` = '<Application ID>'}

</td>
</tr>

<tr>
<td> Resource Error Rate </td> 
<td> 

eval(A/B, alias='Resource Error Rate', A="R::`resource`:(count(`resource_url`)) { `resource_status` >= '400',`app_id` = '<Application ID>' }", B="R::`resource`:(count(`resource_url`)) { `app_id` = '<Application ID>' }")

</td>
</tr>

<tr>
<td> Average First Paint Time </td> 
<td> 

R::page:(avg(page_fpt)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> Average Page Load Time </td> 
<td> 

R::view:(avg(loading_time)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> Slow Page Load Count </td> 
<td> 

R::resource:(count(resource_load)){`app_id` = '#{appid}',`resource_load`>8000000000,resource_type='document'}

</td>
</tr>

<tr>
<td> Average Resource Load Time </td> 
<td> 

R::resource:(avg(`resource_load`) as `Load Time` ) {`app_id` = '#{appid}',resource_type!='document'}

</td>
</tr>

<tr>
<td> LCP
(largest_contentful_paint) </td> 
<td> 

Aggregation functions: avg, P75, P90, P99
R::view:(avg(largest_contentful_paint)){`app_id` = '#{appid}'}
R::view:(percentile(`largest_contentful_paint`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`largest_contentful_paint`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`largest_contentful_paint`,99)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> FID
(first_input_delay) </td> 
<td> 

Aggregation functions: avg, P75, P90, P99
R::view:(avg(first_input_delay)){`app_id` = '#{appid}'}
R::view:(percentile(`first_input_delay`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`first_input_delay`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`first_input_delay`,99)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> CLS
(cumulative_layout_shift) </td> 
<td> 

Aggregation functions: avg, P75, P90, P99
R::view:(avg(cumulative_layout_shift)){`app_id` = '#{appid}'}
R::view:(percentile(`cumulative_layout_shift`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`cumulative_layout_shift`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`cumulative_layout_shift`,99)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> FCP
(first_contentful_paint)  </td> 
<td> 

Aggregation functions: avg, P75, P90, P99
R::view:(avg(first_contentful_paint)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,99)){`app_id` = '#{appid}'}

</td>
</tr>

</table>

[**Android**](../../real-user-monitoring/android/app-data-collection.md) **/** [**iOS**](../../real-user-monitoring/ios/app-data-collection.md) **Metrics Description**

<table>

<tr>
<td> Metric </td> <td> Query Example </td>
</tr>

<tr>
<td> Launch Duration </td> 
<td> 

R::action:(avg(duration)) { `app_id` = '<Application ID>' ,action_type='app_cold_launch'}

</td>
</tr>

<tr>
<td> Total Crash Count </td> 
<td> 

R::error:(count(error_type)) {app_id='<Application ID>',`error_source` = 'logger' and is_web_view !='true'} 

</td>
</tr>

<tr>
<td> Total Crash Rate </td> 
<td> 

eval(A.a1/B.b1, alias='Total Crash Rate',A="R::error:(count(error_type) as a1) {app_id='<Application ID>',`error_source` = 'logger',is_web_view !='true'} ",B="R::action:(count(action_name) as b1)  { `app_id` = '<Application ID>',`action_type` in [`launch_cold`,`launch_hot`,`launch_warm`]} ")

</td>
</tr>

<tr>
<td> Resource Error Count </td> 
<td> 

R::resource:(count(`resource_url`) as `Resource Error Count`) {`resource_status` >=400, `app_id` = '<Application ID>'}

</td>
</tr>

<tr>
<td> Resource Error Rate </td> 
<td> 

eval(A/B, alias='Resource Error Rate', A="R::`resource`:(count(`resource_url`)) { `resource_status` >= '400',`app_id` = '<Application ID>' }", B="R::`resource`:(count(`resource_url`)) { `app_id` = '<Application ID>' }")

</td>
</tr>

<tr>
<td> Average FPS </td> 
<td> 

R::view:(avg(`fps_avg`))  { `app_id` = '<Application ID>' }

</td>
</tr>


<tr>
<td> Average Page Load Time </td> 
<td> 

R::view:(avg(`loading_time`))  { `app_id` = '<Application ID>' }

</td>
</tr>

<tr>
<td> Average Resource Load Time </td> 
<td>

R::resource:(avg(`duration`))  { `app_id` = '<Application ID>' }

</td>
</tr>

<tr>
<td> Jank Count </td> 
<td> 

R::long_task:(count(`view_id`))  { `app_id` = '<Application ID>' }

</td>
</tr>

<tr>
<td> Page Error Rate </td> 
<td> 

eval(A/B, alias='Page Error Rate',A="R::view:(count(`view_name`)) {`view_error_count` > 0, `app_id` = '<Application ID>' }",B="R::view:(count(`view_name`)) { `app_id` = '<Application ID>' }")

</td>
</tr>

</table>

### Trigger Conditions

Set the trigger conditions for alert levels: you can configure any one of critical, major, minor, and normal trigger conditions.

Configure trigger conditions and severity levels. If the query results contain multiple values, an event will be generated if any value meets the trigger condition.

> For more details, refer to [Event Level Description](event-level-description.md).

If **Continuous Trigger Evaluation** is enabled, you can configure the number of consecutive evaluations required before triggering an event. The maximum limit is 10 times.


???+ abstract "Alert Levels"

	1. **Alert Levels Critical (Red), Major (Orange), Minor (Yellow)**: Based on configured conditions and operators.

    > For more details, refer to [Operator Description](operator-description.md).

    2. **Alert Level Normal (Green)**: Based on configured detection counts, as follows:

    - Each execution of a detection task counts as 1 detection, e.g., [Detection Frequency = 5 minutes], then 1 detection = 5 minutes;
    - You can customize the detection count, e.g., [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

    | Level | Description |
    | --- | --- |
    | Normal | After the detection rule takes effect, if critical, major, or minor events occur, and the data returns to normal within the configured custom detection count, a recovery alert event will be generated.<br/> :warning: Recovery alert events are not subject to [Alert Muting](../alert-setting.md). If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Gaps

You can configure seven strategies for handling data gaps.

1. Evaluate the most recent minute's query results within the monitoring interval, **do not trigger an event**;

2. Evaluate the most recent minute's query results within the monitoring interval, **treat the query result as 0**; this result will then be compared against the threshold configured in the **Trigger Conditions** to determine if an anomaly event should be triggered.

3. Customize the filling of the monitoring interval values, **trigger data gap events, critical events, major events, minor events, and recovery events**; it is recommended that the custom data gap time configuration be **>= monitoring interval time span**. If the configured time <= monitoring interval time span, there may be simultaneous satisfaction of data gaps and anomalies, in which case only the data gap handling result will apply.


### Information Event Generation

Enabling this option will generate an "information" event for detection results that do not match the above trigger conditions.

**Note**: When configuring trigger conditions, data gaps, and information event generation simultaneously, the following priority applies: data gaps > trigger conditions > information event generation.