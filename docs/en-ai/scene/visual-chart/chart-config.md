# Chart Configuration

---

This section includes common and advanced configurations for charts.

## Common Configurations {#general}

### Title

:material-numeric-1-circle: **Title**: Set a title for the chart. After setting, it will be displayed in the top-left corner of the chart. You can choose to hide it.

:material-2-circle: **Description**: Add a description to the chart. After setting, an [i] prompt will appear after the chart title; if not set, it will not be displayed.

Based on <<< custom_key.brand_name >>>'s large model natural language generation capabilities, you can use the "Auto Generate" function to quickly generate semantically appropriate titles and descriptions for the chart.

![Chart Configuration](../../img/chart-config-ai.png)

### Units

:material-numeric-1-circle: **Global**: Includes common unit formats across different dimensions, such as data size, time intervals, and timestamps. You can input custom units in the dropdown box and press Enter to apply them to the current chart.

:material-numeric-2-circle: **Custom**: Select the metrics included under the current query conditions and input custom units.

???+ abstract "About Unit Display for Metric Data"

    1. **Default Unit Display**:
        - If the queried data is metric data and you have set units for the metrics in [Metric Management](../../metrics/dictionary.md), the default display will follow the metric's unit settings.
        - If no related unit configuration exists in **Metric Management**, the data will be displayed using thousand separators (as described in [chart-query.md#thousand](chart-query.md#thousand)).

    2. **After Setting Units**: The configured custom units take precedence. For metric data, two options are available for number formatting:
        
        - **Default Scaling**: Units are in thousands, millions, etc., e.g., 10,000 displays as 10K, 1,000,000 displays as 1M. Two decimal places are retained.
        - **Short Scale**: Units are K, M, B, representing thousand, million, billion, trillion, etc. For example, 1,000 is 1k, 10,000 is 10k, and 1,000,000 is 1M. Two decimal places are retained.


### Legend {#legend}

:material-numeric-1-circle: **Alias**: After adding an alias, the legend name changes accordingly, making it easier to distinguish related metrics.

Aliases support template variables for one-click replacement:

- `{tags}` replaces with all "tag names" and "tag values";
- `{host}` replaces with the "tag value" of `host`;
- `{__name__}` replaces with all metric names.

*Example scenarios based on metric aliases:*

Without adding an alias:

![Legend Without Alias](../../img/alias-1.png)

Effect of replacing with plain text:

![Legend With Plain Text](../../img/alias-2.png)

Using the variable `{tags}` based on the `by` condition:

**Note**: When your query contains a `by` condition, all legend series returned will be displayed.

![Legend With Tags](../../img/alias-3.png)

:material-numeric-2-circle: **Position**: Currently supports hiding, bottom, or right-side legends (clicking on a legend item hides/shows the corresponding metric).

:material-3-circle: **Displayed Value**: Choose which values or calculated values to display in the legend.

For time series charts, legend values are aggregated based on chart query results. Options include `Last (last value)`, `First (first value)`, `Avg (average)`, `Min (minimum)`, `Max (maximum)`, `Sum (sum)`, `Count (number of points)`.

As shown below, `First` returns the first value from the current time series query result, while `Last` returns the last value. Clicking on the legend value allows sorting in ascending/descending order.

**Note**: `Avg`, `Sum`, and `Count` display different results based on the selected time interval (original interval and auto-alignment).

![Legend Values](../../img/chart030.png)

### Data Format {#data_format}

:material-numeric-1-circle: **Decimal Places**: Choose between 0, 1, 2, 3 decimal places, or full precision.

:material-numeric-2-circle: **Thousand Separator**: Enabled by default; when disabled, the original value is displayed without separators.

<<< custom_key.brand_name >>> dashboard chart query results support automatic thousand separator formatting.

![](../img/13.table_1.png)

If units are set, the data format follows the set units.

![](../img/13.table_2.png)

After setting, preview the chart with thousand separator formatting, or according to the specified unit format.

- Thousand separator formatting:

![Thousand Separator Formatting](../../img/13.table_4.png)

- Specified data format:

![Specified Data Format](../../img/13.table_5.png)


## Advanced Configurations

### Lock Time Range

Fixes the time range for the current chart query, independent of the global time component. After setting, the user-defined time will appear in the top-right corner of the chart, e.g., [xx minutes], [xx hours], [xx days]. For example, if the locked time interval is 30 minutes, even adjusting the time widget will only display data from the last 30 minutes.

### Rule Mapping

Set the metric ranges and corresponding background and font colors for different columns. Metrics within the set range will be displayed according to the defined styles.

Set metric ranges and mapping values; when the metric value falls within the set range, it will display the corresponding mapped value.

When multiple settings are met simultaneously, the last matching style will be applied.

When setting value mappings, both the **Display As** and **Color** fields are optional:

- **Display As** defaults to empty, meaning no mapped value is shown;
- **Color** defaults to empty, meaning the original color is used.

### Field Mapping

In practical business scenarios, if the fields to be queried differ from those displayed on the front end, you can enable field mapping in the chart. This feature works with object mapping in view variables and is disabled by default.

After enabling field mapping, the chart displays the **grouped fields** and their corresponding **mapped fields**. Ungrouped fields without specified mappings are not displayed.

### Workspace Authorization

When enabled, you can query data from external workspaces within the current workspace's chart.

Below the chart, select the target workspace from the authorized workspaces dropdown list for querying.

### Data Sampling

Applicable only to workspaces using the Doris log data engine.

When enabled, sampling queries are performed on non-metric data, with a dynamic sampling rate based on data volume.

### Time Offset

Non-time series data may have at least a 1-minute delay after being stored. When selecting relative time queries, this can lead to missing recent data.

Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data gaps due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time is 12:14-12:29.

**Note**:

1. This setting applies only to relative time queries. For absolute time ranges, time offset does not apply.
2. For charts with time intervals, like time series charts, if the set time interval exceeds 1 minute, time offset does not apply. For charts without time intervals, such as summary charts and bar charts, time offset remains effective.