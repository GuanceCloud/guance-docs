# How to Use APM to Trace Complete Class Function Calls

Typically, after an application is integrated with APM, it can track the call chain situations between related components and services, such as Tomcat, Redis, MySQL, etc. This is because APM has instrumented standard components, thereby better observing the impact of component calls on the application during actual use.

In actual production processes, non-standard code, i.e., business code, often has a deeper impact on business operations. Different levels of developers have varying degrees of understanding and coding abilities. For business code, how to trace complete class function calls and identify critical issues remains crucial.

Fortunately, APM developers are also well-trained professionals who have experienced the challenges firsthand and have set higher expectations for APM. DataDog and OpenTelemetry also provide relevant features that allow us to delve into this.

Taking JAVA as an example, we will explore DDTrace (DataDog) and OpenTelemetry separately.


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

When the Controller layer calls `testService.users()`, by default, the `users` method does not appear as part of the trace. Run the following command:

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-jar springboot-server.jar
```
Or debug in the IDEA tool.

Request `http://localhost:8090/user`, and the effect seen on the [Guance](https://www.guance.com) platform is as follows:

![Img](../images/tracing_method_1.png)

You can observe the trace situation, which includes two spans.

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

Using the [Guance](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_2.png)

If you want to trace all function calls in a class, use `*` to represent all methods.

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[*]" \
-jar springboot-server.jar
```

Using the [Guance](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_3.png)

Even though `TestService` only has one interface method, using the wildcard `*` still results in multiple span information.

You might have noticed an issue: `TestServiceImpl` provides three functions `getUsername`, `users`, and `print`. Since `users` calls `getUsername` and `print`, why does the trace show `print` but not `getUsername`?

- Why `print` appears in the trace

This is because `TestServiceImpl` implements the `TestService` interface, and `*` represents all methods. DDTrace actually enhances the implementation class `TestServiceImpl`. Equivalent to `-Ddd.trace.methods="com.zy.observable.server.service.TestServiceImpl[*]".

- Why `getUsername` does not appear in the trace

This is mainly because DDTrace shields certain key methods. The following types of methods will not be enhanced:

- constructors
- getters
- setters
- synthetic
- toString
- equals
- hashcode
- finalizer method calls

It's worth noting that in the above trace, the `print` function appears three times as spans because `stus` is a Map collection that loops three times, calling `print` three times. In some scenarios, this can be fatal. Imagine if `stus` had 1000 elements; `print` would generate corresponding numbers of spans. This would significantly increase both the cost of viewing traces and storage/query costs. Too many spans can lead to high browser memory usage, causing UI lag, while also increasing storage and query costs.

## How to Use OpenTelemetry to Trace Function Calls

Continuing with the same code, run the application without adding any parameters using the following command:

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
```

Using the [Guance](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_4.png)

You can observe that the OpenTelemetry trace spans are basically consistent with those of DDTrace.

Without modifying the code, OpenTelemetry also provides the following Java agent configurations to capture specific method spans.

- Parameter method: `-Dotel.instrumentation.methods.include`
- Environment variable method: `OTEL_INSTRUMENTATION_METHODS_INCLUDE`

Note that OTel does not support wildcard configuration.

Run the following command:

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
-Dotel.instrumentation.methods.include="com.zy.observable.server.service.TestService[users]"
```

Using the [Guance](https://www.guance.com) platform, you can see the following effect:

![Img](../images/tracing_method_5.png)

Similarly, the `users` function also has span information added.

## SDK Method

The above sections introduced how DDTrace and OpenTelemetry can trace specific business functions non-intrusively. They also provide SDK methods, which are somewhat intrusive but offer more flexibility.

- DDTrace uses the `@Trace` annotation to configure business spans. For actual usage and dependencies, refer to [this link](https://docs.guance.com/best-practices/insight/ddtrace-skill-api/#2)
- OpenTelemetry uses the `@WithSpan` annotation to configure business spans. Refer to [this link](https://github.com/lrwh/observable-demo/blob/main/springboot-opentelemetry-otlp-server/src/main/java/com/zy/observable/otel/controller/OtelController.java){:target="_blank"}

Regarding the SDK method, we will not analyze each one here.

## Reference Documents

[DDTrace Agent Download Address](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}

[OpenTelemetry Agent Download Address](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases){:target="_blank"}

[OpenTelemetry Methods](https://opentelemetry.io/docs/instrumentation/java/automatic/annotations/#creating-spans-around-methods-with-otelinstrumentationmethodsinclude){:target="_blank"}

[SpringBoot-Server Demo](https://github.com/lrwh/observable-demo/tree/main/springboot-server){:target="_blank"}