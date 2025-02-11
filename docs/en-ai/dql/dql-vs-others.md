# DQL VS Other Query Languages
---

<a name="1ad93e28"></a>
## Preface

DQL is the unified query language of Guance, designed to facilitate learning this language. Below, we compare it with several different query languages to help users quickly understand and apply DQL.

Here, we choose [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/), [LogQL](https://grafana.com/docs/loki/latest/logql/), and the widely known SQL statements for comparison, focusing on basic usage differences among these query languages.

**Note:** SQL has powerful capabilities for inserting, deleting, querying, and updating data; here we only compare its querying functions.

PromQL is a query language used in [Prometheus](https://prometheus.io/) for querying time series data; LogQL is a log query language used in [Grafana Loki](https://grafana.com/oss/loki/), which borrows PromQL's syntax structure and closely resembles it. SQL, on the other hand, is a general-purpose query language commonly used daily, with significant syntactical differences from the former two (variations exist among different databases, but we use MySQL as an example here).

Initially, DQL's syntax was similar to PromQL. As business needs expanded, DQL evolved to include various query functionalities, combining PromQL's basic syntax with some SQL-like structures and semantics to make it easier to write complex queries.

The following sections will compare these query languages based on:

- Basic syntax structure
- Supported common predefined functions
- Common query writing methods

<a name="de3e31ea"></a>
## Basic Syntax Structure
| Query Language | Basic Structure |
| --- | --- |
| PromQL | `Metrics {filter conditions} [start_time:end_time]` |
| LogQL | `{stream-selector} log-pipeline` |
| SQL | `SELECT <column-clause> <FROM-clause> <WHERE-clause> <GROUP-BY-clause> ...` |
| DQL | `namespace::Mearsurement:(column-clause) [time-range-clause] { WHERE-clause } GROUP-BY-clause ORDER-BY-clause` |

Below are detailed explanations.

<a name="PromQL"></a>
### PromQL

In Prometheus, metrics are organized in a discrete form. In its queries, you can directly look up corresponding metrics, such as:

```python
http_requests_total{environment="prometheus", method!="GET"}
```

This query looks up the metric `http_requests_total`, filtering data by specifying label conditions (`environment` and `method`).

**Note:** PromQL refers to these label conditions as Label Matchers, which can be simply understood as where clause filters.


<a name="LogQL"></a>
### LogQL

As the name suggests, LogQL is mainly used for querying log content, such as:

```python
{container="query-frontend", namespace="loki-dev"}
	|= "metrics.go"
	| logfmt
	| duration > 10s and throughput_mb < 500
```

Here, `{...}` is called a Stream Selector in LogQL, defining the scope of data queries (similar to the `FROM ...` part in SQL); the latter part is called a Log Pipeline, primarily processing log information extraction and filtering.

From this, we can see that `{...}` in LogQL serves the same purpose as Label Matchers in PromQL, both functioning as where clause filters.

<a name="SQL"></a>
### SQL

For the most familiar query language, achieving the above effects would be translated as follows (due to different storage structures, this is just a rough equivalent):

```sql
SELECT * FROM `loki-dev`
	WHERE container="query-frontend" AND
	duration > 10s AND
	throughput_mb < 500
```

<a name="DQL"></a>
### DQL

DQL is essentially a query translator that does not directly manage data storage and organization. Therefore, theoretically, it can support any type of storage engine, such as relational databases (MySQL/Oracle/ES/Redis, etc.), file storage (HBASE/S3/OSS, etc.). Currently, DQL is mainly used for querying:

- Time series data
- Log data
- Object data
- APM data
- RUM data
- Key event data
- Security check data
- ...

Example:

```
metric::cpu:(usage_system, usage_user) { usage_idle > 0.9 } [2d:1d:1h] BY hostname
```

Here, `metric` specifies the time series data to be queried (similar to a DB in MySQL), and `cpu` is one of the Mearsurements (similar to a Table in MySQL), specifying two fields `usage_system` and `usage_user`. The `{...}` contains filter conditions, and `[...]` indicates the query time range: from two days ago to yesterday, aggregated every hour.

More examples:

```
# Query K8s pod objects (object)
object::kubelet_pod:(name, age) { cpu_usage > 30.0 } [10m] BY namespace

# Find logs for the application named my_service (message field)
logging::my_service:(message) [1d]

# View span data in APM tracing where duration > 1000us, grouped by operation
T::my_service { duration > 1000 } [10m] BY operation
```

<a name="b69c48c4"></a>
## Horizontal Comparison

<a name="48b7e96a"></a>
### Basic Functionality Comparison
| Query Language | Main Domain | Supports Time Series Queries | Supports Log Queries | Supports Time Range Queries | Supports Group By Aggregation |
| --- | --- | --- | --- | --- | --- |
| PromQL | Prometheus Metrics Query | Supported | Not Supported | Supported | [Supported](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators) |
| LogQL | Primarily for Log Queries | Supports generating metrics from logs | Supported | Supported | [Supported](https://grafana.com/docs/loki/latest/logql/#aggregation-operators) |
| SQL | General Query Language | [Some databases](https://www.timescale.com/) support time series storage | Not Suitable | Supported | Supported |
| DQL | Guance Full Platform Data Query | Supported | Supported | Supported | Supported |


<a name="8d81dc5d"></a>
### Peripheral Tool Support
| Query Language | Comment Style | HTTP API Support | Pipeline Splitting Support | Command Line Support |
| --- | --- | --- | --- | --- |
| PromQL | `# Single-line comment` | [Supported](https://prometheus.io/docs/prometheus/latest/querying/api/) | Not Supported | [promql-cli](https://github.com/nalbury/promql-cli) |
| LogQL | `# Single-line comment` | [Supported](https://grafana.com/docs/loki/latest/api/) | Supported | [logcli](https://grafana.com/docs/loki/latest/getting-started/logcli/) |
| SQL | `-- Single-line comment` or `/* Multi-line comment */` | Not Supported | Not Supported | Various SQL clients, no further details provided |
| DQL | `# Single-line comment` | [Supported](../datakit/apis.md) | Not Supported (pre-split at DataKit end) | Requires [installing DataKit](../datakit/datakit-install.md), then execute [queries](../datakit/datakit-dql-how-to.md) |


<a name="1b8fbe0e"></a>
### Data Processing Function Support

- [List of supported functions in PromQL](https://prometheus.io/docs/prometheus/latest/querying/functions/#functions)
- [List of supported functions in LogQL](https://grafana.com/docs/loki/latest/logql/#metric-queries)
- [List of supported functions in MySQL](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html)
- [List of supported functions in DQL](../dql/funcs.md)

<a name="c05ceae0"></a>
## Common Query Statement Comparisons

<a name="cecdfda9"></a>
### Ordinary Data Query and Filtering

```
# LogQL
{ cluster="ops-tools1", namespace="dev", job="query-frontend"}
  |= "metrics.go"
  !="out of order"
  | logfmt
  | duration > 30s or status_code!="200"

# PromQL (PromQL generally does not support OR filtering in this sense)
http_requests_total{ cluster='ops-tools1', job!='query=frontend', duration > 30s }

# SQL
SELECT * FROM dev
  WHERE cluster='ops-tools' AND
  job='query=frontend' AND
  (duration > 30000000000 OR stataus_code != 200)

# DQL: From the statement structure, it can be seen that DQL's semantic organization is closer to SQL
L::dev {
  cluster='ops-tools',
  job='query=frontend',
  message != match("out of order")
  (duraton > 30s OR stataus_code != 200) # DQL supports nested structure filtering
}
```

Here are various DQL statement examples:

```
# where-clause can be concatenated using AND, which is semantically equivalent to `,'
L::dev {
  cluster='ops-tools' AND
  job='query=frontend' AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)}

# Supports AS aliases/supports Chinese variables
metric::cpu:(usage_system AS System Usage, usage_user AS User Usage)

# where-clause supports array-list IN filtering
L::dev {
  cluster='ops-tools' AND
  job IN [ 'query=frontend', 'query=backend'] AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)
}

# Supports base64 values: For complex strings (like multi-line), avoid cumbersome escaping
T::dev {
  cluster='ops-tools' AND
  resourec IN [
    'some-raw-string', # Regular string
    b64'c2VsZWN0ICoKZnJvbSBhYmMKd2hlcmUgeCA+IDAK' # Base64 string
  ]
}
```

<a name="5e769752"></a>
### Aggregated Queries and Filtering

```python
# LogQL
sum by (org_id) ({source="ops-tools",container="app-dev"} |= "metrics.go" | logfmt | unwrap bytes_processed [1m])

# PromQL
histogram_quantile(0.9, sum by (job, le) (rate(http_request_duration_seconds_bucket[10m])))

# DQL (Note: ops-tools should be enclosed in `` to prevent parsing as subtraction)
L::`ops-tools`:(bytes_processed) {filename = "metrics.go", container="app-dev"} [2m] BY sum(orig_id)
```

<a name="fb1fdfb2"></a>
### Browsing Data Information

```python
# LogQL/PromQL do not have similar query functions

# MySQL
show tables;
show databases;

# DQL
show_measurement()    # View list of time series Mearsurements
show_object_source()  # View list of object classifications
show_rum_source()     # View list of RUM data classifications
show_logging_source() # View list of log classifications
```

<a name="25f9c7fa"></a>
## Summary

The above content provides a basic introduction to several common query languages. Each language has specific application areas, and their functional differences are quite noticeable. For DQL, its design aims to provide a hybrid storage query solution, which is its main distinction compared to the other query languages mentioned. Although DQL does not have a standalone storage engine, its extensibility far surpasses the others, aligning with its positioning as a **hybrid storage query** tool.

Currently, DQL is actively being developed and improved, with room for enhancement in functionality and performance. All data queries in Guance now fully utilize DQL, whose functionality, performance, and stability have been validated over a long period. As the overall product iterates, DQL will continue to evolve to meet the needs of the product and developers.