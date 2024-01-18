# ddtrace 常见参数用法

---

> _作者： 刘锐_

## 前置条件

- 开启 [DataKit ddtrace 采集器](/integrations/ddtrace/)

- 准备 Shell

  ```shell
  java -javaagent:D:/ddtrace/dd-java-agent-1.21.1-guance.jar \
  -Ddd.service.name=ddtrace-server \
  -Ddd.agent.port=9529 \
  -jar springboot-ddtrace-server.jar
  ```

## 参数使用

### 开启 query 参数

开启 query 参数，可以更直观方便地让用户看到当前请求携带了哪些参数，更直观地还原客户真实的操作流程。默认为 false，表示为默认不开启。

但 query 开启参数只能采集到 url 上的参数，request Body 里面的参数目前尚不支持。

```
-Ddd.http.server.tag.query-string=TRUE
```

![image](../images/ddtrace-skill-1.png)

### 配置远程采集链接

`dd.agent.host` 默认值是`localhost`，所以默认推送的是本地的 DataKit。

如果想推送远程 DataKit ，则需要配置 `dd.agent.host`。

```
-Ddd.agent.host=192.168.91.11
```

### 两种添加 Tag 方式

ddtrace 提供两种添加 tag 方式，效果一样。但还是推荐使用 dd.tags 方式

#### 1 dd.trace.span.tags

将 `projectName:observable-demo` 添加到每个 span 的示例：

```
-Ddd.trace.span.tags=projectName:observable-demo
```

![image.png](../images/ddtrace-skill-3.png)

#### 2. dd.tags

```
-Ddd.tags=user_name:joy
```

![image.png](../images/ddtrace-skill-4.png)

以上两种方式都能生成 tag，效果一样，都会在`meta`里面展示数据。

如果确实想要把 `dd.tags`标记的 tag 作为观测云的 标签 ，则需要在 `ddtrace.conf` 配置 `customer_tags`

```yaml
    [[inputs.ddtrace]]
      endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
      customer_tags = ["projectName","user_name"]
```

效果如图：

![image.png](../images/ddtrace-skill-5.png)


### 显示数据库实例名称

显示数据库的名称，默认显示数据库的类型，如需要显示数据库名称，将值设置成`TRUE`

```
-Ddd.trace.db.client.split-by-instance=TRUE
```

以上 demo 并没有加载数据库，所以想要达到这个效果，可以选择一个引入数据库的应用添加参数
```
dd.trace.db.client.split-by-instance=TRUE
```

效果如图：

![image](../images/ddtrace-skill-6.png)

### 类或方法注入 Trace

ddtrace 支持给方法注入 Trace ，默认情况下，ddtrace 会对所有的 API 接口动态注入 Trace。

如果想对非 API 类（方法）——— 一些重要的类和方法重点标记，可以通过 `dd.trace.methods`参数配置。

- **Environment Variable**: DD_TRACE_METHODS <br/>
- **Default**: null <br/>
- **Example**: package.ClassName[method1,method2,...];AnonymousClass$1[call];package.ClassName[*]<br />List of class/interface and methods to trace. Similar to adding @Trace, but without changing code. <br/>
- **Note:** The wildcard method support ([*]) does not accommodate constructors, getters, setters, synthetic, toString, equals, hashcode, or finalizer method calls

如对 `com.zy.observable.ddtrace.service.TestService` 类的`getDemo`方法需要添加 Trace。

```
-Ddd.trace.methods="com.zy.observable.ddtrace.service.TestService[getDemo]"
```

部分代码所示：

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

未添加`dd.trace.methods`参数，上报 11 个 span ，效果如下：

![image.png](../images/ddtrace-skill-2.png)

### 通过 header 自定义业务 tag

主要是通过 header 方式，以一种非侵入式方式将业务 tag 注入到 trace 中，能够跟踪对应业务的执行情况。以 Key:value 方式进行配置，key 为原始 header 的 paramName ，value 为 key 的 rename，其中 key 可以省略。

```
-Ddd.trace.header.tags=user-id:userid,order-id:orderid,orderno
```

请求

![image.png](../images/ddtrace-skill-6-1.png)

链路效果：

![image.png](../images/ddtrace-skill-6-2.png)


### 开启 debug 模式

开启 debug 模式后，系统输出 ddtrace 相关日志，有利于排查 ddtrace 相关问题。

```
-Ddd.trace.debug=true
```

默认情况下 debug 日志会输出到 stdout，如果想要输出到文件，则需要配合以下参数

```
-Ddatadog.slf4j.simpleLogger.logFile=<NEW_LOG_FILE_PATH> 
```

???+ attention "注意"
    `-Ddd.trace.debug=true` 是用来开启 ddtrace 的 debug 日志，而不是开启应用的 debug 日志。
    

### traceId 开启 128 bit
traceId 默认是 64 bit（long型），为了能够更好的与 opentelemetry （traceId 为 128bit ）兼容，可以手动开启 128 bit。
```
-Ddd.trace.128.bit.traceid.generation.enabled=true
```

### 输出 trace 信息
如果需要做一些研发相关的工作，了解 trace 上报数据结构是有必要的，默认情况下，trace 信息会通过`DDAgentWriter`上报到远端可观测平台，如果想在控制台输出对应的信息，可以通过配置如下参数：

```
-Ddd.writer.type=LoggingWriter
```

也可以配置多个
```
-Ddd.writer.type=LoggingWriter,DDAgentWriter
```

### 开启服务名替换中间件名称

默认情况下，链路信息会按照中间件名称进行分组展示，导致如果应用只有中间件产生链路信息，则无法向上追溯到当前中间件所处的应用，可以通过调整参数将全局 tag service name 作为中间件的 service。通过以下参数进行配置：

启动参数方式注入

```
-Ddd.trace.span.attribute.schema=v1
```
可通过环境变量方式注入

```
export DD_TRACE_SPAN_ATTRIBUTE_SCHEMA=v1
```

以上两种方式二选一

最终效果，不再展示中间件服务名称【即应用服务名称替换了中间件的名称】，span 其他 tag 和数据不受影响。

替换前效果

![image.png](../images/ddtrace-param-7.png)

替换后效果

![image.png](../images/ddtrace-param-8.jpg)

### 传播器配置

ddtrace支持以下几种传播器，传播器类型不区分大小写。

- Datadog ：默认传播器
- B3 ：B3 传播是标头“b3”和以“x-b3-”开头的标头的规范。这些标头用于跨服务边界的跟踪上下文传播。B3有两种方式，分别是
    - B3SINGLE（B3_SINGLE_HEADER），对应 header 的 key 为 `b3`
    - B3（B3MULTI），对应 header 的 key 为 `x-b3-`
- haystack
- tracecontext
- xray


```shell
-Ddd.trace.propagation.style=B3SINGLE
```

或者配置环境变量

```shell
DD_TRACE_PROPAGATION_STYLE=B3SINGLE
```


ddtrace 1.9.0 之前使用

```shell
-Ddd.propagation.style.extract=Datadog
-Ddd.propagation.style.inject=Datadog
```
或
```shell
-Ddd.propagation.style=Datadog
```

***注意： 可以配置多个传播器，多个传播器之间使用`,`分割，传播器类型不区分大小写。***

关于传播器更多资料可以参考[链路传播（Propagate）机制及使用场景](https://juejin.cn/post/7254125867177443365)

## 参考文档

[demo 源码地址](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)

[ddtrace 启动参数](/integrations/ddtrace-java/#start-options)