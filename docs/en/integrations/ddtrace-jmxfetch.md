---
title     : 'DDTrace JMX'
summary   : 'DDTrace JMX Integration'
tags      :
  - 'DDTRACE'
  - 'JAVA'
  - 'APM'
__int_icon: 'icon/ddtrace'
---

## JMXFetch {#ddtrace-jmxfetch}

When DDTrace runs in agent mode, users do not need to specifically open a JMX port. If no port is opened, the agent will randomly open a local port.

JMXFetch collects Metrics from JMX servers and sends them outward in the statsD data structure format. It is integrated into *dd-java-agent* by default.

By default, it collects JVM information: JVM CPU, Mem, Thread, Class, etc. For more details, see the [Measurement list](jvm.md#metric).

By default, the collected Metrics are sent to `localhost:8125`. Ensure that the [statsd collector](statsd.md) is enabled.

If in a k8s environment, you need to configure the StatsD host and port:

```shell
DD_JMXFETCH_STATSD_HOST=datakit_url
DD_JMXFETCH_STATSD_PORT=8125
```

You can use `dd.jmxfetch.<INTEGRATION_NAME>.enabled=true` to enable specific collectors.

Before filling in `INTEGRATION_NAME`, you can first check the [default supported third-party software](https://docs.datadoghq.com/integrations/){:target="_blank"}.

For example, for tomcat:

```shell
-Ddd.jmxfetch.tomcat.enabled=true
```

## How to Collect Metrics via Custom Configuration {#custom-metric}

Custom JVM thread state Metrics

- `jvm.total_thread_count`
- `jvm.peak_thread_count`
- `jvm.daemon_thread_count`

> Starting from version v1.17.3-guance of `dd-java-agent`, these three Metrics have been built-in, so there is no need for additional configuration. However, this custom method can still be used to configure other MBean Metrics.

To collect custom Metrics, you need to add a configuration file:

1. Create a folder */usr/local/ddtrace/conf.d*. The directory location is arbitrary (pay attention to permissions), but it will be referenced later.
1. Under this folder, create a configuration file *guance.d/conf.yaml*. The file must be in YAML format.
1. Refer to the configuration of *conf.yaml* at the end.

My service name is `tmall.jar`, and the combined startup parameters are as follows:

```shell
java -javaagent:/usr/local/dd-java-agent.jar \
  -Dcom.sun.management.jmxremote.host=127.0.0.1 \
  -Dcom.sun.manaagement.jmxremote.port=9012 \
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