# How to Use APM to Trace Complete Class Function Calls

Typically, after an application is integrated with APM, it can track the call chain between related components and services, such as Tomcat, Redis, MySQL, etc. This is because APM has instrumented standard components, allowing for better observation of how component calls impact the application during actual use.

In actual production environments, non-standard code, i.e., business code, often has a deeper impact on business operations. The understanding and coding abilities of developers also vary. For business code, tracing complete class function calls to identify key issues remains critical.

Fortunately, APM developers are well-trained professionals who have experienced similar challenges. They have set higher expectations for APM. DataDog and OpenTelemetry also provide relevant features, which we will explore in detail.

Let's take Java as an example and investigate DDTrace (DataDog) and OpenTelemetry.


## How to Use DDTrace to Trace Function Calls

Prepare a piece of code:

```java
    @Autowired
    private TestService testService;

    @GetMapping("/user")
    @ResponseBody
    public String getUser(){
        logger.info("do getUser");
        return testService.users();
    }

```

Service Interface:

```java
public interface TestService {

    String users();
}

```

Service Implementation Class:

```java
package com.zy.observable.server.service;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class TestServiceImpl implements TestService {
    private static final Logger logger = LoggerFactory.getLogger(TestServiceImpl.class);
    public String getUsername(){
        return "lr";
    }

    public String users(){
        Map<Integer, Student> users = new HashMap<>();
        users.put(1, new Student("tom", 18));
        users.put(2, new Student("joy", 20));
        users.put(3, new Student("lucy", 30));
        users.forEach((k, v) -> print(k, v));
        return getUsername();
    }

    public void print(Integer level, Student student){
        logger.info("level:{}, username:{}", level, student.getUsername());
    }
}
```

When the Controller layer calls `testService.users()`, by default, `users` does not appear as part of the trace. Run the following command:

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-jar springboot-server.jar
```
Or you can debug using the IDEA tool.


Request `http://localhost:8090/user`, and the effect seen on the [<<< custom_key.brand_name >>>](https://www.guance.com) platform is as follows:

![Img](../images/tracing_method_1.png)

You can observe the trace, which contains two spans.

To include the `users` method in the trace, DDTrace provides the following parameters to discover business code information.

- Parameter method: `-Ddd.trace.methods`
- Environment variable method: `DD_TRACE_METHODS`

Use the following command:

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[users]" \
-jar springboot-server.jar
```

On the [<<< custom_key.brand_name >>>](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_2.png)


If you want to trace all function calls within a class, use `*` to represent all methods.


```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[*]" \
-jar springboot-server.jar
```

On the [<<< custom_key.brand_name >>>](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_3.png)

Even though `TestService` only has one interface method, using the wildcard `*` still results in multiple span information.

You may have noticed an issue: `TestServiceImpl` provides three methods: `getUsername`, `users`, and `print`. Since `users` calls both `getUsername` and `print`, why does the trace show `print` but not `getUsername`?

- Why does the trace show `print`

This is because `TestServiceImpl` implements the `TestService` interface, and `*` represents all methods. DDTrace actually enhances the implementation class `TestServiceImpl`. It's equivalent to `-Ddd.trace.methods="com.zy.observable.server.service.TestServiceImpl[*]".

- Why does the trace not show `getUsername`

This is mainly because DDTrace filters out certain key methods, and the following types of methods are not enhanced:

- constructors
- getters
- setters
- synthetic
- toString
- equals
- hashcode
- finalizer method calls


It's worth noting that the `print` function appears three times in the trace because `users` is a Map collection that iterates three times, calling `print` each time. In some scenarios, this can be problematic. Imagine if the `users` collection had 1000 elements; `print` would generate 1000 spans. This increases both the cost of viewing traces and storage/query costs. Too many spans can lead to high browser memory usage and UI lag, while also increasing storage and query costs.


## How to Use OpenTelemetry to Trace Function Calls

Continuing with the same code, run the application without adding any parameters using the following command:

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
```

On the [<<< custom_key.brand_name >>>](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_4.png)

You can observe that the OpenTelemetry trace spans are basically consistent with those of DDTrace.

Without modifying the code, OpenTelemetry also provides the following configuration options to capture specific method spans using Java agents.

- Parameter method: `-Dotel.instrumentation.methods.include`
- Environment variable method: `OTEL_INSTRUMENTATION_METHODS_INCLUDE`

Note that OTel does not support wildcard configurations.

Run the following command:

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
-Dotel.instrumentation.methods.include="com.zy.observable.server.service.TestService[users]"
```

On the [<<< custom_key.brand_name >>>](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_5.png)

Similarly, the `users` function is also added to the span information.


## SDK Method

The above sections introduce how DDTrace and OpenTelemetry can trace specific business functions without modifying the code. They also provide SDK methods, which involve some code changes but offer more flexibility.

- DDTrace uses the `@Trace` annotation to configure business Spans. Refer to the [link](https://docs.guance.com/best-practices/insight/ddtrace-skill-api/#2) for actual usage and dependencies.
- OpenTelemetry uses the `@WithSpan` annotation to configure business Spans. Refer to the [link](https://github.com/lrwh/observable-demo/blob/main/springboot-opentelemetry-otlp-server/src/main/java/com/zy/observable/otel/controller/OtelController.java){:target="_blank"}

For SDK methods, we won't delve into detailed analysis here.

## Reference Documents

[DDTrace Agent Download](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}

[OpenTelemetry Agent Download](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases){:target="_blank"}

[OpenTelemetry Methods](https://opentelemetry.io/docs/instrumentation/java/automatic/annotations/#creating-spans-around-methods-with-otelinstrumentationmethodsinclude){:target="_blank"}

[SpringBoot-Server Demo](https://github.com/lrwh/observable-demo/tree/main/springboot-server){:target="_blank"}