---
title     : 'JMX Jolokia'
summary   : 'JVM performance Metrics display: heap and non-heap memory, threads, class loading counts, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by Jolokia monitoring view'
    path  : 'dashboard/en/jmx_exporter'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046 -->
# JVM (Jolokia)
---

???+ info "Tip"

    This article mainly collects jvm related Metrics information through the Jolokia method.
<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `jvm collector`, and collect `jvm` Metrics information through the `jvm collector`.

### Application Integration with Jolokia

The `DataKit` installation directory already provides the `Jolokia agent`. It is located in the `datakit/data/` directory, providing two types of agent libraries: `jolokia-jvm-agent.jar` and `jolokia-war.war`.

The following examples are all based on the `jar` execution method.

- Start configuration for `javaagent`

```shell
java -javaagent:C:/'Program Files'/datakit/data/jolokia-jvm-agent.jar=port=8089,host=localhost -jar your_app.jar
```

### Enable DataKit Collector

- Enable the collector

The collector is located in the `datakit/conf.d/jvm` directory. After entering the directory, copy `jvm.conf.sample` and rename the new file to `jvm.conf`. Mainly configure `url`, other parameters can be adjusted as needed.

```toml
urls = ["http://localhost:8089/jolokia"]
```

The above configuration will generate Measurement sets starting with `java_`.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)