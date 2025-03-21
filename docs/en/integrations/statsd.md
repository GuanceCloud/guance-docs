---
title     : 'StatsD'
summary   : 'Collect metrics data reported by StatsD'
tags:
  - 'External Data Integration'
__int_icon      : 'icon/statsd'
dashboard :
  - desc  : 'None'
    path  : '-'
monitor   :
  - desc  : 'None'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

DDTrace Agent collects metrics data and sends it to DK's port 8125 in the StatsD data format. This includes CPU, memory, thread, and class loading information for JVM runtime, as well as various JMX metrics that are enabled, such as Kafka, Tomcat, RabbitMQ, etc.

## Configuration {#config}

### Prerequisites {#requirements}

When DDTrace runs in agent mode, there is no need for users to specifically open a JMX port. If no port has been opened, the agent will randomly open a local port.

DDTrace collects JVM information by default. By default, it sends data to `localhost:8125`.

If you're in a k8s environment, you need to configure the StatsD host and port:

```shell
DD_JMXFETCH_STATSD_HOST=datakit_url
DD_JMXFETCH_STATSD_PORT=8125
```

You can use `dd.jmxfetch.<INTEGRATION_NAME>.enabled=true` to enable specific collectors.

Before filling in `INTEGRATION_NAME`, you can first check [the default supported third-party software](https://docs.datadoghq.com/integrations/){:target="_blank"}.

For example, Tomcat or Kafka:

```shell
-Ddd.jmxfetch.tomcat.enabled=true
# or
-Ddd.jmxfetch.kafka.enabled=true
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/statsd` directory under the DataKit installation directory, copy `statsd.conf.sample` and rename it to `statsd.conf`. An example is shown below:
    
    ```toml
        
    [[inputs.statsd]]
      ## Collector alias.
      # source = "statsd/-/-"
    
      ## Collection interval, default is 10 seconds. (optional)
      # interval = '10s'
    
      protocol = "udp"
    
      ## Address to host unix listener on, linux only
      service_unix_address = "/var/run/datakit/statsd.sock"
    
      ## Address and port to host UDP listener on
      service_address = ":8125"
    
      ## Tag request metric. Used to distinguish feed metric names.
      ## eg, DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei
      ## eg, -Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei
      # statsd_source_key = "source_key"
      # statsd_host_key   = "host_key"
      ## Indicate whether report statsd_source_key and statsd_host_key tags.
      # save_above_key    = false
    
      delete_gauges = true
      delete_counters = true
      delete_sets = true
      delete_timings = true
    
      ## Counter metric is float in new Datakit version, set true if want be int.
      # set_counter_int = false
    
      ## Percentiles to calculate for timing & histogram stats
      percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]
    
      ## Separator to use between elements of a statsd metric
      metric_separator = "_"
    
      ## Parses tags in the Datadog StatsD format
      ## http://docs.datadoghq.com/guides/dogstatsd/
      parse_data_dog_tags = true
    
      ## Parses Datadog extensions to the StatsD format
      datadog_extensions = true
    
      ## Parses distributions metric as specified in the Datadog StatsD format
      ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
      datadog_distributions = true
    
      ## We do not need following tags(they may create tremendous time-series under InfluxDB's logic)
      # Examples:
      # "runtime-id", "metric-type"
      drop_tags = [ ]
    
      # All metric-name prefixed with 'jvm_' are set to InfluxDB's measurement 'jvm'
      # All metric-name prefixed with 'stats_' are set to InfluxDB's measurement 'stats'
      # Examples:
      # "stats_:stats", "jvm_:jvm", "tomcat_:tomcat",
      metric_mapping = [ ]
    
      ## Number of UDP messages allowed to queue up, once filled,
      ## the StatsD server will start dropping packets, default is 128.
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
    
    After configuration, restart DataKit.

=== "Kubernetes"

    You can currently enable the collector by injecting its configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ info

    If logs show a large number of Feed: io busy, you can set `interval = '1s'`, minimum 1s.
<!-- markdownlint-enable -->

### Mark Data Source {#config-mark}

If you want to mark hosts collected by DDTrace, you can tag them using injected tags:

- You can use environment variables, i.e., [`DD_TAGS`](statsd.md#requirements), for example: `DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei`
- You can use command-line options, i.e., [`dd.tags`](statsd.md#requirements), for example: `-Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei`

In the examples above, you need to specify the key for source in the DataKit configuration as `source_key` and the key for host as `host_key`. You can change these to other names, but you must ensure that the field names in DataKit's configuration match those in DDTrace.

The final effect is: when using `datakit monitor`, you will see `statsd/tomcat/cn-shanghai-sq5ei`, which allows distinguishing this data source from others reporting to the StatsD collector. Without the aforementioned configuration, you would see the default display on `datakit monitor`: `statsd/-/-`.

Additionally, the configuration switch `save_above_key` determines whether the tags corresponding to `statsd_source_key` and `statsd_host_key` are reported to the center. The default is not to report (`false`).

## Metrics {#metric}

There is no predefined metrics set for StatsD; all metrics are based on the network-sent metrics.

When using the default metrics set provided by the Agent, [all metrics sets can be viewed on GitHub](https://docs.datadoghq.com/integrations/){:target="_blank"}.