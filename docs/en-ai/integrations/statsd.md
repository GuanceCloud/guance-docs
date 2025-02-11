---
title     : 'StatsD'
summary   : 'Collect metrics data reported by StatsD'
tags:
  - 'External Data Ingestion'
__int_icon      : 'icon/statsd'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Metrics data collected by the DDTrace Agent is sent to port 8125 of DK using the StatsD data type. This includes CPU, memory, thread, and class loading information from the JVM runtime, as well as various JMX metrics that are enabled, such as Kafka, Tomcat, RabbitMQ, etc.

## Configuration {#config}

### Prerequisites {#requirements}

When running DDTrace as an agent, there's no need for users to specifically open the JMX port. If the port has not been opened, the agent will randomly open a local port.

DDTrace collects JVM information by default. By default, it sends data to `localhost:8125`.

In a Kubernetes environment, you need to configure the StatsD host and port:

```shell
DD_JMXFETCH_STATSD_HOST=datakit_url
DD_JMXFETCH_STATSD_PORT=8125
```

You can enable specific collectors using `dd.jmxfetch.<INTEGRATION_NAME>.enabled=true`.

Before filling in `INTEGRATION_NAME`, you can check the [supported third-party software](https://docs.datadoghq.com/integrations/){:target="_blank"}.

For example, Tomcat or Kafka:

```shell
-Ddd.jmxfetch.tomcat.enabled=true
# or
-Ddd.jmxfetch.kafka.enabled=true
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/statsd` directory under the DataKit installation directory, copy `statsd.conf.sample` and rename it to `statsd.conf`. Example configuration:
    
    ```toml
        
    [[inputs.statsd]]
      ## Collector alias.
      # source = "statsd/-/-"
    
      ## Collection interval, default is 10 seconds. (optional)
      # interval = '10s'
    
      protocol = "udp"
    
      ## Address and port for the UDP listener
      service_address = ":8125"
    
      ## Tag request metric. Used to distinguish feed metric names.
      ## e.g., DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei
      ## e.g., -Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei
      # statsd_source_key = "source_key"
      # statsd_host_key   = "host_key"
      ## Indicate whether to report statsd_source_key and statsd_host_key tags.
      # save_above_key    = false
    
      delete_gauges = true
      delete_counters = true
      delete_sets = true
      delete_timings = true
    
      ## Counter metrics are float in new DataKit versions; set true if you want them to be integers.
      # set_counter_int = false
    
      ## Percentiles to calculate for timing & histogram stats
      percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]
    
      ## Separator to use between elements of a StatsD metric
      metric_separator = "_"
    
      ## Parses tags in the Datadog StatsD format
      ## http://docs.datadoghq.com/guides/dogstatsd/
      parse_data_dog_tags = true
    
      ## Parses Datadog extensions to the StatsD format
      datadog_extensions = true
    
      ## Parses distribution metrics as specified in the Datadog StatsD format
      ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
      datadog_distributions = true
    
      ## Tags that we do not need (they may create a large number of time series under InfluxDB's logic)
      # Examples:
      # "runtime-id", "metric-type"
      drop_tags = [ ]
    
      # All metric names prefixed with 'jvm_' are set to InfluxDB's measurement 'jvm'
      # All metric names prefixed with 'stats_' are set to InfluxDB's measurement 'stats'
      # Examples:
      # "stats_:stats", "jvm_:jvm", "tomcat_:tomcat",
      metric_mapping = [ ]
    
      ## Number of UDP messages allowed to queue up; once filled, the StatsD server will start dropping packets. Default is 128.
      # allowed_pending_messages = 128
    
      ## Number of timing/histogram values to track per-measurement in the calculation of percentiles. Increasing this limit improves accuracy but also increases memory usage and CPU time.
      percentile_limit = 1000
    
      ## Maximum duration (TTL) for each metric to stay cached/reported without being updated.
      #max_ttl = "1000h"
    
      [inputs.statsd.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    After configuring, restart DataKit.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ info

    If logs show many Feed: io busy messages, you can set `interval = '1s'`, minimum 1 second.
<!-- markdownlint-enable -->

### Marking Data Sources {#config-mark}

To mark hosts collected by DDTrace, you can inject tags:

- Use environment variables, i.e., [`DD_TAGS`](statsd.md#requirements), for example: `DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei`
- Use command-line options, i.e., [`dd.tags`](statsd.md#requirements), for example: `-Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei`

In the above examples, specify the key for the source as `source_key` and the key for the host as `host_key` in the DataKit configuration. You can change these keys to other names, but ensure that the field names in the DataKit configuration match those in DDTrace.

The final effect is: when using `datakit monitor`, you can see `statsd/tomcat/cn-shanghai-sq5ei`, which distinguishes this data source from others reported to the StatsD collector. Without this configuration, `datakit monitor` shows the default display: `statsd/-/-`.

Additionally, the configuration switch `save_above_key` determines whether to report the tags corresponding to `statsd_source_key` and `statsd_host_key` to the central system. The default is not to report (`false`).

## Metrics {#metric}

StatsD does not have predefined metric sets; all metrics are based on the metrics sent over the network.

Using the default metric set with the Agent, you can view all metric sets on [GitHub](https://docs.datadoghq.com/integrations/){:target="_blank"}.