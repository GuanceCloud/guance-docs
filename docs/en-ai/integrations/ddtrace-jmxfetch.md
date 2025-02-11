---
title     : 'DDTrace JMX'
summary   : 'DDTrace JMX Integration'
tags      :
  - 'DDTRACE'
  - 'JAVA'
  - 'Tracing'
__int_icon: 'icon/ddtrace'
---

## JMXFetch {#ddtrace-jmxfetch}

When DDTrace runs as an agent, it does not require users to specifically open a JMX port. If no port is opened, the agent will randomly open a local port.

JMXFetch collects metrics from JMX servers and sends them in statsD data structure format. It is integrated into *dd-java-agent*.

By default, it collects JVM information such as JVM CPU, memory, threads, classes, etc. Refer to the [Metrics List](jvm.md#metric) for details.

By default, the collected metrics are sent to `localhost:8125`. Ensure that the [statsd collector](statsd.md) is enabled.

In a Kubernetes environment, configure the StatsD host and port:

```shell
DD_JMXFETCH_STATSD_HOST=datakit_url
DD_JMXFETCH_STATSD_PORT=8125
```

You can enable specific collectors using `dd.jmxfetch.<INTEGRATION_NAME>.enabled=true`.

Before filling in `INTEGRATION_NAME`, you can check the [default supported third-party software](https://docs.datadoghq.com/integrations/){:target="_blank"}.

For example, for Tomcat:

```shell
-Ddd.jmxfetch.tomcat.enabled=true
```

## How to Collect Metrics via Custom Configuration {#custom-metric}

Custom JVM thread state metrics:

- `jvm.total_thread_count`
- `jvm.peak_thread_count`
- `jvm.daemon_thread_count`

> Since version v1.17.3-guance of `dd-java-agent`, these three metrics have been built-in and do not require additional configuration. However, this custom method can still be used to configure other MBean metrics.

To collect custom metrics, add a configuration file:

1. Create a folder */usr/local/ddtrace/conf.d* (the directory path can vary, but pay attention to permissions).
1. Under this folder, create a configuration file *guance.d/conf.yaml*. The file must be in YAML format.
1. Refer to the final section for the configuration of *conf.yaml*.

My service name is `tmall.jar`, and the combined startup parameters are:

```shell
java -javaagent:/usr/local/dd-java-agent.jar \
  -Dcom.sun.management.jmxremote.host=127.0.0.1 \
  -Dcom.sun.management.jmxremote.port=9012 \
  -Dcom.sun.management.jmxremote.ssl=false \
  -Dcom.sun.management.jmxremote.authenticate=false \
  -Ddd.jmxfetch.config.dir="/usr/local/ddtrace/conf.d/" \
  -Ddd.jmxfetch.config="guance.d/conf.yaml" \
  -jar tmall.jar
```

The *conf.yaml* configuration file is as follows:

```yaml
init_config:
  is_jmx: true
  collect_default_metrics: true

instances:
  - jvm_direct: true
    host: localhost
    port: 9012
    conf: 
      - include:
          domain: java.lang
          type: Threading
          attribute:
            TotalStartedThreadCount:
              alias: jvm.total_thread_count
              metric_type: gauge
            PeakThreadCount:
              alias: jvm.peak_thread_count
              metric_type: gauge
            DaemonThreadCount:
              alias: jvm.daemon_thread_count
              metric_type: gauge
```