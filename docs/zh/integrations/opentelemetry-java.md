---
title     : 'OpenTelemetry Java'
summary   : 'OpenTelemetry Java 集成'
tags      :
  - 'JAVA'
  - 'OTEL'
  - '链路追踪'
__int_icon: 'icon/opentelemetry'
---


在使用 OTEL 发送 Trace 到 Datakit 之前，请先确定您已经[配置好了采集器](opentelemetry.md)。

配置：[Datakit 配置 OTEL](opentelemetry.md)

## 添加依赖 {#dependencies}

在 pom.xml 中添加依赖

``` xml
<!-- 加入 opentelemetry  -->
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-sdk</artifactId>
    <version>1.9.0</version>
</dependency>
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-exporter-otlp</artifactId>
    <version>1.9.0</version>
</dependency>
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-netty-shaded</artifactId>
    <version>1.41.0</version>
</dependency>
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-semconv</artifactId>
    <version>1.9.0-alpha</version>
</dependency>
<!-- 使用 grpc 协议 -->
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-protobuf</artifactId>
    <version>1.36.1</version>
</dependency>
```

## Java agent 形式 {#with-agent}

您有多种方式启动 Agent ，接下来介绍如何通过环境变量方式、命令行方式和 Tomcat 配置方式。

- 环境变量形式启动

```shell
export JAVA_OPTS="-javaagent:PATH/TO/opentelemetry-javaagent.jar"
export OTEL_TRACES_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317"
```

- 命令行启动

```shell
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
    -Dotel.traces.exporter=otlp \
    -Dotel.exporter.otlp.endpoint=http://localhost:4317 \
    -jar your-server.jar
```

- Tomcat 配置形式

```shell
cd <本机 tomcat 安装目录>
cd bin

vim catalina.sh

# 添加在第二行
CATALINA_OPTS="$CATALINA_OPTS -javaagent:PATH/TO/opentelemetry-javaagent.jar -Dotel.traces.exporter=otlp -Dotel.exporter.otlp.endpoint=http://localhost:4317"; export CATALINA_OPTS

# 重启 Tomcat
```

在配置字段 `exporter.otlp.endpoint` 时，可以不用配置并使用默认值（localhost:4317），因为 Datakit 与 Java 程序在一台主机上，默认的端口也是 4317。

## Java 2：代码注入形式 {#with-code}

``` java
package com.example;

import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.common.Attributes;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.api.trace.propagation.W3CTraceContextPropagator;
import io.opentelemetry.context.Context;
import io.opentelemetry.context.propagation.ContextPropagators;
import io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter;
import io.opentelemetry.sdk.OpenTelemetrySdk;
import io.opentelemetry.sdk.resources.Resource;
import io.opentelemetry.semconv.resource.attributes.ResourceAttributes;
import io.opentelemetry.sdk.trace.SdkTracerProvider;
import io.opentelemetry.sdk.trace.export.BatchSpanProcessor;
import java.util.concurrent.TimeUnit;
import static java.lang.Thread.sleep;

public class otlpdemo {
    public static void main(String[] args) {
        try {
            OtlpGrpcSpanExporter grpcSpanExporter = OtlpGrpcSpanExporter.builder()
                    .setEndpoint("http://127.0.0.1:4317")   //配置 .setEndpoint 参数时，必须添加 https 或者 http
                    .setTimeout(2, TimeUnit.SECONDS)
                    //.addHeader("header1", "1") // 添加 header
                    .build();

            String s = grpcSpanExporter.toString();
            System.out.println(s);
            SdkTracerProvider tracerProvider = SdkTracerProvider.builder()
                    .addSpanProcessor(BatchSpanProcessor.builder(grpcSpanExporter).build())
                    .setResource(Resource.create(Attributes.builder()
                            .put(ResourceAttributes.SERVICE_NAME, "serviceForJAVA")
                            .put(ResourceAttributes.SERVICE_VERSION, "1.0.0")
                            .put(ResourceAttributes.HOST_NAME, "host")
                            .build()))
                    .build();

            OpenTelemetry openTelemetry = OpenTelemetrySdk.builder()
                    .setTracerProvider(tracerProvider)
                    .setPropagators(ContextPropagators.create(W3CTraceContextPropagator.getInstance()))
                    .buildAndRegisterGlobal();
            // .build();

            Tracer tracer = openTelemetry.getTracer("instrumentation-library-name", "1.0.0");
            Span parentSpan = tracer.spanBuilder("parent").startSpan();


            Span childSpan = tracer.spanBuilder("child")
                    .setParent(Context.current().with(parentSpan))
                    .startSpan();
            childSpan.setAttribute("tagsA", "vllelel");
            // do stuff
            sleep(500);    //延时 1 秒
            for (int i = 0; i < 10; i++) {
                Span childSpan1 = tracer.spanBuilder("child")
                        .setParent(Context.current().with(parentSpan))
                        .startSpan();
                sleep(1000);    //延时 1 秒
                System.out.println(i);
                childSpan1.end();
            }
            childSpan.end();
            childSpan.end(0, TimeUnit.NANOSECONDS);
            System.out.println("span end");
            sleep(1000);    // 延时 1 秒
            parentSpan.end();
            tracerProvider.shutdown();

        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            System.out.println("finally end");
        }
    }
}
```

## 查看效果 {#view}

登录 [<<<custom_key.brand_name>>>](https://console.<<<custom_key.brand_main_domain>>>/tracing/service/table?time=15m){:target="_blank"} 后查看 「应用性能监测 -> 链路 -> 点击单条链路」

![avatar](imgs/otel-java-example.png)

在火焰图中可看到每一个模块中执行的时间、调用流程等。

## 参考 {#more-readings}

- [OpenTelemetry Java 源码示例](https://github.com/open-telemetry/opentelemetry-java){:target="_blank"}
- [官方文档](https://opentelemetry.io/docs/instrumentation/go/getting-started/){:target="_blank"}
