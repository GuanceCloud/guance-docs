---
title     : 'JMX'
summary   : 'Display JVM performance Metrics: heap and non-heap memory, threads, class loading counts, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'None available'
    path  : '-'
monitor   :
  - desc  : 'None available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JMX
<!-- markdownlint-enable -->

## JMX Definition

<!-- markdownlint-disable MD046 -->
???+ info "JMX Definition"

    The Java Virtual Machine (JVM) provides a complete framework for operation management and monitoring, known as JMX (Java Management Extensions). JMX is the abbreviation of Java Management Extensions, an extension framework for managing Java applications. JMX technology defines a comprehensive set of architectures and design patterns to monitor and manage Java applications. The foundation of JMX is managed beans (MBeans), which are instantiated through dependency injection and represent resources within the JVM. Since MBeans represent resources in the JVM, they can be used to manage specific aspects of an application or, more commonly, to collect statistics related to the usage of these resources.

<!-- markdownlint-enable -->

The core of JMX is the MBean server, which acts as a mediator connecting MBeans, applications within the same JVM, and the external world. Any interaction with MBeans is done through this server. Typically, only Java code can directly access the JMX API, but some adapters can convert this API to standard protocols, such as Jolokia converting it to HTTP.

JMX enables the export of runtime data status from within the VM to the outside by encapsulating runtime data into MBeans, which are then managed uniformly by the JMX Server, allowing external programs to retrieve data via RMI.

In summary, JMX allows runtime data to be obtained by external programs through the RMI protocol, providing a window for monitoring and manipulating internal VM data.


## Common JVM Metrics Collection Methods

1. [StatsD Collection](jmx.md#statsd)
2. [JMX Exporter Collection](jmx.md#jmx-exporter)
3. [Jolokia Collection](jmx.md#jolokia)
4. [Micrometer Collection](jmx.md#micrometer)
5. APM Agents: SkyWalking, OpenTelemetry, etc.

![jvm_collector_1](./imgs/jvm_collector_1.png)

### StatsD Collection

StatsD is essentially a daemon that listens on UDP (default) or TCP, collecting data sent by StatsD clients according to a simple protocol, aggregating it, and periodically pushing it to backends like Graphite and InfluxDB, which can then be displayed through an observability platform.

Nowadays, StatsD typically refers to the entire StatsD system, including the client, server, and backend. The client is embedded in the application code, reporting the corresponding metrics to the StatsD server.

DataKit can act as a StatsD server to receive data sent by clients.

![jvm_statsd](./imgs/jvm_statsd_1.png)


[StatsD Integration](jvm_statsd.md)

### JMX Exporter Collection

JMX Exporter uses Java's JMX mechanism to read monitoring data from the JVM runtime and converts it into Prometheus-compatible Metrics format for collection by Prometheus.

<!-- markdownlint-disable MD046 -->
???+ info "JMX Exporter"

    JMX Exporter runs as a Java Agent, exposing local JVM metrics via an HTTP port. It can also run as a standalone HTTP service and fetch remote JMX targets, but this approach has many drawbacks, such as difficulty in configuration and inability to expose process metrics (e.g., memory and CPU usage). Therefore, it is strongly recommended to run JMX Exporter as a Java Agent.
<!-- markdownlint-enable -->

[JMX Exporter Collection](jvm_jmx_exporter.md)

### Jolokia Collection

Jolokia is currently one of the most popular JMX monitoring components, adopted by the Spring community (SpringBoot, MVC, cloud) and mainstream middleware services. Jolokia uses JSON, a lightweight serialization scheme, instead of RMI.

Jolokia fully supports JMX components and can be embedded into any JAVA program, especially web applications. It converts complex and difficult-to-understand MBean filter queries into easier-to-implement and operate HTTP request paradigms, not only shielding the complexity of RMI development but also achieving transparency for external monitoring components, making it easier to test and use.

<!-- markdownlint-disable MD046 -->
???+ info "Jolokia"

    Jolokia solves issues encountered when obtaining JMX data, such as the complexity of the RMI protocol, inconvenience of MBean queries, database serialization, and MBeanServer management. By using HTTP requests, you can directly access JMX data on the same port as the web service.

<!-- markdownlint-enable -->

Jolokia provides two ways to obtain JMX data.

> Through the `javaagent` method, loaded when the application starts.

![jvm_jolokia_1](./imgs/jvm_jolokia_1.png)

> Through a proxy method, running the Agent independently.

![jvm_jolokia_2](./imgs/jvm_jolokia_2.png)


[Jolokia JVM Collection](jvm.md#jvm-jolokia)

### Micrometer Collection

None of the above methods support exposing business-defined metrics without coding definitions. Business metrics need to be defined through SDKs.

[JVM Micrometer Collection](jvm_micrometer.md)


### APM Vendor Integration

**APM Vendors** use APM as the foundation, introducing Metrics as part of observability. For example, SkyWalking integrates with JMX to expose Metric information.

[SkyWalking JVM Observability Best Practices](../best-practices/monitoring/skywalking-jvm.md)


[OpenTelemetry Metrics Collection](opentelemetry.md#opentelemetry_1)
