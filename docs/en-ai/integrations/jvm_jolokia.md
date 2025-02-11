---
title     : 'JMX Jolokia'
summary   : 'JVM performance Metrics display: heap and non-heap memory, threads, class loading count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM monitoring view by Jolokia'
    path  : 'dashboard/en/jmx_exporter'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046 -->
# JVM (Jolokia)
---

???+ info "Tip"

    This article mainly focuses on collecting JVM-related Metrics information via Jolokia.
<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `JVM collector` to collect JVM Metrics.

### Application Integration with Jolokia

The `DataKit` installation directory already provides the `Jolokia agent`. It is located in the `datakit/data/` directory, offering two types of agent libraries: `jolokia-jvm-agent.jar` and `jolokia-war.war`.

The following examples use the `jar` execution method.

- Start configuration `javaagent`

```shell
java -javaagent:C:/'Program Files'/datakit/data/jolokia-jvm-agent.jar=port=8089,host=localhost -jar your_app.jar
```

### Enabling the DataKit Collector

- Enable the collector

The collector is located in the `datakit/conf.d/jvm` directory. Navigate to this directory, copy `jvm.conf.sample`, and rename the new file to `jvm.conf`. Configure the `url`, and adjust other parameters as needed.

```toml
urls = ["http://localhost:8089/jolokia"]
```

The above configuration will generate Metrics sets starting with `java_`.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)