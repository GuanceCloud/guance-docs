---
title     : 'OpenLIT'
summary   : 'OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to Guance'
tags      :
  - 'OTEL'
  - 'Trace Linking'
__int_icon: 'icon/openlit'
dashboard:
  - desc: 'Built-in views of OpenLIT'
    path: 'dashboard/en/openlit'
---

OpenLIT simplifies the development process for generative AI and large language models (LLMs), providing comprehensive observability support and reporting observability data to Guance.

## Configuration {#config}
<!-- markdownlint-disable MD038 -->
Before sending trace linking data to DataKit using OTEL, ensure that the [Collector](opentelemetry.md) is configured. You also need to adjust the configuration file `customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]` as follows:
<!-- markdownlint-enable -->

```toml
[[inputs.opentelemetry]]
  ## customer_tags will work as a whitelist to prevent tags from being sent to the data center.
  ## All . will be replaced with _, like this:
  ## "project.name" will be sent to Guance center as "project_name"
    customer_tags = ["gen_ai.application_name","gen_ai.request.model","gen_ai.prompt","gen_ai.completion","gen_ai.request.temperature","gen_ai.usage.input_tokens","gen_ai.usage.output_tokens","gen_ai.usage.total_tokens","gen_ai.endpoint","gen_ai.system"]

  ...
```

After making these adjustments, restart DataKit.


### Install the OpenLIT SDK

> pip install openlit

### Initialize OpenLIT in Your Application

```python
import openlit

openlit.init(otlp_endpoint="http://127.0.0.1:9529/otel")

```

Example code to monitor OpenAI usage:

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

## Additional Resources {#more-readings}

- OpenLIT [quickstart](https://docs.openlit.io/latest/quickstart){:target="_blank"}