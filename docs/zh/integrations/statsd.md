---
title     : 'StatsD'
summary   : '收集 StatsD 上报的指标数据'
__int_icon      : 'icon/statsd'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# StatsD 数据接入
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

DDTrace Agent 采集的指标数据会通过 StatsD 数据类型发送到 DK 的 8125 端口上。其中包括 JVM 运行时的 CPU 、内存、线程、类加载信息，也包括开启的各种采集上来的 JMX 指标， 如： Kafka、Tomcat、RabbitMQ 等。

## 配置 {#config}

### 前置条件 {#requrements}

DDTrace 以 agent 形式运行时，不需要用户特意的开通 jmx 端口，如果没有开通端口的话， agent 会随机打开一个本地端口。

DDTrace 默认会采集 JVM 信息。默认情况下会发送到 `localhost:8125`.

如果是 k8s 环境下，需要配置 StatsD host 和 port：

```shell
DD_JMXFETCH_STATSD_HOST=datakit_url
DD_JMXFETCH_STATSD_PORT=8125
```

可以使用 `dd.jmxfetch.<INTEGRATION_NAME>.enabled=true` 开启指定的采集器。

填写 `INTEGRATION_NAME` 之前可以先查看 [默认支持的三方软件](https://docs.datadoghq.com/integrations/){:target="_blank"}

比如 Tomcat 或者 Kafka：

```shell
-Ddd.jmxfetch.tomcat.enabled=true
# or
-Ddd.jmxfetch.kafka.enabled=true
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/statsd` 目录，复制 `statsd.conf.sample` 并命名为 `statsd.conf`。示例如下：
    
    ```toml
        
    [[inputs.statsd]]
      ## Collector alias.
      # source = "statsd/-/-"
    
      ## Collect interval, default is 10 seconds. (optional)
      # interval = '10s'
    
      protocol = "udp"
    
      ## Address and port to host UDP listener on
      service_address = ":8125"
    
      ## Tag request metric. Used for distinguish feed metric name.
      ## eg, DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei
      ## eg, -Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei
      # statsd_source_key = "source_key"
      # statsd_host_key   = "host_key"
      ## Indicate whether report tag statsd_source_key and statsd_host_key.
      # save_above_key    = false
    
      delete_gauges = true
      delete_counters = true
      delete_sets = true
      delete_timings = true
    
      ## Counter metric is float in new Datakit version, set true if want be int.
      # set_counter_int = false
    
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
      # "stats_:stats", "jvm_:jvm", "tomcat_:tomcat",
      metric_mapping = [ ]
    
      ## Number of UDP messages allowed to queue up, once filled,
      ## the statsd server will start dropping packets, default is 128.
      # allowed_pending_messages = 128
    
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

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ info

    如果日志出现大量 Feed: io busy，可以配置 interval = '1s'，最低 1s。
<!-- markdownlint-enable -->

### 标记数据源 {#config-mark}

如果想标记 DDTrace 采集的主机，可以使用注入 tags 的方式进行标记：

- 可以使用环境变量，即 [`DD_TAGS`](statsd.md#requrements)，例如：`DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei`
- 可以使用命令行方式，即 [`dd.tags`](statsd.md#requrements)，例如：`-Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei`

在上面的例子中，需要在 Datakit 配置中指定 source 的 key 是 `source_key`，host 的 key 是 `host_key`。改成其它的也可以，但必须保证 Datakit 中的配置字段名与 DDTrace 中的字段名一致。

最终的效果是：在使用 `datakit monitor` 时可以看到 `statsd/tomcat/cn-shanghai-sq5ei`，这样可以与其它两样报告给 statsd 采集器的数据源区分开来。如果没有进行以上配置，那么在 datakit monitor 上看到的是默认展示：`statsd/-/-`。

另外，有配置开关 `save_above_key` 决定是否将 `statsd_source_key` 和 `statsd_host_key` 对应的 tag 报告给中心。默认不报告(`false`)。

## 指标 {#metric}

StatsD 暂无指标集定义，所有指标以网络发送过来的指标为准。

使用 Agent 默认的指标集的情况下，[GitHub 上可以查看所有的指标集](https://docs.datadoghq.com/integrations/){:target="_blank"}
