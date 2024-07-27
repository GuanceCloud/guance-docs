# OTEL Agent 采样策略

> *作者： 宋龙奇*

## 前言 {#preface}

在分布式服务链路跟踪中，您可以在分布式系统中观察请求从一个服务到另一个服务的过程，这是非常必要的，但是 很多情况下
数据都是大量的重复，这些数据真的很重要吗？这时候通过一个正确的采样策略减少不必要的流量开支。

> 采样是指接受数据并准备导出或者存储的数据。有时候 采样被误解，认为是被舍弃的数据，这是不对的。

上一篇 [OpenTelemetry 采样最佳实践](./opentelemetry-simpling.md) 主要介绍 `opentelemetry-collector` 的采样策略，这篇文章主要介绍 Java Agent 端的采样。

## 采样策略 {#sampling}

### 头部采样 {#head-sampling}

头部采样的最常见形式是一致的概率采样。它也可以称为确定性抽样。在这种情况下，根据 TraceID 和样品痕迹的所需百分比做出采样决定。这样可以确保对整个轨迹进行采样，例如所有痕迹的 5％，那么 会将所有所有产生的链路按照 5% 的比例采样。

头部采样的优点有很多：

* 配置简单
* 理解简单
* 高效率
* 可以配置在任意地方

同样缺点也很明显：是不可能根据整个轨迹中的数据做出采样决定。当链路中出现了错误时并不能确保采样并上传，对于问题排查是不利的。

因此，需要了解尾部采样。

### 尾部采样 {#tail-sampling}

尾部采样是指通过考虑链路中的所有或大部分 Span 来决定对链路进行采样的情况。“尾部采样”使您可以选择根据源自轨迹不同部分的特定标准对轨迹进行采样，这是“头部采样”所做不到的。

几个尾部采样的场景：

* 所有包含错误的链路都采样
* 基于整体延迟的进行采样
* 基于特定的事件进行采样
* http code 不为 200 的采样
* 其他标准进行采样

尾部采样存在很多难点：

* 尾部采样可能很难实现。根据您可以使用的采样技术的类型，它并不总是一种“设置并忘记”的事情。随着系统的变化，采样策略也会发生变化。对于大型复杂的分布式系统，实现采样策略的规则也肯定是大型复杂的。
* 尾部采样可能很难操作。实现尾部采样的节点必须接受所有的数据，有时候可能是几十个节点的链路数据，再进行计算。有时候计算的速度跟不上接收量，基于这些 正确的尾部采样节点需要大量的资源。
* 如今，可能某些大型供应商才能提供尾部采样的选项。

关于头部采样和尾部采样的介绍大致就是这样。

最后，对于某些会产生大量 span 数据的应用应当选用头部采样，这样链路通道不会因为过载而导致拥堵。

在 OTEL JAVA Agent 中采用的是基于***头部采样***的策略，这点需要事先了解。

其他语言的支持或者 Collector 的配置，请查看：[官方文档](https://opentelemetry.io/docs/concepts/sampling/){:target="_blank"}

***

## agent 中的采样器 Sampler {#sampler}

在 OTEL 中有两个环境变量配置采样：`OTEL_TRACES_SAMPLER`  和 `OTEL_TRACES_SAMPLER_ARG` :

## 如何选择采样的配置

`OTEL_TRACES_SAMPLER` 的配置是：

* `"always_on"`: AlwaysOnSampler 默认配置 1.0 也就是不采样
* `"always_off"`: AlwaysOffSampler 始终采集任何链路
* `"traceidratio"`: TraceIdRatioBased 根据 trace id 概率采样
* `"parentbased_always_on"`: ParentBased(基于 AlwaysOnSampler)
* `"parentbased_always_off"`: ParentBased(基于 AlwaysOffSampler)
* `"parentbased_traceidratio"`: ParentBased(基于 TraceIdRatioBased)
* `"parentbased_jaeger_remote"`: ParentBased(基于 JaegerRemoteSampler)
* `"jaeger_remote"`: JaegerRemoteSampler
* `"xray"`: [AWS X-Ray Centralized Sampling](https://docs.aws.amazon.com/xray/latest/devguide/xray-console-sampling.html){:target="_blank"} (*third party*)

`OTEL_TRACES_SAMPLER_ARG` 配置

* 1.0  默认情况下是 1.0，也就是全部采样
* \[0-1.0] 概率采样，如 0.25 也就是 25% 的采样率
* 采样的配置只有 `traceidratio` 和 `parentbased_traceidratio` 的情况下，`OTEL_TRACES_SAMPLER_ARG` 才会生效。

### 常用的配置 {#config}

`OTEL_TRACES_SAMPLER=parentbased_traceidratio`（基于父级的 Trace ID 比率）：这种采样策略基于父级的 Trace ID 来确定子级是否应该被采样。当一个新的请求到达时，它会检查父级的 Trace ID 是否在指定的比率范围内。如果是，则子级也将被采样。这种策略确保了请求和其相关操作之间的关联性。这对于分布式跟踪系统非常有用。

`OTEL_TRACES_SAMPLER=traceidratio`（Trace ID 比率）：这种采样策略根据每个请求的 Trace ID 来确定是否要对该请求进行采样。每个请求都有一个唯一的 Trace ID。使用该策略时，每个请求都会根据指定的比率独立地决定是否被采样。这种策略适用于不需要考虑请求之间的关联性，而只关注每个请求本身的采样率。

综上所述，`OTEL_TRACES_SAMPLER=parentbased_traceidratio` 基于父级的 Trace ID 来决定子级的采样率，而 `OTEL_TRACES_SAMPLER=traceidratio` 则根据每个请求的 Trace ID 独立地决定采样率。选择适合您需求的策略取决于您对请求之间关联性的关注程度。

常用的命令为：

```JAVA
-Dotel.traces.sampler=traceidratio
-Dotel.traces.sampler.arg=0.2
```

***

## 自定义 Sampler 插件 {#extension-sampler}

OTEL agent 提供插件接口 [Extensions](https://opentelemetry.io/docs/instrumentation/JAVA/automatic/extensions/){:target="_blank"} ，可以通过自定义 Sampler 实现采样。

这是自定义 Sampler 需要实现的接口：

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

在接口实现中可以看到这里有几个参数： `parentContext`, `traceId`, `name`, `spanKind`, `attributes`, `parentLinks` 。

所以，在自定义的 Sampler 中可以从多个维度进行判定该条链路是否要进行采样：

* 标签过滤
* traceId 比例采样
* name 等

但是，这仍然无法避免在比例采样中将带有错误的 span 删除掉，这是因为 `shouldSample()` 是在 span 初始化的时候调用的，而错误往往是在 span 结束时才会填充到对应的 Event 中。
