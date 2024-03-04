---
title     : 'LangChain'
summary   : 'Optimize LangChain usage: prompt sampling and performance and cost metrics.'
__int_icon: 'icon/langchain'
dashboard :
  - desc  : 'LangChain'
    path  : 'dashboard/en/langchain'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# LangChain
<!-- markdownlint-enable -->

Get cost estimation, prompt and completion sampling, error tracking, performance metrics, and more out of LangChain Python library requests using DDTrace metrics, APM, and logs.

## Installation Configuration{#config}

### Installation DDTrace

`pip install ddtrace>=1.17`

### DataKit Configuration

- Enabled DDTrace collector

The DDTrace collector is used to collect tracing information,Enter the DataKit installation directory, execute `conf.d/ddtrace/`, copy `ddtrace.conf.sample` and rename it to `ddtrace.conf`

- Enabled StatsD collector

The StatsD collector is used to collect metrics information, with a default port of `8125`.

- Restart DataKit

```shell
systemctl restart datakit
```

### Run application

```shell
DD_SERVICE="my-langchain" DD_ENV="dev" DD_AGENT_HOST="localhost" DD_AGENT_PORT="9529" ddtrace-run python <your-app>.py
```


If debugging needs to be enabled, add parameters at startup `-- debug`.

```shell
DD_SERVICE="my-langchain" DD_ENV="dev" DD_AGENT_HOST="localhost" DD_AGENT_PORT="9529" ddtrace-run --debug python <your-app>.py
```

## Metric {#metric}

### `langchain`

| Metrics | Units | Description |
| -- | -- | -- |
|request_duration|nanoseconds|Request duration distribution.|
|request_error | errors | Number of errors.|
|tokens_completion |tokens/request |Number of tokens used in the completion of a response.|
|tokens_prompt |tokens/request |Number of tokens used in the prompt of a request.|
|tokens_total |tokens/request |Total number of tokens used in a request and response. |
|tokens_total_cost |dollars |Estimated cost in USD based on token usage.|

