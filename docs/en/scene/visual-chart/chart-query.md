# Chart Query
---

After selecting a chart, you can use various query methods to conduct in-depth queries and analyses on data of different categories. This helps intuitively display numerical information in the chart and reveal important relationships between data.

## Query Methods {#query}

A single chart supports the following query methods:

:material-numeric-1-circle: [Simple Query](#simple)   
:material-numeric-2-circle: [Expression Query](#expression)       
:material-numeric-3-circle: [DQL Query](#dql)       
:material-numeric-4-circle: [PromQL Query](#promql)       
:material-numeric-5-circle: [Data Source](#func)         

???+ abstract "Switching Query Methods"

    Simple Query and DQL Query can be switched via the :fontawesome-solid-code: button. If it cannot be parsed or is incompletely parsed after switching:

    - Under Simple Query without any operation, switching back to DQL Query will display the previous DQL Query statement;
    - Under Simple Query with adjustments made to the query statement, switching back to DQL Query will parse according to the latest simple query.

<img src="../../img/query.png" width="70%" >


### Simple Query {#simple}

Query data from different [data sources](#source) and display charts through selecting aggregation functions, grouping labels, Labels, filtering conditions, etc.


#### Data Sources {#source}

Includes a series of data combinations from Metrics, Logs, Basic Objects, Resource Catalogs, Events, Application Performance Monitoring, User Analysis, Security Checks, NETWORKs, Profile, Cloud Billing.

| Source | Description |
| --- | --- |
| Metrics | You need to select **Measurement** and **Metrics**, one measurement can contain multiple metrics. |
| Other Types | Basic Objects, Resource Catalogs, Security Checks: Need to select **Resource Class** and **Properties/Labels**;<br />Logs, Events, Application Performance Monitoring, User Analysis: Need to select **Source** and **Properties/Labels**. |

???+ warning "When Logs are Used as Data Sources"

    You can choose different indexes corresponding to log content, default is index `default`.
    
    > For more details, refer to the documentation [Log Indexes](../../logs/multi-index/index.md).

#### Multiple Queries

Select multiple query conditions, data will be grouped and displayed based on the selected filters. Click the AS button to add aliases for each query condition, making it easier to distinguish between data query results.

<img src="../../img/chart-multi-query.png" width="70%" >

If you want to directly display the added alias on the chart, click on the right-hand side [Legend](./chart-config.md#legend) > Position, and select bottom or right.

<img src="../../img/chart-multi-query-legend.png" width="70%" >

#### Label Filtering {#label}

**Prerequisite**: Labels have been set for hosts under **Infrastructure > [HOSTS](../../infrastructure/host.md#label)**.

In **`fx` > Label Filtering**, you can filter by either including or excluding host Label properties.

<img src="../../img/chart_query_label.png" width="70%" >



#### Add Filters

Click the :material-filter-outline: icon to add filtering conditions for the current query.

Under a single query, you can add multiple filtering conditions. Between each filtering condition, there are two possible values: `AND` and `OR`.

| Filtering Condition       | Description                                     | Supported Filtering Condition Types           |
| -------------- | ---------------------------------------- | ---------------------------- |
| `=`            | Equals                                   | `Integer`, `Float`, `String` |
| `!=`           | Not equal                                | `Integer`, `Float`, `String` |
| `>=`           | Greater than or equal to                 | `Integer`, `Float`, `String` |
| `<=`           | Less than or equal to                    | `Integer`, `Float`, `String` |
| `>`            | Greater than                             | `Integer`, `Float`, `String` |
| `<`            | Less than                                | `Integer`, `Float`, `String` |
| `match`        | Contains                                 | `String`                     |
| `not match`    | Does not contain                        | `String`                     |
| `wildcard`     | Fuzzy matching (supports log-type data except Metrics)   | `String`                     |
| `not wildcard` | Fuzzy non-matching (supports log-type data except Metrics) | `String`                     |


<img src="../../img/chart_query_add_label.png" width="70%" >

#### Functions

Click the **fx** icon to add functions for calculating indicators and other data sources for this query.

<img src="../../img/chart_query_add_fix.png" width="70%" >


##### Rollup Function {#rollup}

Slice the data into specified time intervals and calculate and return the data for each time interval.

???+ warning "Note"

    - In Time Series charts, after selecting this function and aggregation method, you can go to **Advanced Configuration** to select the time interval;
    - In non-Time Series charts, after selecting this function, you can choose aggregation methods including `avg`, `sum`, `min`, etc., and time intervals including auto, 10s, 20s, 30s, 1m, 5m, 10m, 30m, 1h, 6h, 12h, 1d, 7d, 30d (`interval`);
    - Only supports Metrics data queries; the Rollup function is not supported for other data queries in the simple mode of the chart;
    - The Rollup function does not support adding multiple instances.

> For more details, refer to [Rollup Function](../../dql/rollup-func.md).

##### Transformation Functions

Also known as outer functions, the UI mode supports the selection of functions as shown below:

| <div style="width: 180px">Transformation Function (Outer Function)</div> | Description |
| --- | --- |
| `cumsum` | Cumulatively sum the processing set |
| `abs` | Calculate the absolute value of each element in the processing set |
| `log2` | Calculate the logarithm base 2 of each element in the processing set; the processing set must be at least one row, otherwise returns null |
| `log10` | Calculate the logarithm base 10 of each element in the processing set; the processing set must be at least one row, otherwise returns null |
| `moving_average` | Calculate the moving average of the processing set; the window size needs to be no smaller than the number of rows in the processing set, otherwise returns null |
| `difference` | Calculate the difference between adjacent elements in the processing set; the processing set must be at least one row, otherwise returns null |
| `derivative` | Calculate the derivative between adjacent elements in the processing set; the unit of derivation is seconds (s) |
| `non_negative_derivative` | Calculate the non-negative derivative between adjacent elements in the processing set; the unit of derivation is seconds (s) |
| `non_negative_difference` | Calculate the non-negative difference between adjacent elements in the processing set; the processing set must be at least one row, otherwise returns null |
| `series_sum` | When grouping produces multiple series, merge them into one series based on the timestamp. Sum the multiple series at the same timestamp; the processing set must be at least one row, otherwise returns null |
| `rate` | Calculate the rate of change of a metric within a certain time range, suitable for slowly changing counters. The time unit is seconds (s) |
| `irate` | Calculate the rate of change of a metric within a certain time range, suitable for rapidly changing counters. The time unit is seconds (s) |

> In DQL mode, more external functions are supported; refer to [DQL Outer Functions](../../dql/out-funcs.md).

##### Aggregation Functions {#aggregate-function}

UI mode supports selecting aggregation methods to return result values.

| Aggregation Function | Description |
| --- | --- |
| `last` | Return the value of the latest timestamp |
| `first` | Return the value of the earliest timestamp |
| `avg` | Return the average value of the field. Parameters are only one, parameter type is field name |
| `min` | Return the minimum value |
| `max` | Return the maximum value |
| `sum` | Return the sum of the field values |
| `P50` | Return the 50th percentile value of the field |
| `P75` | Return the 75th percentile value of the field |
| `P90` | Return the 90th percentile value of the field |
| `P99` | Return the 99th percentile value of the field |
| `count` | Return the summary value of non-null field values |
| `count_distinct` | Count the number of distinct values in the field |
| `difference` | Return the difference between consecutive time values in a field |
| `derivative` | Return the rate of change of a field in a series |
| `non_negative_derivative` | Return the non-negative rate of change of a field in a series |

> In DQL mode, more aggregation functions are supported; refer to [DQL Aggregation Functions](../../dql/funcs.md).



##### Window Functions {#window}

With the selected time interval as the window (record set), combined with aggregation functions, perform statistical calculations on each record. Supports choosing 1 minute, 5 minutes, 15 minutes, 30 minutes, 1 hour, 3 hours, 6 hours, 12 hours, 24 hours.

???+ warning "Note"

    The query results of window functions do not change the number of records. The number of existing records remains unchanged after executing the function results.

##### No Data Fill {#fillin}

Set the fill method for null-value data. After setting, it is displayed as **fill** in the query, including three types:

| Function | Description |
| --- | --- |
| Previous Value Fill (previous) | Convert null-value data to the previous numerical value. |
| Linear Fill (linear) | Perform linear function calculations on null-value data and then fill. |
| Value Fill | Customizable fill value. |

##### Advanced Functions

Advanced functions are mainly used for further functional calculations on data queried by DQL and provide an intuitive Time Series chart display.

> For more details, refer to [Advanced Functions](../../dql/advanced-funcs/index.md).


#### Hide Query

Click the :material-eye-outline: icon to hide the query result of that line on the chart.

As shown in the figure below, the system only displays the query results for 1m and 15m, while the query result for 5m has been hidden and cannot be viewed on the chart.

<img src="../../img/enable_chart_query_result.png" width="70%" >

### Expression Query {#expression}

This involves adding expressions for calculation. If the expression query contains multiple query statements, the group labels must remain consistent. In expression calculations, if Query A has units, the result of operations between Query A and numbers also carries the units. For example, if the unit of A is KB, then the unit of A+100 is also KB.

![](../img/chart022.png)

### DQL Query {#dql}

After switching to DQL mode, manually input DQL statements for chart querying. A single chart supports multiple DQL queries simultaneously.

???+ warning "Note"

    Using wildcards or regular expression searches may slow down or crash the system. It is recommended to preprocess data via Pipeline before performing precise filtering to improve performance and stability.

> For more details, refer to [DQL Query](../../dql/query.md).

<img src="../../img/chart_dql_query_.png" width="70%" >



### PromQL Query {#PromQL}

Obtain data by writing PromQL queries.

| Query Method      | Description        |
| ----------- | -------- |
| Range Query      | Run queries within a certain time range        |
| Instant Query      | Run queries for a single time point        |

After adding PromQL, the default form is a text box input. In this input box, both simple PromQL queries and expression queries can be entered.

> Click to learn about [Comparison of DQL with Other Query Languages](../../dql/dql-vs-others.md#promql); or visit [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).


### Add Data Source {#func}

Perform filtering, searching, and aggregation analysis on data attributes stored in databases.

<img src="../../img/func.png" width="80%" >

> Specific configuration methods see [Function External Function Configuration](../../dql/dql-out-func.md).