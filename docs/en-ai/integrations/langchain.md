---
title     : 'LangChain'
summary   : 'Optimizing the use of LangChain: timely sampling and performance and cost metrics.'
__int_icon: 'icon/langchain'
dashboard :
  - desc  : 'LangChain'
    path  : 'dashboard/zh/langchain'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# LangChain
<!-- markdownlint-enable -->

Use DDTrace to obtain cost estimates, prompt and completion sampling, error tracking, performance metrics, etc., from requests made using the LangChain Python library.

## Configuration {#config}

### Install DDTrace

`pip install ddtrace>=1.17`

### DataKit Configuration

- Enable the DDTrace collector

The DDTrace collector is used to collect trace information. Navigate to the `conf.d/ddtrace/` directory under the DataKit installation directory, copy `ddtrace.conf.sample`, and rename it to `ddtrace.conf`.

- Enable the StatsD collector

The StatsD collector is used to collect metrics information, with the default port being `8125`.

- Restart DataKit

```shell
systemctl restart datakit
```

### Run the Application

```shell
DD_SERVICE="my-langchain" DD_ENV="dev" DD_AGENT_HOST="localhost" DD_AGENT_PORT="9529" ddtrace-run python <your-app>.py
```

If you need to enable debug mode, add the `--debug` parameter when starting:

```shell
DD_SERVICE="my-langchain" DD_ENV="dev" DD_AGENT_HOST="localhost" DD_AGENT_PORT="9529" ddtrace-run --debug python <your-app>.py
```

## Metrics {#metric}

### `langchain`

| Metrics | Units | Description |
| -- | -- | -- |
|request_duration|nanoseconds|Distribution of request durations.|
|request_error | errors | Number of request errors.|
|tokens_completion |tokens/request |Number of tokens used in the completion response.|
|tokens_prompt |tokens/request |Number of tokens used in the request prompt.|
|tokens_total |tokens/request |Total number of tokens used in both request and response.|
|tokens_total_cost |dollars |Estimated cost (in dollars) based on token usage.|

</translated_content>