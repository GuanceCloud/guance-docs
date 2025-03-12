# DQL Query
---

## Introduction

In the Guance workspace, click Shortcut Entry-DQL Query in the menu bar to open the DQL Query Explorer, or you can directly open the DQL Query through the shortcut key `Alt+Q`.<br />![](img/3.dql_6.png)

### Simple Query
Click the toggle button on the right side of DQL Query ![](img/3.dql_5.png), you can switch DQL queries to simple queries.<br />Note: When DQL Query is switched to Simple Query, if it cannot be parsed or parsed incompletely:

- If you do not operate under Simple Query, switch back to DQL Query directly to display the previous DQL query statement;
- Adjust the query statement under Simple Query, and switch back to DQL Query again to parse according to the latest Simple Query.

![](img/3.dql_2.png)

### Return Results

Enter the DQL query statement in the DQL query window, and click anywhere else to view the query results in Return Results. The button Return Results returns query results in tabular form, with a maximum of 1000 pieces of data. It supports exporting CSV files and clicking to view help documents. <br />![](img/3.dql_1.png)<br />If there is an error in the DQL query statement, you can also see the error prompt in Return Results.<br />![](img/3.dql_7.png)

### JSON

If the DQL query statement is correct, you can view the query results of Json structure in JSON after returning the query results. Copying Json and clicking to view help documents are supported. If the DQL query returns an error result, an error message is prompted at the same time as "JSON".<br />![](img/3.dql_3.png)

### Query History

Query history supports viewing 100 query history data within 7 days on a daily basis and supports fuzzy search for query statements.<br />![](img/3.dql_4.png)<br />Click the execute button to the right of the query history![](img/3.dql_8.png), which directly displays the corresponding query statement and query results.<br />![](img/3.dql_1.png)

## DQL Syntax

DQL queries follow the syntax pattern that the relative order of the parts cannot be swapped, that `data-source` is syntactically required (similar to the  `FROM` clause in SQL), and that all other parts are optional. Refer to the document [DQL Definition](../dql/define.md) 。
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

### Example Description

Here is a simple example of querying the field usage_idle (CPU idle rate) of the temporal measurement cpu through DQL, filtering the filter as host, and displaying the results in groups as host. Where # {host} is the view variable set in the Guance dashboard for filtering.<br />![](img/4.DQL_2.1.png)

Apply the above statement to the chart query of Guance Scene Dashboard. The following figure combines expression query and DQL query to show the CPU utilization in the last 15 minutes. <br />![](img/4.DQL_2.png)

## DQL Function

DQL query can be used in scene dashboard, and we can also query various data collected by DataKit through DQL function, such as data source, field, label and so on.

### SHOW Function

SThe SHOW function is used to show all kinds of data. If you don't have a clear understanding of the data sources, fields and labels collected through DataKit, you can query them through the SHOW function in DQL query explorer.

Next, query the source, field and other data of Object and Log through SHOW function. See the documentation [DQL Function](../dql/funcs.md) and [DQL Outer Function](../dql/out-funcs.md) 。

#### show_object_source()

Showing the metric collection of `object` data .<br />![](img/3.dql_9.png)

#### show_object_field()

Showing the `fileds` list of objects.<br />![](img/3.dql_10.png)

#### show_object_label()

Showing the label information contained in the object.<br />![](img/3.dql_11.png)

#### show_logging_source()

Showsing a collection of metrics for log data.<br />![](img/3.dql_12.png)

#### show_logging_field()

Showing all files lists under the specified `source`.<br />![](img/3.dql_13.png)


---

