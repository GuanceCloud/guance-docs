# User Access Metric Detection
---

## Overview

"User Access Metric Detection" is used to monitor the metric data of "User Access Monitoring" in the workspace. By setting the threshold range, when the metric reaches the threshold, it triggers an alarm, and supports setting an alarm and customizing an alarm level for a single metric.

## Application Scene

Support the monitoring of metric data including Web, Android, iOS and Miniapp application types. For example, you can monitor the JS error rate based on the city dimension on the web side.

## Rule Description

In "Monitor", click "+ New Monitor" and select "User Access Metric Detection" to enter the configuration page of detection rules.

### Step 1. Detect the Configuration

![](../img/monitor25.png)

1）**Detection frequency:** The execution frequency of detection rules, including 1m/5m/15/30m/1h/6h (5m is selected by default).

2）**Detection interval:** The time range of detection index query when each task is executed. The optional detection interval will be different due to the influence of detection frequency. (support user-defined)

| Detection Frequency | Detection Interval (Drop-down Option) | Custom Interval Limit |
| --- | --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h | <=3h |
| 5m | 5m/15m/30m/1h/3h | <=3h |
| 15m | 15m/30m/1h/3h/6h | <=6h |
| 30m | 30m/1h/3h/6h | <=6h |
| 1h | 1h/3h/6h/12h/24h | <=24h |
| 6h | 6h/12h/24h | <=24h |

3）**Detection metric:** Set the metric of detection data. Support to set the metric data of all/single applications within a certain time range under a single application type in the current workspace. For example, in the current workspace, all the metric data applied under the Web type.

| Field | Description |
| --- | --- |
| Application Description | Types of applications supported by User Access Monitoring, including Web, Android, iOS, Miniapp |
| Application Name | Obtain the corresponding application list based on the application type, and support all selection and single selection |
| Metrics | A list of metrics obtained based on application types, <br>**Web/Miniapp**（(including JS Error Number, JS Error Rate, Resource Error Number, Resource Error Rate, Average First Render Time, Average Page Load Time, LCP (largest_contentful_paint), FID (first_input_delay), CLS (cumulative_layout_shift), FCP (first_contentful_paint), and so on<br>**Android/IOS**(including startup time, total crashes, total crashes, resource errors, resource errors, FPS, average page load time, and so on) |
| Filter Condition | Based on the metric label, the data of detection metric is screened and the detection data range is limited. Support to add one or more label filters, and support fuzzy matching and fuzzy mismatching filters. |
| Detect Dimension | The corresponding string type (keyword) fields in the configuration data can be selected as detection dimensions. At present, the detection dimensions support selecting up to three fields. Through the combination of fields of multiple detection dimensions, a certain detection object can be determined, and the guance will judge whether the statistical index corresponding to a detection object meets the threshold of trigger conditions, and if it meets the conditions, an event will be generated. (For example, if the instrumentation dimensions "host" and "host_ip" are selected, the instrumentation object can be {host: host1, host_ip: 127.0.0.1}） |

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

[**Android**](../../real-user-monitoring/android/app-data-collection.md) **/** [**IOS**](../../real-user-monitoring/ios/app-data-collection.md) **指标说明**

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


4）**Trigger condition:** Set the trigger condition of alarm level.

![](../img/monitor26.png)

Configure the trigger condition and severity. When the query result is multiple values, an event will be generated if any value meets the trigger condition.

- Event level details refer to [event level description](event-level-description.md) 

**01、Alarm Levels Emergency (Red), Important (Orange), Warning (Yellow) Based on Configuration Condition Judgment Operator.**

- Operator details refer to [operator description](operator-description.md)

**02、Alarm level is normal (green). Information (blue) is based on the number of detections configured. Description is as follows:**

- One test is performed for each test task, if "test frequency = 5 minutes", then one test = 5 minutes
- You can customize the number of tests, such as "Test frequency = 5 minutes", then 3 tests = 15 minutes

**a-Normal (green):** After the detection rules take effect, emergency, important and warning abnormal events are generated, and within the configured custom detection times, the data detection results return to normal, then a recovery alarm event is generated.

???+ attention

    Recovery alarm events are not restricted by [alarm silence](../alert-setting.md). If the recovery alarm event detection number is not set, the alarm event will not recover and will always appear in Events-Unrecovered Event List.

**b-Message (blue):** Normal test results also generate events.

**03、alarm level without data (gray):** No data status supports three configurations: "trigger no data event", "trigger recovery event" and "do not trigger event", and needs to manually configure no data processing strategy.

After the detection rule comes into effect, there is no data detected for the first time and there is no data continuously, and no data alarm event is generated; If there is data detected and the data report is broken within the configured self-defined detection time range, an alarm event without data will be generated.

### Step 2. Event Notification

![](../img/monitor15.png)

5）**Event title:** Set the event name of the alarm trigger condition, and support the use of preset template variables. For details, refer to [template variables](../event-template.md).

6）**Event content:** Event notification content sent when triggering conditions are met, support input of markdown format text information, support preview effect, support use of preset template variables, refer to [template variables](../event-template.md).

???+ attention

    In the latest version, "Monitor Name" will be generated synchronously after entering "Event Title". There may be inconsistencies between "Monitor Name" and "Event Title" in the old monitor. In order to give you a better experience, please synchronize to the latest as soon as possible. Support one-click replacement for event headers.

    Different alarm notification objects support different markdown syntax. For example, enterprise WeChat does not support unordered list.

7）**Alarm strategy:**Send an alarm message to the specified notification object immediately after the monitoring meets the trigger condition. The alarm policy includes the event level to be notified, the notification object, and the alarm silence period. For details, refer to [alarm strategy](../alert-setting.md).

### Step 3. Association

![](../img/monitor13.png)

8）**Associated dashboards:** Each monitor supports associated dashboards, that is, dashboards that can customize quick jumps through the "Associated Dashboards" function (dashboards associated with monitors support quick jumps to view monitoring views).

## Example

Monitor the number of JS errors on the web side of skywalking-web-demo based on the service dimension.

![](../img/example08.png)