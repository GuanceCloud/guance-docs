---
title: 'HUAWEI AS'
tags: 
  - Huawei Cloud
summary: 'The core performance metrics of HUAWEI AS on Huawei Cloud include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system.'
__int_icon: 'icon/huawei_sys_as'
dashboard:

  - desc: 'Built-in View for HUAWEI AS'
    path: 'dashboard/en/huawei_SYS.AS'

monitor:
  - desc: 'HUAWEI AS Monitor'
    path: 'monitor/en/huawei_SYS.AS'

---

<!-- markdownlint-disable MD025 -->

# Huawei Cloud AS
<!-- markdownlint-enable -->

The core performance metrics of Huawei Cloud AS (Auto Scaling) include CPU utilization, memory usage, disk I/O, network throughput, and system load. These are key indicators for evaluating and optimizing the performance of an auto-scaling system.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func independently, refer to [Independent Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from HUAWEI SYS.AS, install the corresponding collection script: 「Guance Integration (Huawei Cloud-AS Collection)」(ID: `guance_huaweicloud_as`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can check the execution task records and corresponding logs.

We default to collecting some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}



### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」that the corresponding tasks have been configured for automatic triggers. You can also check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, verify if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data is present.

## Metrics {#metric}
After configuring HUAWEI SYS.AS, the default metric set is as follows. More metrics can be collected through configuration. [Details of Huawei Cloud Monitoring Metrics](https://support.huaweicloud.com/usermanual-as/as_06_0105.html){:target="_blank"}

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| cpu_util | This metric tracks the CPU utilization of the auto-scaling group | % | AutoScalingGroup |
| instance_num | This metric tracks the number of available cloud servers in the auto-scaling group | count | AutoScalingGroup |
| disk_read_bytes_rate | This metric tracks the amount of data read per second from the auto-scaling group | Byte/s | AutoScalingGroup |
| disk_write_bytes_rate | This metric tracks the amount of data written per second to the auto-scaling group | Byte/s | AutoScalingGroup |
| mem_usedPercent | This metric tracks the (Agent) memory utilization of the auto-scaling group | % | AutoScalingGroup |
| cpu_usage | This metric tracks the (Agent) CPU utilization of the auto-scaling group | % | AutoScalingGroup |

## Objects {#object}

The structure of the collected HUAWEI SYS.AS object data can be viewed under 「Infrastructure - Custom」

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
> Tip 2: `fields.message`, `fields.billing`, `fields.bind_rules`, `fields.message`, and `fields.resources` are all JSON serialized strings.