# Chart Query
---

After selecting a chart, you can use various query methods to perform in-depth queries and analysis on different types of data. These query methods help intuitively display numerical information in the chart and reveal important relationships between data.

## Query Methods {#query}

A single chart supports the following query methods simultaneously:

- Simple Query
- Expression Query
- DQL Query
- PromQL Query
- Data Source

???+ warning "Switching Query Methods"

    Simple Query and DQL Query can be switched via the :fontawesome-solid-code: button. After switching, if the query cannot be parsed or is incompletely parsed:

    - If no changes were made in Simple Query mode, switching back to DQL Query will display the previous DQL query statement.
    - If the query statement was modified in Simple Query mode, switching back to DQL Query will parse according to the latest Simple Query.

![Query](../../img/query.png)

### Simple Query {#simple}

Query data from different [data sources](#source) and display it in the chart by selecting aggregation functions, grouping labels, Labels, filter conditions, etc.

#### Data Sources {#source}

Data combinations from Metrics, logs, base objects, resource catalogs, events, APM, RUM, security checks, network, Profile, cloud billing, and other sources.

| Source | Description |
| --- | --- |
| Metrics | Select **Mearsurement** and **Metrics**, one Mearsurement can contain multiple Metrics. |
| Other Types | Base objects, Resource Catalog, Security Check: Select **Resource Class** and **Attributes/Labels**; <br /> Logs, Events, APM, RUM: Select **Source** and **Attributes/Labels**. |

???- warning "When Logs are Used as Data Source"

    Different indexes can be selected to correspond to log content, with the default index being `default`.

    > For more details, refer to the documentation [Log Indexes](../../logs/multi-index/index.md).

    ![Chart Source Log](../../img/chart-source-log.png)

#### Multiple Queries

Select multiple query conditions, and the data will be grouped and displayed based on the selected filters.

To distinguish the display of query results, click the AS button to add aliases for each query condition.

![Multiple Queries](../../img/chart-multi-query.png)

If you want to display the added aliases directly on the chart, click the right side [Legend](./chart-config.md#legend) > Position, and choose bottom or right.

![Multiple Queries Legend](../../img/chart-multi-query-legend.png)

#### Label Filtering {#label}

**Prerequisite**: Labels have been set for hosts in **Infrastructure > [Hosts](../../infrastructure/host.md#label)**.

In **`fx` > Label Filter**, select or exclude host Label properties for filtering and display.

![Label Query](../../img/chart_query_label.png)

#### Adding Filters

Click the :material-filter-outline: icon to add filter conditions to the current query.

Multiple filter conditions can be added under a single query, with each condition supporting either `AND` or `OR` logical operators.

| Filter Condition | Description | Supported Filter Types |
| -------------- | ---------------------------------------- | ---------------------------- |
| `=` | Equals | `Integer`, `Float`, `String` |
| `!=` | Not equals | `Integer`, `Float`, `String` |
| `>=` | Greater than or equal to | `Integer`, `Float`, `String` |
| `<=` | Less than or equal to | `Integer`, `Float`, `String` |
| `>` | Greater than | `Integer`, `Float`, `String` |
| `<` | Less than | `Integer`, `Float`, `String` |
| `match` | Contains | `String` |
| `not match` | Does not contain | `String` |
| `wildcard` | Fuzzy match (supports log data except Metrics) | `String` |
| `not wildcard` | Fuzzy non-match (supports log data except Metrics) | `String` |

![Add Label Filter](../../img/chart_query_add_label.png)

#### Functions

Click the **fx** icon to add function calculations for Metrics and other data sources.

![Add Function](../../img/chart_query_add_fix.png)

##### Rollup Function {#rollup}

This slices data into specified time intervals and calculates and returns data for each interval.

**Note**:

1. In time series charts, after selecting this function and the aggregation method, go to **Advanced Configuration** to choose the time interval;
2. In non-time series charts, after selecting this function, choose aggregation methods like `avg`, `sum`, `min`, etc., and time intervals including auto, 10s, 20s, 30s, 1m, 5m, 10m, 30m, 1h, 6h, 12h, 1d, 7d, 30d (`interval`);
3. Only supported for Metrics queries, other data queries in simple mode do not support Rollup functions;
4. Rollup functions do not support adding multiple instances.

> For more details, refer to [Rollup Function](../../dql/rollup-func.md).

##### Transformation Functions

Also known as outer functions, UI mode supports the following functions:

| <div style="width: 180px">Transformation Function (Outer Function)</div> | Description |
| --- | --- |
| `cumsum` | Cumulative sum of the processed set |
| `abs` | Absolute value of each element in the processed set |
| `log2` | Logarithm base 2 of each element in the processed set, requires at least one row, otherwise returns null |
| `log10` | Logarithm base 10 of each element in the processed set, requires at least one row, otherwise returns null |
| `moving_average` | Moving average of the processed set, window size must be no less than the number of rows in the processed set, otherwise returns null |
| `difference` | Difference between adjacent elements in the processed set, requires at least one row, otherwise returns null |
| `derivative` | Derivative of adjacent elements in the processed set, derivative time unit is seconds (s) |
| `non_negative_derivative` | Non-negative derivative of adjacent elements in the processed set, derivative time unit is seconds (s) |
| `non_negative_difference` | Non-negative difference between adjacent elements in the processed set, requires at least one row, otherwise returns null |
| `series_sum` | When grouping produces multiple series, merges them into one series based on timestamps. Sums up values at the same timestamp, requires at least one row, otherwise returns null |
| `rate` | Rate of change of a metric over a certain time range, suitable for slowly changing counters. Time unit is seconds (s) |
| `irate` | Rate of change of a metric over a certain time range, suitable for rapidly changing counters, time unit is seconds (s) |

> In DQL mode, more external functions are supported, refer to [DQL Outer Functions](../../dql/out-funcs.md).

##### Aggregation Functions {#aggregate-function}

UI mode supports selecting aggregation methods to return result values.

| Aggregation Function | Description |
| --- | --- |
| `last` | Returns the value of the latest timestamp |
| `first` | Returns the value of the earliest timestamp |
| `avg` | Returns the average value of the field. Parameter is a single field name |
| `min` | Returns the minimum value |
| `max` | Returns the maximum value |
| `sum` | Returns the sum of field values |
| `P50` | Returns the 50th percentile value of the field |
| `P75` | Returns the 75th percentile value of the field |
| `P90` | Returns the 90th percentile value of the field |
| `P99` | Returns the 99th percentile value of the field |
| `count` | Returns the count of non-null field values |
| `count_distinct` | Counts distinct values of a field |
| `difference` | Returns the difference between consecutive time values in a field |
| `derivative` | Returns the rate of change of a field within a series |
| `non_negative_derivative` | Returns the non-negative rate of change of a field within a series |

> In DQL mode, more aggregation functions are supported, refer to [DQL Aggregation Functions](../../dql/funcs.md).

##### Window Functions {#window}

Window functions apply statistical calculations to each record using selected time intervals (record sets), supporting intervals of 1 minute, 5 minutes, 15 minutes, 30 minutes, 1 hour, 3 hours, 6 hours, 12 hours, 24 hours.

**Note**: Window function query results do not change the number of records; the number of existing records remains unchanged after executing the function.

##### No Data Fill {#fillin}

Set the fill method for null data values, which will be displayed as **fill** in queries. There are three types:

| Function | Description |
| --- | --- |
| Previous Value Fill (previous) | Converts null values to the previous value. |
| Linear Fill (linear) | Fills null values using linear interpolation. |
| Value Fill | Customizable fill value. |

##### Advanced Functions

Advanced functions are used to further process data queried by DQL and display intuitive time series charts. Guance supports custom functions for secondary processing and returning data results.

> For more details, refer to [Advanced Functions](../../dql/advanced-funcs/index.md).

#### Hide Query

Click the :material-eye-outline: icon to hide the query result on the chart.

As shown below, the system only displays the query results for 1m and 15m, while the 5m system load query result is hidden and cannot be viewed on the chart.

![Enable Chart Query Result](../../img/enable_chart_query_result.png)

### Expression Query

Perform calculations by adding expressions. If an expression query contains multiple query statements, grouping labels must remain consistent. In expression calculations, if Query A has units, the result of Query A with a number also carries the same units. For example, if A's unit is KB, then A + 100 will also have the unit KB.

![](../img/chart022.png)

### DQL Query

Guance supports switching to DQL mode to manually input DQL statements for chart queries.

> A single chart can support multiple DQL queries. For more details, refer to [DQL Query](../../dql/query.md).

![](../../img/chart021.png)

### PromQL Query {#PromQL}

Guance supports writing PromQL queries to retrieve data.

PromQL is added by default as a text box input. In this input box, both simple PromQL queries and expression queries can be entered.

> Click to learn about [Comparison Between DQL and Other Query Languages](../../dql/dql-vs-others.md#promql); or visit [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).


### Add Data Source {#func}

Filter, search, and aggregate analyze data attributes stored in databases.

![](../../img/func.png)

> Specific configuration methods can be found in [External Function Configuration](../../dql/dql-out-func.md).