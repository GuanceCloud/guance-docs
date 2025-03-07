# SpringBoot3 WebFlux 可观测最佳实践

---

> _作者： 刘锐_

> 在响应式编程 Kotlin 中，如何在 Spring Boot 3 WebFlux 利用 Micrometer 进行链路追踪

![Img](../images/guance_trace_1.jpg)


链路链路追踪是可观测性软件系统的一个非常好的工具。它使开发人员能够了解应用程序中和应用程序之间不同交互发生的时间、地点和方式。同时让观测复杂的软件系统变得更加容易。

从`Spring Boot 3`开始，Spring Boot 中用于链路追踪的旧 `Spring Cloud Sleuth` 解决方案将替换为新的 `Micrometer Tracing` 库。

您可能已经了解 Micrometer，因为它以前被用作公开独立于平台的指标和监控基于 JVM 的微服务（例如 Prometheus ）的默认解决方案。最新产品通过独立于平台的链路追踪解决方案扩展了 Micrometer 生态系统。这使得开发人员能够使用一个通用 API 来检测其应用程序，并以不同的格式将其导出到 Jaeger、Zipkin 或 OpenTelemetry 等链路追踪收集器。



## 1. 微服务设置

接下来，我们将创建一个简单的 Spring Boot 微服务，它提供一个响应式 REST 端点，该端点在内部查询另一个第三方服务以获取一些信息。目标是导出两个操作的 trace。

我们将从以下 Spring Boot Initializr 项目开始，您可以在此处找到该项目。它包括带有`Kotlin Gradle DSL`的`Spring Boot 3.0.1`、`Spring Web Reactive (WebFlux)`和带有`Prometheus`的`Spring Actuator`。以下代码主要使用`Kotlin`，但如果使用 Java 也是可以的，大多数方法都是相同的。

[Spring初始化模板 带有 Webflux、Spring Actuator 和 Prometheus 的 Spring Boot 3 Kotlin 模板](
https://start.spring.io/#!type=gradle-project-kotlin&language=kotlin&platformVersion=3.0.1&packaging=jar&jvmVersion=17&groupId=com.example&artifactId=tracing&name=tracing&description=Demo%20project%20for%20Spring%20Boot%20Tracing&packageName=com.example.tracing&dependencies=webflux,prometheus,actuator)

### 定义 endpoint

我们将首先添加一个带有测试 endpoint 的简单 REST 控制器类，该测试 endpoint 使用Spring WebClient调用外部 API 。我们正在使用*suspend*关键字来使用`Kotlin`的协程。这使我们能够在利用 Spring WebFlux 的响应式流的同时编写命令式代码。

在以下示例中，我们使用 Spring WebClient 调用外部 TODO-API，该 API 以 JSON 字符串形式返回 TODO 项。我们还将创建一条日志消息，其中稍后应包含一些链路追踪信息。

```Kotlin 
@RestController
class Controller {
  val log = LoggerFactory.getLogger(javaClass)
  
  val webClient = WebClient.builder()
    .baseUrl("https://jsonplaceholder.typicode.com")
    .build()
  
  @GetMapping("/test")
  suspend fun test(): String {
    // simulate some complex calculation  
    delay(1.seconds)
    
    log.info("test log with tracing info")
    
    // make web client call to external API
    val externalTodos = webClient.get()
      .uri("/todos/1")
      .retrieve()
      .bodyToMono(String::class.java)
      .awaitSingle()
    
    return externalTodos
  }
}

```

### 新增 Micrometer tracing

在下一步中，我们将把 Micrometer tracing 依赖项添加到我们的`build.gradle.kts`文件中。由于 Micrometer 支持不同的链路追踪格式和供应商，因此依赖项被分开，我们只导入我们需要的内容。为了保持所有依赖项同步，我们使用 Micrometer Tracing BOM（bom 清单）。此外，我们添加了核心依赖项和桥接器，以将 Micrometer Tracing 转换为 OpenTelemetry 格式（其他格式也可用）。

```gradle
implementation(platform("io.micrometer:micrometer-tracing-bom:1.0.0"))
implementation("io.micrometer:micrometer-tracing")
implementation("io.micrometer:micrometer-tracing-bridge-otel")
```

我们还需要添加导出器依赖项来导出创建的 trace。在此示例中，我们将使用由 OpenTelemetry 维护并由 Micrometer Tracing 支持的 Zipkin 导出器。

```gradle
implementation("io.opentelemetry:opentelemetry-exporter-zipkin")
```

### 配置

配置是设置链路追踪必不可少的一步，配置文件`application.yaml`位于`src/main/resources`目录下。


首先，我们必须在管理设置中启用链路追踪。我们还将链路追踪采样率设置为 1（默认值为 0.1），以便为服务收到的每个调用创建链路追踪。在具有大量请求的生产系统中，您可能只想追踪一些调用链路。此外，我们可以定义希望 Zipkin 导出器发送链路追踪的端点 URL。
最后，我们必须更新默认日志记录模式以包含链路追踪和 spanId。
```yaml
management:
  tracing:
    enabled: true
    sampling.probability: 1.0

  zipkin.tracing.endpoint: http://localhost:9411/api/v2/spans

logging.pattern.level: "trace_id=%mdc{traceId} span_id=%mdc{spanId} trace_flags=%mdc{traceFlags} %p"
```

## 2. 测试

现在我们已经完成了服务设置，我们可以运行它了。如果启动应用程序，默认情况下，服务器应在端口下启动 8080。然后，可以通过打开浏览器来调用我们创建的端点`http://localhost:8080/test`。以下是请求响应内容：

```json
{  "userId" :  1 ,  "id" :  1 ,  "title" :  "delectus aut autem" ,  "已完成" :  false  }
```

要查看调用端点时创建的实际链路追踪，我们需要收集并查看它们。在本教程中，我们将使用`zipkin`导出器将数据导出到 **<<< custom_key.brand_name >>>**。当然也可以使用其他系统，例如 Zipkin、Grafana Loki 或 Datadog。

现在您可以再次调用我们的 Spring Boot 服务的端点。之后，当您在 **<<< custom_key.brand_name >>>** 中搜索任何 tracing 时，您应该能够找到端点请求的链路追踪信息。

![Img](../images/guance_tracing.png)


## 3. 问题

乍一看，一切似乎都运行良好。然而，我们有两个问题。

> 解决了部分issue 问题，这些问题可以在[*Micrometer Tracing*文档](https://micrometer.io/docs/observation#instrumentation_of_reactive_libraries_after_reactor_3_5_3)中找到。

### 日志缺少数据
如果我们查看应用程序日志，可以发现调用端点时发出的日志消息。
```txt
trace_id= span_id= trace_flags= INFO 43636 --- [DefaultExecutor] com.example.tracing.Controller           : test log with tracing info
```

正如你所看到的，`trace_id` 和 `span_id`没有设置。这是因为`Micrometer Tracing`还无法轻松处理响应式流中的链路追踪上下文。此外，响应式流的`Kotlin`协程包装器隐藏了链路追踪上下文。因此，我们必须推迟当前响应式流的上下文来获取链路追踪信息。实际上，这看起来如下所示：

```Kotlin
 Mono.deferContextual { contextView ->
   ContextSnapshot.setThreadLocalsFrom(
     contextView,
     ObservationThreadLocalAccessor.KEY
   ).use {
     log.info("test log with tracing info")
     Mono.empty<String>()
   }
}.awaitSingleOrNull()
```

为了更符合应用性，我们可以将示例代码提取到一个单独的函数中。
```Kotlin
@GetMapping("/test")
suspend fun test(): String {
  // ...
  observeCtx { log.info("test log with tracing info") }
  // ...
}

suspend inline fun observeCtx(crossinline f: () -> Unit) {
  Mono.deferContextual { contextView ->
    ContextSnapshot.setThreadLocalsFrom(
      contextView,
      ObservationThreadLocalAccessor.KEY
    ).use {
      f()
      Mono.empty<Unit>()
    }
  }.awaitSingleOrNull()
}
```

如果我们现在启动应用程序并调用我们的端点，我们应该能够`trace_id`在日志中看到。

```txt
trace_id=6c0053eba01199f194f5f76ff8d61917 span_id=967d591266756905 trace_flags= INFO 45139 --- [DefaultExecutor] com.example.tracing.Controller           : test log with tracing info
```

### WebClient 调用没有产生追踪信息
第二个问题可以通过查看**<<< custom_key.brand_name >>>**中的 trace 来发现。它仅显示端点的父链路追踪，但不显示调用的子范围 WebClient。理论上，Spring WebClient 以及 RestTemplate 都是由 Micrometer 自动检测的。但是如果我们查看代码，就会发现我们正在使用静态构建器方法 WebClient。为了从 WebClient 获取自动链路追踪，我们需要使用 Spring 框架提供的构建器 bean。它可以通过我们类的构造函数注入Controller。


```Kotlin
@RestController
class Controller(
  webClientBuilder: WebClient.Builder
) {

 val webClient = webClientBuilder // use injected builder
  .baseUrl("https://jsonplaceholder.typicode.com")
  .build()

 // ...

}
```
通过上面的代码调整后重新调用 endpoint，我们在**<<< custom_key.brand_name >>>**中可以看到`WebClient`的跨度。Micrometer Tracing 还将自动为包含trace_id. 例如，如果我们调用另一个带有链路追踪功能的微服务，它可以获取 ID 并向**<<< custom_key.brand_name >>>**发送附加信息。
![Img](../images/guance_trace_webclient.png)



## 4. 观测指南
Micrometer Tracing 在 Spring 中自动为我们做了很多事情。但是，有时我们可能希望向链路追踪范围添加特定信息或观察应用程序中非传入或传出调用的特定部分。

### 添加跨度标签
我们可以定义自定义标签并将其添加到当前观察中以增强链路追踪数据。要检索当前链路追踪，我们可以使用`ObservationRegistry`类的 bean 。与日志记录问题类似，我们必须使用包装函数来获取正确的上下文。

```Kotlin
@GetMapping("/test")
suspend fun test(): String {

  observeCtx {
    val currentObservation = observationRegistry.currentObservation
    currentObservation?.highCardinalityKeyValue("test_key", "test sample value")
  }

  // ...
}
```

添加此代码后，我们可以在**<<< custom_key.brand_name >>>**中看到我们的自定义标签及其值。

![Img](../images/guance_trace_tag.png)



### 自定义可观测
使用 Micrometer API 创建自定义可观测（跨度）通常很容易。但是，在使用响应式流和协程时，我们需要帮助上下文链路追踪。如果我们在端点处理程序中创建一个新的观测，它将被视为一个单独的链路追踪。为了使代码可重用，我们可以编写一个简单的包装函数来创建新的观测点。它的工作原理与我们之前创建的用于使用 trace_id.

```Kotlin
suspend fun runObserved(
  name: String, 
  observationRegistry: ObservationRegistry,
  f: suspend () -> Unit
) {
  Mono.deferContextual { contextView ->
    ContextSnapshot.setThreadLocalsFrom(
      contextView,
      ObservationThreadLocalAccessor.KEY
    ).use {
      val observation = Observation.start(name, observationRegistry)
      Mono.just(observation).flatMap {
        mono { f() }
      }.doOnError {
        observation.error(it)
        observation.stop()
      }.doOnSuccess {
        observation.stop()
      }
    }
  }.awaitSingleOrNull()
}
```
该函数可以将任何挂起函数包装在新的观察周围。一旦执行了给定的函数，它将自动停止观测。此外，我们将追踪可能发生的任何错误并将其附加到链路追踪中。

我们现在可以应用这个函数来观察任何代码，例如函数的执行`delay`。

```Kotlin
@GetMapping("/test")
suspend fun test(): String {

  runObserved("delay", observationRegistry) {
    delay(1.seconds)
  }

  // ....
}
```
将此代码添加到端点处理程序后，**<<< custom_key.brand_name >>>**将向我们显示该操作的自定义范围。

![Img](../images/guance_trace_delay.png)



## 5. 数据库链路追踪

典型的 Spring Boot 应用程序通常会连接到实际应用程序中的数据库。要利用响应式技术栈，建议使用[R2DBC](https://r2dbc.io/) API 而不是JDBC。

由于`Micrometer Tracing`是一项相当新的技术，目前还没有可用的自动追踪。然而，Spring 团队正在研究创建自动配置。实验存储库可以在[这里](https://github.com/spring-projects-experimental/r2dbc-micrometer-spring-boot)找到。

当前项目，需将添加以下依赖项到`build.gradle.kts`. 为了方便测试，我们不会使用真实的数据库，而是使用[ H2 内存数据库](https://www.h2database.com/html/main.html)。

```gradle
 implementation("org.springframework.boot:spring-boot-starter-data-r2dbc")
 runtimeOnly("com.h2database:h2")
 runtimeOnly("io.r2dbc:r2dbc-h2")

 // R2DBC micrometer auto tracing
 implementation("org.springframework.experimental:r2dbc-micrometer-spring-boot:1.0.2")
```
在`Kotlin`代码中，添加了一个带有协程支持的简单 CRUD 存储库。如下所示：

```Kotlin
@Table("todo")
data class ToDo(
  @Id
  val id: Long = 0,
  val title: String,
)

interface ToDoRepository : CoroutineCrudRepository<ToDo, Long>


@RestController
class Controller(
  val todoRepo: ToDoRepository,
  // ...
) {

  @GetMapping("/test")
  suspend fun test(): String {
    // ...
    // save
    val entry = ToDo(0,"Springboot3 + WebFlux + Kotlin ")
    todoRepo.save(entry)
    // Sample traced DB call
    val dbtodos = todoRepo.findAll().toList()
    
    // ...

    return "${dbtodos.size} $externalTodos"
  }
}
```

调用我们的 endpoint 将会再添加一个跨度。新的跨度名为`query`，包含多个标签，包括[Spring Data R2DBC](https://spring.io/projects/spring-data-r2dbc/) 执行的 SQL 查询。

![Img](../images/guance_trace_db.png)


## 结论

Micrometer 和新的链路追踪扩展统一了`Spring Boot 3`及以上版本的可观测性技术栈。为不同公司及其技术栈使用的不同链路追踪解决方案提供了很好的抽象。因此，它简化了我们开发人员的工作。

在 Spring WebFlux 的响应式编程方面，仍然有一些改进的潜力，尤其是 Kotlin。[Micrometer 团队正在与Project Reactor](https://projectreactor.io/) （Spring WebFlux 使用的响应式库）背后的团队进行积极会谈，以简化响应式技术栈的 Micrometer Tracing 的使用。

## 参考资源

[kotlin-spring-boot-tracing-example](https://github.com/lrwh/kotlin-spring-boot-tracing-example)

[micrometer-metrics](https://github.com/micrometer-metrics/tracing)

[micrometer tracing](https://micrometer.io/docs/tracing)

[r2dbc-micrometer-spring-boot](https://github.com/spring-projects-experimental/r2dbc-micrometer-spring-boot)

