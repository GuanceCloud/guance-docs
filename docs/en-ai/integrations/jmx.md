---
title     : 'JMX'
summary   : 'JVM performance metrics display: heap and non-heap memory, threads, class loading count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JMX
<!-- markdownlint-enable -->

## Definition of JMX

<!-- markdownlint-disable MD046 -->
???+ info "Definition of JMX"

    The Java Virtual Machine (JVM) provides a comprehensive framework for operation management and monitoring, known as JMX (Java Management Extensions). JMX is the abbreviation for Java Management Extensions, an extension framework for managing Java applications. JMX technology defines a complete set of architectures and design patterns to monitor and manage Java applications. The foundation of JMX is Managed Beans (MBeans), which are instantiated through dependency injection and represent resources within the JVM. Since MBeans represent resources in the JVM, they can be used to manage specific aspects of an application or, more commonly, to collect statistics related to the usage of these resources.

<!-- markdownlint-enable -->

The core of JMX is the MBean server, which acts as a mediator connecting MBeans, applications within the same JVM, and the external world. Any interaction with MBeans is conducted through this server. Typically, only Java code can directly access the JMX API, but some adapters can convert this API into standard protocols such as HTTP, like Jolokia, which converts it into HTTP.

JMX enables the export of runtime data state from within the VM, encapsulating runtime data into MBeans, managed by the JMX Server, and allowing external programs to retrieve data via RMI.

In summary, JMX allows runtime data to be accessed by external programs via the RMI protocol, providing a window for monitoring and operating on internal VM data.


## Common JVM Metrics Collection Methods

1. [StatsD Collection](jmx.md#statsd)
2. [JMX Exporter Collection](jmx.md#jmx-exporter)
3. [Jolokia Collection](jmx.md#jolokia)
4. [Micrometer Collection](jmx.md#micrometer)
5. APM Agents: SkyWalking, OpenTelemetry, etc.

![jvm_collector_1](./imgs/jvm_collector_1.png)

### StatsD Collection

StatsD is essentially a daemon that listens on UDP (default) or TCP, collecting data sent by StatsD clients according to a simple protocol, aggregating it, and periodically pushing it to backends like Graphite and InfluxDB, which can then be displayed on observability platforms.

Nowadays, StatsD typically refers to the StatsD system, including three parts: client, server, and backend. The client is embedded in the application code, reporting corresponding metrics to the StatsD server.

DataKit can act as a StatsD server, receiving data sent by clients.

![jvm_statsd](./imgs/jvm_statsd_1.png)


[StatsD Integration](jvm_statsd.md)

### JMX Exporter Collection

JMX Exporter uses Java's JMX mechanism to read monitoring data from the JVM runtime and converts it into Prometheus-compatible Metrics format for Prometheus to collect.

<!-- markdownlint-disable MD046 -->
???+ info "JMX Exporter"

    JMX Exporter runs as a Java Agent, exposing local JVM metrics via an HTTP port. It can also run as a standalone HTTP service and fetch remote JMX targets, but this approach has many drawbacks, such as difficulty in configuration and inability to expose process metrics (e.g., memory and CPU usage). Therefore, it is strongly recommended to run JMX Exporter as a Java Agent.
<!-- markdownlint-enable -->

[JMX Exporter Collection](jvm_jmx_exporter.md)

### Jolokia Collection

Jolokia, currently the most mainstream JMX monitoring component, is used by the Spring community (SpringBoot, MVC, cloud) and major middleware services for JMX monitoring. Jolokia uses lightweight JSON serialization instead of the RMI scheme, making it typeless data.

Jolokia fully supports and enhances JMX components. It can be embedded as an `agent` into any JAVA program, especially web applications, converting complex and difficult-to-understand MBean filter queries into easier-to-implement and operate HTTP request paradigms. This not only shields the complexity of RMI development but also achieves transparency for external monitoring components, making it easier to test and use.

<!-- markdownlint-disable MD046 -->
???+ info "Jolokia"

    Jolokia addresses issues encountered when obtaining JMX data, such as the complexity of the RMI protocol, inconvenient MBean queries, database serialization, and MBeanServer management. By using HTTP requests, you can access JMX data directly via the same port as the web service.

<!-- markdownlint-enable -->

Jolokia provides two ways to obtain JMX data.

> Through the `javaagent` method, loaded when the application starts.

![jvm_jolokia_1](./imgs/jvm_jolokia_1.png)

> Through proxy mode, running the Agent independently.

![jvm_jolokia_2](./imgs/jvm_jolokia_2.png)


[Jolokia JVM Collection](jvm.md#jvm-jolokia)

### Micrometer Collection

None of the above methods support exposing business metrics without coding definitions, meaning SDK-based methods are required to define and expose business metrics.

[JVM Micrometer Collection](jvm_micrometer.md)


### APM Vendor Integrations

**APM Vendors** build on APM as a foundation, introducing Metrics as part of observability. For example, SkyWalking integrates JMX-exposed Metric information.

[SkyWalking JVM Observability Best Practices](../best-practices/monitoring/skywalking-jvm.md)


[OpenTelemetry Metrics Collection](opentelemetry.md#opentelemetry_1)