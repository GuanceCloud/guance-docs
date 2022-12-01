# DDtrace 自定义 Instrumentation

---

> _作者： 刘锐_

## Java Instrumentation 介绍

Instrumentation：插桩（有的人称为“探针”，有的人称为“埋点”，翻译本无错，理解就行）

Java Instrumentation 是 [Java](https://baike.baidu.com/item/Java%20)SE 6 中的新特性，通过 Java 代码即 [java.lang.instrument](https://baike.baidu.com/item/java.lang.instrument/5179837) 可以实现 instrument 用 Java 代码的方式解决问题的一个功能。

使用 Instrumentation，开发者可以构建一个独立于应用程序的代理程序（Agent），用来监测和协助运行在 JVM 上的程序，甚至能够替换和修改某些类的定义。有了这样的功能，开发者就可以实现更为灵活的运行时[虚拟机](https://baike.baidu.com/item/%E8%99%9A%E6%8B%9F%E6%9C%BA)监控和 Java 类操作了，这样的特性实际上提供了一种虚拟机级别支持的 AOP 实现方式，使得开发者无需对 JDK 做任何升级和改动，就可以实现某些 AOP 的功能了。

在 [Java](https://baike.baidu.com/item/Java%20)SE 6 里面，instrumentation 包被赋予了更强大的功能：启动后的 instrument、[本地代码](https://baike.baidu.com/item/%E6%9C%AC%E5%9C%B0%E4%BB%A3%E7%A0%81)（native code）instrument，以及动态改变 classpath 等等。这些改变，意味着 Java 具有了更强的动态控制、解释能力，它使得 Java 语言变得更加灵活多变。

##  DDtrace 自定义 Instrumentation 结构分析

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-1.png)

1. Decorator：装饰器，用于装饰 Instrumentation ，`BaseDecorator`是一个基础装饰器，所以自定义装饰器都需要继承 `BaseDecorator`或者 `BaseDecorator`的子类。对 span 的操作、自定义标签等行为都需要通过`BaseDecorator`实现。
1. Instrumentation ：插桩程序，使用`@AutoService(Instrumenter.class)`注解，将当前类注册为一个插桩应用，当 agent 启动的时候，会加载`@AutoService(Instrumenter.class)`注解的类。
1. Advice：对 Instrumentation 需要插桩的方法进行增强处理，主要提供了两个方法级别的注解`@Advice.OnMethodEnter` 和 `@Advice.OnMethodExit`，分别表示在方法进入的时候调用和在方法退出的时候调用;
1. Inject/Extract：表示 注入/取出，非必须实现，主要功能是对链路信息的注入和提取操作。用它来实现链路信息的透传，如 traceid、spanid 以及相关传播的参数。

### Decorator 类图

这里展示部分类图。

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-2.png)

### Instrumentation 类图

这里展示部分类图。

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-3.png)

Instrumenter 为 interface ，提供了丰富的接口，根据不同定义进行实现。

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-4.png)

HasAdvice：对方法进行环绕处理，也就是我们通常所说的进行埋点操作，主要提供了一个接口方法，用于注册需要埋点的方法，可以对多个 method 进行埋点操作：

```java
/**
 * Instrumenters should register each advice transformation by calling {@link
 * AdviceTransformation#applyAdvice(ElementMatcher, String)} one or more times.
 */
void adviceTransformations(AdviceTransformation transformation);
```

Tracing: 用于 trace 。

```java
/** Parent class for all tracing related instrumentations */
abstract class Tracing extends Default{...}
```

Profiling：代表当前是一个*profiling *插桩。

```java
/** Parent class for all profiling related instrumentations */
abstract class Profiling extends Default{...}
```

CiVisibility: CI 插桩类型。

```java
/** Parent class for all CI related instrumentations */
abstract class CiVisibility extends Default {...}
```

Default：是一个默认实现。

```java
@SuppressFBWarnings("IS2_INCONSISTENT_SYNC")
abstract class Default implements Instrumenter, HasAdvice{...}
```

### Inject 类图

Setter<C> 全称为：AgentPropagation.Setter<C>，这里展示部分类图。

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-5.png)

### Extract 类图

ContextVisitor<C> 全称为：AgentPropagation.ContextVisitor<C>，这里展示部分类图。

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-6.png)

不论是 Inject 还是 Extract，都会涉及到 Propagation (传播器)，关于传播器的使用和介绍参考文档[使用 extract + TextMapAdapter 实现了自定义 traceId](/best-practices/monitoring/ddtrace-custom-traceId)

##  实战：DDtrace 自定义 Dubbo Instrumentation

### 集成思路

![image.png](../images/ddtrace-instrumentation/ddtrace-instrumentation-7.png)

1. 创建 DubboInstrumentation 类，配置插桩相关信息;
1. 通过`adviceTransformations`对相关方法进行增强，增强业务逻辑在 RequestAdvice 类中实现，主要实现两个方法：`@Advice.OnMethodEnter` 和 `@Advice.OnMethodExit`，分别表示在方法进入的时候调用和在方法退出的时候调用;
1. DubboDecorator 起到装饰器的作用，比如对 span 的相关操作，如设置相关 tag、或者关闭一个 span;
1. Inject/Extract 表示 注入/取出，主要功能是对链路信息的注入和提取操作。用它来实现链路信息的透传，如 traceid、spanid 以及相关传播的参数。DubboHeadersInjectAdapter 主要用于 consumer 传播 traceId、spanId 等，provider 通过 DubboHeadersExtractAdapter 提取相关参数来构建 span 。

### 集成步骤

#### 1 在`dd-java-agent\instrumentation`目录下，创建一个模块，选择用 gradle 方式创建。

<font color="red">由于 dubbo 在不同大版本之间，包名、类名、方法名均有差异，创建模块时，带上对应的大版本号，有利于维护，如：dubbo-2.7，表示支持 dubbo 2.7 以上的版本，具体版本支持在当前模块下的 build.gradle 上修改，由于 build.gradle 名称不利于维护，所以这里我们调整为 dubbo-2.7.gradle。</font>

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

同时在` settings.gradle` 文件添加`dubbo-2.7.gradle`

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

#### 2 创建包名 `datadog.trace.instrumentation.dubbo_2_7x`。

#### 3 创建插桩类 `DubboInstrumentation.java`

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
    return  hasClassesNamed(CLASS_NAME);
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

先来看一下`org.apache.dubbo.rpc.Filter`源码:

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

Filter 是一个 interface，所以需要采用 implementsInterface 方式，这样能够对 Filter 接口的所有实现进行拦截处理。`org.apache.dubbo.rpc.Filter`提供了 `invoke` 方法，并携带了两个参数`Invoker`和`Invocation`，后面会用到。

通过重写`void adviceTransformations(AdviceTransformation transformation)`，实现对`org.apache.dubbo.rpc.Filter`的拦截。

applyAdvice 参数介绍：

- isMethod()：是指对方法进行拦截；
- isPublic()：是指访问协议是 public ；
- nameStartsWith("invoke")：方法名称；
- takesArguments： nameStartsWith("invoke") 需要参数数量；
- takesArgument：nameStartsWith("invoke") 相关参数，根据需要进行填写，参数类型以及参数顺序写错，都会导致当前插桩无效。
  - takesArgument(0, named("org.apache.dubbo.rpc.Invoker"))：表示第一个参数类型
  - takesArgument(1, named("org.apache.dubbo.rpc.Invocation"))：第二个参数类型

helperClassNames()： 是辅助类，额外自定义的类，都需要在这里声明。

Map<String, String> contextStore(): 用于上下文信息存储的，主要是存储 AgentSpan 或者 AgentScope 相关信息（如 traceid、spanid 等），这里配置 `singletonMap("org.apache.dubbo.rpc.Invocation", AgentSpan.class.getName())`表示对`org.apache.dubbo.rpc.Invocation`进行增强。

@AutoService 是 google 提供的 SPI 接口规范，在编译期进行处理。

插桩类是核心，需要在类名下添加注解`@AutoService(Instrumenter.class)`，表示一个插桩应用，在对应用进行编译打包的时候，会对` @AutoService(Instrumenter.class)`相关类进行迭代并获取相关的类名放入一个名为 `META-INF/services/datadog.trace.agent.tooling.Instrumenter`文件中，由类加载器启动的时候进行加载。`META-INF/services/datadog.trace.agent.tooling.Instrumenter`文件为自动生成，部分代码如下：

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

#### 4 创建 DubboDecorator

部分代码如下:

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

dubbo 作为 RPC 框架，有 consumer 和 provider ,通过 `isConsumer` 来判断当前是属于 consumer 的代码执行还是 provider 的代码执行。如果是 consumer ，则直接创建 span，它的 traceid 和 parentId 来源于其他链路的传播携带，并通过` propagate().inject(span, invocation, SETTER)`来向 provider 传播数据 。如果是 provider，则通过`propagate().extract(invocation, GETTER)`提取来构造`parentContext`,再通过`parentContext`来构造当前 span 信息，完成链路串联。

#### 5 创建 RequestAdvice

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

RequestAdvice 类主要实现两个方法，方法名成可以自定义，两个方法分别使用 @Advice.OnMethodEnter 和 @Advice.OnMethodExit 注解，代表了方法进入和退出时需要做的操作。通过 `CallDepthThreadLocalMap.incrementCallDepth(RpcContext.class)`可以防止方法重入，OnMethodExit 退出时，需要重置规则`CallDepthThreadLocalMap.reset(RpcContext.class)`。

#### 6 编译打包

通过 `gradle shadowJar` 进行打包，打包后，文件存放在`dd-java-agent\build\libs` 下。

## 源码地址

<[dubbo-instrumentation](https://github.com/GuanceCloud/dd-trace-java/tree/v0.105.0/dd-java-agent/instrumentation/dubbo-2.7)>
