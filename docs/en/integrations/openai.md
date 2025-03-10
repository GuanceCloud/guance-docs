---
title: 'OpenAI'
summary: 'The displayed metrics for OpenAI include total requests, response time, request count, request error count, and consumed token count.'
__int_icon: 'icon/openai'
dashboard:

  - desc: 'Built-in OpenAI View'
    path: 'dashboard/en/openai'

monitor:
  - desc: 'OpenAI Monitor'
    path: 'monitor/en/openai'

---

<!-- markdownlint-disable MD025 -->

# OpenAI

<!-- markdownlint-enable -->

The displayed metrics for OpenAI include total requests, response time, request count, request error count, and consumed token count.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install DataKit

Install the DataKit data collector within the Guance workspace. Click on Integration -- DataKit, copy the installation command line to install DataKit.

**Note**: After installing DataKit, modify one configuration:

- Log in as root user and open the DataKit configuration: `vim /usr/local/datakit/conf.d/datakit.conf`
- Change `http_listen = "localhost:9529"` to `http_listen = "0.0.0.0:9529"`
- Restart the DataKit service: `datakit service -R`

For more information, please refer to:

- <https://func.guance.com/doc/practice-connect-to-datakit/>
- <https://docs.guance.com/datakit/datakit-service-how-to/>

### Install Script

Install the corresponding collection script: 「Guance Integration (ChatGpt Monitoring)」(ID: `guance_chatgpt_monitor`)

After clicking 【Install】, enter the corresponding parameters: OpenAI key.

Click 【Manage】 -> ‘Authorization Link’ -> ‘Create’, create an authorization link for this function. Once created, find this function in the authorization link list. Click on the “Example” on the right side of this function, select ‘POST Simplified Form (**Json**)’, which will give you a URL. Fill this URL into the code's 'url' field.

We have collected some configurations by default; see the Metrics section for details.

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has been configured for automatic triggers. You can also check the task records and logs to ensure there are no anomalies.
2. On the Guance platform, under 「Metrics」, verify if the corresponding monitoring data is available.

## Metrics {#metric}

| Metric        | Description   | Type  | Unit  |
| ------------- | ------------- | ----- | ----- |
| question      | Total Requests | float | count |
| response_time | Response Time | float | s     |
| create_time   | Request Count | float | count |
| res_status    | Request Error Count | float | count |
| total_tokens  | Total Consumed Tokens | float | count |
</translated_content>