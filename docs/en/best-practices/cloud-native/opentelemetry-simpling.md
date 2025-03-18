# OpenTelemetry Sampling Best Practices

---

Full-chain data can indeed help relevant personnel to promptly and accurately identify business issues. However, the probability of business problems occurring in enterprises is generally low, and full-chain sampling has its own advantages and disadvantages.

### Advantages

- Comprehensive link data

### Disadvantages

- Resource waste. Due to comprehensive data leading to increased data storage resource costs, the cost of searching for abnormal link data also increases.

Based on full-chain data collection, OpenTelemetry supports two types of samplers:

> 1. Probabilistic sampler (probabilisticsamplerprocessor)
>
> 2. Tail-based sampler (tailsamplingprocessor)

## [Probabilistic Sampler Processor](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/probabilisticsamplerprocessor)

As the name suggests, the probabilistic sampler samples based on a certain probability. Similarly, OpenTelemetry supports two types of probabilistic sampling:

> 1. `sampling.priority` defined by OpenTracing semantic conventions
>
> 2. TraceId hash

The `sampling.priority` semantic convention takes precedence over TraceId hash. As the name implies, TraceId hash sampling is based on the hash value determined by the TraceId. To make TraceId hash work, all collectors in a given layer (e.g., behind the same load balancer) must have the same `hash_seed`. You can also leverage different `hash_seed` values across different collector layers to support additional sampling requirements. For configuration specifications, see [config.go](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/probabilisticsamplerprocessor/config.go).

You can modify the following configuration options:

- `hash_seed` (no default value): An integer used to compute the hash algorithm. Note that all collectors in a given layer (e.g., behind the same load balancer) should have the same hash_seed.
  
  This is important when using multi-layer collectors to achieve the desired sampling rate, for example: 10% at the first layer, 10% at the second layer, resulting in an overall sampling rate of 1% (10% x 10%).

  If all layers use the same seed, all data passing through one layer will also pass through the next layer regardless of the configured sampling rate. Different seeds in different layers ensure that the sampling rate works as expected in each layer.

- `sampling_percentage` (default = 0): The percentage of traces to sample; >= 100 indicates sampling all traces.

Configuration of the probabilistic sampler:

```yaml
processors:
  # Probabilistic sampler
  probabilistic_sampler:
    hash_seed: 22
    sampling_percentage: 15.3
```

Enabling the probabilistic sampler:

```yaml
service:
  extensions: [pprof, zpages, health_check]
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch, probabilistic_sampler]
      exporters: [otlp]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]
```

## [Tail-Based Sampler](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/processor/tailsamplingprocessor)

The tail-based sampler processor samples traces based on a set of defined policies. Currently, this processor only applies to a single instance of the collector. Technically, traceId-aware load balancing can be used to support multiple collector instances, but this configuration has not been tested. For configuration specifications, see [config.go](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/tailsamplingprocessor/config.go).

The following configuration options are required:

- `policies` (no default value): Policies used to make sampling decisions

Currently, multiple policies are supported. These include:

> - `always_sample`: Sample all traces
> - `latency`: Sample based on trace duration. Duration is determined by looking at the earliest start time and latest end time, ignoring what happens between them.
> - `numeric_attribute`: Sample based on numeric attributes
> - `probabilistic`: Sample a certain percentage of traces.
> - `status_code`: Sample based on status code (`OK`, `ERROR`, or `UNSET`). Many people mistakenly treat this as the response body JSON code (which many projects define this way), but it is incorrect.
> - `string_attribute`: Sample based on string attribute value matches, supporting exact matches and regular expression value matches
> - `rate_limiting`: Sample based on rate limiting
> - `and`: Sample based on multiple policies, creating an AND policy
> - `composite`: Sample based on combinations of the above samplers, with each sampler having sorting and rate allocation. Rate allocation assigns a certain percentage of spans per policy order. For example, if we set max_total_spans_per_second to 100, we can allocate rates as follows:
>   1. test-composite-policy-1 = 50% of max_total_spans_per_second = 50 spans_per_second
>   2. test-composite-policy-2 = 25% of max_total_spans_per_second = 25 spans_per_second
>   3. Use `always_sample` as one of the policies to ensure remaining capacity is filled.

Additional configuration options can be modified:

> - `decision_wait` (default = 30 seconds): Wait time from the first span of a trace before making a sampling decision
> - `num_traces` (default = 50000): Number of traces stored in memory
> - `expected_new_traces_per_sec` (default = 0): Expected number of new traces (helps allocate data structures)

Example:

```yaml
processors:
  tail_sampling:
    decision_wait: 10s
    num_traces: 100
    expected_new_traces_per_sec: 10
    policies:
      [
        {
          name: test-policy-1,
          type: always_sample
        },
        {
          name: test-policy-2,
          type: latency,
          latency: {threshold_ms: 5000}
        },
        {
          name: test-policy-3,
          type: numeric_attribute,
          numeric_attribute: {key: key1, min_value: 50, max_value: 100}
        },
        {
          name: test-policy-4,
          type: probabilistic,
          probabilistic: {sampling_percentage: 10}
        },
        {
          name: test-policy-5,
          type: status_code,
          status_code: {status_codes: [ERROR, UNSET]}
        },
        {
          name: test-policy-6,
          type: string_attribute,
          string_attribute: {key: key2, values: [value1, value2]}
        },
        {
          name: test-policy-7,
          type: string_attribute,
          string_attribute: {key: key2, values: [value1, val*], enabled_regex_matching: true, cache_max_size: 10}
        },
        {
          name: test-policy-8,
          type: rate_limiting,
          rate_limiting: {spans_per_second: 35}
        },
        {
          name: test-policy-9,
          type: string_attribute,
          string_attribute: {key: http.url, values: [/health, /metrics], enabled_regex_matching: true, invert_match: true}
        },
        {
          name: and-policy-1,
          type: and,
          and: {
            and_sub_policy:
              [
                {
                  name: test-and-policy-1,
                  type: numeric_attribute,
                  numeric_attribute: {key: key1, min_value: 50, max_value: 100}
                },
                {
                  name: test-and-policy-2,
                  type: string_attribute,
                  string_attribute: {key: key2, values: [value1, value2]}
                }
              ]
          }
        },
        {
          name: composite-policy-1,
          type: composite,
          composite:
            {
              max_total_spans_per_second: 1000,
              policy_order: [test-composite-policy-1, test-composite-policy-2, test-composite-policy-3],
              composite_sub_policy:
                [
                  {
                    name: test-composite-policy-1,
                    type: numeric_attribute,
                    numeric_attribute: {key: key1, min_value: 50, max_value: 100}
                  },
                  {
                    name: test-composite-policy-2,
                    type: string_attribute,
                    string_attribute: {key: key2, values: [value1, value2]}
                  },
                  {
                    name: test-composite-policy-3,
                    type: always_sample
                  }
                ],
              rate_allocation:
                [
                  {
                    policy: test-composite-policy-1,
                    percent: 50
                  },
                  {
                    policy: test-composite-policy-2,
                    percent: 25
                  }
                ]
            }
        }
      ]
```

For detailed examples using the processor, see [tail_sampling_config.yaml](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/tailsamplingprocessor/testdata/tail_sampling_config.yaml).

## Comparison Between Probabilistic Sampler Processor and Tail-Based Sampler with Probabilistic Policy

The probabilistic sampler processor and tail-based sampler with probabilistic policy work similarly: based on a configurable sampling percentage, they sample received traces at a fixed ratio. However, depending on the overall processing pipeline, you should prefer one over the other.

As a rule of thumb, if you want to add probabilistic sampling and...

...you haven't used the tail-based sampler yet: use the probabilistic sampler processor. Running the probabilistic sampler processor is more efficient than the tail-based sampler. Probabilistic sampling policies make decisions based on TraceId, so waiting for more spans to arrive does not affect their decision.

...you are already using the tail-based sampler: add a probabilistic sampling policy. You've already incurred the cost of running the tail-based sampler, and adding a probabilistic policy will be negligible. Additionally, using this policy within the tail-based sampler ensures that traces sampled by other policies are not discarded.

## Demonstration Demo

This demo mainly pushes OpenTelemetry data to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/)

### Preparation

1. Download source code: [https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-sampling](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-sampling)

2. Ensure [DataKit](/datakit/datakit-install/) is installed.

| Service Name       | Port         | Description                                                                                                                                                                             |
| ------------------ | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| otel-collector     |              | otel/opentelemetry-collector-contrib:0.69.0                                                                                                                                    |
| springboot_server  | 8080:8080    | opentelemetry-agent version 1.21.0, source code: [https://github.com/lrwh/observable-demo/tree/main/springboot-server](https://github.com/lrwh/observable-demo/tree/main/springboot-server) |

3. Enable OpenTelemetry collection in DataKit.

### Start Services

```shell
docker-compose up -d
```

The following example primarily tests the tail-based sampling strategy.

Configure the tail-based sampler:

```yaml
processors:
  # Tail-based sampler
  tail_sampling:
    decision_wait: 10s
    num_traces: 100
    expected_new_traces_per_sec: 100
    policies:
      [
        {
          name: policy-1,
          type: status_code,
          status_code: {status_codes: [ERROR]}
        },
        {
          name: policy-2,
          type: probabilistic,
          probabilistic: {sampling_percentage: 20}
        }
      ]
```

The above rules are OR relationships, meaning either `policy-1` or `policy-2` being true results in sampling.

Enable the tail-based sampler:

```yaml
service:
  extensions: [pprof, zpages, health_check]
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch, tail_sampling]
      exporters: [otlp]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]
```

### Probabilistic Usage

```yaml
tail_sampling:
  decision_wait: 10s
  num_traces: 100
  expected_new_traces_per_sec: 100
  policies:
    [
      {
        name: policy-2,
        type: probabilistic,
        probabilistic: {sampling_percentage: 20}
      }
    ]
```

1. Access the service API `gateway` 5 times, each returning normally.

> curl http://localhost:8080/gateway

2. Go to <<< custom_key.brand_name >>> to view trace information. According to the sampling rule, at most one trace data will be sampled.

### Status Code Usage

```yaml
processors:
  # Tail-based sampler
  tail_sampling:
    decision_wait: 10s
    num_traces: 100
    expected_new_traces_per_sec: 100
    policies:
      [
        {
          name: policy-1,
          type: status_code,
          status_code: {status_codes: [ERROR]}
        }
      ]
```

1. Set up the client startup.

> curl http://localhost:8080/setClient?c=true

Since the current demo does not start the client service, subsequent calls to the `gateway` interface will result in errors.

2. Access the `gateway` service 5 times, returning `{"msg":"client call failed","code":500}`

3. Go to <<< custom_key.brand_name >>> to view trace information. According to the sampling rule, if an error occurs, all errors are fully sampled.

### Span Count Usage

If the span count is less than or equal to 2, no reporting occurs. Configuration as follows:

```yaml
tail_sampling:
  decision_wait: 10s
  num_traces: 100
  expected_new_traces_per_sec: 100
  policies:
    [
      {
        name: p2,
        type: span_count,
        span_count: {min_spans: 3}
      }
    ]
```

### String Attribute Usage

Scenario: Only collect traces for GET requests.

```yaml
tail_sampling:
  decision_wait: 10s
  num_traces: 100
  expected_new_traces_per_sec: 100
  policies:
    [
      {
        name: policy-string,
        type: string_attribute,
        string_attribute: {key: http.method, values: ["GET"]}
      }
    ]
```

???+ warning "String Attribute Not Always Effective?"

Yes, you read that right. The string_attribute may not always be 100% effective. For example, matching GET requests where a GET request calls a POST request chain means that both GET and POST exist in the complete chain. Despite matching GET, which satisfies the matching requirement, the presence of POST in the chain does not cause filtering.

### AND Usage

AND: Sample and report when all AND conditions are met; discard otherwise.

Scenario: Report GET requests and sample at a 20% rate, discarding other cases.

```yaml
tail_sampling:
  decision_wait: 10s
  num_traces: 100
  expected_new_traces_per_sec: 100
  policies:
    [
      {
        name: and-policy-1,
        type: and,
        and: {
          and_sub_policy:
            [
              {
                name: test-and-policy-2,
                type: string_attribute,
                string_attribute: {key: http.method, values: ["GET"]}
              },
              {
                name: policy-2,
                type: probabilistic,
                probabilistic: {sampling_percentage: 20}
              }
            ]
        }
      }
    ]
```

## Sampling Format Notes

Incorrect sampling format can lead to sampling failure. It is recommended to add spaces between each word, symbol, and number.

???+ warning "Incorrect Format"

```yaml
{
 name: p2,
 type: span_count,
 span_count:{min_spans: 3 }
 }
```
or
```yaml
{
 name: p2,
 type: span_count,
 span_count: {min_spans:3 }
 }
```

???+ success "Correct Format"
```yaml
{
 name: p2,
 type: span_count,
 span_count: {min_spans: 3 }
 }
```