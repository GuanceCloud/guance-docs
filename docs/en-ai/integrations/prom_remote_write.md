---
title     : 'Prometheus Remote Write'
summary   : 'Collect metrics data via Prometheus Remote Write'
tags:
  - 'External Data Ingestion'
  - 'PROMETHEUS'
__int_icon: 'icon/prometheus'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Listen to Prometheus Remote Write data and report it to Guance.

## Configuration {#config}

### Prerequisites {#requirements}

Note that for some early versions of `vmalert`, you need to enable the setting `default_content_encoding = "snappy"` in the collector's configuration file.

Enable the Prometheus Remote Write function by adding the following configuration to *prometheus.yml*:

```yml
remote_write:
 - url: "http://<datakit-ip>:9529/prom_remote_write"

# If you want to add some tags, ( __source will not be included in tags, only shown in Datakit exposed metrics)
# remote_write:
# - url: "http://<datakit-ip>:9529/prom_remote_write?host=1.2.3.4&foo=bar&__source=<your_source>" 
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/prom` directory under the DataKit installation directory, copy `prom_remote_write.conf.sample` and rename it to `prom_remote_write.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.prom_remote_write]]
      ## Path to listen to.
      path = "/prom_remote_write"
    
      ## Accepted methods
      methods = ["PUT", "POST"]
      
      ## If the data is decoded incorrectly, you need to set the default HTTP body encoding;
      ## this usually occurs when the sender does not correctly pass the encoding in the HTTP header.
      #
      # default_content_encoding = "snappy"
    
      ## Part of the request to consume.  Available options are "body" and "query".
      # data_source = "body"
    
      ## Output source
      # specify this to output collected metrics to a local file
      # if not specified, metrics is sent to datakit io
      # if specified, you can use 'datakit --prom-conf /path/to/this/conf' to debug collected data
      # output = "/abs/path/file"
    
      ## If job_as_measurement is true, use the job field for the measurement name.
      ## The measurement_name configuration takes precedence.
      job_as_measurement = false
    
      ## Metric name filter
      # Regex is supported.
      # Only metrics matching one of the regexes can pass through. No filter if left empty.
      # metric_name_filter = ["gc", "go"]
    
      ## Measurement name filter
      # Regex is supported.
      # Only measurements matching one of the regexes can pass through. No filter if left empty.
      # This filtering is done before any prefixing rule or renaming rule is applied.
      # measurement_name_filter = ["kubernetes", "container"]
    
      ## Metric name prefix
      ## Prefix will be added to metric name
      # measurement_prefix = "prefix_"
    
      ## Metric name
      ## Metric name will be divided by "_" by default.
      ## Metric is named by the first divided field, the remaining field is used as the current metric name
      ## Metric name will not be divided if measurement_name is configured
      ## measurement_prefix will be added to the start of measurement_name
      # measurement_name = "prom_remote_write"
    
      ## Max body size in bytes, default set to 500MB
      # max_body_size = 0
    
      ## Optional username and password to accept for HTTP basic authentication.
      ## You probably want to make sure you have TLS configured above for this.
      # basic_username = ""
      # basic_password = ""
    
      ## If both blacklist and whitelist are configured, all lists will be canceled.
      ## Tags to ignore (blacklist)
      # tags_ignore = ["xxxx"]
    
      ## Tags to ignore with regex (blacklist)
      # tags_ignore_regex = ["xxxx"]
    
      ## Tags whitelist
      # tags_only = ["xxxx"]
    
      ## Tags whitelist with regex
      # tags_only_regex = ["xxxx"]
    
      ## Indicate whether tags_rename overwrites existing key if tag with the new key name already exists.
      overwrite = false
    
      ## Tags to rename
      [inputs.prom_remote_write.tags_rename]
      # old_tag_name = "new_tag_name"
      # more_old_tag_name = "other_new_tag_name"
    
      ## Optional setting to map http headers into tags
      ## If the http header is not present on the request, no corresponding tag will be added
      ## If multiple instances of the http header are present, only the first value will be used
      [inputs.prom_remote_write.http_header_tags]
      # HTTP_HEADER = "TAG_NAME"
    
      ## Customize measurement set name.
      ## Treat those metrics with prefix as one set.
      ## Prioritier over 'measurement_name' configuration.
      ## Must measurement_name = ""
      [[inputs.prom_remote_write.measurements]]
        prefix = "etcd_network_"
        name = "etcd_network"
        
      [[inputs.prom_remote_write.measurements]]
        prefix = "etcd_server_"
        name = "etcd_server"
    
      ## Custom tags
      [inputs.prom_remote_write.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or configure [ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.
<!-- markdownlint-enable -->

### Tag Processing {#tag-ops}

You can add tags to the collected metrics by configuring `tags`, as follows:

```toml
  ## Custom tags
  [inputs.prom_remote_write.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

Note: If both blacklist and whitelist are configured, they will both be ignored.

You can ignore certain tags on metrics by configuring `tags_ignore` (blacklist), as follows:

```toml
  ## Tags to ignore
  tags_ignore = ["xxxx"]
```

You can ignore tags on metrics using regex by configuring `tags_ignore_regex` (blacklist), as follows:

```toml
  ## Tags to ignore with regex
  tags_ignore_regex = ["xxxx"]
```

You can configure a whitelist of tags on metrics by configuring `tags_only`, as follows:

```toml
  ## Tags white list
  # tags_only = ["xxxx"]
```

You can configure a whitelist of tags on metrics using regex by configuring `tags_only_regex`, as follows:

```toml
  ## Tags white list with regex
  # tags_only_regex = ["xxxx"]
```

You can rename existing tags on metrics by configuring `tags_rename`, as follows:

```toml
  ## Tags to rename
  [inputs.prom_remote_write.tags_rename]
  old_tag_name = "new_tag_name"
  more_old_tag_name = "other_new_tag_name"
```

Additionally, when renaming a tag key that already exists, you can configure whether to overwrite the existing tag key using `overwrite`.

> Note: For [global tag keys in DataKit](../datakit/datakit-conf.md#update-global-tag), renaming them here is not supported.

## Metrics {#metric}

The metrics set follows the metrics set sent by Prometheus.

## Configuring Prometheus Remote Write Metric Filtering {#remote-write-relabel}

When using Prometheus to push metrics to DataKit via remote write, too many metrics may lead to an explosion of data in storage. In such cases, we can use Prometheus's relabel feature to select specific metrics.

In Prometheus, to configure `remote_write` to another service and send only specified metrics, we need to set the `remote_write` section in Prometheus's configuration file (usually `prometheus.yml`) and specify the `match[]` parameter to define the metrics to send.

Here’s an example configuration that shows how to send a specific list of metrics to a remote write endpoint:

```yaml
remote_write:
  - url: "http://remote-write-service:9090/api/v1/write"
    write_relabel_configs:
      - source_labels: ["__name__"]
        regex: "my_metric|another_metric|yet_another_metric"
        action: keep
```

In this configuration:

- `url`: The URL of the remote write service
- `write_relabel_configs`: A list used to relabel and filter the metrics to send
    - `source_labels`: Specifies the source labels to match and relabel
    - `regex`: A regular expression to match the metric names to retain
    - `action`: Specifies whether metrics matching the regex should be kept (`keep`) or dropped (`drop`)

In the above example, only metrics named `my_metric`, `another_metric`, or `yet_another_metric` will be sent to the remote write endpoint. All other metrics will be ignored.

Finally, reload or restart the Prometheus service to apply the changes.

## Debugging Metrics Set via Command Line {#debug}

DataKit provides a simple tool to debug `prom.conf`. By continuously adjusting the `prom.conf` configuration, you can achieve the goal of collecting Prometheus metrics that match certain naming rules.

DataKit supports debugging the collector configuration file directly from the command line. Configure the `output` item in `prom_remote_write.conf` under `conf.d/prom` to a local file path. The collected data will then be written to the file instead of being uploaded to the central server.

Restart DataKit to apply the configuration:

```shell
datakit service -R
```

At this point, the *prom_remote_write* collector will write the collected data to the local file specified by `output`.

Run the following command to debug *prom_remote_write.conf*:

```shell
datakit debug --prom-conf prom_remote_write.conf
```

Parameter description:

- `prom-conf`: Specifies the configuration file, defaults to searching for `prom_remote_write.conf` in the current directory; if not found, it looks for the corresponding file in the *<datakit-install-dir>/conf.d/prom* directory.

Example output:

``` not-set
================= Line Protocol Points ==================

 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor target_scrapes_sample_out_of_order_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor,scrape_job=node target_sync_failed_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor,scrape_job=prometheus target_sync_failed_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor,scrape_job=node target_sync_length_seconds_sum=0.000070352 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor,scrape_job=node target_sync_length_seconds_count=1 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor,scrape_job=prometheus target_sync_length_seconds_sum=0.000089457 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor,scrape_job=prometheus target_sync_length_seconds_count=1 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor template_text_expansion_failures_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor template_text_expansions_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor treecache_watcher_goroutines=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor treecache_zookeeper_failures_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_blocks_loaded=1 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_checkpoint_creations_failed_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_checkpoint_creations_total=1 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_checkpoint_deletions_failed_total=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_checkpoint_deletions_total=1 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_clean_start=1 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=100,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=400,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=1600,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=6400,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=25600,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=102400,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=409600,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=1.6384e+06,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=6.5536e+06,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=2.62144e+07,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=+Inf,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_sum=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,monitor=codelab-monitor tsdb_compaction_chunk_range_seconds_count=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=4,monitor=codelab-monitor tsdb_compaction_chunk_samples_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=6,monitor=codelab-monitor tsdb_compaction_chunk_samples_bucket=0 1634548272855000000
 prometheus,instance=localhost:9090,job=prometheus,le=9,monitor=codelab-monitor tsdb_compaction_chunk_samples_bucket=0 1634548272855000000
...
================= Summary ==================

Total time series: 155
Total line protocol points: 487
Total measurements: 6 (prometheus, promhttp, up, scrape, go, node)
```

Output explanation:

- Line Protocol Points: Generated line protocol points
- Summary: Summary results
    - Total time series: Number of time series
    - Total line protocol points: Number of line protocol points
    - Total measurements: Number of measurements and their names.