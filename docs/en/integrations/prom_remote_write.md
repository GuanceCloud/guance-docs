---
title     : 'Prometheus Remote Write'
summary   : 'Gathering Metrics data through Prometheus Remote Write'
tags:
  - 'External Data Integration'
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

Note, for some early versions of `vmalert`, you need to enable the setting `default_content_encoding = "snappy"` in the collector's configuration file.

Enable Prometheus Remote Write functionality by adding the following configuration to *prometheus.yml*:

```yml
remote_write:
 - url: "http://<datakit-ip>:9529/prom_remote_write"

# If you want to add some tags, ( __source will not be in tags, only shown in Datakit exposed metrics)
# remote_write:
# - url: "http://<datakit-ip>:9529/prom_remote_write?host=1.2.3.4&foo=bar&__source=<your_source>" 
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Go to the `conf.d/prom` directory under the DataKit installation directory, copy `prom_remote_write.conf.sample` and rename it to `prom_remote_write.conf`. Example as follows:
    
    ```toml
        
    [[inputs.prom_remote_write]]
      ## Path to listen to.
      path = "/prom_remote_write"
    
      ## accepted methods
      methods = ["PUT", "POST"]
      
      ## If the data is decoded incorrectly, you need to set the default HTTP body encoding;
      ## this usually occurs when the sender does not correctly pass the encoding in the HTTP header.
      #
      # default_content_encoding = "snappy"
    
      ## Part of the request to consume.  Available options are "body" and "query".
      # data_source = "body"
    
      ## output source
      # specify this to output collected metrics to local file
      # if not specified, metrics is sent to datakit io
      # if specified, you can use 'datakit --prom-conf /path/to/this/conf' to debug collected data
      # output = "/abs/path/file"
    
      ## If job_as_measurement is true, use the job field for the measurement name.
      ## The measurement_name configuration takes precedence.
      job_as_measurement = false
    
      ## Metric name filter
      # Regex is supported.
      # Only metric matches one of the regex can pass through. No filter if left empty.
      # metric_name_filter = ["gc", "go"]
    
      ## Measurement name filter
      # Regex is supported.
      # Only measurement matches one of the regex can pass through. No filter if left empty.
      # This filtering is done before any prefixing rule or renaming rule is applied.
      # measurement_name_filter = ["kubernetes", "container"]
    
      ## metric name prefix
      ## prefix will be added to metric name
      # measurement_prefix = "prefix_"
    
      ## metric name
      ## metric name will be divided by "_" by default.
      ## metric is named by the first divided field, the remaining field is used as the current metric name
      ## metric name will not be divided if measurement_name is configured
      ## measurement_prefix will be added to the start of measurement_name
      # measurement_name = "prom_remote_write"
    
      ## max body size in bytes, default set to 500MB
      # max_body_size = 0
    
      ## Optional username and password to accept for HTTP basic authentication.
      ## You probably want to make sure you have TLS configured above for this.
      # basic_username = ""
      # basic_password = ""
    
      ## If both blacklist and whitelist, all list will cancel.
      ## tags to ignore (blacklist)
      # tags_ignore = ["xxxx"]
    
      ## tags to ignore with regex (blacklist)
      # tags_ignore_regex = ["xxxx"]
    
      ## tags whitelist
      # tags_only = ["xxxx"]
    
      ## tags whitelist with regex
      # tags_only_regex = ["xxxx"]
    
      ## Indicate whether tags_rename overwrites existing key if tag with the new key name already exists.
      overwrite = false
    
      ## tags to rename
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
    
      ## custom tags
      [inputs.prom_remote_write.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject collector configurations via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable collectors.
<!-- markdownlint-enable -->

### Tags Handling {#tag-ops}

You can add labels to collected metrics by configuring `tags`, as follows:

```toml
  ## custom tags
  [inputs.prom_remote_write.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

Note: If both blacklist and whitelist are configured, they will both be invalidated.

You can ignore certain tags on the metrics by configuring `tags_ignore` (blacklist), as follows:

```toml
  ## tags to ignore
  tags_ignore = ["xxxx"]
```

You can ignore certain tags on the metrics by configuring `tags_ignore_regex` with a regular expression match (blacklist), as follows:

```toml
  ## tags to ignore with regex
  tags_ignore_regex = ["xxxx"]
```

You can configure a whitelist for tags on the metrics by using `tags_only`, as follows:

```toml
  ## tags white list
  # tags_only = ["xxxx"]
```

You can configure a whitelist for tags on the metrics by using `tags_only_regex` with a regular expression match, as follows:

```toml
  ## tags white list with regex
  # tags_only_regex = ["xxxx"]
```

You can rename certain tags on the metrics by configuring `tags_rename`, as follows:

```toml
  ## tags to rename
  [inputs.prom_remote_write.tags_rename]
  old_tag_name = "new_tag_name"
  more_old_tag_name = "other_new_tag_name"
```

Additionally, when the renamed tag key matches an existing tag key, you can configure whether to overwrite the existing tag key using `overwrite`.

> Note: For [DataKit global tag keys](../datakit/datakit-conf.md#update-global-tag), renaming them here is unsupported.

## Metrics {#metric}

The Measurement is based on the Metrics set sent by Prometheus.

## Configuring Prometheus Remote Write Metric Filtering {#remote-write-relabel}

When using Prometheus to push Metrics to Datakit via remote write, too many Metrics might lead to a surge in stored data. At this point, we can select specific Metrics using Prometheus's relabel feature.

In Prometheus, to configure `remote_write` to another service and send only specified Metrics, we need to set up the `remote_write` section in Prometheus's configuration file (usually `prometheus.yml`) and specify the `match[]` parameter to define which Metrics should be sent.

Below is a configuration example showing how to send a specific list of Metrics to a remote write endpoint:

```yaml
remote_write:
  - url: "http://remote-write-service:9090/api/v1/write"
    write_relabel_configs:
      - source_labels: ["__name__"]
        regex: "my_metric|another_metric|yet_another_metric"
        action: keep
```

In this configuration:

- `url`: URL of the remote write service
- `write_relabel_configs`: A list used for relabeling and filtering Metrics to send
    - `source_labels`: Specifies the source labels used for matching and relabeling
    - `regex`: A regular expression used to match the names of Metrics to retain
    - `action`: Specifies whether Metrics matching the regular expression are retained (`keep`) or dropped (`drop`)

In the example above, only Metrics whose names match `my_metric`, `another_metric`, or `yet_another_metric` will be sent to the remote write endpoint. All other Metrics will be ignored.

Finally, reload or restart the Prometheus service to apply changes.

## Command Line Debugging of Metrics Sets {#debug}

DataKit provides a simple tool to debug `prom.conf`. By continuously adjusting the `prom.conf` settings, you can achieve the purpose of collecting only Prometheus Metrics that conform to specific naming rules.

Datakit supports direct command-line debugging of this collector's configuration file. Configure the `output` item under `conf.d/prom` in `prom_remote_write.conf` to point to a local file path. Subsequently, `prom_remote_write.conf` will write collected data to the file instead of uploading it to the center.

Restart Datakit to activate the configuration file:

```shell
datakit service -R
```

At this point, the *prom_remote_write* collector will write collected data to the local file specified in the output.

Execute the following command to debug *prom_remote_write.conf*:

```shell
datakit debug --prom-conf prom_remote_write.conf
```

Parameter explanation:

- `prom-conf`: Specifies the configuration file, default looks for `prom_remote_write.conf` in the current directory. If not found, it will look for the corresponding file in the *<datakit-install-dir\>/conf.d/prom* directory.

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

Output Explanation:

- Line Protocol Points: Generated line protocol points
- Summary: Summary results
    - Total time series: Number of Time Series
    - Total line protocol points: Number of line protocol points
    - Total measurements: Number and names of Measurements sets.