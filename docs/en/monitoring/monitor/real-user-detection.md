# User Access Metrics Monitoring
---

This feature monitors metrics related to user access within the workspace. Threshold ranges can be set, and when metrics exceed these thresholds, the system will automatically trigger alerts. Additionally, it supports configuring alert rules for individual metrics and allows customization of alert severity levels.


## Use Cases

It supports monitoring metrics data for various types of applications, including Web, Android, iOS, and Miniapp. For example, you can monitor JS error rates based on city dimensions for web applications.


## Detection Configuration

![](../img/5.monitor_10.png)

### Detection Frequency

The execution frequency of detection rules; the default is 5 minutes.

### Detection Interval

The time range for querying detection metrics. Depending on the detection frequency, different intervals are available.

| Detection Frequency | Detection Interval (Dropdown Options) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |
| 12h | 12h/24h |
| 24h | 24h |

### Detection Metrics

Set the metrics for detecting data. It supports setting all or single application metrics under a specific application type within the current workspace for a certain time range. For example: all application metrics data under the Web type in the current workspace.

| Field | Description |
| --- | --- |
| Application Type | Application types supported by **RUM**, including Web, Android, iOS, Miniapp |
| Application Name | Retrieves the corresponding application list based on the application type, supporting both full selection and individual selection |
| Metrics | Retrieves the metrics list based on the application type,<br>**Web/Miniapp** (including JS error count, JS error rate, resource error count, resource error rate, average first render time, average page load time, LCP(largest_contentful_paint), FID(first_input_delay), CLS(cumulative_layout_shift), FCP(first_contentful_paint), etc.)<br>**Android/IOS** (including launch duration, total crash count, total crash rate, resource error count, resource error rate, FPS, average page load time, etc.). |
| Filter Conditions | Filters the detected metric data using tags associated with the metrics, limiting the scope of the detected data. Supports adding one or multiple tag filters, including fuzzy matching and non-matching conditions. |
| Detection Dimensions | Any string type (`keyword`) fields in the configuration can be selected as detection dimensions. Currently, up to three fields can be chosen. By combining multiple detection dimension fields, a specific detection object can be determined. <<< custom_key.brand_name >>> will evaluate whether the statistical metrics of a particular detection object meet the threshold conditions. If they do, an event is generated.<br />* (For example, selecting detection dimensions `host` and `host_ip` would result in a detection object like `{host: host1, host_ip: 127.0.0.1}`.)*

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
<td> Average First Render Time </td> 
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

Includes aggregate functions: avg, P75, P90, P99
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

Includes aggregate functions: avg, P75, P90, P99
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

Includes aggregate functions: avg, P75, P90, P99
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

Includes aggregate functions: avg, P75, P90, P99
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

Set the trigger conditions for alert levels: You can configure any one of the critical, major, minor, or normal trigger conditions.

Configure the trigger conditions and severity level. When the query results contain multiple values, if any value meets the trigger condition, an event is generated.

> For more details, refer to [Event Level Description](event-level-description.md).   

If **Continuous Trigger Judgment** is enabled, you can configure the number of consecutive times the trigger condition must be met before another event is generated. The maximum limit is 10 times.


???+ abstract "Alert Levels"

	1. **Critical (Red), Major (Orange), Minor (Yellow)**: Based on the configured condition operators.

    > For more details, refer to [Operator Description](operator-description.md).

    2. **Normal (Green)**: Based on the configured detection count, as follows:

    - Each execution of a detection task counts as 1 detection, e.g., [Detection Frequency = 5 minutes], then 1 detection = 5 minutes;
    - You can customize the detection count, e.g., [Detection Frequency = 5 minutes], then 3 detections = 15 minutes.

    | Level | Description |
    | --- | --- |
    | Normal | After the detection rule takes effect, if critical, major, or minor events occur, and within the configured custom detection count, the data returns to normal, a recovery alert event is generated.<br/> :warning: Recovery alert events are not subject to [Alert Mute](../alert-setting.md) restrictions. If no recovery alert event detection count is set, the alert event will not recover and will remain in the [**Events > Unrecovered Events List**](../../events/event-explorer/unrecovered-events.md).|

### Data Discontinuity

For data discontinuity states, seven strategies can be configured.

1. Linked to the detection interval time range, judge the query results of the most recent minutes for the detection metrics, **do not trigger events**;

2. Linked to the detection interval time range, judge the query results of the most recent minutes for the detection metrics, **treat query results as 0**; at this point, the query results will be compared against the threshold configured in the **Trigger Conditions** to determine if an anomaly event should be triggered.

3. Custom fill for the detection interval value, **trigger data discontinuity events, trigger critical events, trigger major events, trigger minor events, and trigger recovery events**; when choosing this type of configuration strategy, it is recommended that the custom data discontinuity time be **>= detection interval time**. If the configured time <= detection interval time, there may be simultaneous satisfaction of data discontinuity and anomaly conditions, in which case only the data discontinuity handling result will apply.


### Information Generation

Enabling this option will generate "Information" events for detection results that do not match the above trigger conditions and write them into the log.


**Note**: If trigger conditions, data discontinuity, and information generation are configured simultaneously, the following priority applies: data discontinuity > trigger conditions > information event generation.