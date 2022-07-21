
# Solr
---

- DataKit 版本：1.4.8
- 操作系统支持：:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

solr 采集器，用于采集 solr cache 和 request times 等的统计信息。

## 前置条件

DataKit 使用 Solr Metrics API 采集指标数据，支持 Solr 7.0 及以上版本。可用于 Solr 6.6，但指标数据不完整。

## 配置

进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `solr.conf.sample` 并命名为 `solr.conf`。示例如下：

```toml

[[inputs.solr]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

  ## specify a list of one or more Solr servers
  servers = ["http://localhost:8983"]

  ## Optional HTTP Basic Auth Credentials
  # username = "username"
  # password = "pa$$word"

  # [inputs.solr.log]
  # files = []
  # #grok pipeline script path
  # pipeline = "solr.p"

  [inputs.solr.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"


```

配置好后，重启 DataKit 即可。

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.solr.tags]` 指定其它标签：

``` toml
 [inputs.solr.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `solr_cache`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`category`|category name|
|`core`|solr core|
|`group`|metric group|
|`host`|host name|
|`instance`|instance name, generated based on server address|
|`name`|cache name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cumulative_evictions`|Number of cache evictions across all caches since this node has been running.|int|count|
|`cumulative_hitratio`|Ratio of cache hits to lookups across all the caches since this node has been running.|float|percent|
|`cumulative_hits`|Number of cache hits across all the caches since this node has been running.|int|count|
|`cumulative_inserts`|Number of cache insertions across all the caches since this node has been running.|int|count|
|`cumulative_lookups`|Number of cache lookups across all the caches since this node has been running.|int|count|
|`evictions`|Number of cache evictions for the current index searcher.|int|count|
|`hitratio`|Ratio of cache hits to lookups for the current index searcher.|float|percent|
|`hits`|Number of hits for the current index searcher.|int|count|
|`inserts`|Number of inserts into the cache.|int|count|
|`lookups`|Number of lookups against the cache.|int|count|
|`max_ram`|Maximum heap that should be used by the cache beyond which keys will be evicted.|int|MB|
|`ram_bytes_used`|Actual heap usage of the cache at that particular instance.|int|B|
|`size`|Number of entries in the cache at that particular instance.|int|count|
|`warmup`|Warm-up time for the registered index searcher. This time is taken in account for the "auto-warming" of caches.|int|ms|



### `solr_request_times`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`category`|category name|
|`core`|solr core|
|`group`|metric group|
|`handler`|request handler|
|`host`|host name|
|`instance`|instance name, generated based on server address|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|Total number of requests made since the Solr process was started.|int|count|
|`max`|Max of all the request processing time.|float|ms|
|`mean`|Mean of all the request processing time.|float|ms|
|`median`|Median of all the request processing time.|float|ms|
|`min`|Min of all the request processing time.|float|ms|
|`p75`|Request processing time for the request which belongs to the 75th Percentile.|float|ms|
|`p95`|Request processing time in milliseconds for the request which belongs to the 95th Percentile. |float|ms|
|`p99`|Request processing time in milliseconds for the request which belongs to the 99th Percentile. |float|ms|
|`p999`|Request processing time in milliseconds for the request which belongs to the 99.9th Percentile. |float|ms|
|`rate_15min`|Requests per second received over the past 15 minutes.|float|reqps|
|`rate_1min`|Requests per second received over the past 1 minutes.|float|reqps|
|`rate_5min`|Requests per second received over the past 5 minutes.|float|reqps|
|`rate_mean`|Average number of requests per second received|float|reqps|
|`stddev`|Stddev of all the request processing time.|float|ms|



### `solr_searcher`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`category`|category name|
|`core`|solr core|
|`group`|metric group|
|`host`|host name|
|`instance`|instance name, generated based on server address|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`deleted_docs`|The number of deleted documents.|int|count|
|`max_docs`|The largest possible document number.|int|count|
|`num_docs`|The total number of indexed documents.|int|count|
|`warmup`|The time spent warming up.|int|ms|



## 日志采集

如需采集 Solr 的日志，可在 solr.conf 中 将 `files` 打开，并写入 Solr 日志文件的绝对路径。比如：

```toml
[inputs.solr.log]
    # 填入绝对路径
    files = ["/path/to/demo.log"]
```

切割日志示例：

```
2013-10-01 12:33:08.319 INFO (org.apache.solr.core.SolrCore) [collection1] webapp.reporter
```

切割后字段：

| 字段名   | 字段值                        |
| -------- | ----------------------------- |
| Reporter | webapp.reporter               |
| status   | INFO                          |
| thread   | org.apache.solr.core.SolrCore |
| time     | 1380630788319000000           |
