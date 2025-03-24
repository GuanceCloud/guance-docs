# Time Series Chart

---

Generally used to display the trend changes of data at equal time intervals, and can also be used to analyze the interaction and impact between multiple groups of metrics data.

Chart types include:

- Line chart (default selected)
- Bar chart
- Area chart

![](../img/timeseries.png)

## Use Cases

1. View the trend changes of application performance metrics data within a certain time range, such as the trend changes in "request numbers" for an application in the last 15 minutes;
2. View the trend changes of user access metrics data within a certain time range, such as the occurrence of "error counts" during different time ranges;
3. View similar trend metrics within a fixed time range;
4. View related events triggered when data fluctuations are abnormal.


## Chart Query

Supports **simple query**, **expression query**, **DQL query**, **Promql query**, and **data source query**. Each query presets 5 result quantity options, including 5, 10, 20, 50, 100, with a default return of 20 data points; manual input is also possible, with a maximum of 100 data points.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Style {#style}

If Time Series Chart > Area Chart is selected, you can choose either **Basic Style** or **Stacked Style**.

- Basic: Displays the trends of each data series intuitively, making it easy to observe changes in single data.
- Stacked: Suitable for multiple data series, where each data series is stacked sequentially based on the previous series' endpoint, facilitating observation of the cumulative effect of overall data.

### Breakpoint Connection

Considering that in time series charts, time points are automatically connected. If the data for a particular time point is empty, there will be a breakpoint in the chart. By default, <<< custom_key.brand_name >>> will automatically connect the data before and after the breakpoint. Configuring **Breakpoint Connection** can prevent judgment errors regarding breakpoint data.

![](../img/breakpoint.gif)

### Display Return Values

Applicable for Time Series Chart > Bar Chart.

When enabled, specific values will be displayed above the bars. Only values are shown here without units; if the number of decimal places is set to 0, 1, 2, 3 in **Basic Settings > Data Format**, the corresponding number of decimal places will be displayed; if "full precision" is selected for decimal places, two decimal places will be displayed by default; the display of thousand separators will synchronize accordingly.

![](../img/show-value.gif)

### Time Interval {#interval}

This refers to the calculation interval (`interval`) for querying chart data.

For example, if switching the time interval is unavailable:

<img src="../../img/lock-1.png" width="60%" >
    
:material-numeric-1-circle: Auto Align: When enabled, queries will dynamically adjust according to the selected time range and aggregation time interval, rounding up to the nearest higher value based on calculated time intervals.

The selectable time intervals will be listed according to the maximum number of points entered:

**Note**: When querying includes `metric` metrics, the smallest preset `interval = 10s`.

<img src="../../img/lock-2.png" width="60%" >

:material-numeric-2-circle: Specified Time: Queries are executed according to the selected `interval`. When conflicting with the "maximum number of returned points", the `interval` will adjust based on "time range/max points". Options include 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

<img src="../../img/lock-3.png" width="60%" >

???+ abstract "Supplementary Explanation of Time Interval Logic"

    The system has 18 built-in "time intervals":
    【10ms、50ms、100ms、500ms】
    【1s, 10s, 20s, 30s 】
    【1m, 5m, 10m, 30m】
    【1h, 6h, 12h】
    【1d, 7d, 30d】

    The frontend will list the available interval options based on the "maximum number of returned points" set in **Chart > Advanced Settings**, and automatically select the smallest time interval. (If not configured by the user, the default maximum number of returned points is 720.)

    Assuming: Querying the last 3 hours time range:

    interval=10s, 1080 points >720 (does not meet criteria)
    interval=20s, 540 points < 720 (meets criteria), so the default interval for the time series chart is 20s.

    However, there is a restriction: If the chart queries metric data, then the minimum interval=10s.



### Maximum Number of Returned Points

This refers to the maximum number of data points per sequence, any integer between 2-1000 can be entered arbitrarily. If not customized, the default limit is 720 points.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum number of points, the data will be returned by calculating the `interval` and rounding up.

### Line Mixed Chart

Only supports bar charts.

### Year-on-Year and Month-on-Month

This compares data from the same time period as the one prior. It is turned off by default.

#### Comparison Dimensions

After enabling, the comparison dimensions support the following options:

- Hour (compared with one hour ago)
- Day (compared with one day ago)
- Week (compared with one week ago)
- Month (compared with one month ago)
- Month-on-Month

#### Comparison Logic

- **Default line chart query**: Draws based on the selected [start time - end time].

- **Concurrent comparison line chart**: Draws by moving back the same time range according to the selected comparison dimension.

#### Example

*Taking the query of HOST A's CPU usage trend as an example:*

- Choosing the comparison dimension 【Hour】: i.e., querying one hour ahead:

If querying 【last 1 hour】 (3/2 10:00 - 3/2 11:00) for HOST A’s CPU usage trend, the concurrent comparison query would be (3/2 09:00 - 3/2 10:00) for HOST A’s CPU usage trend.

If the default query is 【today】 (3/2 00:00 - 3/2 11:00) for HOST A’s CPU usage trend, the concurrent comparison query would be (3/1 23:00 - 3/2 10:00) for HOST A’s CPU usage trend.

- Choosing the comparison dimension 【Day】: i.e., querying one day (24h) ahead:

If the default query is 【last 1 hour】 (3/2 10:00 - 3/2 11:00) for HOST A’s CPU usage trend, the concurrent comparison query would be (3/1 10:00 - 3/1 11:00) for HOST A’s CPU usage trend.

If the default query is 【today】 (3/2 00:00 - 3/2 11:00) for HOST A’s CPU usage trend, the concurrent comparison query would be (3/1 00:00 - 3/1 11:00) for HOST A’s CPU usage trend.

**Note**: When the comparison dimension is 【Month】, if the default query is 【3d】 (3/28 10:00 - 3/31 10:00) for HOST A’s CPU usage trend, the concurrent comparison query would be (2/28 10:00:00 - 2/28 23:59:59) data, because February does not have 29th, 30th, or 31st.


## Chart Analysis

A time series chart is a two-dimensional graph indexed by time order, with the x-axis representing time scale and the y-axis representing data scale. Based on the selected time range, the time series chart will plot the trend changes of object data within that time period.

**Note**: A time series chart query statement returns a maximum of 10 time series. According to the results of the grouping (group by) condition, only the first 10 time series will be displayed if there are more than 10.

<img src="../../img/f4.png" width="70%" >

### Time Axis {#timeline}

Additionally, in analysis mode, <<< custom_key.brand_name >>> provides a time axis feature, allowing you to preview the interaction changes of object data and time through the time axis below the chart, and drag to select the displayed time range. The time axis range is the selected time range as the query cycle, fixed three query cycles forward, and at most one query cycle backward (up to the current time point).

For example: If the current time is 11:33 and the time range is selected as 【Last 1 hour】, then the time axis range is 【10:33 - 11:33】.

<img src="../../img/f3.png" width="70%" >

#### Similar Trend Metrics {#similar}

In the analysis mode of the time series chart, selecting the trend line/bar in the time series chart allows you to **view similar trend metrics**.

Viewing similar trend metrics queries for similar metric trends within the selected time range. You can:

- Click and drag on the time series chart to select the search time range;
- Click the "button" to search for similar trend results;
- Click the query results to enter the "similar trend metrics" detail page.

![](../img/18.shixutu_1.png)

#### Similar Trend Results

Based on the selected absolute time range, the query result list includes:

- Source: Measurement sets with similar trends;
- Similar Count: The number of charts with similar trends under the corresponding "measurement set";
- Preview: Preview images of similar trend charts.

![](../img/18.shixutu_2.png)

**Note**:

1. When querying **similar intervals**, the default selected time range is 【absolute time】 and will not change due to any external factors or observers. To modify the time range, you need to readjust it;

2. After entering the **similar interval** page, clicking and dragging a rectangle adjusts the search time range. If a region has already been selected, you can still move or adjust the selected time range;

3. After dragging to a new time range, you need to confirm/cancel changing the time range.




<!--

## Common Configurations


| <div style="width: 120px">Options</div> | Description |
| --- | --- |
| Title | Set a title name for the chart. After setting, it will be displayed in the top left corner of the chart and supports hiding.|
| Description | Add description information to the chart. After setting, an 【i】 prompt will appear after the chart title. If not set, it will not be displayed. |
| Stacking | Only supports bar charts, default is off.<br /><li>Percentage: Each layer of the bar represents the percentage of the category data relative to the total data of the group, and each series is stacked according to the percentage. |
| Unit | **:material-numeric-1-box: Default unit display**:<br /><li>If the queried data is metric data and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), it will display according to the unit of the metric;<br /><li>If no relevant unit configuration exists in **Metric Management**, it will display using the [thousand separator](chart-query.md#thousand) comma-separated numerical progression method.<br />**:material-numeric-2-box: After configuring units**:<br />It prioritizes displaying using your custom-configured unit, supporting two options for numeric values in metric data:<br /><br />**Scientific Notation Explanation**<br /><u>Default Progression</u>: Units are in ten thousand, million, etc., e.g., 10000 displays as 1 ten thousand, 1000000 displays as 1 million. Retains two decimal places;<br /><u>Short Scale System</u>: Units are K, M, B. That is, they represent thousand, million, billion, trillion, etc. For instance, 1000 is 1 k, 10000 is 10 k, 1000000 is 1 million; retains two decimal places.|
| Color | Set the display color of the chart data, supports custom manual input of preset colors, input format is: aggregate function(metric){"label": "label value"}, such as `last(usage_idle){"host": "guance_01"}`. |
| Legend | For more details, refer to [Legend Description](#legend). |
| Data Format | You can choose the number of decimal places and the use of thousands separators.<br /><li>The thousands separator is enabled by default; disabling it shows the raw value without separators. More details can be found in [Data Thousands Separator Format](../visual-chart/chart-query.md#thousand). |
| Y-Axis | Supports customizing the maximum and minimum values of the Y-axis. |


## Advanced Configuration {#advanced-setting}

| <div style="width: 100px">Options</div> | Description |
| --- | --- |
| Lock Time | Fixes the time range for the current chart query data, unaffected by the global time component. After successful setup, the user-defined time will appear in the top right corner of the chart, such as 【xx minutes】, 【xx hours】, 【xx days】.<br /><font size=2>* (Effect display reference image below.* )</font> |
| Baseline Setting | Supports adding baseline values, baseline titles, and baseline colors. |
| Field Mapping | Cooperates with the object mapping function of view variables, default is off. If object mapping has been configured in view variables:<br /><li>Enabling field mapping displays the queried **group fields** and corresponding **mapped fields**, unassigned group fields are not displayed;<br /><li>Disabling field mapping displays the chart normally without showing mapped fields.<br /> |
| Workspace Authorization | Authorized workspace lists; after selection, you can query and display data from this workspace via the chart. |
| Data Sampling | Only applies to Doris log data engine workspaces; when enabled, it samples all data except "metrics," with sampling rates dynamically adjusting based on data volume. |
| Time Offset | Non-time-series data has at least a 1-minute query delay after being stored. Selecting relative time queries may result in the most recent few minutes of data not being collected, causing data loss.<br />Enabling time offset ensures that when querying relative time ranges, the actual query range shifts 1 minute forward to prevent data acquisition gaps caused by storage delays. For example: if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time is: 12:14-12:29.<br />:warning: <br /><li>This setting only affects relative times. If the query time range is an "absolute time range," time offset does not take effect.<br /><li>For charts with time intervals, such as time series charts, time offset does not take effect if the set time interval exceeds 1 minute, and only takes effect when <= 1 minute. For charts without time intervals, such as summary charts and bar charts, time offset remains effective.|


## Example Charts

Below are line charts, bar charts, and area charts showing the trend changes in host CPU usage over the last 15 minutes:

![](../img/8.scene_time_1.gif)


## Chart Links

Links can help achieve navigation from the current chart to the target page. You can add internal platform links or external links, modifying corresponding variable values in the link using template variables to pass data information and enable data interactivity.

> For more related settings, refer to [Chart Links](chart-link.md).

## Event Association

By **adding filter fields** to match related anomaly events to the selected fields, achieving the purpose of associating time series data with events. This function helps you perceive whether there are related events during data fluctuations while viewing trends, assisting you in locating issues from another perspective.

> For more related settings, refer to [Event Association](events-relative.md).
> -->