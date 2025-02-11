---
title: 'Huawei Cloud FunctionGraph'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics for Huawei Cloud FunctionGraph include invocation counts, error counts, rejection counts, concurrency numbers, reserved instance counts, and execution times (including maximum, minimum, and average execution times). These metrics reflect the operational status of FunctionGraph functions.'
__int_icon: 'icon/huawei_functiongraph'
dashboard:

  - desc: 'Built-in views for Huawei Cloud FunctionGraph'
    path: 'dashboard/en/huawei_functiongraph'

monitor:
  - desc: 'Monitors for Huawei Cloud FunctionGraph'
    path: 'monitor/en/huawei_functiongraph'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud FunctionGraph
<!-- markdownlint-enable -->

The displayed metrics for Huawei Cloud FunctionGraph include invocation counts, error counts, rejection counts, concurrency numbers, reserved instance counts, and execution times (including maximum, minimum, and average execution times). These metrics reflect the operational status of FunctionGraph functions.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud FunctionGraph, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-FunctionGraph Collection)」(ID: `guance_huaweicloud_functiongraph`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the task execution records and corresponding logs.

We collect some default configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-functiongraph/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding automatic trigger configuration exists for the task and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
By default, the following metrics are collected for HUAWEI SYS.FunctionGraph. You can configure additional metrics through settings. [Details of Huawei Cloud Monitoring Metrics](https://support.huaweicloud.com/usermanual-functiongraph/functiongraph_01_0213.html){:target="_blank"}

| Metric ID        | Metric Name     | Metric Description                                      | Value Range      | Measurement Object | **Monitoring Period (Raw Metrics)** |
| ---- -------- | ----------- | -------------------------------------------- | ------------- | --------- | ---------------------- |
| `count`        | Invocation Count      | This metric counts the number of function invocations. Unit: count            | ≥ 0 counts   | Function       | 1 minute                   |
| `failcount`    | Error Count      | This metric counts the number of failed function invocations. Errors occur when the function request fails or returns a non-200 status code. Unit: count          | ≥ 0 counts   | Function       | 1 minute                   |
| `rejectcount`        | Rejection Count      | This metric counts the number of rejected function invocations due to excessive concurrent requests. Unit: count   | ≥ 0 counts   | Function       | 1 minute                   |
| `concurrency`        | Concurrency Count      | This metric counts the maximum number of concurrent function invocations. Unit: count            | ≥ 0 counts   | Function       | 1 minute                   |
| `reservedinstancenum`        | Reserved Instance Count      | This metric counts the number of reserved instances configured for the function. Unit: count           | ≥ 0 counts   | Function       | 1 minute                   |
| `duration`        | Average Execution Time      | This metric measures the average execution time of function invocations. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |
| `maxDuration`        | Maximum Execution Time      | This metric measures the maximum execution time of function invocations. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |
| `minDuration`        | Minimum Execution Time      | This metric measures the minimum execution time of function invocations. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |

## Objects {#object}

The structure of collected HUAWEI SYS.FunctionGraph object data can be viewed in 「Infrastructure - Custom」

``` json
{
  "measurement": "huaweicloud_functiongraph",
  "tags": {
    "code_type"    : "inline",
    "domain_id"    : "1e1fed98168XXXXXX0e285140c83",
    "func_name"    : "XXXXX",
    "func_urn"     : "urn:fss:cn-north-4:c631f046252d4ebda45f253c62d48585:function:default:Helloworld2",
    "handler"      : "index.handler",
    "image_name"   : "latest-230718XXXXX@fikfe",
    "namespace"    : "c631f04625XXXXXX45f253c62d48585",
    "package"      : "default",
    "project_name" : "cn-north-4",
    "runtime"      : "Python3.9"
  },
  "fields": {
    "code_size"       : 286,
    "cpu"             : 300,
    "last_modified"   : "2023-07-18TXX:XX:XX+08:00",
    "memory_size"     : 128,
    "timeout"         : 3,
    "strategy_config" : "{function strategy configuration}",
    "message"         : "{instance JSON data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.last_modified`, `fields.message`, and `fields.strategy_config` are JSON serialized strings.