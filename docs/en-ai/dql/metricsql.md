# MetricsQL Syntax Reference

Currently, in the <<< custom_key.brand_name >>> dashboard, you can use the MetricsQL language to query Prometheus metrics.

MetricsQL is a PromQL syntax enhancement language developed by VictoriaMetrics. In most cases, MetricsQL is compatible with PromQL queries but has made enhancements and optimizations to some less intuitive and inconvenient aspects of PromQL. [This article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e) introduces more details about the compatibility design.

In most cases, you can perform queries based on your understanding of PromQL syntax, which usually does not cause errors. When you encounter more complex issues, such as calculating p95 for gauge data or ensuring that topk returns an exact number of sequences, you can find answers through the following syntax reference.

Compared to MetricsQL and PromQL syntax, they have the following main differences:

- MetricsQL considers the previous point in the lookback window, suitable for range functions like [rate](#rate) and [increase](#increase). This allows it to return precise results for `increase(metric[$__interval])` queries, rather than the incomplete results returned by Prometheus for such queries.
- MetricsQL does not speculate on the results of range functions, solving the [issue](https://github.com/prometheus/prometheus/issues/3746) in PromQL. For technical details on how PromQL and MetricsQL calculate [rate](#rate) and [increase](#increase), see the [comments in this issue](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/1215#issuecomment-850305711).
- For [rate](#rate) with a `step` value smaller than the collection interval, MetricsQL returns the expected non-empty response. This resolves the [issue](https://github.com/grafana/grafana/issues/11451) displayed in Grafana. See also [this blog post](https://www.percona.com/blog/2020/02/28/better-prometheus-rate-function-with-victoriametrics/).
- MetricsQL treats `scalar` types and label-less `instant vector` types as identical because the subtle differences between these two types often confuse users. For more information, see the [corresponding Prometheus documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/#expression-language-data-types).
- MetricsQL removes all `NaN` values from the output, so certain queries (such as `(-1)^0.5`) return empty results in MetricsQL while returning a series of `NaN` values in PromQL. Note that the frontend does not plot any lines or points for `NaN` values, so the final result is the same whether using MetricsQL or PromQL.
- After applying functions, MetricsQL retains metric names when those functions do not change the original time series meaning. For example, [min_over_time(foo)](#min_over_time) or [round(foo)](#round) retain the `foo` metric name in their results. For more information, see [this issue](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/674).

At the same time, you should still pay attention to using it within <<< custom_key.brand_name >>>, where there are differences from the original MetricsQL:

- Support for measurement selection requires concatenating the measurement name before the metric name, separated by a colon `increase(measurement:metric[1m])`. Omitting the measurement significantly degrades query performance.
- The <<< custom_key.brand_name >>> UI currently does not support manual configuration of `step`; the current `step` is automatically calculated based on the time range and display density.
- The <<< custom_key.brand_name >>> UI currently does not support Heatmap-type graphical displays, which may affect the display effect of Histograms.

<font color=coral>The content of this article mainly comes from the translation of <u>https://docs.victoriametrics.com/MetricsQL.html</u>. If there are ambiguities in the Chinese translation, you can also refer to the original text.</font>

## Feature List

MetricsQL includes the following features:

- Square brackets containing lookback windows can be ignored. MetricsQL automatically selects the backward-looking window based on the `step` used to build the graph. For example, `rate(node_network_receive_bytes_total)` is valid in MetricsQL. When used in Grafana, it is equivalent to `rate(node_network_receive_bytes_total[$__interval])`.
- [Aggregate functions](#aggregate-functions) can accept any number of parameters. For instance, `avg(q1, q2, q3)` returns the average value for each point of `q1`, `q2`, and `q3`.
- [@Modifiers](https://prometheus.io/docs/prometheus/latest/querying/basics/#modifier) can be placed anywhere in the query. For example, `sum(foo) @ end()` calculates the value of `sum(foo)` at the `end` timestamp in the selected time range `[start ... end]`.
- Any sub-expression can be used as an [@Modifier](https://prometheus.io/docs/prometheus/latest/querying/basics/#modifier). For example, `foo @ (end() - 1h)` computes `foo` at the `end - 1h` timestamp in the selected time range `[start ... end]`.
- The `offset`, lookback window in square brackets, and `step` value in [subqueries](#subqueries) can use `[Ni]` syntax to reference the current step, known as `$__interval` in Grafana. For example, `rate(metric[10i] offset 5i)` returns the per-second rate covering the last 10 steps with a 5-step offset.
- The `offset` can be placed anywhere in the query. For example, `sum(foo) offset 24h`.
- Lookback windows in square brackets and `offset` can be fractional. For example, `rate(node_network_receive_bytes_total[1.5m] offset 0.5d)`.
- Duration suffixes are optional. If omitted, the duration is in seconds. For example, `rate(m[300] offset 1800)` is equivalent to `rate(m[5m]) offset 30m`.
- Durations can be placed anywhere in the query. For example, `sum_over_time(m[1h]) / 1h` is equivalent to `sum_over_time(m[1h]) / 3600`.
- Numerical values can have suffixes `K`, `Ki`, `M`, `Mi`, `G`, `Gi`, `T`, and `Ti`. For example, `8K` equals `8000`, and `1.2Mi` equals `1.2*1024*1024`.
- Trailing commas are allowed in all lists, such as label filters, function parameters, and expressions. For example, the following queries are valid: `m{foo="bar",}`, `f(a, b,)`, `WITH (x=y,) x`. This simplifies the maintenance of multi-line queries.
- Metric names and label names can contain any Unicode letters. For example, `температура{город="Киев"}` is a MetricsQL expression.
- Metric names and label names can contain escape characters. For example, `foo\\\\-bar{baz\\\\=aa="b"}` is a valid expression. It returns the time series named `foo-bar` containing the label `baz=aa` with the value `b`. Additionally, the following escape sequences are supported:
    - `\\\\xXX`, where `XX` is the hexadecimal representation of the escaped ASCII character.
    - `\\\\uXXXX`, where `XXXX` is the hexadecimal representation of the escaped Unicode character.
- Aggregate functions support an optional `limit N` suffix to limit the number of output series. For example, `sum(x) by (y) limit 3` limits the number of aggregated output time series to 3. All other time series will be discarded.
- [histogram_quantile](#histogram_quantile) accepts an optional third parameter `boundsLabel`. In this case, it returns the `lower` and `upper` boundaries of the estimated percentile. For more details, see [this issue](https://github.com/prometheus/prometheus/issues/5706).
- `default` binary operator. `q1 default q2` fills gaps in `q1` with corresponding values from `q2`.
- `if` binary operator. `q1 if q2` removes values from `q1` where `q2` has missing values.
- `ifnot` binary operator. `q1 ifnot q2` removes values from `q1` where `q2` has existing values.
- `WITH` templates. This feature simplifies writing and managing complex queries. You can try it out on the [WITH templates playground](https://play.victoriametrics.com/select/accounting/1/6a716b0f-38bc-4856-90ce-448fd713e3fe/expand-with-exprs).
- String literals can be concatenated. This is useful in `WITH` templates: `WITH (commonPrefix="long_metric_prefix_") {__name__=commonPrefix+"suffix1"} / {__name__=commonPrefix+"suffix2"}`.
- The `keep_metric_names` modifier can be applied to all [Rollup functions](#rollup-functions) and [Transformation functions](#transform-functions). This modifier prevents the removal of metric names in function results. See [these documents](#keep_metric_names).

## keep_metric_names

By default, after applying functions that change the original time series meaning, metric names are removed. When applying functions to multiple time series with different names, this can lead to "duplicate time series" errors. This error can be resolved by applying the `keep_metric_names` modifier to the function.

For example, `rate({__name__=~"foo|bar"}) keep_metric_names` retains the metric names `foo` and `bar` in the returned time series.

## MetricsQL Functions

MetricsQL provides the following functions:

- [Rollup Functions](#rollup-functions)
- [Transformation Functions](#transform-functions)
- [Label Manipulation Functions](#label-manipulation-functions)
- [Aggregate Functions](#aggregate-functions)

### Rollup Functions

**Rollup Functions** (also known as range functions or window functions) perform rolling calculations on **raw samples** over a specified lookback window, applicable to [series selectors](https://docs.victoriametrics.com/keyConcepts.html#filtering). For example, `avg_over_time(temperature[24h])` calculates the average temperature of raw samples over the past 24 hours.

Additional details:

- If Rollup Functions are used to build graphs, each point on each graph is independently calculated. For example, each point on the `avg_over_time(temperature[24h])` graph shows the average temperature over the last 24 hours. The interval between points is set by the `step` query parameter passed by the frontend.
- If the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) returns multiple time series, rolling calculations are computed separately for each returned series.
- If no lookback window is specified in square brackets, MetricsQL automatically sets the lookback window to the interval between points on the graph (also known as the `step` query parameter in [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query), `$__interval` in Grafana, or `1i` duration in MetricsQL). For example, `rate(http_requests_total)` is equivalent to `rate(http_requests_total[$__interval])` in MetricsQL; it is also equivalent to `rate(http_requests_total[1i])`.
- Each [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) in MetricsQL must be wrapped in a Rollup Function. Otherwise, it is automatically converted to [default_rollup](#default_rollup) before performing calculations. For example, `foo{bar="baz"}` is automatically converted to `default_rollup(foo{bar="baz"}[1i])` before performing calculations.
- If anything other than a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) is passed to a Rollup Function, internal parameters are automatically converted to [subqueries](#subqueries).
- All Rollup Functions accept an optional `keep_metric_names` modifier. If this modifier is set, the function retains metric names in the results. See [these documents](#keep_metric_names).

> See [Implicit Query Conversions](#implicit-query-conversions).

### Supported Rollup Functions List

#### absent_over_time

`absent_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns 1 if the given lookback window `d` does not contain any raw samples. Otherwise, it returns an empty result.

> This function is supported by PromQL. Also see [present_over_time](#present_over_time).

#### aggr_over_time

`aggr_over_time(("rollup_func1","rollup_func2",...), series_selector[d])` is a [Rollup Function](#rollup-functions) that computes all listed `rollup_func*` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). `rollup_func*` can include any Rollup Function. For example, `aggr_over_time(("min_over_time","max_over_time","rate"), m[d])` computes [min_over_time](#min_over_time), [max_over_time](#max_over_time), and [rate](#rate) for `m[d]`.

#### ascent_over_time

`ascent_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the ascent of raw sample values over the given lookback window `d`. Calculations are performed separately for each returned time series.

This function is useful for tracking height gain in GPS. The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [descent_over_time](#descent_over_time).

#### avg_over_time

`avg_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the average of raw sample values over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. Also see [median_over_time](#median_over_time).

#### changes

`changes(series_selector[d])` is a [Rollup Function](#rollup-functions) that counts the number of raw sample changes over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Unlike Prometheus's `changes()`, it considers changes from the last sample before the given lookback window `d`. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> This function is supported by PromQL. Also see [changes_prometheus](#changes_prometheus).

#### changes_prometheus

`changes_prometheus(series_selector[d])` is a [Rollup Function](#rollup-functions) that counts the number of raw sample changes over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It does not consider changes from the last sample before the given lookback window `d`, unlike Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> This function is supported by PromQL. Also see [changes](#changes).

#### count_eq_over_time

`count_eq_over_time(series_selector[d], eq)` is a [Rollup Function](#rollup-functions) that counts the number of raw samples equal to `eq` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [count_over_time](#count_over_time).

#### count_gt_over_time

`count_gt_over_time(series_selector[d], gt)` is a [Rollup Function](#rollup-functions) that counts the number of raw samples greater than `gt` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [count_over_time](#count_over_time).

#### count_le_over_time

`count_le_over_time(series_selector[d], le)` is a [Rollup Function](#rollup-functions) that counts the number of raw samples less than or equal to `le` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [count_over_time](#count_over_time).

#### count_ne_over_time

`count_ne_over_time(series_selector[d], ne)` is a [Rollup Function](#rollup-functions) that counts the number of raw samples not equal to `ne` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [count_over_time](#count_over_time).

#### count_over_time

`count_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that counts the number of raw samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> This function is supported by PromQL. Also see [count_le_over_time](#count_le_over_time), [count_gt_over_time](#count_gt_over_time), [count_eq_over_time](#count_eq_over_time), and [count_ne_over_time](#count_ne_over_time).

#### decreases_over_time

`decreases_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that counts the number of times raw sample values decrease over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [increases_over_time](#increases_over_time).

#### default_rollup

`default_rollup(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the last raw sample value over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

#### delta

`delta(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the difference between the last sample and the first sample in the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The behavior of the `delta()` function in MetricsQL slightly differs from that in Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> This function is supported by PromQL. Also see [increase](#increase) and [delta_prometheus](#delta_prometheus).

#### delta_prometheus

`delta_prometheus(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the difference between the first and last samples in the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

The behavior of `delta_prometheus()` is similar to Prometheus's `delta()` function. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

The metric name is stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain the metric name.

> Also see [delta](#delta).

#### deriv

`deriv(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second derivative for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) using linear regression.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [deriv_fast](#deriv_fast) and [ideriv](#ideriv).

#### deriv_fast

`deriv_fast(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second derivative using the first and last raw samples in the given lookback window `d` for each time series.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [deriv](#deriv) and [ideriv](#ideriv).

#### descent_over_time

`descent_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the descent of raw sample values over the given lookback window `d`. Calculations are performed separately for each returned time series.

This function is very useful for tracking height loss in GPS tracking.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [ascent_over_time](#ascent_over_time).

#### distinct_over_time

`distinct_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the number of distinct raw sample values over the given lookback window `d` for each time series.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### duration_over_time

`duration_over_time(series_selector[d], max_interval)` is a [Rollup Function](#rollup-functions) that returns the duration (in seconds) during which each time series exists within the given lookback window `d`. It is expected that the interval between adjacent samples in each series does not exceed `max_interval`. Otherwise, such intervals are treated as gaps and not counted.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [lifetime](#lifetime) and [lag](#lag).

#### first_over_time

`first_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the first raw sample value over the given lookback window `d` for each time series.

> Also see [last_over_time](#last_over_time) and [tfirst_over_time](#tfirst_over_time).

#### geomean_over_time

`geomean_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the geometric mean of raw samples over the given lookback window `d`. Calculations are performed separately for each returned time series.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### histogram_over_time

`histogram_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that computes [VictoriaMetrics histograms](https://godoc.org/github.com/VictoriaMetrics/metrics#Histogram) over the raw samples in the given lookback window `d`. It is computed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Generated histograms are very useful for passing to [histogram_quantile](#histogram_quantile) to compute percentiles of multiple [gauges](https://docs.victoriametrics.com/keyConcepts.html#gauge). For example, the following query calculates the median temperature for each country over the past 24 hours:

`histogram_quantile(0.5, sum(histogram_over_time(temperature[24h])) by (vmrange,country))`.

#### hoeffding_bound_lower

`hoeffding_bound_lower(phi, series_selector[d])` is a [Rollup Function](#rollup-functions) that computes the lower bound of the [Hoeffding bound](https://en.wikipedia.org/wiki/Hoeffding%27s_inequality) for the given `phi` in the range `[0...1]`.

> Also see [hoeffding_bound_upper](#hoeffding_bound_upper).

#### hoeffding_bound_upper

`hoeffding_bound_upper(phi, series_selector[d])` is a [Rollup Function](#rollup-functions) that computes the upper bound of the [Hoeffding bound](https://en.wikipedia.org/wiki/Hoeffding%27s_inequality) for the given `phi` in the range `[0...1]`.

> Also see [hoeffding_bound_lower](#hoeffding_bound_lower).

#### holt_winters

`holt_winters(series_selector[d], sf, tf)` is a [Rollup Function](#rollup-functions) that computes the Holt-Winters value (also known as [double exponential smoothing](https://en.wikipedia.org/wiki/Exponential_smoothing#Double_exponential_smoothing)) for raw samples over the given lookback window `d` using the given smoothing factor `sf` and trend factor `tf`. Both `sf` and `tf` must be in the range `[0...1]`. It is expected that the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) returns time series of [gauge type](https://docs.victoriametrics.com/keyConcepts.html#gauge).

> This function is supported by PromQL. Also see [range_linear_regression](#range_linear_regression).

#### idelta

`idelta(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the difference between the last two raw samples in the given lookback window `d` for each time series.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [delta](#delta).

#### ideriv

`ideriv(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second derivative based on the last two raw samples in the given lookback window `d` for each time series. Calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [deriv](#deriv).

#### increase

`increase(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the increment over the given lookback window `d` for each time series. It is expected that the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) returns time series of [counter type](https://docs.victoriametrics.com/keyConcepts.html#counter).

Unlike Prometheus, it considers the last sample before the given lookback window `d` when computing the result. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [increase_pure](#increase_pure), [increase_prometheus](#increase_prometheus), and [delta](#delta).

#### increase_prometheus

`increase_prometheus(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the increment over the given lookback window `d` for each time series. It is expected that the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) returns time series of [counter type](https://docs.victoriametrics.com/keyConcepts.html#counter). It does not consider the last sample before the given lookback window `d` when computing the result, unlike Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [increase_pure](#increase_pure) and [increase](#increase).

#### increase_pure

`increase_pure(series_selector[d])` is the same as [increase](#increase) except that it assumes [counters](https://docs.victoriametrics.com/keyConcepts.html#counter) always start from 0, whereas [increase](#increase) ignores the first value if it is too large.

#### increases_over_time

`increases_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that counts the number of increases in raw sample values over the given lookback window `d` for each time series.

Metric names are removed from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [decreases_over_time](#decreases_over_time).

#### integrate

`integrate(series_selector[d])` is a [Rollup Function](#rollup-functions) that integrates the raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### irate

`irate(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second instantaneous growth rate based on the last two raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It is expected that `series_selector` returns counter-type time series.

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [rate](#rate) and [rollup_rate](#rollup_rate).

#### lag

`lag(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the duration (in seconds) between the last sample and the current point's timestamp over the given `d` time window. It is calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [lifetime](#lifetime) and [duration_over_time](#duration_over_time).

#### last_over_time

`last_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the last raw sample value over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. Also see [first_over_time](#first_over_time) and [tlast_over_time](#tlast_over_time).

#### lifetime

`lifetime(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the duration (in seconds) between the first and last samples over the given `d` time window, calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [duration_over_time](#duration_over_time) and [lag](#lag).

#### mad_over_time

`mad_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the [median absolute deviation](https://en.wikipedia.org/wiki/Median_absolute_deviation) of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> Also see [mad](#mad) and [range_mad](#range_mad).

#### max_over_time

`max_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the maximum value of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. Also see [tmax_over_time](#tmax_over_time).

#### median_over_time

`median_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the median of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> Also see [avg_over_time](#avg_over_time).

#### min_over_time

`min_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the minimum value of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. Also see [tmin_over_time](#tmin_over_time).

#### mode_over_time

`mode_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the [mode](https://en.wikipedia.org/wiki/Mode_(statistics)) of raw samples over the given `d` time window. It is calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Raw sample values are expected to be discrete.

#### predict_linear

`predict_linear(series_selector[d], t)` is a [Rollup Function](#rollup-functions) that uses linear interpolation to compute the raw sample value over the given `d` time window and predicts the value `t` seconds into the future. Predicted values are calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. Also see [range_linear_regression](#range_linear_regression).

#### present_over_time

`present_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns 1 if at least one raw sample exists over the given `d` time window. Otherwise, it returns an empty result.

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### quantile_over_time

`quantile_over_time(phi, series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the `phi` quantile over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The `phi` value must be in the range `[0...1]`.

> This function is supported by PromQL. Also see [quantiles_over_time](#quantiles_over_time).

#### quantiles_over_time

`quantiles_over_time("phiLabel", phi1, ..., phiN, series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the `phi*` quantiles over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). This function returns separate time series for each `phi*` with `{phiLabel="phi*"}` labels. The `phi*` values must be in the range `[0...1]`.

> Also see [quantile_over_time](#quantile_over_time).

#### range_over_time

`range_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the value range over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). For example, it computes `max_over_time(series_selector[d]) - min_over_time(series_selector[d])`.

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### rate

`rate(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the average per-second growth rate over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It is expected that `series_selector` returns counter-type time series.

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [irate](#irate) and [rollup_rate](#rollup_rate).

#### rate_over_sum

`rate_over_sum(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second rate of the sum of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). These calculations are performed separately for each time series.

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### resets

`resets(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the number of counter resets over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It is expected that `series_selector` returns counter-type time series.

Metric names are removed from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### rollup

`rollup(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the `min`, `max`, and `avg` values of raw samples over the given `d` time window and returns them in the time series with additional labels `rollup="min"`, `rollup="max"`, and `rollup="avg"`. These values are calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

An optional second parameter `"min"`, `"max"`, or `"avg"` can be passed to retain only one calculation result without adding labels.

#### rollup_candlestick

`rollup_candlestick(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates `open`, `high`, `low`, and `close` values (also known as OHLC) over the given lookback window `d` and returns them as additional labels `rollup="open"`, `rollup="high"`, `rollup="low"`, and `rollup="close"` in the time series. These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). This function is very useful for financial applications.

An optional second parameter `"min"`, `"max"`, or `"avg"` can be passed to retain only one calculation result without adding labels.

#### rollup_delta

`rollup_delta(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the differences between adjacent raw samples over the given lookback window `d` and returns the `min`, `max`, and `avg` values of these differences with additional labels `rollup="min"`, `rollup="max"`, and `rollup="avg"` in the time series. These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the generated rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [rollup_increase](#rollup_increase).

#### rollup_deriv

`rollup_deriv(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second derivative of adjacent raw samples over the given lookback window `d` and returns the `min`, `max`, and `avg` values of these derivatives with additional labels `rollup="min"`, `rollup="max"`, and `rollup="avg"` in the time series. These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the generated rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### rollup_increase

`rollup_increase(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the increments between adjacent raw samples over the given lookback window `d` and returns the `min`, `max`, and `avg` values of these increments with additional labels `rollup="min"`, `rollup="max"`, and `rollup="avg"` in the time series. These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are removed from the generated rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names. Also see [rollup_delta](#rollup_delta).

#### rollup_rate

`rollup_rate(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the per-second change rate between adjacent raw samples within the given lookback window and returns the `min`, `max`, and `avg` values of these rates with additional labels `rollup="min"`, `rollup="max"`, and `rollup="avg"` in the time series.

> See [this article](https://valyala.medium.com/why-irate-from-prometheus-doesnt-capture-spikes-45f9896d7832) for better understanding when to use `rollup_rate()`.

An optional second parameter `"min"`, `"max"`, or `"avg"` can be passed to retain only one calculation result without adding labels.

These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### rollup_scrape_interval

`rollup_scrape_interval(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the interval (in seconds) between adjacent raw samples within the given lookback window and returns the `min`, `max`, and `avg` values of these intervals with additional labels `rollup="min"`, `rollup="max"`, and `rollup="avg"` in the time series.

These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

An optional second parameter `"min"`, `"max"`, or `"avg"` can be passed to retain only one calculation result without adding labels.

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names. Also see [scrape_interval](#scrape_interval).

#### scrape_interval

`scrape_interval(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the average interval (in seconds) between raw samples within the given lookback window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [rollup_scrape_interval](#rollup_scrape_interval).

#### share_gt_over_time

`share_gt_over_time(series_selector[d], gt)` is a [Rollup Function](#rollup-functions) that returns the share of raw samples greater than `gt` over the given lookback window (in the range `[0...1]`). These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

This feature is used for calculating SLI and SLO. For example: `share_gt_over_time(up[24h], 0)` - returns the service availability over the past 24 hours.

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [share_le_over_time](#share_le_over_time).

#### share_le_over_time

`share_le_over_time(series_selector[d], le)` is a [Rollup Function](#rollup-functions) that returns the share of raw samples less than or equal to `le` over the given lookback window (in the range `[0...1]`). These calculations are performed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

This feature is used for calculating SLI and SLO. For example: `share_le_over_time(memory_usage_bytes[24h], 100*1024*1024)` returns the share of time series values where memory usage was less than or equal to 100MB over the past 24 hours.

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [share_gt_over_time](#share_gt_over_time).

#### stale_samples_over_time

`stale_samples_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that counts the number of [staleness markers](https://docs.victoriametrics.com/vmagent.html#prometheus-staleness-markers) over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### stddev_over_time

`stddev_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the standard deviation of raw samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [stdvar_over_time](#stdvar_over_time).

#### stdvar_over_time

`stdvar_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the standard variance of raw samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [stddev_over_time](#stddev_over_time).

#### sum_over_time

`sum_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the sum of raw sample values over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### sum2_over_time

`sum2_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that calculates the sum of squared raw sample values over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### timestamp

`timestamp(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the timestamp (in seconds) of the last raw sample over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [timestamp_with_name](#timestamp_with_name).

#### timestamp_with_name

`timestamp_with_name(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the timestamp (in seconds) of the last raw sample over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are retained in the resulting rollups.

> Also see [timestamp](#timestamp).

#### tfirst_over_time

`tfirst_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the timestamp (in seconds) of the first raw sample over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [first_over_time](#first_over_time).

#### tlast_change_over_time

`tlast_change_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the timestamp of the last change over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [last_over_time](#last_over_time).

#### tlast_over_time

`tlast_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) which is an alias for `timestamp`.

> Also see [tlast_change_over_time](#tlast_change_over_time).

#### tmax_over_time

`tmax_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the timestamp (in seconds) of the raw sample with the maximum value over the given lookback window `d`. It is calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [max_over_time](#max_over_time).

#### tmin_over_time

`tmin_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the timestamp (in seconds) of the raw sample with the minimum value over the given lookback window `d`. It is calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [min_over_time](#min_over_time).

#### zscore_over_time

`zscore_over_time(series_selector[d])` is a [Rollup Function](#rollup-functions) that returns the [z-score](https://en.wikipedia.org/wiki/Standard_score) of raw samples over the given lookback window `d`. It is calculated separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the resulting rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> Also see [zscore](#zscore) and [range_trim_zscore](#range_trim_zscore).

### Transformation Functions

**Transformation Functions** compute transformations on [Rollup results](#rollup-functions). For example, `abs(delta(temperature[24h]))` computes the absolute value of each point in the time series returned by the convolution.

Additional details:

- If a transformation function is directly applied to a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering), the [default_rollup()](#default_rollup) function is automatically applied before performing the transformation. For example, `abs(temperature)` would be implicitly converted to `abs(default_rollup(temperature[1i]))`.
- All transformation functions accept an optional [keep_metric_names](#keep_metric_names) modifier. If set, the function does not remove metric names from the resulting time series. See [these documents](#keep_metric_names).

> Also see [Implicit Query Conversions](#implicit-query-conversions).

### Supported Transformation Functions List

#### abs

`abs(q)` is a [transformation function](#transform-functions) that computes the absolute value of each point in each time series returned by `q`.

> This function is supported by PromQL.

#### absent

`absent(q)` is a [transformation function](#transform-functions) that returns 1 if `q` has no points. Otherwise, it returns an empty result.

> This function is supported by PromQL. Also see [absent_over_time](#absent_over_time).

#### acos

`acos(q)` is a [transformation function](#transform-functions) that returns the [inverse cosine](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [asin](#asin) and [cos](#cos).

#### acosh

`acosh(q)` is a [transformation function](#transform-functions) that returns the [inverse hyperbolic cosine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions#Inverse_hyperbolic_cosine) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [sinh](#cosh).

#### asin

`asin(q)` is a [transformation function](#transform-functions) that returns the [inverse sine](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [acos](#acos) and [sin](#sin).

#### asinh

`asinh(q)` is a [transformation function](#transform-functions) that returns the [inverse hyperbolic sine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions#Inverse_hyperbolic_sine) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [sinh](#sinh).

#### atan

`atan(q)` is a [transformation function](#transform-functions) that returns the [inverse tangent](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [tan](#tan).

#### atanh

`atanh(q)` is a [transformation function](#transform-functions) that returns the [inverse hyperbolic tangent](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions#Inverse_hyperbolic_tangent) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [tanh](#tanh).

#### bitmap_and

`bitmap_and(q, mask)` is a [transformation function](#transform-functions) that computes the bitwise AND operation `v & mask` for each `v` point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### bitmap_or

`bitmap_or(q, mask)` is a [transformation function](#transform-functions) that computes the bitwise OR operation `v | mask` for each `v` point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### bitmap_xor

`bitmap_xor(q, mask)` is a [transformation function](#transform-functions) that computes the bitwise XOR operation `v ^ mask` for each `v` point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### buckets_limit

`buckets_limit(limit, buckets)` is a [transformation function](#transform-functions) that limits the number of [histogram buckets](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350) to the given `limit`.

> Also see [prometheus_buckets](#prometheus_buckets) and [histogram_quantile](#histogram_quantile).

#### ceil

`ceil(q)` is a [transformation function](#transform-functions) that rounds each point in each time series returned by `q` up to the nearest integer.

> This function is supported by PromQL. Also see [floor](#floor) and [round](#round).

#### clamp

`clamp(q, min, max)` is a [transformation function](#transform-functions) that clamps each point in each time series returned by `q` using the given `min` and `max` values.

> This function is supported by PromQL. Also see [clamp_min](#clamp_min) and [clamp_max](#clamp_max).

#### clamp_max

`clamp_max(q, max)` is a [transformation function](#transform-functions) that clamps each point in each time series returned by `q` below the given `max` value.

> This function is supported by PromQL. See [clamp](#clamp) and [clamp_min](#clamp_min).

#### clamp_min

`clamp_min(q, min)` is a [transformation function](#transform-functions) that clamps each point in each time series returned by `q` above the given `min` value.

> This function is supported by PromQL. See [clamp](#clamp) and [clamp_max](#clamp_max).

#### cos

`cos(q)` is a [transformation function](#transform-functions) that returns `cos(v)` for each `v` point in each time series returned by `q`.

Metric names are removed from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See [sin](#sin).

#### cosh

`cosh(q)` is a [transformation function](#transform-functions) that returns the [hyperbolic cosine](https://en.wikipedia.org/wiki/Hyperbolic_functions) of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [acosh](#acosh).

#### day_of_month

`day_of_month(q)` is a [transformation function](#transform-functions) that returns the date of the month for each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps. Returned values are in the range `[1...31]`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### day_of_week

`day_of_week(q)` is a [transformation function](#transform-functions) that returns the day of the week for each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps. Returned values are in the range `[0...6]`, where `0` represents Sunday and `6` represents Saturday.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### days_in_month

`days_in_month(q)` is a [transformation function](#transform-functions) that returns the number of days in the month identified by each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps. Returned values are in the range `[28...31]`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### deg

`deg(q)` is a [transformation function](#transform-functions) that converts each point in each time series returned by `q` from radians to degrees.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [rad](#rad).

#### end

`end()` is a [transformation function](#transform-functions) that returns the Unix timestamp (in seconds) of the last point. It is called with the `end` query parameter passed to [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query).

> Also see [start](#start), [time](#time), and [now](#now).

#### exp

`exp(q)` is a [transformation function](#transform-functions) that computes `e^v` for each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. Also see [ln](#ln).

#### floor

`floor(q)` is a [transformation function](#transform-functions) that rounds each point in each time series returned by `q` down to the nearest integer.

> This function is supported by PromQL. Also see [ceil](#ceil) and [round](#round).

#### histogram_avg

`histogram_avg(buckets)` is a [transformation function](#transform-functions) that computes the average of the given `buckets`. It can be used to calculate the average over a given time range across multiple time series. For example, `histogram_avg(sum(histogram_over_time(response_time_duration_seconds[5m])) by (vmrange,job))` will return the average response time for each `job` over the past 5 minutes.

#### histogram_quantile

`histogram_quantile(phi, buckets)` is a [transformation function](#transform-functions) that computes the `phi`-[percentile](https://en.wikipedia.org/wiki/Percentile) on the given [histogram buckets](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350). `phi` must be in the range `[0...1]`. For example, `histogram_quantile(0.5, sum(rate(http_request_duration_seconds_bucket[5m]) by (le))` will return the median request duration for all requests over the past 5 minutes.

This function accepts an optional third parameter - `boundsLabel`. In this case, it returns the `lower` and `upper` bounds of the estimated percentile with the given `boundsLabel` label. For more details, see [this issue](https://github.com/prometheus/prometheus/issues/5706).

When computing [percentiles](https://en.wikipedia.org/wiki/Percentile) across multiple histograms, all input histograms **must** have the same bucket boundaries, e.g., they must have the same `le` or `vmrange` label sets. Otherwise, the returned results may be invalid. For more details, see [this issue](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/3231).

> This function is supported by PromQL (except for the `boundLabel` parameter). Also see [histogram_quantiles](#histogram_quantiles), [histogram_share](#histogram_share), and [quantile](#quantile).

#### histogram_quantiles

`histogram_quantiles("phiLabel", phi1, ..., phiN, buckets)` is a [transformation function](#transform-functions) that computes the `phi*` quantiles on the given [histogram buckets](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350). Parameters `phi*` must be in the range `[0...1]`. For example, `histogram_quantiles('le', 0.3, 0.5, sum(rate(http_request_duration_seconds_bucket[5m]) by (le))`.

Each computed quantile is returned in a separate time series with the corresponding `{phiLabel="phi*"}` label.

> Also see [histogram_quantile](#histogram_quantile).

#### histogram_share

`histogram_share(le, buckets)` is a [transformation function](#transform-functions) that computes the share of samples below `le` in the `buckets` (in the range `[0...1]`). This function is useful for calculating SLI and SLO. It is the opposite of [histogram_quantile](#histogram_quantile).

This function accepts an optional third parameter - `boundsLabel`. In this case, it returns the `lower` and `upper` bounds of the estimated share with the given `boundsLabel` label.

#### histogram_stddev

`histogram_stddev(buckets)` is a [transformation function](#transform-functions) that computes the standard deviation of the given `buckets`.

#### histogram_stdvar

`histogram_stdvar(buckets)` is a [transformation function](#transform-functions) that can be used to compute the standard deviation across multiple time series over a given time range. It computes the standard variance of the given `buckets`. For example, `histogram_stdvar(sum(histogram_over_time(temperature[24])) by (vmrange,country))` will return the standard deviation of temperature for each country over the past 24 hours.

#### hour

`hour(q)` is a [transformation function](#transform-functions) that returns the hour for each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps. Returned values are in the range `[0...23]`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function.

#### interpolate

`interpolate(q)` is a [transformation function](#transform-functions) that fills gaps using linearly interpolated values computed from the previous and next non-empty points in each time series returned by `q`.

> Also see [keep_last_value](#keep_last_value) and [keep_next_value](#keep_next_value).

#### keep_last_value

`keep_last_value(q)` is a [transformation function](#transform-functions) that fills gaps using the value of the last non-empty point in each time series returned by `q`.

> Also see [keep_next_value](#keep_next_value) and [interpolate](#interpolate).

#### keep_next_value

`keep_next_value(q)` is a [transformation function](#transform-functions) that fills gaps using the value of the next non-empty point in each time series returned by `q`.

> Also see [keep_last_value](#keep_last_value) and [interpolate](#interpolate).

#### limit_offset

`limit_offset(limit, offset, q)` is a [transformation function](#transform-functions) that skips `offset` time series returned by `q` and then returns up to `limit` remaining time series for each group.

> This allows simple pagination for `q` time series. Also see [limitk](#limitk).

#### ln

`ln(q)` is a [transformation function](#transform-functions) that computes `ln(v)` for each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function. Also see [exp](#exp) and [log2](#log2).

#### log2

`log2(q)` is a [transformation function](#transform-functions) that computes `log2(v)` for each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function. Also see [log10](#log10) and [ln](#ln).

#### log10

`log10(q)` is a [transformation function](#transform-functions) that computes `log10(v)` for each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function. Also see [log2](#log2) and [ln](#ln).

#### minute

`minute(q)` is a [transformation function](#transform-functions) that returns the minute for each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps. Returned values are in the range `[0...59]`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function.

#### month

`month(q)` is a [transformation function](#transform-functions) that returns the month for each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps. Returned values are in the range `[1...12]`, where `1` represents January and `12` represents December.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function.

#### now

`now()` is a [transformation function](#transform-functions) that returns the current timestamp as a floating-point value in seconds.

> Also see [time](#time).

#### pi

`pi()` is a [transformation function](#transform-functions) that returns the [Pi number](https://en.wikipedia.org/wiki/Pi).

> PromQL supports this function.

#### rad

`rad(q)` is a [transformation function](#transform-functions) that converts degrees to radians for each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function. Also see [deg](#deg).

#### prometheus_buckets

`prometheus_buckets(buckets)` is a [transformation function](#transform-functions) that converts [VictoriaMetrics histogram buckets](https://valyala.medium.com/improving-histogram-usability-for-prometheus-and-grafana-bc7e5df0e350) with `vmrange` labels to Prometheus histogram buckets with `le` labels.

> Also see [histogram_quantile](#histogram_quantile) and [buckets_limit](#buckets_limit).

#### rand

`rand(seed)` is a [transformation function](#transform-functions) that returns pseudo-random numbers in the range `[0...1]` with uniform distribution. An optional `seed` can be used as the seed for the pseudo-random number generator.

> Also see [rand_normal](#rand_normal) and [rand_exponential](#rand_exponential).

#### rand_ex#### rand_exponential

`rand_exponential(seed)` is a [transformation function](#transform-functions) that returns pseudo-random numbers with an [exponential distribution](https://en.wikipedia.org/wiki/Exponential_distribution). An optional `seed` can be used as the seed for the pseudo-random number generator.

> Also see [rand](#rand) and [rand_normal](#rand_normal).

#### rand_normal

`rand_normal(seed)` is a [transformation function](#transform-functions) that returns pseudo-random numbers with a [normal distribution](https://en.wikipedia.org/wiki/Normal_distribution). An optional `seed` can be used as the seed for the pseudo-random number generator.

> Also see [rand](#rand) and [rand_exponential](#rand_exponential).

#### range_avg

`range_avg(q)` is a [transformation function](#transform-functions) that computes the average of points in each time series returned by `q`.

#### range_first

`range_first(q)` is a [transformation function](#transform-functions) that returns the value of the first point in each time series returned by `q`.

#### range_last

`range_last(q)` is a [transformation function](#transform-functions) that returns the value of the last point in each time series returned by `q`.

#### range_linear_regression

`range_linear_regression(q)` is a [transformation function](#transform-functions) that computes the [simple linear regression](https://en.wikipedia.org/wiki/Simple_linear_regression) for each time series returned by `q` over the selected time range. This function is very useful for capacity planning and forecasting.

#### range_mad

`range_mad(q)` is a [transformation function](#transform-functions) that computes the [median absolute deviation](https://en.wikipedia.org/wiki/Median_absolute_deviation) between points in each time series returned by `q`.

> Also see [mad](#mad) and [mad_over_time](#mad_over_time).

#### range_max

`range_max(q)` is a [transformation function](#transform-functions) that computes the maximum value between points in each time series returned by `q`.

#### range_median

`range_median(q)` is a [transformation function](#transform-functions) that computes the median between points in each time series returned by `q`.

#### range_min

`range_min(q)` is a [transformation function](#transform-functions) that computes the minimum value between points in each time series returned by `q`.

#### range_normalize

`range_normalize(q1, ...)` is a [transformation function](#transform-functions) that normalizes the values of time series returned by `q1, …` to the `[0 ... 1]` range. This function is very useful for correlating time series with different value ranges.

> Also see [share](#share).

#### range_quantile

`range_quantile(phi, q)` is a [transformation function](#transform-functions) that returns the `phi` quantile for each time series returned by `q`. `phi` must be in the range `[0 ... 1]`.

#### range_stddev

`range_stddev(q)` is a [transformation function](#transform-functions) that computes the [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) between points in each time series returned by `q` over the selected time range.

#### range_stdvar

`range_stdvar(q)` is a [transformation function](#transform-functions) that computes the [standard variance](https://en.wikipedia.org/wiki/Variance) between points in each time series returned by `q` over the selected time range.

#### range_sum

`range_sum(q)` is a [transformation function](#transform-functions) that computes the sum of points in each time series returned by `q`.

#### range_trim_outliers

`range_trim_outliers(k, q)` is a [transformation function](#transform-functions) that removes points that are more than `k*range_mad(q)` away from the position of `range_median(q)`. For example, it is equivalent to the following query: `q ifnot (abs(q - range_median(q)) > k*range_mad(q))`.

> Also see [range_trim_spikes](#range_trim_spikes) and [range_trim_zscore](#range_trim_zscore).

#### range_trim_spikes

`range_trim_spikes(phi, q)` is a [transformation function](#transform-functions) that removes the largest `phi` percentage of spikes from the time series returned by `q`. `phi` must be in the range `[0..1]`, where `0` indicates `0%` and `1` indicates `100%`.

> Also see [range_trim_outliers](#range_trim_outliers) and [range_trim_zscore](#range_trim_zscore).

#### range_trim_zscore

`range_trim_zscore(z, q)` is a [transformation function](#transform-functions) that removes points that are more than `z*range_stddev(q)` away from the position of `range_avg(q)`. For example, it is equivalent to the following query: `q ifnot (abs(q - range_avg(q)) > z*range_avg(q))`.

> Also see [range_trim_outliers](#range_trim_outliers) and [range_trim_spikes](#range_trim_spikes).

#### range_zscore

`range_zscore(q)` is a [transformation function](#transform-functions) that computes the [z-score](https://en.wikipedia.org/wiki/Standard_score) for points returned by `q`, equivalent to the following query: `(q - range_avg(q)) / range_stddev(q)`.

#### remove_resets

`remove_resets(q)` is a [transformation function](#transform-functions) that removes counter resets from the time series returned by `q`.

#### round

`round(q, nearest)` is a [transformation function](#transform-functions) that rounds each point in each time series returned by `q` to the nearest multiple of `nearest`. If `nearest` is omitted, it rounds to the nearest integer.

> This function is supported by PromQL. Also see [floor](#floor) and [ceil](#ceil).

#### ru

`ru(free, max)` is a [transformation function](#transform-functions) that calculates the resource utilization within the given `free` and `max` resources, in the range `[0％... 100％]`. For example, `ru(node_memory_MemFree_bytes, node_memory_MemTotal_bytes)` returns the memory utilization of the [node_exporter](https://github.com/prometheus/node_exporter) metrics.

#### running_avg

`running_avg(q)` is a [transformation function](#transform-functions) that computes the running average for each time series returned by `q`.

#### running_max

`running_max(q)` is a [transformation function](#transform-functions) that computes the running maximum for each time series returned by `q`.

#### running_min

`running_min(q)` is a [transformation function](#transform-functions) that computes the running minimum for each time series returned by `q`.

#### running_sum

`running_sum(q)` is a [transformation function](#transform-functions) that computes the running sum for each time series returned by `q`.

#### scalar

`scalar(q)` is a [transformation function](#transform-functions) that returns `q` if it contains only a single time series. Otherwise, it does not return anything.

> This function is supported by PromQL.

#### sgn

`sgn(q)` is a [transformation function](#transform-functions) that returns `1` for each point in each time series returned by `q` if `v > 0`, `-1` if `v < 0`, and `0` if `v == 0`.

Metric names are stripped from the generated series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### sin

`sin(q)` is a [transformation function](#transform-functions) that returns `sin(v)` for each `v` point in each time series returned by `q`.

Metric names are stripped from the generated series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by MetricsQL. Also see [cos](#cos).

#### sinh

`sinh(q)` is a [transformation function](#transform-functions) that returns the [hyperbolic sine](https://en.wikipedia.org/wiki/Hyperbolic_functions) for each point in each time series returned by `q`.

Metric names are stripped from the generated series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by MetricsQL. Also see [cosh](#cosh).

#### tan

`tan(q)` is a [transformation function](#transform-functions) that returns `tan(v)` for each `v` point in each time series returned by `q`.

Metric names are stripped from the generated series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by MetricsQL. Also see [atan](#atan).

#### tanh

`tanh(q)` is a [transformation function](#transform-functions) that returns the [hyperbolic tangent](https://en.wikipedia.org/wiki/Hyperbolic_functions) for each point in each time series returned by `q`.

Metric names are stripped from the generated series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by MetricsQL. Also see [atanh](#atanh).

#### smooth_exponential

`smooth_exponential(q, sf)` is a [transformation function](#transform-functions) that smooths the points of each time series returned by `q` using the given smoothing factor `sf`.

#### sort

`sort(q)` is a [transformation function](#transform-functions) that sorts the series in ascending order based on the last point of each time series returned by `q`.

> This function is supported by PromQL. Also see [sort_desc](#sort_desc) and [sort_by_label](#sort_by_label).

#### sort_desc

`sort_desc(q)` is a [transformation function](#transform-functions) that sorts the series in descending order based on the last point of each time series returned by `q`.

> PromQL supports this function. Also see [sort](#sort) and [sort_by_label_desc](#sort_by_label_desc).

#### sqrt

`sqrt(q)` is a [transformation function](#transform-functions) that computes the square root of each point in each time series returned by `q`.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function.

#### start

`start()` is a [transformation function](#transform-functions) that returns the Unix timestamp (in seconds) of the first point.

It is called with the `start` query parameter passed to [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query).

> Also see [end](#end), [time](#time), and [now](#now).

#### step

`step()` is a [transformation function](#transform-functions) that returns the step length (also known as interval) between points (in seconds). It is called with the `step` query parameter passed to [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query).

> Also see [start](#start) and [end](#end).

#### time

`time()` is a [transformation function](#transform-functions) that returns the Unix timestamp for each returned point.

> PromQL supports this function. Also see [now](#now), [start](#start), and [end](#end).

#### timezone_offset

`timezone_offset(tz)` is a [transformation function](#transform-functions) that returns the offset (in seconds) relative to UTC for the given timezone `tz`. This is particularly useful when used in conjunction with date-time-related functions. For example, `day_of_week(time()+timezone_offset("America/Los_Angeles"))` will return the weekday in the `America/Los_Angeles` timezone.

The special `Local` timezone can be used to return the offset for the timezone set on the host running VictoriaMetrics.

> See the [list of supported timezones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

#### ttf

`ttf(free)` is a [transformation function](#transform-functions) that estimates the time (in seconds) required to exhaust the `free` resources. For example, `ttf(node_filesystem_avail_byte)` returns the time until storage space is exhausted. This feature can be useful for capacity planning.

#### union

`union(q1, ..., qN)` is a [transformation function](#transform-functions) that returns the union of time series returned by `q1`, …, `qN`. The `union` function name can be omitted—the following queries are equivalent: `union(q1, q2)` and `(q1, q2)`.

It is expected that each `q*` query returns time series with unique label sets. Otherwise, only the first time series with matching label sets is returned. Use the [alias](#alias) and [label_set](#label_set) functions to provide unique label sets for each `q*` query:

#### vector

`vector(q)` is a [transformation function](#transform-functions) that returns `q`, essentially doing nothing in MetricsQL.

> PromQL supports this function.

#### year

`year(q)` is a [transformation function](#transform-functions) that returns the year for each point in each time series returned by `q`. It is expected that `q` returns Unix timestamps.

Metric names are stripped from the resulting series. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> PromQL supports this function.

### Label Manipulation Functions

**Label Manipulation Functions** perform label operations on selected [Rollup results](#rollup-functions).

More details:

- If a label manipulation function is directly applied to a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering), the [default_rollup()](#default_rollup) function is automatically applied before performing the label transformation. For example, `alias(temperature, "foo")` would be implicitly converted to `alias(default_rollup(temperature[1i]), "foo")`.

> Also see [Implicit Query Conversions](#implicit-query-conversions).

### Supported Label Manipulation Functions List

#### alias

`alias(q, "name")` is a [label manipulation function](#label-manipulation-functions) that sets the given `name` for all time series returned by `q`. For example, `alias(up, "foobar")` renames the `up` series to the `foobar` series.

#### drop_common_labels

`drop_common_labels(q1, ...., qN)` is a [label manipulation function](#label-manipulation-functions) that deletes common `label="value"` pairs from the time series returned by `q1, ..., qN`.

#### label_copy

`label_copy(q, "src_label1", "dst_label1", ..., "src_labelN", "dst_labelN")` is a [label manipulation function](#label-manipulation-functions) that copies the label values of `src_label*` to `dst_label*` in all time series returned by `q`. If `src_label` is empty, the corresponding `dst_label` remains unchanged.

#### label_del

`label_del(q, "label1", ..., "labelN")` is a [label manipulation function](#label-manipulation-functions) that deletes the specified `label*` from all time series returned by `q`.

#### label_join

`label_join(q, "dst_label", "separator", "src_label1", ..., "src_labelN")` is a [label manipulation function](#label-manipulation-functions) that joins `src_label*` values with the given `separator` and stores the result in `dst_label`. This is performed separately for each time series returned by `q`. For example, `label_join(up{instance="xxx",job="yyy"}, "foo", "-", "instance", "job")` stores the label value `xxx-yyy` into the `foo` label.

> This function is supported by PromQL.

#### label_keep

`label_keep(q, "label1", ..., "labelN")` is a [label manipulation function](#label-manipulation-functions) that retains only the listed `label*` labels in all time series returned by `q`.

#### label_lowercase

`label_lowercase(q, "label1", ..., "labelN")` is a [label manipulation function](#label-manipulation-functions) that converts the values of the given `label*` labels to lowercase in all time series returned by `q`.

#### label_map

`label_map(q, "label", "src_value1", "dst_value1", ..., "src_valueN", "dst_valueN")` is a [label manipulation function](#label-manipulation-functions) that maps the `label` values of all time series returned by `q` from `src_*` to `dst*`.

#### label_match

`label_match(q, "label", "regexp")` is a [label manipulation function](#label-manipulation-functions) that removes time series from `q` where the `label` does not match the given `regexp`. This function is useful after [Rollup](#rollup) functions that may return multiple time series per input series.

> Also see [label_mismatch](#label_mismatch).

#### label_mismatch

`label_mismatch(q, "label", "regexp")` is a [label manipulation function](#label-manipulation-functions) that removes time series from `q` where the `label` matches the given `regexp`. This function is useful after [Rollup](#rollup) functions that may return multiple time series per input series.

> Also see [label_match](#label_match).

#### label_move

`label_move(q, "src_label1", "dst_label1", ..., "src_labelN", "dst_labelN")` is a [label manipulation function](#label-manipulation-functions) that moves the label values of `src_label*` to `dst_label*` in all time series returned by `q`. If `src_label` is empty, the corresponding `dst_label` remains unchanged.

#### label_replace

`label_replace(q, "dst_label", "replacement", "src_label", "regex")` is a [label manipulation function](#label-manipulation-functions) that applies the given `regex` to `src_label` and stores `replacement` in `dst_label` when the `regex` matches `src_label`. The `replacement` can contain references to captured groups in the regular expression, such as `$1`, `$2`, etc. These references are replaced with the corresponding captured regular expressions. For example, `label_replace(up{job="node-exporter"}, "foo", "bar-$1", "job", "node-(.+)"` stores the label value `bar-exporter` into the `foo` label.

> This function is supported by PromQL.

#### label_set

`label_set(q, "label1", "value1", ..., "labelN", "valueN")` is a [label manipulation function](#label-manipulation-functions) that sets `{label1="value1", ..., labelN="valueN"}` labels for all time series returned by `q`.

#### label_transform

`label_transform(q, "label", "regexp", "replacement")` is a [label manipulation function](#label-manipulation-functions) that replaces all occurrences of `regexp` in the given `label` with the given `replacement`.

#### label_uppercase

`label_uppercase(q, "label1", ..., "labelN")` is a [label manipulation function](#label-manipulation-functions) that converts the values of the given `label*` labels to uppercase in all time series returned by `q`.

> Also see [label_lowercase](#label_lowercase).

#### label_value

`label_value(q, "label")` is a [label manipulation function](#label-manipulation-functions) that retrieves the numeric value of the given `label` for each time series returned by `q`.

For example, applying `label_value(foo, "bar")` to `foo{bar="1.234"}` returns a time series `foo{bar="1.234"}` with the value `1.234`. For non-numeric label values, the function does not return any data.

#### sort_by_label

`sort_by_label(q, label1, ... labelN)` is a [label manipulation function](#label-manipulation-functions) that sorts the series in ascending order based on the given label set. For example, `sort_by_label(foo, "bar")` sorts the `foo` series based on the value of the `bar` label in these series.

> Also see [sort_by_label_desc](#sort_by_label_desc) and [sort_by_label_numeric](#sort_by_label_numeric).

#### sort_by_label_desc

`sort_by_label_desc(q, label1, ... labelN)` is a [label manipulation function](#label-manipulation-functions) that sorts the series in descending order based on the given label set. For example, `sort_by_label(foo, "bar")` sorts the `foo` series based on the value of the `bar` label in these series.

> PromQL supports this function. Also see [sort_by_label](#sort_by_label) and [sort_by_label_numeric_desc](#sort_by_label_numeric_desc).

#### sort_by_label_numeric

`sort_by_label_numeric(q, label1, ... labelN)` is a [label manipulation function](#label-manipulation-functions) that sorts the series in ascending order based on the given label set using [numeric sort](https://www.gnu.org/software/coreutils/manual/html_node/Version-sort-is-not-the-same-as-numeric-sort.html). For example, if the `foo` series has `bar` labels with values `1`, `101`, `15`, and `2`, then `sort_by_label_numeric(foo, "bar")` will return the series in the order of `bar` label values: `1`, `2`, `15`, and `101`.

> Also see [sort_by_label_numeric_desc](#sort_by_label_numeric_desc) and [sort_by_label](#sort_by_label).

#### sort_by_label_numeric_desc

`sort_by_label_numeric_desc(q, label1, ... labelN)` is a [label manipulation function](#label-manipulation-functions) that sorts the series in descending order based on the given label set using [numeric sort](https://www.gnu.org/software/coreutils/manual/html_node/Version-sort-is-not-the-same-as-numeric-sort.html). For example, if the `foo` series has `bar` labels with values `1`, `101`, `15`, and `2`, then `sort_by_label_numeric(foo, "bar")` will return the series in the order of `bar` label values: `101`, `15`, `2`, and `1`.

> Also see [sort_by_label_numeric](#sort_by_label_numeric) and [sort_by_label_desc](#sort_by_label_desc).

### Aggregate Functions

**Aggregate Functions** compute aggregates for groups of [Rollup results](#rollup-functions).

Additional details:

- By default, aggregation is performed using a single group. Multiple independent groups can be set by specifying grouping labels in the `by` and `without` modifiers. For example, `count(up) by (job)` groups [Rollup results](#rollup-functions) by `job` label values and computes the [count](#count) aggregate function separately for each group, while `count(up) without (instance)` groups [Rollup results](#rollup-functions) by all labels except `instance` before computing the [count](#count) aggregate function. Multiple labels can be placed in the `by` and `without` modifiers.
- If an aggregate function is directly applied to a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering), the [default_rollup()](#default_rollup) function is automatically applied before computing the aggregate. For example, `count(up)` is implicitly converted to `count(default_rollup(up[1i]))`.
- Aggregate functions accept an arbitrary number of parameters. For example, `avg(q1, q2, q3)` returns the average value for each point of `q1`, `q2`, and `q3`.
- Aggregate functions support an optional `limit N` suffix to limit the number of output groups. For example, `sum(x) by (y) limit 3` limits the number of aggregated groups to 3. All other groups are ignored.

> Also see [implicit query conversions](#implicit-query-conversions).

### Supported Aggregate Functions List

#### any

`any(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that returns one series from each `group_labels` for time series returned by `q`.

> Also see [group](#group).

#### avg

`avg(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that returns the average value for each `group_labels` of time series returned by `q`. Aggregation is computed separately for each group with the same timestamp.

> This function is supported by PromQL.

#### bottomk

`bottomk(k, q)` is an [aggregate function](#aggregate-functions) that returns the `k` points with the smallest values from all time series returned by `q`. Aggregation is computed separately for each group with the same timestamp.

> This function is supported by PromQL. Also see [topk](#topk).

#### bottomk_avg

`bottomk_avg(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the smallest average values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `bottomk_avg(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the smallest averages and a time series with the `{job="other"}` label containing the sum of any remainder.

> Also see [topk_avg](#topk_avg).

#### bottomk_last

`bottomk_last(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the smallest last values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `bottomk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the smallest maximum values and a time series with the `{job="other"}` label containing the sum of any remainder.

> Also see [topk_last](#topk_last).

#### bottomk_max

`bottomk_max(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the smallest maximum values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `bottomk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the smallest maximum values and a time series with the `{job="other"}` label containing the sum of any remainder.

> Also see [topk_max](#topk_max).

#### bottomk_median

`bottomk_median(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the smallest median values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `bottomk_median(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the smallest medians and a time series with the `{job="other"}` label containing the sum of any remainder.

> Also see [topk_median](#topk_median).

#### bottomk_min

`bottomk_min(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the smallest minimum values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `bottomk_min(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the smallest minimum values and a time series with the `{job="other"}` label containing the sum of any remainder.

> Also see [topk_min](#topk_min).

#### count

`count(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that returns the number of non-empty points for each `group_labels` of time series returned by `q`. Aggregation is computed separately for each group with the same timestamp.

> This function is supported by PromQL.

#### count_values

`count_values("label", q)` is an [aggregate function](#aggregate-functions) that counts the number of points with the same value and stores the count in a time series with the added `label` for each initial value. Aggregation is computed separately for each group with the same timestamp.

> This function is supported by PromQL.

#### distinct

`distinct(q)` is an [aggregate function](#aggregate-functions) that counts the number of unique values for each group with the same timestamp.

#### geomean

`geomean(q)` is an [aggregate function](#aggregate-functions) that computes the geometric mean for each group with the same timestamp.

#### group

`group(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that returns `1` for each `group_labels` of time series returned by `q`.

> This function is supported by PromQL. Also see [any](#any).

#### histogram

`histogram(q)` is an aggregate function that computes a VictoriaMetrics histogram for each group of points with the same timestamp. It is useful for visualizing large numbers of time series via heatmaps. More details can be found in this article.

> Also see `histogram_over_time` and `histogram_quantile`.

#### limitk

`limitk(k, q) by (group_labels)` is an aggregate function that returns up to `k` time series for each `group_labels` from those returned by `q`. The set of returned time series remains consistent across calls.

> Also see `limit_offset`.

#### mad

`mad(q) by (group_labels)` is an aggregate function that computes the median absolute deviation for all time series returned by `q` in each `group_labels`. Each group of points with the same timestamp is aggregated separately.

> Also see `range_mad`, `mad_over_time`, `outliers_mad`, and `stddev`.

#### max

`max(q) by (group_labels)` is an aggregate function that returns the maximum value for all time series returned by `q` in each `group_labels`. Each group of points with the same timestamp is aggregated separately.

> PromQL supports this function.

#### median

`median(q) by (group_labels)` is an aggregate function that returns the median value for all time series returned by `q` in each `group_labels`. Each group of points with the same timestamp is aggregated separately.

#### min

`min(q) by (group_labels)` is an aggregate function that returns the minimum value for all time series returned by `q` in each `group_labels`. Each group of points with the same timestamp is aggregated separately.

> PromQL supports this function.

#### mode

`mode(q) by (group_labels)` is an aggregate function that returns the mode for all time series returned by `q` in each `group_labels`. Each group of points with the same timestamp is aggregated separately.

#### outliers_mad

`outliers_mad(tolerance, q)` is an aggregate function that returns time series from `q` that have at least one point outside the median absolute deviation (MAD) multiplied by `tolerance`. For example, it returns time series with at least one point below `median(q)-mad(q)` or above `median(q)+mad(q)`.

> Also see `outliersk` and `mad`.

#### outliersk

`outliersk(k, q)` is an aggregate function that returns up to `k` time series from those returned by `q` with the largest standard deviation (i.e., outliers).

> Also see `outliers_mad`.

#### quantile

`quantile(phi, q) by (group_labels)` is an aggregate function that computes the `phi` quantile for all time series returned by `q` in each `group_labels`. `phi` must be in the range `[0...1]`. Each group of points with the same timestamp is aggregated separately.

> PromQL supports this function. Also see `quantiles` and `histogram_quantile`.

#### quantiles

`quantiles("phiLabel", phi1, ..., phiN, q)` is an aggregate function that computes the `phi*` quantiles for all time series returned by `q` and returns them in time series with `{phiLabel="phi*"}` labels. `phi*` must be in the range `[0...1]`. Each group of points with the same timestamp is aggregated separately.

> Also see `quantile`.

#### share

`share(q) by (group_labels)` is an aggregate function that returns the share in the range `[0..1]` for each non-negative point at each timestamp, so that the sum of shares for each `group_labels` is 1.

This function is used to normalize [histogram bucket](https://docs.victoriametrics.com/keyConcepts.html#histogram) shares to the `[0..1]` range:

```
share(
  sum(
    rate(http_request_duration_seconds_bucket[5m])
  ) by (le, vmrange)
)
```

> Also see [range_normalize](#range_normalize).

#### stddev

`stddev(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that computes the standard deviation for all time series returned by `q` in each `group_labels`. Aggregation is computed separately for each group of points with the same timestamp.

> This function is supported by PromQL.

#### stdvar

`stdvar(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that computes the standard variance for all time series returned by `q` in each `group_labels`. Aggregation is computed separately for each group of points with the same timestamp.

> This function is supported by PromQL.

#### sum

`sum(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that returns the sum of all time series returned by `q` in each `group_labels`. Aggregation is computed separately for each group of points with the same timestamp.

> This function is supported by PromQL.

#### sum2

`sum2(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that computes the sum of squares for all time series returned by `q` in each `group_labels`. Aggregation is computed separately for each group of points with the same timestamp.

#### topk

`topk(k, q)` is an [aggregate function](#aggregate-functions) that returns the `k` points with the largest values from all time series returned by `q`. Aggregation is computed separately for each group of points with the same timestamp.

> This function is supported by PromQL. Also see [bottomk](#bottomk).

#### topk_avg

`topk_avg(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the largest average values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `topk_avg(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the largest averages and a time series with the `{job="other"}` label containing the sum of any remainder (if present).

> Also see [bottomk_avg](#bottomk_avg).

#### topk_last

`topk_last(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the largest last values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `topk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the largest maximum values and a time series with the `{job="other"}` label containing the sum of any remainder (if present).

> Also see [bottomk_last](#bottomk_last).

#### topk_max

`topk_max(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the largest maximum values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `topk_max(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the largest maximum values and a time series with the `{job="other"}` label containing the sum of any remainder (if present).

> Also see [bottomk_max](#bottomk_max).

#### topk_median

`topk_median(k#### topk_median

`topk_median(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the largest median values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `topk_median(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the largest medians and a time series with the `{job="other"}` label containing the sum of any remainder (if present).

> Also see [bottomk_median](#bottomk_median).

#### topk_min

`topk_min(k, q, "other_label=other_value")` is an [aggregate function](#aggregate-functions) that returns the `k` time series with the largest minimum values from `q`. If the optional `other_label=other_value` parameter is set, it returns the sum of the remaining time series with the given label. For example, `topk_min(3, sum(process_resident_memory_bytes) by (job), "job=other")` returns the 3 time series with the largest minimum values and a time series with the `{job="other"}` label containing the sum of any remainder (if present).

> Also see [bottomk_min](#bottomk_min).

#### zscore

`zscore(q) by (group_labels)` is an [aggregate function](#aggregate-functions) that returns the [z-score](https://en.wikipedia.org/wiki/Standard_score) values for all time series returned by `q` in each `group_labels`. Aggregation is computed separately for each group of points with the same timestamp. This function is used to detect outliers within related groups of time series.

> Also see [zscore_over_time](#zscore_over_time) and [range_trim_zscore](#range_trim_zscore).

## Subqueries

MetricsQL supports and extends PromQL subqueries. For more details, see [this article](https://valyala.medium.com/prometheus-subqueries-in-victoriametrics-9b1492b720b3). Any [Rollup Function](#rollup-functions) that is not in the form of a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) forms a subquery. Multi-layer Rollup Functions can be implicitly converted into [implicit query conversions](#implicit-query-conversions). For example, `delta(sum(m))` is implicitly converted to `delta(sum(default_rollup(m[1i]))[1i:1i])`, thus becoming a subquery as it contains nested [default_rollup](#default_rollup) and [delta](#delta).

MetricsQL executes subqueries as follows:

- It calculates the internal Rollup Function using the `step` value of the external Rollup Function. For example, for the expression `max_over_time(rate(http_requests_total[5m])[1h:30s])`, the internal function `rate(http_requests_total[5m])` is calculated using `step=30s`. The resulting data points are aligned by `step`.
- It calculates the external Rollup Function on the results of the internal Rollup Function using the `step` value passed by the frontend.

## Implicit Query Conversions

Before starting calculations, MetricsQL performs the following implicit conversions on incoming queries:

- If the lookback window in square brackets is missing inside a [Rollup Function](#rollup-functions), `[1i]` is automatically added. `[1i]` represents a `step` value that is passed to [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query). In Grafana, it is also known as `$__interval`. For example, `rate(http_requests_count)` is automatically converted to `rate(http_requests_count[1i])`.

- All [series selectors](https://docs.victoriametrics.com/keyConcepts.html#filtering) that are not wrapped in Rollup Functions are automatically wrapped in the `default_rollup` function. For example:
    - `foo` is converted to `default_rollup(foo[1i])`
    - `foo + bar` is converted to `default_rollup(foo[1i]) + default_rollup(bar[1i])`
    - `count(up)` is converted to `count(default_rollup(up[1i]))` because [count](#count) is not a [Rollup Function](#rollup-functions) but an [aggregate function](#aggregate-functions)
    - `abs(temperature)` is converted to `abs(default_rollup(temperature[1i]))` because [abs](#abs) is not a [Rollup Function](#rollup-functions) but a [transformation function](#transform-functions)

- If the `step` is missing in square brackets in a [subquery](#subqueries), `1i` step is automatically added. For example, `avg_over_time(rate(http_requests_total[5m])[1h])` is automatically converted to `avg_over_time(rate(http_requests_total[5m])[1h:1i])`.

- If what is passed to a [Rollup Function](#rollup-functions) is not a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering), it automatically forms a [subquery](#subqueries) with a `1i` lookback window and `1i` step. For example, `rate(sum(up))` is automatically converted to `rate((sum(default_rollup(up[1i])))[1i:1i])`.

---

This concludes the translation of the provided Markdown content into English while preserving the original format and structure. If you need further assistance or have additional sections to translate, feel free to let me know!