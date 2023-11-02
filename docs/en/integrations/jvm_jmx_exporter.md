---
title     : 'JMX Exporter'
summary   : 'JVM performance metrics display: heap and non heap memory, threads, class load count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by JMX Exporter Monitoring View'
    path  : 'dashboard/zh/jvm_jmx_exporter'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046-->
# JVM (JMX Exporter)

???+ info "Notice"

    The current article mainly collects JVM related metric information through the JMX Exporter method.

<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `jvm collector` to collect `jvm` metric information through the `jvm collector`.

### Application access to JMX Exporter


The following are all examples of `jar` running mode.

- Download

Choose the download version according to actual needs [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases),Select version `0.18.0` here.

- Boot Configuration `javaagent`

```shell
java -javaagent:jmx_prometheus_javaagent-0.18.0.jar=8080:config.yaml -jar yourJar.jar
```

### DataKit opens the `prom` collector

The directory where the collector is located is `datakit/conf.d/prom`. After entering the directory, copy `prom.conf.sample` and rename the new file to `jvm_prom.conf`, mainly configuring `urls`, `sources`, and `measurements_prefix`, other parameters can be adjusted as needed.

```toml
urls =["http://localhost:8080/metrics"]
source = "jmx_jmx_exporter_prom"
measurement_prefix = "jvm_"
[inputs.prom.tags]
  server="server"  
```

The above configuration will generate `jvm_` The metric set at the beginning.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)
