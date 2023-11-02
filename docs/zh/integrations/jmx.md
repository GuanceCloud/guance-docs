---
title     : 'JMX'
summary   : 'JVM 性能指标展示：堆与非堆内存、线程、类加载数等。'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JMX
<!-- markdownlint-enable -->

## JMX 定义

<!-- markdownlint-disable MD046 -->
???+ info "JMX 定义"

    Java 虚拟机 (JVM) 提供操作管理和监测提供了一套完整框架，即 JMX（Java 管理扩展），JMX 是 Java Management Extensions 的缩写，是管理 Java 的一种扩展框架，JMX 技术定义了完整的架构和设计模式集合，以对 Java 应用进行监测和管理。JMX 的基础是托管豆（managed bean，业内更习惯将其称为 MBean），MBean 是通过依赖注入完成实例化的各个类别，代表着 JVM 中的资源。由于 MBean 代表 JVM 中的资源，所以我们可以用其来管理应用的特定方面，或者更为常见的一种做法，用其来收集与这些资源的使用相关的统计数据。

<!-- markdownlint-enable -->

JMX 的核心是 MBean 服务器，此类服务器可以作为媒介将 MBean、同一 JVM 内的应用以及外部世界联系在一起。与 MBean 之间的任何交互都是通过此服务器完成的。通常而言，只有 Java 代码能够直接访问 JMX API，但是有一些适配器可将该 API 转换为标准协议，例如 Jolokia 便可将其转换为 HTTP。

JMX 可以实现 VM 内部运行时数据状态的对外 export，我们通过将运行态数据封装成 MBean，通过 JMX Server 统一管理，并允许外部程序通过 RMI 方式获取数据。

总之，JMX 允许运行态数据通过 RMI 协议被外部程序获取。这对我们监控、操作 VM 内部数据提供窗口。


## 常见的几种 JVM 指标采集方式

1. [Statsd 采集](jmx.md#statsd)
2. [JMX Exporter 采集](jmx.md#jmx-exporter)
3. [Jolokia 采集](jmx.md#jolokia)
4. [Micrometer 采集](jmx.md#micrometer)
5. APM Agent: SkyWalking、OpenTelemetry 等

![jvm_collector_1](./imgs/jvm_collector_1.png)

### StatsD 采集

StatsD 其实就是一个监听 UDP（默认）或者 TCP 的守护程序，根据简单的协议收集 statsd 客户端发送来的数据，聚合之后，定时推送给后端，如 graphite 和 influxdb 等，再通过可观测性平台进行展示。

现在通常指 StatsD 系统，包括客户端（client）、服务器（server）和后端（backend）三部分。客户端植入于应用代码中，将相应的 metrics 上报给 StatsD server。

DataKit 可以作为 StatsD server，来接收客户端发送过来的数据。

![jvm_statsd](./imgs/jvm_statsd_1.png)


[StatsD 集成](jvm_statsd.md)

### JMX Exporter 采集

JMX Exporter 利用 Java 的 JMX 机制来读取 JVM 运行时的一些监控数据，然后将其转换为 Prometheus 所认知的 Metrics 格式，以便让 Prometheus 对其进行监控采集。

<!-- markdownlint-disable MD046 -->
???+ info "JMX Exporter"

    JMX Exporter 会作为 Java 的 Agent 运行，通过 HTTP 端口暴露本地 JVM 的指标。它也可以作为一个独立的 HTTP 服务运行，并获取远程 JMX 目标，但这样做有很多缺点，比如难以配置和无法暴露进程指标(例如，内存和CPU使用情况)。因此强烈建议将 JMX Exporter 作为 Java Agent 运行。
<!-- markdownlint-enable -->

[JMX Exporter 采集](jvm_jmx_exporter.md)

### Jolokia 采集

Jolokia 作为目前最主流的 JMX 监控组件，Spring 社区（SpringBoot、MVC、cloud）以及目前主流的中间件服务均采用它作为 JMX 监控，Jolokia 是无类型的数据，使用了 JSON 这种轻量化的序列化方案来替代 RMI 方案。

Jolokia 完全兼容并支撑 JMX 组件，它可以作为 `agent` 嵌入到任何 JAVA 程序中，特别是 WEB 应用，它将复杂而且难以理解的 MBean Filter 查询语句，转换成更易于实施和操作的 HTTP 请求范式，不仅屏蔽了 RMI 的开发困难问题，还实现了对外部监控组件的透明度，而且更易于测试和使用。

<!-- markdownlint-disable MD046 -->
???+ info "Jolokia"

    Jolokia 就是用于解决 JMX 数据获取时，所遇到的 RMI 协议复杂性、MBean 查询的不便捷、数据库序列化、MBeanServer 的托管等问题。我们只需要使用 HTTP 请求，直接访问与 WEB 服务相同的 port 即可获取 JMX 数据。

<!-- markdownlint-enable -->

Jolokia 提供了两种方式来获取 JMX 数据。

> 通过 `javaagent` 方式，随应用程序启动时加载。

![jvm_jolokia_1](./imgs/jvm_jolokia_1.png)

> 通过代理的方式，独立运行 Agent。

![jvm_jolokia_2](./imgs/jvm_jolokia_2.png)


[Jolokia JVM 采集](jvm.md#jvm-jolokia)

### Micrometer 采集

以上几种方案都不支持定义业务指标暴露，业务指标定义需进行编码定义后方可暴露出来，即需要通过 SDK 的方式来完成。

[JVM Micrometer 采集](jvm_micrometer.md)


### APM 厂商集成

**APM 厂商** 以 APM 为基石，引入 Metric 作为可观测的一部分，以 SkyWalking 为例，通过对接 JMX 暴露 Metric 信息。

[SkyWalking 采集 JVM 可观测最佳实践](../best-practices/monitoring/skywalking-jvm.md)


[OpenTelemetry 指标采集](opentelemetry.md#opentelemetry_1)
