---
title     : 'OpenLIT'
summary   : 'OpenLIT simplifies the development process of generative AI and large language models (LLMs), providing comprehensive observability support, and reports observability data to <<< custom_key.brand_name >>>.'
tags      :
  - 'OTEL'
  - 'APM'
__int_icon: 'icon/openlit'
dashboard:
  - desc: 'Built-in views of OpenLIT'
    path: 'dashboard/en/openlit'
---

OpenLIT simplifies the development process of generative AI and large language models (LLMs), providing comprehensive observability support, and reports observability data to <<< custom_key.brand_name >>>.

## Configuration {#config}
<!-- markdownlint-disable MD038 -->
Before sending APM data using OTEL to DataKit, ensure that the [Collector](opentelemetry.md) has been configured. You also need to adjust the configuration file `customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]` as follows:
<!-- markdownlint-enable -->

```toml
[[inputs.opentelemetry]]
  ## customer_tags will work as a whitelist to prevent tags from being sent to the data center.
  ## All . will be replaced with _ , like this :
  ## "project.name" to send to GuanCe center is "project_name"
    customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]

  ...
```

After making adjustments, restart DataKit.


### Install the OpenLIT SDK

> pip install openlit

### Initialize OpenLIT in your application

```python
import openlit

openlit.init(otlp_endpoint="http://127.0.0.1:9529/otel")

```

Example code for monitoring OpenAI usage:

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
            "content": "What is LLM observability",
        }
    ],
    model="gpt-3.5-turbo",
)

```

## Further Reading {#more-readings}

- OpenLIT [quickstart](https://docs.openlit.io/latest/quickstart){:target="_blank"}