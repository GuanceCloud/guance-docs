# MetricsQL Syntax Reference

Currently, in the Guance dashboard, you can use the MetricsQL language to query Prometheus metrics.

MetricsQL is an enhanced PromQL syntax developed by VictoriaMetrics. In most cases, MetricsQL is compatible with PromQL queries but also improves and optimizes some less intuitive and inconvenient aspects of PromQL. [This article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e) provides more details on the compatibility design.

In most cases, you can perform queries according to your understanding of PromQL syntax without issues. When you encounter tricky problems, such as calculating p95 for gauge data or ensuring that topk returns the exact number of series, you can find answers through the following syntax reference.

Comparing MetricsQL and PromQL syntax, their main differences are:

- MetricsQL considers the previous point in the lookback window for range functions like [rate](#rate) and [increase](#increase). This allows it to return accurate results for `increase(metric[$__interval])` queries, instead of the incomplete results returned by Prometheus for such queries.
- MetricsQL does not extrapolate the results of range functions, which solves this issue in PromQL. For technical details on how PromQL and MetricsQL calculate [rate](#rate) and [increase](#increase), see [this comment](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/1215#issuecomment-850305711).
- For [rate](#rate) with a `step` value less than the collection interval, MetricsQL returns expected non-empty responses. This resolves the issue shown in [this problem](https://github.com/grafana/grafana/issues/11451). Also, see [this blog post](https://www.percona.com/blog/2020/02/28/better-prometheus-rate-function-with-victoriametrics/).
- MetricsQL treats `scalar` types and label-less `instant vector` as identical because the subtle differences between these two types often confuse users. For more information, see the [corresponding Prometheus documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/#expression-language-data-types).
- MetricsQL removes all `NaN` values from the output, so certain queries (like `(-1)^0.5`) return empty results in MetricsQL, while PromQL returns a series of `NaN` values. Note that the frontend does not plot any lines or points for `NaN` values, so the final result is the same for both MetricsQL and PromQL.
- After applying functions, MetricsQL retains metric names if the function does not change the original time series' meaning. For example, [min_over_time(foo)](#min_over_time) or [round(foo)](#round) retain the `foo` metric name in the results. For more details, see [this issue](https://github.com/VictoriaMetrics/VictoriaMetrics/issues/674).

At the same time, when using MetricsQL in Guance, note the following differences from the original MetricsQL:

- Support for measurement selection: You need to prefix the metric name with the measurement separated by a colon, e.g., `increase(measurement:metric[1m])`. Omitting the measurement significantly degrades query performance.
- The Guance UI does not support manual configuration of `step`; the current `step` is automatically calculated based on the time range and display density.
- The Guance UI does not support Heatmap-type graph displays, which may affect Histogram display effects.

<font color=coral>The content of this article is mainly translated from <u>https://docs.victoriametrics.com/MetricsQL.html</u>. If there are ambiguities in the Chinese translation, you can also refer to the original text.</font>

## Feature List

MetricsQL includes the following features:

- Square brackets containing lookback windows can be ignored. MetricsQL automatically selects the backward-looking window based on the `step` used to build the graph. The following query is valid in MetricsQL: `rate(node_network_receive_bytes_total)`. When used in Grafana, it is equivalent to `rate(node_network_receive_bytes_total[$__interval])`.
- [Aggregation functions](#aggregate-functions) can accept an arbitrary number of parameters. For example, `avg(q1, q2, q3)` returns the average value for each point of `q1`, `q2`, and `q3`.
- [@Modifiers](https://prometheus.io/docs/prometheus/latest/querying/basics/#modifier) can be placed anywhere in the query. For example, `sum(foo) @ end()` calculates the value of `sum(foo)` at the `end` timestamp within the selected time range `[start ... end]`.
- Any sub-expression can be used as an [@Modifier](https://prometheus.io/docs/prometheus/latest/querying/basics/#modifier). For example, `foo @ (end() - 1h)` calculates `foo` at the `end - 1h` timestamp within the selected time range `[start ... end]`.
- [Offset](https://prometheus.io/docs/prometheus/latest/querying/basics/#offset-modifier), square brackets containing lookback windows, and `step` values in [subqueries](#subqueries) can use `[Ni]` syntax to reference the current step, known as `$__interval` in Grafana. For example, `rate(metric[10i] offset 5i)` returns the per-second rate covering the last 10 steps with a 5-step offset.
- [Offset](https://prometheus.io/docs/prometheus/latest/querying/basics/#offset-modifier) can be placed anywhere in the query. For example, `sum(foo) offset 24h`.
- Lookback windows in square brackets and [offset](https://prometheus.io/docs/prometheus/latest/querying/basics/#offset-modifier) can be fractional. For example, `rate(node_network_receive_bytes_total[1.5m] offset 0.5d)`.
- Duration suffixes are optional. If omitted, the duration is in seconds. For example, `rate(m[300] offset 1800)` is equivalent to `rate(m[5m]) offset 30m`.
- Durations can be placed anywhere in the query. For example, `sum_over_time(m[1h]) / 1h` is equivalent to `sum_over_time(m[1h]) / 3600`.
- Numerical values can have `K`, `Ki`, `M`, `Mi`, `G`, `Gi`, `T`, and `Ti` suffixes. For example, `8K` equals `8000`, and `1.2Mi` equals `1.2*1024*1024`.
- Trailing commas are allowed in lists, including label filters, function parameters, and expressions. For example, the following queries are valid: `m{foo="bar",}`, `f(a, b,)`, `WITH (x=y,) x`.
- Metric names and label names can contain any Unicode letters. For example, `температура{город="Киев"}` is a MetricsQL expression.
- Metric names and label names can contain escape characters. For example, `foo\\\\-bar{baz\\\\=aa="b"}` is a valid expression. It returns a time series named `foo-bar` with a label `baz=aa` having the value `b`. Additionally, the following escape sequences are supported:
    - `\\\\xXX`, where `XX` is the hexadecimal representation of the escaped ASCII character.
    - `\\\\uXXXX`, where `XXXX` is the hexadecimal representation of the escaped Unicode character.
- Aggregation functions support an optional `limit N` suffix to limit the number of output series. For example, `sum(x) by (y) limit 3` limits the number of aggregated output time series to 3. All other time series are discarded.
- [histogram_quantile](#histogram_quantile) accepts an optional third parameter `boundsLabel`. In this case, it returns the `lower` and `upper` boundaries of the estimated percentile. For more details, see [this issue](https://github.com/prometheus/prometheus/issues/5706).
- `default` binary operator. `q1 default q2` fills gaps in `q1` with corresponding values from `q2`.
- `if` binary operator. `q1 if q2` removes values from `q1` where `q2` has missing values.
- `ifnot` binary operator. `q1 ifnot q2` removes values from `q1` where `q2` has existing values.
- `WITH` templates. This feature simplifies writing and managing complex queries. You can try it out on the [WITH templates playground](https://play.victoriametrics.com/select/accounting/1/6a716b0f-38bc-4856-90ce-448fd713e3fe/expand-with-exprs).
- String literals can be concatenated. This is useful in `WITH` templates: `WITH (commonPrefix="long_metric_prefix_") {__name__=commonPrefix+"suffix1"} / {__name__=commonPrefix+"suffix2"}`.
- The `keep_metric_names` modifier can be applied to all [Rollup functions](#rollup-functions) and [Transformation functions](#transform-functions). This modifier prevents the deletion of metric names in function results. See [these documents](#keep_metric_names).

## keep_metric_names

By default, after applying functions that change the original time series' meaning, metric names are removed. When applying functions to multiple time series with different names, this can cause a "duplicate time series" error. This error can be resolved by applying the `keep_metric_names` modifier to the function.

For example, `rate({__name__=~"foo|bar"}) keep_metric_names` retains the metric names `foo` and `bar` in the returned time series.

## MetricsQL Functions

MetricsQL provides the following functions:

- [Rollup functions](#rollup-functions)
- [Transformation functions](#transform-functions)
- [Label manipulation functions](#label-manipulation-functions)
- [Aggregation functions](#aggregate-functions)

### Rollup Functions

**Rollup functions** (also known as range functions or window functions) perform rolling calculations on **raw samples** over a specified lookback window, applicable to [series selectors](https://docs.victoriametrics.com/keyConcepts.html#filtering). For example, `avg_over_time(temperature[24h])` calculates the average temperature of raw samples over the past 24 hours.

Additional details:

- If building graphs with Rollup functions, each point on the graph independently computes the Rollup. For example, each point on the `avg_over_time(temperature[24h])` graph shows the average temperature over the last 24 hours. The interval between points is set by the `step` query parameter passed by the frontend.
- If the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) returns multiple time series, rolling calculations are computed separately for each returned series.
- If the lookback window in square brackets is missing, MetricsQL automatically sets the lookback window to the interval between points on the graph (`step` query parameter in [/api/v1/query_range](https://docs.victoriametrics.com/keyConcepts.html#range-query), `$__interval` in Grafana, or `1i` duration in MetricsQL). For example, `rate(http_requests_total)` is equivalent to `rate(http_requests_total[$__interval])` in MetricsQL. It is also equivalent to `rate(http_requests_total[1i])`.
- Each [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) in MetricsQL must be wrapped in a Rollup function. Otherwise, it is automatically converted to [default_rollup](#default_rollup) before computation. For example, `foo{bar="baz"}` is automatically converted to `default_rollup(foo{bar="baz"}[1i])` before computation.
- If something other than a [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) is passed to a Rollup function, the internal parameter is automatically converted to a [subquery](#subqueries).
- All Rollup functions accept an optional `keep_metric_names` modifier. If this modifier is set, the function retains metric names in the results. See [these documents](#keep_metric_names).

> See [Implicit Query Conversions](#implicit-query-conversions).

### Supported Rollup Function List

#### absent_over_time

`absent_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that returns 1 if no raw sample exists in the given lookback window `d`. Otherwise, it returns an empty result.

> This function is supported by PromQL. See also [present_over_time](#present_over_time).

#### aggr_over_time

`aggr_over_time(("rollup_func1","rollup_func2",...), series_selector[d])` is a [Rollup function](#rollup-functions) that computes all listed `rollup_func*` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). `rollup_func*` can include any Rollup function. For example, `aggr_over_time(("min_over_time","max_over_time","rate"), m[d])` computes [min_over_time](#min_over_time), [max_over_time](#max_over_time), and [rate](#rate) for `m[d]`.

#### ascent_over_time

`ascent_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the ascent of raw sample values over the given lookback window `d`. Calculations are performed separately for each returned time series.

This function is useful for tracking height gain in GPS tracking. Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [descent_over_time](#descent_over_time).

#### avg_over_time

`avg_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the average of raw sample values over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. See also [median_over_time](#median_over_time).

#### changes

`changes(series_selector[d])` is a [Rollup function](#rollup-functions) that counts the number of changes in raw samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Unlike `changes()` in Prometheus, it considers changes from the last sample before the given lookback window `d`. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [changes_prometheus](#changes_prometheus).

#### changes_prometheus

`changes_prometheus(series_selector[d])` is a [Rollup function](#rollup-functions) that counts the number of changes in raw samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It does not consider changes from the last sample before the given lookback window `d`, unlike Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [changes](#changes).

#### count_eq_over_time

`count_eq_over_time(series_selector[d], eq)` is a [Rollup function](#rollup-functions) that counts the number of raw samples equal to `eq` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [count_over_time](#count_over_time).

#### count_gt_over_time

`count_gt_over_time(series_selector[d], gt)` is a [Rollup function](#rollup-functions) that counts the number of raw samples greater than `gt` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [count_over_time](#count_over_time).

#### count_le_over_time

`count_le_over_time(series_selector[d], le)` is a [Rollup function](#rollup-functions) that counts the number of raw samples less than or equal to `le` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [count_over_time](#count_over_time).

#### count_ne_over_time

`count_ne_over_time(series_selector[d], ne)` is a [Rollup function](#rollup-functions) that counts the number of raw samples not equal to `ne` over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [count_over_time](#count_over_time).

#### count_over_time

`count_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that counts the number of raw samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [count_le_over_time](#count_le_over_time), [count_gt_over_time](#count_gt_over_time), [count_eq_over_time](#count_eq_over_time), and [count_ne_over_time](#count_ne_over_time).

#### decreases_over_time

`decreases_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that counts the number of decreases in raw sample values over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [increases_over_time](#increases_over_time).

#### default_rollup

`default_rollup(series_selector[d])` is a [Rollup function](#rollup-functions) that returns the last raw sample value over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

#### delta

`delta(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the difference between the last sample and the first sample over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The behavior of the `delta()` function in MetricsQL slightly differs from that in Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [increase](#increase) and [delta_prometheus](#delta_prometheus).

#### delta_prometheus

`delta_prometheus(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the difference between the first and last samples over the given lookback window `d` for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

The behavior of `delta_prometheus()` closely resembles the `delta()` function in Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are stripped from the cumulative value in the result. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [delta](#delta).

#### deriv

`deriv(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the per-second derivative of each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) using linear regression.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [deriv_fast](#deriv_fast) and [ideriv](#ideriv).

#### deriv_fast

`deriv_fast(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the per-second derivative using the first and last raw samples in the given lookback window `d` for each time series.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [deriv](#deriv) and [ideriv](#ideriv).

#### descent_over_time

`descent_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the descent of raw sample values over the given lookback window `d`. Calculations are performed separately for each returned time series.

This function is useful for tracking height loss in GPS tracking.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [ascent_over_time](#ascent_over_time).

#### distinct_over_time

`distinct_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that returns the number of distinct raw sample values over the given lookback window `d` for each time series.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### duration_over_time

`duration_over_time(series_selector[d], max_interval)` is a [Rollup function](#rollup-functions) that returns the duration (in seconds) of the existence of each time series over the lookback window `d`. It assumes that intervals between adjacent samples in each series do not exceed `max_interval`. Otherwise, such intervals are considered gaps and are not counted.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [lifetime](#lifetime) and [lag](#lag).

#### first_over_time

`first_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that returns the first raw sample value over the given lookback window `d` for each time series.

> See also [last_over_time](#last_over_time) and [tfirst_over_time](#tfirst_over_time).

#### geomean_over_time

`geomean_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the geometric mean of raw samples over the given lookback window `d`. Calculations are performed separately for each returned time series.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### histogram_over_time

`histogram_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that computes a [VictoriaMetrics histogram](https://godoc.org/github.com/VictoriaMetrics/metrics#Histogram) over the raw samples in the given lookback window `d`. It is computed separately for each time series returned by the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). Generated histograms are very useful for passing to [histogram_quantile](#histogram_quantile) to compute percentiles for multiple [gauges](https://docs.victoriametrics.com/keyConcepts.html#gauge). For example, the following query calculates the median temperature for each country over the past 24 hours:

`histogram_quantile(0.5, sum(histogram_over_time(temperature[24h])) by (vmrange,country))`.

#### hoeffding_bound_lower

`hoeffding_bound_lower(phi, series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the lower bound of the [Hoeffding bound](https://en.wikipedia.org/wiki/Hoeffding's_inequality) for the given `phi` in the range `[0...1]`.

> See also [hoeffding_bound_upper](#hoeffding_bound_upper).

#### hoeffding_bound_upper

`hoeffding_bound_upper(phi, series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the upper bound of the [Hoeffding bound](https://en.wikipedia.org/wiki/Hoeffding's_inequality) for the given `phi` in the range `[0...1]`.

> See also [hoeffding_bound_lower](#hoeffding_bound_lower).

#### holt_winters

`holt_winters(series_selector[d], sf, tf)` is a [Rollup function](#rollup-functions) that calculates the Holt-Winters value (also known as [double exponential smoothing](https://en.wikipedia.org/wiki/Exponential_smoothing#Double_exponential_smoothing)) of raw samples over the given lookback window `d` using the given smoothing factor `sf` and trend factor `tf`. Both `sf` and `tf` must be in the range `[0...1]`. It expects the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) to return time series of [gauge type](https://docs.victoriametrics.com/keyConcepts.html#gauge).

> This function is supported by PromQL. See also [range_linear_regression](#range_linear_regression).

#### idelta

`idelta(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the difference between the last two raw samples over the given lookback window `d` for each time series.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [delta](#delta).

#### ideriv

`ideriv(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the per-second derivative based on the last two raw samples over the given lookback window `d` for each time series. Calculations are performed separately for each time series returned by the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [deriv](#deriv).

#### increase

`increase(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the increment over the given lookback window `d` for each time series. It expects the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) to return time series of [counter type](https://docs.victoriametrics.com/keyConcepts.html#counter).

Unlike Prometheus, it considers the last sample before the given lookback window `d` when computing the result. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [increase_pure](#increase_pure), [increase_prometheus](#increase_prometheus), and [delta](#delta).

#### increase_prometheus

`increase_prometheus(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the increment over the given lookback window `d` for each time series. It expects the [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering) to return time series of [counter type](https://docs.victoriametrics.com/keyConcepts.html#counter). When computing the result, it does not consider the last sample before the given lookback window `d`, unlike Prometheus. For more details, see [this article](https://medium.com/@romanhavronenko/victoriametrics-promql-compliance-d4318203f51e).

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [increase_pure](#increase_pure) and [increase](#increase).

#### increase_pure

`increase_pure(series_selector[d])` behaves similarly to [increase](#increase), except it assumes [counters](https://docs.victoriametrics.com/keyConcepts.html#counter) always start from 0, whereas [increase](#increase) ignores the first value if it is too large.

#### increases_over_time

`increases_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that counts the number of increases in raw sample values over the given lookback window `d` for each time series.

Metric names are stripped from the results. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [decreases_over_time](#decreases_over_time).

#### integrate

`integrate(series_selector[d])` is a [Rollup function](#rollup-functions) that integrates the raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

#### irate

`irate(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the instantaneous per-second growth rate based on the last two raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It expects `series_selector` to return counter-type time series.

Metric names are stripped from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL. See also [rate](#rate) and [rollup_rate](#rollup_rate).

#### lag

`lag(series_selector[d])` is a [Rollup function](#rollup-functions) that returns the duration (in seconds) between the last sample and the current point's timestamp over the given `d` time window. It is computed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [lifetime](#lifetime) and [duration_over_time](#duration_over_time).

#### last_over_time

`last_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that returns the last raw sample value over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. See also [first_over_time](#first_over_time) and [tlast_over_time](#tlast_over_time).

#### lifetime

`lifetime(series_selector[d])` is a [Rollup function](#rollup-functions) that returns the duration (in seconds) between the first and last samples over the given `d` time window, computed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

Metric names are stripped from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> See also [duration_over_time](#duration_over_time) and [lag](#lag).

#### mad_over_time

`mad_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the [median absolute deviation](https://en.wikipedia.org/wiki/Median_absolute_deviation) of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> See also [mad](#mad) and [range_mad](#range_mad).

#### max_over_time

`max_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the maximum value of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. See also [tmax_over_time](#tmax_over_time).

#### median_over_time

`median_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the median of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> See also [avg_over_time](#avg_over_time).

#### min_over_time

`min_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the minimum value of raw samples over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. See also [tmin_over_time](#tmin_over_time).

#### mode_over_time

`mode_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the [mode](https://en.wikipedia.org/wiki/Mode_(statistics)) of raw samples over the given `d` time window. It is computed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). It is expected that raw sample values are discrete.

#### predict_linear

`predict_linear(series_selector[d], t)` is a [Rollup function](#rollup-functions) that uses linear interpolation to calculate the value of raw samples over the given `d` time window, predicting the value `t` seconds into the future. Predictions are computed separately for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering).

> This function is supported by PromQL. See also [range_linear_regression](#range_linear_regression).

#### present_over_time

`present_over_time(series_selector[d])` is a [Rollup function](#rollup-functions) that returns 1 if at least one raw sample exists over the given `d` time window. Otherwise, it returns an empty result.

Metric names are stripped from the rollups. Add the [keep_metric_names](#keep_metric_names) modifier to retain metric names.

> This function is supported by PromQL.

#### quantile_over_time

`quantile_over_time(phi, series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the `phi` quantile over the given `d` time window for each time series returned by the given [series selector](https://docs.victoriametrics.com/keyConcepts.html#filtering). The `phi` value must be in the range `[0...1]`.

> This function is supported by PromQL. See also [quantiles_over_time](#quantiles_over_time).

#### quantiles_over_time

`quantiles_over_time("phiLabel", phi1, ..., phiN, series_selector[d])` is a [Rollup function](#rollup-functions) that calculates the `phi*` quantiles over the given `d` time window for each time series returned by the given [series selector](https://docs.victor