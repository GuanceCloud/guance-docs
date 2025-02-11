# Common ddtrace Parameter Usage

---

> _Author: Liu Rui_

## Prerequisites

- Enable [DataKit ddtrace Collector](/integrations/ddtrace/)

- Startup Command

  ```shell
  java -javaagent:D:/ddtrace/dd-java-agent-guance.jar \
  -Ddd.service.name=ddtrace-server \
  -Ddd.agent.port=9529 \
  -jar springboot-ddtrace-server.jar
  ```

## Parameter Usage

### Enable Query Parameters

Enabling query parameters allows users to more intuitively see the parameters carried by the current request, providing a clearer replay of the actual user operation flow. By default, it is set to `false`, meaning it is not enabled by default.

However, enabling query parameters only collects parameters from the URL; parameters inside the request body are currently not supported.

```
-Ddd.http.server.tag.query-string=TRUE
```

![image](../images/ddtrace-skill-1.png)

### Configure Remote Collection Link

The default value for `dd.agent.host` is `localhost`, so by default, data is pushed to the local DataKit.

If you want to push data to a remote DataKit, you need to configure `dd.agent.host`.

```
-Ddd.agent.host=192.168.91.11
```

### Two Methods to Add Tags

ddtrace provides two methods to add tags, which have the same effect. However, using `dd.tags` is still recommended.

#### 1. `dd.trace.span.tags`

Example of adding `projectName:observable-demo` to each span:

```
-Ddd.trace.span.tags=projectName:observable-demo
```

![image.png](../images/ddtrace-skill-3.png)

#### 2. `dd.tags`

```
-Ddd.tags=user_name:joy
```

![image.png](../images/ddtrace-skill-4.png)

Both methods generate tags with the same effect, displaying data in the `meta` section.

If you want to use `dd.tags` as Guance labels, you need to configure `customer_tags` in `ddtrace.conf`.

```yaml
    [[inputs.ddtrace]]
      endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
      customer_tags = ["projectName","user_name"]
```

Effect as shown:

![image.png](../images/ddtrace-skill-5.png)

### Display Database Instance Name

By default, only the database type is displayed. To display the database name, set this value to `TRUE`.

```
-Ddd.trace.db.client.split-by-instance=TRUE
```

Since this demo does not load a database, to achieve this effect, choose an application that introduces a database and add the parameter.

```
dd.trace.db.client.split-by-instance=TRUE
```

Effect as shown:

![image](../images/ddtrace-skill-6.png)

### Inject Trace into Classes or Methods

ddtrace supports injecting traces into methods. By default, ddtrace dynamically injects traces into all API interfaces.

If you want to mark important classes and methods that are not APIs, you can configure this via the `dd.trace.methods` parameter.

- **Environment Variable**: DD_TRACE_METHODS <br/>
- **Default**: null <br/>
- **Example**: package.ClassName[method1,method2,...];AnonymousClass$1[call];package.ClassName[*]<br /> List of class/interface and methods to trace. Similar to adding @Trace, but without changing code. <br/>
- **Note:** The wildcard method support ([*]) does not accommodate constructors, getters, setters, synthetic, toString, equals, hashcode, or finalizer method calls

For example, to add a trace to the `getDemo` method of the `com.zy.observable.ddtrace.service.TestService` class:

```
-Ddd.trace.methods="com.zy.observable.ddtrace.service.TestService[getDemo]"
```

Part of the code is shown below:

```java
    @Autowired
    private TestService testService;

    @GetMapping("/gateway")
    @ResponseBody
    public String gateway(String tag) {
        String userId = "user-" + System.currentTimeMillis();
        MDC.put(ConstantsUtils.MDC_USER_ID, userId);
        logger.info("this is tag");
        sleep();
        testService.getDemo();
        httpTemplate.getForEntity(apiUrl + "/resource", String.class).getBody();
        httpTemplate.getForEntity(apiUrl + "/auth", String.class).getBody();
        if (client) {
            httpTemplate.getForEntity("http://"+extraHost+":8081/client", String.class).getBody();
        }
        return httpTemplate.getForEntity(apiUrl + "/billing?tag=" + tag, String.class).getBody();
    }
```

Without adding the `dd.trace.methods` parameter, 11 spans are reported, with the following effect:

![image.png](../images/ddtrace-skill-2.png)

### Custom Business Tags via Header

This primarily involves injecting business tags into traces in a non-intrusive way through headers, allowing tracking of the execution of corresponding business processes. Configuration is done in Key:value format, where key is the original header paramName, and value is the renamed key. The key can be omitted.

```
-Ddd.trace.header.tags=user-id:userid,order-id:orderid,orderno
```

Request

![image.png](../images/ddtrace-skill-6-1.png)

Trace Effect:

![image.png](../images/ddtrace-skill-6-2.png)

### Baggage, Unlimited Tag Propagation

Environment Variable: DD_TRACE_HEADER_BAGGAGE

Default Value: null

Example: CASE-insensitive-Header:my-baggage-name,User-ID:userId,My-Header-And-Baggage-Name

For example:
```shell
-Ddd.trace.header.baggage=userId:user_id
```

???+ info ""
    `-Ddd.trace.header.tags` does not implement propagation functionality. Baggage allows header tags to propagate infinitely.

Trace Effect:

![image.png](../images/ddtrace_skill_params_baggage_01.png)

### Enable Debug Mode

After enabling debug mode, the system outputs ddtrace-related logs, which helps in troubleshooting ddtrace issues.

```
-Ddd.trace.debug=true
```

By default, debug logs are output to stdout. If you want to output them to a file, you need to use the following parameter.

```
-Ddatadog.slf4j.simpleLogger.logFile=<NEW_LOG_FILE_PATH>
```

???+ warning "Note"
    `-Ddd.trace.debug=true` enables ddtrace debug logs, not application debug logs.

### Enable 128-bit TraceId

The default traceId is 64 bits (long type). To better align with OpenTelemetry (which uses a 128-bit traceId), you can manually enable 128 bits.

```
-Ddd.trace.128.bit.traceid.generation.enabled=true
```

### Output Trace Information

To understand the structure of the trace data being reported, especially for development work, you can configure the following parameter to output trace information to the console:

```
-Ddd.writer.type=LoggingWriter
```

You can also configure multiple writers:

```
-Ddd.writer.type=LoggingWriter,DDAgentWriter
```

### Replace Middleware Service Names with Application Service Names

By default, trace information is grouped by middleware names, making it difficult to trace back to the application if only middleware generates trace information. You can adjust this by setting the global tag service name as the middleware's service name. This can be configured using the following parameter:

Startup parameter injection:

```
-Ddd.trace.span.attribute.schema=v1
```

Or environment variable injection:

```
export DD_TRACE_SPAN_ATTRIBUTE_SCHEMA=v1
```

Choose one of the two methods.

Final effect: No longer displays middleware service names (i.e., application service names replace middleware names), while other span tags and data remain unaffected.

Before replacement:

![image.png](../images/ddtrace-param-7.png)

After replacement:

![image.png](../images/ddtrace-param-8.jpg)

### Propagator Configuration

ddtrace supports several propagators, and propagator types are case-insensitive.

- Datadog: Default propagator
- B3: B3 propagation specifies headers "b3" and those starting with "x-b3-". These headers are used for tracing context propagation across service boundaries. B3 has two modes:
    - B3SINGLE (B3_SINGLE_HEADER), corresponding header key is `b3`
    - B3 (B3MULTI), corresponding header key is `x-b3-`
- haystack
- tracecontext: Default propagator
- xray: AWS propagator

```shell
-Ddd.trace.propagation.style=B3SINGLE
```

Or configure environment variables:

```shell
DD_TRACE_PROPAGATION_STYLE=B3SINGLE
```

For versions before ddtrace 1.9.0:

```shell
-Ddd.propagation.style.extract=Datadog
-Ddd.propagation.style.inject=Datadog
```
or
```shell
-Ddd.propagation.style=Datadog
```

***Note: Multiple propagators can be configured, separated by commas. Propagator types are case-insensitive.***

For more information on propagators, refer to [Propagation Mechanism and Use Cases](https://juejin.cn/post/7254125867177443365){:target="_blank"}

### Response Returns TraceId

No additional configuration is required. After the request response is completed, a header with the key `guance_trace_id` is appended.

![Img](../images/ddtrace-param-response.png)

:heavy_check_mark: version >= 1.25.1-guance

### Header Tags

All headers from requests and responses are added to trace tags. Request headers have the tag name `request_header`, and response headers have the tag name `response_header`. You can enable this in two ways, choosing one:

- Startup command

`-Ddd.trace.headers.enabled`: Default value is `false`, meaning it is not enabled by default.

- Environment variable

`DD_TRACE_HEADERS_ENABLED`

![Img](../images/ddtrace-param-request-header.png)

|Component|ddtrace Version|
|-|-|
|javax.servlet| >=1.25|
|jakarta.servlet | >=1.42.9|

### Request Body Tag

Adds the request body to the trace tag. Currently, only `POST` requests with `Context-Type` as `application/json` or `application/json;charset=UTF-8` are supported.
- Startup command

`-Ddd.trace.request.body.enabled`: Default value is `false`, meaning it is not enabled by default.

- Environment variable

`DD_TRACE_REQUEST_BODY_ENABLED`

For example, executing the following request:

> curl -X POST -H 'Content-Type: application/json' -d '{"username":"joy","age":18}' http://localhost:8090/jsonStr

![Img](../images/ddtrace-param-request-body.png)

|Component|ddtrace Version|
|-|-|
|javax.servlet| >=1.25|
|jakarta.servlet | >=1.42.9|

### Response Body Tag

Adds the content of the response body to the trace tag, supporting `application/json` and `text/plain` data types.

- Startup command

`-Ddd.trace.response.body.enabled`: Default value is `false`, meaning it is not enabled by default.

- Environment variable

`DD_TRACE_RESPONSE_BODY_ENABLED`

Reading the response body consumes some Java memory space. It is recommended to add blacklisted URLs for large response bodies (e.g., file download interfaces) to prevent OOM. URLs on the blacklist will not parse the response body content.

Blacklist configuration:

- Parameter method

> -Ddd.trace.response.body.blacklist.urls="/auth,/download/file"

- Environment variable method

> DD_TRACE_RESPONSE_BODY_BLACKLIST_URLS

|Component|ddtrace Version|
|-|-|
|javax.servlet| >=1.42|
|jakarta.servlet | >=1.42.9|

## Reference Documents

[demo source code](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server){:target="_blank"}

[ddtrace startup parameters](/integrations/ddtrace-java/#start-options){:target="_blank"}

[ddtrace issue](https://github.com/GuanceCloud/dd-trace-java/issues){:target="_blank"}

[ddtrace extended features](/integrations/ddtrace-ext-java/):loudspeaker: