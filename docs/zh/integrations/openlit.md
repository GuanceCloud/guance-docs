---
title     : 'OpenLIT'
summary   : 'OpenLIT 通过简化生成式 AI 和大模型语言(LLM)的开发流程，并提供全面的可观测性支持，并将可观测性数据上报到观测云'
tags      :
  - 'OTEL'
  - '链路追踪'
__int_icon: 'icon/openlit'
dashboard:
  - desc: 'OpenLIT 内置视图'
    path: 'dashboard/zh/openlit'
---

OpenLIT 通过简化生成式 AI 和大模型语言(LLMs)的开发流程，并提供全面的可观测性支持，并将可观测性数据上报到观测云。

## 配置 {#config}
<!-- markdownlint-disable MD038 -->
在使用 OTEL 将链路追踪数据发送到 DataKit 之前，请确保已配置 [Collector](opentelemetry.md)，同时需要调整配置文件`  customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]`，如下所示：
<!-- markdownlint-enable -->

```toml
[[inputs.opentelemetry]]
  ## customer_tags will work as a whitelist to prevent tags send to data center.
  ## All . will replace to _ ,like this :
  ## "project.name" to send to GuanCe center is "project_name"
    customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]

  ...
```

调整完成后，重启 DataKit


### 安装 OpenLIT SDK

> pip install openlit

### 在应用程序中初始化 OpenLIT

```python
import openlit

openlit.init(otlp_endpoint="http://127.0.0.1:9529/otel")

```

监控 OpenAI 使用的示例代码：

```python
from openai import OpenAI
import openlit

# Init OpenLit
openlit.init(
    otlp_endpoint="http://127.0.0.1:9529/otel",
    application_name="openlit_demo"
)

client = OpenAI(
    api_key="YOUR_OPENAI_KEY"
)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "什么是 LLM 可观测性",
        }
    ],
    model="gpt-3.5-turbo",
)

```

## 参考资料 {#more-readings}

- OpenLIT [quickstart](https://docs.openlit.io/latest/quickstart){:target="_blank"}
