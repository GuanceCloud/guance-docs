---
title: 'Huawei Cloud CBR'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics for Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.'
__int_icon: 'icon/huawei_sys_cbr'
dashboard:

  - desc: 'Built-in View for Huawei Cloud CBR'
    path: 'dashboard/en/huawei_SYS.CBR'

monitor:
  - desc: 'Monitor for Huawei Cloud CBR'
    path: 'monitor/en/huawei_SYS.CBR'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud CBR
<!-- markdownlint-enable -->

Huawei Cloud CBR (Cloud Backup and Recovery) displays metrics such as bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Expansion - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of HUAWEI SYS.CBR, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-CBR Collection)」(ID: `guance_huaweicloud_cbr`).

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create the `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}

### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」 whether the corresponding task has an automatic trigger configuration. You can also check the task records and logs to ensure there are no anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring HUAWEI SYS.CBR, the default metric set is as follows. You can collect more metrics through configuration. [Huawei Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-cbr/cbr_03_0114.html){:target="_blank"}

| Metric ID                              | Metric Name           | Metric Description                                                   | Value Range   | Measurement Object (Dimension) | **Monitoring Period (Original Metric)** |
| -------------------------------------- | --------------------- | -------------------------------------------------------------------- | ------------- | ------------------------------ | ------------------------------------------------- |
| used_vault_size                        | Storage Vault Usage   | This metric counts the storage vault usage capacity. Unit: GB.       | >=0           | Storage Vault                 | 15min                                           |
| vault_util                             | Storage Vault Utilization | This metric counts the storage vault capacity utilization.          | 0~100%        | Storage Vault                 | 15min                                            |

## Objects {#object}

The object data structure collected from HUAWEI SYS.CBR can be viewed in 「Infrastructure - Custom」

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: `fields.message`, `fields.billing`, `fields.bind_rules`, `fields.resources` are all JSON serialized strings.