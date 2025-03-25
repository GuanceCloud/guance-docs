# Chart Configuration

---

Includes commonly used configurations and advanced configurations for charts.

## Common Configurations {#general}

### Title

1. Title: Set a title name for the chart. After setting, it will be displayed in the top-left corner of the chart and supports hiding.
2. Description: Add a description to the chart. After setting, an [i] prompt will appear after the chart title; if not set, it will not be displayed.

Based on <<< custom_key.brand_name >>>'s large model natural language generation capabilities, you can use the "Auto Generate" function to quickly generate semantically appropriate titles and descriptions for the chart.

<img src="../../img/chart-config-ai.png" width="80%" > 

### Units

1. Global: Includes common unit formats for different dimensions, such as data size, time intervals, timestamps, etc. You can input custom units in the dropdown box, and after pressing Enter, they will be applied to the current chart.
2. Custom: Select the metrics included under the current query conditions and input custom units.

???+ abstract "About Unit Display for Metric Data"

    1. Default Unit Display:
    
        - If the queried data is metric data, and you have set a unit for the metric in [Metric Management](../../metrics/dictionary.md), then by default, the display will follow the unit of the metric;
        - If there are no related unit settings in **Metric Management**, the data will be displayed using the thousand separator (as described in [chart-query.md#thousand]) with comma-separated numerical increments.

    2. After Configuring Units: The system will prioritize displaying the units that you have customized. For metric-type data, two options are supported for numerical values:
        
        - Default Scaling: Units include ten thousand and million. For example, 10,000 displays as 1 ten thousand, and 1,000,000 displays as 1 million. Two decimal places are retained.
        - Short Scale: Units include K, M, B. That is, thousand, million, billion, trillion, etc., represent thousands, millions, billions, trillions, etc., in Chinese contexts. For example, 1,000 is 1k, 10,000 is 10k, and 1,000,000 is 1 million. Two decimal places are retained.


### Legend {#legend}

1. Alias: After adding an alias, the legend's name will also change, making it easier to distinguish between related metrics.

Aliases support one-click replacement using template variables. For example:

- `{tags}` replaces all "tag names" and "tag values";
- `{host}` replaces the `host` "tag value";
- `{__name__}` replaces all metric names.

*Example: Based on metrics, setting aliases will result in the following scenarios:*

Effect without adding an alias:

<img src="../../img/alias-1.png" width="60%" > 

Effect of replacing with plain text:

<img src="../../img/alias-2.png" width="60%" > 

Using variables {tags} based on by condition:

**Note**: When your query contains a by condition, it will display all returned legend sequences.

<img src="../../img/alias-3.png" width="60%" >

2. Position: Currently supports choosing to hide, bottom, or right-side legends (clicking on the metric line in the legend allows you to hide/show the corresponding metric).

3. Display Values: Choose which values or calculated values to show in the legend.

Time series chart legend values will undergo additional aggregation calculations based on the chart query results. Currently, you can choose from `Last (last value)`, `First (first value)`, `Avg (average)`, `Min (minimum)`, `Max (maximum)`, `Sum (sum)`, `Count (number of points)`.

As shown below: `First` returns the first value of the current time series query result, and `Last` returns the last value of the current time series query result. Clicking on the legend value supports ascending/descending sorting.

**Note**: `Avg`, `Sum`, and `Count` display different results depending on the selected time interval (original interval and automatic alignment).

<img src="../../img/chart030.png" width="70%" >

### Data Format {#data_format}

1. Decimal Places: You can choose 0, 1, 2, 3 decimal places or full precision.
2. Thousand Separator: Enabled by default; when disabled, it shows the raw value without separators.

<<< custom_key.brand_name >>> dashboard chart query results support automatically adding data with thousand separators for display.

![](../img/13.table_1.png)

If units are set, the data format will be displayed according to the set units.

![](../img/13.table_2.png)

After setting, the data format can be previewed with thousand separators, or according to the set unit format.

- Thousand Separator Data Format Display:

<img src="../../img/13.table_4.png" width="70%" >

- Set Data Format Display:

<img src="../../img/13.table_5.png" width="70%" >


## Advanced Configurations

### Lock Time

This fixes the time range for querying data in the current chart, independent of the global time component. After setting successfully, the upper-right corner of the chart will display the user-defined time, such as [xx minutes], [xx hours], [xx days]. For example, if the locked time interval is 30 minutes, even if the time control in the upper-right corner is adjusted, the current chart will only display data from the last 30 minutes.


### Rule Mapping 

Set metric ranges and corresponding background colors, font colors for different columns. Metrics within the defined range will be displayed according to the set styles.

Set metric ranges and mapping values; when the metric value falls within the set data range, it will display as the corresponding mapped value.

When a metric value satisfies multiple settings simultaneously, it will display as the style of the last satisfied condition.

When setting value mappings, neither the "Display As" nor the "Color" fields are mandatory:

- "Display As" defaults to blank, meaning no mapping value will be displayed;
- "Color" defaults to blank, meaning no color mapping will be applied and the original color will be displayed.


### Field Mapping

In practical business scenarios, if the fields to be queried do not match the fields displayed on the front end, you can enable field mapping in the chart. This feature works together with the object mapping function of view variables and is off by default.

After enabling field mapping, the chart will display the **grouped fields** and their corresponding **mapped fields**. Grouped fields without specified mappings will not be displayed.


### Workspace Authorization

Once enabled, you can query data from external workspaces under the current chart in the current workspace.

Below the chart, you can select the target workspace from the authorized workspace dropdown list to perform queries.


### Data Sampling

Applies only to Doris log data engine workspaces.

After enabling, sampling queries will be performed on data other than "Metrics". The sampling rate is not fixed and adjusts dynamically based on the volume of data.


### Time Offset

Due to at least a 1-minute delay in querying non-time-series data after it has been stored, selecting relative time queries may result in recent data not being collected, leading to data loss.

After enabling time offset, when querying relative time ranges, the actual query time range shifts forward by 1 minute to prevent data retrieval from being empty due to storage delays. For example, if the current time is 12:30 and you query the last 15 minutes of data, with time offset enabled, the actual query time would be 12:14-12:29.

???+ warning "Note"

    - This setting applies only to relative times. If the query time range is an "absolute time range," the time offset will not take effect.
    - For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, the time offset will not take effect. It only takes effect when the interval is <= 1 minute. For charts without time intervals, such as summary charts or bar charts, the time offset remains effective.