---
title: 'JMX'
summary: 'JVM performance metrics display: heap and non-heap memory, threads, number of class loads, etc.'
__int_icon: 'icon/jvm'
dashboard:
  - desc: 'Not available yet'
    path: '-'
monitor:
  - desc: 'Not available yet'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# JMX
<!-- markdownlint-enable -->

## JMX Definition

<!-- markdownlint-disable MD046 -->
???+ info "JMX Definition"

    The Java Virtual Machine (JVM) provides a complete framework for operation management and monitoring, namely JMX (Java Management Extensions). JMX is the abbreviation of Java Management Extensions, which is an extension framework for managing Java. JMX technology defines a complete set of architectures and design patterns to monitor and manage Java applications. The foundation of JMX is managed beans (MBeans), where MBeans are various categories instantiated through dependency injection, representing resources in the JVM. Since MBeans represent resources within the JVM, we can use them to manage specific aspects of the application or, more commonly, to collect statistics related to the usage of these resources.

<!-- markdownlint-enable -->

The core of JMX is the MBean server, which acts as a medium connecting MBeans, applications within the same JVM, and the external world. All interactions with MBeans are conducted through this server. Typically, only Java code can directly access the JMX API, but some adapters can convert this API into standard protocols, such as Jolokia converting it into HTTP.

JMX can export runtime data states from within the VM by encapsulating runtime data into MBeans, which are then centrally managed via the JMX Server, allowing external programs to retrieve data through RMI.

In short, JMX allows runtime data to be obtained by external programs via the RMI protocol, providing a window for us to monitor and operate on internal data within the VM.


## Common JVM Metric Collection Methods

1. [Statsd Collection](jmx.md#statsd)
2. [JMX Exporter Collection](jmx.md#jmx-exporter)
3. [Jolokia Collection](jmx.md#jolokia)
4. [Micrometer Collection](jmx.md#micrometer)
5. APM Agents: SkyWalking, OpenTelemetry, etc.

![jvm_collector_1](./imgs/jvm_collector_1.png)

### StatsD Collection

StatsD is actually a daemon that listens on UDP (default) or TCP, collecting data sent by StatsD clients according to a simple protocol, aggregating it, and periodically pushing it to backends like Graphite and InfluxDB, then displaying it through observability platforms.

Nowadays, StatsD usually refers to the StatsD system, consisting of three parts: client, server, and backend. The client is embedded in the application code, reporting corresponding metrics to the StatsD server.

DataKit can act as a StatsD server to receive data sent by the client.

![jvm_statsd](./imgs/jvm_statsd_1.png)


[StatsD Integration](jvm_statsd.md)

### JMX Exporter Collection

The JMX Exporter uses Java's JMX mechanism to read some monitoring data from the JVM at runtime, then converts it into the Metrics format recognized by Prometheus so that Prometheus can monitor and collect it.

<!-- markdownlint-disable MD046 -->
???+ info "JMX Exporter"

    The JMX Exporter runs as a Java Agent, exposing local JVM metrics via an HTTP port. It can also run as an independent HTTP service and fetch remote JMX targets, but this has many disadvantages, such as difficulty in configuration and inability to expose process metrics (e.g., memory and CPU usage). Therefore, it is strongly recommended to run the JMX Exporter as a Java Agent.
<!-- markdownlint-enable -->

[JMX Exporter Collection](jvm_jmx_exporter.md)

### Jolokia Collection

As the most mainstream JMX monitoring component currently, Jolokia is adopted by the Spring community (SpringBoot, MVC, cloud) and mainstream middleware services. Jolokia is typeless data, using JSON as a lightweight serialization scheme instead of the RMI scheme.

Jolokia fully supports JMX components and can be embedded as an `agent` into any JAVA program, especially web applications. It converts complex and hard-to-understand MBean Filter query statements into easier-to-implement and operate HTTP request paradigms, not only shielding the development difficulties of RMI but also achieving transparency for external monitoring components, making it easier to test and use.

<!-- markdownlint-disable MD046 -->
???+ info "Jolokia"

    Jolokia solves the problems encountered when obtaining JMX data, such as the complexity of the RMI protocol, inconvenience of MBean queries, database serialization, and MBeanServer management. We just need to use HTTP requests to directly access the same port as the web service to obtain JMX data.

<!-- markdownlint-enable -->

Jolokia provides two ways to get JMX data.

> Through the `javaagent` method, loaded when the application starts.

![jvm_jolokia_1](./imgs/jvm_jolokia_1.png)

> Through proxy mode, running the Agent independently.

![jvm_jolokia_2](./imgs/jvm_jolokia_2.png)


[Jolokia JVM Collection](jvm.md#jvm-jolokia)

### Micrometer Collection

None of the above solutions support exposing business metrics definitions, which require coding definitions before they can be exposed, i.e., completed through SDKs.

[JVM Micrometer Collection](jvm_micrometer.md)


### APM Vendor Integration

**APM Vendors** use APM as a foundation, introducing Metrics as part of observability. For example, SkyWalking exposes Metric information through JMX integration.

[SkyWalking Best Practices for Collecting JVM Observability](../best-practices/monitoring/skywalking-jvm.md)


[OpenTelemetry Metrics Collection](opentelemetry.md#opentelemetry_1)