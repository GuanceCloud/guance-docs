---
title: 'Solr'
summary: 'Collect metrics data from Solr'
tags:
  - 'Database'
__int_icon: 'icon/solr'
dashboard:
  - desc: 'Solr'
    path: 'dashboard/en/solr'
monitor:
  - desc: 'Solr'
    path: 'monitor/en/solr'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Solr collector is used to collect statistical information such as Solr Cache and Request Times.

## Configuration {#config}

### Prerequisites {#requirements}

- DataKit uses the Solr Metrics API to collect metrics data, supporting Solr version 7.0 and above.
- It can also be used for Solr 6.6, but the metrics data may not be complete.

Tested versions:

- [x] 8.11.2
- [x] 7.0.0

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/db` directory under the DataKit installation directory, copy `solr.conf.sample` and rename it to `solr.conf`. An example configuration is as follows:
    
    ```toml
        
    [[inputs.solr]]
      ## (optional) collection interval, default is 10 seconds
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
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

If you need to collect Solr logs, you can enable `files` in *solr.conf* and specify the absolute path of the Solr log file. For example:

```toml
[inputs.solr.log]
    # enter the absolute path
    files = ["/path/to/demo.log"]
```

## Metrics {#metric}

All the following data collected will append the global election tag by default. You can also specify other tags through `[inputs.solr.tags]` in the configuration:

```toml
 [inputs.solr.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `solr_cache`

- Tags


| Tag | Description |
|  ----  | --------|
|`category`|Category name.|
|`core`|Solr core.|
|`group`|Metric group.|
|`host`|System hostname.|
|`instance`|Instance name, generated based on server address.|
|`name`|Cache name.|

- Metrics List


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
|`warmup`|Warm-up time for the registered index searcher. This time is taken into account for the "auto-warming" of caches.|int|ms|



### `solr_request_times`

- Tags


| Tag | Description |
|  ----  | --------|
|`category`|Category name.|
|`core`|Solr core.|
|`group`|Metric group.|
|`handler`|Request handler.|
|`host`|System hostname.|
|`instance`|Instance name, generated based on server address.|

- Metrics List


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
|`rate_1min`|Requests per second received over the past 1 minute.|float|req/s|
|`rate_5min`|Requests per second received over the past 5 minutes.|float|req/s|
|`rate_mean`|Average number of requests per second received|float|req/s|
|`stddev`|Stddev of all the request processing time.|float|ms|



### `solr_searcher`

- Tags


| Tag | Description |
|  ----  | --------|
|`category`|Category name.|
|`core`|Solr core.|
|`group`|Metric group.|
|`host`|System hostname.|
|`instance`|Instance name, generated based on server address.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`deleted_docs`|The number of deleted documents.|int|count|
|`max_docs`|The largest possible document number.|int|count|
|`num_docs`|The total number of indexed documents.|int|count|
|`warmup`|The time spent warming up.|int|ms|



## Logging {#logging}

Example of log parsing:

```log
2013-10-01 12:33:08.319 INFO (org.apache.solr.core.SolrCore) [collection1] webapp.reporter
```

Parsed fields:

| Field Name     | Field Value                          |
| -------------- | ------------------------------------ |
| `Reporter`     | `webapp.reporter`                    |
| `status`       | `INFO`                               |
| `thread`       | `org.apache.solr.core.SolrCore`      |
| `time`         | `1380630788319000000`                |
