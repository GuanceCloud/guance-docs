# Chart Query
---

After selecting a chart, you can use various query methods to perform in-depth queries and analysis on different categories of data. These query methods help intuitively display numerical information in the chart and reveal important relationships between data.

## Query Methods {#query}

A single chart supports the following query methods simultaneously:

- Simple Query
- Expression Query
- DQL Query
- PromQL Query
- Data Source

???+ warning "Switching Query Methods"

    Simple Query and DQL Query can be switched via the :fontawesome-solid-code: button. After switching, if it cannot be parsed or parsed incompletely:

    - If no operation has been performed under Simple Query, switching back to DQL Query will show the previous DQL query statement.
    - If the query statement has been adjusted under Simple Query, switching back to DQL Query will parse according to the latest Simple Query.

![Query](../../img/query.png)

### Simple Query {#simple}

Queries data from different [data sources](#source) and displays it through charts by selecting aggregation functions, grouping labels, Labels, filter conditions, etc.

#### Data Sources {#source}

Data comes from a series of combinations including Metrics, logs, basic objects, resource catalog, events, APM, RUM, security checks, network, Profile, cloud billing.

| Source | Description |
| --- | --- |
| Metrics | You need to select **Measurement** and **Metrics**, one Measurement can contain multiple metrics. |
| Other Types | Basic objects, resource catalog, security checks: Need to select **Resource Class** and **Properties/Labels**; <br /> Logs, events, APM, RUM: Need to select **Source** and **Properties/Labels**. |

???- warning "When Logs are Used as Data Source"

    Different indexes can be selected for corresponding log content, default index is `default`.

    > For more details, refer to the documentation [Log Index](../../logs/multi-index/index.md).

    ![Chart Source Log](../../img/chart-source-log.png)

#### Multiple Queries

Select multiple query conditions, and data is grouped and displayed according to the selected filters.

To easily distinguish the display of query results, click the AS button to add an alias for each query condition.

![Multiple Queries](../../img/chart-multi-query.png)

If you want the added aliases to be directly displayed on the chart, click the right-hand side [Legend](./chart-config.md#legend) > Position, and choose bottom or right.

![Multiple Queries Legend](../../img/chart-multi-query-legend.png)

#### Label Filtering {#label}

**Prerequisite**: Labels have already been set for hosts in **Infrastructure > [Hosts](../../infrastructure/host.md#label)**.

In **`fx` > Label Filtering**, select or exclude host Label properties for filtering display.

![Label Query](../../img/chart_query_label.png)

#### Adding Filters

Click the :material-filter-outline: icon to add filter conditions to the current query.

Multiple filter conditions can be added under a single query, with each condition having either `AND` or `OR` relationships.

| Filter Condition | Description | Supported Condition Types |
| -------------- | ---------------------------------------- | ---------------------------- |
| `=`            | Equals                                   | `Integer`, `Float`, `String` |
| `!=`           | Not equal                                | `Integer`, `Float`, `String` |
| `>=`           | Greater than or equal                    | `Integer`, `Float`, `String` |
| `<=`           | Less than or equal                       | `Integer`, `Float`, `String` |
| `>`            | Greater than                             | `Integer`, `Float`, `String` |
| `<`            | Less than                                | `Integer`, `Float`, `String` |
| `match`        | Contains                                 | `String`                     |
| `not match`    | Does not contain                        | `String`                     |
| `wildcard`     | Fuzzy match (supports log data except Metrics) | `String`                     |
| `not wildcard` | Fuzzy non-match (supports log data except Metrics) | `String`                     |

![Add Label Filter](../../img/chart_query_add_label.png)

#### Functions

Click the **fx** icon to add function calculations for indicators and other data sources.

![Add Function](../../img/chart_query_add_fix.png)

##### Rollup Function {#rollup}

This slices data into specified time intervals and calculates and returns data for each interval.

**Note**:

1. In time series charts, after selecting this function and the aggregation method, go to **Advanced Configuration** to choose the time interval;
2. In non-time series charts, after selecting this function, you can choose aggregation methods such as `avg`, `sum`, `min`, and time intervals including auto, 10s, 20s, 30s, 1m, 5m, 10m, 30m, 1h, 6h, 12h, 1d, 7d, 30d (`interval`);
3. Only supports Metrics data queries; simple mode does not support choosing the Rollup function for other data queries;
4. The Rollup function does not support adding multiple instances.

> For more details, refer to [Rollup Function](../../dql/rollup-func.md).

##### Transformation Functions

Also known as outer functions, UI mode supports the following functions:

| <div style="width: 180px">Transformation Function (Outer Function)</div> | Description |
| --- | --- |
| `cumsum` | Cumulative sum of processed sets |
| `abs` | Calculate the absolute value of each element in the processed set |
| `log2` | Calculate the logarithm of each element in the processed set with base 2, requires at least one row, otherwise returns null |
| `log10` | Calculate the logarithm of each element in the processed set with base 10, requires at least one row, otherwise returns null |
| `moving_average` | Calculate the moving average of the processed set, window size must be no less than the number of rows in the processed set, otherwise returns null |
| `difference` | Calculate the difference between adjacent elements in the processed set, requires at least one row, otherwise returns null |
| `derivative` | Calculate the derivative of adjacent elements in the processed set, differentiation time unit is seconds (s) |
| `non_negative_derivative` | Calculate the non-negative derivative of adjacent elements in the processed set, differentiation time unit is seconds (s) |
| `non_negative_difference` | Calculate the non-negative difference between adjacent elements in the processed set, requires at least one row, otherwise returns null |
| `series_sum` | When grouping produces multiple series, merge them into one series based on timestamps. Sum values of the same timestamp across multiple series, requires at least one row, otherwise returns null |
| `rate` | Calculate the rate of change of a metric over a certain time range, suitable for slowly changing counters. Time unit is seconds (s) |
| `irate` | Calculate the rate of change of a metric over a certain time range, suitable for rapidly changing counters, time unit is seconds (s) |

> In DQL mode, more outer functions are supported, refer to [DQL Outer Functions](../../dql/out-funcs.md).

##### Aggregation Functions {#aggregate-function}

UI mode supports selecting aggregation methods to return result values.


| Aggregation Function | Description |
| --- | --- |
| `last` | Returns the value of the latest timestamp |
| `first` | Returns the value of the earliest timestamp |
| `avg` | Returns the average value of the field. Parameter is only one field name |
| `min` | Returns the minimum value |
| `max` | Returns the maximum value |
| `sum` | Returns the sum of field values |
| `P50` | Returns the 50th percentile value of the field |
| `P75` | Returns the 75th percentile value of the field |
| `P90` | Returns the 90th percentile value of the field |
| `P99` | Returns the 99th percentile value of the field |
| `count` | Returns the count of non-null field values |
| `count_distinct` | Counts the number of distinct values in a field |
| `difference` | Returns the difference between consecutive time values in a field |
| `derivative` | Returns the rate of change of a field within a series |
| `non_negative_derivative` | Returns the non-negative rate of change of a field within a series |

> In DQL mode, more aggregation functions are supported, refer to [DQL Aggregation Functions](../../dql/funcs.md).

##### Window Functions {#window}

Window functions use selected time intervals as windows (record sets), combining aggregation functions to perform statistical calculations on each record, supporting intervals of 1 minute, 5 minutes, 15 minutes, 30 minutes, 1 hour, 3 hours, 6 hours, 12 hours, 24 hours.

**Note**: Window function query results do not change the number of records; the number of existing records remains the same after executing the function.

##### No Data Fill {#fillin}

Set the filling method for null values. After setting, it is displayed as **fill** in queries, including three types:

| Function | Description |
| --- | --- |
| Previous Value Fill (previous) | Convert null values to the previous value. |
| Linear Fill (linear) | Perform linear function calculation on null values and fill them. |
| Value Fill | Customizable fill value. |

##### Advanced Functions

Advanced functions are mainly used for further function calculations on data queried by DQL and provide intuitive time series chart displays. <<< custom_key.brand_name >>> time series charts support custom functions for secondary processing and returning data results.

> For more details, refer to [Advanced Functions](../../dql/advanced-funcs/index.md).

#### Hide Query

Click the :material-eye-outline: icon to hide the query result of that line on the chart.

As shown below, the system loads data only displaying 1m and 15m query results, while the 5m system load query result is hidden and cannot be viewed on the chart.

![Hide Query Result](../../img/enable_chart_query_result.png)

### Expression Query

Calculate using added expressions. If the expression query contains multiple query statements, grouping tags need to remain consistent. In expression calculations, if Query A has units, the result of operations involving Query A and numbers also retains the units. For example, if A's unit is KB, then A+100 also has the unit KB.

![](../img/chart022.png)

### DQL Query

<<< custom_key.brand_name >>> supports switching to DQL mode to manually input DQL statements for chart queries.

> A single chart supports multiple DQL queries simultaneously. For more details, refer to [DQL Query](../../dql/query.md).

![DQL Query](../../img/chart021.png)

### PromQL Query {#PromQL}

<<< custom_key.brand_name >>> supports writing PromQL queries to fetch data.

| Query Type      | Description        |
| ----------- | -------- |
| Range Query      | Run queries over a time range        |
| Instant Query      | Run queries for a single point in time        |

PromQL is added by default as a text box input. In this input box, both simple PromQL queries and expression queries can be entered.

> Click to learn about [Comparison of DQL and Other Query Languages](../../dql/dql-vs-others.md#promql); or visit [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).


### Add Data Source {#func}

Perform operations like filtering, searching, and aggregating data stored in databases.

![Add Data Source](../../img/func.png)

> Specific configuration methods see [External Function Configuration](../../dql/dql-out-func.md).

<!-- 

#### Preset Field Query

If workspace data reporting is interrupted, preset field values can be configured in queries when configuring chart queries, defaulting to numeric type and displaying [aggregation functions](#aggregate-function).
-->



<!--
If you have published scripts and synchronized them to the corresponding workspace in the Function platform, you can directly select Func data sources from the table below. <<< custom_key.brand_name >>> automatically retrieves workspace Issue information, ultimately providing visualized data display. Currently <<< custom_key.brand_name >>> supports listing handling duration statistics for [resolved Issues](../../exception/issue.md#others).

| Function List    | Description |
| --------- | ----------- |
| incidents-issue_total_count | Incident-total number of issues |
| incidents-open_issue_count | Incident-number of open issues |
| incidents-pending_issue_count | Incident-number of pending issues |
| incidents-resolved_issue_count | Incident-number of resolved issues |
| incidents-average_issue_duration | Incident-average handling duration |
| incidents-max_issue_duration | Incident-maximum handling duration |
| incidents-issue_count_distribution_by_level | Incident-distribution by issue level |
| incidents-issue_count_distribution_by_reference | Incident-distribution by issue source |
| incidents-issue_count_by_assignee(top10) | Incident-TOP 10 assignees by issue count |
| incidents-issue_duration_by_assignee(top10) | Incident-TOP 10 assignees by issue handling duration |
| incidents-unresolved_issue_assignee_distribution | Incident-distribution of unresolved issues by assignee |
| incidents-unresolved_issue_list | Incident-list of unresolved issues |
-->



<!--
## Time Slicing {#time-slicing}

### Enable Time Slicing

Time slicing generally works with time intervals. After enabling time slicing, raw data is first segmented and aggregated according to a specified time interval, and then the aggregated dataset is re-aggregated to get the final result.

![](../img/8.chart_7.png)

In the following overview diagram, memory activity within the last hour is first aggregated into 12 average values with a 5-minute interval, and then the maximum value is displayed on the chart.

![](../img/8.chart_8.png)

### Disable Time Slicing

If time slicing is not enabled, all collected raw data is aggregated based on the selected function to get the result.

<img src="../../img/8.chart_6.png" width="70%" >

In the following overview diagram, the average value of memory activity within the last hour is displayed on the chart.

![](../img/8.chart_9.png)

## Thousand Separator {#thousand}

<<< custom_key.brand_name >>> dashboard chart query results support automatic thousand separator formatting.

![](../img/13.table_1.png)

If a unit is set, data format follows the set unit.

![](../img/13.table_2.png)

After setting, previewed data will display in thousand separator format, and if a unit is set, it will follow the unit format.

- Thousand separator data format:

<img src="../../img/13.table_4.png" width="70%" >

- Set data format:

<img src="../../img/13.table_5.png" width="70%" >
-->