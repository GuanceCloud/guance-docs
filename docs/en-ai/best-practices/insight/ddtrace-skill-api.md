# ddtrace-api Usage Guide

---

???+ warning

    **The current example uses the version of ddtrace for testing**

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

### Add Maven Pom Dependency

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

Obtain the Tracer object through `GlobalTracer`

> Tracer tracer = GlobalTracer.get();

You can get the current span information through Tracer

> Span span = tracer.activeSpan();

```java
    // Get tracer object
    Tracer tracer = GlobalTracer.get();
    // Get the current span object
    Span span = tracer.activeSpan();
    if (span!=null) {
        // Get traceId
        String traceId = span.context().toTraceId();
        // Get spanId
        String spanId = span.context().toSpanId();
    }
```

### Function-level Instrumentation

In addition to the `dd.trace.methods` method that allows active instrumentation of methods, ddtrace provides an API method that offers more flexible instrumentation for business logic.

1. Add the `@Trace` annotation to the corresponding method that needs instrumentation

```java
    @Trace
    public String apiTrace(){
        return "apiTrace";
    }
```

2. Call this in the `gateway` method

```java
...
testService.apiTrace();
...
```

3. Restart and access gateway

![image.png](../images/ddtrace-skill-9.png)

> **Note:** Intrusive instrumentation does not mean that the agent is not required when the application starts. Without an agent, `@Trace` will also fail. The `@Trace` annotation has a default operation name `trace.annotation`, and the traced methods have default resources.

You can modify the corresponding names

```java
    @Trace(resourceName = "apiTrace",operationName = "apiTrace")
    public String apiTrace(){
        return "apiTrace";
    }
```

After modification, the effect is as follows:

![image.png](../images/ddtrace-skill-10.png)

### Using Baggage to Propagate Business-Critical Tags Through Backend Links

ddtrace provides the `Baggage` feature, specifically using OpenTracing's `Baggage` functionality to propagate specified tags through the trace. For example, username, position information, etc., to facilitate user behavior analysis.

```
span.setBaggageItem("username","liurui");
```

#### 1 Write TraceBaggageFilter

Intercept requests via `TraceBaggageFilter` and pass relevant `request header` parameters through `Baggage`.

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
 * Baggage can propagate tags between traces by obtaining the current request header and setting specified prefix headers as Baggage
 * @author liurui
 * @date 2022/7/19 14:59
 */
@Component
public class TraceBaggageFilter implements Filter {

    /**
     * Propagate headers with specified prefixes
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
                    // Baggage can be propagated between traces, while ordinary tags cannot
                    span.setBaggageItem(header.replace(PREFIX,""),value);
                }
            }

        }
        filterChain.doFilter(servletRequest,servletResponse);
    }
}
```

#### 2 DataKit Configuration

This requires coordination with DataKit's ddtrace collector configuration. Use the `customer_tags` method to add custom tags; otherwise, this data only exists in `meta`.

```toml
customer_tags = ["username", "job"]
```

#### 3 Initiate a Request

Initiate a gateway request carrying two headers: `dd-username` and `dd-job`. The system will recognize headers starting with `dd` and propagate them across all trace spans.

![](../images/ddtrace-skill-14.png)

### Effect Display

![](../images/ddtrace-skill-13.gif)


## Customization

### Custom traceId

Refer to the best practices document: <[Use extract + TextMapAdapter to Implement Custom traceId](/best-practices/monitoring/ddtrace-custom-traceId/)>

### Custom span

Typically, applications handle business logic exceptions, and related traces may not be marked as errors, leading to incorrect statistics on application error traces. This usually happens in try-catch or global exception handling scenarios.

At this point, you need to mark the trace. You can mark these spans as error spans through custom spans by marking them at the catch location.

1. Obtain the current span information as follows

```
final Span span = GlobalTracer.get().activeSpan();
```

2. Mark the span as an error

```
span.setTag(Tags.ERROR, true);
```

If the current method is placed inside a catch block, you can also output the track information into the span.

You can make the error span processing logic a common function for global use. The code is shown below:

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

<[Demo Source Code Address](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)>

[ddtrace Startup Parameters](/integrations/ddtrace-java/#start-options)