# OTEL Agent Sampling Strategy

> *Author: Longqi Song*

## Preface {#preface}

In distributed service tracing, you can observe requests as they travel from one service to another within a distributed system, which is essential. However, in many cases, the data is largely repetitive. Is all this data really important? This is where an appropriate sampling strategy can reduce unnecessary traffic costs.

> Sampling refers to accepting data and preparing it for export or storage. Sometimes sampling is misunderstood as discarded data, which is incorrect.

The previous article [OpenTelemetry Sampling Best Practices](./opentelemetry-simpling.md) primarily introduced the sampling strategies of `opentelemetry-collector`. This article focuses on the sampling strategies at the Java Agent level.

## Sampling Strategies {#sampling}

### Head Sampling {#head-sampling}

The most common form of head sampling is consistent probabilistic sampling. It can also be called deterministic sampling. In this case, the sampling decision is made based on the TraceID and the desired percentage of traces. This ensures that a certain percentage of all traces are sampled, for example, 5% of all traces will sample all generated spans at a rate of 5%.

The advantages of head sampling are numerous:

* Simple configuration
* Easy to understand
* High efficiency
* Can be configured anywhere

However, the disadvantages are also obvious: it is impossible to make sampling decisions based on data from the entire trace. When errors occur in the chain, it cannot ensure that the trace is sampled and uploaded, which is detrimental to troubleshooting.

Therefore, tail sampling needs to be understood.

### Tail Sampling {#tail-sampling}

Tail sampling refers to deciding whether to sample a trace by considering all or most of the Spans in the trace. "Tail sampling" allows you to sample traces based on specific criteria originating from different parts of the trace, which "head sampling" cannot achieve.

Several scenarios for tail sampling include:

* All traces containing errors are sampled
* Sampling based on overall latency
* Sampling based on specific events
* Sampling when the HTTP code is not 200
* Sampling based on other criteria

There are many challenges with tail sampling:

* Tail sampling can be difficult to implement. Depending on the type of sampling technology available, it is not always a "set and forget" thing. As the system changes, the sampling strategy also changes. For large and complex distributed systems, the rules for implementing the sampling strategy will also be large and complex.
* Tail sampling can be difficult to operate. Nodes implementing tail sampling must accept all data, sometimes from dozens of nodes' trace data, and then perform calculations. Sometimes the calculation speed cannot keep up with the reception volume. Therefore, proper tail sampling nodes require substantial resources.
* Today, only some large vendors may provide options for tail sampling.

This concludes the introduction to head sampling and tail sampling.

Finally, for applications that generate a large amount of Span data, head sampling should be used to prevent congestion in the trace channel due to overload.

In OTEL JAVA Agent, a **head sampling** strategy is adopted, which should be understood beforehand.

For support in other languages or Collector configurations, please refer to the [official documentation](https://opentelemetry.io/docs/concepts/sampling/){:target="_blank"}

***

## Samplers in the Agent {#sampler}

In OTEL, there are two environment variables for configuring sampling: `OTEL_TRACES_SAMPLER` and `OTEL_TRACES_SAMPLER_ARG`:

## How to Choose Sampling Configuration

The configuration options for `OTEL_TRACES_SAMPLER` are:

* `"always_on"`: AlwaysOnSampler, default configuration 1.0, meaning no sampling
* `"always_off"`: AlwaysOffSampler, never samples any trace
* `"traceidratio"`: TraceIdRatioBased, samples based on Trace ID probability
* `"parentbased_always_on"`: ParentBased (based on AlwaysOnSampler)
* `"parentbased_always_off"`: ParentBased (based on AlwaysOffSampler)
* `"parentbased_traceidratio"`: ParentBased (based on TraceIdRatioBased)
* `"parentbased_jaeger_remote"`: ParentBased (based on JaegerRemoteSampler)
* `"jaeger_remote"`: JaegerRemoteSampler
* `"xray"`: [AWS X-Ray Centralized Sampling](https://docs.aws.amazon.com/xray/latest/devguide/xray-console-sampling.html){:target="_blank"} (*third party*)

Configuration for `OTEL_TRACES_SAMPLER_ARG`:

* 1.0 By default, it is set to 1.0, meaning full sampling
* [0-1.0] Probability-based sampling, e.g., 0.25 means a 25% sampling rate
* The configuration only applies to `traceidratio` and `parentbased_traceidratio`.

### Common Configurations {#config}

`OTEL_TRACES_SAMPLER=parentbased_traceidratio` (Parent-based Trace ID Ratio): This sampling strategy determines whether child spans should be sampled based on the parent's Trace ID. When a new request arrives, it checks if the parent's Trace ID falls within the specified ratio. If so, the child spans will also be sampled. This strategy ensures the association between requests and their related operations, which is very useful for distributed tracing systems.

`OTEL_TRACES_SAMPLER=traceidratio` (Trace ID Ratio): This sampling strategy determines whether to sample a request based on its Trace ID. Each request has a unique Trace ID. With this strategy, each request independently decides whether to be sampled based on the specified ratio. This strategy is suitable when you do not need to consider the correlation between requests but focus on the sampling rate of each request.

In summary, `OTEL_TRACES_SAMPLER=parentbased_traceidratio` decides the sampling rate based on the parent's Trace ID, while `OTEL_TRACES_SAMPLER=traceidratio` independently decides the sampling rate based on each request's Trace ID. Choosing the right strategy depends on how much you care about the correlation between requests.

Common commands are:

```JAVA
-Dotel.traces.sampler=traceidratio
-Dotel.traces.sampler.arg=0.2
```

***

## Custom Sampler Plugin {#extension-sampler}

OTEL agent provides plugin interfaces [Extensions](https://opentelemetry.io/docs/instrumentation/JAVA/automatic/extensions/){:target="_blank"}, allowing custom Samplers to be implemented for sampling.

Here is an interface that needs to be implemented for a custom Sampler:

```JAVA
public class DemoSampler implements Sampler {
  @Override
  public SamplingResult shouldSample(
      Context parentContext,
      String traceId,
      String name,
      SpanKind spanKind,
      Attributes attributes,
      List<LinkData> parentLinks) {
    if (spanKind == SpanKind.INTERNAL && name.contains("greeting")) {
      return SamplingResult.create(SamplingDecision.DROP);
    } else {
      return SamplingResult.create(SamplingDecision.RECORD_AND_SAMPLE);
    }
  }

  @Override
  public String getDescription() {
    return "DemoSampler";
  }
}
```

In the interface implementation, you can see several parameters: `parentContext`, `traceId`, `name`, `spanKind`, `attributes`, `parentLinks`.

Thus, in a custom Sampler, multiple dimensions can be used to determine whether a trace should be sampled:

* Tag filtering
* Trace ID ratio sampling
* Name matching

However, this still cannot avoid dropping spans with errors during ratio sampling, as `shouldSample()` is called when the span initializes, while errors are often filled into the corresponding Events only when the span ends.