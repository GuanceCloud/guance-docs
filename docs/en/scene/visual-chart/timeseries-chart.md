# Time Series Chart

---

Generally used to display the trend changes of data at equal time intervals, and can also be used to analyze the interaction and influence between multiple sets of metrics data.

The chart types include:

- Line chart (default selected)
- Bar chart
- Area chart

![](../img/timeseries.png)

## Use Cases

1. View the trend changes of application performance metrics data within a certain time range, such as the trend changes in "request counts" within the last 15 minutes;
2. View the trend changes of user access metrics data within a certain time range, such as the occurrence of "error counts" during different time periods;    
3. View similar trend metrics within a fixed time range;
4. View related events triggered when data fluctuations are abnormal.


## Chart Query

Supports **simple query**, **expression query**, **DQL query**, **Promql query**, and **data source query**. Each query presets five return result quantities, including 5, 10, 20, 50, 100, with a default return of 20 data points; manual input is also supported, up to a maximum of 100 data points.

> For more detailed information on chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Style {#style}

If Time Series Chart > Area Chart is selected, you can choose either **Basic Style** or **Stacked Style**.

- Basic: Intuitively displays the trends of each data series, making it easier to observe changes in individual data.
- Stacked: Suitable for multiple data series, where each data series is stacked sequentially. The starting point of each series is based on the ending point of the previous series, making it easier to observe the cumulative effect of overall data.

### Breakpoint Connection

Considering that in the time series chart, time points are automatically connected. If the data for a certain time point is empty, a breakpoint will appear in the chart. By default, <<< custom_key.brand_name >>> will automatically connect the data before and after the breakpoint. Setting **Breakpoint Connection** can avoid judgment errors caused by breakpoint data.

![](../img/breakpoint.gif)

### Display Return Values

Applicable to Time Series Chart > Bar Chart.

When enabled, specific values will be displayed above the bar chart. Only the numerical value is shown here, without units; if the number of decimal places is set to 0, 1, 2, or 3 in **Basic Settings > Data Format**, it follows the set number of decimal places; if the number of decimal places is set to "full precision", then two decimal places are displayed by default; the display of thousand separators will also synchronize here.

![](../img/show-value.gif)

### Time Interval {#interval}

This is the calculation interval (`interval`) for querying chart data.

For example, when switching time intervals is unavailable:

<img src="../../img/lock-1.png" width="60%" >
    
:material-numeric-1-circle: Auto-align: When enabled, queries will dynamically adjust according to the selected time range and aggregation time interval, rounding up to the nearest higher interval based on the calculated time interval.

At this point, selectable time intervals will be listed according to the maximum number of points entered:

**Note**: When there is a `metric` metric query in the query, the smallest preset `interval = 10s`.

<img src="../../img/lock-2.png" width="60%" >

:material-numeric-2-circle: Specify Time: Queries are executed according to the selected `interval`. When conflicting with "maximum return points," it will prioritize adjusting `interval` based on "time range/max points"; includes 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

<img src="../../img/lock-3.png" width="60%" >

???+ abstract "Additional Notes on Time Interval Logic"

    The system has 18 built-in "time intervals":
    【10ms、50ms、100ms、500ms】
    【1s, 10s, 20s, 30s 】
    【1m, 5m, 10m, 30m】
    【1h, 6h, 12h】
    【1d, 7d, 30d】

    The frontend will list the user-selectable interval options based on the "maximum return points" set in **Chart > Advanced Configuration**, and automatically select the smallest time interval. (If not configured by the user, the default maximum return points is 720.)

    Assuming: Querying the most recent 3-hour time range:

    interval=10s, 1080 points >720 (does not meet criteria)
    interval=20s, 540 points < 720 (meets criteria), so the time series chart's interval defaults to 20s.

    However, there is a restriction: if the chart queries metric data, the minimum interval=10s.



### Maximum Return Points

This refers to the maximum number of data points per series, any integer between 2-1000 can be entered arbitrarily. If not customized, the default limit is 720 maximum points.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum number of points, the data will be returned after calculating `interval` and rounding.

### Mixed Line Chart

Only supports bar charts.

### Year-over-Year and Month-over-Month Comparison

Compares data with the same period from the previous hour/day/week/month. Default is turned off.

#### Comparison Dimensions

After enabling, the following comparison dimensions are supported:

- Hour (compared with one hour ago)
- Day (compared with one day ago)
- Week (compared with one week ago)
- Month (compared with one month ago)
- Month-over-month

#### Comparison Logic

- **Default line chart query**: Draws based on the selected [start time - end time].

- **Comparison line chart**: Draws based on the selected comparison dimension, moving forward the same time range.

#### Example

*Using the query for HOST A's CPU usage trend as an example:*

- Selecting comparison dimension 【Hour】: i.e., querying one hour ahead:

If querying 【last 1 hour】 (3/2 10:00 - 3/2 11:00) HOST A’s CPU usage trend, then the comparison query would be (3/2 09:00 - 3/2 10:00) HOST A’s CPU usage trend.

If default query 【today】 (3/2 00:00 - 3/2 11:00) HOST A’s CPU usage trend, then the comparison query would be (3/1 23:00 - 3/2 10:00) HOST A’s CPU usage trend.

- Selecting comparison dimension 【Day】: i.e., querying one day (24h) ahead:

If default query 【last 1 hour】 (3/2 10:00 - 3/2 11:00) HOST A’s CPU usage trend, then the comparison query would be (3/1 10:00 - 3/1 11:00) HOST A’s CPU usage trend.

If default query 【today】 (3/2 00:00 - 3/2 11:00) HOST A’s CPU usage trend, then the comparison query would be (3/1 00:00 - 3/1 11:00) HOST A’s CPU usage trend.

**Note**: When selecting comparison dimension 【Month】, if default query 【3d】 (3/28 10:00 - 3/31 10:00) HOST A’s CPU usage trend, then the comparison query would be (2/28 10:00:00 - 2/28 23:59:59) data, because February does not have 29th, 30th, and 31st.


## Chart Analysis

A time series chart is a two-dimensional graph indexed by time order, with the horizontal axis as the time scale and the vertical axis as the data scale. Based on the selected time range, the time series chart will depict the trend changes of object data within that time period.

**Note**: A single query statement in a time series chart can return up to 10 time series, i.e., according to the results of the grouping (group by) condition, only the first 10 time series will be displayed if there are more than 10.

<img src="../../img/f4.png" width="70%" >

### Time Axis {#timeline}

Additionally, in analysis mode, <<< custom_key.brand_name >>> provides a timeline feature, meaning you can not only preview the interaction changes of object data and time through the timeline below the chart but also drag and select the displayed time range. The timeline range is based on the selected time range as the query cycle, extending three query cycles backward and fixing one query cycle forward (up to the current time point).

For example: Current time is 11:33, time range selected is 【last 1 hour】, so the timeline range is 【10:33 - 11:33】.

<img src="../../img/f3.png" width="70%" >

#### Similar Trend Metrics {#similar}

In the analysis mode of the time series chart, you can **view similar trend metrics** by selecting the trend line/bar of the time series chart.

Viewing similar trend metrics uses the selected time range as absolute time to query similar metric trends within the space. You can:

- On the time series chart, click and drag the mouse to select the search time range;
- Click the "button" to search for similar trend results;
- Click the query result to enter the "similar trend metrics" detail page.

![](../img/18.shixutu_1.png)

#### Similar Trend Results

Based on the selected absolute time range, the query result list includes:

- Source: Measurement sets with similar trends;
- Similar quantity: Number of charts with similar trends under the corresponding "measurement set";
- Preview: Preview image of similar trend charts.

![](../img/18.shixutu_2.png)

**Note**:

1. When querying **similar intervals**, the currently selected time range defaults to 【absolute time】 and will not change due to any external effects or observers. If you need to change the time range, you need to readjust the time range;

2. After entering the **similar interval** page, dragging a rectangle adjusts the search time range. If a region has already been selected, you can still move or adjust the selected time range;

3. After dragging to a new time range, you need to confirm/cancel the replacement of the time range.