# How to Use APM to Trace Complete Class Function Calls

Typically, after an application is connected to APM, it can trace the call chains between related components and services of the application, such as Tomcat, Redis, MySQL, etc. This is because APM has instrumented standard components, allowing for better observation of how component calls impact the application during actual use.

In real-world production environments, non-standard code, i.e., business code, often has a deeper impact on operations. The level of understanding and coding ability among developers also varies. For business code, tracing complete class function calls and identifying key issues remains crucial.

Fortunately, APM developers are also formally trained professionals who have experienced their share of challenges and have set higher expectations for APM. DataDog and OpenTelemetry also provide relevant features that allow us to explore further.

Taking JAVA as an example, we will investigate DDTrace (DataDog) and OpenTelemetry separately.


## How to Use DDTrace to Trace Function Calls

Prepare a piece of code

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

Service interface

```java
public interface TestService {

    String users();
}

```

Service implementation class

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
        Map<Integer,Student> users =new HashMap<>();
        users.put(1,new Student("tom",18));
        users.put(2,new Student("joy",20));
        users.put(3,new Student("lucy",30));
        users.forEach((k,v)->print(k,v));
        return getUsername();
    }

    public void print(Integer level,Student student){
        logger.info("level:{},username:{}",level,student.getUsername());
    }
}
```

When the Controller layer calls `testService.users()`, by default, `users` will not be part of the chain. Run the following command:

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-jar springboot-server.jar
```
Or you can debug in the idea tool.


Request `http://localhost:8090/user`, and the result displayed on the [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) platform is shown in the figure below:

![Img](../images/tracing_method_1.png)

You can observe the chain situation, with two spans.

How to make the `users` method appear in the chain? DDTrace provides the following parameters to discover business code information.

- Parameter method: `-Ddd.trace.methods`
- Environment variable method: `DD_TRACE_METHODS`

Use the following command

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[users]" \
-jar springboot-server.jar
```

Using the [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) platform, you can see the following effect:

![Img](../images/tracing_method_2.png)


If you want to trace all function calls within a class, use `*` to represent them.


```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[*]" \
-jar springboot-server.jar
```

Using the [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) platform, you can see the following effect:

![Img](../images/tracing_method_3.png)

Even though `TestService` has only one interface method, using the wildcard `*` still results in multiple span information.

You may have already noticed the issue; `TestServiceImpl` provides three functions `getUsername`, `users`, and `print`. Since `users` calls both `getUsername` and `print`, why does the chain show `print` but not `getUsername`?

- Why does the chain show `print`

This is because `TestServiceImpl` implements the `TestService` interface, and `*` represents all methods. DDTrace actually enhances the implementation class `TestServiceImpl` of `TestService`. It's equivalent to `-Ddd.trace.methods="com.zy.observable.server.service.TestServiceImpl[*]"`.

- Why doesn't the chain show `getUsername`

This is mainly because `DDTrace` filters out certain critical methods. Methods of the following types will not be enhanced:

- constructors
- getters
- setters
- synthetic
- toString
- equals
- hashcode
- finalizer method calls


It's worth noting that there are three spans for the `print` function in the above chain. This is because `stus` is a Map collection, and it iterates three times, calling `print` three times. In some scenarios, this could be fatal. Imagine if the `stus` collection had 1000 elements, then `print` would generate corresponding numbers of spans. Whether viewing the chain or estimating costs, this has a high price. Too many spans can cause high browser memory usage, leading to UI interface lag, and also increase storage and query costs.


## How to Use OpenTelemetry to Trace Function Calls

Continuing with the same code, run the application without adding parameters using the following command:

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
```

Using the [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) platform, you can see the following effect:

![Img](../images/tracing_method_4.png)

You can observe that the OpenTelemetry chain Span is basically consistent with DDTrace.

In cases where the code cannot be modified, OpenTelemetry also provides the following Java agent configuration options to capture specific method spans.

- Parameter method: `-Dotel.instrumentation.methods.include`
- Environment variable method: `OTEL_INSTRUMENTATION_METHODS_INCLUDE`

Note that otel does not support wildcard configurations.

Run the following command

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
-Dotel.instrumentation.methods.include="com.zy.observable.server.service.TestService[users]"
```

Using the [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) platform, you can see the following effect:

![Img](../images/tracing_method_5.png)

Similarly, the `users` function also adds span information.


## SDK Method

The above sections introduce how DDTrace and OpenTelemetry perform non-intrusive chain tracing for specific business functions. They also offer SDK methods, which are somewhat intrusive to the code but provide more flexibility.

- DDTrace uses the annotation `@Trace` to configure business Spans. For actual usage and related dependencies, refer to [link](<<< homepage >>>/best-practices/insight/ddtrace-skill-api/#2)
- OpenTelemetry uses the annotation `@WithSpan` to configure business Spans, refer to [link](https://github.com/lrwh/observable-demo/blob/main/springboot-opentelemetry-otlp-server/src/main/java/com/zy/observable/otel/controller/OtelController.java){:target="_blank"}

Regarding SDK methods, they will not be analyzed here one by one.

## Reference Documents

[DDTrace Agent Download Address](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}

[OpenTelemetry Agent Download Address](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases){:target="_blank"}

[OpenTelemetry methods](https://opentelemetry.io/docs/instrumentation/java/automatic/annotations/#creating-spans-around-methods-with-otelinstrumentationmethodsinclude){:target="_blank"}

[SpringBoot-Server demo](https://github.com/lrwh/observable-demo/tree/main/springboot-server){:target="_blank"}