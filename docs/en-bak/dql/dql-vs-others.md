# Comparison of DQL with Other Query Languages
---

<a name="1ad93e28"></a>
# Preface

DQL is a unified query language for Guance. In order to facilitate everyone to learn this language, we select several different query languages to compare with it, so that everyone can understand and use DQL quickly.

Here we choose [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/), [LogQL](https://grafana.com/docs/loki/latest/logql/) and well-known SQL statements as a comparison, and make a comparison of the basic use of each query language.

> Note: SQL has powerful ability to add, delete, check and change, so only its query function is taken here for comparison.


PromQL is a kind of query language used in [Prometheus](https://prometheus.io/) to query its time series data; LogQL is a log query language for [Grafana Loki](https://grafana.com/oss/loki/). Similar to PromQL, it uses the syntax structure design of PromQL for reference. SQL is one of the most commonly used query languages in our daily life, and its syntax structure is quite different from the former two (different databases are similar, taking MySQL as an example here).

The initial syntax structure of DQL is similar to PromQL. With the continuous expansion of business, DQL itself has gradually evolved different query functions. It integrates the basic syntax structure of PromQL, but at the same time draws lessons from some syntax structures and semantic expressions of SQL statements, aiming at making it easier for everyone to write some more complex queries.

The following will explain the differences of each query language from the following aspects:

- Basic grammatical structure
- Commonly Supported Predefined Functions
- Commonly used query writing

<a name="de3e31ea"></a>
## Basic Grammatical Structure
| Query Language | Basic Structure |
| --- | --- |
| PromQL | `Metric {conditional filter list} [tart time:end time]` |
| LogQL | `{stream-selector} log-pipeline` |
| SQL | `SELECT <column-clause> <FROM-clause> <WHERE-clause> <GROUP-BY-clause> ...` |
| DQL | `namespace::measurement:(column-clause) [time-range-clause] { WHERE-clause } GROUP-BY-clause ORDER-BY-clause` |


Detailed Explanation

<a name="PromQL"></a>
### PromQL

In Prometheuse, related metrics are organized in discrete form. In its query, you can directly find the corresponding metrics, such as:

```python
http_requests_total{environment="prometheus", method!="GET"}
```

Here you look for the metric `http_requests_total` and filter the data by specifying its label constraints (`environment` and `method`).

> Note: PromeQL calls the label constraint here Label Matchers. It can be simply understood as a kind of where conditional filtering.


<a name="LogQL"></a>
### LogQL

As the name implies, LogQL is mainly used for log content queries, such as:

```python
{container="query-frontend", namespace="loki-dev"}
	|= "metrics.go"
	| logfmt
	| duration > 10s and throughput_mb < 500
```

Here in `{...}` , LogQL is called Stream Selector, which is intended to delimit the data query (similar to the `FROM ...` part of SQL); The second part is called Log Pipeline, which mainly deals with the extraction and filtering of log information.

It can be seen that the `{...}` in LogQL, like Label Matchers in PromQL, can also be understood as a kind of where conditional filtering.

<a name="SQL"></a>
### SQL

For the most well-known query language, if you want to achieve the above two effects, the simple translation is as follows (because of the different storage structures, only the general meaning is expressed here):

```sql
SELECT * FROM `loki-dev`
	WHERE container="query-frontend" AND
	duration > 10s AND
	throughput_mb < 500
```

<a name="DQL"></a>
### DQL

DQL is essentially a query translator, and its background does not directly manage the storage and organization of data. So theoretically it can support any type of storage engine, such as information data storage (MySQL/Oracle/ES/Redis, etc.), file storage (HBASE/S3/OSS, etc.). At present, DQL is mainly used for querying the following types of data:

- Timing Data
- Log Data
- Object Data
- Application Performance Tracking (APM) Data
- User Behavior Detection (RUM) Data
- Critical Event Data
- Safety Inspection Data
- ...

For example:

```
metric::cpu:(usage_system, usage_user) { usage_idle > 0.9 } [2d:1d:1h] BY hostname
```

Here, `metric` specifies the time series data to be queried (understood simply as a DB in MySQL), and  `cpu` is one of the metrics sets (similar to Table in MySQL), and specifies looking for two of the fields `usage_system` and `usage_user`; ; Then, `{...}` denotes the filter criteria, and finally,  `[...]` denotes the time range of the query: the period from the day before yesterday to yesterday, with an aggregation interval of 1h.

More examples:

```
# Query the pod object in K8s
object::kubelet_pod:(name, age) { cpu_usage > 30.0 } [10m] BY namespace

# Find the log named my_service application (message field)
logging::my_service:(message) [1d]

# Look at span data for duration > 1000us in the application performance trace (T is tracing) and group them by operation
T::my_service { duration > 1000 } [10m] BY operation
```

<a name="b69c48c4"></a>
## Horizontal Contrast

<a name="48b7e96a"></a>
### Comparison of Basic Functions
| Query Language | Main Areas | Support Timing Query | Support Log Query | Support Time Range Lookup | Support group by Aggregation |
| --- | --- | --- | --- | --- | --- |
| PromQL | Prometheuse Metric Query | Available | Unavailable | Available | [Available](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators) |
| LogQL | Mainly used for querying logs | Support generating metrics from logs | Available | Available | [Available](https://grafana.com/docs/loki/latest/logql/#aggregation-operators) |
| SQL | Universal Query Language | [Certain databases](https://www.timescale.com/)<br />support sequential storage | Unavailable | Unavailable | Unavailable |
| DQL | Data Query of Guance Platform | Available | Available | Available | Available |


<a name="8d81dc5d"></a>
### Tool Support
| Query Language | Annotation | Supporting HTTP API or not | Suprooting Pipeline Cutting or not | Supporting Command Line or not |
| --- | --- | --- | --- | --- |
| PromQL | `# Single-Line Comments` | [Available](https://prometheus.io/docs/prometheus/latest/querying/api/) | Unavailable | [promql-cli](https://github.com/nalbury/promql-cli) |
| LogQL | `# Single-Line Comments` | [Available](https://grafana.com/docs/loki/latest/api/) | Available | [logcli](https://grafana.com/docs/loki/latest/getting-started/logcli/) |
| SQL | `-- Single-Line Comments`<br /> or `/* Multiline Comment */` | Unavailable | Unavailable | Various SQL client-side, we won't explore it in this article. |
| DQL | `# Single-Line Comments` | [Available](../datakit/apis.md) | Unavailable (pre-cut on the DataKit side) | Need to [Install DataKit](../datakit/datakit-install.md)<br />; re-execute[query](../datakit/datakit-dql-how-to.md) |


<a name="1b8fbe0e"></a>
### Data Processing Function Support

- [List of functions supported by PromQL](https://prometheus.io/docs/prometheus/latest/querying/functions/#functions)
- [List of functions supported by LogQL](https://grafana.com/docs/loki/latest/logql/#metric-queries)
- [List of functions supported by MySQL](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html)
- [List of functions supported by DQL](../dql/funcs.md)

<a name="c05ceae0"></a>
## Comparison of Writing Methods of Common Query Statements

<a name="cecdfda9"></a>
### General Data Query and Filtering

```
# LogQL
{ cluster="ops-tools1", namespace="dev", job="query-frontend"}
  |= "metrics.go"
  !="out of order"
  | logfmt
  | duration > 30s or status_code!="200"

# PromQL（PromQL probably does not support ordinary OR filtering.）
http_requests_total{ cluster='ops-tools1', job!='query=frontend', duration > 30s }

# SQL
SELECT * FROM dev
  WHERE cluster='ops-tools' AND
  job='query=frontend' AND
  (duration > 30000000000 OR stataus_code != 200)

# DQL：It can be seen from the statement structure that the semantic organization of DQL is close to that of SQL.
L::dev {
  cluster='ops-tools',
  job='query=frontend',
  message != match("out of order")
  (duraton > 30s OR stataus_code != 200) # DQL supports nested structure filtering}
```

The following is a list of how to write various DQL statements:

```
# Where-clause can be concatenated by AND, which is semantically equivalent to `,'.
L::dev {
  cluster='ops-tools' AND
  job='query=frontend' AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)}

# Support AS aliases/support Chinese variables.
metric::cpu:(usage_system AS system usage, usage_user AS user usage)

# Where-cluase supports array-list IN filtering.
L::dev {
  cluster='ops-tools' AND
  job IN [ 'query=frontend', 'query=backend'] AND
  message != match("out of order") AND
  (duraton > 30s OR stataus_code != 200)
}

# Support base64 value transfer: Avoid headache escape for some complex strings (such as multiple lines).
T::dev {
  cluster='ops-tools' AND
  resourec IN [
    'some-raw-string', # ordinary string
    b64'c2VsZWN0ICoKZnJvbSBhYmMKd2hlcmUgeCA+IDAK' # base64 string
  ]
}
```

<a name="5e769752"></a>
### Query with Aggregation and Filtering

```python
# LogQL
sum by (org_id) ({source="ops-tools",container="app-dev"} |= "metrics.go" | logfmt | unwrap bytes_processed [1m])

# PromQL
histogram_quantile(0.9, sum by (job, le) (rate(http_request_duration_seconds_bucket[10m])))

# DQL (Note that ops-tools need to be added with `` on both sides, otherwise it will be resolved into a subtraction expression)
L::`ops-tools`:(bytes_processed) {filename = "metrics.go", container="app-dev"} [2m] BY sum(orig_id)
```

<a name="fb1fdfb2"></a>
### Browse Data Status

```python
# LogQL/PromQL have not found similar query function yet.

# MySQL
show tables;
show databases;

# DQL
show_measurement()    # View the list of time series measurements
show_object_source()  # View object classification list
show_rum_source()     # View the RUM data classification list
show_logging_source() # View log classification list
```

<a name="25f9c7fa"></a>
## Summary

The above content makes some fundamental introduction to several common query languages. Each language has its specific application field, and its functional differences are obvious. As far as DQL is concerned, its original intention is to provide a query scheme with mixed storage, which is the biggest difference between DQL and other query languages in this paper. Although DQL does not have a separate storage engine, its scalability is unmatched by several others, which is also in line with its positioning of hybrid storage query.

At present, DQL is still actively developing and improving, and there is still much room for improvement in function and performance. At present, DQL is fully used in all data queries of Guance, and its function, performance and stability have been verified for a long time. With the iteration of the whole product of Guance, the integrity of DQL itself will gradually evolve to meet the needs of the product side and the majority of developers.


---

