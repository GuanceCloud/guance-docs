# DQL Query
---

Click <<< custom_key.brand_name >>> console's **Shortcut > Query Tool** to open the query explorer, or you can use the shortcut keys `Alt+Q` or `option+Q` to directly open the query tool.


> Click the **[Simple Query](../scene/visual-chart/chart-query.md#simple)** and **[PromQL Query](../scene/visual-chart/chart-query.md#promql)** buttons on the right side of **DQL Query** to switch the query method.


## Options

### Return Results

Enter a query statement in the DQL query window, click **Execute**, and you can view the query results in **Return Results**.

The query results will be displayed in table format, with the system defaulting to returning a maximum of 2,000 data entries. You can also export these data as a CSV file.

**Note:** When using DQL query statements, you can control the number of returned query results using the [slimit](define.md#slimit) parameter.

![](img/3.dql_1.png)


### JSON

Query results support viewing in JSON format. If the DQL query returns an error result, the error message will be directly indicated in the JSON.

![](img/3.dql_3.png)

### Query History

Query history supports viewing up to 100 query history records from the last 7 days by day, and it supports fuzzy searching for query statements.

![](img/3.dql_4.png)

Click the execute button :octicons-play-16: on the right side of the query history data to directly display the corresponding query statement and its results.

![](img/3.dql_1.png)

## DQL Syntax

DQL queries follow the syntax paradigm below; the relative order between different parts cannot be changed. From a syntax perspective, `data-source` is mandatory (similar to the `FROM` clause in SQL), while other parts are optional.

> For more details about DQL syntax, refer to the document [DQL Definition](../dql/define.md).

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

Below is a simple example that queries the field `usage_idle` (CPU idle rate) of the time series Metrics set `cpu` using DQL, filtering and grouping by host. Here, `#{host}` is a view variable set in the <<< custom_key.brand_name >>> dashboard used for filtering.

![](img/4.DQL_2.1.png)

Applying the above statement to the chart query in the <<< custom_key.brand_name >>> scene dashboard, the following image combines expression queries and DQL queries to display CPU usage over the past 15 minutes.

![](img/4.DQL_2.png)

## DQL Functions

In addition to using DQL queries in scene dashboards, we can also query various DataKit-collected data, such as data sources, fields, and tags, using DQL functions.

### SHOW Function

The SHOW function is used to display various types of data. If you do not have a clear understanding of the data sources, fields, and tags collected by DataKit, you can use the SHOW function in the DQL query explorer to query them.

Below are examples of querying the sources, fields, etc., for "objects" and "logs" using the SHOW function.

> For more information about functions, refer to the documents [DQL Functions](../dql/funcs.md) and [DQL Outer Functions](../dql/out-funcs.md).

#### show_object_source()

Displays the Metrics sets for `object` data.

![](img/3.dql_9.png)

#### show_object_field()

Displays the list of fields for objects.

![](img/3.dql_10.png)

#### show_object_label()

Displays the labels included in the object.

![](img/3.dql_11.png)

#### show_logging_source()

Displays the Metrics sets for log data.

![](img/3.dql_12.png)

#### show_logging_field()

Displays all fields under a specified `source`.

![](img/3.dql_13.png)


## Time Queries {#query_time}

In DQL query statements, you can specify `[today]`, `[yesterday]`, `[this week]`, `[last week]`, `[this month]`, `[last month]` time parameters.

- today: From midnight today to the current time;
- yesterday: From midnight yesterday to midnight today;
- this week: From midnight Monday of this week to the current time;
- last week: From midnight Monday of last week to midnight Monday of this week;
- this month: From midnight on the 1st of this month to the current time;
- last month: From midnight on the 1st of last month to midnight on the 1st of this month;

### Example Writing


To query data from midnight today until now without a time interval, returning one data point:

```
M::cpu:(avg(`useage`)) [today]
```


For example, to query data from midnight today until now with a 5-minute time interval, returning aggregated data points:

```
M::cpu:(avg(`usage`)) [today:5m]

```

Expression calculations can also support querying data from two different time periods for final result calculations. If there are multiple different time parameters defined in the expression, such as `[today]` and `[yesterday]` in subqueries A and B, the final data return value will be filled according to the `now()` time when querying, ultimately returning one data point.


If a time interval is defined in the expression and there are inconsistent query times across multiple queries, such as `[today:5m]` and `[yesterday:5m]` in subqueries A and B, the data points' times will not align, making it impossible to perform arithmetic operations. In this case, <<< custom_key.brand_name >>> will default to returning a null value.