---
title: 'OpenAI'
summary: 'The displayed Metrics of OpenAI include total requests, response time, request volume, number of request errors, and consumed token count.'
__int_icon: 'icon/openai'
dashboard:

  - desc: 'OpenAI Built-in Views'
    path: 'dashboard/en/openai'

monitor:
  - desc: 'OpenAI Monitors'
    path: 'monitor/en/openai'

---

<!-- markdownlint-disable MD025 -->

# OpenAI

<!-- markdownlint-enable -->

The displayed Metrics of OpenAI include total requests, response time, request volume, number of request errors, and consumed token count.

## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install DataKit

Install the DataKit data collector. In the <<< custom_key.brand_name >>> workspace, click Integration -- DataKit, copy the installation command line to install DataKit.

**Note**: After installing DataKit, modify one configuration:

- Log in as root user and open the DataKit configuration: `vim /usr/local/datakit/conf.d/datakit.conf`
- Change http_listen = "localhost:9529" to http_listen = "0.0.0.0:9529"
- Restart the DataKit service: `datakit service -R`

For more information, please refer to:

- [practice-connect-to-datakit](https://<<< custom_key.func_domain >>>/doc/practice-connect-to-datakit/)
- [datakit-service-how-to](<<< homepage >>>/datakit/datakit-service-how-to/)

### Install Script

Install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (ChatGpt Monitoring)」(ID: `guance_chatgpt_monitor`)

After clicking 【Install】, input the corresponding parameters: OpenAI key.

Click 【Manage】-'Authorization Link' -'Create', create an authorization link for this function. After creation, in the authorization link list, you can find this function. Click the "Example" on the right side of this function, select 'POST Simplified Form (**Json**) ', you will get a link, fill this link into the 'url' section of the code.

We have collected some configurations by default; for details, see the Metrics section.

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding automatic trigger configuration exists for the task, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, go to 「Metrics」to check if there are corresponding monitoring data.

## Metrics {#metric}

| Metric        | Description   | Type  | Unit  |
| ------------- | ------------- | ----- | ----- |
| question      | Total Requests | float | count |
| response_time | Response Time | float | s     |
| create_time   | Request Volume | float | count |
| res_status    | Number of Request Errors | float | count |
| total_tokens  | Total Consumed Tokens | float | count |