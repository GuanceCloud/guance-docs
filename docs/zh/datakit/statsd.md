
# StatsD 数据接入

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

DDTrace agent 采集的指标数据会通过 StatsD 数据类型发送到 DK 的 8125 端口上。
其中包括 JVM 运行时的 CPU 、内存、线程、类加载信息，也包括开启的各种采集上来的 JMX 指标， 如: Kafka, Tomcat, RabbitMQ 等。

## 前置条件 {#requrements}

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

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

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

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标集 {#measurement}

statsD 暂无指标集定义，所有指标以网络发送过来的指标为准。

使用 Agent 默认的指标集的情况下，[GitHub 上可以查看所有的指标集](https://docs.datadoghq.com/integrations/){:target="_blank"}
