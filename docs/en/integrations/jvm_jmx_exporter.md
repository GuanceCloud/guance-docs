---
title     : 'JMX Exporter'
summary   : 'JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by JMX Exporter monitoring view'
    path  : 'dashboard/en/jvm_jmx_exporter'
monitor   :
  - desc  : 'None temporarily'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046-->
# JVM (JMX Exporter)


???+ info "Tip"

    This article mainly focuses on collecting JVM-related metrics information via the JMX Exporter method.

<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `jvm collector`, which collects `jvm` Metrics information through the `jvm collector`.

### Application Integration with JMX Exporter


The following examples all use the `jar` runtime method.

- Download

Download the version based on actual needs from [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases). Here we choose version 0.18.0.

- Start configuration `javaagent`

```shell
java -javaagent:jmx_prometheus_javaagent-0.18.0.jar=8080:config.yaml -jar yourJar.jar
```

### DataKit Enable `prom` Collector

The collector directory is `datakit/conf.d/prom`. After entering the directory, copy `prom.conf.sample` and rename the new file to `jvm-prom.conf`. Mainly configure url, source, and measurement_prefix; other parameters can be adjusted as needed.

```toml
urls =["http://localhost:8080/metrics"]
source = "jmx_jmx_exporter_prom"
measurement_prefix = "jvm_"
[inputs.prom.tags]
  server="server"  
```

The above configuration will generate a Measurement set that starts with `jvm_`.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)
```