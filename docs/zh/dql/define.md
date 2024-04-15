# DQL 定义
---

以下是 DataFlux 查询语言（DQL）定义。随着不同语法的逐步支持，该文档会做不同程度的调整和增删。

全局约束如下：

- 非关键字（如指标名、标签名等）大小写敏感，<u>关键字及函数名大小写不敏感</u>；

- 以 `#` 为行注释字符，不支持行内注释；

- 支持的操作符：

	- `+`  - 加法
	- `-`  - 减法
	- `*`  - 乘法
	- `/`  - 除法
	- `%`  - 取模
	- `=` - 等于
	- `!=` - 不等于
	- `<=` - 小于等于
	- `<` - 小于
	- `>=` - 大于等于
	- `>` -  大于
	- `^` - 指数运算
	- `&&` - 逻辑与
	- `||` - 逻辑或

- 支持的关键字：

```
AND AS ASC AUTO
BY DESC FALSE
LIMIT LINEAR
NIL OFFSET OR PREVIOUS
SLIMIT SOFFSET TRUE
```

- 标识符：标识符有几种形式，便于兼容各种变量命名形式：

	- 正常变量名中只能出现 `[_a-zA-Z0-9]` 这些字符，且首字符不能是数字。如 `_abc, _abc123, _123ab`。
	- 其它形式的变量名处理方式：
		- `this+is-a*xx/yy^zz?variable`，`by` 需写成 `` `this+is-a*xx/yy^zz?variable` ``，`` `by` ``，前者变量中带运算符，后者的 `by` 是 DQL 关键字；
		- 支持中文等 UTF8 标识符，如 `M::cpu:(usage AS 使用率) [5m]`。
			- 支持表情符号：`M::cpu:(usage AS 使用率👍) [5m]`。
		- 变量中就带了一个反引号，`` this`is-a-vairalbe `` 需写成 `` `identifier("this`is-a-vairalbe")` `` 来修饰。

- 字符串值可用双引号和单引号： `"this is a string"` 和 `'this is a string'` 是等价的。

- 特殊字符串：
	- base64 字符串：DQL 支持处理 base64 字符串，对于 bas64 字符串，DQL 在查询时能自动解出原始字符串，其写法如下：
		- `` b64`some-base64-string` ``
		- `b64'some-base64-string'`
		- `b64"some-base64-string"`

	- 正则表达式字符串：原 `re('xxx')` 已弃用，建议使用如下形式来标识正则字符串。
		- `` re`some-regexp` ``*（推荐）*
		- `re'some-regexp'`
		- `re"some-regexp"`

- 支持数据类型：
	- 支持浮点（`123.4`, `5.67E3`）
	- 整形（`123`, `-1`）
	- 字符串（`'张三'`, `"hello world"`）
	- Boolean（`true`, `false`）
	- Duration（`1y`, `1w`, `1d`, `1h`, `1m`, `1s`, `1ms`, `1us`, `1ns` 分别表示 1 年/周/天/时/分/秒/毫秒/微秒/纳秒）

## 查询

查询遵循如下的语法范式，注意，各个部分之间的相对顺序不能调换，如 `time-expr` 不能出现在 `filter-clause` 之前。

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

从语法角度而言， `data-source` 是必须的（类似于 SQL 中的 `FROM` 子句），其它部分都是可选的。但实际查询过程中，对查询的实际执行会施加一定约束（比如 `time_expr` 不允许时间跨度太大）。

举例：

```python
# 获取指标集 cpu 最近 5 分钟所有字段的数据
M::cpu [5m]

# 查找匹配正则表达式 *db 的所有指标最近 5 分钟的数据
M::re('*db') [5m]

# 获取指标集 cpu 10 分钟前到 5 分钟前的所有字段数据
M::cpu [10m:5m]

# 获取指标集 cpu 10 分钟前到 5 分钟前的所有字段数据，以 1分钟的间隔来聚合
M::cpu:(usage_idle) [10m:5m:1m]

# 查询时序数据指标集 cpu 最近 5分钟的两个字段 time_active, time_guest_nice，
# 以 host 和 cpu 两个 tag 来过滤，同时以 host 和 cpu 来分组显示结果。
M:: cpu:(time_active, time_guest_nice)
		{ host = "host-name", cpu = "cpu0" } [5m] BY host,cpu

# 以身高倒排，获取前十
O::human:(height, age) { age > 100, sex = "直男" } ORDER BY height desc LIMIT 10

M::cpu,mem:(time_active, time_guest_nice, host) { host = "host-name", cpu = "cpu0" } [5m] BY host,cpu
```

<font color=coral>**注意：**</font>：`::` 和 `:` 两边都是可以添加空白字符的，如下语句是等价的：

```python
M::cpu:(time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   ::cpu : (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]

M   :: cpu :   (time_active, time_guest_nice)
	{ host = "host-name", cpu = "cpu0" } [5m]
```

### 各数据类型查询示例 {#example}

- M::`指标集名`:(聚合函数(`指标名`)) { `标签名` = '标签值' } BY `标签名`

	- 比如：M::`cpu`:(last(`usage_system`)) {`host`=`xxx`} BY `host_ip`

- L::`日志来源`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：L::`datakit`:(COUNT(`*`)) { `index` = 'default' } BY `host`

- O::`类别名称`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

    - 比如：O::`HOST`:(COUNT(`*`)) { `class` = 'HOST' } BY `host_ip`

- E::`事件来源`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：E::`monitor`:(COUNT(`create_time`)) { `create_time` = 1688708829409 } BY `df_event_id`

- T::`服务名称`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：T::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

- R::`数据来源`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：R::`error`:(LAST(`browser`)) { `city` = 'unknown' } BY `city`

- S::`分类名称`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：S::`storage`:(LAST(`host`)) { `level` = re('warn') } BY `level`

- N::`网络来源`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：N::`httpflow`:(FIRST(`direction`)) { `http_version` = '1.1' } BY `dst_ip_type`

- P::`Profiling 名称`:(聚合函数(`属性名`)) { `属性名` = '属性值' } BY `属性名`

	- 比如：P::`mysqli`:(COUNT(`resource`)) { `status` = 'ok' } BY `status`

不使用聚合函数的情况：

比如：

- 统计不同【namespace】下的容器数量：

O::`docker_containers`:(COUNT(`*`)) BY `namespace`

- 查询容器的所有字段，并返回最新的 10 条：

O::`docker_containers` {`host`=`xxx`} limit 10

## 语句

### namespace {#namespace}

语义层面，目前支持以下几种数据源：

- M/metric - 时序指标数据
- O/object - 对象数据
- CO/custom_object - 用户自定义对象数据
- L/logging - 日志数据
- E/event - 事件数据
- T/tracing - 追踪数据
- R/rum - RUM 数据
- F/func - Func 函数计算
- N/network - 网络 eBPF 数据查找

在语法层面，暂不对数据源做约束。数据源语法如下：

```python
data-source ::
	# 具体查询细节...
```

在具体的查询中，如果不指定数据源，则默认为 `metric`（或 `M`），即时序指标是 DQL 的默认数据源。

### target-clause

查询的结果列表：

```python
M::cpu:(time_active, system_usage) {host="biz_prod"} [5m]

# 这里支持同一个指标集上不同指标（类型要基本匹配）之间进行计算
M::cpu:(time_active+1, time_active/time_guest_nice) [5m]
```

### filter-clause

过滤子句用来对结果数据做过滤，类似 SQL 中的 `where` 条件：

```python
# 查询人口对象中（__class=human）中百岁直男的身高
O::human:(height) { age > 100, sex = "直男" }

# 带正则的过滤
O::human:(height) { age > 100, sex != re("男") }

# 带计算表达式的过滤
O::human:(height) { (age + 1)/2 > 31, sex != re("男") }

# 带或运算表达式的过滤
O::human:(height) { age > 31 || sex != re("男"), weight > 70}

# 带聚合的的结果列
M::cpu:(avg(time_active) AS time_active_avg) [1d::1h]

# 带聚合填充的的结果列
M::cpu:(fill(avg(time_active) AS time_active_avg, 0.1)) [1d::1h]

# 带有 in 列表的查询,其中 in 中选项关系为逻辑 or, in 列表中只能是数值或者字符串
O::human:(height) { age in [30, 40, 50], weight > 70}
```

关于填充：

- 数值填充：形如 `cpu:(fill(f1, 123), fill(f2, "foo bar"), fill(f3, 123.456))`
- 线性填充：如 `cpu:(fill(f1, LINEAR))`
- 前值填充：如 `cpu:(fill(f1, PREVIOUS))`

<font color=coral>**注意：**</font>多个过滤条件之间。默认是 `AND` 的关系，但如果要表达 `OR` 的关系，就用 `||` 操作符即可。如下两个语句的意思是相等的：

```python
O::human:(height) { age > 31, sex != re("男") }
O::human:(height) { age > 31 && sex != re("男") }
```

来个复杂的过滤表达式：

```python
M::some_metric {(a>123.45 && b!=re("abc")) || (z!="abc"), c=re("xyz")} [1d::30m]
```

### time-expr

DataFlux 数据特点均有时间属性，故将时间的表达用单独的子句来表示：

`time-expr` 由3个部分组成 [`start_time`:`end_time`:`interval`:`rollup`]:

| 序号 | 名称         | 是否必须 | 说明                                                                                                | 示例                           |
| ---- | ------------ | -------- | --------------------------------------------------------------------------------------------------- | ------------------------------ |
| 1    | `start_time` | 否       | 时间过滤的开始时间                                                                                  | `1672502400000` / `1672502400` |
| 2    | `end_time`   | 否       | 时间过滤的结束时间                                                                                  | `1672588800000` / `1672588800` |
| 3    | `interval`   | 否       | 时间聚合周期，一般需要配合聚合或滚动聚合使用，支持 `s`、`m`、`h`、`d` 等时间单位，可以组合使用      | `1s`/`1m`/`1h` 等              |
| 4    | `rollup`     | 否       | 滚动聚合函数名，当前支持的聚合函数有 `avg`、`sum`、`min`、`max`、`count`、`first`、`last`、`stddev` | `last`                         |

<font color=coral>**注意：**</font>

`start_time`, `end_time` 支持 3 种格式：

- 带有时间单位的数值，例如: `1m`
- 时间戳，例如: `1672502400`
- 毫秒为单位的时间值，`1672502400000`

`interval` 的时间单位支持如下几种：

- `ns` - 纳秒
- `us` - 微秒
- `ms` - 毫秒
- `s` - 秒
- `m` - 分钟
- `h` - 小时
- `d` - 天
- `w` - 周
- `y` - 年，指定为 365d，不区分闰年。

`rollup` 滚动聚合函数名，当前支持的聚合函数有：

- `avg`: 平均值
- `sum`: 求和
- `min`: 最小值
- `max`: 最大值
- `count`: 计数
- `first`: 第一个
- `last`: 最后一个
- `deriv`: 每秒变化率，通过最后一个值减去第一个值并除以时间间隔来进行估算
- `rate`: 每秒变化率，与 `deriv` 类似但不返回负数结果，逻辑跟 PromQL 保持一致
- `irate`: 瞬时变化率，通过最后两个值的差并除以时间间隔来进行估算，逻辑跟 PromQL 保持一致
- `p99`、`p95`、`p90`、`p75`: 百分位计算，支持使用 p 后面跟任意数字来表达百分比
- `median`: 中位数，等同于 `p50`
- `stddev`: 标准差

`rollup` 滚动聚合是将单条时间线按照给定的 `interval` 拆分成不同的时间段，并在每个时间段上进行聚合求值。当 `rollup` 为空时，表示不进行滚动聚合。

常用示例:

- `[5m]` - 最近 5 分钟
- `[10m:5m]` - 最近 10 分钟到最近 5 分钟
- `[10m:5m:1m]` - 最近 10 分钟到最近 5 分钟，且结果按照 1 分钟的间隔聚合
- `[1672502400000:1672588800000]` - `2023-01-01 00:00:00` 到 `2023-01-02 00:00:00`时间范围
- `[1672502400:1672588800]` - `2023-01-01 00:00:00` 到 `2023-01-02 00:00:00`时间范围

### by-clause 语句

`BY` 子句用来对结果进行分类聚合，类似 MySQL 中的 `GROUP BY`。

### having-clause 语句

`HAVING` 子句用来对聚合以后得结果进行过滤，类似 MySQL 中的 `HAVING`。

```python
# 获取所有 CPU 使用率大于 80% 的主机
M::cpu:(max(`usage_total`) as `max_usage`) by host having max_usage > 80
```

### order-by-clause 语句

`ORDER BY` 子句会对结果进行排序，类似 MySQL 中的 `ORDER BY`。

<font color=coral>**注意：**</font> 1.「指标数据」只支持对 time 字段排序; 2. 当查询中 by 了分组，order-by 将不生效，请使用 sorder-by 排序。

```python
# 获取所有的主机CPU 使用率，按照时间逆序
M::cpu:(`usage_total`) order by time desc
```

```python
# 获取所有日志数据，按照响应时间升序
L::`*`:(`*`) order by response_time asc
```

### sorder-by-clause 语句

`SORDER BY` 子句会对分组进行排序。

```python
# 获取不同主机的 CPU 最大使用率，按照主机名逆序
M::cpu:(max(`usage_total`)) by host sorder by host desc
```

```python
# 获取不同主机的 CPU 最大使用率，按照最大 CPU 使用率升序
M::cpu:(max(`usage_total`) as m) by host sorder by m
```

```python
# 获取不同主机的 CPU 使用率，按照最新 CPU 使用率升序
M::cpu:(`usage_total`) sorder by usage_total
```

### limit 语句

用于指定返回行数，

<font color=coral>**注意：**</font>

对于时序数据，如果dql语句中同时包含了by短语和limit短语，limit约束的是每个聚合组中的返回条数

```python

# 返回三条cpu记录
M::cpu:() limit 3

# 返回每个主机的三条cpu记录
M::cpu:() by host limit 3
```

### slimit 语句

用于指定分组数量

```python
# 返回三台主机的cpu使用信息
M::cpu:(last(usage_total)) by host slimit 3

# 返回三台主机cpu信息，其中，每一台主机，返回三条记录
M::cpu:() by host limit 3 slimit 3
```


### SHOW 语句

`SHOW_xxx` 用来浏览数据（函数名不区分大小写）：

- `SHOW_MEASUREMENT()` - 查看指标集列表，支持`filter-clause`、`limit`和`offset`语句
- `SHOW_OBJECT_CLASS()` - 查看对象分类列表
- `SHOW_CUSTOM_OBJECT_SOURCE()` - 查看自定义对象数据类型列表
- `SHOW_EVENT_SOURCE()` - 查看事件来源列表
- `SHOW_LOGGING_SOURCE()` - 查看日志来源列表
- `SHOW_TRACING_SERVICE()` - 查看 tracing 来源列表
- `SHOW_RUM_TYPE()` - 查看 RUM 数据类型列表
- `SHOW_NETWORK_SOURCE()` - 查看网络 eBPF 数据类型列表
- `SHOW_SECURITY_SOURCE()` - 查看安全巡检数据类型列表
- `SHOW_WORKSPACES()` - 查看当前工作空间及其授权工作空间信息

> 更多 show 函数，参见[函数文档](funcs.md)

<!--
### 结果集函数结算

DQL 支持对查询结果进行二次计算：

```python
func::dataflux__dql:(EXPR_EVAL(expr='data1.f1+data1.f2', data=dql('M::cpu:(f1, f2)')))

# 通过 func 做跨数据集的计算
F::dataflux__dql:(SOME_FUNC(
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'), some_args))

# 通过 func 做跨数据集的复杂表达式计算
F::dataflux__dql:(EXPR_EVAL(
	expr='data1.f1/(data2.f2+3)',  # 表达式
	data1=dql('M::cpu:(f1, f2)'),
	data2=dql('O::ecs:(f1, f2)'),))
```
-->

### 嵌套查询以及语句块

以 `()` 来表示子查询和外层查询的分隔，如两层嵌套：

```python
M::(
# 子查询
M::cpu:(usage_total) {host='kind'}
):(last(usage_total))  # 外层查询目标列
{}  # 外层查询过滤条件
```

三层嵌套：

```python
M::(M::(M::cpu:(usage_total) {host='kind'}):(usage_total) {usage_total > 0} ):(last(usage_total))
```

原则上不对嵌套层次做限制。但<u>不允许某层嵌套中出现多个平级的子查询</u>，如：

```python
object::(     # 第二层查询
		object::( # 第三层查询
				object::a:(f1,f2,f3) {host="foo"}
			):(f1,f2),

		object::( # 并列第三层查询：不支持
				object::b:(f1,f2,f3) {host="foo"}
			):(f1,f2)
	):(f1)
```

## 特殊用法

如 message 字段是 json 的数据类型（目前只有日志支持），那么支持以如下形式直接通过 DQL 来提取字段：

```python
L::nginx { @abc.def = "xyz" }
```

它等价于下面的查询，即用 `@` 表示 `message@json`，这是一种简写。

```python
L::nginx { `message@json.abc.def` = "xyz" }
```

## 函数说明

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL 函数**</font>](./funcs.md)
- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL 外层函数**</font>](./out-funcs.md)

</div>
