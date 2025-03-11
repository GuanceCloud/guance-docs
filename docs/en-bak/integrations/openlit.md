---
title     : 'OpenLIT'
summary   : 'OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to DataKit'
tags      :
  - 'OTEL'
  - 'Tracing'
__int_icon: 'icon/openlit'
dashboard:
  - desc: 'OpenLIT Monitoring View'
    path: 'dashboard/en/openlit'
---

OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to DataKit.

## Configuration {#config}

<!-- markdownlint-disable MD038 -->
Before using OTEL to send Traces to DataKit, please ensure that you have configured the [Collector](opentelemetry.md. Additionally, you need to adjust the configuration file by adding `customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]`, as shown below:
<!-- markdownlint-enable -->

```toml
[[inputs.opentelemetry]]
  ## customer_tags will work as a whitelist to prevent tags send to data center.
  ## All . will replace to _ ,like this :
  ## "project.name" to send to GuanCe center is "project_name"
  customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]

  ...
```

After making these adjustments, restart DataKit.


### Install OpenLIT SDK

> pip install openlit

### Initialize OpenLIT in Your Application

```python
import openlit

openlit.init(otlp_endpoint="http://127.0.0.1:9529/otel")
```

Example Usage for monitoring OpenAI Usage:

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
            "content": "What is LLM Observability",
        }
    ],
    model="gpt-3.5-turbo",
)

```

## Reference {#more-readings}

- OpenLIT [quickstart](https://docs.openlit.io/latest/quickstart){:target="_blank"}
