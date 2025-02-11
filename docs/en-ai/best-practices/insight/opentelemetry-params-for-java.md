# OpenTelemetry Agent for JAVA Parameter Configuration

## Using Environment Variables Configuration Standards

In certain environments, configuration through environment variables is preferred. Any setting that can be configured using system properties can also be configured using environment variables. Many of the settings below include both options, but they should not apply the following steps to determine the correct name mapping for required system properties:

1. Convert system properties to uppercase.
2. Replace all `.` and `-` characters with `_`.
For example, `otel.instrumentation.common.default-enabled` will be converted to `OTEL_INSTRUMENTATION_COMMON_DEFAULT_ENABLED`.

## Startup

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-guance.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4317 \
-Dotel.resource.attributes=service.name=springboot \
-jar springboot-server.jar
```

## Disable Agent

By default, it is enabled. If you need to disable it, set it to `false`.

> -Dotel.javaagent.enabled=false


## Enable `debug` Logs

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

***After enabling debug, logs will be output to the console and application-configured log files (if the application has configured log file output).***

## Database Sanitization

The agent sanitizes all database queries/statements before setting the `db.statement` semantic attribute. All values in query strings (strings, numbers) are replaced with question marks (`?`).

Note: JDBC binding parameters are not included in `db.statement`. If you are looking to capture binding parameters, refer to the corresponding [issue](https://github.com/open-telemetry/opentelemetry-java-instrumentation#7413).

Examples:
- SQL query `SELECT a from b where password="secret"` will appear as `SELECT a from b where password=?` in the exported span;
- Redis command `HSET map password "secret"` will appear as `HSET map password ?` in the exported span.

By default, this behavior is enabled for all database detection. Use the following property to disable it:

System Property: `otel.instrumentation.common.db-statement-sanitizer.enabled`
Environment Variable: `OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED`
Default Value: `true`
Description: Enable DB statement sanitization.

## Suppress Spans
***It is recommended to enable the `span-kind` strategy***

Some libraries detected by the agent use lower-level libraries that are also detected, leading to nested spans containing duplicate telemetry data. For example:

- Spans generated by the Reactor Netty HTTP client tool will have duplicate HTTP client spans generated by the Netty tool;
- Dynamo DB spans generated by AWS SDK detection will have child HTTP client spans generated by its internal HTTP client library (which is also detected);
- Spans generated by the Tomcat tool will have duplicate HTTP server spans generated by the generic Servlet API tool.

The javaagent prevents these situations by detecting and suppressing nested spans with duplicate telemetry data. The suppression behavior can be configured using the following options:

**System Property**: `otel.instrumentation.experimental.span-suppression-strategy`
**Description**: Javaagent span suppression strategy. Supports the following three strategies:

    - `semconv`: The agent suppresses duplicate semantic conventions. This is the default behavior of the javaagent.
    - `span-kind`: The agent suppresses spans of the same type (except `INTERNAL`).
    - `none`: The agent does not suppress anything. We do not recommend using this option for any purpose other than debugging, as it generates a large amount of duplicate telemetry data.
For example, assume we detect a database client that internally uses the Reactor Netty HTTP client, which in turn uses Netty.

Using the default `semconv` suppression strategy results in two nested `CLIENT` spans:

- A `CLIENT` span with database client semantic attributes emitted by the database client instrumentation;
- A `CLIENT` span with HTTP client semantic attributes emitted by the Reactor Netty instrumentation.
Netty detection is suppressed because it duplicates the Reactor Netty HTTP client detection.

Using the `span-kind` suppression strategy results in only one span:

A `CLIENT` span with database client semantic attributes emitted by the database client instrumentation.
Reactor Netty and Netty instrumentation are suppressed because they also emit `CLIENT` spans.

Finally, using the `none` suppression strategy results in three spans:

- A `CLIENT` span with database client semantic attributes emitted by the database client instrumentation;
- A `CLIENT` span with HTTP client semantic attributes emitted by the Reactor Netty instrumentation;
- A `CLIENT` span with HTTP client semantic attributes emitted by the Netty instrumentation.

## Propagator Configuration

Propagators are used to support multiple types of APM framework link data, and can be adjusted via parameters or environment variables:

- `-Dotel.propagators`: Default propagators are `tracecontext,baggage` (W3C).
- `OTEL_PROPAGATORS`

Currently supported propagator types:

- "tracecontext": W3C Trace Context (add baggage to include W3C baggage)
- "baggage": W3C Baggage
- "b3": B3 Single
- "b3multi": B3 Multi
- "jaeger": Jaeger (includes Jaeger baggage)
- "xray": AWS X-Ray
- "ottrace": OT Trace

To understand propagator principles, refer to the document [Propagation Mechanism and Usage Scenarios](https://juejin.cn/post/7254125867177443365)

## Function Tracing

When code modification is not possible, OpenTelemetry provides the following configurations to capture spans for specific methods using the Java agent:

- Parameter method: `-Dotel.instrumentation.methods.include`
- Environment variable method: `OTEL_INSTRUMENTATION_METHODS_INCLUDE`

Note that OpenTelemetry does not support wildcard configurations.

Example:
`-Dotel.instrumentation.methods.include="com.zy.observable.server.service.TestService[users]"`, indicating adding tracing for `TestService`'s `users`.

[How to Use APM to Track Complete Class Function Calls](https://juejin.cn/post/7324084744525168681)

## Function Argument Tracing

By default, traces can capture function calls but cannot capture function arguments. To capture function arguments, configure the following:

`-Dotel.instrumentation.methods.attribute.enabled`, default value is `false`

## Reporting Protocol

OpenTelemetry supports three data protocols: `gRPC`, `http/protobuf`, and `http/json`. Adjust the protocol using the following methods:

- `-Dotel.exporter.otlp.protocol=grpc`
- `OTEL_EXPORTER_OTLP_PROTOCOL`

DataKit parameter configurations differ based on the reporting protocol.

```shell
# Send OpenTelemetry gRPC protocol to DataKit
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=grpc \
-Dotel.exporter.otlp.endpoint=http://datakit-endpoint:4317

# Use http/protobuf method
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/protobuf \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric 

# Use http/json method
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/json \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric
```

**Some versions of OpenTelemetry have different reporting protocols; manual configuration is recommended.**

## Reference Documents

[OpenTelemetry Java Configuration](https://opentelemetry.io/docs/instrumentation/java/automatic/agent-config/)

[OpenTelemetry-Java Extended Configuration](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md)

[Enhanced OpenTelemetry Agent](https://docs.guance.com/integrations/otel-ext-changelog/)