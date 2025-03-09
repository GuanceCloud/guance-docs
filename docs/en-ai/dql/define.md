# DQL Definition
---

Below is the DataFlux Query Language (DQL) definition. As support for different syntaxes gradually expands, this document will be adjusted and modified to varying degrees.

Global constraints are as follows:

- Non-keywords (such as metric names, label names, etc.) are case-sensitive, <u>while keywords and function names are case-insensitive</u>;

- The `#` character is used for line comments; inline comments are not supported;

- Supported operators:

	- `+` - Addition
	- `-` - Subtraction
	- `*` - Multiplication
	- `/` - Division
	- `%` - Modulus
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

- Identifiers: Identifiers come in several forms to accommodate various variable naming conventions:

	- Normal variable names can only contain `[_a-zA-Z0-9]` characters, and the first character cannot be a digit. For example, `_abc`, `_abc123`, `_123ab`.
	- Other forms of variable names:
		- `this+is-a*xx/yy^zz?variable` should be written as `` `this+is-a*xx/yy^zz?variable` `` and `` `by` ``. The former contains operators within the variable, while the latter's `by` is a DQL keyword.
		- UTF8 identifiers such as Chinese characters are supported, e.g., `M::cpu:(usage AS usage_rate) [5m]`.
			- Emoji support: `M::cpu:(usage AS usage_rate👍) [5m]`.
		- If a variable contains a backtick, `` this`is-a-variable `` should be written as `` `identifier("this`is-a-variable")` ``.

- String values can use double quotes and single quotes: `"this is a string"` and `'this is a string'` are equivalent.

- Special strings:
	- Base64 strings: DQL supports handling base64 strings. For base64 strings, DQL can automatically decode the original string during queries. The syntax is as follows:
		- `` b64`some-base64-string` ``
		- `b64'some-base64-string'`
		- `b64"some-base64-string"`

	- Regular expression strings: The original `re('xxx')` has been deprecated. It is recommended to use the following format to identify regular expressions.
		- `` re`some-regexp` `` * (recommended) *
		- `re'some-regexp'`
		- `re"some-regexp"`

- Supported data types:
	- Floating-point (`123.4`, `5.67E3`)
	- Integer (`123`, `-1`)
	- String (`'John Doe'`, `"hello world"`)
	- Boolean (`true`, `false`)
	- Duration (`1y`, `1w`, `1d`, `1h`, `1m`, `1s`, `1ms`, `1us`, `1ns` representing 1 year/week/day/hour/minute/second/millisecond/microsecond/nanosecond)

## Queries

Queries follow the following syntactic paradigm. Note that the relative order between parts cannot be changed, such as `time-expr` appearing before `filter-clause`.

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

From a syntactic perspective, `data-source` is mandatory (similar to the `FROM` clause in SQL), while other parts are optional. However, during actual query execution, certain constraints may apply (for example, `time_expr` does not allow too large time spans).

Example:

```python
# Get all fields of the metric set cpu for the last 5 minutes
M::cpu [5m]

# Find all metrics matching the regular expression *db for the last 5 minutes
M::re('*db') [5m]

# Get all field data from the metric set cpu from 10 minutes ago to 5 minutes ago
M::cpu [10m:5m]

# Get all field data from the metric set cpu from 10 minutes ago to 5 minutes ago, aggregated at 1-minute intervals
M::cpu:(usage_idle) [10m:5m:1m]

# Query Time Series data for the metric set cpu for the last 5 minutes for two fields time_active, time_guest_nice,
# filtered by host and cpu tags, grouped by host and cpu to display results.
M:: cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m] BY host,cpu

# Order by height in descending order and get the top ten
O::human:(height, age) { age > 100, sex = "male" } ORDER BY height desc LIMIT 10

M::cpu,mem:(time_active, time_guest_nice, host) { host = "host-name", cpu = "cpu0" } [5m] BY host,cpu
```

**Note:** `::` and `:` on both sides can have whitespace characters, as the following statements are equivalent:

```python
M::cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   ::cpu : (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   :: cpu :   (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]
```

### Examples of Various Data Type Queries {#example}

- M::`metric_set_name`:(aggregation_function(`metric_name`)) { `label_name` = 'label_value' } BY `label_name`

	- Example: M::`cpu`:(last(`usage_system`)) {`host`=`xxx`} BY `host_ip`

- L::`log_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: L::`datakit`:(COUNT(`*`)) { `index` = 'default' } BY `host`

- O::`category_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

    - Example: O::`HOST`:(COUNT(`*`)) { `class` = 'HOST' } BY `host_ip`

- E::`event_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: E::`monitor`:(COUNT(`create_time`)) { `create_time` = 1688708829409 } BY `df_event_id`

- T::`service_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: T::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

- R::`data_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: R::`error`:(LAST(`browser`)) { `city` = 'unknown' } BY `city`

- S::`category_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: S::`storage`:(LAST(`host`)) { `level` = re('warn') } BY `level`

- N::`network_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: N::`httpflow`:(FIRST(`direction`)) { `http_version` = '1.1' } BY `dst_ip_type`

- P::`Profiling_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: P::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

Without using aggregation functions:

For example:

- Counting the number of containers under different namespaces:

O::`docker_containers`:(COUNT(`*`)) BY `namespace`

- Query all fields of the container and return the latest 10 records:

O::`docker_containers` {`host`=`xxx`} limit 10

## Statements

### Namespace {#namespace}

Semantically, the following data sources are currently supported:

- M/metric - Time Series Metrics Data
- O/object - Object Data
- CO/custom_object - User Resource Catalog Data
- L/logging - Log Data
- E/event - Event Data
- T/tracing - Tracing Data
- R/rum - RUM Data
- F/func - Func Function Computation
- N/network - Network eBPF Data Lookup

At the syntax level, there are no constraints on data sources. The data source syntax is as follows:

```python
data-source ::
	# Specific query details...
```

In specific queries, if the data source is not specified, it defaults to `metric` (or `M`), meaning Time Series Metrics is the default data source for DQL.

### Target Clause

The result list of the query:

```python
M::cpu:(time_active, system_usage) {host="biz_prod"} [5m]

# This supports calculations between different metrics on the same metric set (types must match)
M::cpu:(time_active+1, time_active/time_guest_nice) [5m]
```

### Filter Clause

The filter clause is used to filter the result data, similar to the `where` condition in SQL:

```python
# Query the height of centenarian males in the human population (__class=human)
O::human:(height) { age > 100, sex = "male" }

# Filter with regex
O::human:(height) { age > 100, sex != re("male") }

# Filter with an expression
O::human:(height) { (age + 1)/2 > 31, sex != re("male") }

# Filter with OR expressions
O::human:(height) { age > 31 || sex != re("male"), weight > 70}

# Aggregate result column
M::cpu:(avg(time_active) AS time_active_avg) [1d::1h]

# Aggregate with fill
M::cpu:(fill(avg(time_active) AS time_active_avg, 0.1)) [1d::1h]

# Query with IN list, where options in IN are logically OR, IN list can only be numbers or strings
O::human:(height) { age in [30, 40, 50], weight > 70}
```

Regarding filling:

- Numeric fill: Formatted like `cpu:(fill(f1, 123), fill(f2, "foo bar"), fill(f3, 123.456))`
- Linear fill: Such as `cpu:(fill(f1, LINEAR))`
- Previous value fill: Such as `cpu:(fill(f1, PREVIOUS))`

**Note:** Multiple filtering conditions are `AND` by default, but if you want to express `OR`, use the `||` operator. The following two statements are equivalent:

```python
O::human:(height) { age > 31, sex != re("male") }
O::human:(height) { age > 31 && sex != re("male") }
```

A complex filtering expression:

```python
M::some_metric {(a>123.45 && b!=re("abc")) || (z!="abc"), c=re("xyz")} [1d::30m]
```

### Time Expression

DataFlux data characteristics all have time attributes, so the time expression is represented by a separate clause:

`time-expr` consists of four parts [`start_time`:`end_time`:`interval`:`rollup`]:

| No. | Name         | Required | Description                                                                                             | Example                           |
| ---- | ------------ | -------- | --------------------------------------------------------------------------------------------------- | ------------------------------ |
| 1    | `start_time` | No       | Start time for time filtering                                                                          | `1672502400000` / `1672502400` |
| 2    | `end_time`   | No       | End time for time filtering                                                                            | `1672588800000` / `1672588800` |
| 3    | `interval`   | No       | Time aggregation period, generally used with aggregation or rolling aggregation, supports `s`, `m`, `h`, `d` units, can be combined | `1s`/`1m`/`1h`                 |
| 4    | `rollup`     | No       | Rolling aggregation function name, currently supported aggregation functions include `avg`, `sum`, `min`, `max`, `count`, `first`, `last`, `stddev` | `last`                         |

**Note:**

`start_time`, `end_time` support three formats:

- Numerical with time unit, e.g., `1m`
- Timestamp, e.g., `1672502400`
- Millisecond timestamp, `1672502400000`

`interval` supports the following time units:

- `ns` - Nanoseconds
- `us` - Microseconds
- `ms` - Milliseconds
- `s` - Seconds
- `m` - Minutes
- `h` - Hours
- `d` - Days
- `w` - Weeks
- `y` - Years, specified as 365d, ignoring leap years.

`rollup` rolling aggregation functions include:

- `avg`: Average
- `sum`: Sum
- `min`: Minimum
- `max`: Maximum
- `count`: Count
- `first`: First
- `last`: Last
- `deriv`: Rate of change per second, estimated by subtracting the first value from the last value and dividing by the time interval
- `rate`: Rate of change per second, similar to `deriv` but does not return negative results, consistent with PromQL logic
- `irate`: Instantaneous rate of change, estimated by subtracting the previous value from the current value and dividing by the time interval, consistent with PromQL logic
- `p99`, `p95`, `p90`, `p75`: Percentile calculation, supports any percentage after `p`
- `median`: Median, equivalent to `p50`
- `stddev`: Standard deviation

`rollup` rolling aggregation splits a single timeline into different time periods according to the given `interval` and performs aggregation calculations on each period. When `rollup` is empty, it indicates no rolling aggregation.

Common examples:

- `[5m]` - Last 5 minutes
- `[10m:5m]` - From 10 minutes ago to 5 minutes ago
- `[10m:5m:1m]` - From 10 minutes ago to 5 minutes ago, aggregated at 1-minute intervals
- `[1672502400000:1672588800000]` - Time range from `2023-01-01 00:00:00` to `2023-01-02 00:00:00`
- `[1672502400:1672588800]` - Time range from `2023-01-01 00:00:00` to `2023-01-02 00:00:00`

### By Clause Statement

The `BY` clause is used to aggregate and classify results, similar to MySQL's `GROUP BY`.

### Having Clause Statement

The `HAVING` clause is used to filter results after aggregation, similar to MySQL's `HAVING`.

```python
# Get all hosts with CPU utilization greater than 80%
M::cpu:(max(`usage_total`) as `max_usage`) by host having max_usage > 80
```

### Order By Clause Statement

The `ORDER BY` clause sorts the results, similar to MySQL's `ORDER BY`.

**Note:** 1. Metric data only supports sorting by the `time` field; 2. When grouping with `by` in the query, `order-by` will not take effect. Please use `sorder-by` for sorting.

```python
# Get all host CPU utilization, ordered by time in descending order
M::cpu:(`usage_total`) order by time desc
```

```python
# Get all log data, ordered by response time in ascending order
L::`*`:(`*`) order by response_time asc
```

### SOrder By Clause Statement

The `SORDER BY` clause sorts groups.

```python
# Get the maximum CPU utilization of different hosts, ordered by hostname in descending order
M::cpu:(max(`usage_total`)) by host sorder by host desc
```

```python
# Get the maximum CPU utilization of different hosts, ordered by maximum CPU utilization in ascending order
M::cpu:(max(`usage_total`) as m) by host sorder by m
```

```python
# Get the CPU utilization of different hosts, ordered by the latest CPU utilization in ascending order
M::cpu:(`usage_total`) sorder by usage_total
```

### Limit Statement

Used to specify the number of returned rows,

**Note:**

For time series data, if the DQL statement includes both `by` and `limit` clauses, the `limit` applies to the number of rows returned in each aggregation group.

```python

# Return three CPU records
M::cpu:() limit 3

# Return three CPU records for each host
M::cpu:() by host limit 3
```

### SLimit Statement

Used to specify the number of groups

```python
# Return CPU usage information for three hosts
M::cpu:(last(usage_total)) by host slimit 3

# Return CPU information for three hosts, where each host returns three records
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

> For more show functions, see [Function Documentation](funcs.md)

<!--
### Result Set Calculation

DQL supports secondary calculations on query results:

```python
func::dataflux__dql:(EXPR_EVAL(expr='data1.f1+data1.f2', data=dql('M::cpu:(f1, f2)')))

# Cross-dataset calculations using func
F::dataflux__dql:(SOME_FUNC(
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'), some_args))

# Complex expression calculations across datasets using func
F::dataflux__dql:(EXPR_EVAL(
	expr='data1.f1/(data2.f2+3)',  # Expression
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2')),))
```
-->

### Nested Queries and Statement Blocks

Subqueries and outer queries are separated by `()`, such as two levels of nesting:

```python
M::(
# Subquery
M::cpu:(usage_total) {host='kind'}
):(last(usage_total))  # Outer query target column
{}  # Outer query filter condition
```

Three levels of nesting:

```python
M::(M::(M::cpu:(usage_total) {host='kind'}):(usage_total) {usage_total > 0} ):(last(usage_total))
```

Principally, there is no limit on nesting levels. However, <u>multiple parallel subqueries are not allowed in a nested layer</u>, such as:

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

If the message field is of JSON type (currently only supported for logs), you can directly extract fields using DQL as follows:

```python
L::nginx { @abc.def = "xyz" }
```

This is equivalent to the following query, i.e., `@` represents `message@json`, which is a shorthand.

```python
L::nginx { `message@json.abc.def` = "xyz" }
```

## Function Documentation

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL Functions**</font>](./funcs.md)
- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL Outer Functions**</font>](./out-funcs.md)

</div>
</input_content>
<target_language>英语</target_language>
</input>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example>
</example# DQL Definition
---

Below is the DataFlux Query Language (DQL) definition. As support for different syntaxes gradually expands, this document will be adjusted and modified to varying degrees.

Global constraints are as follows:

- Non-keywords (such as metric names, label names, etc.) are case-sensitive, <u>while keywords and function names are case-insensitive</u>;

- The `#` character is used for line comments; inline comments are not supported;

- Supported operators:

	- `+` - Addition
	- `-` - Subtraction
	- `*` - Multiplication
	- `/` - Division
	- `%` - Modulus
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

- Identifiers: Identifiers come in several forms to accommodate various variable naming conventions:

	- Normal variable names can only contain `[_a-zA-Z0-9]` characters, and the first character cannot be a digit. For example, `_abc`, `_abc123`, `_123ab`.
	- Other forms of variable names:
		- `this+is-a*xx/yy^zz?variable` should be written as `` `this+is-a*xx/yy^zz?variable` `` and `` `by` ``. The former contains operators within the variable, while the latter's `by` is a DQL keyword.
		- UTF8 identifiers such as Chinese characters are supported, e.g., `M::cpu:(usage AS usage_rate) [5m]`.
			- Emoji support: `M::cpu:(usage AS usage_rate👍) [5m]`.
		- If a variable contains a backtick, `` this`is-a-variable `` should be written as `` `identifier("this`is-a-variable")` ``.

- String values can use double quotes and single quotes: `"this is a string"` and `'this is a string'` are equivalent.

- Special strings:
	- Base64 strings: DQL supports handling base64 strings. For base64 strings, DQL can automatically decode the original string during queries. The syntax is as follows:
		- `` b64`some-base64-string` ``
		- `b64'some-base64-string'`
		- `b64"some-base64-string"`

	- Regular expression strings: The original `re('xxx')` has been deprecated. It is recommended to use the following format to identify regular expressions.
		- `` re`some-regexp` `` * (recommended) *
		- `re'some-regexp'`
		- `re"some-regexp"`

- Supported data types:
	- Floating-point (`123.4`, `5.67E3`)
	- Integer (`123`, `-1`)
	- String (`'John Doe'`, `"hello world"`)
	- Boolean (`true`, `false`)
	- Duration (`1y`, `1w`, `1d`, `1h`, `1m`, `1s`, `1ms`, `1us`, `1ns` representing 1 year/week/day/hour/minute/second/millisecond/microsecond/nanosecond)

## Queries

Queries follow the following syntactic paradigm. Note that the relative order between parts cannot be changed, such as `time-expr` appearing before `filter-clause`.

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

From a syntactic perspective, `data-source` is mandatory (similar to the `FROM` clause in SQL), while other parts are optional. However, during actual query execution, certain constraints may apply (for example, `time_expr` does not allow too large time spans).

Example:

```python
# Get all fields of the metric set cpu for the last 5 minutes
M::cpu [5m]

# Find all metrics matching the regular expression *db for the last 5 minutes
M::re('*db') [5m]

# Get all field data from the metric set cpu from 10 minutes ago to 5 minutes ago
M::cpu [10m:5m]

# Get all field data from the metric set cpu from 10 minutes ago to 5 minutes ago, aggregated at 1-minute intervals
M::cpu:(usage_idle) [10m:5m:1m]

# Query Time Series data for the metric set cpu for the last 5 minutes for two fields time_active, time_guest_nice,
# filtered by host and cpu tags, grouped by host and cpu to display results.
M:: cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m] BY host,cpu

# Order by height in descending order and get the top ten
O::human:(height, age) { age > 100, sex = "male" } ORDER BY height desc LIMIT 10

M::cpu,mem:(time_active, time_guest_nice, host) { host = "host-name", cpu = "cpu0" } [5m] BY host,cpu
```

**Note:** `::` and `:` on both sides can have whitespace characters, as the following statements are equivalent:

```python
M::cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   ::cpu : (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   :: cpu :   (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]
```

### Examples of Various Data Type Queries {#example}

- M::`metric_set_name`:(aggregation_function(`metric_name`)) { `label_name` = 'label_value' } BY `label_name`

	- Example: M::`cpu`:(last(`usage_system`)) {`host`=`xxx`} BY `host_ip`

- L::`log_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: L::`datakit`:(COUNT(`*`)) { `index` = 'default' } BY `host`

- O::`category_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

    - Example: O::`HOST`:(COUNT(`*`)) { `class` = 'HOST' } BY `host_ip`

- E::`event_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: E::`monitor`:(COUNT(`create_time`)) { `create_time` = 1688708829409 } BY `df_event_id`

- T::`service_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: T::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

- R::`data_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: R::`error`:(LAST(`browser`)) { `city` = 'unknown' } BY `city`

- S::`category_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: S::`storage`:(LAST(`host`)) { `level` = re('warn') } BY `level`

- N::`network_source`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: N::`httpflow`:(FIRST(`direction`)) { `http_version` = '1.1' } BY `dst_ip_type`

- P::`Profiling_name`:(aggregation_function(`property_name`)) { `property_name` = 'property_value' } BY `property_name`

	- Example: P::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

Without using aggregation functions:

For example:

- Counting the number of containers under different namespaces:

O::`docker_containers`:(COUNT(`*`)) BY `namespace`

- Query all fields of the container and return the latest 10 records:

O::`docker_containers` {`host`=`xxx`} limit 10

## Statements

### Namespace {#namespace}

Semantically, the following data sources are currently supported:

- M/metric - Time Series Metrics Data
- O/object - Object Data
- CO/custom_object - User Resource Catalog Data
- L/logging - Log Data
- E/event - Event Data
- T/tracing - Tracing Data
- R/rum - RUM Data
- F/func - Func Function Computation
- N/network - Network eBPF Data Lookup

At the syntax level, there are no constraints on data sources. The data source syntax is as follows:

```python
data-source ::
	# Specific query details...
```

In specific queries, if the data source is not specified, it defaults to `metric` (or `M`), meaning Time Series Metrics is the default data source for DQL.

### Target Clause

The result list of the query:

```python
M::cpu:(time_active, system_usage) {host="biz_prod"} [5m]

# This supports calculations between different metrics on the same metric set (types must match)
M::cpu:(time_active+1, time_active/time_guest_nice) [5m]
```

### Filter Clause

The filter clause is used to filter the result data, similar to the `where` condition in SQL:

```python
# Query the height of centenarian males in the human population (__class=human)
O::human:(height) { age > 100, sex = "male" }

# Filter with regex
O::human:(height) { age > 100, sex != re("male") }

# Filter with an expression
O::human:(height) { (age + 1)/2 > 31, sex != re("male") }

# Filter with OR expressions
O::human:(height) { age > 31 || sex != re("male"), weight > 70}

# Aggregate result column
M::cpu:(avg(time_active) AS time_active_avg) [1d::1h]

# Aggregate with fill
M::cpu:(fill(avg(time_active) AS time_active_avg, 0.1)) [1d::1h]

# Query with IN list, where options in IN are logically OR, IN list can only be numbers or strings
O::human:(height) { age in [30, 40, 50], weight > 70}
```

Regarding filling:

- Numeric fill: Formatted like `cpu:(fill(f1, 123), fill(f2, "foo bar"), fill(f3, 123.456))`
- Linear fill: Such as `cpu:(fill(f1, LINEAR))`
- Previous value fill: Such as `cpu:(fill(f1, PREVIOUS))`

**Note:** Multiple filtering conditions are `AND` by default, but if you want to express `OR`, use the `||` operator. The following two statements are equivalent:

```python
O::human:(height) { age > 31, sex != re("male") }
O::human:(height) { age > 31 && sex != re("male") }
```

A complex filtering expression:

```python
M::some_metric {(a>123.45 && b!=re("abc")) || (z!="abc"), c=re("xyz")} [1d::30m]
```

### Time Expression

DataFlux data characteristics all have time attributes, so the time expression is represented by a separate clause:

`time-expr` consists of four parts [`start_time`:`end_time`:`interval`:`rollup`]:

| No. | Name         | Required | Description                                                                                             | Example                           |
| ---- | ------------ | -------- | --------------------------------------------------------------------------------------------------- | ------------------------------ |
| 1    | `start_time` | No       | Start time for time filtering                                                                          | `1672502400000` / `1672502400` |
| 2    | `end_time`   | No       | End time for time filtering                                                                            | `1672588800000` / `1672588800` |
| 3    | `interval`   | No       | Time aggregation period, generally used with aggregation or rolling aggregation, supports `s`, `m`, `h`, `d` units, can be combined | `1s`/`1m`/`1h`                 |
| 4    | `rollup`     | No       | Rolling aggregation function name, currently supported aggregation functions include `avg`, `sum`, `min`, `max`, `count`, `first`, `last`, `stddev` | `last`                         |

**Note:**

`start_time`, `end_time` support three formats:

- Numerical with time unit, e.g., `1m`
- Timestamp, e.g., `1672502400`
- Millisecond timestamp, `1672502400000`

`interval` supports the following time units:

- `ns` - Nanoseconds
- `us` - Microseconds
- `ms` - Milliseconds
- `s` - Seconds
- `m` - Minutes
- `h` - Hours
- `d` - Days
- `w` - Weeks
- `y` - Years, specified as 365d, ignoring leap years.

`rollup` rolling aggregation functions include:

- `avg`: Average
- `sum`: Sum
- `min`: Minimum
- `max`: Maximum
- `count`: Count
- `first`: First
- `last`: Last
- `deriv`: Rate of change per second, estimated by subtracting the first value from the last value and dividing by the time interval
- `rate`: Rate of change per second, similar to `deriv` but does not return negative results, consistent with PromQL logic
- `irate`: Instantaneous rate of change, estimated by subtracting the previous value from the current value and dividing by the time interval, consistent with PromQL logic
- `p99`, `p95`, `p90`, `p75`: Percentile calculation, supports any percentage after `p`
- `median`: Median, equivalent to `p50`
- `stddev`: Standard deviation

`rollup` rolling aggregation splits a single timeline into different time periods according to the given `interval` and performs aggregation calculations on each period. When `rollup` is empty, it indicates no rolling aggregation.

Common examples:

- `[5m]` - Last 5 minutes
- `[10m:5m]` - From 10 minutes ago to 5 minutes ago
- `[10m:5m:1m]` - From 10 minutes ago to 5 minutes ago, aggregated at 1-minute intervals
- `[1672502400000:1672588800000]` - Time range from `2023-01-01 00:00:00` to `2023-01-02 00:00:00`
- `[1672502400:1672588800]` - Time range from `2023-01-01 00:00:00` to `2023-01-02 00:00:00`

### By Clause Statement

The `BY` clause is used to aggregate and classify results, similar to MySQL's `GROUP BY`.

### Having Clause Statement

The `HAVING` clause is used to filter results after aggregation, similar to MySQL's `HAVING`.

```python
# Get all hosts with CPU utilization greater than 80%
M::cpu:(max(`usage_total`) as `max_usage`) by host having max_usage > 80
```

### Order By Clause Statement

The `ORDER BY` clause sorts the results, similar to MySQL's `ORDER BY`.

**Note:** 1. Metric data only supports sorting by the `time` field; 2. When grouping with `by` in the query, `order-by` will not take effect. Please use `sorder-by` for sorting.

```python
# Get all host CPU utilization, ordered by time in descending order
M::cpu:(`usage_total`) order by time desc
```

```python
# Get all log data, ordered by response time in ascending order
L::`*`:(`*`) order by response_time asc
```

### SOrder By Clause Statement

The `SORDER BY` clause sorts groups.

```python
# Get the maximum CPU utilization of different hosts, ordered by hostname in descending order
M::cpu:(max(`usage_total`)) by host sorder by host desc
```

```python
# Get the maximum CPU utilization of different hosts, ordered by maximum CPU utilization in ascending order
M::cpu:(max(`usage_total`) as m) by host sorder by m
```

```python
# Get the CPU utilization of different hosts, ordered by the latest CPU utilization in ascending order
M::cpu:(`usage_total`) sorder by usage_total
```

### Limit Statement

Used to specify the number of returned rows,

**Note:**

For time series data, if the DQL statement includes both `by` and `limit` clauses, the `limit` applies to the number of rows returned in each aggregation group.

```python

# Return three CPU records
M::cpu:() limit 3

# Return three CPU records for each host
M::cpu:() by host limit 3
```

### SLimit Statement

Used to specify the number of groups

```python
# Return CPU usage information for three hosts
M::cpu:(last(usage_total)) by host slimit 3

# Return CPU information for three hosts, where each host returns three records
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

> For more show functions, see [Function Documentation](funcs.md)

### Nested Queries and Statement Blocks

Subqueries and outer queries are separated by `()`, such as two levels of nesting:

```python
M::(
# Subquery
M::cpu:(usage_total) {host='kind'}
):(last(usage_total))  # Outer query target column
{}  # Outer query filter condition
```

Three levels of nesting:

```python
M::(M::(M::cpu:(usage_total) {host='kind'}):(usage_total) {usage_total > 0} ):(last(usage_total))
```

Principally, there is no limit on nesting levels. However, <u>multiple parallel subqueries are not allowed in a nested layer</u>, such as:

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

If the message field is of JSON type (currently only supported for logs), you can directly extract fields using DQL as follows:

```python
L::nginx { @abc.def = "xyz" }
```

This is equivalent to the following query, i.e., `@` represents `message@json`, which is a shorthand.

```python
L::nginx { `message@json.abc.def` = "xyz" }
```

## Function Documentation

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL Functions**</font>](./funcs.md)
- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL Outer Functions**</font>](./out-funcs.md)

</div>