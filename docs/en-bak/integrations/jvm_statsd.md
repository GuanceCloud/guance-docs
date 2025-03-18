---
title     : 'JMX StatsD'
summary   : 'JVM performance metrics display: heap and non heap memory, threads, class load count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM Monitoring View'
    path  : 'dashboard/zh/jvm'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (StatsD)
<!-- markdownlint-enable -->
---

## Configuration {#config}

Example: Collect JVM metrics through `ddtrace` and receive JVM metrics sent by `ddtrace` through the built-in Statsd of DataKit.

### DataKit enables the collector

- Enables `Statsd` collector

Copy the `sample` file without modifying the `statsd.conf`

```shell
cd /usr/local/datakit/conf.d/statsd
cp statsd.conf.sample statsd.conf
```

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


### Application Configuration

- Adjusting startup parameters


```shell
-javaagent:/usr/local/datakit/data/dd-java-agent.jar \
 -Ddd.service.name=<your-service>   \
 -Ddd.env=dev  \
 -Ddd.agent.port=9529  
```

Start `jar` using the `java -jar` method and connect to DataKit on the local machine by default. If you need to connect to DataKit on a remote server, please use `-Ddd.agent.host` and `-Ddd.jmxfetch.statsd.host` to specify `ip`.

For more detailed access to DDTrace, refer to the [`ddtrace java`](ddtrace-java.md) document.
