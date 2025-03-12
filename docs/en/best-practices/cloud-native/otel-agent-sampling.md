# OTEL Agent Sampling Strategy

> *Author: Longqi Song*

## Preface {#preface}

In distributed service tracing, you can observe requests moving from one service to another within a distributed system, which is essential. However, in many cases, the data is largely repetitive. Is this data really important? This is when a proper sampling strategy can reduce unnecessary traffic costs.

> Sampling refers to accepting data and preparing it for export or storage. Sometimes sampling is misunderstood as discarded data, which is incorrect.

The previous article [OpenTelemetry Sampling Best Practices](./opentelemetry-simpling.md) mainly introduced the sampling strategies of `opentelemetry-collector`. This article focuses on the sampling strategies at the Java Agent end.

## Sampling Strategies {#sampling}

### Head-Based Sampling {#head-sampling}

The most common form of head-based sampling is consistent probability sampling. It can also be called deterministic sampling. In this case, the sampling decision is made based on the TraceID and the desired percentage of sampled traces. This ensures that the entire trace is sampled, for example, if 5% of all traces are sampled, then all generated spans will be sampled at a rate of 5%.

Head-based sampling has many advantages:

* Simple configuration
* Easy to understand
* Efficient
* Can be configured anywhere

However, the disadvantages are also obvious: it is impossible to make sampling decisions based on data from the entire trace. When an error occurs in the trace, it cannot ensure that the trace is sampled and uploaded, which is detrimental for troubleshooting.

Therefore, it is necessary to understand tail-based sampling.

### Tail-Based Sampling {#tail-sampling}

Tail-based sampling refers to making sampling decisions based on all or most of the Spans in a trace. "Tail-based sampling" allows you to sample traces based on specific criteria originating from different parts of the trace, which "head-based sampling" cannot achieve.

Several scenarios for tail-based sampling include:

* All traces containing errors are sampled
* Sampling based on overall latency
* Sampling based on specific events
* Sampling where HTTP code is not 200
* Sampling based on other criteria

Tail-based sampling presents many challenges:

* Tail-based sampling can be difficult to implement. Depending on the type of sampling technology available, it is not always a "set and forget" thing. As the system changes, the sampling strategy also changes. For large, complex distributed systems, the rules for implementing sampling strategies will also be large and complex.
* Tail-based sampling can be difficult to operate. Nodes implementing tail-based sampling must accept all data, sometimes involving dozens of nodes' trace data, and then perform calculations. Sometimes the calculation speed cannot keep up with the reception volume. Proper tail-based sampling nodes require substantial resources.
* Today, only some large vendors may offer tail-based sampling options.

That's a general introduction to head-based and tail-based sampling.

Finally, for applications that generate a large amount of Span data, head-based sampling should be used to prevent congestion in the trace channel due to overload.

In OTEL JAVA Agent, a head-based sampling strategy is adopted, which needs to be understood beforehand.

For support in other languages or Collector configurations, please refer to the [official documentation](https://opentelemetry.io/docs/concepts/sampling/){:target="_blank"}

***

## Samplers in the Agent {#sampler}

In OTEL, two environment variables configure sampling: `OTEL_TRACES_SAMPLER` and `OTEL_TRACES_SAMPLER_ARG`:

## How to Choose Sampling Configuration

The configuration options for `OTEL_TRACES_SAMPLER` are:

* `"always_on"`: AlwaysOnSampler, default configuration with a sampling rate of 1.0 (i.e., no sampling)
* `"always_off"`: AlwaysOffSampler, never samples any trace
* `"traceidratio"`: TraceIdRatioBased, samples based on the probability of the Trace ID
* `"parentbased_always_on"`: ParentBased (based on AlwaysOnSampler)
* `"parentbased_always_off"`: ParentBased (based on AlwaysOffSampler)
* `"parentbased_traceidratio"`: ParentBased (based on TraceIdRatioBased)
* `"parentbased_jaeger_remote"`: ParentBased (based on JaegerRemoteSampler)
* `"jaeger_remote"`: JaegerRemoteSampler
* `"xray"`: [AWS X-Ray Centralized Sampling](https://docs.aws.amazon.com/xray/latest/devguide/xray-console-sampling.html){:target="_blank"} (*third party*)

Configuration for `OTEL_TRACES_SAMPLER_ARG`:

* 1.0 By default, it is set to 1.0, meaning all traces are sampled
* [0-1.0] Probability sampling, such as 0.25 for a 25% sampling rate
* The configuration only affects `traceidratio` and `parentbased_traceidratio`.

### Common Configurations {#config}

`OTEL_TRACES_SAMPLER=parentbased_traceidratio` (Parent-based Trace ID Ratio): This sampling strategy determines whether child spans should be sampled based on the parent's Trace ID. When a new request arrives, it checks if the parent's Trace ID falls within the specified ratio. If so, the child span will also be sampled. This strategy ensures the association between requests and their related operations, which is very useful for distributed tracing systems.

`OTEL_TRACES_SAMPLER=traceidratio` (Trace ID Ratio): This sampling strategy determines whether to sample a request based on its Trace ID. Each request has a unique Trace ID. With this strategy, each request independently decides whether to be sampled based on the specified ratio. This strategy is suitable when you do not need to consider the correlation between requests but focus on the sampling rate of each request.

In summary, `OTEL_TRACES_SAMPLER=parentbased_traceidratio` determines the sampling rate of child spans based on the parent's Trace ID, while `OTEL_TRACES_SAMPLER=traceidratio` independently decides the sampling rate for each request based on its Trace ID. Choosing the right strategy depends on your need for correlation between requests.

Common commands include:

```JAVA
-Dotel.traces.sampler=traceidratio
-Dotel.traces.sampler.arg=0.2
```

***

## Custom Sampler Plugins {#extension-sampler}

OTEL agent provides plugin interfaces [Extensions](https://opentelemetry.io/docs/instrumentation/JAVA/automatic/extensions/){:target="_blank"}, allowing custom Samplers to be implemented for sampling.

This is the interface that needs to be implemented for a custom Sampler:

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

In the interface implementation, several parameters are visible: `parentContext`, `traceId`, `name`, `spanKind`, `attributes`, `parentLinks`.

Thus, in a custom Sampler, multiple dimensions can be used to determine whether a trace should be sampled:

* Tag filtering
* Trace ID ratio sampling
* Name matching

However, this still cannot avoid dropping spans with errors in ratio sampling because `shouldSample()` is called during span initialization, while errors are often filled into corresponding Events only when the span ends.