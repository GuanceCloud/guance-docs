---
title: 'Huawei Cloud CBR'
tags: 
  - Huawei Cloud
summary: 'The displayed Metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These Metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.'
__int_icon: 'icon/huawei_sys_cbr'
dashboard:

  - desc: 'Built-in views of Huawei Cloud CBR'
    path: 'dashboard/en/huawei_SYS.CBR'

monitor:
  - desc: 'Monitor for Huawei Cloud CBR'
    path: 'monitor/en/huawei_SYS.CBR'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud CBR
<!-- markdownlint-enable -->

The displayed Metrics for Huawei Cloud CBR (Cloud Backup and Recovery) include bandwidth utilization, latency, packet loss rate, and network throughput. These Metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of HUAWEI SYS.CBR, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-CBR Collection)」(ID: `guance_huaweicloud_cbr`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the task execution records and corresponding logs.

We default collect some configurations, details are shown in the Metrics section.

[Configure custom cloud object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}



### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring HUAWEI SYS.CBR, the default Measurement set is as follows, and more Metrics can be collected through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-cbr/cbr_03_0114.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measured Object (Dimension) | **Monitoring Cycle (Raw Metrics)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| used_vault_size                       | Vault Usage            | This metric is used to count the vault usage capacity. Unit: GB.                       | >=0           | Vault          | 15min                                           |
| vault_util                            | Vault Utilization Rate | This metric is used to count the vault capacity utilization rate.                                | 0~100%          | Vault          | 15min                                            |

## Objects {#object}

The collected HUAWEI SYS.CBR object data structure can be seen in the object data from 「Infrastructure - Custom」

``` json
{
  "measurement": "huaweicloud_cbr",
  "tags": {
    "RegionId"    : "cn-north-4",
    "id"          : "aa5f3e93-0cea-404c-xxxx-3eec40142e0d",
    "name"        : "aa5f3e93-0cea-404c-xxxx-3eec40142e0d",
    "project_id"  : "c631f046252d4xxxxxx45f253c62d48585",
    "provider_id" : "0dxxxxxxc5-6707-4851-xxxx-169e36266b66",
    "user_id"     : "6bb90c6e26624ae5b1dxxxxxx2f89e3a64",
    "vault_name"  : "vault-aba3"
  },
  "fields": {
    "auto_bind"   : false,
    "auto_expand" : false,
    "billing"     : "{Operational Information}",
    "bind_rules"  : "{Binding Rules}",
    "resources"   : "{Vault Resources}",
    "created_at"  : "2023-07-24Txx : xx : xx.936999",
    "threshold"   : 80,
    "message"     : "{Instance JSON Data}"
  }
}

```


> *Note: The fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: `fields.message`, `fields.billing`, `fields.bind_rules`, `fields.message`, `fields.resources` are all strings serialized after JSON serialization.