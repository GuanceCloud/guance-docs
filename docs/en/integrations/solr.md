---
title     : 'Solr'
summary   : 'Collect Solr metrics'
__int_icon      : 'icon/solr'
dashboard :
  - desc  : 'Solr'
    path  : 'dashboard/en/solr'
monitor   :
  - desc  : 'Solr'
    path  : 'monitor/en/solr'
---

<!-- markdownlint-disable MD025 -->
# Solr
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Solr collector, which collects statistics of solr cache, request times, and so on.

## Configuration {#config}

### Preconditions {#requrements}

DataKit uses the Solr Metrics API to collect metrics data and supports Solr 7.0 and above. Available for Solr 6.6, but the indicator data is incomplete.

Already tested version:

- [x] 8.11.2
- [x] 7.0.0

### Collector Configuration {#input-config}

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `solr.conf.sample` and name it  `solr.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.solr]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      ## specify a list of one or more Solr servers
      servers = ["http://localhost:8983"]
    
      ## Optional HTTP Basic Auth Credentials
      # username = "username"
      # password = "pa$$word"
    
      ## Set true to enable election
      election = true
    
      # [inputs.solr.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "solr.p"
    
      [inputs.solr.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    
    ```

    After configuration, restart DataKit.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

---

To collect Solr's log, open `files` in Solr.conf and write to the absolute path of the Solr log file. For example:

```toml
[inputs.solr.log]
    # fill in the absolute path
    files = ["/path/to/demo.log"]
```

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.solr.tags]`:

``` toml
 [inputs.solr.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `solr_cache`

- tag


| Tag | Description |
|  ----  | --------|
|`category`|Category name.|
|`core`|Solr core.|
|`group`|Metric group.|
|`host`|System hostname.|
|`instance`|Instance name, generated based on server address.|
|`name`|Cache name.|

- metric list


| Metric | Description | Type | Unit |
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

- tag


| Tag | Description |
|  ----  | --------|
|`category`|Category name.|
|`core`|Solr core.|
|`group`|Metric group.|
|`handler`|Request handler.|
|`host`|System hostname.|
|`instance`|Instance name, generated based on server address.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Total number of requests made since the Solr process was started.|int|count|
|`max`|Max of all the request processing time.|float|ms|
|`mean`|Mean of all the request processing time.|float|ms|
|`median`|Median of all the request processing time.|float|ms|
|`min`|Min of all the request processing time.|float|ms|
|`p75`|Request processing time for the request which belongs to the 75th Percentile.|float|ms|
|`p95`|Request processing time in milliseconds for the request which belongs to the 95th Percentile.|float|ms|
|`p99`|Request processing time in milliseconds for the request which belongs to the 99th Percentile.|float|ms|
|`p999`|Request processing time in milliseconds for the request which belongs to the 99.9th Percentile.|float|ms|
|`rate_15min`|Requests per second received over the past 15 minutes.|float|req/s|
|`rate_1min`|Requests per second received over the past 1 minutes.|float|req/s|
|`rate_5min`|Requests per second received over the past 5 minutes.|float|req/s|
|`rate_mean`|Average number of requests per second received|float|req/s|
|`stddev`|Stddev of all the request processing time.|float|ms|



### `solr_searcher`

- tag


| Tag | Description |
|  ----  | --------|
|`category`|Category name.|
|`core`|Solr core.|
|`group`|Metric group.|
|`host`|System hostname.|
|`instance`|Instance name, generated based on server address.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`deleted_docs`|The number of deleted documents.|int|count|
|`max_docs`|The largest possible document number.|int|count|
|`num_docs`|The total number of indexed documents.|int|count|
|`warmup`|The time spent warming up.|int|ms|



## Log Collection {#logging}

Example of cutting logs:

```
2013-10-01 12:33:08.319 INFO (org.apache.solr.core.SolrCore) [collection1] webapp.reporter
```

Cut fields:

| Field Name   | Field Value                        |
| -------- | ----------------------------- |
| Reporter | webapp.reporter               |
| status   | INFO                          |
| thread   | org.apache.solr.core.SolrCore |
| time     | 1380630788319000000           |
