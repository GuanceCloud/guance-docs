# Chart Configuration

---

Includes common and advanced configurations for charts.

## Common Configuration {#general}


### Title

1. Title: Set a title name for the chart; after completion, it will be displayed in the top-left corner of the chart and supports hiding.

2. Description: Add descriptive information to the chart; after setting, an [i] prompt will appear after the chart title. If not set, it will not be displayed.


Based on <<< custom_key.brand_name >>> equipped with large model natural language generation capabilities, you can use the "Auto Generate" function to quickly create semantically appropriate titles and descriptions.

<img src="../../img/chart-config-ai.png" width="70%" > 

### Unit


<div class="grid" markdown>

=== "Global"

    Includes general unit formats for different dimensions such as data size, time intervals, timestamps, etc. You can input custom units in the dropdown box.

    ---

=== "Custom"

    Select the metrics included under the current query conditions and input custom units.

    ---

</div>


???+ abstract "About Unit Display for Metric Data"

    1. Default unit display:

        - If the queried data is metric data, and you have set units for the metric in [Metric Management](../../metrics/dictionary.md), it will default to displaying according to the metric's unit;
        - If there is no related unit configuration in **Metric Management**, it will display using the [thousand separator](chart-query.md#thousand) comma-separated numerical progression method.

    2. After configuring units: It prioritizes using your custom-configured units for numerical progression display. Metric-type data supports providing two options for values:
        
        - Default progression: Units are ten thousand, million, e.g., 10,000 displays as 10K, 1,000,000 displays as 1M. Retains two decimal places;
        - Short scale: Units are K, M, B. That is, thousand, million, billion, trillion, etc., sequentially representing thousand, million, billion, trillion, etc., in Chinese context. For example, 1,000 is 1k, 10,000 is 10k, 1,000,000 is 1M; retains two decimal places.



### Legend {#legend}

#### Alias

After adding an alias, the legend name changes accordingly, making it easier to distinguish relevant metrics. Aliases support the use of template variables for one-click replacement, such as:

- `{tags}` represents replacing with all "tag names" and "tag values";    

- `{host}` represents replacing with the "tag value" of `host`;   

- `{__name__}` represents replacing with all metric names.

*Example: Based on metrics, setting aliases will result in the following scenarios:*

Effect without adding an alias:

<img src="../../img/alias-1.png" width="60%" > 

Effect of replacing with plain text:

<img src="../../img/alias-2.png" width="60%" > 

Based on by condition input variable {tags}:

<img src="../../img/alias-3.png" width="60%" >

???+ warning "Note"

    When your query contains a by condition, it will display all legend sequences returned.


#### Position

Supports selecting hidden, bottom, or right-side legends. Clicking on a metric line in the legend hides/shows the corresponding metric.

##### Display Value

Choose the value or calculated value to display in the legend.

The values of the time series chart legend will be recalculated based on the chart query results, supporting the selection of `Last (last value)`, `First (first value)`, `Avg (average value)`, `Min (minimum value)`, `Max (maximum value)`, `Sum (sum)`, `Count (number of returned points)`.

As shown in the figure below: `First` indicates returning the first value of the current time series chart query result, `Last` is the last value of the current time series chart query result, clicking on the legend value supports ascending/descending sorting.


<img src="../../img/chart030.png" width="70%" >


???+ warning "Note"

    `Avg`, `Sum`, `Count` display different results depending on the selected time interval (original interval and automatic alignment).

### Data Format {#data_format}

1. Decimal Places: You can choose 0, 1, 2, 3 decimal places or full precision.

2. Thousand Separator: Enabled by default; when disabled, the original value is displayed without separators.


<<< custom_key.brand_name >>> dashboard chart query results support automatically displaying data with thousand separators.

![](../img/13.table_1.png)

If a unit is set, the data format will be displayed according to the set unit.

![](../img/13.table_2.png)

After setting, the preview will display data formatted with thousand separators. If a unit is set, the data will be displayed according to the set unit format.

- Thousand separator data format display:

<img src="../../img/13.table_4.png" width="70%" >

- Set data format display:

<img src="../../img/13.table_5.png" width="70%" >


## Advanced Configuration

### Lock Time

That is, fix the time range of the current chart query data, not restricted by the global time component. After successful settings, the user-defined time will appear in the upper-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. Assuming a locked time interval of 30 minutes, even if the time widget in the upper-right corner is adjusted, the current chart will still only display data from the last 30 minutes.


### Rule Mapping 

Set metric ranges and corresponding background colors, font colors for different columns. Metrics within the range will be displayed according to the set styles.

Set metric ranges and mapping values, and when the metric value falls within the set data range, it will display the corresponding mapping value.

When the metric value satisfies multiple settings simultaneously, it displays the style of the last satisfied condition.

When setting value mappings, neither the ["Display As"] nor the ["Color"] are mandatory fields:

- The ["Display As"] defaults to empty, meaning no mapping value display;
- The ["Color"] defaults to empty, meaning no color mapping display, showing its original color.

### Field Mapping

In actual business scenarios, if the fields to be queried and the fields displayed on the front-end do not match, you can enable field mapping in the chart. This works together with the object mapping function of view variables and is turned off by default.

After enabling field mapping, the chart will display the **grouped fields** and their corresponding **mapped fields**. Grouped fields that are not specified in the mapping will not be displayed.



### Workspace Authorization

After enabling, you can query data from external workspaces under the current chart in the current workspace.

Below the chart, you can select the target workspace from the authorized workspace drop-down list for querying.



### Data Sampling

Only applies to workspaces using the Doris log data engine.

After enabling, it will perform sampling queries for data other than "Metrics". The sampling rate is not fixed and adjusts dynamically based on data volume.


### Time Offset

Since non-time series data has at least a 1-minute query delay after being stored. Choosing relative time queries may result in the most recent few minutes of data not being collected, leading to data loss.

After enabling time offset, when querying relative time ranges, the actual query time range shifts forward by 1 minute to prevent data retrieval from being empty due to storage delays. For example: if the current time is 12:30, and you query the data for the last 15 minutes, with time offset enabled, the actual query time would be: 12:14-12:29.

???+ warning "Note"

    - This setting only takes effect for relative times; if the query time range is "absolute time range," the time offset does not take effect.
    - For charts with time intervals, such as time series charts, if the set time interval exceeds 1min, the time offset does not take effect and only takes effect when <= 1m. For charts without time intervals, such as summary charts and bar charts, the time offset remains effective.