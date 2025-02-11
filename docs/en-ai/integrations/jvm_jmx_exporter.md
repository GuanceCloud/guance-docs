---
title     : 'JMX Exporter'
summary   : 'JVM performance metrics display: heap and non-heap memory, threads, class loading count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM monitoring view by JMX Exporter'
    path  : 'dashboard/en/jvm_jmx_exporter'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046-->
# JVM (JMX Exporter)


???+ info "Tip"

    This article primarily focuses on collecting JVM-related metrics using the JMX Exporter method.

<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `JVM collector` to collect JVM metrics information.

### Application Integration with JMX Exporter

The following examples are based on running via `jar`.

- Download

Choose the appropriate version to download from [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases). Here we choose version 0.18.0.

- Start configuration with `javaagent`

```shell
java -javaagent:jmx_prometheus_javaagent-0.18.0.jar=8080:config.yaml -jar yourJar.jar
```

### DataKit Enables `Prom` Collector

The collector is located in the directory `datakit/conf.d/prom`. After entering this directory, copy `prom.conf.sample` and rename the new file to `jvm-prom.conf`. The main configurations include url, source, and measurement_prefix, while other parameters can be adjusted as needed.

```toml
urls =["http://localhost:8080/metrics"]
source = "jmx_jmx_exporter_prom"
measurement_prefix = "jvm_"
[inputs.prom.tags]
  server="server"  
```

The above configuration will generate Metrics starting with `jvm_`.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)