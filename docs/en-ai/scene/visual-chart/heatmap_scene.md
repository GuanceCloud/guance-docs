# Heatmap
---

A heatmap is a data visualization tool that represents the density or intensity of data through changes in color. It is commonly used to display the distribution of data in specific scenarios. Guance applies heatmaps to various monitoring and analysis scenarios, visualizing aggregated data.

![](../img/scene_heatmap.png)

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Colors

Gradient range:

:material-numeric-1-circle: Automatic:
 
- You can choose a number of levels ranging from 2 to 100; the system default is 60.
- Includes 4 gradient color schemes.
- Supports custom maximum and minimum values; if not set, it automatically obtains the maximum and minimum values from the returned data.

:material-numeric-2-circle: Custom: Choose a number of levels ranging from 2 to 5; the system default is 5.


### Time

:material-numeric-1-circle: Locked Time: This fixes the time range for querying data on the current chart, independent of the dashboard or other global time components. After setting this successfully, the current chart will directly display the time you have set, such as 【xx minutes】, 【xx hours】, 【xx days】.

:material-numeric-2-circle: Time Interval: This is the calculation interval (`interval`) for querying data on the chart.
    
- Auto Alignment: When enabled, it dynamically adjusts queries based on the selected time range and aggregation interval, rounding up to the nearest time interval.
- Specified Time: Queries are executed according to the selected `interval`. If it conflicts with "Maximum Return Points," it prioritizes adjusting the `interval` based on "Time Range / Maximum Points"; includes intervals of 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

:material-numeric-3-circle: Maximum Return Points: This is the maximum number of data points per series, which can be any integer between 2 and 1000. If not customized, the default maximum point limit is 720.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum number of points, it will calculate the `interval` based on the maximum number of points and round it up to return data.

<!--
### [Legend](./timeseries-chart.md#legend)

1. Adding an alias changes the legend name accordingly;
2. Selecting the legend position, including hiding it or placing it at the bottom of the chart.


### Units

???+ abstract "About unit display for metric data"

    :material-numeric-1-circle: Default Unit Display:

    - If the queried data is metric data and you have set units for metrics in [Metric Management](../../metrics/dictionary.md), it defaults to displaying the data using the configured units.
    - If no related unit configuration exists in **Metric Management**, it displays the data using comma-separated thousand separators.

    :material-numeric-2-circle: After Configuring Units: It prioritizes displaying the data using your custom-configured units. Metric data supports two options for formatting numbers:
    
    - Default Scaling: Units are in ten thousand, million, etc., e.g., 10000 displayed as 1 ten thousand, 1000000 displayed as 1 million; retains two decimal places.
    - Short Scale: Units are K, M, B. Represents thousand, million, billion, trillion in Chinese context. E.g., 1000 as 1K, 10000 as 10K, 1000000 as 1M; retains two decimal places.


- Global:

Includes universal unit formats across different dimensions, such as data size, time intervals, timestamps, etc.

In this mode, you can also select and input custom units from a dropdown menu, which will apply to the current chart upon pressing Enter.


- Custom: Choose the metrics included under the current query conditions and input custom units.



### Data Formatting

1. Decimal Places: Choose 0, 1, 2, 3 decimal places, or full precision.

2. [Thousand Separator](../visual-chart/chart-query.md#thousand): The thousand separator is enabled by default. Disabling it shows the raw value without separators.

## Advanced Settings {#advanced-setting}

### Time

1. Locked Time: Fixes the time range for querying data on the current chart, independent of the dashboard or other global time components. After setting this successfully, the current chart will directly display the time you have set, such as 【xx minutes】, 【xx hours】, 【xx days】.

2. Time Interval: This is the calculation interval (`interval`) for querying data on the chart.
    - Auto Alignment: When enabled, it dynamically adjusts queries based on the selected time range and aggregation interval, rounding up to the nearest time interval.
    - Specified Time: Queries are executed according to the selected `interval`. If it conflicts with "Maximum Return Points," it prioritizes adjusting the `interval` based on "Time Range / Maximum Points"; includes intervals of 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

3. Maximum Return Points: This is the maximum number of data points per series, which can be any integer between 2 and 1000. If not customized, the default maximum point limit is 720.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum number of points, it will calculate the `interval` based on the maximum number of points and round it up to return data.

### Field Mapping

This feature enables object mapping with view variables and is disabled by default. If object mapping has been configured in the view variables:

- When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not displayed.
- When field mapping is disabled, the chart displays normally without showing mapped fields.

### Workspace Authorization

When enabled, it allows querying data from external workspaces within the current chart in the current workspace.

Below the chart, you can select the target workspace from the authorized workspace dropdown list for querying.

### Data Sampling

Applicable only to Doris log data engine workspaces.

When enabled, it samples queries for data other than "Metrics." The sampling rate is not fixed and dynamically adjusts based on the data volume.


### Time Offset

Non-time series data may have at least a 1-minute query delay after being stored. When selecting relative time queries, it might result in recent minutes' data not being collected, leading to data loss.

Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals to prevent data retrieval from being empty due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset means the actual query time is 12:14-12:29.

???+ warning "Notes"

    1. This setting only applies to relative time ranges. If the query time range is an "absolute time range," the time offset does not take effect.
    2. For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, the time offset does not take effect. It only takes effect for intervals <= 1 minute. For charts without time intervals, such as summary charts or bar charts, the time offset remains effective.

-->

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Chart Query**</font>](./chart-query.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Chart Link**</font>](./chart-link.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Chart JSON**</font>](./chart-json.md)

</div>

</font>