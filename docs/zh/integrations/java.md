---
title     : 'JAVA'
summary   : '获取 JAVA 应用的指标、链路追踪和日志信息'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JAVA
<!-- markdownlint-enable -->

使用{{{ custom_key.brand_name }}}链接到 JAVA 应用程序：

- 从应用当中收集自定义指标数据；
- 从应用中收集链路追踪数据；
- 管理应用的所有日志。

## 配置 {#config}

### 指标采集

可以查看 [jvm 文档](jvm.md)

### 链路追踪采集

应用开启对应***采集器***，然后使用 JAVA agent 工具获取 traces 信息发送到{{{ custom_key.brand_name }}}。
<!-- markdownlint-disable MD046 -->
=== "OpenTelemetry"

    [OpenTelemetry 采集器](opentelemetry.md)

=== "DDTrace"

    [DDTrace 采集器](ddtrace.md)

=== "SkyWalking"

    [SkyWalking 采集器](skywalking.md)

=== "Jaeger"

    [Jaeger 采集器](jaeger.md)

=== "Zipkin"

    [Zipkin 采集器](zipkin.md)

=== "CAT"

    [CAT 采集器](cat.md)

=== "Pinpoint"

    [Pinpoint 采集器](pinpoint.md)
<!-- markdownlint-enable -->
## 日志关联 {#logging}

`opentelemetry-java`（以下简称“Agent”）通过 `javaagent` 方式注入到应用当中，应用产生 trace 信息后，通过设置 MDC 可以把 `traceId` 和 `spanId`作为参数传递给`log`，这样`log`在输出的时候便会带上`traceId`和`spanId` 。
<!-- markdownlint-disable MD046 -->
???+ info "关于 MDC"

    映射诊断上下文 (MDC) 是一种用于区分来自不同来源的交错日志输出的工具。— [log4j MDC 文档](http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/MDC.html)
<!-- markdownlint-enable -->
它包含线程本地上下文信息，并将其复制到日志库捕获的每个日志事件中。

OTEL JAVA Agent 将有关当前跨度的几条信息注入到每个日志记录事件的 MDC 副本中：

- ***trace_id*** 当前跟踪 id（与 相同`Span.current().getSpanContext().getTraceId()`）；
- ***span_id*** 当前跨度 id（与 相同`Span.current().getSpanContext().getSpanId()`）；
- ***trace_flags*** 当前跟踪标志，根据 W3C 跟踪标志格式（与 相同`Span.current().getSpanContext().getTraceFlags().asHex()`）格式化。

这三条信息可以包含在日志库生成的日志语句中，方法是在模式/格式中指定它们。

提示：对于使用`logback`的 SpringBoot 配置，您可以通过仅覆盖以下内容将 MDC 添加到日志行`logging.pattern.level`：

```bash
logging.pattern.level = trace_id=%mdc{trace_id} span_id=%mdc{span_id} trace_flags=%mdc{trace_flags} %5p
```

这样，解析应用程序日志的任何服务或工具都可以将跟踪/跨度与日志语句相关联。

### 日志配置

不同 APM 工具配置日志 `pattern` 有差异，以 `logback.xml` 为例：
<!-- markdownlint-disable MD046 -->
=== "OpenTelemetry"

    OpenTelemetry MDC 参数：

    - trace_id
    - span_id

    ```xml
    <property name="log.pattern" value="%d{HH:mm:ss} [%thread] %-5level %logger{10} [traceId=%X{trace_id} spanId=%X{span_id} userId=%X{user-id}] %msg%n" />

    <!-- %m输出的信息,%p日志级别,%t线程名,%d日期,%c类的全名,,,, -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>
    ```

=== "DDTrace"

    DDTrace MDC参数：

    - dd.service
    - dd.trace_id
    - dd.span_id

    ```xml
    <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />

    <!-- %m输出的信息,%p日志级别,%t线程名,%d日期,%c类的全名,,,, -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>-
    ```
<!-- markdownlint-enable -->

## 参考文档 {#faq}

[**DDTrace Log**](https://docs.guance.com/best-practices/insight/ddtrace-skill-log/)

[**springboot-ddtrace-server**](https://github.com/lrwh/observable-demo/blob/main/springboot-ddtrace-server/src/main/resources/logback-spring.xml)

[**springboot-opentelemetry-otlp-server**](https://github.com/lrwh/observable-demo/blob/main/springboot-opentelemetry-otlp-server/src/main/resources/logback-spring.xml)

