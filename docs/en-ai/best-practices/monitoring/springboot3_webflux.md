# Best Practices for Observability with SpringBoot3 WebFlux

---

> _Author: Liu Rui_

> How to perform trace collection in Spring Boot 3 WebFlux using Micrometer within reactive programming in Kotlin.

![Img](../images/guance_trace_1.jpg)

Trace collection is an excellent tool for observability in software systems. It allows developers to understand when, where, and how different interactions occur within and between applications. It also makes it easier to observe complex software systems.

Starting from `Spring Boot 3`, the old `Spring Cloud Sleuth` solution for trace collection in Spring Boot will be replaced by the new `Micrometer Tracing` library.

You may already be familiar with Micrometer because it was previously used as the default solution for exposing platform-independent metrics and monitoring JVM-based microservices (such as Prometheus). The latest product extends the Micrometer ecosystem with a platform-independent trace collection solution. This enables developers to instrument their applications using a common API and export them in different formats to trace collectors like Jaeger, Zipkin, or OpenTelemetry.

## 1. Microservice Setup

Next, we will create a simple Spring Boot microservice that provides a reactive REST endpoint, which internally queries another third-party service to retrieve some information. The goal is to export traces for two operations.

We will start with the following Spring Boot Initializr project, which you can find here. It includes `Spring Boot 3.0.1` with `Kotlin Gradle DSL`, `Spring Web Reactive (WebFlux)`, and `Spring Actuator` with `Prometheus`. The following code mainly uses `Kotlin`, but Java can also be used, as most methods are the same.

[Spring Initializr Template with Webflux, Spring Actuator, and Prometheus for Spring Boot 3 Kotlin](
https://start.spring.io/#!type=gradle-project-kotlin&language=kotlin&platformVersion=3.0.1&packaging=jar&jvmVersion=17&groupId=com.example&artifactId=tracing&name=tracing&description=Demo%20project%20for%20Spring%20Boot%20Tracing&packageName=com.example.tracing&dependencies=webflux,prometheus,actuator)

### Defining the Endpoint

We will first add a simple REST controller class with a test endpoint that uses Spring WebClient to call an external API. We are using the *suspend* keyword to use Kotlin's coroutines. This allows us to write imperative code while leveraging the reactive streams of Spring WebFlux.

In the following example, we use Spring WebClient to call an external TODO-API, which returns TODO items as a JSON string. We will also create a log message that should later contain some trace information.

```kotlin 
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

### Adding Micrometer Tracing

In the next step, we will add the Micrometer tracing dependencies to our `build.gradle.kts` file. Since Micrometer supports different trace formats and vendors, the dependencies are separated, and we only import what we need. To keep all dependencies synchronized, we use the Micrometer Tracing BOM (Bill of Materials). Additionally, we add core dependencies and bridges to convert Micrometer Tracing into OpenTelemetry format (other formats are also available).

```gradle
implementation(platform("io.micrometer:micrometer-tracing-bom:1.0.0"))
implementation("io.micrometer:micrometer-tracing")
implementation("io.micrometer:micrometer-tracing-bridge-otel")
```

We also need to add exporter dependencies to export the created traces. In this example, we will use the Zipkin exporter maintained by OpenTelemetry and supported by Micrometer Tracing.

```gradle
implementation("io.opentelemetry:opentelemetry-exporter-zipkin")
```

### Configuration

Configuration is an essential step in setting up trace collection. The configuration file `application.yaml` is located in the `src/main/resources` directory.

First, we must enable trace collection in the management settings. We will set the trace sampling rate to 1 (default is 0.1), so a trace is created for each call received by the service. In production systems with a large number of requests, you may only want to trace some calls. Additionally, we can define the endpoint URL to which the Zipkin exporter should send traces.
Finally, we must update the default logging pattern to include trace and span IDs.
```yaml
management:
  tracing:
    enabled: true
    sampling.probability: 1.0

  zipkin.tracing.endpoint: http://localhost:9411/api/v2/spans

logging.pattern.level: "trace_id=%mdc{traceId} span_id=%mdc{spanId} trace_flags=%mdc{traceFlags} %p"
```

## 2. Testing

Now that we have completed the service setup, we can run it. By default, the server should start on port 8080. Then, you can call the endpoint we created at `http://localhost:8080/test` by opening a browser. Below is the response content:

```json
{  "userId" :  1 ,  "id" :  1 ,  "title" :  "delectus aut autem" ,  "completed" :  false  }
```

To view the actual trace created when calling the endpoint, we need to collect and view them. In this tutorial, we will use the `Zipkin` exporter to export data to **Guance**. Of course, other systems such as Zipkin, Grafana Loki, or Datadog can also be used.

Now you can call the endpoint of our Spring Boot service again. Afterward, when you search for any tracing in **Guance**, you should be able to find the trace information for the endpoint request.

![Img](../images/guance_tracing.png)


## 3. Issues

At first glance, everything seems to be running well. However, we have two issues.

> Some issues have been addressed in the [*Micrometer Tracing* documentation](https://micrometer.io/docs/observation#instrumentation_of_reactive_libraries_after_reactor_3_5_3).

### Missing Data in Logs
If we look at the application logs, we can see the log messages emitted when calling the endpoint.
```txt
trace_id= span_id= trace_flags= INFO 43636 --- [DefaultExecutor] com.example.tracing.Controller           : test log with tracing info
```

As you can see, `trace_id` and `span_id` are not set. This is because `Micrometer Tracing` cannot easily handle trace context in reactive streams. Additionally, the Kotlin coroutine wrapper for reactive streams hides the trace context. Therefore, we must defer the current reactive stream context to obtain trace information. In practice, it looks like this:

```kotlin
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

For better reusability, we can extract the sample code into a separate function.
```kotlin
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

If we now start the application and call our endpoint, we should be able to see the `trace_id` in the logs.

```txt
trace_id=6c0053eba01199f194f5f76ff8d61917 span_id=967d591266756905 trace_flags= INFO 45139 --- [DefaultExecutor] com.example.tracing.Controller           : test log with tracing info
```

### No Trace Information from WebClient Call
The second issue can be discovered by looking at the trace in **Guance**. It only shows the parent trace of the endpoint but does not display the child spans of the WebClient call. Theoretically, Spring WebClient and RestTemplate are automatically instrumented by Micrometer. However, if we look at the code, we are using a static builder method for WebClient. To get automatic trace collection from WebClient, we need to use the builder bean provided by the Spring framework. It can be injected into our `Controller` class via its constructor.


```kotlin
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
After adjusting the code above and recalling the endpoint, we can see the `WebClient` spans in **Guance**. Micrometer Tracing will also automatically include the `trace_id`. For example, if we call another microservice with trace capabilities, it can obtain the ID and send additional information to **Guance**.
![Img](../images/guance_trace_webclient.png)



## 4. Observability Guidelines
Micrometer Tracing automatically handles many things for us in Spring. However, sometimes we may want to add specific information to trace spans or observe specific parts of the application that are not incoming or outgoing calls.

### Adding Span Tags
We can define custom tags and add them to the current observation to enhance trace data. To retrieve the current trace, we can use the `ObservationRegistry` bean. Similar to the logging issue, we must use a wrapper function to get the correct context.

```kotlin
@GetMapping("/test")
suspend fun test(): String {

  observeCtx {
    val currentObservation = observationRegistry.currentObservation
    currentObservation?.highCardinalityKeyValue("test_key", "test sample value")
  }

  // ...
}
```

After adding this code, we can see our custom tags and their values in **Guance**.

![Img](../images/guance_trace_tag.png)



### Custom Observability
Creating custom observables (spans) using the Micrometer API is usually straightforward. However, when using reactive streams and coroutines, we need help with context trace propagation. If we create a new observation in the endpoint handler, it will be treated as a separate trace. To make the code reusable, we can write a simple wrapper function to create new observations. It works similarly to the one we created earlier for using `trace_id`.

```kotlin
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
This function can wrap any suspend function in a new observation. Once the given function is executed, it automatically stops the observation. Additionally, it captures any errors that occur and attaches them to the trace.

We can now apply this function to observe any code, such as the execution of `delay`.

```kotlin
@GetMapping("/test")
suspend fun test(): String {

  runObserved("delay", observationRegistry) {
    delay(1.seconds)
  }

  // ....
}
```
Adding this code to the endpoint handler will show a custom span for the operation in **Guance**.

![Img](../images/guance_trace_delay.png)



## 5. Database Trace Collection

A typical Spring Boot application usually connects to a database in the actual application. To leverage the reactive stack, it is recommended to use the [R2DBC](https://r2dbc.io/) API instead of JDBC.

Since `Micrometer Tracing` is a relatively new technology, there is currently no available automatic tracing. However, the Spring team is working on creating automatic configurations. An experimental repository can be found [here](https://github.com/spring-projects-experimental/r2dbc-micrometer-spring-boot).

For the current project, we need to add the following dependencies to `build.gradle.kts`. For easy testing, we will not use a real database but an [H2 in-memory database](https://www.h2database.com/html/main.html).

```gradle
 implementation("org.springframework.boot:spring-boot-starter-data-r2dbc")
 runtimeOnly("com.h2database:h2")
 runtimeOnly("io.r2dbc:r2dbc-h2")

 // R2DBC micrometer auto tracing
 implementation("org.springframework.experimental:r2dbc-micrometer-spring-boot:1.0.2")
```
In the `Kotlin` code, we add a simple CRUD repository with coroutine support. As shown below:

```kotlin
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

Calling our endpoint will add another span. The new span is named `query` and includes multiple labels, including the SQL query executed by [Spring Data R2DBC](https://spring.io/projects/spring-data-r2dbc).

![Img](../images/guance_trace_db.png)


## Conclusion

Micrometer and the new tracing extension unify the observability technology stack for `Spring Boot 3` and higher versions. It provides a good abstraction for different tracing solutions used by various companies and their technology stacks. Therefore, it simplifies the work of developers.

In terms of reactive programming with Spring WebFlux, there is still potential for improvement, especially with Kotlin. The [Micrometer team is actively discussing with the Project Reactor team](https://projectreactor.io/) (the reactive library used by Spring WebFlux) to simplify the use of Micrometer Tracing in the reactive stack.

## Reference Resources

[kotlin-spring-boot-tracing-example](https://github.com/lrwh/kotlin-spring-boot-tracing-example)

[micrometer-metrics](https://github.com/micrometer-metrics/tracing)

[micrometer tracing](https://micrometer.io/docs/tracing)

[r2dbc-micrometer-spring-boot](https://github.com/spring-projects-experimental/r2dbc-micrometer-spring-boot)