# Quick Start with PromQL

## Overview

[PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) is the query language of the [Prometheus monitoring system](https://prometheus.io/). It has a concise yet powerful syntax. The syntax of PromQL differs significantly from typical SQL languages, and beginners often need to spend several hours reading the [official PromQL documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/) to understand how it works.

Follow our guide here to quickly grasp the essence of PromQL's design and master its usage.

## Selecting Time Series with PromQL

To select time series in PromQL, you can simply write the series name. For example, the following query returns all time series named `node_network_receive_bytes_total`:

```
node_network_receive_bytes_total
```

This name corresponds to the [node_exporter metric](https://github.com/prometheus/node_exporter), which includes the number of bytes received by various network interfaces. A simple query like this might return time series with the following labels for network interfaces `eth0`, `eth1`, and `eth2`:

```
node_network_receive_bytes_total{device="eth0"}
node_network_receive_bytes_total{device="eth1"}
node_network_receive_bytes_total{device="eth2"}
```

Different labels are enclosed in curly braces: `{device="eth0"}`, `{device="eth1"}`, `{device="eth2"}`.

## Mearsurement

All metrics in <<< custom_key.brand_name >>> belong to a Mearsurement, and we manage the lifecycle of metrics at the Mearsurement level. The concept of Mearsurement does not exist in Prometheus; it can be manually configured or automatically generated based on prefixes when reporting through Datakit. For more details, refer to the [Datakit documentation](../integrations/prom.md).

Continuing with the `node_network_receive_bytes_total` metric as an example, if we use automatic rules in Datakit to generate this metric, it will be split into a Mearsurement and Field, namely `node` and `network_receive_bytes_total`.

In queries, this changes slightly. Continuing with the different network interfaces mentioned earlier:

```
node:network_receive_bytes_total{device="eth0"}
node:network_receive_bytes_total{device="eth1"}
node:network_receive_bytes_total{device="eth2"}
```

You can observe that the metric name filter format now becomes `measurement:field`, connected by a colon.

## Filtering by Labels

A single metric name may correspond to multiple time series with different label sets, as shown in the previous example. How do you select only the time series matching `{device="eth1"}`? Just mention the required label in the query:

```
node:network_receive_bytes_total{device="eth1"}
```

If you want to select all time series except those for device `eth1`, replace `=` with `!=` in the query:

```
node:network_receive_bytes_total{device!="eth1"}
```

How do you select time series for devices starting with `eth`? Use a regular expression:

```
node:network_receive_bytes_total{device=~"eth.+"}
```

Filters can contain any Go-compatible regular expressions (also known as RE2).

To select all time series for devices not starting with `eth`, replace `=~` with `!~`:

```
node:network_receive_bytes_total{device!~"eth.+"}
```

## Filtering by Multiple Labels

You can combine label filters. For example, the following query returns only the time series for devices starting with `eth` on the `node42:9100` instance:

```
node:network_receive_bytes_total{instance="node42:9100", device=~"eth.+"}
```

Label filters are combined using the `and` operator, meaning "return time series matching this filter `and` that filter". How do you implement the `or` operator? Currently, PromQL lacks an `or` operator for combining label filters, but in most cases, it can be replaced with regular expressions. For example, the following query returns time series for devices `eth1` or `lo`:

```
node:network_receive_bytes_total{device=~"eth1|lo"}
```

## Filtering Metrics or Mearsurement Names by Regular Expressions

Mearsurements and metric names are actually ordinary labels with special names: `__measurement__` and `__field__`. Therefore, you can apply regular expressions to these labels to filter the data you want.

For example, to query all time series in the `node` Mearsurement with metric names `network_receive_bytes_total` or `network_transmit_bytes_total`:

```
{__measurement__="node", __field__=~"network_(receive|transmit)_bytes_total"}
```

Or to query time series with metric names `network_receive_bytes_total` or `network_transmit_bytes_total` distributed across `node1` and `node2` Mearsurements:

```
{__measurement__=~"node1|node2", __field__=~"network_(receive|transmit)_bytes_total"}
```

## Comparing Current Data with Historical Data

PromQL allows querying historical data and combining/comparing it with current data. Just add `offset` to your query. For example, the following query returns data from one week ago for all time series named `node:network_receive_bytes_total`:

```
node:network_receive_bytes_total offset 7d
```

The following query returns points where the current GC overhead exceeds 1.5 times the GC overhead one hour ago.

```
go:memstats_gc_cpu_fraction > 1.5 * (go:memstats_gc_cpu_fraction offset 1h)
```

We will introduce the `>` and `*` operators below.

## Calculating Rates

Careful readers may have noticed that the charts for all the above queries draw continuously increasing lines:

![](img/promql.png)

Such graphs are almost useless because they display hard-to-interpret growing counter values, whereas we need to visualize network bandwidth. PromQL has a function [rate](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate) that calculates the per-second rate for all matching time series:

```
rate(node:network_receive_bytes_total[5m])
```

Now the graph makes sense:

![](img/promql-1.png)

What does `[5m]` mean in the query? It is a time duration (d).

In our case, it is 5 minutes—when calculating the per-second rate for each graph point, it looks back this duration. Simplified rate calculation for each point is: `(Vcurr-Vprev) / (Tcurr-Tprev)`, where `Vcurr` is the value at the current point `-Tcurr`, and `Vprev` is the value at the point `Tprev = Tcurr-d`.

If this seems too complex, just remember that a higher `d` smooths the graph, while a lower `d` adds more noise to the graph.

<<< custom_key.brand_name >>> uses an extended PromQL syntax called [MetricsQL](metricsql.md) (thanks to [VictoriaMetrics](https://docs.victoriametrics.com/) for open-sourcing!). In this case, `[d]` can be omitted, and it equals the duration between two consecutive points on the graph (also known as "step"):

```
rate(node:network_receive_bytes_total)
```

So when you're unsure about what duration to fill after `rate`, feel free to omit it directly.

## Notes on `rate`

`rate` removes the metric name but retains all labels of the internal time series.

Do not apply `rate` to time series that can fluctuate up and down. Such time series are called [gauges](https://prometheus.io/docs/concepts/metric_types/#gauge). `rate` should only be applied to [counters](https://prometheus.io/docs/concepts/metric_types/#counter), which always increase but may reset to zero occasionally (e.g., during service restarts).

Do not use `irate` instead of `rate`, as it [cannot capture spikes](https://medium.com/@valyala/why-irate-from-prometheus-doesnt-capture-spikes-45f9896d7832), and it is not much faster than `rate`.

## Arithmetic Operators

PromQL supports all basic [arithmetic operations](https://prometheus.io/docs/prometheus/latest/querying/operators/#arithmetic-binary-operators):

- Addition (+)
- Subtraction (-)
- Multiplication (*)
- Division (/)
- Modulo (%)
- Exponentiation (^)

This enables various transformations. For example, converting bytes/second to bits/second:

```
rate(node:network_receive_bytes_total[5m]) * 8
```

Additionally, this allows cross-time series calculations. For example, the Flux query in [this article](https://www.influxdata.com/blog/practical-uses-of-cross-measurement-math-in-flux/) can be simplified to the following PromQL query:

```
co2 * (((temp_c + 273.15) * 1013.25) / (pressure * 298.15))
```

Combining multiple time series using arithmetic operators requires understanding [matching rules](https://prometheus.io/docs/prometheus/latest/querying/operators/#vector-matching). Otherwise, queries may fail or produce incorrect results. The basics of matching rules are simple:

- The PromQL engine strips the metric names from all time series on both sides without touching the labels.
- For each time series on the left side, the PromQL engine searches for corresponding time series on the right side with the same label set, applies the operation to each data point, and returns the resulting time series with the same label set. If there is no match, the time series is removed from the result.

Matching rules can be enhanced with modifiers such as `ignoring`, `on`, `group_left`, and `group_right`. This is complex but usually unnecessary.

## PromQL Comparison Operators

PromQL supports the following [comparison operators](https://prometheus.io/docs/prometheus/latest/querying/operators/#comparison-binary-operators):

- Equal (==)
- Not equal (!=)
- Greater than (>)
- Greater than or equal (>=)
- Less than (<)
- Less than or equal (<=)

These operators can be applied to any PromQL expression, just like arithmetic operators. The result of a comparison is a time series of matching data points. For example, the following query returns only time series with bandwidth less than 2300 bytes/second:

```
rate(node:network_receive_bytes_total[5m]) < 2300
```

This results in a graph with gaps where the bandwidth exceeds 2300 bytes/second:

```
rate(node:network_receive_bytes_total[5m]) < 2300
```

Comparison results can be enhanced with the `bool` modifier:

```
rate(node:network_receive_bytes_total[5m]) < bool 2300
```

In this case, the result will contain 1 for true comparisons and 0 for false comparisons:

```
rate(node:network_receive_bytes_total[5m]) < bool 2300
```

## Aggregation and Grouping Functions

PromQL allows [aggregating and grouping time series](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators). Time series are grouped by given label sets, and then the specified aggregation function is applied to each group. For example, the following query returns the summary ingress traffic grouped by instance across all nodes running `node_exporter`:

```
sum(rate(node:network_receive_bytes_total[5m])) by (instance)
```

## Using Gauges

Gauges are time series that can fluctuate up and down at any time. For example, memory usage, temperature, or pressure. When drawing graphs for dashboards, expect minimum, maximum, average, and/or quantile values for each point. PromQL provides [functions](https://prometheus.io/docs/prometheus/latest/querying/functions/#aggregation_over_time) to achieve this:

For example, the following query draws the minimum idle memory for each point on the graph:

```
min_over_time(node:memory_MemFree_bytes[5m])
```

MetricsQL adds [rollup_*](https://docs.victoriametrics.com/MetricsQL.html#rollup) functions to PromQL, which automatically return `min`, `max`, and `avg` values when applied to gauges. For example:

```
rollup(node:memory_MemFree_bytes)
```

## Label Operations

PromQL provides two functions for modifying, beautifying, deleting, or creating labels:

Although these functions are cumbersome to use, they allow powerful dynamic operations on selected time series labels. The main use of label_ functions is to transform labels into the desired view.

MetricsQL extends these functions with [more convenient label manipulation functions](https://docs.victoriametrics.com/MetricsQL.html#label-manipulation-functions):

- label_set — set additional labels for time series
- label_del — delete given labels from time series
- label_keep — delete all labels from time series except the given ones
- label_copy — copy label values to other labels
- label_move — rename labels
- label_transform — replace all substrings matching a given regular expression with template substitutions
- label_value — return numeric values from given labels

## Returning Multiple Results from a Single Query

Sometimes it is necessary to return multiple results from a single PromQL query. This can be achieved using the [or operator](https://prometheus.io/docs/prometheus/latest/querying/operators/#logical-set-binary-operators). For example, the following query returns all time series named `metric1`, `metric2`, and `metric3`:

```
metric1 or metric2 or metric3
```

MetricsQL [simplifies](https://docs.victoriametrics.com/MetricsQL.html#union) the process of returning multiple results—just list them in `()`:

```
(metric1, metric2, metric3)
```

Note: Any PromQL expression can be used instead of metric names.

When combining expression results, there is a common pitfall: results with duplicate label sets will be skipped. For example, the following query skips `sum(b)` because both `sum(a)` and `sum(b)` have the same label set—they have no labels at all:

```
sum(a) or sum(b)
```

## Conclusion

PromQL is an easy-to-use yet powerful query language for time series databases. Compared to SQL, InfluxQL, or Flux, it allows writing typical TSDB queries in a concise and clear manner.

This tutorial does not cover all PromQL features, as some are not commonly used:

- It does not mention many [functions](https://prometheus.io/docs/prometheus/latest/querying/functions/) and [logical operators](https://prometheus.io/docs/prometheus/latest/querying/operators/#logical-set-binary-operators).
- It does not cover common expressions (i.e., CTE or [WITH templates](https://victoriametrics.com/promql/expand-with-exprs)).
- It does not cover many useful features supported by [MetricsQL](https://docs.victoriametrics.com/MetricsQL.html).

You can continue learning PromQL using this [PromQL cheat sheet](https://promlabs.com/promql-cheat-sheet/).

*This content is translated from [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085). <<< custom_key.brand_name >>> also uses the [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) open-source [MetricsQL](https://docs.victoriametrics.com/MetricsQL.html) engine implementation, thanks again to VictoriaMetrics!*

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **MetricsQL Syntax Reference**</font>](./metricsql.md)

</div>