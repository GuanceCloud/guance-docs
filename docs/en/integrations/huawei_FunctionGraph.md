---
title: 'Huawei Cloud FunctionGraph'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics for Huawei Cloud FunctionGraph include the number of calls, number of errors, number of rejections, concurrency count, reserved instance count, and run time (including maximum run time, minimum run time, and average run time), which reflect the operational status of the FunctionGraph function.'
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

The displayed metrics for Huawei Cloud FunctionGraph include the number of calls, number of errors, number of rejections, concurrency count, reserved instance count, and run time (including maximum run time, minimum run time, and average run time), which reflect the operational status of the FunctionGraph function.


## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of HUAWEI FunctionGraph, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-FunctionGraph Collection)」(ID: `guance_huaweicloud_functiongraph`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, details see the metric section

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-functiongraph/){:target="_blank"}



### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring HUAWEI SYS.FunctionGraph, the default metric sets are as follows. You can collect more metrics through configuration. [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-functiongraph/functiongraph_01_0213.html){:target="_blank"}

| Metric ID        | Metric Name     | Metric Meaning                                      | Value Range      | Measurement Object   | **Monitoring Cycle (Raw Metric)** |
| ---- -------- | ----------- | -------------------------------------------- | ------------- | --------- | ---------------------- |
| `count`        | Number of Calls      | This metric counts the number of function calls. Unit: times            | ≥ 0 counts   | Function       | 1 minute                   |
| `failcount`    | Error Count      | This metric counts the number of function call errors. The following two situations will both be counted as errors: abnormal function requests that prevent execution from completing and return 200. Syntax errors or execution errors in the function itself. Unit: times          | ≥ 0 counts   | Function       | 1 minute                   |
| `rejectcount`        | Rejected Count      | This metric counts the number of rejected function calls. Rejected count refers to the number of requests rejected due to too many concurrent requests and system flow control. Unit: times   | ≥ 0 counts   | Function       | 1 minute                   |
| `concurrency`        | Concurrency      | This metric counts the maximum number of concurrent requests processed by simultaneous function calls. Unit: items            | ≥ 0 counts   | Function       | 1 minute                   |
| `reservedinstancenum`        | Reserved Instance Count      | This metric counts the number of reserved instances configured for the function. Unit: items           | ≥ 0 counts   | Function       | 1 minute                   |
| `duration`        | Average Run Time      | This metric counts the average run time of function calls. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |
| `maxDuration`        | Maximum Run Time      | This metric counts the maximum run time of function calls. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |
| `minDuration`        | Minimum Run Time      | This metric counts the minimum run time of function calls. Unit: milliseconds           | ≥ 0 ms   | Function       | 1 minute                   |

## Objects {#object}

The collected HUAWEI SYS.FunctionGraph object data structure can be seen from 「Infrastructure - Custom」.

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


> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: `fields.last_modified`, `fields.message`, and `fields.strategy_config` are strings serialized in JSON format.