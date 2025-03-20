---
title     : 'OpenTelemetry Java'
summary   : 'OpenTelemetry Java Integration'
tags      :
  - 'JAVA'
  - 'OTEL'
  - 'APM'
__int_icon: 'icon/opentelemetry'
---


Before sending Trace to Datakit using OTEL, please ensure that you have [configured the collector](opentelemetry.md).

Configuration: [Datakit Configure OTEL](opentelemetry.md)

## Add Dependencies {#dependencies}

Add dependencies in pom.xml

``` xml
<!-- Add opentelemetry -->
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
<!-- Use grpc protocol -->
<dependency>
    <groupId>io.grpc</groupId>
    <artifactId>grpc-protobuf</artifactId>
    <version>1.36.1</version>
</dependency>
```

## Java Agent Form {#with-agent}

There are multiple ways to start the Agent; next, we will introduce how to start it via environment variables, command line, and Tomcat configuration.

- Start with environment variables

```shell
export JAVA_OPTS="-javaagent:PATH/TO/opentelemetry-javaagent.jar"
export OTEL_TRACES_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317"
```

- Start with command line

```shell
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
    -Dotel.traces.exporter=otlp \
    -Dotel.exporter.otlp.endpoint=http://localhost:4317 \
    -jar your-server.jar
```

- Tomcat configuration form

```shell
cd <local tomcat installation directory>
cd bin

vim catalina.sh

# Add on the second line
CATALINA_OPTS="$CATALINA_OPTS -javaagent:PATH/TO/opentelemetry-javaagent.jar -Dotel.traces.exporter=otlp -Dotel.exporter.otlp.endpoint=http://localhost:4317"; export CATALINA_OPTS

# Restart Tomcat
```

When configuring the field `exporter.otlp.endpoint`, you can omit the configuration and use the default value (localhost:4317), as Datakit and the Java program are on the same HOST, and the default port is also 4317.

## Java 2: Code Injection Form {#with-code}

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
                    .setEndpoint("http://127.0.0.1:4317")   // When configuring the .setEndpoint parameter, you must add https or http
                    .setTimeout(2, TimeUnit.SECONDS)
                    //.addHeader("header1", "1") // Add header
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
            sleep(500);    // delay for 1 second
            for (int i = 0; i < 10; i++) {
                Span childSpan1 = tracer.spanBuilder("child")
                        .setParent(Context.current().with(parentSpan))
                        .startSpan();
                sleep(1000);    // delay for 1 second
                System.out.println(i);
                childSpan1.end();
            }
            childSpan.end();
            childSpan.end(0, TimeUnit.NANOSECONDS);
            System.out.println("span end");
            sleep(1000);    // delay for 1 second
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

## View Effects {#view}

After logging into [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/tracing/service/table?time=15m){:target="_blank"}, view 「APM -> APM -> Click a single trace」

![avatar](imgs/otel-java-example.png)

In the flame graph, you can see the execution time and call flow of each module.

## References {#more-readings}

- [OpenTelemetry Java Source Code Example](https://github.com/open-telemetry/opentelemetry-java){:target="_blank"}
- [Official Documentation](https://opentelemetry.io/docs/instrumentation/go/getting-started/){:target="_blank"}