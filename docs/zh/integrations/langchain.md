---
title     : 'LangChain'
summary   : '优化 LangChain 的使用：及时采样以及性能和成本指标。'
__int_icon: 'icon/langchain'
dashboard :
  - desc  : 'LangChain'
    path  : 'dashboard/zh/langchain'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# LangChain
<!-- markdownlint-enable -->

使用 DDTrace 从 LangChain Python 库请求中获取成本估计、提示和完成采样、错误跟踪、性能指标等。

## 配置 {#config}

### 安装 DDTrace

`pip install ddtrace>=1.17`

### DataKit 配置

- 开启 DDTrace 采集器

DDTrace 采集器用于采集链路信息，进入到 DataKit 安装目录下，执行`conf.d/ddtrace/`，复制`ddtrace.conf.sample` 并重命名为 `ddtrace.conf`

- 开启 StatsD 采集器

StatsD 采集器用于采集指标信息，默认端口为`8125`。

- 重启 DataKit

```shell
systemctl restart datakit
```

### 运行应用

```shell
DD_SERVICE="my-langchain" DD_ENV="dev" DD_AGENT_HOST="localhost" DD_AGENT_PORT="9529" ddtrace-run python <your-app>.py
```

如需开启 debug，则启动时添加参数`--debug`

```shell
DD_SERVICE="my-langchain" DD_ENV="dev" DD_AGENT_HOST="localhost" DD_AGENT_PORT="9529" ddtrace-run --debug python <your-app>.py
```

## 指标 {#metric}

### `langchain`

| Metrics | Units | Description |
| -- | -- | -- |
|request_duration|nanoseconds|请求持续时间分布。|
|request_error | errors | 请求异常数。|
|tokens_completion |tokens/request |完成响应时使用的令牌数。|
|tokens_prompt |tokens/request |在请求提示中使用的令牌数。|
|tokens_total |tokens/request |请求和响应中使用的令牌总数。|
|tokens_total_cost |dollars |基于代币使用情况的估计成本（美元）。|

