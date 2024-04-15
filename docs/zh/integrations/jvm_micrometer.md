---
title     : 'JMX Micrometer'
summary   : 'JVM 性能指标展示：堆与非堆内存、线程、类加载数等。'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by Micrometer 监控视图'
    path  : 'dashboard/zh/jmx_micrometer'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (Micrometer)
<!-- markdownlint-enable -->
---

<!-- markdownlint-disable MD046 -->
???+ info "提示"

    本文将以 SpringBoot 为前提，引入 Micrometer 相关依赖采集 JVM 指标。
<!-- markdownlint-enable -->

## 配置 {#config}

说明：开启 `prom 采集器`，通过 `prom 采集器`采集 jvm 指标信息。

### 应用接入 Prometheus

这里使用 SpringBoot 的 `spring-boot-starter-actuator` 和 `micrometer`。


### Micrometer

<!-- markdownlint-disable MD046 -->
???+ info "Micrometer"

    Micrometer 为 Java 平台上的性能数据收集提供了一个通用的 API，它提供了多种度量指标类型（`Timers`、`Guauges`、`Counters等`），同时支持接入不同的监控系统，例如 Influxdb、Graphite、Prometheus 等。我们可以通过 Micrometer 收集 Java 性能数据，配合 Prometheus 监控系统实时获取数据，并最终在 Grafana 上展示出来，从而很容易实现应用的监控。
<!-- markdownlint-enable -->

- 应用需要引入以下相关依赖

```xml
    <!-- spring-boot-actuator依赖 -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <!-- prometheus依赖 -->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-registry-prometheus</artifactId>
    </dependency>

```

- 配置 application.yaml

新增如下配置

```yaml
management:
  server:
    port: 8091
  endpoints:
    web:
      exposure:
        include: "*"
  metrics:
    tags:
      application: ${spring.application.name}
      env: ${spring.profiles.active}
```

- 访问指标

当启动完应用后，浏览器打开 `http://localhost:8091/actuator/prometheus` ，此端口为 `management` 端口。

如果 URL 访问正常，则表示应用已成功接入 `prometheus`。

### DataKit 开启 `prom` 采集器

- 开启采集器

采集器所在目录 `datakit/conf.d/prom`，进入目录后，复制 `prom.conf.sample`并将新文件重命名为 `jvm-prom.conf`，主要配置 URL 和 `source` ,其他参数可按需调整。

```toml
urls =["http://localhost:8091/actuator/prometheus"]
source = "jvm-prom"

measurement_prefix = "jvm_"
```

以上配置会生成 `jvm_`开头的指标集。

- 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

