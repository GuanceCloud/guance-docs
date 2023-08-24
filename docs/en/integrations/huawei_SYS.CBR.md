---
title: 'HUAWEI SYS.CBR'
summary: 'Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_SYS.CBR'
dashboard:

  - desc: 'HUAWEI SYS.CBR 内置视图'
    path: 'dashboard/zh/huawei_SYS.CBR'

monitor:
  - desc: 'HUAWEI SYS.CBR 监控器'
    path: 'monitor/zh/huawei_SYS.CBR'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI SYS.CBR
<!-- markdownlint-enable -->

HUAWEI SYS.CBR includes metrics such as repository usage and repository utilization.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Huawei AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI SYS.CBR, we install the corresponding collection script：「观测云集成（华为云-CBR采集）」(ID：`guance_huaweicloud_cbr`)

Click 【Install】 and enter the corresponding parameters: Huawei AK, Huawei account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI SYS.CBR monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Huawei CloudMonitor Metrics Details](https://support.huaweicloud.com/intl/en-us/usermanual-cbr/cbr_03_0114.html){:target="_blank"}

| Indicator ID                       | Index name                                               | Indicator meaning                                                      | Value range    | Measurement object (dimension)         | Monitoring cycle (raw metrics) |
|------------------------------------|----------------------------------------------------------| ------------------------------------------------------------ | ---------- | ---------------- | -------------------- |
| used_vault_size                       | Used Vault Size            | Used capacity of the vault. Unit: GB.                       | >=0           | Vault          | 15min                                           |
| vault_util                            | Vault Usage         | Capacity usage of the vault.                                | 0~100%          | Vault          | 15min                                            |

## Object {#object}

The collected Huawei Cloud OBS object data structure can see the object data from 「基础设施-自定义」

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
    "billing"     : "{运营信息}",
    "bind_rules"  : "{绑定规则}",
    "resources"   : "{存储库资源}",
    "created_at"  : "2023-07-24Txx : xx : xx.936999",
    "threshold"   : 80,
    "message"     : "{实例 JSON 数据}"
  }
}

```


> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value serves as the instance ID for unique identification
>
> Tips 2：`fields.message`、`fields.billing`、`fields.bind_rules`、`fields.message`、`fields.resources`、are all JSON-serialized string representations.

