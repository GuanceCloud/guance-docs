# DQL Query
---

Click on the **Shortcut > Query Tool** in the Guance console to open the query Explorer, or you can use the shortcut keys `Alt+Q` or `option+Q` to directly open the query tool.

![](img/3.dql_6.png)

> Click the **[Simple Query](../scene/visual-chart/chart-query.md#simple)** and **[PromQL Query](../scene/visual-chart/chart-query.md#promql)** buttons to the right of **DQL Query** to switch query methods.


## Related Actions

### Return Results

In the DQL query window, input a DQL query statement and click **Execute** to view the query results in **Return Results**. The **Return Results** displays the query results in table format, with a default return of 1000 records. You can export the returned data as a CSV file.

**Note:** When using DQL query statements, you can use [limit](define.md#limit) or [slimit](define.md#slimit) to control the number of returned query results.

![](img/3.dql_1.png)

If there is an error in the DQL query statement, you can also see the error message in **Return Results**.

![](img/3.dql_7.png)

### JSON

If the DQL query statement is correct, after returning the query results, you can view the JSON structured query results in **JSON**, which supports copying JSON. If the DQL query returns an error result, the error information will also be displayed in **JSON**.

![](img/3.dql_3.png)

### Query History

Query history supports viewing up to 100 query history records for the past 7 days by day, and supports fuzzy search of query statements.

![](img/3.dql_4.png)

Click the execute button ![](img/3.dql_8.png) to the right of the query history data to directly display the corresponding query statement and query results.

![](img/3.dql_1.png)

## DQL Syntax

DQL queries follow the syntax paradigm below, where the relative order between parts cannot be changed. From a syntactical perspective, `data-source` is mandatory (similar to the `FROM` clause in SQL), while other parts are optional.

> For more details on DQL syntax, refer to the documentation [DQL Definition](../dql/define.md).

```
namespace::
	data-source
	target-clause
	filter-clause
	time-expr
	by-clause
	limit-clause
	offset-clause
	slimit-clause
	soffset-clause
```

### <u>Example Explanation</u>

Below is a simple example that uses DQL to query the `usage_idle` field (CPU idle rate) from the time series Metrics set `cpu`, filtering and grouping the results by host. Here, `#{host}` is a view variable set in the Guance dashboard for filtering.

![](img/4.DQL_2.1.png)

Applying the above statement to the chart query in the Guance scene dashboard, the following image combines expression queries and DQL queries to display CPU usage over the last 15 minutes.

![](img/4.DQL_2.png)

## DQL Functions

In addition to using DQL queries in scene dashboards, we can also use DQL functions to query various data collected by DataKit, such as data sources, fields, tags, etc.

### SHOW Function

The SHOW function is used to display various types of data. If you are not clear about the data sources, fields, tags, etc., collected by DataKit, you can use the SHOW function in the DQL query Explorer to query them.

Below are examples of using the SHOW function to query sources, fields, etc., for "objects" and "logs".

> For more details on functions, refer to the documentation [DQL Functions](../dql/funcs.md) and [DQL Outer Functions](../dql/out-funcs.md).

#### show_object_source()

Displays the Metrics set for `object` data.

![](img/3.dql_9.png)

#### show_object_field()

Displays the `fields` list for objects.

![](img/3.dql_10.png)

#### show_object_label()

Displays the label information included in objects.

![](img/3.dql_11.png)

#### show_logging_source()

Displays the Metrics set for log data.

![](img/3.dql_12.png)

#### show_logging_field()

Displays all `fields` lists under a specified `source`.

![](img/3.dql_13.png)


## Time Query {#query_time}

In DQL query statements, you can specify time parameters like `[today]`, `[yesterday]`, `[this week]`, `[last week]`, `[this month]`, `[last month]`.

- today: from midnight today to the current time;
- yesterday: from midnight yesterday to midnight today;
- this week: from midnight Monday of this week to the current time;
- last week: from midnight Monday of last week to midnight Monday of this week;
- this month: from midnight on the 1st of this month to the current time;
- last month: from midnight on the 1st of last month to midnight on the 1st of this month;

### Example Syntax


To query data from midnight today until now without a time interval, returning one data point:

```
M::cpu:(avg(`useage`)) [today]
```


For example, to query data from midnight today until now with a 5-minute time interval, returning aggregated data points:

```
M::cpu:(avg(`usage`)) [today:5m]
```

Expression calculations can also support querying data from two different time periods for final result calculation. If multiple different time parameters are defined in the expression, such as subquery A and subquery B defining time parameters as `[today]` and `[yesterday]` respectively, the final data return value's time will be filled according to the `now()` time at the time of the query, ultimately returning one data point.


If a time interval is defined in the expression and the query times of multiple queries do not align, such as subquery A and subquery B defining time parameters as `[today:5m]` and `[yesterday:5m]` respectively, the data points' times do not match, making it impossible to perform arithmetic operations. In this case, Guance will default to returning an empty value.