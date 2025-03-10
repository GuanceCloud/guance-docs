# Implementing Custom TraceId Using extract + TextMapAdapter

---

> _Author: Liu Rui_

## Preface

In certain specific scenarios, it is necessary to implement **custom traceId** through code.

Implementation idea: By using `tracer.extract`, a SpanContext can be constructed. The constructed SpanContext serves as the parent node information, and by using `asChildOf(SpanContext)`, the current span can be constructed.

### How TraceId Parameters Are Defined

For constructing SpanContext using `tracer.extract`, ContextInterpreter is used internally to parse and obtain the corresponding traceId and spanId. The implementation code of ContextInterpreter will be introduced in the following sections.

### Propagators

ddtrace supports several propagation protocols, and the parameter names for traceId differ across different propagation protocols. For Java, ddtrace supports two propagation protocols:

- Datadog: Default propagation protocol
- B3: B3 propagation is the specification of headers "b3" and those starting with "x-b3-". These headers are used for propagating tracing context across service boundaries. B3 has two formats:
    - B3SINGLE (B3_SINGLE_HEADER), where the header key is `b3`
    - B3 (B3MULTI), where the header key is `x-b3-`

## Implementing Custom TraceId Using the Datadog Propagator

### Enabling the Datadog Propagator

```shell
-Ddd.propagation.style.extract=Datadog
-Ddd.propagation.style.inject=Datadog
```

### Mechanism Code Introduction

ddtrace defaults to using **Datadog** as the default propagation protocol, with the interceptor being `DatadogContextInterpreter`. Part of its code is as follows:

```java
	public boolean accept(String key, String value) {
		case 'x':
			if ("x-datadog-trace-id".equalsIgnoreCase(key)) {
				classification = 0;
			} else if ("x-datadog-parent-id".equalsIgnoreCase(key)) {
				classification = 1;
			} else if ("x-datadog-sampling-priority".equalsIgnoreCase(key)) {
				classification = 3;
			} else if ("x-datadog-origin".equalsIgnoreCase(key)) {
				classification = 2;

		....

		switch(classification) {
			case 0:
				this.traceId = DDId.from(firstValue);
				break;
			case 1:
				this.spanId = DDId.from(firstValue);
				break;
			case 2:
				this.origin = firstValue;
				break;
			case 3:
				this.samplingPriority = Integer.parseInt(firstValue);
				break;
	....
	}
```

### Code Implementation

```java

    /***
     * Custom traceId related information, implementing custom tracing.
     * @param traceId
     * @param parentId
     * @param treeLength
     * @return
     */
    @GetMapping("/customTrace")
    @ResponseBody
    public String customTrace(String traceId, String parentId, Integer treeLength) {
        Tracer tracer = GlobalTracer.get();
        traceId = StringUtils.isEmpty(traceId) ? IdGenerationStrategy.RANDOM.generate().toString() : traceId;
        parentId = StringUtils.isEmpty(parentId) ? DDId.ZERO.toString() : parentId;
        treeLength = treeLength == null ? 3 : treeLength;
        for (int i = 0; i < treeLength; i++) {
            Map<String, String> data = new HashMap<>();
            data.put("x-datadog-trace-id", traceId);
            data.put("x-datadog-parent-id", parentId);

            SpanContext extractedContext = tracer.extract(Format.Builtin.HTTP_HEADERS, new TextMapAdapter(data));
            Span serverSpan = tracer.buildSpan("opt" + i)
                    .withTag("service_name", "someService" + i)
                    .asChildOf(extractedContext)
                    .start();
            tracer.activateSpan(serverSpan).close();
            serverSpan.finish();
            parentId = serverSpan.context().toSpanId();
        }
        return "build success!";
    }

```

## Implementing Custom TraceId Using the B3 Propagator

[About B3 Propagator](https://github.com/openzipkin/b3-propagation#single-header)

B3 has two encoding formats: Single Header and Multiple Headers.

- Multiple Headers encode each item in the tracing context with a prefixed header.
- Single Header encodes the context into one header named `b3`. When extracting fields, the single-header variant takes precedence over the multi-header variant.

This is an example flow using multiple headers, assuming an HTTP request carries propagated tracing:

![image](../images/ddtrace-custom-traceId-1.png)

### Enabling the B3 Propagator

```shell
-Ddd.propagation.style.extract=B3SINGLE
-Ddd.propagation.style.inject=B3SINGLE
```

### Mechanism Code Introduction

```java
	public boolean accept(String key, String value) {
		...
		char first = Character.toLowerCase(key.charAt(0));
		switch (first) {
			case 'f':
				if (this.handledForwarding(key, value)) {
					return true;
				}
				break;
			case 'u':
				if (this.handledUserAgent(key, value)) {
					return true;
				}
				break;
			case 'x':
				if ((this.traceId == null || this.traceId == DDId.ZERO) && "X-B3-TraceId".equalsIgnoreCase(key)) {
					classification = 0;
				} else if ((this.spanId == null || this.spanId == DDId.ZERO) && "X-B3-SpanId".equalsIgnoreCase(key)) {
					classification = 1;
				} else if (this.samplingPriority == this.defaultSamplingPriority() && "X-B3-Sampled".equalsIgnoreCase(key)) {
					classification = 3;
				} else if (this.handledXForwarding(key, value)) {
					return true;
				}
		}

	    ...

		String firstValue = HttpCodec.firstHeaderValue(value);
		if (null != firstValue) {
			switch (classification) {
				case 0:
					if (this.setTraceId(firstValue)) {
						return true;
					}
					break;
				case 1:
					this.setSpanId(firstValue);
					break;
				case 2:
					String mappedKey = (String)this.taggedHeaders.get(lowerCaseKey);
					if (null != mappedKey) {
						if (this.tags.isEmpty()) {
							this.tags = new TreeMap();
						}

						this.tags.put(mappedKey, HttpCodec.decode(firstValue));
					}
					break;
				case 3:
					this.samplingPriority = this.convertSamplingPriority(firstValue);
					break;
				case 4:
					if (this.extractB3(firstValue)) {
						return true;
					}
			}
		}

		...

```

The following method handles the Single Header format:

```java
	private boolean extractB3(String firstValue) {
		if (firstValue.length() == 1) {
			this.samplingPriority = this.convertSamplingPriority(firstValue);
		} else {
			int firstIndex = firstValue.indexOf("-");
			int secondIndex = firstValue.indexOf("-", firstIndex + 1);
			String b3SpanId;
			if (firstIndex != -1) {
				b3SpanId = firstValue.substring(0, firstIndex);
				if (this.setTraceId(b3SpanId)) {
					return true;
				}
			}

			if (secondIndex == -1) {
				b3SpanId = firstValue.substring(firstIndex + 1);
				this.setSpanId(b3SpanId);
			} else {
				b3SpanId = firstValue.substring(firstIndex + 1, secondIndex);
				this.setSpanId(b3SpanId);
				String b3SamplingId = firstValue.substring(secondIndex + 1);
				this.samplingPriority = this.convertSamplingPriority(b3SamplingId);
			}
		}

		return false;
	}
```

### Multiple Header Code Implementation

```java
	private static void b3TraceByMultiple(){
        String traceId = DDId.from("6917954032704516265").toHexStringOrOriginal();
        Tracer tracer = GlobalTracer.get();
        String parentId = DDId.from("4025816492133344807").toHexStringOrOriginal();
        for (int i = 0; i < 3; i++) {
            Map<String, String> data = new HashMap<>();
            data.put("X-B3-TraceId", traceId);
            data.put("X-B3-SpanId", parentId);

            SpanContext extractedContext = tracer.extract(Format.Builtin.HTTP_HEADERS, new TextMapAdapter(data));
            Span serverSpan = tracer.buildSpan("opt"+i)
                    .withTag("service","someService"+i)
                    .asChildOf(extractedContext)
                    .start();
            serverSpan.setTag("code","200");
            tracer.activateSpan(serverSpan).close();
            serverSpan.finish();
            parentId = DDId.from(serverSpan.context().toSpanId()).toHexStringOrOriginal();
            System.out.println( traceId+"\t"+serverSpan.context().toTraceId()+"\t"+parentId);
        }

    }

```

> **Note:** Multiple Header must include two headers: `X-B3-TraceId` and `X-B3-SpanId`. From the interceptor analysis, these headers are case-insensitive.

```bash
6001828a33d570a9	6917954032704516265	58c4b35f113ee353
6001828a33d570a9	6917954032704516265	330359b7aaea9d6b
6001828a33d570a9	6917954032704516265	1ac0dcd332f9262f
```

### Single Header Code Implementation

```java
	private static void b3TraceBySingle(){
        String traceId = DDId.from("6917954032704516265").toHexStringOrOriginal();
        Tracer tracer = GlobalTracer.get();
        String parentId = DDId.from("4025816492133344807").toHexStringOrOriginal();
        for (int i = 0; i < 3; i++) {
            String b3 = traceId+ "-"+parentId+"-1";
            Map<String, String> data = new HashMap<>();
            data.put("b3",b3);
            SpanContext extractedContext = tracer.extract(Format.Builtin.HTTP_HEADERS, new TextMapAdapter(data));
            Span serverSpan = tracer.buildSpan("opt"+i)
                    .withTag("service","someService"+i)
                    .asChildOf(extractedContext)
                    .start();
            serverSpan.setTag("code","200");
            tracer.activateSpan(serverSpan).close();
            serverSpan.finish();
            parentId = DDId.from(serverSpan.context().toSpanId()).toHexStringOrOriginal();
            System.out.println( traceId+"\t"+serverSpan.context().toTraceId()+"\t"+parentId);
            System.out.println("b3="+b3);
        }

    }
```

```bash
6001828a33d570a9	6917954032704516265	308287d022272ed9
b3=6001828a33d570a9-37de92c518846627-1
6001828a33d570a9	6917954032704516265	5e6fbaad91daef5c
b3=6001828a33d570a9-308287d022272ed9-1
6001828a33d570a9	6917954032704516265	2cfbc225bddf5e6d
b3=6001828a33d570a9-5e6fbaad91daef5c-1
```

> **Note:** Single Header only requires the `b3` header, with the format `traceId-parentId-Sampled`

## Enabling Multiple Propagators

Choose either of the two methods:

- System Property:

```shell
-Ddd.propagation.style.inject=Datadog,B3SINGLE
-Ddd.propagation.style.extract=Datadog,B3SINGLE
```

- Environment Variable:

```shell
DD_PROPAGATION_STYLE_INJECT=Datadog,B3SINGLE
DD_PROPAGATION_STYLE_EXTRACT=Datadog,B3SINGLE
```