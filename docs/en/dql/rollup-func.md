# Rollup Functions

---

<<< custom_key.brand_name >>> provides comprehensive data aggregation capabilities and can improve the efficiency of data grouping returns through Rollup functions. This involves slicing data into specified time intervals and performing calculations on the data within each interval. The currently supported functions are listed below:

| Rollup Function | Description | Example |
| --- | --- | --- |
| `avg` | Slices data into specified time intervals and calculates the average value for each interval | `M:cpu:load5s [::1m:avg]` |
| `sum` | Slices data into specified time intervals and sums the data within each interval | `M:cpu:load5s [::1m:sum]` |
| `min` | Slices data into specified time intervals and calculates the minimum value for each interval | `M:cpu:load5s [::1m:min]` |
| `max` | Slices data into specified time intervals and calculates the maximum value for each interval | `M:cpu:load5s [::1m:max]` |
| `count` | Slices data into specified time intervals and counts the number of data points within each interval | `M:cpu:load5s [::1m:count]` |
| `first` | Slices data into specified time intervals and retrieves the first value within each interval | `M:cpu:load5s [::1m:first]` |
| `last` | Slices data into specified time intervals and retrieves the last value within each interval | `M:cpu:load5s [::1m:last]` |
| `rate` | Slices data into specified time intervals and calculates the rate of change, suitable for calculating instantaneous rates within short time windows | `M:cpu:load5s [::1m:rate]` |
| `irate` | Slices data into specified time intervals and calculates the rate of change, suitable for calculating average rates over longer periods | `M:cpu:load5s [::1m:irate]` |
| `median` | Slices data into specified time intervals and calculates the median value for each interval | `M:cpu:load5s [::1m:median]` |
| `stddev` | Slices data into specified time intervals and calculates the standard deviation for each interval | `M:cpu:load5s [::1m:stddev]` |
| `deriv` | Slices data into specified time intervals and calculates the per-second derivative between adjacent elements within each interval | `M:cpu:load5s [::1m:deriv]` |
| `p99` | Slices data into specified time intervals and returns the 99th percentile value for each interval | `M:cpu:load5s [::1m:p99]` |
| `p90` | Slices data into specified time intervals and returns the 90th percentile value for each interval | `M:cpu:load5s [::1m:p90]` |
| `p95` | Slices data into specified time intervals and returns the 95th percentile value for each interval | `M:cpu:load5s [::1m:p95]` |
| `p75` | Slices data into specified time intervals and returns the 75th percentile value for each interval | `M:cpu:load5s [::1m:p75]` |
| `p50` | Slices data into specified time intervals and returns the 50th percentile value for each interval | `M:cpu:load5s [::1m:p50]` |