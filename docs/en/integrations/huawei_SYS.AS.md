---
title: 'HUAWEI SYS.AS'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/huawei_SYS.AS'
dashboard:

  - desc: 'HUAWEI CLOUD SYS.AS Dashboard'
    path: 'dashboard/zh/huawei_SYS.AS'

monitor:
  - desc: 'HUAWEI CLOUD SYS.AS Monitor'
    path: 'monitor/zh/huawei_SYS.AS'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD SYS.AS
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD SYS.CBR, we install the corresponding collection script：「Guance Integration (HUAWEI CLOUD AS Collect)」(ID：`guance_huaweicloud_as`)

Click [Install] and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap[Deploy startup Script],The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click [Run],you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD SYS.CBR monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-as/as_06_0105.html){:target="_blank"}

| Metric Name | Descriptive | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| cpu_util | This metric is used to count the CPU utilization of the elastic scaling group | % | AutoScalingGroup |
| instance_num | This metric is used to count the number of cloud servers cloud hosts available in an elastic scaling group | count | AutoScalingGroup |
| disk_read_bytes_rate | This metric is used to count the amount of data read from the elastic scaling group per second | Byte/s | AutoScalingGroup |
| disk_write_bytes_rate | This metric is used to count the amount of data written to the elastic scaling group per second | Byte/s | AutoScalingGroup |
| mem_usedPercent | This metric is used to count the (Agent) memory utilization of the elastic scaling group | % | AutoScalingGroup |
| cpu_usage | This metric is used to count the (Agent) CPU utilization of the elastic scaling group | % | AutoScalingGroup |

## Object {#object}

AS object data structure collected, you can see the object data from "Infrastructure-Customize".

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
    "instance_config" : "{Instance Configuration Information}",
    "message"         : "{Instance JSON data}"
  }
}

```

> *notice：`tags`,`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value serves as the instance ID for unique identification
>
> Tips 2：`fields.message`,`fields.billing`,`fields.bind_rules`,`fields.message`,`fields.resources`,are all JSON-serialized string representations.

