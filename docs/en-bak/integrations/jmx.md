---
title     : 'JMX'
summary   : 'JVM performance metrics display: heap and non heap memory, threads, class load count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JMX
<!-- markdownlint-enable -->

## JMX Definition

<!-- markdownlint-disable MD046 -->
???+ info "JMX Definition"

    The Java Virtual Machine (JVM) provides a complete framework for operation management and monitoring, known as JMX (Java Management Extensions). JMX is an abbreviation for Java Management Extensions and an extension framework for managing Java. JMX technology defines a complete set of architecture and design patterns to monitor and manage Java applications. The foundation of JMX is managed beans (commonly referred to as MBeans in the industry), which are various classes that are instantiated through dependency injection and represent resources in the JVM. Since MBeans represent resources within the JVM, we can use them to manage specific aspects of the application, or more commonly, to collect statistical data related to the use of these resources.

<!-- markdownlint-enable -->

The core of JMX is an MBean server, which can serve as a medium to connect MBeans, applications within the same JVM, and the external world. Any interaction with MBeans is completed through this server. Generally speaking, only Java code can directly access the JMX API, but there are some adapters that can convert the API to a standard protocol, such as Jolokia that can convert it to HTTP.

JMX can achieve external export of the internal runtime data state of VMs. We encapsulate the runtime data into MBeans, manage it uniformly through JMX Server, and allow external programs to obtain data through RMI.

In summary, JMX allows runtime data to be obtained by external programs through the RMI protocol. This provides a window for us to monitor and manipulate the internal data of the VM.

## Common methods for collecting JVM metrics

1. [Statsd collect](jmx.md#statsd)
2. [JMX Exporter collect](jmx.md#jmx-exporter)
3. [Jolokia collect](jmx.md#jolokia)
4. [Micrometer collect](jmx.md#micrometer)
5. APM Agent: SkyWalking、OpenTelemetry etc.

![jvm_collector_1](./imgs/jvm_collector_1.png)

### StatsD collect

StatsD is actually a daemon that listens to UDP (default) or TCP, collects data sent by Statsd clients based on a simple protocol, aggregates it, and periodically pushes it to the backend, such as Graphite and Influxdb, before displaying it through the observability platform.

Nowadays, it usually refers to the StatsD system, which includes three parts: client, server, and backend. The client is embedded in the application code and reports the corresponding metrics to the StatsD server.

DataKit can serve as a StatsD server to receive data sent by clients.

![jvm_statsd](./imgs/jvm_statsd_1.png)


[StatsD collect](jvm_statsd.md)

### JMX Exporter collect

The JMX Exporter utilizes Java's JMX mechanism to read some monitoring data from the JVM runtime, and then converts it into the Metrics format recognized by Prometheus, so that Prometheus can monitor and collect it.

<!-- markdownlint-disable MD046 -->
???+ info "JMX Exporter"

    The JMX Exporter runs as a Java agent, exposing local JVM metrics through the HTTP port. It can also run as an independent HTTP service and obtain remote JMX targets, but this has many drawbacks, such as difficulty in configuration and inability to expose process metrics (such as memory and CPU usage). Therefore, it is strongly recommended to run JMX Exporter as a Java Agent.

<!-- markdownlint-enable -->

[JMX Exporter collect](jvm_jmx_exporter.md)

### Jolokia collect

Jolokia, as the most mainstream JMX monitoring component currently, is adopted by the Spring community (SpringBoot, MVC, cloud) and mainstream middleware services as JMX monitoring. Jolokia is untyped data and uses JSON, a lightweight serialization scheme, to replace the RMI scheme.

Jolokia is fully compatible and supports JMX components. It can be embedded as an 'agent' in any JAVA program, especially in web applications. It transforms complex and difficult to understand MBean Filter query statements into an HTTP request paradigm that is easier to implement and operate. Not only does Jolokia shield the development difficulties of RMI, but it also achieves transparency in external monitoring components and is easier to test and use.

<!-- markdownlint-disable MD046 -->
???+ info "Jolokia"

    Jolokia is used to solve the problems encountered in JMX data acquisition, such as RMI protocol complexity, inconvenient MBean queries, database serialization, and hosting of MBeanServer. We only need to use HTTP requests to directly access the same port as the WEB service to obtain JMX data.

<!-- markdownlint-enable -->

Jolokia provides two ways to obtain JMX data.

> Load with application startup through the 'javaagent' method

![jvm_jolokia_1](./imgs/jvm_jolokia_1.png)

> Run the agent independently through an agent

![jvm_jolokia_2](./imgs/jvm_jolokia_2.png)

[Jolokia JVM collect](jvm.md#jvm-jolokia)

### Micrometer collect

The above solutions do not support defining business metric exposure. Business metric definition needs to be encoded and defined before it can be exposed, that is, it needs to be completed through SDK.

[JVM Micrometer collect](jvm_micrometer.md)


### APM Agent

**The APM Agent** is based on APM and introduces Metric as an observable part. Taking SkyWalking as an example, metric information is exposed through docking with JMX.

<!-- TODO: page 404
[SkyWalking collects JVM observable best practices](../best-practices/monitoring/skywalking-jvm.md)
-->

[OpenTelemetry metrics collect](opentelemetry.md#opentelemetry_1)
