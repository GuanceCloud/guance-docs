# Chart Query
---

## Introduction

When editing charts, you can perform chart queries and other chart settings depending on the selected chart type. A chart query is a graph that displays numerical data and exposes important data relationships in a visual layout based on a user-defined data query. Each correct query corresponds to a json text, and the json text and chart query within the Support Workbench can be parsed to help you gain insight into the chart plotting details.

## data queries {#query}

A single chart can display multiple queries at the same time, including 「simple query」, 「expression query」 and 「DQL query」. Click 「Add Simple Query」 or 「Add Expression Query」 to add a new query. The 「Simple Query」 and 「DQL Query」 can be switched between each other via buttons. For single-query charts such as overview charts, dashboards, and leaderboards, 「Simple Query」 can be directly converted to 「Expression Query」.

Note: When switching from 「DQL Query」 to 「Simple Query」, if the parsing cannot be done or is incomplete：

- the previous DQL query statement is displayed if it is switched back to 「DQL query」 directly after no operation under 「Simple query」；
- If you adjust the query statement under 「Simple Query」, switching back to 「DQL Query」 again will parse it according to the latest 「Simple Query」.

![](../img/chart015.png)

### Simple Query

Simple query supports querying data from different data sources and displaying charts by selecting aggregation functions, grouping labels, Labels, filtering criteria, etc.

- Support dragging up and down through the 「Separator」 button in the middle of the chart and query to display more query areas
- Support dragging up and down by the 「drag and drop」 button on the left side of the query statement to adjust the order of the query

![](../img/chart016.png)

#### Data Sources

Data sources include a combination of data from metrics, logs, base objects, custom objects, events, application performance, user access, security patrol, network, and profiles.

| Options | Description |
| --- | --- |
| Metrics | You need to select 「Metrics Set」 and 「Metrics」. A metrics set can contain multiple metrics, and the base function checks 「Last by」 by default. Combine with the chart type, select the metric you want to display for query. |
| Logs/Basic Objects/Custom Objects/Events/Application Performance/User Access/Security Patrol/Network/ Profile | System Objects, Custom Objects and Security Patrol need to select 「Category」 and 「Attribute/Label」, Logs/Events/Application Performance/User Access need to select 「Source」 and 「Attribute/Label」, and 「Count by」 is selected by default for the base function. |

Note: If you set the index in 「Log」 - 「Index」, when you select "Log" as the data source of the chart query, you can select different indexes corresponding to the log content, the default is index `default`. For more details, please refer to the document [Log Index](.../.../logs/multi-index/index.md).

![](../img/5.log_7.png)

#### Grouping

Grouping query supports selecting different "tags" for grouping query, and the data is displayed in groups according to the selected tag items, and supports selecting multiple tags (no more than three) for query.

It supports aliasing the grouped queries. After adding aliases, the name of the chart legend changes, which is convenient to distinguish the related metrics more intuitively. (The charts currently supported by this function are: time series chart, pie chart, bar chart, scatter chart, bubble chart, funnel chart.)

![](../img/chart017.png)

#### Label {#label}

Before selecting Label in the chart query, you need to set the Label attribute for the host in 「Infrastructure」 - 「Host」. In the following figure, click 「fx」, select 「Label Filtering」, enter the Label attribute "guance", and you can find the data of one host. For host Label settings, please refer to the document [Host](../../infrastructure/host.md).

![](../img/chart018.png)

#### Filtering

Support filtering by tags. Click the 「Funnel」 icon to add a filter for the query. Multiple filters are supported, and each filter can have 「and」 and 「or」 values between them.

| Filtering criteria | Description | Supported filtering criteria types |
| -------------- | ---------------------------------------- | ---------------------------- |
| `=` | is equal to | `Integer`, `Float`, `String` |
| `! =` | not equal to | `Integer`, `Float`, `String` |
| `>=` | greater than or equal to | `Integer`, `Float`, `String` |
| `<=` | less than or equal to | `Integer`, `Float`, `String` |
| `>` | greater than | `Integer`, `Float`, `String` |
| `<` | less than | `Integer`, `Float`, `String` |
| `match` | contains | `String` |
| `not match` | not include | `String` |
| `wildcard` | fuzzy match (supports log type data other than metrics) | `String` |
| `not wildcard` | fuzzy not match (supports log data other than metrics) | `String` |

**Note: `#{host}` in the content of the filter condition is a view variable, refer to the documentation [view-variable](../view-variable.md). **

![](../img/chart019.png)

#### Functions

Supports calculating data sources such as metrics by functions. Click the 「fx」 icon to add a function to the query, and support adding multiple functions.

![](../img/chart020.png)

##### Aggregation functions

The following aggregation methods are supported in UI mode to return the result values, and more aggregation functions are supported in DQL mode, see [DQL aggregation functions](../../dql/funcs.md).

| Aggregate Functions | Description |
| --- | --- | last
| last | Returns the value of the newest timestamp |
| first | Returns the value of the earliest timestamp |
| avg | Returns the average value of the fields. There is one and only one parameter, and the parameter type is the field name |
| min | Returns the minimum value.
| max | Returns the maximum value.
| sum | Returns the sum of the field values.
| P50 | Returns the 50th percentile of the field values.
| P75 | returns the 75th percentile of the field
| P90 | returns the 90th percentile of the field
| P99 | Returns the 99th percentile of the field
| count | Returns a summary of non-empty field values
| count_distinct | counts the number of different values in a field
| difference | Returns the difference between consecutive time values in a field.
| derivative | Returns the rate of change of a field within a series.
| non_negative_derivative | returns the non-negative rate of change of a value in a field in a series

##### conversion functions

The conversion functions here are also called outer functions. The functions supported in UI mode are shown below, and more outer functions are supported in DQL mode, see [DQL outer functions](../../dql/out-funcs.md).

| Conversion functions (outer functions) | Description |
| --- | --- |
| cumsum | Sums the processed set cumulatively |
| abs | Computes the absolute value of each element of the processing set |
| log2 | Computes the logarithm of the base 2 of each element of the processing set, if the processing set is at least one line larger than the base 2, otherwise it returns null |
| log10 | Computes the logarithm of the base 10 of each element of the processing set, if the processing set is greater than at least one row, otherwise null is returned.
| moving_average | Computes the moving average of the processing set, the size of the window must be no smaller than the number of rows in the processing set, otherwise null is returned.
| difference | Calculates the difference between the adjacent elements of the processing set, if the processing set is larger than one row, otherwise null is returned.
| derivative | Computes the derivative of the set of adjacent elements, in seconds (s).
| non_negative_derivative | Computes the nonnegative derivative of the set of adjacent elements, in seconds (s).
| non_negative_difference | Computes the nonnegative difference of the adjacent elements of the processing set, the processing set is at least one row larger, otherwise it returns null |
| series_sum | When a series is generated by a group, it is merged into 1 series according to the time point, where the sum of multiple series at the same time point is at least one row larger than the processing set, otherwise null is returned.
| rate | Calculate the rate of change of an metric within a certain time range, suitable for slow change counters. The time unit is seconds (s).
| irate | Calculates the rate of change of an metric within a certain time frame, suitable for fast changing counters, in seconds (s) |

##### window function {#window}

Support the selected time interval for the window (record set), combined with the aggregation function for each record to perform statistical calculations, support the selection of 1 minute, 5 minutes, 15 minutes, 30 minutes, 1 hour, 3 hours, etc.

Note: The window function query result does not change the number of records, and the number of records currently present remains the same as before after the function result is executed.

##### No data fill {#fillin}

Support to set the way to fill in the null data, which is displayed as 「fill」 in the query after setting, including three types.

| function | description |
| --- | --- |


| linear fill | A linear fill is a fill of null data by a linear function.
| Numeric fill | Numeric fill is a customizable fill value |


#### Alias

Support adding custom name, click 「AS」 to add alias.

![](../img/3.chart_8.png)

#### Hide Query

Click the 「Hide」 icon to hide the results of that query on the chart. As you can see from the chart below, the system loading data only shows the results of 1 minute and 15 minutes queries, the results of 5 minutes system loading queries have been hidden and cannot be viewed on the chart.

![](../img/3.chart_9.png)

#### Copying a query

Click the "Copy" icon to copy the query.

#### Delete a query

Click the "Delete" icon to delete the query.

### DQL queries

During the chart query process, you can switch to DQL mode when a simple query can no longer meet your needs. Click 「</>」 to manually enter a DQL statement for a chart query, and tap the screen anywhere to execute the query statement and refresh the chart, the system will prompt for the wrong DQL query statement.

DQL is a language developed specifically for guances, and a chart supports multiple DQL queries at the same time. For details, see [DQL Query] (../../dql/query.md).

![](../img/chart021.png)

### Expression Queries

Expression queries perform calculations by adding expressions. If the expression query contains multiple query statements, the grouping labels need to be consistent. In an expression calculation, if query A has units, the result of query A and the number also has units. For example, if the unit of A is KB, then the unit of A+100 is also KB.

![](../img/chart022.png)

## Time slice {#time-slicing}

### Turn on time slicing

Time slicing is generally used in conjunction with time intervals. When time slicing is turned on, the original data is first aggregated in segments at a certain time interval, and then the aggregated data set is aggregated a second time to get the result value.

![](../img/8.chart_7.png)

在In the example overview chart below, the memory active in the last hour is first aggregated in 5-minute intervals to obtain 12 averages, and then the maximum value is displayed on the chart.

![](../img/8.chart_8.png)

### Turn off time slicing

If time slicing is not turned on, all the raw data collected is aggregated according to the selected function to get the result value.

![](../img/8.chart_6.png)

In the following example overview chart, the memory active in the last hour is averaged and displayed on the chart.

![](../img/8.chart_9.png)

## Chart Thousands {#thousand}

The guance dashboard chart query results support automatic addition of data in thousandths format.

![](../img/13.table_1.png)

If the unit is set, the data format is displayed according to the set unit.

![](../img/13.table_2.png)

After setting, the data can be displayed in thousandths data format in preview, or in unit setting format if units are set.

- Kilobits data format display

![](../img/13.table_4.png)

- The set data format is displayed

![](../img/13.table_5.png)

