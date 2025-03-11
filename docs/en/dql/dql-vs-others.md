# DQL VS Other Query Languages
---

<a name="1ad93e28"></a>
## Preface

DQL is <<< custom_key.brand_name >>>'s unified query language. To facilitate learning this language, we will compare it with several other query languages below to help users understand and use DQL more quickly.

Here, we have chosen [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/), [LogQL](https://grafana.com/docs/loki/latest/logql/), and the well-known SQL statements for comparison, highlighting the basic usage of each query language.

**Note:** SQL has powerful capabilities for insert, delete, update, and select operations; here we only focus on its query functionality for comparison.


PromQL is a query language used in [Prometheus](https://prometheus.io/) for querying time series data; LogQL is a log query language used in [Grafana Loki](https://grafana.com/oss/loki/), which borrows the syntax structure from PromQL and closely resembles it. SQL, on the other hand, is a widely-used general-purpose query language whose syntax differs significantly from the first two (variations exist among different databases, but they are largely similar; here we use MySQL as an example).

Initially, DQL's syntax was similar to PromQL. As business needs expanded, DQL evolved to include various query functionalities. It combines the basic syntax of PromQL with elements from SQL to make it easier for users to write more complex queries.

The following sections will explain the differences between these query languages in terms of:

- Basic Syntax Structure
- Supported Common Predefined Functions
- Common Query Writing Styles

<a name="de3e31ea"></a>
## Basic Syntax Structure
| Query Language | Basic Structure |
| --- | --- |
| PromQL | `Metrics {filter conditions} [start_time:end_time]` |
| LogQL | `{stream-selector} log-pipeline` |
| SQL | `SELECT <column-clause> <FROM-clause> <WHERE-clause> <GROUP-BY-clause> ...` |
| DQL | `namespace::Measurement:(column-clause) [time-range-clause] { WHERE-clause } GROUP-BY-clause ORDER-BY-clause` |

Below, we provide detailed explanations.

<a name="PromQL"></a>
### PromQL

In Prometheus, related metrics are organized in a discrete manner. In its queries, you can directly search for specific metrics, such as:

```python
http_requests_total{environment="prometheus", method!="GET"}
```

This query searches for the metric `http_requests_total`, filtering the data by specifying label conditions (`environment` and `method`).

**Note:** PromQL refers to these label conditions as Label Matchers. You can simply think of them as where clause filters.

<a name="LogQL"></a>
### LogQL

As the name suggests, LogQL is primarily used for querying log content, such as:

```python
{container="query-frontend", namespace="loki-dev"}
	|= "metrics.go"
	| logfmt
	| duration > 10s and throughput_mb < 500
```

Here, `{...}` is called a Stream Selector in LogQL, which defines the data query scope (similar to the `FROM ...` part in SQL); the latter part is called a Log Pipeline, which mainly processes log information extraction and filtering.

From this, we can see that the `{...}` in LogQL serves the same purpose as Label Matchers in PromQL, both of which can be understood as where clause filters.

<a name="SQL"></a>
### SQL

For the most familiar query language, achieving similar effects would look like this (due to different storage structures, this is just an approximate translation):

```sql
SELECT * FROM `loki-dev`
	WHERE container="query-frontend" AND
	duration > 10s AND
	throughput_mb < 500
```

<a name="DQL"></a>
### DQL

DQL is essentially a query translator that does not directly manage data storage and organization. Therefore, theoretically, it can support any type of storage engine, such as information data storage (MySQL/Oracle/ES/Redis, etc.), file storage (HBASE/S3/OSS, etc.). Currently, DQL is mainly used for querying the following types of data:

- Time Series Data
- Log Data
- Object Data
- APM Data
- RUM Data
- Critical Event Data
- Security Check Data
- ...

For example:

```
metric::cpu:(usage_system, usage_user) { usage_idle > 0.9 } [2d:1d:1h] BY hostname
```

Here, `metric` specifies the time series data to be queried (similar to a DB in MySQL), and `cpu` is a type of Measurement (similar to a Table in MySQL), specifying two fields `usage_system` and `usage_user`. The `{...}` indicates filter conditions, and `[...]` specifies the time range for the query: from two days ago to yesterday, aggregated every hour.

More examples:

```
# Query K8s pod objects (object)
object::kubelet_pod:(name, age) { cpu_usage > 30.0 } [10m] BY namespace

# Find logs for the application named my_service (message field)
logging::my_service:(message) [1d]

# View span data in APM tracing with duration > 1000us, grouped by operation
T::my_service { duration > 1000 } [10m] BY operation
```

<a name="b69c48c4"></a>
## Horizontal Comparison

<a name="48b7e96a"></a>
### Basic Function Comparison
| Query Language | Main Domain | Supports Time Series Queries | Supports Log Queries | Supports Time Range Search | Supports Group By Aggregation |
| --- | --- | --- | --- | --- | --- |
| PromQL | Prometheus Metrics Query | Supported | Not Supported | Supported | [Supported](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators) |
| LogQL | Primarily for Log Queries | Supports Generating Metrics from Logs | Supported | Supported | [Supported](https://grafana.com/docs/loki/latest/logql/#aggregation-operators) |
| SQL | General Query Language | [Some Databases](https://www.timescale.com/)<br />Support Time Series Storage | Not Suitable | Supported | Supported |
| DQL | <<< custom_key.brand_name >>> Full Platform Data Query | Supported | Supported | Supported | Supported |


<a name="8d81dc5d"></a>
### Peripheral Tool Support
| Query Language | Comment Style | HTTP API Support | Pipeline Cutting Support | Command Line Support |
| --- | --- | --- | --- | --- |
| PromQL | `# Single-line comment` | [Supported](https://prometheus.io/docs/prometheus/latest/querying/api/) | Not Supported | [promql-cli](https://github.com/nalbury/promql-cli) |
| LogQL | `# Single-line comment` | [Supported](https://grafana.com/docs/loki/latest/api/) | Supported | [logcli](https://grafana.com/docs/loki/latest/getting-started/logcli/) |
| SQL | `-- Single-line comment`<br /> or `/* Multi-line comment */` | Not Supported | Not Supported | Various SQL Clients, no further details |
| DQL | `# Single-line comment` | [Supported](../datakit/apis.md) | Not Supported (Pre-cut in DataKit) | Need to [install DataKit](../datakit/datakit-install.md)<br />, then execute [queries](../datakit/datakit-dql-how-to.md) |


<a name="1b8fbe0e"></a>
### Data Processing Function Support

- [PromQL Supported Function List](https://prometheus.io/docs/prometheus/latest/querying/functions/#functions)
- [LogQL Supported Function List](https://grafana.com/docs/loki/latest/logql/#metric-queries)
- [MySQL Supported Function List](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html)
- [DQL Supported Function List](../dql/funcs.md)

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

# PromQL (PromQL roughly does not support OR filtering in the conventional sense)
http_requests_total{ cluster='ops-tools1', job!='query=frontend', duration > 30s }

# SQL
SELECT * FROM dev
  WHERE cluster='ops-tools' AND
  job='query=frontend' AND
  (duration > 30000000000 OR stataus_code != 200)

# DQL: From the statement structure, DQL's semantic organization is closer to SQL
L::dev {
  cluster='ops-tools',
  job='query=frontend',
  message != match("out of order")
  (duraton > 30s OR stataus_code != 200) # DQL supports nested structure filtering
}
```

Below are various DQL statement examples:

```
# where-clause can be chained with AND, AND is semantically equivalent to `,'
L::dev {
  cluster='ops-tools' AND
  job='query=frontend' AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)}

# Supports AS alias / supports Chinese variables
metric::cpu:(usage_system AS system_usage, usage_user AS user_usage)

# where-clause supports array-list IN filtering
L::dev {
  cluster='ops-tools' AND
  job IN [ 'query=frontend', 'query=backend'] AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)
}

# Supports base64 value passing: For complex strings (like multiline), avoid tedious escaping
T::dev {
  cluster='ops-tools' AND
  resourec IN [
    'some-raw-string', # Plain string
    b64'c2VsZWN0ICoKZnJvbSBhYmMKd2hlcmUgeCA+IDAK' # Base64 string
  ]
}
```

<a name="5e769752"></a>
### Aggregated Queries with Filtering

```python
# LogQL
sum by (org_id) ({source="ops-tools",container="app-dev"} |= "metrics.go" | logfmt | unwrap bytes_processed [1m])

# PromQL
histogram_quantile(0.9, sum by (job, le) (rate(http_request_duration_seconds_bucket[10m])))

# DQL (Note: `ops-tools` should be enclosed in backticks to prevent parsing as subtraction)
L::`ops-tools`:(bytes_processed) {filename = "metrics.go", container="app-dev"} [2m] BY sum(orig_id)
```

<a name="fb1fdfb2"></a>
### Browsing Data Situations

```python
# LogQL/PromQL do not seem to have similar query functions

# MySQL
show tables;
show databases;

# DQL
show_measurement()    # View list of time series Mearsurements
show_object_source()  # View list of object classes
show_rum_source()     # View list of RUM data classes
show_logging_source() # View list of log classes
```

<a name="25f9c7fa"></a>
## Summary

The above content provides a basic introduction to several common query languages. Each language has its specific application domain, and their functionalities differ significantly. For DQL, its design aims to provide a hybrid storage query solution, which is its biggest distinction compared to the other query languages mentioned. Although DQL does not have a standalone storage engine, its extensibility sets it apart from the others, aligning with its hybrid storage query positioning.

Currently, DQL is actively being developed and improved. There is still considerable room for enhancing its functionality and performance. All data queries in <<< custom_key.brand_name >>> currently use DQL comprehensively, and its functionality, performance, and stability have been validated over a long period. As <<< custom_key.brand_name >>> products continue to iterate, the completeness of DQL will evolve to meet the needs of the product and developers.