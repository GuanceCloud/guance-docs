# Quick Start with PromQL

## Overview

[PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) is the query language of the [Prometheus monitoring system](https://prometheus.io/), featuring concise and powerful syntax. PromQL's syntax differs significantly from traditional SQL, and beginners often need to spend several hours reading the [official PromQL documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/) to understand how it works.

Follow our guide here to quickly grasp the essence of PromQL's design and master its usage.

## Selecting Time Series with PromQL

To select time series in PromQL, simply write the series name. For example, the following query will return all time series named `node_network_receive_bytes_total`:

```
node_network_receive_bytes_total
```

This name corresponds to the [node_exporter metric](https://github.com/prometheus/node_exporter) and includes the number of bytes received by various network interfaces. A simple query like this might return time series with the following labels for network interfaces `eth0`, `eth1`, and `eth2`:

```
node_network_receive_bytes_total{device="eth0"}
node_network_receive_bytes_total{device="eth1"}
node_network_receive_bytes_total{device="eth2"}
```

Different labels are enclosed in curly braces: `{device="eth0"}`, `{device="eth1"}`, `{device="eth2"}`.

## Metrics Set Measurement

All metrics in Guance belong to a Mearsurement set, and we manage the lifecycle of metrics at the Mearsurement level. The concept of Mearsurement does not exist in Prometheus; it can be manually configured or automatically generated based on prefixes when reporting through Datakit. For more details, refer to the [Datakit documentation](../integrations/prom.md).

Continuing with the `node_network_receive_bytes_total` metric as an example, if we use Datakit's automatic rules to generate this metric, it would be split into two parts: `node` (Mearsurement) and `network_receive_bytes_total` (Field).

The query format changes slightly accordingly. Using the different network interfaces mentioned earlier:

```
node:network_receive_bytes_total{device="eth0"}
node:network_receive_bytes_total{device="eth1"}
node:network_receive_bytes_total{device="eth2"}
```

Notice that the metric name filter format has changed to `measurement:field`, connected by a colon.

## Filtering by Labels

A single metric name may correspond to multiple time series with different label sets, as shown in the example above. How do you select only the time series matching `{device="eth1"}`? Just mention the required label in your query:

```
node:network_receive_bytes_total{device="eth1"}
```

To select all time series except those with `eth1`, replace `=` with `!=` in the query:

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

You can combine label filters. For example, the following query returns time series only for the `node42:9100` instance with devices starting with `eth`:

```
node:network_receive_bytes_total{instance="node42:9100", device=~"eth.+"}
```

Label filters are combined using the `and` operator, meaning "return time series matching this filter `and` that filter." How do you implement the `or` operator? Currently, PromQL lacks an `or` operator for combining label filters, but in most cases, it can be replaced with regular expressions. For example, the following query returns time series for `eth1` or `lo` devices:

```
node:network_receive_bytes_total{device=~"eth1|lo"}
```

## Filtering Metric or Mearsurement Names by Regular Expressions

Metrics names and Mearsurement names are essentially special labels: `__measurement__` and `__field__`. Therefore, you can apply regular expressions to these labels to filter the data you want.

For example, to query all time series in the `node` Mearsurement with `network_receive_bytes_total` or `network_transmit_bytes_total` metric names:

```
{__measurement__="node", __field__=~"network_(receive|transmit)_bytes_total"}
```

Or to query `network_receive_bytes_total` or `network_transmit_bytes_total` metrics across `node1` and `node2` Mearsurements:

```
{__measurement__=~"node1|node2", __field__=~"network_(receive|transmit)_bytes_total"}
```

## Comparing Current Data with Historical Data

PromQL allows querying historical data and combining/comparing it with current data. Simply add `offset` to your query. For example, the following query returns data from one week ago for all time series named `node:network_receive_bytes_total`:

```
node:network_receive_bytes_total offset 7d
```

The following query returns points where the current GC overhead exceeds 1.5 times the GC overhead from one hour ago.

```
go:memstats_gc_cpu_fraction > 1.5 * (go:memstats_gc_cpu_fraction offset 1h)
```

We'll introduce the `>` and `*` operators below.

## Calculating Rates

Careful readers may have noticed that the graphs for all queries so far show continuously increasing lines:

![](img/promql.png)

Such graphs are nearly useless because they display difficult-to-interpret growing counter values, whereas we need to plot network bandwidth. PromQL has a function [rate](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate) that calculates the per-second rate for all matching time series:

```
rate(node:network_receive_bytes_total[5m])
```

Now the graph makes sense:

![](img/promql-1.png)

What does `[5m]` mean in the query? It specifies the time duration (d).

In our case, it's 5 minutes—looking back this duration when calculating the per-second rate for each graph point. The simplified rate calculation for each point is: `(Vcurr-Vprev) / (Tcurr-Tprev)`, where `Vcurr` is the value at the current point `-Tcurr`, and `Vprev` is the value at `Tprev = Tcurr-d`.

If this seems too complex, just remember that a higher `d` smooths the graph, while a lower `d` introduces more noise.

Guance uses an extended PromQL syntax called [MetricsQL](metricsql.md) (thanks to [VictoriaMetrics](https://docs.victoriametrics.com/) for open-sourcing it!), in which `[d]` can be omitted—it defaults to the duration between consecutive points on the graph (also known as "step"):

```
rate(node:network_receive_bytes_total)
```

So when you're unsure what duration to use after `rate`, feel free to omit it.

## Notes on `rate`

`rate` removes the metric name but retains all labels of the internal time series.

Do not apply `rate` to time series that can fluctuate up and down. Such time series are called [gauges](https://prometheus.io/docs/concepts/metric_types/#gauge). `rate` should only be applied to [counters](https://prometheus.io/docs/concepts/metric_types/#counter), which always increase but may reset to zero occasionally (e.g., during service restarts).

Do not use `irate` instead of `rate`, as it [cannot capture spikes](https://medium.com/@valyala/why-irate-from-prometheus-doesnt-capture-spikes-45f9896d7832) and is not much faster than `rate`.

## Arithmetic Operators

PromQL supports all basic [arithmetic operations](https://prometheus.io/docs/prometheus/latest/querying/operators/#arithmetic-binary-operators):

- Addition (+)
- Subtraction (-)
- Multiplication (*)
- Division (/)
- Modulo (%)
- Exponentiation (^)

This allows for various transformations. For example, converting bytes/second to bits/second:

```
rate(node:network_receive_bytes_total[5m]) * 8
```

Additionally, this enables calculations across time series. For example, the Flux query in [this article](https://www.influxdata.com/blog/practical-uses-of-cross-measurement-math-in-flux/) can be simplified to the following PromQL query:

```
co2 * (((temp_c + 273.15) * 1013.25) / (pressure * 298.15))
```

Using arithmetic operators to combine multiple time series requires understanding [matching rules](https://prometheus.io/docs/prometheus/latest/querying/operators/#vector-matching). Otherwise, queries may fail or produce incorrect results. The basics of matching rules are:

- The PromQL engine strips the metric names from all time series on both sides, leaving the labels untouched.
- For each time series on the left side, the PromQL engine searches for corresponding time series on the right side with matching label sets, applies the operation to each data point, and returns the resulting time series with the same label set. If no match is found, the time series is removed from the result.

Matching rules can be enhanced with modifiers like `ignoring`, `on`, `group_left`, and `group_right`. This can be complex but is rarely necessary.

## PromQL Comparison Operators

PromQL supports the following [comparison operators](https://prometheus.io/docs/prometheus/latest/querying/operators/#comparison-binary-operators):

- Equal (==)
- Not equal (!=)
- Greater than (>)
- Greater than or equal (>=)
- Less than (<)
- Less than or equal (<=)

These operators can be applied to any PromQL expression, similar to arithmetic operators. The result of a comparison is a time series of matching data points. For example, the following query returns only time series with bandwidth less than 2300 bytes/second:

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

PromQL allows [aggregating and grouping time series](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators). Time series are grouped by the given label set, and the specified aggregation function is applied to each group. For example, the following query returns summary inbound traffic grouped by instance across all nodes running `node_exporter`:

```
sum(rate(node:network_receive_bytes_total[5m])) by (instance)
```

## Using Gauges

Gauges are time series that can fluctuate up and down. Examples include memory usage, temperature, or pressure. When plotting gauges on dashboards, expect minimum, maximum, average, and/or quantile values for each point. PromQL provides [functions](https://prometheus.io/docs/prometheus/latest/querying/functions/#aggregation_over_time) to achieve this:

For example, the following query plots the minimum idle memory for each point on the graph:

```
min_over_time(node:memory_MemFree_bytes[5m])
```

MetricsQL adds [rollup_* functions](https://docs.victoriametrics.com/MetricsQL.html#rollup) to PromQL, which automatically return `min`, `max`, and `avg` values when applied to gauges. For example:

```
rollup(node:memory_MemFree_bytes)
```

## Label Operations

PromQL provides two functions for modifying, beautifying, deleting, or creating labels:

Although these functions can be cumbersome, they allow powerful dynamic manipulation of selected time series labels. The main purpose of label_ functions is to transform labels into the desired view.

MetricsQL extends these functions with [more convenient label manipulation functions](https://docs.victoriametrics.com/MetricsQL.html#label-manipulation-functions):

- label_set — Adds extra labels to time series
- label_del — Removes specified labels from time series
- label_keep — Removes all labels from time series except the specified ones
- label_copy — Copies label values to other labels
- label_move — Renames labels
- label_transform — Replaces all substrings matching a given regular expression with a template replacement
- label_value — Returns numerical values from given labels

## Returning Multiple Results from a Single Query

Sometimes you need to return multiple results from a single PromQL query. This can be achieved using the [or operator](https://prometheus.io/docs/prometheus/latest/querying/operators/#logical-set-binary-operators). For example, the following query returns all time series named `metric1`, `metric2`, and `metric3`:

```
metric1 or metric2 or metric3
```

MetricsQL [simplifies](https://docs.victoriametrics.com/MetricsQL.html#union) returning multiple results—just list them in `()`:

```
(metric1, metric2, metric3)
```

Note: Any PromQL expression can be used instead of metric names.

When combining expression results, there is a common pitfall: results with duplicate label sets will be skipped. For example, the following query skips `sum(b)` because both `sum(a)` and `sum(b)` have the same label set—they have no labels:

```
sum(a) or sum(b)
```

## Conclusion

PromQL is an easy-to-use yet powerful query language for time series databases. Compared to SQL, InfluxQL, or Flux, it allows writing typical TSDB queries in a concise and clear manner.

This tutorial does not cover all PromQL features because some are less commonly used:

- It doesn't mention many [functions](https://prometheus.io/docs/prometheus/latest/querying/functions/) and [logical operators](https://prometheus.io/docs/prometheus/latest/querying/operators/#logical-set-binary-operators).
- It doesn't cover common expressions (i.e., CTE or [WITH templates](https://victoriametrics.com/promql/expand-with-exprs)).
- It doesn't cover many useful features supported by [MetricsQL](https://docs.victoriametrics.com/MetricsQL.html).

You can continue learning PromQL using this [PromQL cheat sheet](https://promlabs.com/promql-cheat-sheet/).

*The main content of this article is translated from [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085). Guance is also using the open-source [MetricsQL](https://docs.victoriametrics.com/MetricsQL.html) engine implementation from [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics). Thanks again to VictoriaMetrics!* 

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **MetricsQL Syntax Reference**</font>](./metricsql.md)

</div>