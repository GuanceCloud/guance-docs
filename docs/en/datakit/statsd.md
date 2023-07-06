
# Statsd Data Access
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---
The indicator data collected by the DDTrace agent will be sent to port 8125 of the DK through the StatsD data type.

This includes the JVM CPU, memory, threads, and class loading information of the JVM runtime, as well as various collected JMX indicators such as Kafka, Tomcat, RabbitMQ, etc.


## Preconditions {#requrements}

When DDTrace runs as an agent, there is no need for the user to specifically open the jmx port. If no port is opened, the agent will randomly open a local port.

DDTrace will collect JVM information by default. By default, it will be sent to 'localhost: 8125'

if k8s:
```shell
DD_JMXFETCH_STATSD_HOST=datakit_url
DD_JMXFETCH_STATSD_PORT=8125
```

You can use ` dd.jmxfetch.<INTEGRATION_NAME>.enabled=true ` Enable the specified collector.

for `INTEGRATION_NAME`, You can check the [default supported third-party software](https://docs.datadoghq.com/integrations/){:target="_blank"} before.

For example, Tomcat or Kafka:

```shell
-Ddd.jmxfetch.tomcat.enabled=true
# or
-Ddd.jmxfetch.kafka.enabled=true 
```


## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/statsd` directory under the DataKit installation directory, copy `statsd.conf.sample` and name it `statsd.conf`. Examples are as follows:
    
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
    
    After configuration, restart DataKit.

=== "Kubernetes"

    The collector can now be turned on by [configMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurement {#measurement}

Statsd has no measurement definition at present, and all metrics are subject to the metrics sent by the network.

For example, if Tomcat or Kafka uses the default indicator set, [GitHub can view all indicator sets](https://docs.datadoghq.com/integrations/){:target="_blank"}
