# Trace 在多线程异步体系下传递最佳实践

JAVA 线程异步常见的实现方式有：

- `new Thread`
- `ExecutorService`

当然还有其他的，比如`fork-join`，这些下文会有提及，下面主要针对这两种场景结合 DDTrace 和 Springboot 下进行实践。

## 引入 DDTrace sdk

```pom

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

关于 DDTrace sdk 使用方式参考文档[`ddtrace-api`使用指南](/best-practices/insight/ddtrace-skill-api/)

## Logback 配置

配置 `logback` ，让其输出 `traceId` 和 `spanId`,将以下 `pattern` 应用到所有的 `appender` 中。

```xml
<property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />
```

如果有链路信息产生，则会在日志里面输出 Trace 信息。

## new Thread

实现一个简单的接口，使用 `logback` 输出日志信息，观察日志输出情况

```java
    @RequestMapping("/thread")
    @ResponseBody
    public String threadTest(){
        logger.info("this func is threadTest.");
        return "success";
    }
```
请求后，日志如下

```txt
2023-10-23 11:33:09.983 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.CalcFilter - [doFilter,28] springboot-server 7209831467195902001 958235974016818257 - START /thread
host			localhost:8086
connection			Keep-Alive
user-agent			Apache-HttpClient/4.5.14 (Java/17.0.7)
accept-encoding			br,deflate,gzip,x-gzip
2023-10-23 11:33:10.009 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,277] springboot-server 7209831467195902001 2587871298938674772 - this func is threadTest.
2023-10-23 11:33:10.022 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.CalcFilter - [doFilter,34] springboot-server 7209831467195902001 958235974016818257 - END : /thread耗时：39

```

日志里面有 trace 信息产生， `7209831467195902001`为 `traceId`，`2587871298938674772`为 `spanId`。


向该接口加入 new Thread ，创建一个线程。

```java
    @RequestMapping("/thread")
    @ResponseBody
    public String threadTest(){
        logger.info("this func is threadTest.");
        new Thread(()->{
            logger.info("this is new Thread.");
        }).start();
        return "success";
    }
```

通过请求对应的 URL，观察日志输出情况。

```txt
2023-10-23 11:40:00.994 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,277] springboot-server 319673369251953601 5380270359912403278 - this func is threadTest.
2023-10-23 11:40:00.995 [Thread-10] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,279] springboot-server   - this is new Thread.
```

通过日志输出发现，`new Thread `方式，并不能够输出 `Trace` 信息，也就是说 `Trace` 并未传递进去。

如果我们显示的把 `Trace` 信息传递进去是不是就可以了，说干就干。

### ThreadLocal 为什么不行

**ThreadLocal** 本地线程变量，该变量为当前线程独有。

为了方便使用，我们创建一个工具类 `ThreadLocalUtil`。

```java
public static final ThreadLocal<Span> THREAD_LOCAL = new ThreadLocal<>();
```

然后将当前 Span 信息存储到 `ThreadLocal`。

```java
    @RequestMapping("/thread")
    @ResponseBody
    public String threadTest(){
        logger.info("this func is threadTest.");
        ThreadLocalUtil.setValue(GlobalTracer.get().activeSpan());
        logger.info("current traceiD:{}",GlobalTracer.get().activeSpan().context().toTraceId());

        new Thread(()->{
            logger.info("this is new Thread.");
            logger.info("new Thread get span:{}",ThreadLocalUtil.getValue());
        }).start();
        return "success";
    }
```

通过请求对应的 URL，观察日志输出情况。

```txt
2023-10-23 14:14:02.339 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 4492960774800816442 4097884453719637622 - this func is threadTest.
2023-10-23 14:14:02.340 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 4492960774800816442 4097884453719637622 - current traceiD:4492960774800816442
2023-10-23 14:14:02.341 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,283] springboot-server   - this is new Thread.
2023-10-23 14:14:02.342 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,284] springboot-server   - new Thread get span:null
```

在新线程内获取外部线程 `ThreadLocal`，获取到的值为 `null`。

通过分析`ThreadLocal`源码发现，当我们使用 `ThreadLocal` 的 `set()` 方法时，`ThreadLocal` 内部使用了`Thread.currentThread()`作为了 `ThreadLocal` 的数据存储的 `key`，也就是说当从新线程里面获取变量信息，`key` 发生了变化，所以取不到值。

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

`InheritableThreadLocal` 扩展了 `ThreadLocal`，以提供从父线程到子线程的值继承：当创建子线程时，子线程接收父线程具有值的所有可继承线程局部变量的初始值。

官方解释：

```java
This class extends ThreadLocal to provide inheritance of values from parent thread to child thread: when a child thread is created, the child receives initial values for all inheritable thread-local variables for which the parent has values. Normally the child's values will be identical to the parent's; however, the child's value can be made an arbitrary function of the parent's by overriding the childValue method in this class.
Inheritable thread-local variables are used in preference to ordinary thread-local variables when the per-thread-attribute being maintained in the variable (e.g., User ID, Transaction ID) must be automatically transmitted to any child threads that are created.
Note: During the creation of a new thread, it is possible to opt out of receiving initial values for inheritable thread-local variables.
```

为了方便使用，我们创建一个工具类 `InheritableThreadLocalUtil.java`，用于存放 Span 信息

```java
public static final InheritableThreadLocal<Span> THREAD_LOCAL = new InheritableThreadLocal<>();
```

将 `ThreadLocalUtil` 换成 `InheritableThreadLocalUtil`

```java
@RequestMapping("/thread")
    @ResponseBody
    public String threadTest(){
        logger.info("this func is threadTest.");
        InheritableThreadLocalUtil.setValue(GlobalTracer.get().activeSpan());
        logger.info("current traceiD:{}",GlobalTracer.get().activeSpan().context().toTraceId());

        new Thread(()->{
            logger.info("this is new Thread.");
            logger.info("new Thread get span:{}",InheritableThreadLocalUtil.getValue());
        }).start();
        return "success";
    }
```

通过请求对应的 URL，观察日志输出情况。

```
2023-10-23 14:37:05.415 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 8754268856419787293 5276611939997441402 - this func is threadTest.
2023-10-23 14:37:05.416 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 8754268856419787293 5276611939997441402 - current traceiD:8754268856419787293
2023-10-23 14:37:05.416 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,283] springboot-server   - this is new Thread.
2023-10-23 14:37:05.417 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,284] springboot-server   - new Thread get span:datadog.trace.instrumentation.opentracing32.OTSpan@712ad7e2
```

通过观测以上日志信息，线程内部已经获取到了 `span` 对象地址，但日志 `pattern` 部分并没有 `Trace` 信息输出，原因在于，`DDTrace` 对 `logback` 的`getMDCPropertyMap()`和 `getMdc()`方法做了插桩处理,将 Trace 信息 `put` 到 `MDC` 中。

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

为了让新创建的线程的日志也能够获取父线程 Trace 信息，可以通过创建 `span` 来实现，该 `span` 需要作为父线程的子 `span`才能完成串联。

```java
    new Thread(()->{
        logger.info("this is new Thread.");
        logger.info("new Thread get span:{}",InheritableThreadLocalUtil.getValue());
        Span span = null;
        try {
            Tracer tracer = GlobalTracer.get();
            span = tracer.buildSpan("thread")
                    .asChildOf(InheritableThreadLocalUtil.getValue())
                    .start();
            span.setTag("threadName", Thread.currentThread().getName());
            GlobalTracer.get().activateSpan(span);
            logger.info("thread:{}",span.context().toTraceId());
        }finally {
            if (span!=null) {
                span.finish();
            }
        }
    }).start();
```

通过请求对应的 URL，观察日志输出情况。

```txt
2023-10-23 14:51:28.969 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 2303424716416355903 7690232490489894572 - this func is threadTest.
2023-10-23 14:51:28.969 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 2303424716416355903 7690232490489894572 - current traceiD:2303424716416355903
2023-10-23 14:51:28.970 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,283] springboot-server   - this is new Thread.
2023-10-23 14:51:28.971 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,284] springboot-server   - new Thread get span:datadog.trace.instrumentation.opentracing32.OTSpan@c3a1aae
2023-10-23 14:51:28.971 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,292] springboot-server   - thread:2303424716416355903
2023-10-23 14:51:28.971 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,294] springboot-server 2303424716416355903 5766505477412800739 - thread:2303424716416355903
```

为何线程内有两条日志的 `pattern` 没有输出 Trace 信息？原因在于当前线程内部的 `span` 是在日志输出之后创建的，只需要将日志放到 `span` 创建下面即可。

```java
    new Thread(()->{
        Span span = null;
        try {
            Tracer tracer = GlobalTracer.get();
            span = tracer.buildSpan("thread")
                    .asChildOf(InheritableThreadLocalUtil.getValue())
                    .start();
            span.setTag("threadName", Thread.currentThread().getName());
            GlobalTracer.get().activateSpan(span);
            logger.info("this is new Thread.");
            logger.info("new Thread get span:{}",InheritableThreadLocalUtil.getValue());
            logger.info("thread:{}",span.context().toTraceId());
        }finally {
            if (span!=null) {
                span.finish();
            }
        }
    }).start();
```

通过请求对应的 URL，观察日志输出情况。

```
2023-10-23 15:01:00.490 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,278] springboot-server 472828375731745486 6076606716618097397 - this func is threadTest.
2023-10-23 15:01:00.491 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [threadTest,280] springboot-server 472828375731745486 6076606716618097397 - current traceId:472828375731745486
2023-10-23 15:01:00.492 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,291] springboot-server 472828375731745486 9214366589561638347 - this is new Thread.
2023-10-23 15:01:00.492 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,292] springboot-server 472828375731745486 9214366589561638347 - new Thread get span:datadog.trace.instrumentation.opentracing32.OTSpan@12fd40f0
2023-10-23 15:01:00.493 [Thread-9] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$threadTest$1,293] springboot-server 472828375731745486 9214366589561638347 - thread:472828375731745486

```

## ExecutorService

创建一个 API ，并通过`Executors` 创建 `ExecutorService`对象。

```java
    @RequestMapping("/execThread")
    @ResponseBody
    public String ExecutorServiceTest(){
        ExecutorService executor = Executors.newCachedThreadPool();
        logger.info("this func is ExecutorServiceTest.");
        executor.submit(()->{
            logger.info("this is executor Thread.");
        });
        return "ExecutorService";
    }
```
通过请求对应的 URL，观察日志输出情况。

```txt
2023-10-23 15:24:41.828 [http-nio-8086-exec-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [ExecutorServiceTest,309] springboot-server 2170215511602500482 4370366221958823908 - this func is ExecutorServiceTest.
2023-10-23 15:24:41.832 [pool-2-thread-1] INFO  com.zy.observable.ddtrace.controller.IndexController - [lambda$ExecutorServiceTest$2,311] springboot-server 2170215511602500482 4370366221958823908 - this is executor Thread.
```

`ExecutorService` 线程池方式会自动传递 Trace 信息，这种自动的能力源于 DDTrace 对相应组件埋点操作实现。

JAVA 对于很多线程组件框架都做了链路传递的支持，如：`ForkJoinTask`、`ForkJoinPool`、`TimerTask`、`FutureTask`、`ThreadPoolExecutor`等等。

![Img](../images/trace_thread_1.png)



## 源码

[springboot-ddtrace-server](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)
