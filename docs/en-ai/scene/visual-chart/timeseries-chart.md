# Time Series Chart

---

Generally used to display the trend changes of data at equal time intervals, and can also be used to analyze the interaction and impact between multiple sets of metrics data.

The chart types include:

- Line Chart (default selected)
- Bar Chart
- Area Chart

![](../img/timeseries.png)

## Application Scenarios

1. View the trend changes of APM Metrics data within a certain time range, such as the trend changes in "request counts" in the last 15 minutes;
2. View the trend changes of RUM Metrics data within a certain time range, such as the occurrence of "error counts" during different time periods;
3. View similar trend metrics within a fixed time range;
4. View related events triggered when data fluctuates abnormally.

## Chart Queries

Supports **simple queries**, **expression queries**, **DQL queries**, **PromQL queries**, and **data source queries**. Each query preset has five return result quantities: 5, 10, 20, 50, and 100, with a default return of 20 results; manual input is also supported, with a maximum of 100 results.

> For more detailed explanations on chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Breakpoint Connection

Considering that in a time series chart, time points are automatically connected. If the data for a certain time point is empty, there will be a breakpoint in the chart. By default, Guance automatically connects the data before and after the breakpoint. By setting **Breakpoint Connection**, you can avoid misjudgments caused by breakpoint data.

![](../img/breakpoint.gif)

### Display Return Values

Applicable to Time Series Chart > Bar Chart.

When enabled, specific values will be displayed above the bars. Only the values are shown, not the units. If the decimal places in **Basic Settings > Data Format** are set to 0, 1, 2, or 3, the displayed values will follow these settings. If set to "full precision," two decimal places are displayed by default. The thousands separator will also be synchronized here.

![](../img/show-value.gif)

### Time Interval

This refers to the calculation interval (`interval`) for querying chart data.

For example, if you cannot switch time intervals:

<img src="../../img/lock-1.png" width="60%" >

:material-numeric-1-circle: Auto Alignment: When enabled, the query adjusts dynamically based on the selected time range and aggregation interval, rounding up to the nearest interval.

At this point, selectable time intervals will be listed based on the maximum number of points you enter:

**Note**: When querying `Metrics`, the smallest `interval` is fixed at 10 seconds.

<img src="../../img/lock-2.png" width="60%" >

:material-numeric-2-circle: Specified Time: Queries are executed according to the selected `interval`. If it conflicts with the "maximum return points," it prioritizes adjusting the `interval` based on "time range/max points." Includes intervals like 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

<img src="../../img/lock-3.png" width="60%" >

???+ abstract "Additional Explanation on Time Interval Logic"

    The system has 18 built-in "time intervals":
    【10ms, 50ms, 100ms, 500ms】
    【1s, 10s, 20s, 30s】
    【1m, 5m, 10m, 30m】
    【1h, 6h, 12h】
    【1d, 7d, 30d】

    The frontend lists selectable intervals based on the "maximum return points" set in **Chart > Advanced Settings** and automatically selects the smallest interval. (If not configured by the user, the default maximum return points is 720.)

    Assuming a query for the last 3 hours:

    interval=10s, 1080 points > 720 (not compliant)
    interval=20s, 540 points < 720 (compliant), so the time series chart's interval defaults to 20s.

    However, there's a restriction: if the chart queries Metrics data, the minimum interval is 10s.


### Maximum Return Points

This refers to the maximum number of data points per series, which can be any integer between 2 and 1000. If not customized, the default limit is 720 points.

**Note**: Based on the selected time interval, if the query range exceeds the maximum points, it will calculate the `interval` and round up the returned data.

### Line Mixed Chart

Supported only for bar charts.

### Year-over-Year and Month-over-Month Comparison

This compares data with the same time period from the previous period. Default is set to off.

#### Comparison Dimensions

When enabled, comparison dimensions support the following options:

- Hour (compared to one hour ago)
- Day (compared to one day ago)
- Week (compared to one week ago)
- Month (compared to one month ago)
- Month-over-Month

#### Comparison Logic

- **Default Line Chart Query**: Draws based on the selected [start time - end time].

- **Comparative Line Chart**: Draws based on the selected comparison dimension, shifting forward by the same time range.

#### Example

*Using the CPU usage trend of host A as an example:*

- Comparison Dimension chosen as 【Hour】: i.e., query one hour back:

If querying 【last 1 hour】 (3/2 10:00 - 3/2 11:00) for host A’s CPU usage trend, the comparative query would be (3/2 09:00 - 3/2 10:00) for host A’s CPU usage trend.

If querying 【today】 (3/2 00:00 - 3/2 11:00) for host A’s CPU usage trend, the comparative query would be (3/1 23:00 - 3/2 10:00) for host A’s CPU usage trend.

- Comparison Dimension chosen as 【Day】: i.e., query one day (24 hours) back:

If querying 【last 1 hour】 (3/2 10:00 - 3/2 11:00) for host A’s CPU usage trend, the comparative query would be (3/1 10:00 - 3/1 11:00) for host A’s CPU usage trend.

If querying 【today】 (3/2 00:00 - 3/2 11:00) for host A’s CPU usage trend, the comparative query would be (3/1 00:00 - 3/1 11:00) for host A’s CPU usage trend.

**Note**: When choosing 【Month】 as the comparison dimension, if querying 【3 days】 (3/28 10:00 - 3/31 10:00) for host A’s CPU usage trend, the comparative query would be (2/28 10:00:00 - 2/28 23:59:59) because February does not have 29th, 30th, or 31st.


## Chart Analysis

A time series chart is a two-dimensional graph indexed by time order, with the x-axis representing time scale and the y-axis representing data scale. Based on the selected time range, the time series chart plots the trend changes of object data within that time frame.

**Note**: A single query statement in a time series chart can return up to 10 Time Series. If more than 10 Time Series are obtained based on grouping conditions, only the first 10 Time Series are displayed in sequence.

<img src="../../img/f4.png" width="70%" >

### Time Axis

In analysis mode, Guance provides a time axis feature, allowing you to preview object data and time interaction changes via the time axis below the chart, and drag to select the displayed time range. The time axis range is based on the selected time range as the query cycle, extending three cycles backward and one cycle forward (up to the current time point).

For example, if the current time is 11:33 and the time range is selected as 【last 1 hour】, the time axis range would be 【10:33 - 11:33】.

<img src="../../img/f3.png" width="70%" >

#### Similar Trend Metrics {#similar}

In the analysis mode of a time series chart, selecting a trend line/column allows you to **view similar trend metrics**.

Viewing similar trend metrics queries similar metric trends within the selected absolute time range. You can:

- Click and drag on the time series chart to select the search time range;
- Click the "button" to search for similar trend results;
- Click on the query results to enter the "Similar Trend Metrics" detail page.

![](../img/18.shixutu_1.png)

#### Similar Trend Results

Based on the selected absolute time range, the query result list includes:

- Source: Metric sets with similar trends;
- Similar Count: Number of charts with similar trends under the corresponding "Metric Set";
- Preview: Preview images of similar trend charts.

![](../img/18.shixutu_2.png)

**Note**:

1. When querying **similar intervals**, the currently selected time range is treated as 【absolute time】 and remains unchanged regardless of external influences. To change the time range, you need to adjust it manually;

2. After entering the **similar intervals** page, you can adjust the search time range by dragging the rectangle. If a region is already selected, you can still move or adjust the selected time range;

3. After dragging to a new time range, you need to confirm or cancel the change in time range.