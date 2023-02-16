# DQL Definition
---

The following is the DataFlux Query Language (dql) definition. With the gradual support of different syntax, the document will be adjusted, added and deleted to varying degrees.

The whole constraints are as follows:

- Non-keywords (such as metric name and tag name) are case sensitive; **keywords and function names are case-insensitive**.

- With `#` as line comment character; inline comment is not supported.

- Supported operators:

  - `+`  - addition
  - `-`  - subtraction
  - `*`  - multiplication
  - `/`  - division
  - `%`  - modulo
  - `=` - equal to
  - `!=` - not equal to
  - `<=` - greater than or equal to
  - `<` - less than
  - `>=` - greater than or equal to
  - `>` -  greater than
  - `^` - exponential operation
  - `&&` - logical and
  - `||` - logical or

- Supported keywords:

```
AND AS ASC AUTO
BY DESC FALSE FILTER
LIMIT LINK WITH LINEAR
NIL OFFSET OR PREVIOUS
SLIMIT SOFFSET TRUE WITH
```

- Identifiers: There are several forms of identifiers, which are compatible with various variable naming forms.

  - Only `[_a-zA-Z0-9]` can appear in normal variable names, and the first character cannot be a number, such as `_abc, _abc123, _123ab`.
  - Other forms of processing variable name:
    - `this+is-a*xx/yy^zz?variable`, `by` should be written as `` `this+is-a*xx/yy^zz?variable` ``, `` `by` ``, with operators in the former variable, and `by` in the latter is the DQL keyword.
    - Support UTF8 identifiers such as Chinese, such as  `M::cpu:(usage AS 使用率) [5m]`
      - Support emoji: `M::cpu:(usage AS 使用率👍) [5m]`
    - The variable is enclosed in an inverse quotation mark, `` this`is-a-vairalbe `` should be modified by `` `identifier("this`is-a-vairalbe")` `` .

- String values can be used in double and single quotation marks: `"this is a string"` and `'this is a string'` are equivalent.

- Special string
  - Base64 strings: DQL supports processing Base64 strings. For Bas64 strings, DQL can automatically solve the original strings when querying, which is written as follows:
    - `` b64`some-base64-string` ``
    - `b64'some-base64-string'`
    - `b64"some-base64-string"`

  - Regular expression strings: The original `re('xxx')` is deprecated, and the following form is recommended to identify regular strings.
    - `` re`some-regexp` ``(recommended)
    - `re'some-regexp'`
    - `re"some-regexp"`

- Supported data types:
  - Support for floating points (`123.4`, `5.67E3`)
  - Plastic (`123`, `-1`)
  - String (`'zhangsan'`, `"hello world"`)
  - Boolean(`true`, `false`)
  - Duration(`1y`, `1w`, `1d`, `1h`, `1m`, `1s`, `1ms`, `1us`, `1ns` for 1 year/week/day/hour/minute/second/millisecond/microsecond/nanosecond, respectively)

- Special function

  - `tz()` - time zone, supported in two forms
    - `tz(+-12)` is specified with an offset of 24 time zones, so be `tz(+8),tz(8), tz('Asia/Shanghai')` , and daylight saving time cannot be specified in this form.
    - `tz('Asia/Shanghai')` specifies the time zone in international standard form. For daylight saving time, it can only be specified in this form.

  - `identifier()` is used to modify variables with `` ` `` 字characters in variable names.

  - `int()` and `float()` type-convert the returned data and apply only to time series data.

## Query

The query follows the following syntax pattern, noting that the relative order between the parts cannot be reversed, for example, `time-expr` cannot appear before `filter-clause`.

```
namespace::
	data-source
	target-clause
	filter-clause
	time-expr
	by-clause
	order-by-clause
	limit-clause
	offset-clause
	slimit-clause
	soffset-clause
```

Syntactically,  `data-source` is required (similar to the `FROM` clause in SQL), and the rest is optional. However, in the actual query process, some constraints are imposed on the actual execution of the query. For example, `time_expr` does not allow too long a time span.

Examples：

```python
# Get the data of all fields of the measurement cpu in the last 5 minutes.
M::cpu [5m]}

# Find the data that matches all metrics of regular expression *db in the last 5 minutes.
M::re('*db') [5m]

# Get all field data of measurement cpu from 10 minutes ago to 5 minutes ago.
M::cpu [10m:5m]

# Get all the field data of the measurement cpu from 10 minutes ago to 5 minutes ago, and aggregate them at 1 minute intervals.
M::cpu [10m:5m:1m]

# Query the time_active and time_guest_nice of the time series data measurement cpu in the last 5 minutes,
# Filter with two tags of host and cpu, and display the results in groups of host and cpu.
M:: cpu:(time_active, time_guest_nice)
		{ host = "host-name", cpu = "cpu0" } [5m] BY host,cpu

# Reverse by height and get the top ten
O::human:(height, age) { age > 100, sex = "straight men" } ORDER BY height LIMIT 10

M::cpu,mem:(time_active, time_guest_nice, host) { host = "host-name", cpu = "cpu0" } [5m] BY host,cpu
```

Note: that white space characters can be added on both sides of `::` and `:` , and the following statements are equivalent:

```python
M::cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   ::cpu : (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   :: cpu :   (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]
```

## Statement

### Namespace

At the semantic level, the following data sources are currently supported:

- M/metric - time series index data
- O/object - object data
- CO/custom_object - user-defined object data
- L/logging - log data
- E/event - event data
- T/tracing - tracking data
- R/rum - RUM data
- F/func - Func function computation
- N/network - network eBPF data lookup

At the syntax level, the data source is not constrained for the time being. The data source syntax is as follows:

```python
data-source ::
	# specific query details...
```

In a specific query, if no data source is specified, the default is `metric`(or `M`), that is, the time series metric is the default data source for DQL.

### Target-clause

List of the query results:

```python
M::cpu:(time_active, system_usage) {host="biz_prod"} [5m]

# Here, the calculation between different metrics (types should be basically matched) on the same measurement is supported.
M::cpu:(time_active+1, time_active/time_guest_nice) [5m]
```

### Filter-clause

The filter clause is used to filter the resulting data, similar to the `where` condition in SQL:

```python
# Query the height of 100-year-old straight men in the population object (__class=human)
O::human:(height) { age > 100, sex = "直男" }

# Filtering with regularity
O::human:(height) { age > 100, sex != re("男") }

# Filtering with computed expressions
O::human:(height) { (age + 1)/2 > 31, sex != re("男") }

# Filtering of expressions with OR operation
O::human:(height) { age > 31 || sex != re("男"), weight > 70}

# Result column with aggregation
M::cpu:(avg(time_active) AS time_active_avg, time_guest_nice) [1d::1h]

# Result column with aggregate padding
M::cpu:(fill(avg(time_active) AS time_active_avg, 0.1), time_guest_nice) [1d::1h]

# Query with in list, where the option relationship in in is logical or, and in list can only be numeric value or string.
O::human:(height) { age in [30, 40, 50], weight > 70}
```

About filling:

- Numeric filling: such as `cpu:(fill(f1, 123), fill(f2, "foo bar"), fill(f3, 123.456))`
- Linear filling: such as `cpu:(fill(f1, LINEAR))`
- Pre-value filling: such as `cpu:(fill(f1, PREVIOUS))`

> Note: Between multiple filter conditions. The default is an `AND` relationship, but if you want to express an `OR` relationship, you can use the `||` operator. The following two statements have the same meaning:

```python
O::human:(height) { age > 31, sex != re("男") }
O::human:(height) { age > 31 && sex != re("男") }
```

A complex filter expression:

```python
M::some_metric {(a>123.45 && b!=re("abc")) || (z!="abc"), c=re("xyz")} [1d::30m]
```

### Time-expr

DataFlux data features all have time attributes, so the expression of time is expressed by a separate clause:

- `[5m]` - last 5 minutes
- `[10m:5m]` - last 10 minutes to last 5 minutes
- `[10m:5m:1m]` - last 10 minutes to last 5 minutes with results aggregated at 1-minute intervals
- `[2019-01-01 12:13:14:5m:1w]` -  2019/1/1 12:13:14 to the last 5 minutes, and the results are aggregated at one-week intervals. Note that when specifying a date, it can only be accurate to the second level. And there are only two date formats:
  - `2006-01-02 15:04:05`: The time here refers to the time in UTC time zone, and the specified time zone is unavailable.
  - `2006-01-02`

The following time units are available:

- `ns` - nanoseconds
- `us` - microseconds
- `ms` - milliseconds
- `s` - seconds
- `m` - minutes
- `h` - hours
- `d` - days
- `w` - weeks
- `y` - years, specified as 365 days, with no distinction between leap years.

### By-clause Statement

The `BY` clause is used to categorize and aggregate the results. Similar to `GROUP BY` in MySQL.

### Order-by-clause Statement

The `ORDER BY` clause sorts the results, similar to the `ORDER BY` in MySQL.

⚠️ Time series data, only time field sorting is supported.

```python
# Get the maximum CPU utilization of different hosts, in reverse order of time.
M::cpu:(max('usage_total')) by host order by time desc
```

```python
# Obtain the response time of processing requests under different hosts, in ascending order of response time.
L::`*`:(max('response_time') as m1) by host order by m1 asc
```

### Filter-clause Statement

`FILTER ... WITH ...` is used to filter different data sets:

```python
# Get the CPU usage of all objects.
M::cpu:(host, usage) FILTER O::ecs:(hostname) WITH {host = hostname}
```

### Link-with Statement

`LINK ... WITH ...` is used to combine output from different data sets:

```python
O::ecs:(host, region) LINK M::cpu:(usage, hostname) [:5m] WITH {host = hostname}

# Multiple LINK writing
O::ecs:(host, region)  
    LINK M::cpu:(usage, hostname) [:5m]
    LINK M::mem:(percent, hostname) [:5m]
    WITH {host = hostname}
```

### Limit Statement

Used to specify the number of rows returned

Note:

For time series data, if the dql statement contains both the by phrase and the limit phrase, the limit constrains the number of returned items in each aggregate group.

```python
# Back to three cpu records
M::cpu:() limit 3

# Back to three cpu records per host
M::cpu:() by host limit 3
```

### slimit statement

Used to specify the number of packets

```python
# Back to cpu usage information for three hosts
M::cpu:(last(usage_total)) by host slimit 3

# Back to CPU information of three hosts, where each host returns three records
M::cpu:() by host limit 3 slimit 3
```



### SHOW Statement

`SHOW_xxx` is used to browse data (function names are not case sensitive):

- `SHOW_MEASUREMENT()` - view a list of measurements, supporting `filter-clause`、`limit` and `offset` statement
- `SHOW_OBJECT_CLASS()` - view object classification list
- `SHOW_CUSTOM_OBJECT_SOURCE()` - view a list of custom object data types
- `SHOW_EVENT_SOURCE()` - view list of event sources
- `SHOW_LOGGING_SOURCE()` - view log source list
- `SHOW_TRACING_SERVICE()` - view tracing source list
- `SHOW_RUM_TYPE()` - view list of RUM data types
- `SHOW_NETWORK_SOURCE()` - view list of network eBPF data types
- `SHOW_SECURITY_SOURCE()` - view list of security patrol data types
- `SHOW_WORKSPACES()` - view the current workspace and its authorized workspace information
For more show functions, see[Function Document](funcs.md)

### Result Set Function Settlement

DQL supports secondary evaluation of query results:

```python
func::dataflux__dql:(EXPR_EVAL(expr='data1.f1+data1.f2', data=dql('M::cpu:(f1, f2)')))

# Calculate across data sets through func
F::dataflux__dql:(SOME_FUNC(
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'), some_args))

# Calculate complex expression evaluation across data sets through func
F::dataflux__dql:(EXPR_EVAL(
	expr='data1.f1/(data2.f2+3)',  # expression
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'),))
```

### Nested Queries and Statement Blocks

Use `()` to indicate the separation of subqueries and outer queries, such as two layers of nesting.

```python
metric::(
		# Subquery
		metric::cpu,mem:(f1, f2) {host="abcd"} [1m:2m:5s] BY f1 DESC 
	):(f1)              # Outer query target column
	{ host=re("abc*") } # Outer query filter criteria
	[1m:2m:1s]          # Outer query time limit
```

Three-layer nesting

```python
metric::(     # the second layer query
		metric::( # the third layer query
				metric::a:(f1,f2,f3) {host="foo"} [10m::1m]
			):(f1,f2)
	):(f1)
```

In principle, there is no restriction on nesting level, but **multiple horizontal subqueries are not allowed**, for example:

```python
object::(     # the second layer query
		object::( # the third layer query
				object::a:(f1,f2,f3) {host="foo"} [10m::1m]
			):(f1,f2),

		object::( # the third layer query: unavailable
				object::b:(f1,f2,f3) {host="foo"} [10m::1m]
			):(f1,f2)
	):(f1)
```

## Special Usage

If the message field is the data type of json (currently supported by L/O/T/R and so on), it is supported to extract the field directly through DQL in the following form:

```python
L::nginx { @abc.def = "xyz" }


It is equivalent to the following query, which means `message@json` by `@`, which is a shorthand.

``` python
L::nginx { `message@jons.abc.def` = "xyz" }
```

## Function Description

See [DQL Functions](funcs.md)

See [DQL Outer Functions](out-funcs.md)


---

