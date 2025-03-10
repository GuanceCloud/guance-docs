# DDtrace Custom Instrumentation

---

> _Author: Liu Rui_

## Introduction to Java Instrumentation

Instrumentation: instrumentation (some people call it "probe", some call it "burial point"; translation is not wrong, as long as it is understood)

Java Instrumentation is a new feature in [Java](https://en.wikipedia.org/wiki/Java_(programming_language)) SE 6. Through the use of [java.lang.instrument](https://docs.oracle.com/javase/8/docs/api/java/lang/instrument/package-summary.html), developers can implement instrumentation using Java code, solving problems with Java code.

Using Instrumentation, developers can build an agent program independent of the application to monitor and assist programs running on the JVM, even replacing and modifying certain class definitions. With this capability, developers can achieve more flexible runtime monitoring and Java class operations, providing a VM-level supported AOP implementation method. This allows developers to implement certain AOP features without upgrading or modifying the JDK.

In [Java](https://en.wikipedia.org/wiki/Java_(programming_language)) SE 6, the instrumentation package has been enhanced with powerful features such as post-start instrumentation, [native code](https://en.wikipedia.org/wiki/Native_code) instrumentation, and dynamic changes to the classpath. These improvements mean that Java has stronger dynamic control and interpretive capabilities, making the Java language more flexible.

## Analysis of DDtrace Custom Instrumentation Structure

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-1.png)

1. Decorator: Used for decorating Instrumentation. `BaseDecorator` is a base decorator, so custom decorators need to inherit from `BaseDecorator` or its subclasses. Operations on spans and custom tags are implemented through `BaseDecorator`.
2. Instrumentation: An instrumentation program annotated with `@AutoService(Instrumenter.class)` to register the current class as an instrumentation application. When the agent starts, classes annotated with `@AutoService(Instrumenter.class)` will be loaded.
3. Advice: Enhances methods that need instrumentation, mainly providing two method-level annotations `@Advice.OnMethodEnter` and `@Advice.OnMethodExit`, which are called when entering and exiting methods, respectively.
4. Inject/Extract: Represents injection/extraction, not mandatory to implement. The main function is to inject and extract trace information such as traceid, spanid, and related propagation parameters. It is used to ensure trace information transparency across services.

### Decorator Class Diagram

Here is part of the class diagram.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-2.png)

### Instrumentation Class Diagram

Here is part of the class diagram.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-3.png)

`Instrumenter` is an interface providing rich interfaces for different implementations.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-4.png)

`HasAdvice`: Wraps methods, i.e., performs instrumentation operations. It mainly provides an interface method to register methods that need instrumentation, allowing multiple methods to be instrumented:

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

Profiling: Indicates profiling instrumentation.

```java
/** Parent class for all profiling related instrumentations */
abstract class Profiling extends Default{...}
```

CiVisibility: CI instrumentation type.

```java
/** Parent class for all CI related instrumentations */
abstract class CiVisibility extends Default {...}
```

Default: A default implementation.

```java
@SuppressFBWarnings("IS2_INCONSISTENT_SYNC")
abstract class Default implements Instrumenter, HasAdvice{...}
```

### Inject Class Diagram

`Setter<C>` is fully named `AgentPropagation.Setter<C>`. Here is part of the class diagram.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-5.png)

### Extract Class Diagram

`ContextVisitor<C>` is fully named `AgentPropagation.ContextVisitor<C>`. Here is part of the class diagram.

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-6.png)

Both Inject and Extract involve Propagation (propagators). For usage and introduction of propagators, refer to the document [Custom traceId Implementation Using extract + TextMapAdapter](/best-practices/monitoring/ddtrace-custom-traceId).

## Practical Example: DDtrace Custom Dubbo Instrumentation

### Integration Ideas

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-7.png)

1. Create the `DubboInstrumentation` class and configure instrumentation-related information.
2. Use `adviceTransformations` to enhance relevant methods. Business logic enhancements are implemented in the `RequestAdvice` class, primarily implementing two methods: `@Advice.OnMethodEnter` and `@Advice.OnMethodExit`, which are called when entering and exiting methods, respectively.
3. `DubboDecorator` acts as a decorator, performing operations like setting related tags or closing a span.
4. Inject/Extract: Mainly used for injecting and extracting trace information. They ensure trace information transparency, such as traceid, spanid, and related propagation parameters. `DubboHeadersInjectAdapter` is mainly used by consumers to propagate traceId, spanId, etc., while providers extract related parameters using `DubboHeadersExtractAdapter` to build spans.

### Integration Steps

#### Step 1: In the `dd-java-agent\instrumentation` directory, create a module using Gradle.

<font color="red">Since dubbo's package names, class names, and method names differ significantly between major versions, it's beneficial to include the corresponding major version number when creating modules, such as dubbo-2.7, indicating support for dubbo 2.7 and above. Specific version support can be modified in the module's build.gradle file. Since the name `build.gradle` is not conducive to maintenance, we rename it to `dubbo-2.7.gradle`.</font>

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

Add `dubbo-2.7.gradle` in the `settings.gradle` file.

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

#### Step 2: Create the package name `datadog.trace.instrumentation.dubbo_2_7x`.

#### Step 3: Create the instrumentation class `DubboInstrumentation.java`

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

`Filter` is an interface, so we need to use `implementsInterface` to intercept all implementations of the `Filter` interface. `org.apache.dubbo.rpc.Filter` provides the `invoke` method with two parameters: `Invoker` and `Invocation`, which will be used later.

By overriding `void adviceTransformations(AdviceTransformation transformation)`, we achieve interception of `org.apache.dubbo.rpc.Filter`.

Parameters for `applyAdvice`:

- `isMethod()`: Intercept methods.
- `isPublic()`: Public access modifier.
- `nameStartsWith("invoke")`: Method name.
- `takesArguments`: Number of arguments required by `nameStartsWith("invoke")`.
- `takesArgument`: Parameters for `nameStartsWith("invoke")`, fill in according to needs. Incorrect parameter types or orders will render the instrumentation invalid.
  - `takesArgument(0, named("org.apache.dubbo.rpc.Invoker"))`: First parameter type.
  - `takesArgument(1, named("org.apache.dubbo.rpc.Invocation"))`: Second parameter type.

`helperClassNames()`: Declares additional custom classes.

`Map<String, String> contextStore()`: Used for storing context information, mainly storing `AgentSpan` or `AgentScope` related information (such as traceid, spanid, etc.). Here, we configure `singletonMap("org.apache.dubbo.rpc.Invocation", AgentSpan.class.getName())` to enhance `org.apache.dubbo.rpc.Invocation`.

`@AutoService` is a SPI interface specification provided by Google, processed during compilation.

The instrumentation class is core and requires adding the annotation `@AutoService(Instrumenter.class)` to indicate an instrumentation application. During compilation and packaging, classes annotated with `@AutoService(Instrumenter.class)` are iterated over and their class names are placed in a file named `META-INF/services/datadog.trace.agent.tooling.Instrumenter`, which is then loaded by the class loader at startup. The `META-INF/services/datadog.trace.agent.tooling.Instrumenter` file is auto-generated, with partial content as follows:

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

#### Step 4: Create `DubboDecorator`

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

As an RPC framework, dubbo has both consumers and providers. We determine whether the current execution belongs to consumer or provider code via `isConsumer`. If it's a consumer, it directly creates a span with traceid and parentId propagated from other chains, and passes data to the provider using `propagate().inject(span, invocation, SETTER)`. If it's a provider, it extracts data using `propagate().extract(invocation, GETTER)` to construct `parentContext`, and then constructs the current span information to complete the trace linkage.

#### Step 5: Create `RequestAdvice`

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

`RequestAdvice` mainly implements two methods. Method names can be customized, and the two methods are annotated with `@Advice.OnMethodEnter` and `@Advice.OnMethodExit`, representing actions to be performed when entering and exiting methods. `CallDepthThreadLocalMap.incrementCallDepth(RpcContext.class)` prevents method reentry, and `CallDepthThreadLocalMap.reset(RpcContext.class)` resets the rule upon exit.

#### Step 6: Compile and Package

Use `gradle shadowJar` for packaging. After packaging, the file is stored in `dd-java-agent\build\libs`.

## Source Code Location

<[dubbo-instrumentation](https://github.com/GuanceCloud/dd-trace-java/tree/v0.105.0/dd-java-agent/instrumentation/dubbo-2.7)>