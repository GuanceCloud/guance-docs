
# Statsd 数据接入

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-10 10:51:49
- 操作系统支持：`windows,linux,darwin`

statsd 采集器用于接收网络上发送过来的 statsd 数据。

## 前置条件

暂无

## 配置

进入 DataKit 安装目录下的 `conf.d/statsd` 目录，复制 `statsd.conf.sample` 并命名为 `statsd.conf`。示例如下：

```toml

[[inputs.statsd]]
  protocol = "udp"

  ## Address and port to host UDP listener on
  service_address = ":8125"

  delete_gauges = true
  delete_counters = true
  delete_sets = true
  delete_timings = true

  ## Percentiles to calculate for timing & histogram stats
  percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]

  ## separator to use between elements of a statsd metric
  metric_separator = "_"

  ## Parses tags in the datadog statsd format
  ## http://docs.datadoghq.com/guides/dogstatsd/
  parse_data_dog_tags = true

  ## Parses datadog extensions to the statsd format
  datadog_extensions = true

  ## Parses distributions metric as specified in the datadog statsd format
  ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
  datadog_distributions = true

	## We do not need following tags(they may create tremendous of time-series under influxdb's logic)
	# Examples:
	# "runtime-id", "metric-type"
  drop_tags = [ ]

  # All metric-name prefixed with 'jvm_' are set to influxdb's measurement 'jvm'
  # All metric-name prefixed with 'stats_' are set to influxdb's measurement 'stats'
  # Examples:
  # "stats_:stats", "jvm_:jvm"
	metric_mapping = [ ]

  ## Number of UDP messages allowed to queue up, once filled,
  ## the statsd server will start dropping packets
  allowed_pending_messages = 10000

  ## Number of timing/histogram values to track per-measurement in the
  ## calculation of percentiles. Raising this limit increases the accuracy
  ## of percentiles but also increases the memory usage and cpu time.
  percentile_limit = 1000

  ## Max duration (TTL) for each metric to stay cached/reported without being updated.
  #max_ttl = "1000h"

  [inputs.statsd.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

## 指标集

statsd 暂无指标集定义，所有指标以网络发送过来的指标为准。
