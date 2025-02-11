---
title: 'Huawei Cloud CBR'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics of Huawei Cloud CBR include bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.'
__int_icon: 'icon/huawei_sys_cbr'
dashboard:

  - desc: 'Built-in views for Huawei Cloud CBR'
    path: 'dashboard/en/huawei_SYS.CBR'

monitor:
  - desc: 'Monitors for Huawei Cloud CBR'
    path: 'monitor/en/huawei_SYS.CBR'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud CBR
<!-- markdownlint-enable -->

Huawei Cloud CBR (Cloud Backup and Recovery) displays metrics such as bandwidth utilization, latency, packet loss rate, and network throughput. These metrics reflect the performance and quality assurance of CBR in network transmission and bandwidth management.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from HUAWEI SYS.CBR, we install the corresponding collection script: "Guance Integration (Huawei Cloud-CBR Collection)" (ID: `guance_huaweicloud_cbr`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}

### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」that the corresponding automatic trigger configuration exists for the task and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring HUAWEI SYS.CBR, the default metric set is as follows. You can collect more metrics by configuring them. [Huawei Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-cbr/cbr_03_0114.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object (Dimension) | **Monitoring Period (Original Metric)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| used_vault_size                       | Vault Usage           | This metric counts the storage vault usage capacity. Unit: GB.                       | >=0           | Storage Vault          | 15min                                           |
| vault_util                            | Vault Utilization     | This metric counts the storage vault capacity utilization rate.                                | 0~100%          | Storage Vault          | 15min                                            |

## Objects {#object}

The collected HUAWEI SYS.CBR object data structure can be viewed under 「Infrastructure - Custom」

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
> Tip 2: `fields.message`, `fields.billing`, `fields.bind_rules`, `fields.resources`, are all serialized JSON strings.