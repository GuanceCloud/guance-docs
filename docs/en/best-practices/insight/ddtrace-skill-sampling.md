# ddtrace Sampling

---

???+ warning

    **The current example uses ddtrace version `0.114.0` (latest version) for testing**

## Prerequisites

- Enable the [DataKit ddtrace Collector](/integrations/ddtrace/)

- Prepare Shell

  ```shell
  java -javaagent:D:/ddtrace/dd-java-agent-0.114.0.jar \
  -Ddd.service.name=ddtrace-server \
  -Ddd.agent.port=9529 \
  -jar springboot-ddtrace-server.jar
  ```

## Installation and Deployment

### 1 Configuration of the Sampler Section in `ddtrace.conf`

```toml
  ## Sampler config used to set global sampling strategy.
  ## sampling_rate used to set global sampling rate.
  [inputs.ddtrace.sampler]
    sampling_rate = 0.1
```

### 2 Test Script

```shell
for ((i=1;i<=100;i++)); 
do
	curl http://localhost:8080/counter
done
```

### 3 Enable Sampling

1. Enable sampling on the collector side

   The `sampling_rate` range is (0,1). If it is outside this range, traces are discarded.

   If full tracing is required, there is no need to configure `[inputs.ddtrace.sampler]`.

2. Enable sampling on the application side

   Sampling is enabled on the application side using `-Ddd.trace.sample.rate`, with a range of (0,1).

   This is marked as sampled, meaning all traces are collected while being marked for sampling.

3. Sampling Priority

   Both sampling methods have the same effect. If both are configured, the sampling configuration on the collector side will not take effect.

???+ note "Summary"

    `-Ddd.trace.sample.rate` > `sampling_rate`


## Reference Documentation

<[demo source code address](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)>

<[ddtrace startup parameters](/integrations/ddtrace-java/#start-options)>