# DDtrace Custom Instrumentation

---

> _Author: Liu Rui_

## Introduction to Java Instrumentation

Instrumentation: Instrumentation (some people refer to it as "probe," others as "embedding points"; translation variations exist but the understanding is key)

Java Instrumentation is a new feature introduced in [Java](https://baike.baidu.com/item/Java%20) SE 6. Through [java.lang.instrument](https://baike.baidu.com/item/java.lang.instrument/5179837), developers can implement instrumentation using Java code, providing a way to solve problems via Java code.

Using Instrumentation, developers can build an agent program (Agent) independent of the application to monitor and assist programs running on the JVM, even replacing and modifying certain class definitions. With this capability, developers can achieve more flexible runtime [virtual machine](https://baike.baidu.com/item/%E8%99%9A%E6%8B%9F%E6%9C%BA) monitoring and Java class manipulation. This feature essentially provides a virtual machine-level supported AOP implementation method, allowing developers to achieve some AOP functionalities without upgrading or modifying the JDK.

In [Java](https://baike.baidu.com/item/Java%20) SE 6, the instrumentation package has been enhanced with more powerful features: post-start instrumentation, [native code](https://baike.baidu.com/item/%E6%9C%AC%E5%9C%B0%E4%BB%A3%E7%A0%81) instrumentation, and dynamically changing the classpath. These changes mean that Java has stronger dynamic control and interpretation capabilities, making the Java language more flexible.

## Structure Analysis of DDtrace Custom Instrumentation

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-1.png)

1. Decorator: Decorator used for decorating Instrumentation. `BaseDecorator` is a base decorator, so custom decorators must inherit from `BaseDecorator` or its subclasses. Operations on spans, such as adding custom tags, are implemented through `BaseDecorator`.
1. Instrumentation: The instrumentation program uses the `@AutoService(Instrumenter.class)` annotation to register the current class as an instrumentation application. When the agent starts, it loads classes annotated with `@AutoService(Instrumenter.class)`.
1. Advice: Enhances methods that need instrumentation, mainly providing two method-level annotations `@Advice.OnMethodEnter` and `@Advice.OnMethodExit`, representing calls when entering and exiting a method.
1. Inject/Extract: Represents injection/extraction, not mandatory to implement, primarily used for injecting and extracting trace information like traceid, spanid, and related propagation parameters.

### Decorator Class Diagram

Partial class diagram shown here.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-2.png)

### Instrumentation Class Diagram

Partial class diagram shown here.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-3.png)

`Instrumenter` is an interface providing rich interfaces for implementation based on different definitions.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-4.png)

`HasAdvice`: Wraps method handling, commonly known as embedding points, mainly providing an interface method for registering methods that need embedding points, which can be applied to multiple methods:

```java
/**
 * Instrumenters should register each advice transformation by calling {@link
 * AdviceTransformation#applyAdvice(ElementMatcher, String)} one or more times.
 */
void adviceTransformations(AdviceTransformation transformation);
```

Tracing: Used for tracing.

```java
/** Parent class for all tracing related instrumentations */
abstract class Tracing extends Default{...}
```

Profiling: Represents profiling instrumentation.

```java
/** Parent class for all profiling related instrumentations */
abstract class Profiling extends Default{...}
```

CiVisibility: CI instrumentation type.

```java
/** Parent class for all CI related instrumentations */
abstract class CiVisibility extends Default {...}
```

Default: Default implementation.

```java
@SuppressFBWarnings("IS2_INCONSISTENT_SYNC")
abstract class Default implements Instrumenter, HasAdvice{...}
```

### Inject Class Diagram

Setter<C> is fully named: `AgentPropagation.Setter<C>`. Partial class diagram shown here.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-5.png)

### Extract Class Diagram

ContextVisitor<C> is fully named: `AgentPropagation.ContextVisitor<C>`. Partial class diagram shown here.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-6.png)

Both Inject and Extract involve Propagation (propagator). For details on the usage and introduction of propagators, refer to the document [Custom traceId Implementation Using extract + TextMapAdapter](/best-practices/monitoring/ddtrace-custom-traceId).

## Practical Example: Custom DDtrace Dubbo Instrumentation

### Integration Approach

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-7.png)

1. Create the `DubboInstrumentation` class to configure instrumentation-related information;
1. Use `adviceTransformations` to enhance relevant methods; business logic enhancements are implemented in the `RequestAdvice` class, mainly implementing two methods: `@Advice.OnMethodEnter` and `@Advice.OnMethodExit`, representing calls when entering and exiting a method;
1. `DubboDecorator` acts as a decorator, performing operations such as setting related tags or closing a span;
1. Inject/Extract represents injection/extraction, primarily used for injecting and extracting trace information like traceid, spanid, and related propagation parameters. `DubboHeadersInjectAdapter` is mainly used by consumers to propagate traceId, spanId, etc., while providers extract related parameters using `DubboHeadersExtractAdapter` to build spans.

### Integration Steps

#### 1. In the `dd-java-agent\instrumentation` directory, create a module using Gradle.

<font color="red">Since dubbo has differences in package names, class names, and method names across major versions, it's beneficial to include the corresponding major version number when creating the module, e.g., `dubbo-2.7`, indicating support for dubbo 2.7 and above. Specific version support can be modified in the `build.gradle` file within the current module. Since `build.gradle` is not ideal for maintenance, we rename it to `dubbo-2.7.gradle`.</font>

```groovy
muzzle {
  pass {
    group = "org.apache.dubbo"
    module = "dubbo"
    versions = "[2.7.0,)"
//    assertInverse = true
  }
}

apply from: "$rootDir/gradle/java.gradle"

apply plugin: 'org.unbroken-dome.test-sets'

dependencies {
  compileOnly(group: 'org.apache.dubbo', name: 'dubbo', version: '2.7.0')
}

testSets {
  latestDepTest {
    dirName = 'test'
  }
}

tasks.withType(Test).configureEach {
  usesService(testcontainersLimit)
}
```

Also add `dubbo-2.7.gradle` in the `settings.gradle` file.

```groovy
...
include ':dd-java-agent:instrumentation:dropwizard'
include ':dd-java-agent:instrumentation:dropwizard:dropwizard-views'
include ':dd-java-agent:instrumentation:dubbo-2.7'
include ':dd-java-agent:instrumentation:elasticsearch'
include ':dd-java-agent:instrumentation:elasticsearch:rest-5'
include ':dd-java-agent:instrumentation:elasticsearch:rest-6.4'
include ':dd-java-agent:instrumentation:elasticsearch:rest-7'
...
```

#### 2. Create the package name `datadog.trace.instrumentation.dubbo_2_7x`.

#### 3. Create the instrumentation class `DubboInstrumentation.java`

```java
package datadog.trace.instrumentation.dubbo_2_7x;

import com.google.auto.service.AutoService;
import datadog.trace.agent.tooling.Instrumenter;
import datadog.trace.bootstrap.instrumentation.api.AgentSpan;
import net.bytebuddy.description.type.TypeDescription;
import net.bytebuddy.matcher.ElementMatcher;

import java.util.Map;

import static datadog.trace.agent.tooling.bytebuddy.matcher.ClassLoaderMatchers.hasClassesNamed;
import static datadog.trace.agent.tooling.bytebuddy.matcher.HierarchyMatchers.implementsInterface;
import static datadog.trace.agent.tooling.bytebuddy.matcher.NameMatchers.nameStartsWith;
import static datadog.trace.agent.tooling.bytebuddy.matcher.NameMatchers.named;
import static java.util.Collections.singletonMap;
import static net.bytebuddy.matcher.ElementMatchers.*;

@AutoService(Instrumenter.class)
public class DubboInstrumentation extends Instrumenter.Tracing
    implements Instrumenter.ForTypeHierarchy {

  public DubboInstrumentation() {
    super("apache-dubbo");
  }

//  public static final String CLASS_NAME = "org.apache.dubbo.rpc.Filter";
  public static final String CLASS_NAME = "org.apache.dubbo.monitor.support.MonitorFilter";

  @Override
  public ElementMatcher<ClassLoader> classLoaderMatcher() {
    return hasClassesNamed(CLASS_NAME);
  }

  @Override
  public ElementMatcher<TypeDescription> hierarchyMatcher() {
    return extendsClass(named(CLASS_NAME));
  }

  @Override
  public void adviceTransformations(AdviceTransformation transformation) {
    transformation.applyAdvice(
        isMethod()
            .and(isPublic())
            .and(nameStartsWith("invoke"))
            .and(takesArguments(2))
            .and(takesArgument(0, named("org.apache.dubbo.rpc.Invoker")))
            .and(takesArgument(1, named("org.apache.dubbo.rpc.Invocation"))),
        packageName + ".RequestAdvice");
  }

  @Override
  public String[] helperClassNames() {
    return new String[]{
        packageName + ".DubboDecorator",
        packageName + ".RequestAdvice",
        packageName + ".DubboHeadersExtractAdapter",
        packageName + ".DubboHeadersInjectAdapter"
    };
  }

  @Override
  public Map<String, String> contextStore() {
    return singletonMap("org.apache.dubbo.rpc.RpcContext", AgentSpan.class.getName());
  }
}


```

Let's take a look at the source code of `org.apache.dubbo.rpc.Filter`:

```java
@SPI
public interface Filter {
    /**
     * Make sure call invoker.invoke() in your implementation.
     */
    Result invoke(Invoker<?> invoker, Invocation invocation) throws RpcException;

    interface Listener {

        void onResponse(Result appResponse, Invoker<?> invoker, Invocation invocation);

        void onError(Throwable t, Invoker<?> invoker, Invocation invocation);
    }

}
```

`Filter` is an interface, so the `implementsInterface` method is used to intercept all implementations of the `Filter` interface. `org.apache.dubbo.rpc.Filter` provides the `invoke` method with two parameters `Invoker` and `Invocation`, which will be used later.

By overriding `void adviceTransformations(AdviceTransformation transformation)`, interception of `org.apache.dubbo.rpc.Filter` is achieved.

Parameters for `applyAdvice`:

- `isMethod()`: Indicates method interception;
- `isPublic()`: Indicates public access modifier;
- `nameStartsWith("invoke")`: Method name;
- `takesArguments`: Number of arguments required by `nameStartsWith("invoke")`;
- `takesArgument`: Arguments for `nameStartsWith("invoke")`, fill according to needs. Incorrect parameter types or orders will render the instrumentation ineffective.
  - `takesArgument(0, named("org.apache.dubbo.rpc.Invoker"))`: First argument type
  - `takesArgument(1, named("org.apache.dubbo.rpc.Invocation"))`: Second argument type

`helperClassNames()`: Declares additional custom classes.

`Map<String, String> contextStore()`: Used for storing context information, mainly for storing `AgentSpan` or `AgentScope` information (such as traceid, spanid, etc.). Here, `singletonMap("org.apache.dubbo.rpc.Invocation", AgentSpan.class.getName())` indicates enhancement for `org.apache.dubbo.rpc.Invocation`.

`@AutoService` is a SPI interface specification provided by Google, processed during compilation.

The instrumentation class is core and requires the annotation `@AutoService(Instrumenter.class)` to indicate an instrumentation application. During application compilation and packaging, classes annotated with `@AutoService(Instrumenter.class)` are iterated and their class names are placed in a file named `META-INF/services/datadog.trace.agent.tooling.Instrumenter`, which is loaded by the class loader upon startup. `META-INF/services/datadog.trace.agent.tooling.Instrumenter` is auto-generated, with partial content as follows:

```groovy
...
datadog.trace.instrumentation.datastax.cassandra.CassandraClientInstrumentation
datadog.trace.instrumentation.datastax.cassandra4.CassandraClientInstrumentation
datadog.trace.instrumentation.dubbo.DubboInstrumentation
datadog.trace.instrumentation.dubbo_2_7x.DubboInstrumentation
datadog.trace.instrumentation.elasticsearch5.Elasticsearch5RestClientInstrumentation
datadog.trace.instrumentation.elasticsearch6_4.Elasticsearch6RestClientInstrumentation
datadog.trace.instrumentation.elasticsearch7.Elasticsearch7RestClientInstrumentation
datadog.trace.instrumentation.elasticsearch2.Elasticsearch2TransportClientInstrumentation
datadog.trace.instrumentation.elasticsearch5.Elasticsearch5TransportClientInstrumentation
datadog.trace.instrumentation.elasticsearch5_3.Elasticsearch53TransportClientInstrumentation
datadog.trace.instrumentation.elasticsearch6.Elasticsearch6TransportClientInstrumentation
datadog.trace.instrumentation.elasticsearch7_3.Elasticsearch73TransportClientInstrumentation
...
```

#### 4. Create `DubboDecorator`

Partial code as follows:

```java
...
public class DubboDecorator extends BaseDecorator {
  private static final Logger log = LoggerFactory.getLogger(DubboDecorator.class);
  public static final CharSequence DUBBO_REQUEST = UTF8BytesString.create("dubbo");

  public static final CharSequence DUBBO_SERVER = UTF8BytesString.create("apache-dubbo");

  public static final DubboDecorator DECORATE = new DubboDecorator();

  public static final String SIDE_KEY = "side";

  public static final String PROVIDER_SIDE = "provider";

  public static final String CONSUMER_SIDE = "consumer";

  public static final String GROUP_KEY = "group";

  public static final String VERSION = "release";
  @Override
  protected String[] instrumentationNames() {
    return new String[]{"apache-dubbo"};
  }

  @Override
  protected CharSequence spanType() {
    return DUBBO_SERVER;
  }

  @Override
  protected CharSequence component() {
    return DUBBO_SERVER;
  }

  public AgentSpan startDubboSpan(Invoker invoker, Invocation invocation) {
    URL url = invoker.getUrl();
    boolean isConsumer = isConsumerSide(url);

    String methodName = invocation.getMethodName();
    String resourceName = generateOperationName(url,invocation);
    String shortUrl = generateRequestURL(url,invocation);
    System.out.println("isConsumer : "+isConsumer);
    if (log.isDebugEnabled()) {
      log.debug("isConsumer:{},method:{},resourceName:{},shortUrl:{},longUrl:{},version:{}",
          isConsumer,
          methodName,
          resourceName,
          shortUrl,
          url.toString(),
          getVersion(url)
          );
    }
    AgentSpan span;
    RpcContext rpcContext = RpcContext.getContext();
    if (isConsumer){
      // this is consumer
      span = startSpan(DUBBO_REQUEST);
    }else{
      // this is provider
      AgentSpan.Context parentContext = propagate().extract(rpcContext, GETTER);
      span = startSpan(DUBBO_REQUEST,parentContext);
    }
    span.setTag("url", url.toString());
    span.setTag("short_url", shortUrl);
    span.setTag("method", methodName);
    span.setTag("dubbo-version",getVersion(url));
    afterStart(span);

    withMethod(span, resourceName);
    if (isConsumer){
      propagate().inject(span, rpcContext, SETTER);
//      InstrumentationContext.get(Invocation.class, AgentSpan.class).put(invocation, span);
    }
    return span;
  }

  public void withMethod(final AgentSpan span, final String methodName) {
    span.setResourceName(methodName);
  }

  @Override
  public AgentSpan afterStart(AgentSpan span) {
    return super.afterStart(span);
  }

	...
}


...
```

As an RPC framework, dubbo has both consumer and provider sides. `isConsumer` determines whether the current execution belongs to the consumer or provider side. If it's a consumer, a span is directly created, and its traceid and parentId come from propagated data from other traces, injected via `propagate().inject(span, invocation, SETTER)`. If it's a provider, `parentContext` is constructed by extracting data using `propagate().extract(invocation, GETTER)`, then the current span information is built using `parentContext`, completing the trace linkage.

#### 5. Create `RequestAdvice`

```java

public class RequestAdvice {

  @Advice.OnMethodEnter(suppress = Throwable.class)
  public static AgentScope beginRequest(@Advice.This Filter filter,@Advice.Argument(0) final Invoker invoker,
                                        @Advice.Argument(1) final Invocation invocation) {

    System.out.println(filter.getClass().getName());
    final int callDepth = CallDepthThreadLocalMap.incrementCallDepth(RpcContext.class);
    if (callDepth > 0) {
      return null;
    }

    AgentScope agentScope = DECORATE.buildSpan(invoker, invocation);
    return agentScope;
  }

  @Advice.OnMethodExit(onThrowable = Throwable.class, suppress = Throwable.class)
  public static void stopSpan(
      @Advice.Enter final AgentScope scope, @Advice.Thrown final Throwable throwable) {
    if (scope == null) {
      return;
    }
    DECORATE.onError(scope.span(), throwable);
    DECORATE.beforeFinish(scope.span());

    scope.close();
    scope.span().finish();
    CallDepthThreadLocalMap.reset(RpcContext.class);
  }
}
```

The `RequestAdvice` class mainly implements two methods. Method names can be customized. The two methods use the `@Advice.OnMethodEnter` and `@Advice.OnMethodExit` annotations, representing operations to be performed when entering and exiting a method. `CallDepthThreadLocalMap.incrementCallDepth(RpcContext.class)` prevents method re-entry, and `CallDepthThreadLocalMap.reset(RpcContext.class)` resets the rule when exiting the method.

#### 6. Compile and Package

Use `gradle shadowJar` for packaging. After packaging, the files are stored under `dd-java-agent\build\libs`.

## Source Code Address

<[dubbo-instrumentation](https://github.com/GuanceCloud/dd-trace-java/tree/v0.105.0/dd-java-agent/instrumentation/dubbo-2.7)>