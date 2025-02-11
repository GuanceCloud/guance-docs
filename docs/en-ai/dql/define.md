# DQL Definition
---

Below is the definition of the DataFlux Query Language (DQL). As support for different syntaxes gradually expands, this document will undergo adjustments and additions to varying degrees.

Global constraints are as follows:

- Non-keywords (such as metric names, label names, etc.) are case-sensitive, while <u>keywords and function names are case-insensitive</u>;

- `#` is used as a line comment character, inline comments are not supported;

- Supported operators:

	- `+`  - Addition
	- `-`  - Subtraction
	- `*`  - Multiplication
	- `/`  - Division
	- `%`  - Modulo
	- `=` - Equal to
	- `!=` - Not equal to
	- `<=` - Less than or equal to
	- `<` - Less than
	- `>=` - Greater than or equal to
	- `>` - Greater than
	- `^` - Exponentiation
	- `&&` - Logical AND
	- `||` - Logical OR

- Supported keywords:

```
AND AS ASC AUTO
BY DESC FALSE
LIMIT LINEAR
NIL OFFSET OR PREVIOUS
SLIMIT SOFFSET TRUE
```

- Identifiers: There are several forms of identifiers to accommodate various variable naming conventions:

	- Normal variable names can only contain `[_a-zA-Z0-9]`, and the first character cannot be a digit. For example `_abc, _abc123, _123ab`.
	- Other forms of variable names:
		- `this+is-a*xx/yy^zz?variable`, `by` should be written as `` `this+is-a*xx/yy^zz?variable` `` or `` `by` ``. The former contains operators within the variable, while the latter `by` is a DQL keyword.
		- UTF8 identifiers such as Chinese characters are supported, e.g., `M::cpu:(usage AS usage_rate) [5m]`.
			- Emoji support: `M::cpu:(usage AS usage_rate👍) [5m]`.
		- If a variable contains a backtick, `` this`is-a-variable `` should be written as `` `identifier("this`is-a-variable")` ``.

- String values can use double quotes and single quotes: `"this is a string"` and `'this is a string'` are equivalent.

- Special strings:
	- Base64 strings: DQL supports handling base64 strings. For base64 strings, DQL can automatically decode the original string during queries. Syntax:
		- `` b64`some-base64-string` ``
		- `b64'some-base64-string'`
		- `b64"some-base64-string"`

	- Regular expression strings: The old `re('xxx')` has been deprecated; it is recommended to use the following format to denote regex strings.
		- `` re`some-regexp` ``* (recommended)*
		- `re'some-regexp'`
		- `re"some-regexp"`

- Supported data types:
	- Floating point (`123.4`, `5.67E3`)
	- Integer (`123`, `-1`)
	- String (`'张三'`, `"hello world"`)
	- Boolean (`true`, `false`)
	- Duration (`1y`, `1w`, `1d`, `1h`, `1m`, `1s`, `1ms`, `1us`, `1ns` representing 1 year/week/day/hour/minute/second/millisecond/microsecond/nanosecond)

## Queries

Queries follow the following syntactical paradigm. Note that the relative order between parts cannot be changed, such as `time-expr` cannot appear before `filter-clause`.

```
namespace::
	data-source
	target-clause
	filter-clause
	time-expr
	by-clause
	having-clause
	order-by-clause
	limit-clause
	offset-clause
	sorder-by-clause
	slimit-clause
	soffset-clause
```

From a syntactic perspective, `data-source` is mandatory (similar to the `FROM` clause in SQL), other parts are optional. However, during actual query execution, certain constraints may be applied (for example, `time_expr` does not allow too large time spans).

Example:

```python
# Get all fields of the metric set cpu for the last 5 minutes
M::cpu [5m]

# Find all metrics matching the regular expression *db for the last 5 minutes
M::re('*db') [5m]

# Get all field data of the metric set cpu from 10 minutes ago to 5 minutes ago
M::cpu [10m:5m]

# Get all field data of the metric set cpu from 10 minutes ago to 5 minutes ago, aggregated every minute
M::cpu:(usage_idle) [10m:5m:1m]

# Query two fields, time_active, time_guest_nice, of the time series data set cpu for the last 5 minutes,
# filtered by host and cpu tags, and grouped by host and cpu to display results.
M:: cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m] BY host,cpu

# Sort by height in descending order, get top ten
O::human:(height, age) { age > 100, sex = "直男" } ORDER BY height desc LIMIT 10

M::cpu,mem:(time_active, time_guest_nice, host) { host = "host-name", cpu = "cpu0" } [5m] BY host,cpu
```

**Note:** Spaces can be added around `::` and `:` as shown below, these statements are equivalent:

```python
M::cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   ::cpu : (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   :: cpu :   (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]
```

### Examples of Queries for Various Data Types {#example}

- M::`metric_set_name`:(aggregate_function(`metric_name`)) { `label_name` = 'label_value' } BY `label_name`

	- Example: M::`cpu`:(last(`usage_system`)) {`host`=`xxx`} BY `host_ip`

- L::`log_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: L::`datakit`:(COUNT(`*`)) { `index` = 'default' } BY `host`

- O::`category_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

    - Example: O::`HOST`:(COUNT(`*`)) { `class` = 'HOST' } BY `host_ip`

- E::`event_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: E::`monitor`:(COUNT(`create_time`)) { `create_time` = 1688708829409 } BY `df_event_id`

- T::`service_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: T::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

- R::`data_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: R::`error`:(LAST(`browser`)) { `city` = 'unknown' } BY `city`

- S::`category_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: S::`storage`:(LAST(`host`)) { `level` = re('warn') } BY `level`

- N::`network_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: N::`httpflow`:(FIRST(`direction`)) { `http_version` = '1.1' } BY `dst_ip_type`

- P::`profiling_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: P::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

Without using aggregate functions:

For example:

- Counting containers under different namespaces:

O::`docker_containers`:(COUNT(`*`)) BY `namespace`

- Query all fields of containers and return the latest 10 records:

O::`docker_containers` {`host`=`xxx`} limit 10

## Statements

### Namespace {#namespace}

Semantically, currently the following data sources are supported:

- M/metric - Time series metric data
- O/object - Object data
- CO/custom_object - User resource catalog data
- L/logging - Log data
- E/event - Event data
- T/tracing - Tracing data
- R/rum - RUM data
- F/func - Func function computation
- N/network - Network eBPF data lookup

In terms of syntax, there are no constraints on data sources. Data source syntax is as follows:

```python
data-source ::
	# specific query details...
```

In specific queries, if the data source is not specified, it defaults to `metric` (or `M`), meaning time series metrics are the default data source for DQL.

### Target Clause

The result list of the query:

```python
M::cpu:(time_active, system_usage) {host="biz_prod"} [5m]

# This supports performing calculations between different metrics within the same metric set (types must generally match)
M::cpu:(time_active+1, time_active/time_guest_nice) [5m]
```

### Filter Clause

The filter clause is used to filter the result data, similar to the `where` condition in SQL:

```python
# Query the height of centenarian heterosexual males in the human object class
O::human:(height) { age > 100, sex = "直男" }

# Filtering with regex
O::human:(height) { age > 100, sex != re("男") }

# Filtering with calculation expressions
O::human:(height) { (age + 1)/2 > 31, sex != re("男") }

# Filtering with OR expressions
O::human:(height) { age > 31 || sex != re("男"), weight > 70}

# Aggregated result column
M::cpu:(avg(time_active) AS time_active_avg) [1d::1h]

# Aggregated result column with fill
M::cpu:(fill(avg(time_active) AS time_active_avg, 0.1)) [1d::1h]

# Query with an IN list, where options in the IN list are logically ORed, and can only be numbers or strings
O::human:(height) { age in [30, 40, 50], weight > 70}
```

Regarding filling:

- Numeric filling: e.g., `cpu:(fill(f1, 123), fill(f2, "foo bar"), fill(f3, 123.456))`
- Linear filling: e.g., `cpu:(fill(f1, LINEAR))`
- Previous value filling: e.g., `cpu:(fill(f1, PREVIOUS))`

**Note:** Multiple filter conditions are by default `AND` related, but to express `OR` relationships, use the `||` operator. The following two statements have the same meaning:

```python
O::human:(height) { age > 31, sex != re("男") }
O::human:(height) { age > 31 && sex != re("男") }
```

A more complex filter expression:

```python
M::some_metric {(a>123.45 && b!=re("abc")) || (z!="abc"), c=re("xyz")} [1d::30m]
```

### Time Expression

DataFlux data all have a time attribute, so time expression is represented by a separate clause:

`time-expr` consists of 3 parts [`start_time`:`end_time`:`interval`:`rollup`]:

| No. | Name         | Required | Description                                                                                                 | Example                           |
| ---- | ------------ | -------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| 1    | `start_time` | No       | Start time for time filtering                                                                               | `1672502400000` / `1672502400`     |
| 2    | `end_time`   | No       | End time for time filtering                                                                                 | `1672588800000` / `1672588800`     |
| 3    | `interval`   | No       | Time aggregation period, usually used with aggregation or rolling aggregation, supports `s`, `m`, `h`, `d` units | `1s`/`1m`/`1h`                    |
| 4    | `rollup`     | No       | Rolling aggregation function name, currently supported aggregation functions include `avg`, `sum`, `min`, `max`, `count`, `first`, `last`, `stddev` | `last`                            |

**Note:**

`start_time`, `end_time` support 3 formats:

- Numerical with time units, e.g., `1m`
- Timestamp, e.g., `1672502400`
- Milliseconds timestamp, e.g., `1672502400000`

`interval` supports the following time units:

- `ns` - Nanoseconds
- `us` - Microseconds
- `ms` - Milliseconds
- `s` - Seconds
- `m` - Minutes
- `h` - Hours
- `d` - Days
- `w` - Weeks
- `y` - Years, defined as 365 days without considering leap years.

`rollup` rolling aggregation functions currently supported:

- `avg`: Average
- `sum`: Sum
- `min`: Minimum
- `max`: Maximum
- `count`: Count
- `first`: First
- `last`: Last
- `deriv`: Rate of change per second, estimated by subtracting the first value from the last and dividing by the time interval
- `rate`: Rate of change per second, similar to `deriv` but returns non-negative results, consistent with PromQL logic
- `irate`: Instantaneous rate of change, estimated by subtracting the previous value from the current one and dividing by the time interval, consistent with PromQL logic
- `p99`, `p95`, `p90`, `p75`: Percentile calculations, supporting any percentage after `p`
- `median`: Median, equivalent to `p50`
- `stddev`: Standard deviation

Rolling aggregation splits a single timeline into different time segments based on the given `interval` and performs aggregation on each segment. When `rollup` is empty, no rolling aggregation is performed.

Common examples:

- `[5m]` - Last 5 minutes
- `[10m:5m]` - From 10 minutes ago to 5 minutes ago
- `[10m:5m:1m]` - From 10 minutes ago to 5 minutes ago, aggregated every minute
- `[1672502400000:1672588800000]` - From `2023-01-01 00:00:00` to `2023-01-02 00:00:00`
- `[1672502400:1672588800]` - From `2023-01-01 00:00:00` to `2023-01-02 00:00:00`

### By Clause Statement

The `BY` clause is used for classification and aggregation of results, similar to MySQL's `GROUP BY`.

### Having Clause Statement

The `HAVING` clause is used to filter results after aggregation, similar to MySQL's `HAVING`.

```python
# Get all hosts with CPU usage greater than 80%
M::cpu:(max(`usage_total`) as `max_usage`) by host having max_usage > 80
```

### Order By Clause Statement

The `ORDER BY` clause sorts the results, similar to MySQL's `ORDER BY`.

**Note:** 1. Metric data only supports sorting by the `time` field; 2. When the query includes grouping with `by`, `order-by` will not take effect, please use `sorder-by` for sorting.

```python
# Get all host CPU usage, ordered by time in descending order
M::cpu:(`usage_total`) order by time desc
```

```python
# Get all log data, ordered by response time in ascending order
L::`*`:(`*`) order by response_time asc
```

### SOrder By Clause Statement

The `SORDER BY` clause sorts groups.

```python
# Get the maximum CPU usage of different hosts, ordered by hostname in descending order
M::cpu:(max(`usage_total`)) by host sorder by host desc
```

```python
# Get the maximum CPU usage of different hosts, ordered by maximum CPU usage in ascending order
M::cpu:(max(`usage_total`) as m) by host sorder by m
```

```python
# Get the CPU usage of different hosts, ordered by the latest CPU usage in ascending order
M::cpu:(`usage_total`) sorder by usage_total
```

### Limit Statement

Used to specify the number of returned rows,

**Note:**

For time series data, if both `by` and `limit` clauses are included in the DQL statement, `limit` constrains the number of returned rows within each aggregation group.

```python

# Return three cpu records
M::cpu:() limit 3

# Return three cpu records for each host
M::cpu:() by host limit 3
```

### SLimit Statement

Used to specify the number of groups

```python
# Return CPU usage information for three hosts
M::cpu:(last(usage_total)) by host slimit 3

# Return CPU usage information for three hosts, with each host returning three records
M::cpu:() by host limit 3 slimit 3
```

### SHOW Statement

`SHOW_xxx` is used to browse data (function names are case-insensitive):

- `SHOW_MEASUREMENT()` - View the list of metric sets, supports `filter-clause`, `limit`, and `offset` statements
- `SHOW_OBJECT_CLASS()` - View the list of object classes
- `SHOW_CUSTOM_OBJECT_SOURCE()` - View the list of resource catalog data types
- `SHOW_EVENT_SOURCE()` - View the list of event sources
- `SHOW_LOGGING_SOURCE()` - View the list of log sources
- `SHOW_TRACING_SERVICE()` - View the list of tracing sources
- `SHOW_RUM_TYPE()` - View the list of RUM data types
- `SHOW_NETWORK_SOURCE()` - View the list of network eBPF data types
- `SHOW_SECURITY_SOURCE()` - View the list of security check data types
- `SHOW_WORKSPACES()` - View current workspace and authorized workspace information

> More show functions, see [Function Documentation](funcs.md)

<!--
### Result Set Function Calculation

DQL supports secondary calculations on query results:

```python
func::dataflux__dql:(EXPR_EVAL(expr='data1.f1+data1.f2', data=dql('M::cpu:(f1, f2)')))

# Perform cross-dataset calculations using func
F::dataflux__dql:(SOME_FUNC(
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'), some_args))

# Perform complex expression calculations across datasets using func
F::dataflux__dql:(EXPR_EVAL(
	expr='data1.f1/(data2.f2+3)',  # expression
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'),))
```
-->

### Nested Queries and Statement Blocks

Parentheses `()` are used to separate subqueries and outer queries, for example, two levels of nesting:

```python
M::(
# Subquery
M::cpu:(usage_total) {host='kind'}
):(last(usage_total))  # Outer query target column
{}  # Outer query filter conditions
```

Three levels of nesting:

```python
M::(M::(M::cpu:(usage_total) {host='kind'}):(usage_total) {usage_total > 0} ):(last(usage_total))
```

Principally, there is no limit on nesting levels. However, <u>multiple parallel subqueries are not allowed within a single nested level</u>, for example:

```python
object::(     # Second-level query
		object::( # Third-level query
				object::a:(f1,f2,f3) {host="foo"}
			):(f1,f2),

		object::( # Parallel third-level query: not supported
				object::b:(f1,f2,f3) {host="foo"}
			):(f1,f2)
	):(f1)
```

## Special Usage

If the message field is of JSON type (currently only supported for logs), fields can be extracted directly using DQL as follows:

```python
L::nginx { @abc.def = "xyz" }
```

This is equivalent to the following query, i.e., using `@` to indicate `message@json`, which is a shorthand.

```python
L::nginx { `message@json.abc.def` = "xyz" }
```

## Function Explanation

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL Functions**</font>](./funcs.md)
- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL Outer Functions**</font>](./out-funcs.md)

</div>
</input_content>
<target_language>英语</target_language>
</input>
</example>
</instruction>
<input>
请翻译。
</input>
<translation>
# DQL Definition
---

Below is the definition of the DataFlux Query Language (DQL). As support for different syntaxes gradually expands, this document will undergo adjustments and additions to varying degrees.

Global constraints are as follows:

- Non-keywords (such as metric names, label names, etc.) are case-sensitive, while <u>keywords and function names are case-insensitive</u>;

- `#` is used as a line comment character, inline comments are not supported;

- Supported operators:

	- `+`  - Addition
	- `-`  - Subtraction
	- `*`  - Multiplication
	- `/`  - Division
	- `%`  - Modulo
	- `=` - Equal to
	- `!=` - Not equal to
	- `<=` - Less than or equal to
	- `<` - Less than
	- `>=` - Greater than or equal to
	- `>` - Greater than
	- `^` - Exponentiation
	- `&&` - Logical AND
	- `||` - Logical OR

- Supported keywords:

```
AND AS ASC AUTO
BY DESC FALSE
LIMIT LINEAR
NIL OFFSET OR PREVIOUS
SLIMIT SOFFSET TRUE
```

- Identifiers: There are several forms of identifiers to accommodate various variable naming conventions:

	- Normal variable names can only contain `[_a-zA-Z0-9]`, and the first character cannot be a digit. For example `_abc, _abc123, _123ab`.
	- Other forms of variable names:
		- `this+is-a*xx/yy^zz?variable`, `by` should be written as `` `this+is-a*xx/yy^zz?variable` `` or `` `by` ``. The former contains operators within the variable, while the latter `by` is a DQL keyword.
		- UTF8 identifiers such as Chinese characters are supported, e.g., `M::cpu:(usage AS usage_rate) [5m]`.
			- Emoji support: `M::cpu:(usage AS usage_rate👍) [5m]`.
		- If a variable contains a backtick, `` this`is-a-variable `` should be written as `` `identifier("this`is-a-variable")` ``.

- String values can use double quotes and single quotes: `"this is a string"` and `'this is a string'` are equivalent.

- Special strings:
	- Base64 strings: DQL supports handling base64 strings. For base64 strings, DQL can automatically decode the original string during queries. Syntax:
		- `` b64`some-base64-string` ``
		- `b64'some-base64-string'`
		- `b64"some-base64-string"`

	- Regular expression strings: The old `re('xxx')` has been deprecated; it is recommended to use the following format to denote regex strings.
		- `` re`some-regexp` ``* (recommended)*
		- `re'some-regexp'`
		- `re"some-regexp"`

- Supported data types:
	- Floating point (`123.4`, `5.67E3`)
	- Integer (`123`, `-1`)
	- String (`'张三'`, `"hello world"`)
	- Boolean (`true`, `false`)
	- Duration (`1y`, `1w`, `1d`, `1h`, `1m`, `1s`, `1ms`, `1us`, `1ns` representing 1 year/week/day/hour/minute/second/millisecond/microsecond/nanosecond)

## Queries

Queries follow the following syntactical paradigm. Note that the relative order between parts cannot be changed, such as `time-expr` cannot appear before `filter-clause`.

```
namespace::
	data-source
	target-clause
	filter-clause
	time-expr
	by-clause
	having-clause
	order-by-clause
	limit-clause
	offset-clause
	sorder-by-clause
	slimit-clause
	soffset-clause
```

From a syntactic perspective, `data-source` is mandatory (similar to the `FROM` clause in SQL), other parts are optional. However, during actual query execution, certain constraints may be applied (for example, `time_expr` does not allow too large time spans).

Example:

```python
# Get all fields of the metric set cpu for the last 5 minutes
M::cpu [5m]

# Find all metrics matching the regular expression *db for the last 5 minutes
M::re('*db') [5m]

# Get all field data of the metric set cpu from 10 minutes ago to 5 minutes ago
M::cpu [10m:5m]

# Get all field data of the metric set cpu from 10 minutes ago to 5 minutes ago, aggregated every minute
M::cpu:(usage_idle) [10m:5m:1m]

# Query two fields, time_active, time_guest_nice, of the time series data set cpu for the last 5 minutes,
# filtered by host and cpu tags, and grouped by host and cpu to display results.
M:: cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m] BY host,cpu

# Sort by height in descending order, get top ten
O::human:(height, age) { age > 100, sex = "straight male" } ORDER BY height desc LIMIT 10

M::cpu,mem:(time_active, time_guest_nice, host) { host = "host-name", cpu = "cpu0" } [5m] BY host,cpu
```

**Note:** Spaces can be added around `::` and `:` as shown below, these statements are equivalent:

```python
M::cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   ::cpu : (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   :: cpu :   (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]
```

### Examples of Queries for Various Data Types {#example}

- M::`metric_set_name`:(aggregate_function(`metric_name`)) { `label_name` = 'label_value' } BY `label_name`

	- Example: M::`cpu`:(last(`usage_system`)) {`host`=`xxx`} BY `host_ip`

- L::`log_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: L::`datakit`:(COUNT(`*`)) { `index` = 'default' } BY `host`

- O::`category_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

    - Example: O::`HOST`:(COUNT(`*`)) { `class` = 'HOST' } BY `host_ip`

- E::`event_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: E::`monitor`:(COUNT(`create_time`)) { `create_time` = 1688708829409 } BY `df_event_id`

- T::`service_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: T::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

- R::`data_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: R::`error`:(LAST(`browser`)) { `city` = 'unknown' } BY `city`

- S::`category_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: S::`storage`:(LAST(`host`)) { `level` = re('warn') } BY `level`

- N::`network_source`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: N::`httpflow`:(FIRST(`direction`)) { `http_version` = '1.1' } BY `dst_ip_type`

- P::`profiling_name`:(aggregate_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: P::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

Without using aggregate functions:

For example:

- Counting containers under different namespaces:

O::`docker_containers`:(COUNT(`*`)) BY `namespace`

- Query all fields of containers and return the latest 10 records:

O::`docker_containers` {`host`=`xxx`} limit 10

## Statements

### Namespace {#namespace}

Semantically, currently the following data sources are supported:

- M/metric - Time series metric data
- O/object - Object data
- CO/custom_object - User resource catalog data
- L/logging - Log data
- E/event - Event data
- T/tracing - Tracing data
- R/rum - RUM data
- F/func - Func function computation
- N/network - Network eBPF data lookup

In terms of syntax, there are no constraints on data sources. Data source syntax is as follows:

```python
data-source ::
	# specific query details...
```

In specific queries, if the data source is not specified, it defaults to `metric` (or `M`), meaning time series metrics are the default data source for DQL.

### Target Clause

The result list of the query:

```python
M::cpu:(time_active, system_usage) {host="biz_prod"} [5m]

# This supports performing calculations between different metrics within the same metric set (types must generally match)
M::cpu:(time_active+1, time_active/time_guest_nice) [5m]
```

### Filter Clause

The filter clause is used to filter the result data, similar to the `where` condition in SQL:

```python
# Query the height of centenarian straight males in the human object class
O::human:(height) { age > 100, sex = "straight male" }

# Filtering with regex
O::human:(height) { age > 100, sex != re("male") }

# Filtering with calculation expressions
O::human:(height) { (age + 1)/2 > 31, sex != re("male") }

# Filtering with OR expressions
O::human:(height) { age > 31 || sex != re("male"), weight > 70}

# Aggregated result column
M::cpu:(avg(time_active) AS time_active_avg) [1d::1h]

# Aggregated result column with fill
M::cpu:(fill(avg(time_active) AS time_active_avg, 0.1)) [1d::1h]

# Query with an IN list, where options in the IN list are logically ORed, and can only be numbers or strings
O::human:(height) { age in [30, 40, 50], weight > 70}
```

Regarding filling:

- Numeric filling: e.g., `cpu:(fill(f1, 123), fill(f2, "foo bar"), fill(f3, 123.456))`
- Linear filling: e.g., `cpu:(fill(f1, LINEAR))`
- Previous value filling: e.g., `cpu:(fill(f1, PREVIOUS))`

**Note:** Multiple filter conditions are by default `AND` related, but to express `OR` relationships, use the `||` operator. The following two statements have the same meaning:

```python
O::human:(height) { age > 31, sex != re("male") }
O::human:(height) { age > 31 && sex != re("male") }
```

A more complex filter expression:

```python
M::some_metric {(a>123.45 && b!=re("abc")) || (z!="abc"), c=re("xyz")} [1d::30m]
```

### Time Expression

DataFlux data all have a time attribute, so time expression is represented by a separate clause:

`time-expr` consists of 3 parts [`start_time`:`end_time`:`interval`:`rollup`]:

| No. | Name         | Required | Description                                                                                                 | Example                           |
| ---- | ------------ | -------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| 1    | `start_time` | No       | Start time for time filtering                                                                               | `1672502400000` / `1672502400`     |
| 2    | `end_time`   | No       | End time for time filtering                                                                                 | `1672588800000` / `1672588800`     |
| 3    | `interval`   | No       | Time aggregation period, usually used with aggregation or rolling aggregation, supports `s`, `m`, `h`, `d` units | `1s`/`1m`/`1h`                    |
| 4    | `rollup`     | No       | Rolling aggregation function name, currently supported aggregation functions include `avg`, `sum`, `min`, `max`, `count`, `first`, `last`, `stddev` | `last`                            |

**Note:**

`start_time`, `end_time` support 3 formats:

- Numerical with time units, e.g., `1m`
- Timestamp, e.g., `1672502400`
- Milliseconds timestamp, e.g., `1672502400000`

`interval` supports the following time units:

- `ns` - Nanoseconds
- `us` - Microseconds
- `ms` - Milliseconds
- `s` - Seconds
- `m` - Minutes
- `h` - Hours
- `d` - Days
- `w` - Weeks
- `y` - Years, defined as 