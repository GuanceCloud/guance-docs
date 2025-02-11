# Chart Configuration

---

This document includes common and advanced configurations for charts in Guance.

## Common Configurations {#general}

### Title

:material-numeric-1-circle: Title: Set a title for the chart. Once set, it will be displayed at the top-left corner of the chart, and supports hiding.

:material-numeric-2-circle: Description: Add a description to the chart. After setting, an [i] icon will appear after the chart title; if not set, it will not be displayed.

### Units

:material-numeric-1-circle: Global: Includes common unit formats across different dimensions, such as data size, time intervals, timestamps, etc. You can input custom units in the dropdown box, press Enter, and they will be applied to the current chart.

:material-numeric-2-circle: Custom: Select the metrics included under the current query conditions and input custom units.

???+ abstract "About Unit Display for Metric Data"

    1. Default Unit Display:

        - If the queried data is metric data and you have set units for the metrics in [Metrics Management](../../metrics/dictionary.md), the default display will follow the metric's unit.
        - If no unit configuration exists in **Metrics Management**, it will display using the [thousand separator](chart-query.md#thousand) with comma-separated values.

    2. After Setting Units: It prioritizes the custom units you configure. For metric data, two options are supported for numerical values:
        
        - Default Scaling: Units are ten thousand, million, e.g., 10,000 displays as 10K, 1,000,000 displays as 1M. Retains two decimal places.
        - Short Scale: Units are K, M, B. These represent thousand, million, billion, trillion in Chinese context. For example, 1,000 is 1k, 10,000 is 10k, 1,000,000 is 1M; retains two decimal places.

### Legend {#legend}

:material-numeric-1-circle: Alias: After adding an alias, the legend name changes accordingly, making it easier to distinguish related metrics.

Aliases support template variables for one-click replacement, such as:

- `{tags}` replaces with all "tag names" and "tag values";
- `{host}` replaces with the "tag value" of `host`;
- `{__name__}` replaces with all metric names.

*Example scenarios based on metrics:*

Without alias:

<img src="../../img/alias-1.png" width="60%" > 

Text replacement effect:

<img src="../../img/alias-2.png" width="60%" > 

Using variable `{tags}` with `by` condition:

**Note**: When your query contains a `by` condition, it will display all legend series returned.

<img src="../../img/alias-3.png" width="60%" >

:material-numeric-2-circle: Position: Currently supports hiding, bottom, or right-side legend (clicking on a legend item hides/shows the corresponding metric).

:material-numeric-3-circle: Display Value: Choose which values or calculated values to show in the legend.

For time series charts, legend values are recalculated based on the chart query results. Supported options include `Last (last value)`, `First (first value)`, `Avg (average)`, `Min (minimum)`, `Max (maximum)`, `Sum (sum)`, `Count (number of points)`.

As shown below: `First` returns the first value of the current time series query result, `Last` returns the last value. Clicking on the legend value supports ascending/descending sorting.

**Note**: `Avg`, `Sum`, `Count` display different results based on the selected time interval (original interval and automatic alignment).

<img src="../../img/chart030.png" width="70%" >

### Data Format {#data_format}

:material-numeric-1-circle: Decimal Places: Choose 0, 1, 2, 3 decimal places, or full precision.

:material-numeric-2-circle: Thousand Separator: Enabled by default; disabling shows raw values without separators.

Guance dashboard chart query results support automatic thousand separator formatting.

![](../img/13.table_1.png)

If units are set, data format follows the set units.

![](../img/13.table_2.png)

After setting, previewed data formats according to thousand separator settings, or according to unit settings if units are specified.

- Thousand separator data format:

<img src="../../img/13.table_4.png" width="70%" >

- Set data format:

<img src="../../img/13.table_5.png" width="70%" >

## Advanced Configurations

### Lock Time Range

Fixes the time range for querying data in the current chart, unaffected by the global time component. After setting, the chart's top-right corner will display the user-defined time, e.g., ["xx minutes"], ["xx hours"], ["xx days"]. Assuming a locked time interval of 30 minutes, even if the top-right time control is adjusted, the chart will only display the most recent 30 minutes of data.

### Rule Mapping

Set metric ranges and corresponding background and font colors for different columns. Metrics within the set range will display according to the configured styles.

When multiple settings are met, the last matching style is displayed.

When configuring value mappings, both the "Display As" and "Color" fields are optional:

- "Display As" defaults to empty, meaning no mapping value is displayed;
- "Color" defaults to empty, meaning no color mapping is applied.

### Field Mapping

In practical business scenarios, if the fields to be queried differ from those displayed on the front end, field mapping can be enabled in the chart. This feature works with view variable object mapping and is disabled by default.

After enabling field mapping, the chart displays the **grouped fields** and their corresponding **mapped fields**. Ungrouped fields that are not mapped do not display.

### Workspace Authorization

Enabling this allows querying external workspace data under the current workspace and chart.

Below the chart, select the target workspace from the authorized workspaces dropdown for querying.

### Data Sampling

Applicable only to workspaces using the Doris log data engine.

When enabled, it samples data other than "metrics," with a dynamic sampling rate based on data volume.

### Time Offset

Non-time series data has at least a 1-minute query delay after being stored. Choosing relative time queries may result in missing recent data due to collection delays.

Enabling time offset shifts the actual query time range forward by 1 minute when querying relative time intervals, preventing data gaps caused by storage delays. For example, at 12:30, querying the last 15 minutes of data would actually query from 12:14 to 12:29.

**Note**:

1. This setting only applies to relative time queries. For absolute time ranges, time offset does not apply.
2. For charts with time intervals, like time series charts, if the set time interval exceeds 1 minute, time offset does not apply. For charts without time intervals, like summary or bar charts, time offset remains effective.