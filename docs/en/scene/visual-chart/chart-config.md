# Chart Configuration

---

Includes commonly used configurations and advanced configurations for charts.

## Common Configurations {#general}


### Title

1. Title: Set a title name for the chart. After setting, it will be displayed in the top-left corner of the chart, with an option to hide it.

2. Description: Add descriptive information to the chart. After setting, a [i] prompt will appear after the chart title; if not set, it will not be displayed.


Based on <<< custom_key.brand_name >>>'s equipped large model natural language generation capability, the "auto-generate" function can be used to quickly generate appropriate titles and descriptions.

<img src="../../img/chart-config-ai.png" width="70%" > 

### Unit


<div class="grid" markdown>

=== "Global"

    Includes general unit formats for different dimensions, such as data size, time intervals, timestamps, etc. You can input custom units in the dropdown box.

    ---

=== "Custom"

    Select the metrics included under the current query conditions and input custom units.

    ---

</div>


???+ abstract "About the unit display of metric data"

    1. Default unit display:

        - If the queried data is metric data and you have set units for the metrics in [Metric Management](../../metrics/dictionary.md), the default display will increment according to the unit of the metric;
        - If there are no related unit settings in **Metric Management**, the values will increment with commas separating thousands as described in [chart-query.md#thousand].

    2. After configuring the unit: The configured custom unit takes priority for increment display. Metric data supports two options for numerical values:
        
        - Default increment: Units in ten thousand, million, e.g., 10,000 displays as 1 ten thousand, 1,000,000 displays as 1 million. Retains two decimal places;
        - Short scale: Units in K, M, B. i.e., thousand, million, billion, trillion represent thousand, million, billion, trillion respectively in Chinese context. For example, 1,000 is 1 k, 10,000 is 10 k, 1,000,000 is 1 million; retains two decimal places.



### Alias {#alias}

The system automatically lists all metrics and groupings under the current chart query. After adding aliases, the grouping part of the chart will dynamically update based on alias values. Aliases support template variables for one-click replacement. For example:

- `{tags}`: Replaces with all "tag names" and "tag values";    

- `{host}`: Replaces with the "tag value" of `host`;   

- `{__name__}`: Replaces with all metric names.

<img src="../../img/alias_list.png" width="60%" > 


???+ warning "Note"

    - The alias for the metric section is determined by the `AS` on the right side of the query statement;
    
    <img src="../../img/as_alias.png" width="60%" > 
    
    - When your query contains a `by` condition, all legend sequences returned will be displayed;
    - If both the metric section and the grouping section are set in the alias, the setting precedence is: Grouping alias > Metric alias.

#### Scenario Example

As shown in the figure below, queries are made for the total CPU usage (`usage_total`) and user state usage (`usage_user`) of the host. Based on the former, the following scenarios may occur when setting aliases:

- Effect without adding aliases:

<img src="../../img/no_alias.png" width="60%" > 

- Effect of replacing with plain text:

<img src="../../img/alias_pure_text.png" width="60%" > 

- Input variable `{tags}` based on `by` condition:

<img src="../../img/alias_by.png" width="60%" >


### Legend {#legend}

#### Position

Supports selecting to hide, bottom, or right-side legends. Clicking on the legend's metric row can hide/show the corresponding metric.

##### Display Value

Choose which value or calculated value to display in the legend.

Time series chart legend values will be recalculated based on the chart query results, supporting selection of `Last (last value)`, `First (first value)`, `Avg (average value)`, `Min (minimum value)`, `Max (maximum value)`, `Sum (sum)`, `Count (number of points)`.

As shown in the figure below: `First` returns the first value of the current time series chart query result, `Last` is the last value of the current time series chart query result, and clicking on the legend value supports ascending/descending sorting.


<img src="../../img/chart030.png" width="70%" >


???+ warning "Note"

    `Avg`, `Sum`, `Count` show different results depending on the selected time interval (original interval and automatic alignment).

### Data Format {#data_format}

1. Decimal places: Can choose 0, 1, 2, 3 decimal places or full precision.

2. Thousand separator: Enabled by default; when disabled, the raw value will be displayed without separators.


<<< custom_key.brand_name >>> dashboard chart query results support automatic addition of thousand separators for data display.

![](../img/13.table_1.png)

If units are set, the data format will be displayed according to the set units.

![](../img/13.table_2.png)

After configuration, the preview will display data formatted with thousand separators, or according to the set unit format.

- Data format with thousand separators:

<img src="../../img/13.table_4.png" width="70%" >

- Set data format display:

<img src="../../img/13.table_5.png" width="70%" >


## Advanced Configuration

### Lock Time

Fixes the time range for the current chart query data, independent of the global time component. After successful setup, the upper-right corner of the chart will display the user-set time, such as [xx minutes], [xx hours], [xx days]. Assuming a lock time interval of 30 minutes, even if the time control in the upper-right corner is adjusted, the current chart will only display data from the last 30 minutes.


### Rule Mapping

Set metric ranges and corresponding background colors, font colors for different columns. Metrics within the range will be displayed according to the set styles.

Set metric ranges and mapping values; when the metric value falls within the set data range, it will be displayed as the corresponding mapping value.

When a metric value satisfies multiple settings simultaneously, it will be displayed in the style of the last satisfied condition.

When setting value mappings, neither the "Display As" nor the "Color" fields are mandatory:

- "Display As" defaults to empty, meaning no mapping value display;
- "Color" defaults to empty, meaning no color mapping, displaying its original color.

### Field Mapping

In actual business scenarios, if the fields to be queried differ from the fields displayed on the front end, field mapping in the chart can be enabled. Object mapping functionality for view variables is supported by default but turned off.

After enabling field mapping, the chart displays the **grouped fields** and their corresponding **mapped fields**, and any grouped fields not specified in the mapping will not be displayed.



### Space Authorization

After enabling, data from external workspaces can be queried under the current workspace and chart.

Below the chart, select the target workspace from the authorized workspace dropdown menu for querying.



### Data Sampling

Only applies to Doris log data engine workspaces.

After enabling, sampling queries will be performed on data other than "Metrics", with a non-fixed sampling rate that dynamically adjusts based on data volume.


### Time Offset

Since non-time-series data has at least a 1-minute query delay after being stored in the database, choosing relative time queries might cause recent minutes' data to be missed, resulting in data loss.

After enabling time offset, when querying relative time intervals, the actual query time range shifts forward by 1 minute to prevent data retrieval from being empty due to storage delays. For example: if the current time is 12:30 and you query data from the last 15 minutes, after enabling time offset, the actual query time will be: 12:14-12:29.

???+ warning "Note"

    - This setting only applies to relative times; if the query time interval is an "absolute time range," the time offset does not take effect.
    - For charts with time intervals, such as time series charts, if the set time interval exceeds 1 minute, the time offset does not take effect; it only offsets when <= 1 minute. For charts without time intervals, such as overview charts and bar charts, the time offset remains effective.