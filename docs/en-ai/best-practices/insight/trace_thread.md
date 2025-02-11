# Best Practices for Passing Trace in Multi-threaded Asynchronous Systems

Common implementations of asynchronous threads in JAVA include:

- `new Thread`
- `ExecutorService`

Of course, there are others like `fork-join`, which will be mentioned later. This document mainly focuses on these two scenarios in conjunction with DDTrace and Spring Boot.

## Introducing the DDTrace SDK

```xml
<properties>
    <java.version>1.8</java.version>
    <dd.version>1.21.0</dd.version>
</properties>
<dependencies>
    <dependency>
        <groupId>com.datadoghq</groupId>
        <artifactId>dd-trace-api</artifactId>
        <version>${dd.version}</version>
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
    ...
```

For more information on using the DDTrace SDK, refer to the [DDTrace API Usage Guide](/best-practices/insight/ddtrace-skill-api/).

## Logback Configuration

Configure `logback` to output `traceId` and `spanId`. Apply the following `pattern` to all `appender`.

```xml
<property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />
```

If trace information is generated, it will appear in the logs.

## `new Thread`

Implement a simple interface that uses `logback` to log information and observe the log output.

```java
@RequestMapping("/thread")
@ResponseBody
public String threadTest(){
    logger.info("this func is threadTest.");
    return "success";
}
```

After making a request, the logs look like this:

```txt
2023-10-23 11:33:09.983 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.CalcFilter - [doFilter,28] springboot-server 7209831467195902001 958235974016818257 - START /thread
host			localhost:8086
connection			Keep-Alive
user-agent			Apache-HttpClient/4.5.14 (Java/17.0.7)
accept-encoding			br,deflate,gzip,x-gzip
2023-10-23 11:33:10.009 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,277] springboot-server 7209831467195902001 2587871298938674772 - this func is threadTest.
2023-10-23 11:33:10.022 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.CalcFilter - [doFilter,34] springboot-server 7209831467195902001 958235974016818257 - END : /thread took 39ms
```

The logs contain trace information where `7209831467195902001` is the `traceId` and `2587871298938674772` is the `spanId`.

Add `new Thread` to create a new thread.

```java
@RequestMapping("/thread")
@ResponseBody
public String threadTest(){
    logger.info("this func is threadTest.");
    new Thread(() -> {
        logger.info("this is new Thread.");
    }).start();
    return "success";
}
```

Make a request and observe the log output.

```txt
2023-10-23 11:40:00.994 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,277] springboot-server 319673369251953601 5380270359912403278 - this func is threadTest.
2023-10-23 11:40:00.995 [Thread-10] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,279] springboot-server   - this is new Thread.
```

From the log output, it's clear that the `new Thread` method does not pass the `Trace` information.

### Why ThreadLocal Does Not Work

**ThreadLocal** provides local thread variables, unique to each thread.

To facilitate usage, we create a utility class `ThreadLocalUtil`.

```java
public static final ThreadLocal<Span> THREAD_LOCAL = new ThreadLocal<>();
```

Store the current Span information in `ThreadLocal`.

```java
@RequestMapping("/thread")
@ResponseBody
public String threadTest(){
    logger.info("this func is threadTest.");
    ThreadLocalUtil.setValue(GlobalTracer.get().activeSpan());
    logger.info("current traceId:{}", GlobalTracer.get().activeSpan().context().toTraceId());

    new Thread(() -> {
        logger.info("this is new Thread.");
        logger.info("new Thread get span:{}", ThreadLocalUtil.getValue());
    }).start();
    return "success";
}
```

Make a request and observe the log output.

```txt
2023-10-23 14:14:02.339 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 4492960774800816442 4097884453719637622 - this func is threadTest.
2023-10-23 14:14:02.340 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 4492960774800816442 4097884453719637622 - current traceId:4492960774800816442
2023-10-23 14:14:02.341 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,283] springboot-server   - this is new Thread.
2023-10-23 14:14:02.342 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,284] springboot-server   - new Thread get span:null
```

In the new thread, the value obtained from the parent thread's `ThreadLocal` is `null`.

Analyzing the source code of `ThreadLocal`, when using the `set()` method, `Thread.currentThread()` is used as the key for storing data in `ThreadLocal`. When accessing the variable from a new thread, the key changes, hence no value is retrieved.

```java
public class ThreadLocal<T> {
    ...
   public void set(T value) {
        Thread t = Thread.currentThread();
        ThreadLocalMap map = getMap(t);
        if (map != null) {
            map.set(this, value);
        } else {
            createMap(t, value);
        }
    }
    public T get() {
        Thread t = Thread.currentThread();
        ThreadLocalMap map = getMap(t);
        if (map != null) {
            ThreadLocalMap.Entry e = map.getEntry(this);
            if (e != null) {
                @SuppressWarnings("unchecked")
                T result = (T)e.value;
                return result;
            }
        }
        return setInitialValue();
    }
    ...
}
```

### InheritableThreadLocal

`InheritableThreadLocal` extends `ThreadLocal` to provide inheritance of values from parent threads to child threads: when a child thread is created, it receives initial values for all inheritable thread-local variables that have values in the parent thread.

Official explanation:

```java
This class extends ThreadLocal to provide inheritance of values from parent thread to child thread: when a child thread is created, the child receives initial values for all inheritable thread-local variables for which the parent has values. Normally the child's values will be identical to the parent's; however, the child's value can be made an arbitrary function of the parent's by overriding the childValue method in this class.
Inheritable thread-local variables are used in preference to ordinary thread-local variables when the per-thread attribute being maintained in the variable (e.g., User ID, Transaction ID) must be automatically transmitted to any child threads that are created.
Note: During the creation of a new thread, it is possible to opt out of receiving initial values for inheritable thread-local variables.
```

To facilitate usage, we create a utility class `InheritableThreadLocalUtil.java` to store Span information.

```java
public static final InheritableThreadLocal<Span> THREAD_LOCAL = new InheritableThreadLocal<>();
```

Replace `ThreadLocalUtil` with `InheritableThreadLocalUtil`.

```java
@RequestMapping("/thread")
@ResponseBody
public String threadTest(){
    logger.info("this func is threadTest.");
    InheritableThreadLocalUtil.setValue(GlobalTracer.get().activeSpan());
    logger.info("current traceId:{}", GlobalTracer.get().activeSpan().context().toTraceId());

    new Thread(() -> {
        logger.info("this is new Thread.");
        logger.info("new Thread get span:{}", InheritableThreadLocalUtil.getValue());
    }).start();
    return "success";
}
```

Make a request and observe the log output.

```
2023-10-23 14:37:05.415 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 8754268856419787293 5276611939997441402 - this func is threadTest.
2023-10-23 14:37:05.416 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 8754268856419787293 5276611939997441402 - current traceId:8754268856419787293
2023-10-23 14:37:05.416 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,283] springboot-server   - this is new Thread.
2023-10-23 14:37:05.417 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,284] springboot-server   - new Thread get span:datadog.trace.instrumentation.opentracing32.OTSpan@712ad7e2
```

From the above log, the thread internal has obtained the `span` object address, but the log `pattern` part did not output `Trace` information. The reason lies in the fact that `DDTrace` instruments `logback`'s `getMDCPropertyMap()` and `getMdc()` methods, putting Trace information into `MDC`.

```java
@Advice.OnMethodExit(suppress = Throwable.class)
public static void onExit(
    @Advice.This ILoggingEvent event,
    @Advice.Return(typing = Assigner.Typing.DYNAMIC, readOnly = false)
        Map<String, String> mdc) {

  if (mdc instanceof UnionMap) {
    return;
  }

  AgentSpan.Context context =
      InstrumentationContext.get(ILoggingEvent.class, AgentSpan.Context.class).get(event);

  // Nothing to add so return early
  if (context == null && !AgentTracer.traceConfig().isLogsInjectionEnabled()) {
    return;
  }

  Map<String, String> correlationValues = new HashMap<>(8);

  if (context != null) {
    DDTraceId traceId = context.getTraceId();
    String traceIdValue =
        InstrumenterConfig.get().isLogs128bTraceIdEnabled() && traceId.toHighOrderLong() != 0
            ? traceId.toHexString()
            : traceId.toString();
    correlationValues.put(CorrelationIdentifier.getTraceIdKey(), traceIdValue);
    correlationValues.put(
        CorrelationIdentifier.getSpanIdKey(), DDSpanId.toString(context.getSpanId()));
  }else{
    AgentSpan span = activeSpan();
    if (span!=null){
      correlationValues.put(
          CorrelationIdentifier.getTraceIdKey(), span.getTraceId().toString());
      correlationValues.put(
          CorrelationIdentifier.getSpanIdKey(), DDSpanId.toString(span.getSpanId()));
    }
  }

  String serviceName = Config.get().getServiceName();
  if (null != serviceName && !serviceName.isEmpty()) {
    correlationValues.put(Tags.DD_SERVICE, serviceName);
  }
  String env = Config.get().getEnv();
  if (null != env && !env.isEmpty()) {
    correlationValues.put(Tags.DD_ENV, env);
  }
  String version = Config.get().getVersion();
  if (null != version && !version.isEmpty()) {
    correlationValues.put(Tags.DD_VERSION, version);
  }

  mdc = null != mdc ? new UnionMap<>(mdc, correlationValues) : correlationValues;
}
```

To ensure that the newly created thread's logs also obtain the parent thread's Trace information, you can create a `span` that acts as a child `span` of the parent thread to achieve continuity.

```java
new Thread(() -> {
    logger.info("this is new Thread.");
    logger.info("new Thread get span:{}", InheritableThreadLocalUtil.getValue());
    Span span = null;
    try {
        Tracer tracer = GlobalTracer.get();
        span = tracer.buildSpan("thread")
                .asChildOf(InheritableThreadLocalUtil.getValue())
                .start();
        span.setTag("threadName", Thread.currentThread().getName());
        GlobalTracer.get().activateSpan(span);
        logger.info("thread:{}", span.context().toTraceId());
    } finally {
        if (span != null) {
            span.finish();
        }
    }
}).start();
```

Make a request and observe the log output.

```txt
2023-10-23 14:51:28.969 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 2303424716416355903 7690232490489894572 - this func is threadTest.
2023-10-23 14:51:28.969 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 2303424716416355903 7690232490489894572 - current traceId:2303424716416355903
2023-10-23 14:51:28.970 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,283] springboot-server   - this is new Thread.
2023-10-23 14:51:28.971 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,284] springboot-server   - new Thread get span:datadog.trace.instrumentation.opentracing32.OTSpan@c3a1aae
2023-10-23 14:51:28.971 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,292] springboot-server   - thread:2303424716416355903
2023-10-23 14:51:28.971 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,294] springboot-server 2303424716416355903 5766505477412800739 - thread:2303424716416355903
```

Why are there two log lines in the thread without Trace information in the `pattern`? The reason is that the current thread's internal `span` is created after the log output. Simply place the log statements below the `span` creation.

```java
new Thread(() -> {
    Span span = null;
    try {
        Tracer tracer = GlobalTracer.get();
        span = tracer.buildSpan("thread")
                .asChildOf(InheritableThreadLocalUtil.getValue())
                .start();
        span.setTag("threadName", Thread.currentThread().getName());
        GlobalTracer.get().activateSpan(span);
        logger.info("this is new Thread.");
        logger.info("new Thread get span:{}", InheritableThreadLocalUtil.getValue());
        logger.info("thread:{}", span.context().toTraceId());
    } finally {
        if (span != null) {
            span.finish();
        }
    }
}).start();
```

Make a request and observe the log output.

```
2023-10-23 15:01:00.490 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 472828375731745486 6076606716618097397 - this func is threadTest.
2023-10-23 15:01:00.491 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 472828375731745486 6076606716618097397 - current traceId:472828375731745486
2023-10-23 15:01:00.492 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,291] springboot-server 472828375731745486 9214366589561638347 - this is new Thread.
2023-10-23 15:01:00.492 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,292] springboot-server 472828375731745486 9214366589561638347 - new Thread get span:datadog.trace.instrumentation.opentracing32.OTSpan@12fd40f0
2023-10-23 15:01:00.493 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,293] springboot-server 472828375731745486 9214366589561638347 - thread:472828375731745486
```

## ExecutorService

Create an API and use `Executors` to create an `ExecutorService` object.

```java
@RequestMapping("/execThread")
@ResponseBody
public String ExecutorServiceTest(){
    ExecutorService executor = Executors.newCachedThreadPool();
    logger.info("this func is ExecutorServiceTest.");
    executor.submit(() -> {
        logger.info("this is executor Thread.");
    });
    return "ExecutorService";
}
```

Make a request and observe the log output.

```txt
2023-10-23 15:24:41.828 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [ExecutorServiceTest,309] springboot-server 2170215511602500482 4370366221958823908 - this func is ExecutorServiceTest.
2023-10-23 15:24:41.832 [pool-2-thread-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$ExecutorServiceTest$2,311] springboot-server 2170215511602500482 4370366221958823908 - this is executor Thread.
```

`ExecutorService` thread pool automatically passes Trace information due to DDTrace instrumentation of the corresponding components.

JAVA supports trace propagation for many thread component frameworks such as `ForkJoinTask`, `ForkJoinPool`, `TimerTask`, `FutureTask`, `ThreadPoolExecutor`, etc.

![Img](../images/trace_thread_1.png)

## Source Code

[springboot-ddtrace-server](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)