# Heatmap
---

A heatmap is a data visualization tool that represents the density or intensity of data through variations in color. It is commonly used to display the distribution of data in specific scenarios. <<< custom_key.brand_name >>> applies heatmaps to various monitoring and analysis scenarios, providing visualized aggregated data.

![](../img/scene_heatmap.png)

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Colors

Gradient intervals:

:material-numeric-1-circle: Automatic:
 
- You can choose between 2 to 100 levels, with the system default set to 60.
- Includes 4 gradient color schemes.
- Supports customizing maximum and minimum values; if not set, it automatically calculates based on the returned data's max and min values.

:material-numeric-2-circle: Custom: You can choose between 2 to 5 levels, with the system default set to 5.


### Time

:material-numeric-1-circle: Locked Time: This fixes the time range for querying data in the current chart, unaffected by dashboard or other global time components. After setting, the current chart will directly display the time you have set, such as 【xx minutes】, 【xx hours】, 【xx days】.

:material-numeric-2-circle: Time Interval: The calculation interval (`interval`) for querying data in the chart.
    
- Auto Alignment: When enabled, queries are dynamically adjusted based on the selected time range and aggregation interval, rounding up to the nearest interval.
- Specified Time: Queries are executed based on the selected `interval`. If it conflicts with "Maximum Return Points," it prioritizes adjusting `interval` based on "Time Range / Maximum Points"; includes 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

:material-numeric-3-circle: Maximum Return Points: The maximum number of data points per series, which can be any integer between 2 and 1000. If not customized, the default limit is 720 points.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum points, it will calculate the `interval` based on the maximum points and round up the returned data.

## Advanced Configuration {#advanced-setting}

### Time

1. Locked Time: This fixes the time range for querying data in the current chart, unaffected by dashboard or other global time components. After setting, the current chart will directly display the time you have set, such as 【xx minutes】, 【xx hours】, 【xx days】.

2. Time Interval: The calculation interval (`interval`) for querying data in the chart.
    - Auto Alignment: When enabled, queries are dynamically adjusted based on the selected time range and aggregation interval, rounding up to the nearest interval.
    - Specified Time: Queries are executed based on the selected `interval`. If it conflicts with "Maximum Return Points," it prioritizes adjusting `interval` based on "Time Range / Maximum Points"; includes 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 7 days, and 30 days.

3. Maximum Return Points: The maximum number of data points per series, which can be any integer between 2 and 1000. If not customized, the default limit is 720 points.

**Note**: Based on the selected time interval, if the query range is too large and exceeds the maximum points, it will calculate the `interval` based on the maximum points and round up the returned data.

### Field Mapping

This feature works with object mapping in view variables and is disabled by default. If object mapping is configured in view variables:

- When field mapping is enabled, the chart displays the **grouping fields** and corresponding **mapped fields**, and any grouping fields without specified mappings are not displayed.
- When field mapping is disabled, the chart displays normally without showing mapped fields.

### Workspace Authorization

When enabled, this allows querying data from external workspaces within the current chart of the current workspace.

Below the chart, you can select the target workspace from the authorized workspace dropdown list for querying.

### Data Sampling

Only applicable to workspaces using the Doris log data engine.

When enabled, it samples all data except "Metrics," with a dynamic sampling rate based on data volume.

### Time Offset

Non-time series data may have at least a 1-minute delay after being stored, leading to missing data when querying recent minutes.

Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals to prevent data loss due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, enabling time offset changes the actual query time to 12:14-12:29.

???+ warning "Important Notes"

    1. This setting only applies to relative time queries. If the time range is an absolute time range, the time offset does not take effect.
    2. For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, the time offset does not take effect. It only takes effect when the interval is <= 1 minute. For charts without time intervals, such as overview charts or bar charts, the time offset remains effective.

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