---
title     : 'JMX StatsD'
summary   : 'JVM performance Metrics display: heap and non-heap memory, threads, class loading numbers, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM Monitoring View'
    path  : 'dashboard/en/jvm'
  - desc  : 'JVM Kubernetes Monitoring View'
    path  : 'dashboard/en/jvm_kubernetes'
  - desc  : 'JVM Kubernetes by podName Monitoring View'
    path  : 'dashboard/en/jvm_kubernetes_by_podname'
monitor   :
  - desc  : 'Not exist'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (StatsD)
<!-- markdownlint-enable -->
---

## Configuration {#config}

Description: Example of collecting JVM Metrics through `ddtrace`, with DataKit's built-in Statsd receiving the JVM Metrics sent by `ddtrace`.

### Enable DataKit Collector

- Enable `Statsd` collector

Copy the `sample` file; no need to modify `statsd.conf`

```shell
cd /usr/local/datakit/conf.d/statsd
cp statsd.conf.sample statsd.conf
```

- Restart DataKit

```shell
systemctl restart datakit
```

### Application Configuration

- Adjust startup parameters


```shell
-javaagent:/usr/local/datakit/data/dd-java-agent.jar \
 -Ddd.service.name=<your-service>   \
 -Ddd.env=dev  \
 -Ddd.agent.port=9529  
```

Use `java -jar` to start the `jar`, which by default connects to the local `DataKit`. If you need to connect to a remote server's `DataKit`, use `-Ddd.agent.host` and `-Ddd.jmxfetch.statsd.host` to specify the `ip`.

For more detailed integration with DDTrace, refer to the [`ddtrace-java`](ddtrace-java.md) documentation.
</translated_content>