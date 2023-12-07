# OpenTelemetry Java SDK

---  

> _作者： 刘锐_

通过引入 OpenTelemetry SDK，可以观测业务核心逻辑，比如给核心的业务设置一个 span 以统计、跟踪、分析其实际行为、设置业务属性指标等。此方法具有一定的侵入性。

## 启动命令

```shell
java -javaagent:../opentelemetry-javaagent/opentelemetry-javaagent.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://192.168.91.11:4317 \
-Dotel.resource.attributes=service.name=demo,version=dev \
-Dotel.metrics.exporter=otlp \
-jar springboot-opentelemetry-otlp-server.jar --client=true
```

???+ waring "特别说明"

	<font color="red">
	根据启动参数 exporter 的不同，sdk 方式也需要引入对应的 exporter ，否则启动失败。如启动参数使用了 `otlp` 和 `logging` 两个 exporter，则需要在 pom 添加对应的两个 exporter 依赖。
	
	如果没有使用 sdk 相关依赖，则不需要做对应的调整。
	</font>

## 引入依赖

``` xml
	<dependencies>
		...
        <dependency>
            <groupId>io.opentelemetry</groupId>
            <artifactId>opentelemetry-exporter-otlp</artifactId>
        </dependency>
        <dependency>
            <groupId>io.opentelemetry</groupId>
            <artifactId>opentelemetry-extension-annotations</artifactId>
        </dependency>
        <dependency>
            <groupId>io.opentelemetry</groupId>
            <artifactId>opentelemetry-semconv</artifactId>
            <version>1.21.0-alpha</version>
        </dependency>
        <dependency>
            <groupId>io.opentelemetry</groupId>
            <artifactId>opentelemetry-sdk-extension-autoconfigure</artifactId>
            <version>1.21.0-alpha</version>
        </dependency>
		...
	</dependencies>

	<dependencyManagement>
		<dependencies>
			<dependency>
				<groupId>io.opentelemetry</groupId>
				<artifactId>opentelemetry-bom</artifactId>
				<version>1.21.0</version>
				<type>pom</type>
				<scope>import</scope>
			</dependency>
		</dependencies>
	</dependencyManagement>
```



## 创建 sdk

不推荐

```java
    @Bean
    public OpenTelemetry openTelemetry() {
        return AutoConfiguredOpenTelemetrySdk.builder()
                .setResultAsGlobal(false)
                .build()
                .getOpenTelemetrySdk();
    }
```


以上方式会导致`AutoConfiguredOpenTelemetrySdk`重加载，SDK 提供了一个全局的对象 `GlobalOpenTelemetry` 来获取 `OpenTelemetry` 对象。

下面使用主要采用 `GlobalOpenTelemetry.get()` 来获取`OpenTelemetry` 对象。

## 链路（Trace）

### 创建 Tracer

`Tracer` 主要是用来获取、创建 span 对象。注意: `Tracer` 通常不负责进行配置，这是`TracerProvider` 的职责。 OpenTelemetry interface 提供了默认的`TracerProvider`实现。

```java
TracerProvider getTracerProvider();
```

通过`openTelemetry()` 来获取 `Tracer` 对象

```java
    @Bean
    public Tracer tracer() {
        return GlobalOpenTelemetry.getTracer(appName);
    }

```

### 创建 Span

???+ info  

	除了 Tracer 外，不准许任何其他 API 创建 Span 。

``` java
Span span = tracer.spanBuilder(spanName).startSpan();
``` 

### 获取当前 Span 对象

获取当前 span 对象，可以为当前 span 设置 attribute、event 等。

```java
Span span = Span.current();
```

### 创建 Attribute

attribute 为 span 的属性，为当前 span 的标签。

```java
span.setAttribute(key, value);
```

### 创建 Link Span

一个 Span 可以连接一个或多个因果相关的其他 Span 。链接可用于表示批处理操作，其中一个 Span 的初始化由多个 Span 初始化构成，其中每个 Span 表示批处理中处理的单个输入项。

```java
Span child = tracer.spanBuilder(spanName)
		.addLink(span(1))
		.addLink(span(2))
		.addLink(span(3))
		.startSpan();
```

### 创建 Event

Span 可以携带零个或多个 Span 属性的命名事件进行注释，每一个事件都是一个 key:value 键值对并自动携带相应的时间戳。

```java
span.addEvent(eventName);

span.addEvent(eventName,Attributes);
```


???+ waring "注意"

	recordException 是 `addEvent` 的特殊变体，用于记录异常事件。


### 创建一个嵌套的 Span

通过 setParent(parentSpan) 设置 parentSpan

``` java 
void parent() {
	Span parentSpan = tracer.spanBuilder("parent")
		.startSpan();
	childSpan(parentSpan);
	parentSpan.end();
}
void childSpan(Span parentSpan) {
	Span childSpan = tracer.spanBuilder("childSpan")
		.setParent(parentSpan)
		.startSpan();
	// do stuff
	childSpan.end();
}
```


### Baggage 用法

Baggage 可以在整个链路传播，适用于全局埋点，比如用户id埋点、用户名埋点，以便追踪业务数据。

gateway方法 set Baggage

```java
// Baggage 用法,此处set
	Baggage.current().toBuilder().put("app.username", "gateway").build().makeCurrent();
	logger.info("gateway set baggage[app.username] value: gateway");
```

resource 方法 get Baggage

```java
 // Baggage 用法,此get
	String baggage = Baggage.current().getEntryValue("app.username");
	logger.info("resource get baggage[app.username] value: {}", baggage);
```

### 通过已知的traceId和spanId,来构造一个新span。

Tracer 构造 span 提供了`setParent(context)`方法，便于为自定义的 span 构造一个父 span。

```java 
tracer.spanBuilder(spanName).setParent(context)
```
其中 `setParent` 需要传入 `Context` 参数，所以需要构造一个上下文。

而 OpenTelemetry sdk 只提供了一个 `create` 方法用于创建 `SpanContext`，其中可以自定义 traceId 和 spanId。

```java
SpanContext create(String traceIdHex, String spanIdHex, TraceFlags traceFlags, TraceState traceState)
```

`SpanContext` 作为表示 Span 的一部分，他必须可以进行序列化，并沿着分布式上下文进行传播。`SpanContext` 是不可变的。

OpenTelemetry `SpanContext` 符合 [W3C TraceContext](https://www.w3.org/TR/trace-context/) 规范。这包含两个标识符 - TraceId 和 SpanId - 一套通用 TraceFlags 和 系统特定 TraceState。
 
1. **`TraceId`** 一个有效的 `TraceId` 是一个 16 字节的数组，且至少有一个非零字节。

2. **`SpanId`** 一个有效的 `SpanId` 是一个 8 字节的数组，且至少有一个非零字节。

3. **`TraceFlags`** 包含该 trace 的详情。不像 `TraceFlags`，`TraceFlags` 影响所有的 traces。当前版本和定义的 Flags 只有 sampled 。

4. **`TraceState`** 携带特定 trace 标识数据，通过一个 KV 对数组进行标识。`TraceState`允许多个跟踪系统参与同一个 Trace。完整定义请参考 [W3C Trace Context specification](https://www.w3.org/TR/trace-context/#tracestate-header)。

本 API 必须实现创建 SpanContext 的方法。这些方法应当是唯一的方法用于创建 SpanContext。这个功能必须在 API 中完全实现，并且不应当可以被覆盖。

但 SpanContext 并不是 Context，因而还需要做一层转换。

```java
private Context withSpanContext(SpanContext spanContext, Context context) {
	return context.with(Span.wrap(spanContext));
}
```
完整代码如下：

```java
    /***
     * @Description 通过已知的traceId和spanId,来构造一个新span。
     * @Param [spanName, traceId, spanId]
     * @return java.lang.String
     **/
    @GetMapping("/customSpanByTraceIdAndSpanId")
    @ResponseBody
    public String customSpanByTraceIdAndSpanId(String spanName,String traceId,String spanId){
        assert StringUtils.isEmpty(spanName):"spanName 不能为空";
        assert StringUtils.isEmpty(traceId):"traceId 不能为空";
        assert StringUtils.isEmpty(spanId):"spanId 不能为空";
        Context context =
                withSpanContext(
                        SpanContext.create(
                                traceId, spanId, TraceFlags.getSampled(), TraceState.getDefault()),
                        Context.current());
        Span span = tracer.spanBuilder(spanName)
                .setParent(context)
                .startSpan();
        span.setAttribute("attribute.a2", "some value");
        span.setAttribute("func","attr");
        span.setAttribute("app","otel3");
        span.end();
        return buildTraceUrl(span.getSpanContext().getTraceId());
    }

    private Context withSpanContext(SpanContext spanContext, Context context) {
        return context.with(Span.wrap(spanContext));
    }
```

???+ waring "注意"

	**需要特别注意，依据当前测试写法的请求自身会产生一个新的 trace 信息。新构造的 span 是依据传入的参数进行构造。**

我们可以通过访问链接来观察结果

http://localhost:8080/customSpanByTraceIdAndSpanId?spanName=tSpan&traceId=24baeeddfbb35fceaf4c18e7cae58fe1&spanId=ff1955b4f0eacc4f


## 指标（Metrics）

OpenTelemetry 还提供了 metric 相关操作的 API。

span 提供关于应用程序的详细信息，但生成的数据与系统上的负载成正比。相比之下，度量将单个度量组合成聚合，并生成作为系统负载函数的常量数据。聚合缺乏诊断低级问题所需的细节，但是通过帮助识别趋势和提供应用程序运行时遥测来补充跨度。

度量API定义了各种工具。仪器记录测量值，这些测量值由度量SDK聚合，并最终导出到进程外。仪器有同步和异步两种。同步仪器记录测量结果。异步仪器注册回调，每次采集调用一次，并记录该时间点的测量值。下列仪器可供选择:

1. **LongCounter/DoubleCounter:** 只记录正数值，有同步和异步选项。用于计算事物，例如通过网络发送的字节数。默认情况下，计数器测量被聚合为始终递增的单调和。

2. **LongUpDownCounter/DoubleUpDownCounter:** 记录正负值，有同步和异步选项。对于计算上升和下降的东西很有用，比如队列的大小。默认情况下，向上向下计数器测量被聚合为非单调和。

3. **LongGauge/DoubleGauge:** 用异步回调测量瞬时值。用于记录不能跨属性合并的值，如 CPU 使用率百分比。默认情况下，量规测量被聚合为量规。

4. **LongHistogram/DoubleHistogram（长直方图/双直方图）:** 记录对直方图分布分析最有用的测量值。没有异步选项可用。用于记录 HTTP 服务器处理请求所花费的时间等。默认情况下，直方图测量被聚合为显式的桶直方图。


### 获取 Meter 对象

API定义了一个 Meter 接口。该接口由一组 instrument 构造器，和一个使用原子方式批量获取测量值的工具组成。Meter 可以通过 `MeterProvider` 的 getMeter(name)方法来创建一个新实例。 `MeterProvider` 通常被期望作为单例来使用。 其实现应作为 `MeterProvider` 全局的唯一实现。通过 Meter 对象可以构建不同类型的 metric。

```java
    @Bean
    public Meter meter() {
        return GlobalOpenTelemetry.getMeter(appName);
    }
```

这里跳过了 `MeterProvider` 的细节，主要原因在于 OpenTelemetry Interface 提供了 `MeterProvider` 的默认 noop 实现。

```java
    default MeterProvider getMeterProvider() {
        return MeterProvider.noop();
    }
```

### 构建 gauge 类型的 metric

``` java

	meter.gaugeBuilder("connections")
		.setDescription("当前Socket.io连接数")
		.setUnit("1")
		.buildWithCallback(
				result -> {
					System.out.println("metrics");
					for (int i = 1; i < 4; i++) {
						result.record(
								i,
								Attributes.of(
										AttributeKey.stringKey("id"),
										"a" + i));
					}
				});

```

`buildWithCallback` 是一个回调函数，是支持异步 API 并按需收集度量数据的附加工具，按间隔收集数据，默认 `1min` 一次。


## 相关文档

[OpenTelemetry 链路数据接入](/integrations/opentelemetry/)

[springboot-opentelemetry-otlp-server](https://github.com/lrwh/observable-demo/tree/main/springboot-opentelemetry-otlp-server)

[opentelemetry api](https://github.com/open-telemetry/docs-cn/blob/main/specification/trace/api.md)

[opentelemetry java](https://opentelemetry.io/docs/instrumentation/java/manual/)

[opentelemetry 参数配置](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md)