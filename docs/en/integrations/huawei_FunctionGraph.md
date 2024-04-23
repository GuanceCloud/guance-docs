---
title: 'HUAWEI FunctionGraph'
tags: 
  - Huawei Cloud
summary: 'Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_functiongraph'
dashboard:

  - desc: 'HUAWEI CLOUD FunctionGraph dashboard'
    path: 'dashboard/zh/huawei_functiongraph'

monitor:
  - desc: 'HUAWEI CLOUD FunctionGraph monitor'
    path: 'monitor/zh/huawei_functiongraph'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD FunctionGraph
<!-- markdownlint-enable -->

HUAWEI CLOUD FunctionGraph display metrics include count,**failcount**,**rejectcount**,concurrency,**reservedinstancenum** and so on, these metrics Indicates the operation of function for **FuntionGraph**.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, You can directly grant the global read-only permission for CloudWatch `ReadOnlyAccess`）

To synchronize the monitoring data of HUAWEI CLOUD FunctionGraph cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-FunctionGraphCollect）」(ID：`guance_huaweicloud_functiongraph`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

Then, in the collection script, add the collector-Configs and cloudwatch-Change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click【Run】,you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-functiongraph/){:target="_blank"}



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure HUAWEI SYS.FunctionGraph. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD CloudWatch Metrics Details](https://support.huaweicloud.com/intl/en-us/usermanual-functiongraph/functiongraph_01_0213.html){:target="_blank"}

| Metric ID        | Metric Name     | Description                                      | Value Range      | Monitored Object   | **Monitoring Period of Raw Data (Minute)** |
| ---- -------- | ----------- | -------------------------------------------- | ------------- | --------- | ---------------------- |
| `count`        | Invocations      | Number of function invocations Unit: Count           | ≥ 0 counts   | Functions       | 1                   |
| `failcount`    | Errors      | Number of invocation errors. The following errors are included:Function request error (causing an execution failure and returning error code 200). Function syntax or execution error. Unit: Count          | ≥ 0 counts   | Functions       | 1               |
| `rejectcount`        | Throttles      | Number of function throttles. That is, the number of times that FunctionGraph throttles your functions due to the resource limit. Unit: Count   | ≥ 0 counts   | Functions       | 1                  |
| `concurrency`        | Number of concurrent requests      | Maximum number of concurrent requests during function invocation. Unit: Count           | ≥ 0 counts   | Functions       | 1                |
| `reservedinstancenum`        | Number of reserved instances      | Number of reserved instances. Unit: Count           | ≥ 0 counts   | Functions       | 1                |
| `duration`        | Average duration      | Average duration of function invocation. Unit: ms          | ≥ 0 ms   | Functions       | 1                   |
| `maxDuration`        | Maximum duration      | Maximum duration of function invocation. Unit: ms          | ≥ 0 ms   | Functions       | 1                  |
| `minDuration`        | Minimum duration      | Minimum duration           | ≥ 0 ms   | Functions       | 1                   |

## Object {#object}

The collected HUAWEI CLOUD SYS.FunctionGraph object data structure can be seen from the [ Infrastructure - Custom]  object data.

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
    "strategy_config" : "{Function policy configuration}",
    "message"         : "{Instance JSON data}"
  }
}

```


> *Note: The fields in 'tags' and' fields' may change with subsequent updates*
>
> Tip 1: `tags.name` value as instance ID, it is th uniquely identify.
>
> Tip 2: `fields.last_modified`、`fields.message`、`fields.strategy_config`are all the JSON serialized strings.

