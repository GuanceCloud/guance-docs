---
title: 'OpenAI'
summary: 'The display metrics of OpenAI include the total number of requests, response time, number of requests, number of request errors, and number of consumed tokens.'
__int_icon: 'icon/openai'
dashboard:

  - desc: 'OpenAI Monitoring View'
    path: 'dashboard/zh/openai'

monitor:
  - desc: 'OpenAI Monitor'
    path: 'monitor/zh/openai'

---

<!-- markdownlint-disable MD025 -->

# OpenAI

<!-- markdownlint-enable -->

The display metrics of OpenAI include the total number of requests, response time, number of requests, number of request errors, and number of consumed tokens.

## Config

### Install Func

Recommend opening Observation Cloud Integration - Extension - Managed Version Func: All prerequisites are automatically installed, please continue with script installation

If deploying Func on your own, refer to [Deploying Func on your own](https://func.guance.com/doc/script-market-guance-integration/){: target="_blank"}

### Install DataKit

Install the DataKit data collector, in the observation cloud space, click on Integration - Datakit, copy and install the command line to install the **datakit**

**Note** : After installing DataKit, modify a configuration:

- After the root user logs in, open the DataKit configuration: `vim/usr/local/datakit/conf.d/datakit.conf`
- `Add HTTP_ Listen="localhost: 9529" Change to http_ Listen="0.0.0.0:9529"`

- Restart DataKit service: `datakit service - R`

For more information, please refer to:

- <https://func.guance.com/doc/practice-connect-to-datakit/>

- <https://docs.guance.com/datakit/datakit-service-how-to/>

### Install script

Install the corresponding collection script: 'Observation Cloud Integration (ChatGpt Monitoring)' (ID: 'guiance_chatgpt_monitor')

After clicking [Install], enter the corresponding parameter: OpenAI key.

Click 'Management' - 'Authorization Link' - 'New' to create an authorization link for this function. After creating it, you can find this function in the authorization link list. Click on the 'Example' on the right side of this function, select 'POST Simplified Form (Json)', and you will get a link that will be filled in at the 'URL' of the code.

We have collected some configurations by default, as detailed in the metric column

### Verification

1. Confirm whether the corresponding task already has a corresponding automatic trigger configuration in "Management/Automatic Trigger Configuration", and check the corresponding task records and logs for any abnormalities
2. On the observation cloud platform, check whether there is corresponding monitoring data for the 'metrics'

## Metric

| Metric        | Description                     | Type  | Unit  |
| ------------- | ------------------------------- | ----- | ----- |
| question      | Total Requests                  | float | count |
| response_time | response time                   | float | s     |
| create_time   | Request quantity                | float | count |
| res_status    | Number of request errors        | float | count |
| total_tokens  | Total number of tokens consumed | float | count |

