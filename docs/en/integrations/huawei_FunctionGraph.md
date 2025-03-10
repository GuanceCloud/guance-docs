---
title: 'Huawei Cloud FunctionGraph'
tags: 
  - Huawei Cloud
summary: 'The metrics displayed for Huawei Cloud FunctionGraph include invocation counts, error counts, rejected counts, concurrency numbers, reserved instance counts, and runtime (including maximum, minimum, and average runtimes). These metrics reflect the operational status of FunctionGraph functions.'
__int_icon: 'icon/huawei_functiongraph'
dashboard:

  - desc: 'Built-in Views for Huawei Cloud FunctionGraph'
    path: 'dashboard/en/huawei_functiongraph'

monitor:
  - desc: 'Monitors for Huawei Cloud FunctionGraph'
    path: 'monitor/en/huawei_functiongraph'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud FunctionGraph
<!-- markdownlint-enable -->

The metrics displayed for Huawei Cloud FunctionGraph include invocation counts, error counts, rejected counts, concurrency numbers, reserved instance counts, and runtime (including maximum, minimum, and average runtimes). These metrics reflect the operational status of FunctionGraph functions.

## Configuration {#config}

### Installing Func

We recommend enabling the Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you choose to deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Ensure you have prepared a Huawei Cloud AK that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei FunctionGraph, install the corresponding collection script: "Guance Integration (Huawei Cloud - FunctionGraph Collection)" (ID: `guance_huaweicloud_functiongraph`).

After clicking 【Install】, enter the required parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】 to have the system automatically create the `Startup` script set and configure the startup scripts accordingly.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-functiongraph/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm that the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", verify if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring Huawei SYS.FunctionGraph, the default metric set is as follows. You can collect more metrics by configuring further. Refer to [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-functiongraph/functiongraph_01_0213.html){:target="_blank"}

| Metric ID        | Metric Name     | Description                                      | Value Range      | Measurement Object   | **Monitoring Period (Original Metric)** |
| ---- -------- | ----------- | -------------------------------------------- | ------------- | --------- | ---------------------- |
| `count`        | Invocation Count      | This metric counts the number of function invocations. Unit: times            | ≥ 0 counts   | Function       | 1 minute                   |
| `failcount`    | Error Count      | This metric counts the number of function invocation errors. Errors occur when function requests fail to complete or return a non-200 status code due to syntax or execution issues. Unit: times          | ≥ 0 counts   | Function       | 1 minute                   |
| `rejectcount`        | Rejected Count      | This metric counts the number of function invocations that were rejected due to too many concurrent requests. Unit: times   | ≥ 0 counts   | Function       | 1 minute                   |
| `concurrency`        | Concurrency      | This metric counts the maximum number of concurrent requests being processed simultaneously. Unit: instances            | ≥ 0 counts   | Function       | 1 minute                   |
| `reservedinstancenum`        | Reserved Instance Count      | This metric counts the number of reserved instances configured for the function. Unit: instances           | ≥ 0 counts   | Function       | 1 minute                   |
| `duration`        | Average Runtime      | This metric measures the average runtime of function invocations. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |
| `maxDuration`        | Maximum Runtime      | This metric measures the maximum runtime of function invocations. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |
| `minDuration`        | Minimum Runtime      | This metric measures the minimum runtime of function invocations. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |

## Objects {#object}

The object data structure collected from Huawei SYS.FunctionGraph can be viewed in "Infrastructure - Custom"

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
> Tip 2: `fields.last_modified`, `fields.message`, and `fields.strategy_config` are serialized JSON strings.