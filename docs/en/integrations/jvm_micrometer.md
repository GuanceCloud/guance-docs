---
title     : 'JMX Micrometer'
summary   : 'JVM performance Metrics display: heap and non-heap memory, threads, number of class loads, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by Micrometer monitoring view'
    path  : 'dashboard/en/jmx_micrometer'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (Micrometer)
<!-- markdownlint-enable -->
---

<!-- markdownlint-disable MD046 -->
???+ info "Tip"

    This article will take SpringBoot as a prerequisite, introducing Micrometer-related dependencies to collect JVM Metrics.
<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `prom collector`, and collect JVM Metrics information through the `prom collector`.

### Application Integration with Prometheus

Here we use SpringBoot’s `spring-boot-starter-actuator` and `micrometer`.


### Micrometer

<!-- markdownlint-disable MD046 -->
???+ info "Micrometer"

    Micrometer provides a common API for performance data collection on the Java platform. It offers various types of metrics (`Timers`, `Gauges`, `Counters`, etc.), and supports integration with different monitoring systems such as Influxdb, Graphite, Prometheus, etc. We can collect Java performance data using Micrometer, combined with the Prometheus monitoring system to obtain data in real-time, and ultimately display it in Grafana, making it easy to monitor applications.
<!-- markdownlint-enable -->

- The application needs to introduce the following related dependencies

```xml
    <!-- spring-boot-actuator dependency -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <!-- prometheus dependency -->
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

- Access Metrics

After starting the application, open the browser at `http://localhost:8091/actuator/prometheus`, this port is the `management` port.

If the URL access is normal, it means the application has successfully integrated with `prometheus`.

### DataKit Enable `prom` Collector

- Enable Collector

The directory for the collector is `datakit/conf.d/prom`. After entering the directory, copy `prom.conf.sample` and rename the new file to `jvm-prom.conf`. Mainly configure the URL and `source`; other parameters can be adjusted as needed.

```toml
urls =["http://localhost:8091/actuator/prometheus"]
source = "jvm-prom"

measurement_prefix = "jvm_"
```

The above configuration will generate Measurement sets starting with `jvm_`.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)