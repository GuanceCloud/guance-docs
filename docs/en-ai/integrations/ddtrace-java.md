---
title     : 'DDTrace Java'
summary   : 'DDTrace Java Integration'
tags      :
  - 'DDTRACE'
  - 'JAVA'
  - 'Tracing'
__int_icon: 'icon/ddtrace'
---


Java APM integration is very convenient, requiring no modification of business code; only the corresponding agent needs to be injected.

## Install Dependencies {#dependence}

<!-- markdownlint-disable MD046 -->
=== "Guance Version"

    To support more middleware, Guance has enhanced the [DDTrace-Java implementation](ddtrace-ext-java.md).

    ```shell
    wget -O dd-java-agent.jar 'https://static.guance.com/dd-image/dd-java-agent.jar'
    ```

=== "Datadog Version"

    ```shell
    wget -O dd-java-agent.jar 'https://dtdg.co/latest-java-tracer'
    ```
<!-- markdownlint-enable -->

## Run Application {#instrument}

<!-- markdownlint-disable MD046 -->
=== "Host Application"

    You can run your Java Code through various means, such as IDE, Maven, Gradle, or directly via the `java -jar` command. Below is an example using the `java` command to start the application:
    
    ```shell hl_lines="2-7" linenums="1"
    java \
      -javaagent:/path/to/dd-java-agent.jar \
      -Ddd.logs.injection=true \
      -Ddd.service.name=<YOUR-SERVICE-NAME> \
      -Ddd.env=<YOUR-ENV-NAME> \
      -Ddd.agent.host=<YOUR-DATAKIT-HOST> \
      -Ddd.trace.agent.port=9529 \
      -jar path/to/your/app.jar
    ```
    
    Please fill in your various basic configuration parameters `<YOUR-...>` here. Additionally, there are some optional parameters:
    
    ### Enable Profiling {#instrument-profiling}

    > This requires enabling the [Profiling collector](profile.md).
    
    After enabling Profiling, we can see more information about Java runtime:
    
    ```shell linenums="1" hl_lines="3-4"
    java \
      -javaagent:/path/to/dd-java-agent.jar \
      -Ddd.profiling.enabled=true \
      -XX:FlightRecorderOptions=stackdepth=256 \
      ...
    ```

    ### Enable Sampling Rate {#instrument-sampling}
    
    We can enable sampling rate to reduce the actual amount of data generated:

    ```shell hl_lines="3" linenums="1"
    java \
      -javaagent:/path/to/dd-java-agent.jar \
      -Ddd.trace.sample.rate=0.8 \
      ...
    ```

    ### Enable JVM Metrics Collection {#instrument-jvm-metrics}
    
    > This requires enabling the [statsd collector](statsd.md).
    
    ```shell hl_lines="3-6" linenums="1"
    java \
      -javaagent:/path/to/dd-java-agent.jar \
      -Ddd.jmxfetch.enabled=true \
      -Ddd.jmxfetch.check-period=1000 \
      -Ddd.jmxfetch.statsd.host=<YOUR-DATAKIT-HOST>  \
      -Ddd.jmxfetch.statsd.port=8125 \
      ...
    ```

=== "Kubernetes"

    In Kubernetes, you can inject the trace agent via the [Datakit Operator](../datakit/datakit-operator.md#datakit-operator-inject-lib) or manually mount the trace agent into the application container.

    ```yaml hl_lines="10-19" linenums="1"
    apiVersion: apps/v1
    kind: Deployment
    spec:
      template:
        spec:
          containers:
            - name: <CONTAINER_NAME>
              image: <CONTAINER_IMAGE>/<TAG>
              env:
                - name: DD_AGENT_HOST
                  value: "datakit-service.datakit.svc"
                - name: DD_TRACE_AGENT_PORT
                  value: "9529"
                - name: DD_ENV
                  value: <YOUR-ENV-NAME>
                - name: DD_SERVICE
                  value: <YOUR-SERVICE-NAME>
                - name: DD_LOGS_INJECTION
                  value: "true"
    ```

    For more parameter settings, refer to the corresponding ENV fields in [Parameter Explanation](ddtrace-java.md#start-options) below.
<!-- markdownlint-enable -->

## Parameter Explanation {#start-options}

Below are explanations for each command-line parameter and their corresponding environment variable configurations. For complete parameter support, refer to the [DataDog official documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/java){:target="_blank"}.

- **`dd.env`**

    **ENV**：`DD_ENV`

    Sets environment information for the service, such as `testing/prod`.

- **`dd.version`**

    **ENV**：`DD_VERSION`

    APP version number

- **`dd.service.name`**

    Sets the service name
    **ENV**：`DD_SERVICE`

- **`dd.trace.agent.timeout`**

    **ENV**：`DD_TRACE_AGENT_TIMEOUT`

    Client network send timeout, default 10s

- **`dd.logs.injection`**

    **ENV**：`DD_LOGS_INJECTION`

    Whether to enable Java application log injection to correlate logs with tracing data, default true

- **`dd.tags`**

    **ENV**：`DD_TAGS`

    Adds default tags to each Span

- **`dd.agent.host`**

    **ENV**：`DD_AGENT_HOST`

    Datakit listening address, default localhost

- **`dd.trace.agent.port`**

    **ENV**：`DD_TRACE_AGENT_PORT`

    Datakit listening port, default 9529

- **`dd.trace.sample.rate`**

    **ENV**：`DD_TRACE_SAMPLE_RATE`

    Set sampling rate from 0.0(0%) ~ 1.0(100%)

- **`dd.jmxfetch.enabled`**

    **ENV**：`DD_JMXFETCH_ENABLED`

    Enable JMX metrics collection, default value true

- **`dd.jmxfetch.config.dir`**

    **ENV**：`DD_JMXFETCH_CONFIG_DIR`

    Additional JMX metrics collection configuration directory. The Java Agent will look for `jvm_direct:true` in the instance section of YAML configuration files to modify settings

- **`dd.jmxfetch.config`**

    **ENV**：`DD_JMXFETCH_CONFIG`

    Additional JMX metrics collection configuration file. The Java Agent will look for `jvm_direct: true` in the instance section of YAML configuration files to modify settings

- **`dd.jmxfetch.check-period`**

    **ENV**：`DD_JMXFETCH_CHECK_PERIOD`

    JMX metrics sending frequency (ms), default value 1500

- **`dd.jmxfetch.refresh-beans-period`**

    **ENV**：`DD_JMXFETCH_REFRESH_BEANS_PERIOD`

    Refresh JMX beans frequency (s), default value 600

- **`dd.jmxfetch.statsd.host`**

    **ENV**：`DD_JMXFETCH_STATSD_HOST`

    Statsd host address to receive JMX metrics, use `unix://PATH_TO_UDS_SOCKET` for Unix Domain Socket. Default value same as `agent.host`

- **`dd.jmxfetch.statsd.port`**

    **ENV**：`DD_JMXFETCH_STATSD_PORT`

    StatsD port number to receive JMX metrics, use 0 for Unix Domain Socket. Default value same as agent.port

- **`dd.profiling.enabled`**

    **ENV**：`DD_PROFILING_ENABLED`

    Enable Profiling control. After enabling, Profiling information during Java application runtime will also be collected and reported to Datakit

## Trace Error Situations {#error}

A span represents a single logical operation unit, which can be a database query, an HTTP request, or any other type of operation. When this operation encounters issues or does not execute as expected, the span's status will be marked as `error`.

### Reasons for Errors {#error_reason}

Specifically, spans will be marked as `error` under the following conditions:

1. **Exception Thrown**: If any exception is thrown (whether checked or runtime exceptions) during the execution of a span and is not properly handled by the application code (captured but not re-thrown), the span will be marked as `error`. This is the most common situation.
1. **Manual Marking**: Developers can manually mark a span as `error` using the Datadog SDK. This is useful for certain logic errors or special conditions, even if these situations do not throw exceptions.
1. **HTTP Request Errors**: For HTTP client or server spans, if the response status code indicates an error (e.g., 4xx or 5xx), the span is typically marked as `error`. This depends on specific integrations and configurations.
1. **Custom Error Conditions**: Through configuration or custom integrations, developers can define specific conditions or checks to mark spans as errors. For example, if a database query returns results that do not meet expected format or content, it can be marked as `error` even if no exception is thrown.
1. **Timeouts**: Certain operations may fail due to timeouts, such as database queries or remote calls. If these operations are configured with timeout limits and the actual execution exceeds this limit, the span might be marked as `error`.

Marking spans as `error` helps developers and operations personnel quickly identify and resolve issues within applications. By observing spans marked as errors, it becomes easier to detect performance bottlenecks, failed service calls, unhandled exceptions, and take appropriate optimization or corrective measures.

### Common Error Types {#error_type}

In Java programming, exceptions (Exceptions) are problems that occur during program execution, disrupting normal program flow. Java exceptions can be categorized into two main types:

- Checked Exceptions
- Unchecked Exceptions: Unchecked exceptions further divide into

    - Runtime Exceptions
    - Errors

Here are some common exception types:

Checked Exceptions: These exceptions must be explicitly handled in the code (caught or declared). If a method may throw such an exception but does not handle it (i.e., neither caught nor declared with `throws`), the compiler will report an error.

- `IOException`: Thrown when input/output operations fail or are interrupted, such as file read/write failures.
- `SQLException`: Thrown when handling database access errors or other database-related issues.
- `ClassNotFoundException`: Thrown when the application tries to load a class by its string name but cannot find the corresponding class.

Runtime Exceptions: These are a type of unchecked exception. Programs can choose to catch them, but it is not mandatory. They usually indicate programming logic errors and should be fixed during development.

- `NullPointerException`: Occurs when attempting to use a `null` object.
- `ArrayIndexOutOfBoundsException`: Thrown when accessing an illegal index in an array.
- `ClassCastException`: Thrown when attempting to cast an object to a class it is not an instance of.
- `ArithmeticException`: Thrown for mathematical operation errors, like division by zero.
- `IllegalArgumentException`: Thrown when passing an illegal or inappropriate argument to a method.

Errors: Errors represent serious problems that are not designed to be caught by applications. They usually relate to underlying resource issues, such as insufficient system resources or virtual machine problems.

- `OutOfMemoryError`: Thrown when the Java Virtual Machine (JVM) does not have enough memory to allocate space for an object.
- `StackOverflowError`: Thrown when recursive calls are too deep, causing stack overflow.
- `NoClassDefFoundError`: Thrown when the Java Virtual Machine or `ClassLoader` instance tries to load a class definition but cannot find the corresponding class.

Understanding these common exceptions and their usage scenarios is crucial for writing robust and reliable Java applications. Properly handling exceptions can make your programs more stable and provide better user experiences.

### Example {error_exception}

This is a Java code snippet that triggers a division-by-zero exception:

```java
@RequestMapping("/billing")
@ResponseBody
public AjaxResult billing(String tag) {
    logger.info("this is method3,{}", tag);
    sleep();
    if (Optional.ofNullable(tag).get().equalsIgnoreCase("error")) {
        System.out.println(1 / 0);
    }
    return AjaxResult.success("Order placed successfully");
}
```

Requesting this interface triggers a division-by-zero exception: `http://localhost:8080/billing?tag=error`

At this point, you can see the span information on Guance: `error_message` `error_stack`:

```txt
  error_message Request processing failed; nested exception is java.lang.ArithmeticException: / by zero
  error_stack  org.springframework.web.util.NestedServletException: Request processing failed; nested exception is java.lang.ArithmeticException: / by zero
    at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1014)
    at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:898)
    at javax.servlet.http.HttpServlet.service(HttpServlet.java:670)
    at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)
    at javax.servlet.http.HttpServlet.service(HttpServlet.java:779)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:227)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:189)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:117)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:189)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:117)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:189)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at datadog.trace.instrumentation.springweb.HandlerMappingResourceNameFilter.doFilterInternal(HandlerMappingResourceNameFilter.java:50)
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:117)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:189)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:117)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:189)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at org.springframework.web.filter.ServletRequestPathFilter.doFilter(ServletRequestPathFilter.java:56)
    at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:354)
    at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:267)
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:189)
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:162)
    at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:177)
    at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)
    at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)
    at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:135)
    at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)
    at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)
    at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:360)
    at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:399)
    at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)
    at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:891)
    at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1784)
    at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)
    at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1191)
    at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659)
    at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
    at java.lang.Thread.run(Thread.java:750)
  Caused by: java.lang.ArithmeticException: / by zero
    at com.zy.observable.server.controller.ServerController.billing(ServerController.java:99)
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
    at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    at java.lang.reflect.Method.invoke(Method.java:498)
    at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)
    at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:150)
    at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:117)
    at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:895)
    at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:808)
    at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)
    at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1071)
    at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:964)
    at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)
    ... 46 more

  meta{
  error.type  org.springframework.web.util.NestedServletException
}
```

From `error_message`, you can see this is a `Request processing failed; nested exception is java.lang.ArithmeticException: / by zero` exception.

The `error.type` is the exception class name, and `error_stack` is the exception stack trace.

Again, modify the code and use try/catch to catch the exception:

```java
 try {
    if (Optional.ofNullable(tag).get().equalsIgnoreCase("error")) {
        System.out.println(1 / 0);
    }
 }catch (Exception e){
     System.out.println(e);
 }
```

At this point, requesting the interface again will not produce exception information because the exception is caught and handled within the method and will not be propagated for the probe to capture.