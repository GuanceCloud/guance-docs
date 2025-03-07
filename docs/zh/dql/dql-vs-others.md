# DQL VS 其它查询语言
---

<a name="1ad93e28"></a>
## 前言

DQL 是<<< custom_key.brand_name >>>统一的查询语言，为便于大家学习这种语言，下面我们选取几种不同的查询语言来与之对比，以便大家能较为快速的理解和运用 DQL。

这里我们选择 [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) 、[LogQL](https://grafana.com/docs/loki/latest/logql/) 以及大家较为熟知的 SQL 语句作为对比，对各个查询语言的基本使用做一个对比。

**注意：**SQL 有强大的增、删、查、改能力，此处只摘取其查询功能作为对比。


PromQL 是 [Prometheus](https://prometheus.io/) 中用于查询其时序数据的一种查询语言；LogQL 是用于 [Grafana Loki](https://grafana.com/oss/loki/) 的一种日志查询语言，它借鉴了 PromQL 的语法结构设计，跟 PromQL 的写法很相近。SQL 则是我们日常使用最多的一种通用查询语言，其语法结构跟前两者差异很大（各个不同数据库大同小异，此处以 MySQL 为例）。

DQL 初期的语法结构跟 PromQL 类似，随着业务的不断拓展，DQL 自身也逐渐演变出不同的查询功能，它综合了 PromQL 的基本语法结构，但同时借鉴了 SQL 语句的一些语法结构以及语义表达，旨在更便于大家编写一些较为复杂的查询。

下文将从如下几个方面加以说明各个查询语言的差异：

- 基本语法结构
- 支持的常用预定义函数
- 常用查询写法

<a name="de3e31ea"></a>
## 基本语法结构
| 查询语言 | 基本结构 |
| --- | --- |
| PromQL | `指标 {条件过滤列表} [起始时间:结束时间]` |
| LogQL | `{stream-selector} log-pipeline` |
| SQL | `SELECT <column-clause> <FROM-clause> <WHERE-clause> <GROUP-BY-clause> ...` |
| DQL | `namespace::指标集:(column-clause) [time-range-clause] { WHERE-clause } GROUP-BY-clause ORDER-BY-clause` |


下面分别加以说明。

<a name="PromQL"></a>
### PromQL

在 Prometheuse 中，相关指标是离散形式组织的。在其查询中，可直接查找对应的指标，如：

```python
http_requests_total{environment="prometheus", method!="GET"}
```

此处即查找指标 `http_requests_total`，通过指定其 label 限制条件（`environment` 和 `method`）来过滤数据。

**注意：**PromeQL 称这里的 label 限制条件为 Label Matchers。可简单将其理解为一种 where 条件过滤。


<a name="LogQL"></a>
### LogQL

顾名思义，LogQL 主要用于日志内容查询，如：

```python
{container="query-frontend", namespace="loki-dev"}
	|= "metrics.go"
	| logfmt
	| duration > 10s and throughput_mb < 500
```

此处 `{...}` 里面的，LogQL 称之为 Stream Selector，其旨在于划定数据查询范围（类似于 SQL 中的 `FROM ...` 部分）；后半部分则称之为 Log Pipeline，其主要处理日志信息的提取和过滤。

从这里可看出，LogQL 中的 `{...}` 跟 PromQL 中的 Label Matchers 一样，我们也可将其理解为一种 where 条件过滤。

<a name="SQL"></a>
### SQL

对于大家最为熟知的查询语言，如果要达到如上俩种效果，简单翻译如下（因存储结构不同，此处只表达大概意思）：

```sql
SELECT * FROM `loki-dev`
	WHERE container="query-frontend" AND
	duration > 10s AND
	throughput_mb < 500
```

<a name="DQL"></a>
### DQL

DQL 本质上是一个查询翻译器，其后台并不直接管理数据的存储和组织。故理论上其可以支持任意类型的存储引擎，如信息数据存储（MySQL/Oracle/ES/Redis 等）、文件存储（HBASE/S3/OSS 等）。目前 DQL 主要用于如下几类数据的查询：

- 时序数据
- 日志数据
- 对象数据
- 应用性能追踪（APM）数据
- 用户行为检测（RUM）数据
- 关键事件数据
- 安全巡检数据
- ...

如：

```
metric::cpu:(usage_system, usage_user) { usage_idle > 0.9 } [2d:1d:1h] BY hostname
```

此处，`metric` 指定了要查询时序数据（可简单理解成 MySQL 中的一个 DB），而 `cpu` 就是其中的一种指标集（类似于 MySQL 中的 Table），并且指定查找其中的两个字段 `usage_system` 和 `usage_user`；接着，`{...}` 中的表示过滤条件，最后 `[...]` 表示查询的时间范围：前天到昨天一段时间内，以 1h 为聚合间隔。

更多示例：

```
# 查询 K8s 中的 pod 对象（object）
object::kubelet_pod:(name, age) { cpu_usage > 30.0 } [10m] BY namespace

# 查找名为 my_service 应用的日志（message 字段）
logging::my_service:(message) [1d]

# 查看应用性能追踪（T 即 tracing）中，持续时间 > 1000us 的 span 数据，并且按照 operation 来分组
T::my_service { duration > 1000 } [10m] BY operation
```

<a name="b69c48c4"></a>
## 横向对比

<a name="48b7e96a"></a>
### 基本功能对比
| 查询语言 | 主要领域 | 支持时序查询 | 支持日志查询 | 支持时间范围查找 | 支持 group by 聚合 |
| --- | --- | --- | --- | --- | --- |
| PromQL | Prometheuse 指标查询 | 支持 | 不支持 | 支持 | [支持](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators) |
| LogQL | 主要用于查询日志 | 支持从日志生成指标 | 支持 | 支持 | [支持](https://grafana.com/docs/loki/latest/logql/#aggregation-operators) |
| SQL | 通用查询语言 | [某些数据库](https://www.timescale.com/)<br />支持时序存储 | 不适合 | 支持 | 支持 |
| DQL | <<< custom_key.brand_name >>>全平台数据查询 | 支持 | 支持 | 支持 | 支持 |


<a name="8d81dc5d"></a>
### 周边工具支持
| 查询语言 | 注释方式 | 是否支持 HTTP API | 是否支持 Pipeline 切割 | 是否支持命令行 |
| --- | --- | --- | --- | --- |
| PromQL | `# 单行注释` | [支持](https://prometheus.io/docs/prometheus/latest/querying/api/) | 不支持 | [promql-cli](https://github.com/nalbury/promql-cli) |
| LogQL | `# 单行注释` | [支持](https://grafana.com/docs/loki/latest/api/) | 支持 | [logcli](https://grafana.com/docs/loki/latest/getting-started/logcli/) |
| SQL | `-- 单行注释`<br /> 或 `/* 多行注释 */` | 不支持 | 不支持 | 各种 SQL 客户端，此处不再赘述 |
| DQL | `# 单行注释` | [支持](../datakit/apis.md) | 不支持（在 DataKit 端已预先切割好） | 需[安装DataKit](../datakit/datakit-install.md)<br />，再执行[查询](../datakit/datakit-dql-how-to.md) |


<a name="1b8fbe0e"></a>
### 数据处理函数支持情况

- [PromQL 支持的函数列表](https://prometheus.io/docs/prometheus/latest/querying/functions/#functions)
- [LogQL 支持的函数列表](https://grafana.com/docs/loki/latest/logql/#metric-queries)
- [MySQL 支持的函数列表](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html)
- [DQL 支持的函数列表](../dql/funcs.md)

<a name="c05ceae0"></a>
## 常见查询语句写法对比

<a name="cecdfda9"></a>
### 普通数据查询及过滤

```
# LogQL
{ cluster="ops-tools1", namespace="dev", job="query-frontend"}
  |= "metrics.go"
  !="out of order"
  | logfmt
  | duration > 30s or status_code!="200"

# PromQL（PromQL 大概不支持普通意义上的 OR 过滤）
http_requests_total{ cluster='ops-tools1', job!='query=frontend', duration > 30s }

# SQL
SELECT * FROM dev
  WHERE cluster='ops-tools' AND
  job='query=frontend' AND
  (duration > 30000000000 OR stataus_code != 200)

# DQL：从语句结构上可看出，DQL 的语义组织跟 SQL 比较接近
L::dev {
  cluster='ops-tools',
  job='query=frontend',
  message != match("out of order")
  (duraton > 30s OR stataus_code != 200) # DQL 支持嵌套结构过滤
}
```

以下是各种 DQL 语句的写法罗列

```
# where-clause 可用 AND 来串联，AND 跟 `,' 语义等价
L::dev {
  cluster='ops-tools' AND
  job='query=frontend' AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)}

# 支持 AS 别名/支持中文变量
metric::cpu:(usage_system AS 系统用量, usage_user AS 用户用量)

# where-cluase 支持 array-list IN 过滤
L::dev {
  cluster='ops-tools' AND
  job IN [ 'query=frontend', 'query=backend'] AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)
}

# 支持 base64 传值：对于一些复杂的字符串（比如多行），避免头疼的转义
T::dev {
  cluster='ops-tools' AND
  resourec IN [
    'some-raw-string', # 普通字符串
    b64'c2VsZWN0ICoKZnJvbSBhYmMKd2hlcmUgeCA+IDAK' # base64 字符串
  ]
}
```

<a name="5e769752"></a>
### 带聚合的查询以及过滤

```python
# LogQL
sum by (org_id) ({source="ops-tools",container="app-dev"} |= "metrics.go" | logfmt | unwrap bytes_processed [1m])

# PromQL
histogram_quantile(0.9, sum by (job, le) (rate(http_request_duration_seconds_bucket[10m])))

# DQL（注意，ops-tools 两边需加上 ``，不然被解析成减法表达式）
L::`ops-tools`:(bytes_processed) {filename = "metrics.go", container="app-dev"} [2m] BY sum(orig_id)
```

<a name="fb1fdfb2"></a>
### 浏览数据情况

```python
# LogQL/PromQL 暂未找到类似查询功能

# MySQL
show tables;
show databases;

# DQL
show_measurement()    # 查看时序指标集列表
show_object_source()  # 查看对象分类列表
show_rum_source()     # 查看 RUM 数据分类列表
show_logging_source() # 查看日志分类列表
```

<a name="25f9c7fa"></a>
## 总结

以上内容对几个常见的查询语言做了一些基本面的介绍，各个语言有其特定的应用领域，彼此之间功能差异也比较明显。对 DQL 而言，其设计初衷在于提供一种混合存储的查询方案，这是它相比文中其它几种查询语言的最大区别。虽然 DQL 并没有一个独立的存储引擎，但其扩展性是其它几种无言所不能相比的，这也正符合其<u>混合存储查询</u>的定位。

目前 DQL 还在积极的开发和完善中，功能、性能还有较大的提升空间。目前<<< custom_key.brand_name >>>的所有数据查询均全面应用 DQL，其功能、性能、稳定性经过了较为长时间的验证。随着<<< custom_key.brand_name >>>整体产品的迭代，DQL 自身的完整性也将逐步演进，以满足产品侧以及广大开发者的需求。


---

