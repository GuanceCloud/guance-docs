# ddtrace-api Usage Guide

---

???+ warning

    **The current case is tested with the corresponding version of ddtrace**

## Prerequisites

- Enable [DataKit ddtrace Collector](/integrations/ddtrace/)

- Prepare Shell

  ```shell
  java -javaagent:dd-java-agent-v1.34.0-guance.jar \
  -Ddd.service.name=ddtrace-server \
  -Ddd.agent.port=9529 \
  -jar springboot-ddtrace-server.jar
  ```

## Installation and Deployment

### Add Maven pom Dependency

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

### Obtain Tracer

Get the Tracer object via `GlobalTracer`

> Tracer tracer = GlobalTracer.get();

Through Tracer, you can get information about the current span.

> Span span = tracer.activeSpan();

```java
    // Get tracer object
    Tracer tracer = GlobalTracer.get();
    // Get current span object
    Span span = tracer.activeSpan();
    if (span!=null) {
        // Get traceId
        String traceId = span.context().toTraceId();
        // Get spanId
        String spanId = span.context().toSpanId();
    }
```

### Function-level Instrumentation

In addition to the `dd.trace.methods` method for proactive instrumentation of methods, ddtrace provides an API method that allows more flexible instrumentation of business logic.

1. Add the `@Trace` annotation to the corresponding method that needs instrumentation.

```java
    @Trace
    public String apiTrace(){
        return "apiTrace";
    }
```

2. Then call this in the `gateway` method.

```java
...
testService.apiTrace();
...
```

3. Restart and access gateway

![image.png](../images/ddtrace-skill-9.png)

> **Note:** Intrusive instrumentation does not mean that the agent is not required when starting the application. Without the agent, `@Trace` will also be invalid. The `@Trace` annotation has a default operation name `trace.annotation`, while tracked methods have resources by default.

You can modify the corresponding names.

```java
    @Trace(resourceName = "apiTrace",operationName = "apiTrace")
    public String apiTrace(){
        return "apiTrace";
    }
```

After modification, the effect is as follows:

![image.png](../images/ddtrace-skill-10.png)

### Using Baggage to Pass Business Critical Tags Through Backend Chains

ddtrace provides the `Baggage` method. More accurately, ddtrace uses the `Baggage` feature provided by OpenTracing to pass specified tags through the chain. For example, username, position information, etc., which makes it easier to analyze user behavior.

```
span.setBaggageItem("username","liurui");
```

#### 1 Write TraceBaggageFilter

By using the `TraceBaggageFilter` method to intercept requests and pass related parameters from `request header` through `Baggage`.

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
 * Baggage can pass tags between chains, by obtaining the current request header, set the headers with a specified prefix as Baggage.
 * @author liurui
 * @date 2022/7/19 14:59
 */
@Component
public class TraceBaggageFilter implements Filter {

    /**
     * Pass headers with a specified prefix through the chain
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
                    // Baggage can be passed between chains, while ordinary tags cannot
                    span.setBaggageItem(header.replace(PREFIX,""),value);
                }
            }

        }
        filterChain.doFilter(servletRequest,servletResponse);
    }
}
```

#### 2 DataKit Configuration

This requires using the ddtrace collector configuration of DataKit together. You need to add custom tags through the `customer_tags` method; otherwise, this data will only exist in `meta`.

```toml
customer_tags = ["username", "job"]
```

#### 3 Initiate a Request

Initiate a gateway request carrying two headers: `dd-username` and `dd-job`. The system will recognize `dd` prefixed header parameters and pass them through all current chain spans.

![](../images/ddtrace-skill-14.png)

### Effect Display

![](../images/ddtrace-skill-13.gif)


## Customization

### Custom traceId

Please refer to the best practices document: <[Implementing custom traceId using extract + TextMapAdapter](/best-practices/monitoring/ddtrace-custom-traceId/)>

### Custom span

Usually, applications handle business logic exceptions, and related chains may not be marked as error, leading to inability to normally count the application's error traces. Generally, these are try-catch or global exception captures.

At this point, marking the chain is needed. By customizing the span, these spans can be marked as error spans, and marking can be done at the catch location.

1. Get current span information via the following method.

```
final Span span = GlobalTracer.get().activeSpan();
```

2. Mark span as error.

```
span.setTag(Tags.ERROR, true);
```

If the current method is placed inside a catch block, the track information can also be output to the span.

The error span handling logic can be made into a common function for global use. The code is shown below:

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

Caller code

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

## Reference Documents

<[demo source code address](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)>

[ddtrace startup parameters](/integrations/ddtrace-java/#start-options)