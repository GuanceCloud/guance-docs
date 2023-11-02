---
title     : 'JMX Micrometer'
summary   : 'JVM performance metrics display: heap and non heap memory, threads, class load count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by Micrometer Monitoring View'
    path  : 'dashboard/zh/jvm_micrometer'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (Micrometer)
<!-- markdownlint-enable -->
---

<!-- markdownlint-disable MD046 -->
???+ info "Notice"

    This article will take SpringBoot as the premise and introduce Micrometer related dependencies to collect JVM metrics.

<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `prom` collector to collect jvm metric information through the `prom` collector.

### Application access to Prometheus

Here, we use SpringBoot's `spring boot starter actuator` and `micrometer`.

### Micrometer

<!-- markdownlint-disable MD046 -->
???+ info "Micrometer"

    Micrometer provides a universal API for performance data collection on the Java platform, providing multiple metric types (such as `Timers`, `Guages`,`Counters`, etc.), and supporting access to different monitoring systems such as Influxdb, Graphite, Prometheus, etc. We can collect Java performance data through Micrometer, cooperate with the Prometheus monitoring system to obtain real-time data, and ultimately display it on Grafana, making it easy to achieve application monitoring.

<!-- markdownlint-enable -->

- The application needs to introduce the following related dependencies

```xml
    <!-- spring-boot-actuator  -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <!-- prometheus  -->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-registry-prometheus</artifactId>
    </dependency>

```

- Configure application.yaml

Add the following configuration

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

- Access metrics

After launching the application, the browser opens `http://localhost:8091/actuator/prometheus` This port is the `management` port.

If the URL access is normal, it indicates that the application has successfully connected to `prometheus`.

### DataKit enables `prom` collector

- Enables the collector

The directory where the collector is located is `datakit/conf.d/prom` . After entering the directory, copy `prom.conf.sample` and rename the new file to `jvm-prom.conf` . The main configuration is `URL` and `source`, and other parameters can be adjusted as needed.

```toml
urls =["http://localhost:8091/actuator/prometheus"]
source = "jvm-prom"

measurement_prefix = "jvm_"
```

The above configuration will generate `jvm_` The metric set at the beginning.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

