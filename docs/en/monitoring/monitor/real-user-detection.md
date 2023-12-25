# RUM Metric Detection
---

RUM Metric Detection is used to monitor the metric data of user access within the workspace. By setting threshold ranges, alerts can be triggered when the metrics reach the threshold. It supports setting alerts for individual metrics and customizing alert levels.

## Use Case

Support the monitoring of metric data including Web, Android, iOS and Miniapp application types. For example, you can monitor the JS error rate based on the city dimension on the web side.

## Setup

### Step 1: Detection Configuration

![](../img/monitor25.png)

:material-numeric-1-circle-outline: **Detection Frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

:material-numeric-2-circle-outline: **Detection Interval:** The time range of detection index query when each task is executed. The optional detection interval will be different due to the influence of detection frequency.

| Detection Frequency | Detection Interval (Drop-down Option) |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |

:material-numeric-3-circle-outline: **Detection Metrics:** Set the metric of detection data. Support to set the metric data of all/single applications within a certain time range under a single application type in the current workspace. For example, in the current workspace, all the metric data applied under the Web type.

| Field | Description |
| --- | --- |
| Application Description | Types of applications supported by User Access Monitoring, including Web, Android, iOS, Miniapp. |
| Application Name | Obtain the corresponding application list based on the application type, and support all selection and single selection. |
| Metrics | A list of metrics obtained based on application types, <br>**Web/Miniapp**（(including JS Error Number, JS Error Rate, Resource Error Number, Resource Error Rate, Average First Render Time, Average Page Load Time, LCP (largest_contentful_paint), FID (first_input_delay), CLS (cumulative_layout_shift), FCP (first_contentful_paint), and so on.<br>**Android/IOS**(including startup time, total crashes, total crashes, resource errors, resource errors, FPS, average page load time, and so on.) |
| Filtering | Based on the metric label, the data of detection metric is screened and the detection data range is limited. Support to add one or more label filters, and support fuzzy matching and fuzzy mismatching filters. |
| Detect Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. *(For example, if the instrumentation dimensions `host` and `host_ip` are selected, the instrumentation object can be `{host: host1, host_ip: 127.0.0.1}`.)* |

[**Web**](../../real-user-monitoring/web/app-data-collection.md) / [**Miniapp**](../../real-user-monitoring/miniapp/app-data-collection.md) **Metric Description**

<table>
<tr>
<td> Metric </td> <td> Query Sample </td>
</tr>

<tr>
<td> Number of JS Errors </td> 
<td> 

R::js_error:(count(`error_message`)) {`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> JS Error Rate </td> 
<td> 

F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::page:(count(`page_url`) as count) {`app_id` = '#{appid}',`page_js_error_count` > 0}"),
data2 = dql("R::page:(count(`page_url`) as count) {`app_id` = '#{appid}'}")
))

</td>
</tr>

<tr>
<td> Number of resource errors </td> 
<td> 

R::resource:(count(`resource_url`)) {`app_id` = '#{appid}',( `resource_status_group` = '4xx' || `resource_status_group` = '5xx')}

</td>
</tr>

<tr>
<td> Resource Error Rate </td> 
<td> 

F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::resource:(count(`page_url`) as count) {`app_id` = '#{appid}',`resource_status` >= 400}"),
data2 = dql("R::resource:(count(`page_url`) as count) {`app_id` = '#{appid}'}")
))

</td>
</tr>

<tr>
<td> Average First Rendering Time </td> 
<td> 

R::page:(avg(page_fpt)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> Average Page Loading Time </td> 
<td> 

R::view:(avg(loading_time)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> Number of Slow Page Loads </td> 
<td> 

R::resource:(count(resource_load)){`app_id` = '#{appid}',`resource_load`>8000000000,resource_type='document'}

</td>
</tr>

<tr>
<td> Average Resource Loading Time </td> 
<td> 

R::resource:(avg(`resource_load`) as `加载耗时` ) {`app_id` = '#{appid}',resource_type!='document'}

</td>
</tr>

<tr>
<td> LCP
(largest_contentful_paint) </td> 
<td> 

Includes aggregate functions: avg、P75、P90、P99
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

Includes aggregate functions: avg、P75、P90、P99
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

Includes aggregate functions: : avg、P75、P90、P99
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

Includes aggregate functions: : avg、P75、P90、P99
R::view:(avg(first_contentful_paint)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,99)){`app_id` = '#{appid}'}

</td>
</tr>

</table>

[**Android**](../../real-user-monitoring/android/app-data-collection.md) **/** [**IOS**](../../real-user-monitoring/ios/app-data-collection.md) **Metric Description**

<table>

<tr>
<td> Metric </td> <td> Query Sample </td>
</tr>

<tr>
<td> Startup Time Consuming </td> 
<td> 

```
M::rum_app_startup:(AVG(`app_startup_duration`)) { `app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> Total Number of Crashes </td> 
<td> 

```
R::crash:(count(`crash_type`)) {`app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> Total Collapse Rate </td> 
<td> 

```
F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::crash:(count(`crash_type`) as count) {`app_id` = '#{appid}'}"),
data2 = dql("M::rum_app_startup:(count(`app_startup_duration`) as count) {`app_id` = '#{appid}'}")
))
```

</td>
</tr>

<tr>
<td> Number of Resource Errors </td> 
<td> 

```
R::resource:(count(`resource_url`) as count) {`app_id` = '#{appid}',`resource_status` >= 400}
```

</td>
</tr>

<tr>
<td> Resource Error Rate </td> 
<td> 

```
F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::resource:(count(`resource_url`) as count) {`app_id` = '#{appid}',`resource_status` >= 400}"),
data2 = dql("R::resource:(count(`resource_url`) as count) {`app_id` = '#{appid}'}")
))
```

</td>
</tr>

<tr>
<td> FPS </td> 
<td> 

```
R::view:(avg(`view_fps`)) {`app_id` = '#{appid}'}
```

</td>
</tr>


<tr>
<td> Average Page Loading Time </td> 
<td> 

```
R::view:(avg(`view_load`)) {`app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> Average Resource Loading Time </td> 
<td>

```
R::resource:(avg(`resource_load`)) { `app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> Caton Number </td> 
<td> 

```
R::freeze:(count(`freeze_type`) as count) {`app_id` = '#{appid}'}
```

</td>
</tr>

</table>


:material-numeric-4-circle-outline: **Trigger Condition:** Set the trigger condition of alert level; You can configure any of the following trigger conditions: Critical, Error, Warning, No Data, or Information.

![](../img/monitor26.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

> See [Event Levels](event-level-description.md). 

I. Alert levels: Critical (red), Important (orange), Warning (yellow): Based on the configured conditions using [operators](operator-description.md).

II. Alert levels: OK (green), Information (blue): Based on the configured number of detections, as explained below:

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

| Level | Description |
| --- | --- |
| OK | After the detection rule takes effect, if the result of an urgent, important, or warning abnormal event returns to normal within the configured number of custom detections, a recovery alert event is generated. <br/>:warning: Recovery alert events are not affected by [Mute Alerting](../alert-setting.md). If no detection count is set for recovery alert events, the alert event will not recover and will always appear in the Events > Unrecovered Events List. |
| Information | Events are generated even for normal detection results. |

III. Alert level: No Data (gray): The no data state supports three configuration strategies: Trigger No-Data Event, Trigger Recovery Event, and Untrigger Event.

### Step 2: Event Notification

![](../img/monitor15.png)

:material-numeric-5-circle-outline: **Event Title:** Set the event name of the alert trigger condition; support the use of [preset template variables](../event-template.md).

:material-numeric-6-circle-outline: **Event Content**: The content of the event notification sent when the trigger conditions are met. Support inputting text in Markdown format, previewing effects, the use of preset [associated links](link-description.md) and the use of preset [template variables](../event-template.md).

**Note**: 

- In the latest version, the Monitor Name will be automatically generated based on the Event Title input. In older monitors, there may be inconsistencies between the Monitor Name and the Event Title. To enjoy a better user experience, please synchronize to the latest version as soon as possible. One-click replacement with event title is supported.

- Different alert notification targets support different Markdown syntax. For example, WeCom does not support unordered lists.

**No Data Notification Configuration**: Support customizing the content of the no data notification. If not configured, the official default notification template will be automatically used.


:material-numeric-7-circle-outline: **Alarm Strategy:** After the monitoring meets the trigger conditions, immediately send an alert message to the specified notification targets. The [Alert Strategy](../alert-setting.md) includes the event level that needs to be notified, the notification targets and the mute alerting period.

### Step 3: Association

![](../img/monitor13.png)

:material-numeric-8-circle-outline: **Associate Dashboard**: Every monitor supports associating with a dashboard for quick navigation and viewing.

### Example

Monitor the number of JS errors on the web side of skywalking-web-demo based on the service dimension.

![](../img/example08.png)