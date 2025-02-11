# OpenTelemetry Java SDK

---

> _Author: Liu Rui_

By introducing the OpenTelemetry SDK, you can observe the core business logic, such as setting a span for the core business to statistically track and analyze its actual behavior, set business attribute metrics, etc. This method is somewhat intrusive.

## Start Command

```shell
java -javaagent:../opentelemetry-javaagent/opentelemetry-javaagent.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://192.168.91.11:4317 \
-Dotel.resource.attributes=service.name=demo,version=dev \
-Dotel.metrics.exporter=otlp \
-jar springboot-opentelemetry-otlp-server.jar --client=true
```

???+ warning "Special Note"

	<font color="red">
	Depending on the exporter specified in the startup parameters, the corresponding exporter must also be introduced into the SDK; otherwise, the startup will fail. For example, if the startup parameters use both `otlp` and `logging` exporters, then the corresponding two exporter dependencies need to be added in the pom.
	
	If no SDK-related dependencies are used, no corresponding adjustments are needed.
	</font>

## Introduce Dependencies

```xml
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

## Create SDK

Not recommended

```java
    @Bean
    public OpenTelemetry openTelemetry() {
        return AutoConfiguredOpenTelemetrySdk.builder()
                .setResultAsGlobal(false)
                .build()
                .getOpenTelemetrySdk();
    }
```

The above approach would cause `AutoConfiguredOpenTelemetrySdk` to reload, and the SDK provides a global object `GlobalOpenTelemetry` to obtain the `OpenTelemetry` object.

Below, we mainly use `GlobalOpenTelemetry.get()` to get the `OpenTelemetry` object.

## Trace

### Create Tracer

`Tracer` is primarily used to obtain and create Span objects. Note: `Tracer` typically does not handle configuration; this is the responsibility of `TracerProvider`. The OpenTelemetry interface provides a default implementation of `TracerProvider`.

```java
TracerProvider getTracerProvider();
```

Obtain the `Tracer` object via `openTelemetry()`

```java
    @Bean
    public Tracer tracer() {
        return GlobalOpenTelemetry.getTracer(appName);
    }
```

### Create Span

???+ info  

	No other APIs besides Tracer are allowed to create Spans.

```java
Span span = tracer.spanBuilder(spanName).startSpan();
```

### Get Current Span Object

Get the current Span object to set attributes, events, etc., for the current Span.

```java
Span span = Span.current();
```

### Create Attribute

Attributes are properties of a Span, serving as labels for the current Span.

```java
span.setAttribute(key, value);
```

### Create Linked Span

A Span can link to one or more causally related Spans. Links can represent batch operations where a Span's initialization is composed of multiple Spans initializing, each representing a single input item processed in the batch.

```java
Span child = tracer.spanBuilder(spanName)
		.addLink(span(1))
		.addLink(span(2))
		.addLink(span(3))
		.startSpan();
```

### Create Event

Spans can carry zero or more named events annotated with Span attributes. Each event is a key:value pair and automatically carries a timestamp.

```java
span.addEvent(eventName);

span.addEvent(eventName, Attributes);
```

???+ warning "Note"

	`recordException` is a special variant of `addEvent`, used to record exception events.


### Create a Nested Span

Set the parentSpan using `setParent(parentSpan)`

```java 
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

### Baggage Usage

Baggage can propagate throughout the trace, suitable for global instrumentation like user ID or username, enabling tracking of business data.

Gateway method to set Baggage

```java
// Baggage usage, set here
	Baggage.current().toBuilder().put("app.username", "gateway").build().makeCurrent();
	logger.info("gateway set baggage[app.username] value: gateway");
```

Resource method to get Baggage

```java
 // Baggage usage, get here
	String baggage = Baggage.current().getEntryValue("app.username");
	logger.info("resource get baggage[app.username] value: {}", baggage);
```

### Construct a New Span Using Known TraceId and SpanId

Tracer provides the `setParent(context)` method to construct a parent Span for custom spans.

```java 
tracer.spanBuilder(spanName).setParent(context)
```

The `setParent` method requires a `Context` parameter, so a context needs to be constructed.

The OpenTelemetry SDK only provides a `create` method to create a `SpanContext`, which allows customizing `traceId` and `spanId`.

```java
SpanContext create(String traceIdHex, String spanIdHex, TraceFlags traceFlags, TraceState traceState)
```

`SpanContext` represents part of a Span, must be serializable, and should propagate along the distributed context. `SpanContext` is immutable.

OpenTelemetry `SpanContext` conforms to the [W3C TraceContext](https://www.w3.org/TR/trace-context/) specification. This includes two identifiers - `TraceId` and `SpanId` - a set of common `TraceFlags`, and system-specific `TraceState`.

1. **`TraceId`** A valid `TraceId` is a 16-byte array with at least one non-zero byte.

2. **`SpanId`** A valid `SpanId` is an 8-byte array with at least one non-zero byte.

3. **`TraceFlags`** Contains details about the trace. Unlike `TraceFlags`, `TraceFlags` affect all traces. The only flag defined in the current version is `sampled`.

4. **`TraceState`** Carries specific trace identifier data through a KV pair array. `TraceState` allows multiple tracing systems to participate in the same trace. For a full definition, refer to the [W3C Trace Context specification](https://www.w3.org/TR/trace-context/#tracestate-header).

This API must implement methods to create `SpanContext`. These methods should be the only ones used to create `SpanContext`. This functionality must be fully implemented in the API and cannot be overridden.

However, `SpanContext` is not `Context`, so an additional conversion is required.

```java
private Context withSpanContext(SpanContext spanContext, Context context) {
	return context.with(Span.wrap(spanContext));
}
```

Complete code:

```java
    /***
     * @Description Construct a new span using known traceId and spanId.
     * @Param [spanName, traceId, spanId]
     * @return java.lang.String
     **/
    @GetMapping("/customSpanByTraceIdAndSpanId")
    @ResponseBody
    public String customSpanByTraceIdAndSpanId(String spanName, String traceId, String spanId){
        assert StringUtils.isEmpty(spanName):"spanName cannot be empty";
        assert StringUtils.isEmpty(traceId):"traceId cannot be empty";
        assert StringUtils.isEmpty(spanId):"spanId cannot be empty";
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

???+ warning "Note"

	**Pay special attention that the request itself generates a new trace information based on the current test writing method. The newly constructed Span is created based on the input parameters.**

We can observe the results by accessing the following URL:

http://localhost:8080/customSpanByTraceIdAndSpanId?spanName=tSpan&traceId=24baeeddfbb35fceaf4c18e7cae58fe1&spanId=ff1955b4f0eacc4f


## Metrics

OpenTelemetry also provides APIs for metric-related operations.

Spans provide detailed information about applications, but the generated data scales with the load on the system. In contrast, metrics aggregate individual measurements and generate constant data as a function of system load. Aggregations lack the detail required to diagnose low-level issues but complement spans by helping identify trends and providing runtime telemetry for applications.

The Metrics API defines various instruments. Instruments record measurements, which are aggregated by the Metrics SDK and eventually exported out-of-process. Instruments come in synchronous and asynchronous forms. Synchronous instruments record measurements directly. Asynchronous instruments register callbacks, called once per collection period, recording measurements at those points in time. The following instruments are available:

1. **LongCounter/DoubleCounter:** Record positive values only, with synchronous and asynchronous options. Useful for counting things like bytes sent over the network. By default, counter measurements are aggregated as always-increasing monotonic sums.

2. **LongUpDownCounter/DoubleUpDownCounter:** Record positive and negative values, with synchronous and asynchronous options. Useful for measuring rising and falling quantities, like queue sizes. By default, up-down counter measurements are aggregated as non-monotonic sums.

3. **LongGauge/DoubleGauge:** Measure instantaneous values with asynchronous callbacks. Used for values that cannot be combined across attributes, like CPU usage percentages. By default, gauge measurements are aggregated as gauges.

4. **LongHistogram/DoubleHistogram (long histogram/double histogram):** Record measurements most useful for histogram distribution analysis. No asynchronous options are available. Used for recording times taken by an HTTP server to process requests, etc. By default, histogram measurements are aggregated as explicit bucket histograms.

### Obtain Meter Object

The API defines a `Meter` interface. This interface consists of a set of instrument builders and a tool for atomically collecting batches of measurements. A new instance of `Meter` can be created using the `getMeter(name)` method of `MeterProvider`. `MeterProvider` is typically expected to be used as a singleton. Its implementation should be the unique global implementation of `MeterProvider`. Through the `Meter` object, different types of metrics can be built.

```java
    @Bean
    public Meter meter() {
        return GlobalOpenTelemetry.getMeter(appName);
    }
```

Here we skip the details of `MeterProvider`, mainly because the OpenTelemetry Interface provides a default noop implementation of `MeterProvider`.

```java
    default MeterProvider getMeterProvider() {
        return MeterProvider.noop();
    }
```

### Build Gauge Type Metric

```java
	meter.gaugeBuilder("connections")
		.setDescription("Current Socket.io connections")
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

`buildWithCallback` is a callback function that supports asynchronous APIs and collects metrics on-demand, collecting data at intervals, defaulting to once every `1min`.

## Related Documentation

[OpenTelemetry Trace Data Integration](/integrations/opentelemetry/)

[springboot-opentelemetry-otlp-server](https://github.com/lrwh/observable-demo/tree/main/springboot-opentelemetry-otlp-server)

[opentelemetry api](https://github.com/open-telemetry/docs-cn/blob/main/specification/trace/api.md)

[opentelemetry java](https://opentelemetry.io/docs/instrumentation/java/manual/)

[opentelemetry configuration parameters](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md)