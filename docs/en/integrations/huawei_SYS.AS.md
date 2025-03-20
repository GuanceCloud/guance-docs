---
title: 'HUAWEI AS'
tags: 
  - Huawei Cloud
summary: 'The key performance Metrics of HUAWEI AS include CPU utilization, memory usage, disk I/O, network throughput, and system load, all of which are critical Metrics for evaluating and optimizing the performance of an auto-scaling system.'
__int_icon: 'icon/huawei_sys_as'
dashboard:

  - desc: 'HUAWEI AS built-in views'
    path: 'dashboard/en/huawei_SYS.AS'

monitor:
  - desc: 'HUAWEI AS monitors'
    path: 'monitor/en/huawei_SYS.AS'

---

<!-- markdownlint-disable MD025 -->

# Huawei Cloud AS
<!-- markdownlint-enable -->

The core performance Metrics of Huawei Cloud AS (Auto Scaling) include CPU utilization, memory usage, disk I/O, network throughput, and system load, all of which are critical Metrics for evaluating and optimizing the performance of an auto-scaling system.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize HUAWEI SYS.AS monitoring data, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-AS Collection)」(ID: `guance_huaweicloud_as`).

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can check the execution task records and corresponding logs.

We default collect some configurations, details are shown in the Metrics section.

[Configure custom cloud object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}



### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also view the corresponding task records and log checks for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring HUAWEI SYS.AS, the default Measurement set is as follows. More Metrics can be collected via configuration. [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-as/as_06_0105.html){:target="_blank"}

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| cpu_util | This Metric is used to count the CPU usage rate of the auto-scaling group | % | AutoScalingGroup |
| instance_num | This Metric is used to count the number of available cloud servers in the auto-scaling group | count | AutoScalingGroup |
| disk_read_bytes_rate | This Metric is used to count the amount of data read from the auto-scaling group per second | Byte/s | AutoScalingGroup |
| disk_write_bytes_rate | This Metric is used to count the amount of data written to the auto-scaling group per second | Byte/s | AutoScalingGroup |
| mem_usedPercent | This Metric is used to count the (Agent) memory usage rate of the auto-scaling group | % | AutoScalingGroup |
| cpu_usage | This Metric is used to count the (Agent) CPU usage rate of the auto-scaling group | % | AutoScalingGroup |

## Objects {#object}

The collected HUAWEI SYS.AS object data structure can be seen in 「Infrastructure - Custom」

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
> Tip 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
>
> Tip 2: `fields.message`, `fields.billing`, `fields.bind_rules`, `fields.message`, `fields.resources`, are all JSON serialized strings.