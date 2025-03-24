# OpenTelemetry Sampling Best Practices

---

Full-chain data can indeed greatly assist relevant personnel in promptly and accurately identifying business issues. However, the probability of business problems occurring in enterprises is generally very low, and full-chain sampling has its own advantages and disadvantages.

Advantages

- Complete link data

Disadvantages

- Resource waste. Due to complete data leading to a significant increase in data storage resource costs, the cost of searching for abnormal chain data also increases.

Based on full-chain data collection, OpenTelemetry supports two types of samplers:

> 1. Probabilistic sampler (probabilisticsamplerprocessor)
>
> 2. Tail sampler (tailsamplingprocessor)

## [Probabilistic Sampler Processor](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/probabilisticsamplerprocessor)

As the name suggests, the probabilistic sampler samples according to a certain probability. Similarly, OpenTelemetry supports two types of probabilistic sampling:

> 1. `sampling.priority` semantic conventions defined by OpenTracing
>
> 2. TraceId hash

The `sampling.priority` semantic convention takes precedence over TraceId hash. As the name implies, TraceId hash sampling is based on the hash value determined by the TraceId. To make TraceId hash work, all collectors in a given layer (e.g., behind the same load balancer) must have the same `hash_seed`. You can also use different `hash_seed`s in different collector layers to support additional sampling requirements. For configuration specifications, see [config.go](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/probabilisticsamplerprocessor/config.go).

You can modify the following configuration options:

- `hash_seed` (no default value): An integer used to compute the hash algorithm. Note that all collectors in a given layer (e.g., behind the same load balancer) should have the same hash_seed.
  
  This is important when using multiple layers of collectors to achieve the desired sampling rate, for example: first layer at 10%, second layer at 10%, overall sampling rate at 1% (10%x 10%).
  
  If all layers use the same seed, then all data through one layer will also pass through the next layer, regardless of the configured sampling rate. Having different seeds in different layers ensures that the sampling rate works as expected per layer.

- `sampling_percentage` (default = 0): The percentage of traces to sample; >= 100 means collecting all traces.

Configuring the probabilistic sampler:

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
      processors: [batch,probabilistic_sampler]
      exporters: [otlp]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]
```

## [Tail Sampling Processor](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/processor/tailsamplingprocessor)

The tail sampling processor samples traces based on a set of defined policies. Currently, this processor only applies to a single instance of the collector. Technically, traceId-aware load balancing can be used to support multiple collector instances, but this configuration has not been tested yet. For configuration specifications, see [config.go](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/tailsamplingprocessor/config.go).

The following configuration options are required:

- `policies` (no default value): Policies used to make sampling decisions

Currently, multiple policies are supported. These include:

> - `always_sample`: Samples all traces
> - `latency`: Samples based on trace duration. Duration is determined by looking at the earliest start time and latest end time without considering what happens between them.
> - `numeric_attribute`: Samples based on numeric attributes
> - `probabilistic`: Samples a certain percentage of traces.
> - `status_code`: Samples based on status code (`OK`, `ERROR`, or `UNSET`). Many people incorrectly consider this as the response body JSON code (many projects define it this way), but it is not correct.
> - `string_attribute`: Samples based on string attribute value matching, supporting exact matches and regular expression value matching.
> - `rate_limiting`: Samples based on rate.
> - `and`: Creates an AND policy based on multiple policies.
> - `composite`: Combines the above samplers with sorting and rate allocation. Rate allocation assigns a certain percentage of spans to each policy order. For example, if we set max_total_spans_per_second to 100, then we can allocate rate_allocation as follows:
>   1. test-composite-policy-1 = 50% of max_total_spans_per_second = 50 spans_per_second
>   2. test-composite-policy-2 = 25% of max_total_spans_per_second = 25 spans_per_second
>   3. To ensure remaining capacity is filled, use always_sample as one of the strategies.
>
> The following configuration options can also be modified:
>
> - `decision_wait` (default = 30 seconds): Waiting time from the first span of the trace before making a sampling decision.
> - `num_traces` (default = 50000): Number of traces stored in memory.
> - `expected_new_traces_per_sec` (default = 0): Expected number of new traces (helps allocate data structures).

Example:

```yaml
processors:
  tail_sampling:
    decision_wait: 10s
    num_traces: 100
    expected_new_traces_per_sec: 10
    policies:      [
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
            string_attribute: {key: http.url, values: [\/health, \/metrics], enabled_regex_matching: true, invert_match: true}
         },
         {
            name: and-policy-1,
            type: and,
            and: {
              and_sub_policy:               [
                {
                  name: test-and-policy-1,
                  type: numeric_attribute,
                  numeric_attribute: { key: key1, min_value: 50, max_value: 100 }
                },
                {
                    name: test-and-policy-2,
                    type: string_attribute,
                    string_attribute: { key: key2, values: [ value1, value2 ] }
                },
              ]
            }
         },
         {
            name: composite-policy-1,
            type: composite,
            composite:              {
                max_total_spans_per_second: 1000,
                policy_order: [test-composite-policy-1, test-composite-policy-2, test-composite-policy-3],
                composite_sub_policy:                  [
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
                rate_allocation:                  [
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
          },
        ]
```

For detailed examples of using the processor, see [tail_sampling_config.yaml](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/processor/tailsamplingprocessor/testdata/tail_sampling_config.yaml).


## Comparison of Probabilistic Sampling Processor with Tail Sampling Processor Using Probabilistic Strategy

The probabilistic sampling processor and probabilistic tail sampling processor strategy work very similarly: based on a configurable sampling percentage, they both sample incoming traces at a fixed ratio. But depending on the overall processing pipeline, you should prefer one over the other.

As a rule of thumb, if you want to add probabilistic sampling and...

...you're not already using the tail sampling processor: Use the probabilistic sampling processor. Running the probabilistic sampling processor is more efficient than the tail sampling processor. Probabilistic sampling strategies make decisions based on the traceId, so waiting for more spans to arrive does not affect their decision.

...you're already using the tail sampling processor: Add a probabilistic sampling strategy. You've already incurred the cost of running the tail sampling processor, adding a probabilistic strategy will be negligible. Additionally, using this strategy within the tail sampling processor ensures that traces sampled by other strategies are not discarded.


## Demonstration Demo

This demo mainly pushes OpenTelemetry data to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/).

### Preparation

1. Download source code: [https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-sampling](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-sampling)

2. Ensure that [DataKit](/datakit/datakit-install/) is installed.

| Service Name             | Port       | Description                                                                                                                                                                             |
| ----------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| otel-collector           |            | otel/opentelemetry-collector-contrib:0.69.0                                                                                                                                    |
| springboot_server        | 8080:8080  | opentelemetry-agent version 1.21.0, source code address: [https://github.com/lrwh/observable-demo/tree/main/springboot-server](https://github.com/lrwh/observable-demo/tree/main/springboot-server) |

3. Enable OpenTelemetry collection in Datakit.

### Start Services

```shell
docker-compose up -d
```

The following example mainly tests the tail sampling strategy.

Configure the tail sampler:

```yaml
processors:
  # Tail sampler
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

The above rules are 'OR' relationships, meaning that if either `policy-1` or `policy-2` holds true, sampling occurs.

Enable the tail sampler:

```yaml
service:
  extensions: [pprof, zpages, health_check]
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch,tail_sampling]
      exporters: [otlp]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]
```

### Usage of Probabilistic

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

2. Go to <<< custom_key.brand_name >>> to check trace information. According to the sampling rule, at most one trace data should be sampled.

### Usage of Status Code

```yaml
processors:
  # Tail sampler
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

In the current demo, the client service is not started, so subsequent calls to the `gateway` interface will result in exceptions.

2. Access the `gateway` service 5 times, returning `{"msg":"client call failed","code":500}`.

3. Go to <<< custom_key.brand_name >>> to check trace information. According to the sampling rule, if an exception occurs, all exceptions will be fully sampled.

### Span Count Usage

If the span count is less than or equal to 2, no reporting occurs. Configuration is as follows:

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
		 span_count: {min_spans: 3 }
		 }
	  ]
```

### String Attribute Usage

Scenario: Only collect GET request chains.

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
		 string_attribute: {key: http.method, values: [ GET ] }
		 }
	  ]
```

???+ warning "Why doesn't string_attribute always work?"

	Yes, you read that right, string_attribute doesn't always work 100%. Taking http.method as an example, if we match GET requests, but this GET request calls a POST request chain, for the entire chain, there are both GET and POST, which creates a conflict. Since it can match GET, satisfying the matching requirement, it won't filter out just because the chain has POST.

### AND Usage

AND: Refers to sampling reports when AND conditions are met, discarding other cases.

Scenario: Report GET requests and sample according to a 20% sampling rate, discard other cases.

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
					 string_attribute: { key: http.method, values: [ GET ] }
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

## Sampling Writing Format Notes

Incorrect sampling format can also lead to sampling failure. It's recommended to add spaces between each word, symbol, and value.

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