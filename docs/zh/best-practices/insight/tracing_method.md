# 如何利用 APM 追踪完整的类函数调用

通常，应用接入 APM 后，可以追踪到应用相关组件、服务间的调用链路情况，如 Tomcat、Redis、MySQL 等，这是因为 APM 对于标准性组件做了插桩处理，从而更好的观测到在实际使用过程中组件调用对应用的影响。

而在实际生产过程中，非标代码即业务代码，常常对业务影响程度更深，不同程度的开发人员对代码理解程度、编写能力也存在这差异，对于业务代码，如何追踪完整的类函数调用，找到关键问题所在仍是至关重要。

所幸的是 APM 研发人员也是科班出生，也曾体会过人间疾苦，同样对 APM 赋予了更高的期望。DataDog、OpenTelemetry 也提供了相关的功能，让我们一窥究竟。

以 JAVA 为例，分别探究 DDTrace(DataDog)、OpenTelemetry。


## 如何使用 DDTrace 追踪函数调用

准备一段代码

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

Service 接口

```java
public interface TestService {

    String users();
}

```

Service 实现类

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

当 Controller 层调用 `testService.users()`,默认情况下，`users`不会作为链路的一部分，用以下命令运行

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-jar springboot-server.jar
```
或者在 idea 工具进行调试均可。


请求 `http://localhost:8090/user`,在[{{{ custom_key.brand_name }}}](https://www.guance.com)平台看到的效果如下图所示：

![Img](../images/tracing_method_1.png)

可以观察到链路情况，有两个 span。

如何将 `users`方法也体现在链路中，DDTrace 提供了以下参数可以发现业务代码信息。

- 参数方式：`-Ddd.trace.methods`
- 环境变量方式：`DD_TRACE_METHODS`

用以下命令

```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[users]" \
-jar springboot-server.jar
```

使用[{{{ custom_key.brand_name }}}](https://www.guance.com)平台可以看到以下效果：

![Img](../images/tracing_method_2.png)


如果想追踪一个类中的所有函数调用，则用`*`来表示。


```shell
java -javaagent:D:/ddtrace/dd-java-agent-1.25.2-guance.jar \
-Ddd.service=springboot-server \
-Ddd.env=1.0 \
-Ddd.agent.port=9529 \
-Ddd.trace.methods="com.zy.observable.server.service.TestService[*]" \
-jar springboot-server.jar
```

使用[{{{ custom_key.brand_name }}}](https://www.guance.com)平台可以看到以下效果：

![Img](../images/tracing_method_3.png)

尽管`TestService`只有一个接口方法，用通配符`*`，仍会出现多个 span 信息。

细心的你可能已经发现了问题，`TestServiceImpl` 分别提供了三个函数`getUsername`、`users`、`print`，其中 `users` 分别调用了 `getUsername`和 `print`，为什么链路上有`print`却没有`getUsername`？

- 为什么链路上有`print`

原因在于 `TestServiceImpl` 实现了 `TestService` 接口，而 `*` 则代表所有，ddtrace 实际是对`TestService`的实现类`TestServiceImpl`进行了增强处理。相当于`-Ddd.trace.methods="com.zy.observable.server.service.TestServiceImpl[*]"`

- 为什么链路上没有`getUsername`

主要是因为 `DDTrace` 对一些关键方法做了屏蔽，对于以下类型的方法函数将不会做增强处理。

- constructors
- getters
- setters
- synthetic
- toString
- equals
- hashcode
- finalizer method calls


值得注意的是，以上链路`print`函数出现了三个 span，是由于`stus`是一个 Map 集合，循环了三次，调用了三次 `print`。这在某些场景下是致命的，试想想，如果`stus`集合是 1000，`print`则会生成对应数量的 span。这不管是查看链路还是成本估算，都有着很高的代价。前者由于 span 太多，会导致浏览器内存占用高，造成 UI 界面卡顿，后者增加了存储和查询成本。


## 如何使用 OpenTelemetry 追踪函数调用

继续沿用上面的代码，在不添加其参数的情况下，用以下命令运行应用

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
```

使用[{{{ custom_key.brand_name }}}](https://www.guance.com)平台可以看到以下效果：

![Img](../images/tracing_method_4.png)

可以观察到 OpenTelemetry 链路 Span 与 DDTrace 基本一致。

在无法修改代码的情况下，OpenTelemetry 也提供了以下配置 Java 代理来捕获特定方法的跨度。

- 参数方式：`-Dotel.instrumentation.methods.include`
- 环境变量方式：`OTEL_INSTRUMENTATION_METHODS_INCLUDE`

需要注意的是，otel 不支持同配符的方式进行配置。

运行以下命令

```shell
-javaagent:/home/liurui/agent/opentelemetry-javaagent-1.26.1-guance.jar
-Dotel.traces.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://localhost:4317
-Dotel.resource.attributes=service.name=springboot-server
-Dotel.instrumentation.methods.include="com.zy.observable.server.service.TestService[users]"
```

使用[{{{ custom_key.brand_name }}}](https://www.guance.com)平台可以看到以下效果：

![Img](../images/tracing_method_5.png)

同样 `users` 函数也被添加了 span 信息。


## SDK 方式

以上分别介绍了 DDTrace 和 OpenTelemetry 在非侵入式的情况下对业务特定函数方法进行链路追踪。同样它们也提供了 SDK 的方式，具有一定的代码侵入性，但表现为更灵活。

- DDTrace 使用注解 `@Trace`配置业务 Span，实际用法以及相关依赖，参考[链接](https://docs.guance.com/best-practices/insight/ddtrace-skill-api/#2)
- OpenTelemetry  使用注解 `@WithSpan` 配置业务 Span，参考[链接](https://github.com/lrwh/observable-demo/blob/main/springboot-opentelemetry-otlp-server/src/main/java/com/zy/observable/otel/controller/OtelController.java){:target="_blank"}

关于 SDK 方式，这里不再一一分析。

## 参考文档

[DDTrace Agent 下载地址](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}

[OpenTelemetry Agent 下载地址](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases){:target="_blank"}

[OpenTelemetry methods](https://opentelemetry.io/docs/instrumentation/java/automatic/annotations/#creating-spans-around-methods-with-otelinstrumentationmethodsinclude){:target="_blank"}

[SpringBoot-Server demo](https://github.com/lrwh/observable-demo/tree/main/springboot-server){:target="_blank"}