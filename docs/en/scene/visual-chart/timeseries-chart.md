# Time Series Chart

---

Generally used to display the trend changes of data at equal time intervals, and can also be used to analyze the effects and impacts between multiple groups of metrics data.

Chart types include:

- Line chart (default selected)
- Bar chart
- Area chart

![](../img/timeseries.png)

## Use Cases

- View the trend changes of application performance metrics data within a certain time range, such as the trend changes in "request counts" within the last 15 minutes;
- View the trend changes of user access metrics data within a certain time range, such as the occurrence of "error counts" during different time ranges;
- View similar trend metrics within fixed time ranges;
- View related events triggered when data fluctuations are abnormal.


## Chart Queries

Supports **simple queries**, **expression queries**, **DQL queries**, **Promql queries**, and **data source queries**. Each query presets five return result quantities: 5, 10, 20, 50, 100; by default, it returns 20 data entries; manual input is also supported, with a maximum of 100 data entries.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Style {#style}

#### Line Chart {#line-chart}

Four styles can be chosen: linear, smooth, pre-step, post-step.

<img src="../../img/line_chart_style.png" width="70%" >

#### Area Chart

Two styles can be chosen:

- Basic: Intuitively displays the trends of each data series, making it easy to observe changes in individual data.
- Stacked: Suitable for multiple data series, where each data series is stacked sequentially. The starting point of each series is based on the end point of the previous series, making it easy to observe the cumulative effect of overall data.



### Breakpoint Connection

Considering that in time series charts, time points are automatically connected. If the data at a certain time point is empty, a breakpoint will appear in the chart at this point. By default, <<< custom_key.brand_name >>> will automatically connect the data before and after the breakpoint. By setting **breakpoint connection**, you can avoid judgment errors caused by breakpoint data.

![](../img/breakpoint.gif)

### Display Return Values

Applicable to time series > bar chart.

When enabled, specific values will be displayed above the bars. Here only the numerical value is shown, not the unit; if the number of decimal places is set to 0, 1, 2, or 3 in **Basic Settings > Data Format**, the number of decimal places follows the setting; if the number of decimal places is set to "full precision", then two decimal places are displayed by default; the display of thousand separators will also synchronize here.

![](../img/show-value.gif)

### Time Interval {#interval}

That is, the calculation interval (`interval`) for querying chart data.

For example, if you cannot switch the time interval at this moment:

<img src="../../img/lock-1.png" width="60%" >
    
:material-numeric-1-circle: Auto Align: When enabled, the query will dynamically adjust according to the selected time range and aggregation time interval, rounding up to the nearest calculated time interval.

The selectable time intervals will be listed based on the maximum number of points you enter:

**Note**: When there is a `metrics` query in the query, the smallest preset `interval = 10s`.

<img src="../../img/lock-2.png" width="60%" >

:material-numeric-2-circle: Specified Time: Executes queries according to the selected `interval`. When conflicting with the "maximum number of return points," it adjusts the `interval` according to "time range / maximum number of points"; includes 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

<img src="../../img/lock-3.png" width="60%" >

???+ abstract "Additional Explanation on Time Interval Logic"

    The system has 18 built-in "time intervals":
    【10ms、50ms、100ms、500ms】
    【1s, 10s, 20s, 30s 】
    【1m, 5m, 10m, 30m】
    【1h, 6h, 12h】
    【1d, 7d, 30d】

    The frontend will list the user-selectable interval options based on the "maximum number of return points" set in **Chart > Advanced Settings** and automatically select the smallest time interval. (If the user does not configure it, the default maximum number of return points is 720.)

    Assuming: Querying the latest 3-hour time range:

    interval=10s, 1080 points >720 (not eligible)
    interval=20s, 540 points < 720 (eligible), so the interval for the time series chart defaults to 20s.

    However, there is a restriction: If the chart queries metric data, then the minimum interval=10s. 



### Maximum Number of Return Points

That is, the maximum number of data points per series, any integer between 2-1000 can be entered arbitrarily. If you do not customize it, the default maximum number of points is limited to 720.

**Note**: Based on the already selected time interval, if the query range is too large and exceeds the maximum number of points, the data will be returned after calculating the `interval` and rounding.

### Line Mixed Chart

Only supports bar charts.

### Year-over-Year and Month-over-Month Comparison

Compares with the same period of time data. It is defaulted to be turned off.

#### Comparison Dimensions

After enabling, the comparison dimensions support the following options:

- Hour (compared with one hour ago)
- Day (compared with one day ago)
- Week (compared with one week ago)
- Month (compared with one month ago)
- Month-over-Month Comparison

#### Comparison Logic

- **Default queried line chart**: Drawn based on the selected [start time - end time].

- **Year-over-year compared line chart**: Drawn by moving forward the same time range based on the selected comparison dimension.

#### Example

*Using the query of host A's CPU usage rate trend as an example:*

- Selecting the comparison dimension as [Hour]: i.e., querying one hour earlier:

If querying [the past 1 hour] (3/2 10:00 - 3/2 11:00) for host A's CPU usage rate trend, then the year-over-year comparison query would be (3/2 09:00 - 3/2 10:00) for host A's CPU usage rate trend.

If the default query is [today] (3/2 00:00 - 3/2 11:00) for host A's CPU usage rate trend, then the year-over-year comparison query would be (3/1 23:00 - 3/2 10:00) for host A's CPU usage rate trend.

- Selecting the comparison dimension as [Day]: i.e., querying one day (24 hours) earlier:

If the default query is [the past 1 hour] (3/2 10:00 - 3/2 11:00) for host A's CPU usage rate trend, then the year-over-year comparison query would be (3/1 10:00 - 3/1 11:00) for host A's CPU usage rate trend.

If the default query is [today] (3/2 00:00 - 3/2 11:00) for host A's CPU usage rate trend, then the year-over-year comparison query would be (3/1 00:00 - 3/1 11:00) for host A's CPU usage rate trend.

**Note**: When selecting the comparison dimension as [Month], if the default query is [3d] (3/28 10:00 - 3/31 10:00) for host A's CPU usage rate trend, then the year-over-year comparison query would be (2/28 10:00:00 - 2/28 23:59:59) data, because February does not have 29th, 30th, and 31st.


## Chart Analysis

A time series chart is a two-dimensional graph indexed by time order, with the horizontal axis representing time scale and the vertical axis representing data scale. Based on the selected time range, the time series chart will plot the trend changes of object data within that time period.

**Note**: A single query statement in a time series chart can return up to 10 timelines, i.e., according to the results of the grouping (group by) condition, only the first 10 timelines will be displayed in order if there are more than 10 timelines.

<img src="../../img/f4.png" width="70%" >

### Timeline {#timeline}

Also, in analysis mode, <<< custom_key.brand_name >>> provides a timeline feature, meaning you can not only preview the interaction changes of object data and time through the timeline below the chart but also drag and select the time range to display. The timeline range is based on the selected time range as the query cycle, fixed three query cycles backward, and up to one query cycle forward (up to the current time point).

For example: If the current time point is 11:33 and the time range is selected as [the past 1 hour], then the timeline range is [10:33 - 11:33].

<img src="../../img/f3.png" width="70%" >

#### Similar Trend Metrics {#similar}

In the analysis mode of the time series chart, selecting the trend line/bar of the time series chart allows you to **view similar trend metrics**.

Viewing similar trend metrics uses the time range you select as absolute time, querying similar metric trends within the space. You can:

- On the time series chart, click the chart and drag the mouse to select the search time range;
- Click the "button" to search for similar trend results;
- Click the query result to enter the "similar trend metrics" detail page.

![](../img/18.shixutu_1.png)

#### Similar Trend Results

Based on the selected absolute time range, the query result list includes:

- Source: Measurement sets with similar trends;
- Similar quantity: The number of charts under the corresponding "measurement set" with similar trends;
- Preview: Preview images of similar trend charts.

![](../img/18.shixutu_2.png)

???+ warning "Note"

    - When querying **similar intervals**, the currently selected time range defaults to [absolute time], which will not change due to any external factors or observer actions. If you need to change the time range, you need to re-adjust the time range;

    - After entering the **similar interval** page, you can adjust the search time range by dragging the rectangle. If a region has been selected, you can still move or adjust the selected time range;

    - After dragging to a new time range, you need to confirm/cancel the replacement of the time range.