---
title: 'HUAWEI AS'
tags: 
  - Huawei Cloud
summary: 'The core performance metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system.'
__int_icon: 'icon/huawei_sys_as'
dashboard:

  - desc: 'Built-in views for HUAWEI AS'
    path: 'dashboard/en/huawei_SYS.AS'

monitor:
  - desc: 'HUAWEI AS monitors'
    path: 'monitor/en/huawei_SYS.AS'

---

<!-- markdownlint-disable MD025 -->

# Huawei Cloud AS
<!-- markdownlint-enable -->

Huawei Cloud AS (Auto Scaling) core performance metrics include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of HUAWEI SYS.AS, we install the corresponding collection script: "Guance Integration (Huawei Cloud-AS Collection)" (ID: `guance_huaweicloud_as`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We default to collecting some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration. You can also view the task records and logs to check for any anomalies.
2. On the Guance platform, go to "Infrastructure / Custom" to check if asset information exists.
3. On the Guance platform, go to "Metrics" to check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring HUAWEI SYS.AS, the default metric set is as follows. More metrics can be collected through configuration. [Huawei Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-as/as_06_0105.html){:target="_blank"}

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| cpu_util | This metric measures the CPU utilization of the auto-scaling group | % | AutoScalingGroup |
| instance_num | This metric counts the number of available cloud servers in the auto-scaling group | count | AutoScalingGroup |
| disk_read_bytes_rate | This metric measures the amount of data read per second from the auto-scaling group | Byte/s | AutoScalingGroup |
| disk_write_bytes_rate | This metric measures the amount of data written per second to the auto-scaling group | Byte/s | AutoScalingGroup |
| mem_usedPercent | This metric measures the (Agent) memory utilization of the auto-scaling group | % | AutoScalingGroup |
| cpu_usage | This metric measures the (Agent) CPU utilization of the auto-scaling group | % | AutoScalingGroup |

## Objects {#object}

The structure of the collected HUAWEI SYS.AS object data can be viewed in "Infrastructure - Custom".

``` json
{
  "measurement": "huaweicloud_as",
  "tags": {
    "name"                       : "c4dec56f-96b0-40f4-b47d-ab0cdc47e908",
    "scaling_configuration_id"   : "c4dec56f-96b0-40f4-b47d-ab0cdc47e908",
    "scaling_configuration_name" : "as-config-cdec",
    "scaling_group_id"           : "da854ab8-bd88-4757-a35a-135c7c3d526d"
  },
  "fields": {
    "created_time"    : "2022-06-21T06:17:27+0000",
    "instance_config" : "{Instance configuration information}",
    "message"         : "{Instance JSON data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.message`, `fields.billing`, `fields.bind_rules`, `fields.message`, `fields.resources` are all JSON serialized strings.