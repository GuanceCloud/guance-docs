# Time Series Chart

---

Generally used to display the trend changes of data at equal time intervals, and can also be used to analyze the interaction and impact between multiple sets of metrics data.

Chart types include:

- Line chart (default selected)
- Bar chart
- Area chart

![](../img/timeseries.png)

## Use Cases

1. View the trend changes of APM Metrics data within a certain time range, such as the trend changes in "request count" for an application in the last 15 minutes;
2. View the trend changes of RUM Metrics data within a certain time range, such as the occurrence of "error count" during user visits at different time ranges;
3. View similar trend metrics within a fixed time range;
4. View related events triggered when data fluctuates abnormally.


## Chart Queries

Supports **simple query**, **expression query**, **DQL query**, **Promql query**, and **data source query**. Each query preset returns 5 result counts, including 5, 10, 20, 50, 100, with a default return of 20 data points; manual input is also supported, with a maximum of 100 data points.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Breakpoint Connection

Considering that in time series charts, timestamps are automatically connected. If the data at a certain timestamp is empty, a breakpoint will appear in the chart. By default, <<< custom_key.brand_name >>> automatically connects the data before and after the breakpoint. By setting **Breakpoint Connection**, you can avoid misjudging the breakpoint data.

![](../img/breakpoint.gif)

### Display Return Values

Applicable to Time Series Chart > Bar Chart.

When enabled, specific values will be displayed above the bars. Only the values are shown without units; if decimal places are set to 0, 1, 2, or 3 in **Basic Settings > Data Format**, it follows the specified number of decimal places; if set to "full precision," it defaults to two decimal places; the thousand separator will also sync here.

![](../img/show-value.gif)

### Time Interval {#interval}

This refers to the calculation interval (`interval`) for querying chart data.

For example, when switching the time interval is not available:

<img src="../../img/lock-1.png" width="60%" >
    
:material-numeric-1-circle: Auto Alignment: When enabled, it dynamically adjusts queries based on the selected time range and aggregation interval, rounding up to the nearest value.

The selectable time intervals will be listed based on the maximum number of points you input:

**Note**: When querying `metric` Metrics, the smallest `interval = 10s`.

<img src="../../img/lock-2.png" width="60%" >

:material-numeric-2-circle: Specified Time: Queries are executed according to the selected `interval`. If there's a conflict with the "maximum returned points," it prioritizes adjusting the `interval` based on "time range / maximum points"; includes 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

<img src="../../img/lock-3.png" width="60%" >

???+ abstract "Additional Explanation of Time Interval Logic"

    The system has 18 built-in "time intervals":
    【10ms, 50ms, 100ms, 500ms】
    【1s, 10s, 20s, 30s 】
    【1m, 5m, 10m, 30m】
    【1h, 6h, 12h】
    【1d, 7d, 30d】

    The frontend lists the selectable interval options based on the "maximum returned points" set in **Chart > Advanced Settings** and automatically selects the smallest interval. (If not configured by the user, the default maximum returned points is 720.)

    Assuming a query for the last 3 hours:

    interval=10s, 1080 points > 720 (does not meet criteria)
    interval=20s, 540 points < 720 (meets criteria), so the time series chart's interval defaults to 20s.

    However, if the chart queries Metrics data, the minimum interval is 10s.



### Maximum Returned Points

This refers to the maximum number of data points per series, which can be any integer between 2-1000. If not customized, the default limit is 720 points.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum points, it will calculate the `interval` based on the maximum points and round the data accordingly.

### Line Mixed Chart

Only supports bar charts.

### Year-over-Year and Month-over-Month Comparison

Compares data with the same period from the previous time unit. It is defaulted to be turned off.

#### Comparison Dimensions

When enabled, the comparison dimensions support the following options:

- Hour (compared to one hour ago)
- Day (compared to one day ago)
- Week (compared to one week ago)
- Month (compared to one month ago)
- Month-over-Month

#### Comparison Logic

- **Default Line Chart Query**: Draws based on the selected [start time - end time].

- **Same Period Comparison Line Chart**: Draws by shifting forward the same time range based on the selected comparison dimension.

#### Example

*Using the CPU usage trend of Host A as an example:*

- Choosing comparison dimension as **Hour**: i.e., querying one hour back:

If querying **last 1 hour** (3/2 10:00 - 3/2 11:00) for Host A's CPU usage trend, then the same period comparison query would be (3/2 09:00 - 3/2 10:00) for Host A's CPU usage trend.

If querying **today** (3/2 00:00 - 3/2 11:00) for Host A's CPU usage trend, then the same period comparison query would be (3/1 23:00 - 3/2 10:00) for Host A's CPU usage trend.

- Choosing comparison dimension as **Day**: i.e., querying one day (24h) back:

If querying **last 1 hour** (3/2 10:00 - 3/2 11:00) for Host A's CPU usage trend, then the same period comparison query would be (3/1 10:00 - 3/1 11:00) for Host A's CPU usage trend.

If querying **today** (3/2 00:00 - 3/2 11:00) for Host A's CPU usage trend, then the same period comparison query would be (3/1 00:00 - 3/1 11:00) for Host A's CPU usage trend.

**Note**: When choosing the comparison dimension as **Month**, if querying **3d** (3/28 10:00 - 3/31 10:00) for Host A's CPU usage trend, the same period comparison query would be (2/28 10:00:00 - 2/28 23:59:59) because February does not have 29th, 30th, or 31st.


## Chart Analysis

A time series chart is a two-dimensional graph indexed by time order, with the x-axis representing time scale and the y-axis representing data scale. Based on the selected time range, the time series chart will draw the trend changes of the object data within that time period.

**Note**: A single query statement in a time series chart can return a maximum of 10 Time Series, i.e., based on the grouping (group by) condition results, only the first 10 Time Series are displayed if there are more than 10.

<img src="../../img/f4.png" width="70%" >

### Timeline {#timeline}

In analysis mode, <<< custom_key.brand_name >>> provides a timeline feature, allowing you to preview the interaction between object data and time via the timeline below the chart and drag to select the displayed time range. The timeline range is based on the selected time range, extending three query cycles backward and one query cycle forward (up to the current time point).

For example: If the current time is 11:33 and the time range is set to **last 1 hour**, the timeline range is 【10:33 - 11:33】.

<img src="../../img/f3.png" width="70%" >

#### Similar Trend Metrics {#similar}

In the analysis mode of the time series chart, selecting a trend line/column allows you to **view similar trend metrics**.

Viewing similar trend metrics queries similar metric trends within the selected absolute time range. You can:

- Click and drag on the time series chart to select the search time range;
- Click the "button" to search for similar trend results;
- Click the query results to enter the "Similar Trend Metrics" detail page.

![](../img/18.shixutu_1.png)

#### Similar Trend Results

Based on the selected absolute time range, the query result list includes:

- Source: Measurement sets with similar trends;
- Similar Count: Number of charts under the "Measurement set" with similar trends;
- Preview: Preview images of similar trend charts.

![](../img/18.shixutu_2.png)

**Note**:

1. When querying **similar intervals**, the currently selected time range is treated as **absolute time**, unaffected by any external factors or observers. To change the time range, you need to adjust it manually;

2. After entering the **similar interval** page, you can adjust the search time range by dragging the rectangle. If a region is already selected, you can still move or adjust the selected time range;

3. After dragging to a new time range, you need to confirm/cancel the change of time range.