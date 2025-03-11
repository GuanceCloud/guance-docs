---
title     : 'JMX Micrometer'
summary   : 'JVM performance metrics display: heap and non-heap memory, threads, number of classes loaded, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by Micrometer monitoring view'
    path  : 'dashboard/en/jmx_micrometer'
monitor   :
  - desc  : 'Not exist'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (Micrometer)
<!-- markdownlint-enable -->
---

<!-- markdownlint-disable MD046 -->
???+ info "Tip"

    This article will use SpringBoot as a prerequisite, introducing Micrometer-related dependencies to collect JVM metrics.
<!-- markdownlint-enable -->

## Configuration {#config}

Note: Enable the `Prometheus collector`, collecting JVM metric information via the `Prometheus collector`.

### Application Integration with Prometheus

Here we use SpringBoot's `spring-boot-starter-actuator` and `Micrometer`.


### Micrometer

<!-- markdownlint-disable MD046 -->
???+ info "Micrometer"

    Micrometer provides a common API for performance data collection on the Java platform. It offers various types of metrics (`Timers`, `Gauges`, `Counters`, etc.), and supports integration with different monitoring systems such as Influxdb, Graphite, Prometheus, etc. We can collect Java performance data through Micrometer, combined with the Prometheus monitoring system to obtain real-time data, and finally display it on Grafana, making it easy to achieve application monitoring.
<!-- markdownlint-enable -->

- The application needs to introduce the following related dependencies

```xml
    <!-- spring-boot-actuator dependency -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <!-- Prometheus dependency -->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-registry-prometheus</artifactId>
    </dependency>

```

- Configure `application.yaml`

Add the following configuration:

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

- Access Metrics

After starting the application, open `http://localhost:8091/actuator/prometheus` in your browser. This port is the `management` port.

If the URL access is successful, it indicates that the application has successfully integrated with `Prometheus`.

### DataKit Enable `Prometheus` Collector

- Enable Collector

The collector directory is `datakit/conf.d/prom`. Enter this directory, copy `prom.conf.sample` and rename the new file to `jvm-prom.conf`. Mainly configure the URL and `source`; other parameters can be adjusted as needed.

```toml
urls = ["http://localhost:8091/actuator/prometheus"]
source = "jvm-prom"

measurement_prefix = "jvm_"
```

The above configuration will generate a metrics set starting with `jvm_`.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)
