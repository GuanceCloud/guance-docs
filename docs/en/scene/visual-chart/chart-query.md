# Chart Query
---

After selecting a chart, various query methods can be used to perform in-depth queries and analyses on different categories of data. This helps intuitively display numerical information in the chart and reveal important relationships between data.

## Query Methods {#query}

A single chart supports the following query methods:

:material-numeric-1-circle: [Simple Query](#simple)
:material-numeric-2-circle: [Expression Query](#expression)
:material-numeric-3-circle: [DQL Query](#dql)
:material-numeric-4-circle: [PromQL Query](#promql)
:material-numeric-5-circle: [Data Source](#func)

???+ abstract "Switch Query Method"

    Simple Query and DQL Query can be switched via the :fontawesome-solid-code: button. If it cannot be parsed or is incompletely parsed after switching:

    - No operation under Simple Query, switching back to DQL Query displays the previous DQL Query statement;
    - Adjustments made to the query statement under Simple Query, switching back to DQL Query parses according to the latest simple query.

<img src="../../img/query.png" width="70%" >


### Simple Query {#simple}

Queries data from different [data sources](#source) and displays charts through selecting aggregation functions, grouping labels, Labels, and filtering conditions.


#### Data Sources {#source}

Includes a series of data combinations from Metrics, Logs, Basic Objects, Resource Catalogs, Events, APM, RUM, Security Check, NETWORK, Profile, Cloud Billing.

| Source | Description |
| --- | --- |
| Metrics | Need to select **Measurement** and **Metrics**, one Measurement can contain multiple Metrics. |
| Other Types | Basic Objects, Resource Catalogs, Security Check: Need to select **Resource Class** and **Properties/Labels**;<br />Logs, Events, APM, RUM: Need to select **Source** and **Properties/Labels**. |

???+ warning "When Logs are Used as Data Source"

    You can choose different indexes corresponding to log content, default index is `default`.
    
    > For more details, refer to the documentation [Log Index](../../logs/multi-index/index.md).

#### Multiple Queries

Select multiple query conditions, data will be grouped and displayed according to the selected filter items. Click the AS button to add aliases for each query condition, making it easier to distinguish the display of data query results.

<img src="../../img/chart-multi-query.png" width="70%" >

If you wish to directly display added aliases on the chart, click on the right-hand [Legend](./chart-config.md#legend) > Position, and select bottom or side.

<img src="../../img/chart-multi-query-legend.png" width="70%" >

#### Label Filtering {#label}

**Prerequisite**: Labels have been set for hosts in **Infrastructure > [HOST](../../infrastructure/host.md#label)**.

In **`fx` > Label Filtering**, either positively or negatively select HOST Label properties for filtering and displaying.

<img src="../../img/chart_query_label.png" width="70%" >



#### Add Filters

Click the :material-filter-outline: icon to add filter conditions for the current query.

Multiple filter conditions can be added under a single query, with two options between each filter condition: `AND` and `OR`.

| Filter Condition       | Description                                     | Supported Filter Condition Types           |
| -------------- | ---------------------------------------- | ---------------------------- |
| `=`            | Equals                                    | `Integer`, `Float`, `String` |
| `!=`           | Not Equal                                 | `Integer`, `Float`, `String` |
| `>=`           | Greater Than or Equal To                  | `Integer`, `Float`, `String` |
| `<=`           | Less Than or Equal To                     | `Integer`, `Float`, `String` |
| `>`            | Greater Than                              | `Integer`, `Float`, `String` |
| `<`            | Less Than                                 | `Integer`, `Float`, `String` |
| `match`        | Contains                                  | `String`                     |
| `not match`    | Does Not Contain                         | `String`                     |
| `wildcard`     | Fuzzy Match (supports log-type data except Metrics)   | `String`                     |
| `not wildcard` | Fuzzy Non-Match (supports log-type data except Metrics) | `String`                     |


<img src="../../img/chart_query_add_label.png" width="70%" >

#### Functions

Click the **fx** icon to add function calculations for this query's data source.

<img src="../../img/chart_query_add_fix.png" width="70%" >


##### Rollup Function {#rollup}

Slices data into specified time-interval data and calculates and returns data for each time interval.

???+ warning "Note"

    - In Time Series charts, after selecting this function along with an aggregation method, go to **Advanced Configuration** to select the time interval;
    - In non-Time Series charts, after selecting this function, you can choose aggregation methods including `avg`, `sum`, `min`, etc., and time intervals including auto, 10s, 20s, 30s, 1m, 5m, 10m, 30m, 1h, 6h, 12h, 1d, 7d, 30d (`interval`);
    - Only supports Metrics data queries; other data queries under the chart's simple mode do not support selecting the Rollup function;
    - The Rollup function does not support adding multiple instances.

> For more details, refer to [Rollup Function](../../dql/rollup-func.md).

##### Transformation Functions

Also known as outer functions, the UI mode supports selecting the following functions:

| <div style="width: 180px">Transformation Function (Outer Function)</div> | Description |
| --- | --- |
| `cumsum` | Calculates the cumulative sum of the processing set |
| `abs` | Computes the absolute value of each element in the processing set |
| `log2` | Computes the base-2 logarithm of each element in the processing set, the processing set must be at least greater than one row, otherwise it returns null |
| `log10` | Computes the base-10 logarithm of each element in the processing set, the processing set must be at least greater than one row, otherwise it returns null |
| `moving_average` | Computes the moving average of the processing set, the window size needs to be no less than the number of rows in the processing set, otherwise it returns null |
| `difference` | Computes the difference between adjacent elements in the processing set, the processing set must be at least greater than one row, otherwise it returns null |
| `derivative` | Computes the derivative of adjacent elements in the processing set, the unit of derivation is seconds (s) |
| `non_negative_derivative` | Computes the non-negative derivative of adjacent elements in the processing set, the unit of derivation is seconds (s) |
| `non_negative_difference` | Computes the non-negative difference between adjacent elements in the processing set, the processing set must be at least greater than one row, otherwise it returns null |
| `series_sum` | When grouping produces multiple series, merges them into one series based on the time points. Sums up multiple series at the same time point, the processing set must be at least greater than one row, otherwise it returns null |
| `rate` | Computes the rate of change of a metric within a certain time range, suitable for slowly changing counters. The time unit is seconds (s) |
| `irate` | Computes the rate of change of a metric within a certain time range, suitable for rapidly changing counters. The time unit is seconds (s) |

> In DQL mode, more outer functions are supported, refer to [DQL Outer Functions](../../dql/out-funcs.md).

##### Aggregation Functions {#aggregate-function}

The UI mode supports selecting aggregation methods to return result values.

| Aggregation Function | Description |
| --- | --- |
| `last` | Returns the value of the latest timestamp |
| `first` | Returns the value of the earliest timestamp |
| `avg` | Returns the average value of the field. The parameter has only one, and the parameter type is the field name |
| `min` | Returns the minimum value |
| `max` | Returns the maximum value |
| `sum` | Returns the sum of the field values |
| `P50` | Returns the 50th percentile value of the field |
| `P75` | Returns the 75th percentile value of the field |
| `P90` | Returns the 90th percentile value of the field |
| `P99` | Returns the 99th percentile value of the field |
| `count` | Returns the total count of non-null field values |
| `count_distinct` | Counts the number of distinct values in the field |
| `difference` | Returns the difference between consecutive time values in a field |
| `derivative` | Returns the rate of change of a field in a series |
| `non_negative_derivative` | Returns the non-negative rate of change of a field in a series |

> In DQL mode, more aggregation functions are supported, refer to [DQL Aggregation Functions](../../dql/funcs.md).



##### Window Functions {#window}

With the selected time interval as a window (record collection), combined with aggregation functions, performs statistical calculations on each record, supporting selections of 1 minute, 5 minutes, 15 minutes, 30 minutes, 1 hour, 3 hours, 6 hours, 12 hours, 24 hours.

???+ warning "Note"

    The results of the window function query will not change the number of records, the number of existing records remains unchanged after executing the function.

##### No Data Fill {#fillin}

Set the fill method for empty data values, after setting, it appears as **fill** in the query, includes three types:

| Function | Description |
| --- | --- |
| Previous Value Fill (previous) | Converts missing data to the previous numerical value. |
| Linear Fill (linear) | Calculates linear functions for missing data and fills accordingly. |
| Numerical Fill | Allows custom numerical fill values. |

##### Advanced Functions

Advanced functions are mainly used for further function calculations on data queried by DQL and provide intuitive Time Series graph displays.

> For more details, refer to [Advanced Functions](../../dql/advanced-funcs/index.md).


#### Hide Query

Click the :material-eye-outline: icon to hide the query result for this line on the chart.

As shown below, the system only displays the query results for 1m and 15m, the query result for 5m system load has been hidden and cannot be viewed on the chart.

<img src="../../img/enable_chart_query_result.png" width="70%" >

### Expression Query {#expression}

That is, performing calculations by adding expressions. If the expression query contains multiple query statements, group tags need to remain consistent. In expression calculations, if Query A carries units, the result of Query A with numbers also carries units. For example: If the unit of A is KB, then the unit of A+100 is also KB.

![](../img/chart022.png)

### DQL Query {#dql}

After switching to DQL mode, manually input DQL statements for chart queries. A chart simultaneously supports multiple DQL queries.

???+ warning "Note"

    Using wildcards or regular expressions for search may slow down or crash the system. It is recommended to preprocess data via Pipeline before precise filtering to enhance performance and stability.

> For more details, refer to [DQL Query](../../dql/query.md).

<img src="../../img/chart_dql_query_.png" width="70%" >



### PromQL Query {#PromQL}

Obtain data by writing PromQL queries.

| Query Type      | Description        |
| ----------- | -------- |
| Range Query      | Runs queries over a specific time range        |
| Instant Query      | Runs queries against a single time point        |

PromQL defaults to text box input. In this text box, both PromQL simple queries and expression queries can be entered.

> Click to learn about [Comparison Between DQL and Other Query Languages](../../dql/dql-vs-others.md#promql); or visit [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).


### Add Data Source {#func}

Perform filtering, searching, and aggregation analysis operations on data attributes stored in databases.

<img src="../../img/func.png" width="80%" >

> Specific configuration methods see [Function External Function Configuration](../../dql/dql-out-func.md).