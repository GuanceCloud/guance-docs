# OpenTelemetry Agent for JAVA 参数配置


## 使用环境变量配置规范

在某些环境中，更喜欢通过环境变量进行配置。任何可使用系统属性配置的设置也可以使用环境变量进行配置。下面的许多设置包括这两个选项，但它们不应用以下步骤来确定所需系统属性的正确名称映射：

1. 将系统属性转换为大写。
2. 将所有`.`和`-`字符替换为`_`.
例如`otel.instrumentation.common.default-enabled` 将转换为 `OTEL_INSTRUMENTATION_COMMON_DEFAULT_ENABLED`.

## 启动

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-guance.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4317 \
-Dotel.resource.attributes=service.name=springboot \
-jar springboot-server.jar
```

## 禁用 Agent

默认是启用，如果需要关闭，则设置为 `false`。

> -Dotel.javaagent.enabled=false


## 开启 `debug` 日志

> -Dotel.javaagent.debug=true

```txt
[otel.javaagent 2024-02-19 10:25:25:909 +0800] [main] INFO io.opentelemetry.javaagent.tooling.VersionLogger - opentelemetry-javaagent - version: 1.26.1-guance
[otel.javaagent 2024-02-19 10:25:25:911 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.VersionLogger - Running on Java 11.0.18. JVM Java HotSpot(TM) 64-Bit Server VM - Oracle Corporation - 11.0.18+9-LTS-195
[otel.javaagent 2024-02-19 10:25:25:911 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.AgentInstaller - io.opentelemetry.javaagent.tooling.AgentInstaller loaded on io.opentelemetry.javaagent.bootstrap.AgentClassLoader@6cc4c815
[otel.javaagent 2024-02-19 10:25:25:924 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.SafeServiceLoader - Unable to load instrumentation class: io/opentelemetry/javaagent/shaded/instrumentation/javaagent/runtimetelemetryjfr/RuntimeMetricsInstallerJfr has been compiled by a more recent version of the Java Runtime (class file version 61.0), this version of the Java Runtime only recognizes class file versions up to 55.0
[otel.javaagent 2024-02-19 10:25:26:098 +0800] [main] DEBUG io.opentelemetry.sdk.internal.JavaVersionSpecific - Using the APIs optimized for: Java 9+
[otel.javaagent 2024-02-19 10:25:26:584 +0800] [main] DEBUG io.opentelemetry.sdk.autoconfigure.AutoConfiguredOpenTelemetrySdkBuilder - Global OpenTelemetry set to OpenTelemetrySdk{tracerProvider=SdkTracerProvider{clock=SystemClock{}, idGenerator=RandomIdGenerator{}, resource=Resource{schemaUrl=https://opentelemetry.io/schemas/1.19.0, attributes={host.arch="amd64", host.name="liurui", os.description="Linux 5.15.0-92-generic", os.type="linux", process.command_line="/home/liurui/middleware/jdk/jdk-11.0.18/bin/java -javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar -Dotel.traces.exporter=otlp -Dotel.exporter.otlp.endpoint=http://localhost:4317 -Dotel.resource.attributes=service.name=springboot -Dotel.javaagent.debug=true -XX:TieredStopAtLevel=1 -Xverify:none -Dspring.output.ansi.enabled=always -Dcom.sun.management.jmxremote -Dspring.jmx.enabled=true -Dspring.liveBeansView.mbeanDomain -Dspring.application.admin.enabled=true -Dmanagement.endpoints.jmx.exposure.include=* -javaagent:/home/liurui/middleware/idea-IU-231.9161.38/lib/idea_rt.jar=39689:/home/liurui/middleware/idea-IU-231.9161.38/bin -Dfile.encoding=UTF-8 com.zy.observable.server.ServerApplication", process.executable.path="/home/liurui/middleware/jdk/jdk-11.0.18/bin/java", process.pid=11464, process.runtime.description="Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 11.0.18+9-LTS-195", process.runtime.name="Java(TM) SE Runtime Environment", process.runtime.version="11.0.18+9-LTS-195", service.name="springboot", telemetry.auto.version="1.26.1-guance", telemetry.sdk.language="java", telemetry.sdk.name="opentelemetry", telemetry.sdk.version="1.26.0"}}, spanLimitsSupplier=SpanLimitsValue{maxNumberOfAttributes=128, maxNumberOfEvents=128, maxNumberOfLinks=128, maxNumberOfAttributesPerEvent=128, maxNumberOfAttributesPerLink=128, maxAttributeValueLength=2147483647}, sampler=ParentBased{root:AlwaysOnSampler,remoteParentSampled:AlwaysOnSampler,remoteParentNotSampled:AlwaysOffSampler,localParentSampled:AlwaysOnSampler,localParentNotSampled:AlwaysOffSampler}, spanProcessor=MultiSpanProcessor{spanProcessorsStart=[io.opentelemetry.javaagent.tooling.AddThreadDetailsSpanProcessor@74287ea3], spanProcessorsEnd=[BatchSpanProcessor{spanExporter=io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter@7d7758be, scheduleDelayNanos=5000000000, maxExportBatchSize=512, exporterTimeoutNanos=30000000000}, SimpleSpanProcessor{spanExporter=io.opentelemetry.exporter.logging.LoggingSpanExporter@2bdd8394}], spanProcessorsAll=[BatchSpanProcessor{spanExporter=io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter@7d7758be, scheduleDelayNanos=5000000000, maxExportBatchSize=512, exporterTimeoutNanos=30000000000}, io.opentelemetry.javaagent.tooling.AddThreadDetailsSpanProcessor@74287ea3, SimpleSpanProcessor{spanExporter=io.opentelemetry.exporter.logging.LoggingSpanExporter@2bdd8394}]}}, meterProvider=SdkMeterProvider{clock=SystemClock{}, resource=Resource{schemaUrl=https://opentelemetry.io/schemas/1.19.0, attributes={host.arch="amd64", host.name="liurui", os.description="Linux 5.15.0-92-generic", os.type="linux", process.command_line="/home/liurui/middleware/jdk/jdk-11.0.18/bin/java -javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar -Dotel.traces.exporter=otlp -Dotel.exporter.otlp.endpoint=http://localhost:4317 -Dotel.resource.attributes=service.name=springboot -Dotel.javaagent.debug=true -XX:TieredStopAtLevel=1 -Xverify:none -Dspring.output.ansi.enabled=always -Dcom.sun.management.jmxremote -Dspring.jmx.enabled=true -Dspring.liveBeansView.mbeanDomain -Dspring.application.admin.enabled=true -Dmanagement.endpoints.jmx.exposure.include=* -javaagent:/home/liurui/middleware/idea-IU-231.9161.38/lib/idea_rt.jar=39689:/home/liurui/middleware/idea-IU-231.9161.38/bin -Dfile.encoding=UTF-8 com.zy.observable.server.ServerApplication", process.executable.path="/home/liurui/middleware/jdk/jdk-11.0.18/bin/java", process.pid=11464, process.runtime.description="Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 11.0.18+9-LTS-195", process.runtime.name="Java(TM) SE Runtime Environment", process.runtime.version="11.0.18+9-LTS-195", service.name="springboot", telemetry.auto.version="1.26.1-guance", telemetry.sdk.language="java", telemetry.sdk.name="opentelemetry", telemetry.sdk.version="1.26.0"}}, metricReaders=[PeriodicMetricReader{exporter=io.opentelemetry.exporter.otlp.metrics.OtlpGrpcMetricExporter@68746f22, intervalNanos=60000000000}], views=[]}, loggerProvider=SdkLoggerProvider{clock=SystemClock{}, resource=Resource{schemaUrl=https://opentelemetry.io/schemas/1.19.0, attributes={host.arch="amd64", host.name="liurui", os.description="Linux 5.15.0-92-generic", os.type="linux", process.command_line="/home/liurui/middleware/jdk/jdk-11.0.18/bin/java -javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar -Dotel.traces.exporter=otlp -Dotel.exporter.otlp.endpoint=http://localhost:4317 -Dotel.resource.attributes=service.name=springboot -Dotel.javaagent.debug=true -XX:TieredStopAtLevel=1 -Xverify:none -Dspring.output.ansi.enabled=always -Dcom.sun.management.jmxremote -Dspring.jmx.enabled=true -Dspring.liveBeansView.mbeanDomain -Dspring.application.admin.enabled=true -Dmanagement.endpoints.jmx.exposure.include=* -javaagent:/home/liurui/middleware/idea-IU-231.9161.38/lib/idea_rt.jar=39689:/home/liurui/middleware/idea-IU-231.9161.38/bin -Dfile.encoding=UTF-8 com.zy.observable.server.ServerApplication", process.executable.path="/home/liurui/middleware/jdk/jdk-11.0.18/bin/java", process.pid=11464, process.runtime.description="Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 11.0.18+9-LTS-195", process.runtime.name="Java(TM) SE Runtime Environment", process.runtime.version="11.0.18+9-LTS-195", service.name="springboot", telemetry.auto.version="1.26.1-guance", telemetry.sdk.language="java", telemetry.sdk.name="opentelemetry", telemetry.sdk.version="1.26.0"}}, logLimits=LogLimits{maxNumberOfAttributes=128, maxAttributeValueLength=2147483647}, logRecordProcessor=io.opentelemetry.sdk.logs.NoopLogRecordProcessor@7fd7a283}, propagators=DefaultContextPropagators{textMapPropagator=MultiTextMapPropagator{textMapPropagators=[W3CTraceContextPropagator, W3CBaggagePropagator]}}} by autoconfiguration
[otel.javaagent 2024-02-19 10:25:26:873 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.AgentInstaller - Loading extension instrumentation-loader [class io.opentelemetry.javaagent.tooling.instrumentation.InstrumentationLoader]
[otel.javaagent 2024-02-19 10:25:26:959 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.SafeServiceLoader - Unable to load instrumentation class: io/opentelemetry/javaagent/instrumentation/spring/jms/v6_0/SpringJmsInstrumentationModule has been compiled by a more recent version of the Java Runtime (class file version 61.0), this version of the Java Runtime only recognizes class file versions up to 55.0
[otel.javaagent 2024-02-19 10:25:27:010 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.SafeServiceLoader - Unable to load instrumentation class: io/opentelemetry/javaagent/instrumentation/spring/webmvc/v6_0/SpringWebMvcInstrumentationModule has been compiled by a more recent version of the Java Runtime (class file version 61.0), this version of the Java Runtime only recognizes class file versions up to 55.0
[otel.javaagent 2024-02-19 10:25:27:011 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.instrumentation.InstrumentationLoader - Loading instrumentation opentelemetry-instrumentation-annotations [class io.opentelemetry.javaagent.instrumentation.instrumentationannotations.AnnotationInstrumentationModule]
[otel.javaagent 2024-02-19 10:25:27:031 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.instrumentation.InstrumentationLoader - Loading instrumentation opentelemetry-api [class io.opentelemetry.javaagent.instrumentation.opentelemetryapi.v1_15.OpenTelemetryApiInstrumentationModule]
[otel.javaagent 2024-02-19 10:25:27:032 +0800] [main] DEBUG io.opentelemetry.javaagent.tooling.instrumentation.InstrumentationLoader - Loading instrumentation opentelemetry-api [class io.opentelemetry.javaagent.instrumentation.opentelemetryapi.v1_10.OpenTelemetryApiInstrumentationModule]
```


***开启 debug 后，日志会输出到 console 及应用配置的日志文件中（如果应用配置了日志文件输出）**。*

## 数据库脱敏

agent 在设置 `db.statement` 语义属性之前清理所有数据库查询/语句。查询字符串中的所有值（字符串、数字）都替换为问号 ( ?)。

注意：JDBC 绑定参数不会在`db.statement`. 如果您正在寻找捕获绑定参数，请参阅[issue](https://github.com/open-telemetry/opentelemetry-java-instrumentation#7413)相应的问题。

例子：

- SQL 查询`SELECT a from b where password="secret"`将出现 `SELECT a from b where password=?`在导出的跨度中；
- Redis 命令`HSET map password "secret"`将出现 `HSET map password ?`在导出的跨度中。

默认情况下，所有数据库检测都启用此行为。使用以下属性禁用它：

系统属性： otel.instrumentation.common.db-statement-sanitizer.enabled
环境变量： OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED
默认值：true
说明：启用 DB 语句清理。

## 抑制跨度
***建议开启 `span-kind` 策略***

该代理检测的一些库反过来使用也被检测的较低级别的库。这通常会导致包含重复遥测数据的嵌套跨度。例如：

- Reactor Netty HTTP 客户端工具生成的跨度将具有由 Netty 工具生成的重复 HTTP 客户端跨度；
- 由 AWS SDK 检测生成的 Dynamo DB 跨度将具有由其内部 HTTP 客户端库（也被检测）生成的子 HTTP 客户端跨度；
- 由 Tomcat 工具生成的跨度将具有由通用 Servlet API 工具生成的重复 HTTP 服务器跨度。

javaagent 通过检测和抑制重复遥测数据的嵌套跨度来防止这些情况。可以使用以下配置选项配置抑制行为：

**系统属性**： `otel.instrumentation.experimental.span-suppression-strategy`
**说明**：javaagent 跨度抑制策略。支持以下 3 种策略：

    - `semconv`：代理将抑制重复的语义约定。这是 javaagent 的默认行为。
    - `span-kind`：代理将抑制具有相同类型（除了`INTERNAL`）的跨度。
    - `none`: 代理根本不会压制任何东西。我们不建议将此选项用于调试目的以外的任何用途，因为它会生成大量重复的遥测数据。
例如，假设我们检测一个内部使用 Reactor Netty HTTP 客户端的数据库客户端；反过来使用 Netty。

使用默认`semconv`抑制策略会导致 2 个嵌套 `CLIENT`跨度：

- `CLIENT` 具有数据库客户端工具发出的数据库客户端语义属性的跨度；
- `CLIENT` span 具有 Reactor Netty 工具发出的 HTTP 客户端语义属性。
Netty 检测将被抑制，因为它复制了 Reactor Netty HTTP 客户端检测。

使用抑制策略`span-kind`只会产生一个跨度：

`CLIENT` 跨度与数据库客户端检测发出的数据库客户端语义属性。
Reactor Netty 和 Netty 仪器都将被抑制，因为它们也会发出 `CLIENT` 跨度。

最后，使用抑制策略`none`会产生 3 个跨度：

- `CLIENT` 具有数据库客户端工具发出的数据库客户端语义属性的跨度；
- `CLIENT` span 具有 Reactor Netty 工具发出的 HTTP 客户端语义属性；
- `CLIENT` span 具有 Netty 工具发出的 HTTP 客户端语义属性。

## 传播器（Propagator）配置

传播器用于兼容多个类型的 APM 框架链路数据，可以用参数或者环境变量的方式调整传播器类型：

- `-Dotel.propagators`：默认传播器为`tracecontext,baggage`(W3C).
- `OTEL_PROPAGATORS`

当前支持以下类型的传播器

- "tracecontext": W3C Trace Context (add baggage as well to include W3C baggage)
- "baggage": W3C Baggage
- "b3": B3 Single
- "b3multi": B3 Multi
- "jaeger": Jaeger (includes Jaeger baggage)
- "xray": AWS X-Ray
- "ottrace": OT Trace

了解传播器原理可参考文档[链路传播（Propagate）机制及使用场景](https://juejin.cn/post/7254125867177443365)

## 函数追踪

在无法修改代码的情况下，OpenTelemetry 提供了以下配置 Java 代理来捕获特定方法的跨度。

- 参数方式：`-Dotel.instrumentation.methods.include`
- 环境变量方式：`OTEL_INSTRUMENTATION_METHODS_INCLUDE`

需要注意的是，OpenTelemetry 不支持同配符的方式进行配置。

例：
`-Dotel.instrumentation.methods.include="com.zy.observable.server.service.TestService[users]"`，表示对`TestService`的`users`添加链路追踪。

[如何利用 APM 追踪完整的类函数调用](https://juejin.cn/post/7324084744525168681)

## 函数入参追踪

默认情况下，链路可以获取到函数的调用情况，但无法获取函数的入参信息，通过以下配置可以获取到函数入参信息

`-Dotel.instrumentation.methods.attribute.enabled`，默认值为 `false`


## 上报协议

OpenTelemetry 支持三种数据协议： `gRPC` ， `http/protobuf` 和 `http/json`，通过以下方式可以调整协议：

- `-Dotel.exporter.otlp.protocol=grpc`
- `OTEL_EXPORTER_OTLP_PROTOCOL`

DataKit 根据上报协议的不同，参数配置有差异。

```shell
# OpenTelemetry gPRC 协议发送到 Datakit
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=grpc \
-Dotel.exporter.otlp.endpoint=http://datakit-endpoint:4317

# 使用 http/protobuf 方式
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/protobuf \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric 

# 使用 http/json 方式
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/json \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric

```

**OpenTelemetry 部分版本上报协议有差异，建议手动配置上。**


## 参考文档

[opentelemetry java 配置](https://opentelemetry.io/docs/instrumentation/java/automatic/agent-config/)

[opentelemetry-java 扩展配置](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md)


[Opentelemetry Agent 增强版](<<< homepage >>>/integrations/otel-ext-changelog/)
