# ddtrace-api 使用指南

---

???+ warning

    **当前案例使用 ddtrace 对应的版本进行测试**

## 前置条件

- 开启 [DataKit ddtrace 采集器](/integrations/ddtrace/)

- 准备 Shell

  ```shell
  java -javaagent:dd-java-agent-v1.34.0-guance.jar \
  -Ddd.service.name=ddtrace-server \
  -Ddd.agent.port=9529 \
  -jar springboot-ddtrace-server.jar
  ```

## 安装部署

### 添加 maven pom 依赖

```xml
	<dependency>
		<groupId>com.datadoghq</groupId>
		<artifactId>dd-trace-api</artifactId>
		<version>1.34.0</version>
	</dependency>

	<dependency>
		<groupId>io.opentracing</groupId>
		<artifactId>opentracing-api</artifactId>
		<version>0.33.0</version>
	</dependency>
	<dependency>
		<groupId>io.opentracing</groupId>
		<artifactId>opentracing-mock</artifactId>
		<version>0.33.0</version>
	</dependency>
	<dependency>
		<groupId>io.opentracing</groupId>
		<artifactId>opentracing-util</artifactId>
		<version>0.33.0</version>
	</dependency>

```

### 获取 Tracer

通过 `GlobalTracer` 获取 Tracer 对象

> Tracer tracer = GlobalTracer.get();

通过 Tracer 可以获取到当前 span 信息

> Span span = tracer.activeSpan();

```java
    // 获取 tracer 对象
    Tracer tracer = GlobalTracer.get();
    // 获取当前 span 对象
    Span span = tracer.activeSpan();
    if (span!=null) {
        // 获取 traceId
        String traceId = span.context().toTraceId();
        // 获取 spanId
        String spanId = span.context().toSpanId();
    }
```

### 函数级别埋点

除了`dd.trace.methods` 方式可以对方法进行主动埋点外，ddtrace 提供了 api 方式能够对业务进行更灵活的埋点。

1、 在对应需要埋点的方法添加注解 `@Trace`

```java
    @Trace
    public String apiTrace(){
        return "apiTrace";
    }
```

2、 然后在 `gateway`方法调用这个

```java
...
testService.apiTrace();
...
```

3、 重启，访问 gateway

![image.png](../images/ddtrace-skill-9.png)

> **注意：**入侵式埋点不代表应用启动的时候不需要 agent ，如果没有 agent， `@Trace` 也将失效。`@Trace` 注释具有默认操作名称 `trace.annotation`，而跟踪的方法默认具有资源。

可以修改对应的名称

```java
    @Trace(resourceName = "apiTrace",operationName = "apiTrace")
    public String apiTrace(){
        return "apiTrace";
    }
```

修改后，效果如下：

![image.png](../images/ddtrace-skill-10.png)

### 使用 Baggage 让业务关键 tag 在后端链路进行传递

ddtrace 提供了`Baggage` 方式，准确的说，应该是 ddtrace 使用 OpenTracing 提供的`Baggage` 功能，让指定的 tag 在链路上进行传递。比如用户名、岗位等信息，方便分析用户行为。

```
span.setBaggageItem("username","liurui");
```

#### 1 编写 TraceBaggageFilter

通过 `TraceBaggageFilter` 方式拦截请求，并将 `request header` 相关参数通过 `Baggage` 方式进行传递。

```java
package com.zy.observable.ddtrace;


import io.opentracing.Span;
import io.opentracing.util.GlobalTracer;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Enumeration;

/**
 * Baggage 可以让 tag 在链路之间进行传递，通过获取当前请求header，将指定前缀的header设置为Baggage
 * @author liurui
 * @date 2022/7/19 14:59
 */
@Component
public class TraceBaggageFilter implements Filter {

    /**
     * 指定前缀的 header 进行链路传递
     */
    private static final String PREFIX = "dd-";

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        final Span span = GlobalTracer.get().activeSpan();
        if (span != null) {
            HttpServletRequest request = (HttpServletRequest)servletRequest;
            Enumeration<String> headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                final String header = headerNames.nextElement();
                String value = request.getHeader(header);
                if (StringUtils.startsWith(header,PREFIX) && StringUtils.isNotBlank(value)){
                    //Baggage 可以在链路之间进行传递，而普通的tag不行
                    span.setBaggageItem(header.replace(PREFIX,""),value);
                }
            }

        }
        filterChain.doFilter(servletRequest,servletResponse);
    }
}
```

#### 2 DataKit 配置

这里需要配合 DataKit 的 ddtrace 采集器配置一起使用，需要通过`customer_tags`方式新增自定义 tag ，否则这部分数据只存在`meta`里面。

```toml
customer_tags = ["username", "job"]
```

#### 3 发起一个请求

发起一个 gateway 请求，携带两个 header ：`dd-username` 和 `dd-job`，系统会识别`dd`开头的 header 参数并在当前所有的链路 span 进行传递。

![](../images/ddtrace-skill-14.png)

### 效果展示

![](../images/ddtrace-skill-13.gif)


## 自定义

### 自定义 traceId

请参考最佳实践文档：<[使用 extract + TextMapAdapter 实现了自定义 traceId](/best-practices/monitoring/ddtrace-custom-traceId/)>

### 自定义 span

通常，应用会对业务逻辑进行异常处理，相关的链路可能因为无法标记为 error 从而导致无法正常统计到应用的 error trace，一般为 try-catch 或者全局异常捕获。

这时候就需要对链路进行标记处理，可以通过自定义 span 的方式来标记这些 span 为 error span，只需要在 catch 处进行标记即可.

1、 通过以下方式获取当前 span 信息

```
final Span span = GlobalTracer.get().activeSpan();
```

2、 标记 span 为 error

```
span.setTag(Tags.ERROR, true);
```

如果当前方法是放在 catch 里面，则可以将 track 信息也可以输出到 span 里面。

可以将 error span 处理逻辑作为一个公共的函数共全局使用，代码如下所示：

```java hl_lines="4 6 7 11"
    private void buildErrorTrace(Exception ex) {
        final Span span = GlobalTracer.get().activeSpan();
        if (span != null) {
            span.setTag(Tags.ERROR, true);
            span.log(Collections.singletonMap(Fields.ERROR_OBJECT, ex));
            span.setTag(DDTags.ERROR_MSG, ex.getMessage());
            span.setTag(DDTags.ERROR_TYPE, ex.getClass().getName());

            final StringWriter errorString = new StringWriter();
            ex.printStackTrace(new PrintWriter(errorString));
            span.setTag(DDTags.ERROR_STACK, errorString.toString());
        }

    }
```

调用方代码

```java hl_lines="10"
@GetMapping("/gateway")
    @ResponseBody
    public String gateway(String tag) {
        ......
        try {
            if (client) {
                httpTemplate.getForEntity("http://" + extraHost + ":8081/client", String.class).getBody();
            }
        } catch (Exception e) {
            buildErrorTrace(e);
        }
        return httpTemplate.getForEntity(apiUrl + "/billing?tag=" + tag, String.class).getBody();
    }

```

## 参考文档

<[demo 源码地址](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)>

[ddtrace 启动参数](/integrations/ddtrace-java/#start-options)
