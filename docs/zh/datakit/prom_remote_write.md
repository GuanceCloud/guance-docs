
# Prometheus Remote Write 支持

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

监听 Prometheus Remote Write 数据，上报到观测云。

## 前置条件 {#requirements}

开启 Prometheus Remote Write 功能，在 *prometheus.yml* 添加如下配置：

```yml
remote_write:
 - url: "http://<datakit-ip>:9529/prom_remote_write"
```

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/prom` 目录，复制 `prom_remote_write.conf.sample` 并命名为 `prom_remote_write.conf`。示例如下：
    
    ```toml
        
    [[inputs.prom_remote_write]]
      ## Path to listen to.
      path = "/prom_remote_write"
    
      ## accepted methods
      methods = ["PUT", "POST"]
    
      ## Part of the request to consume.  Available options are "body" and "query".
      # data_source = "body"
    
      ## output source
      # specify this to output collected metrics to local file
      # if not specified, metrics is sent to datakit io
      # if specified, you can use 'datakit --prom-conf /path/to/this/conf' to debug collected data
      # output = "/abs/path/file"
    
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
      # prefix will be added to metric name
      # measurement_prefix = "prefix_"
    
      ## metric name
      # metric name will be divided by "_" by default.
      # metric is named by the first divided field, the remaining field is used as the current metric name
      # metric name will not be divided if measurement_name is configured
      # measurement_prefix will be added to the start of measurement_name
      # measurement_name = "prom_remote_write"
    
      ## max body size in bytes, default set to 500MB
      # max_body_size = 0
    
      ## Optional username and password to accept for HTTP basic authentication.
      ## You probably want to make sure you have TLS configured above for this.
      # basic_username = ""
      # basic_password = ""
    
      ## tags to ignore
      # tags_ignore = ["xxxx"]
    
      ## tags to ignore with regex
      tags_ignore_regex = ["xxxx"]
    
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
    
      ## custom tags
      [inputs.prom_remote_write.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### tags 添加、忽略及重命名 {#tag-ops}

可以通过配置 `tags` 为采集到的指标加上标签，如下：

```toml
  ## custom tags
  [inputs.prom_remote_write.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

可以通过配置 `tags_ignore` 忽略指标上的某些标签，如下：

```toml
  ## tags to ignore
  tags_ignore = ["xxxx"]
```

可以通过配置 `tags_ignore_regex` 正则匹配并忽略指标上的标签，如下：

```toml
  ## tags to ignore with regex
  tags_ignore_regex = ["xxxx"]
```

可以通过配置 `tags_rename` 重命名指标已有的某些标签名，如下：

```toml
  ## tags to rename
  [inputs.prom_remote_write.tags_rename]
  old_tag_name = "new_tag_name"
  more_old_tag_name = "other_new_tag_name"
```

另外，当重命名后的 tag key 与已有 tag key 相同时:可以通过 `overwrite` 配置是否覆盖掉已有的 tag key。

> 注意：对于 [DataKit 全局 tag key](datakit-conf.md#update-global-tag)，此处不支持将它们重命名。

## 指标集 {#measurements}

指标集以 Prometheus 发送过来的指标集为准。

## 命令行调试指标集 {#debug}

DataKit 提供一个简单的调试 `prom.conf` 的工具，如果不断调整 `prom.conf` 的配置，可以实现只采集符合一定名称规则的 Prometheus 指标的目的。

Datakit 支持命令行直接调试本采集器的配置文件。在配置 `conf.d/prom` 下 `prom_remote_write.conf` 的 `output` 项，将其配置为一个本地文件路径，之后 `prom_remote_write.conf` 会将采集到的数据写到文件中，数据就不会上传到中心。

重启 Datakit，让配置文件生效：

```shell
datakit service -R
```

这时 *prom_remote_write* 采集器将把采集的数据写到 output 指明的本地文件中。

这时执行如下命令，即可调试 *prom_remote_write.conf*

```shell
datakit debug --prom-conf prom_remote_write.conf
```

参数说明：

- `prom-conf`: 指定配置文件，默认在当前目录下寻找 `prom_remote_write.conf` 文件，如果未找到，会去 `<datakit-install-dir>/conf.d/prom` 目录下查找相应文件。

输出示例：

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

输出说明：

- Line Protocol Points： 产生的行协议点
- Summary： 汇总结果
    - Total time series: 时间线数量
    - Total line protocol points: 行协议点数
    - Total measurements: 指标集个数及其名称。
