---
title: 'HUAWEI SYS.CBR'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
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

HUAWEI SYS.CBR，包括存储库使用量、存储库使用率。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 HUAWEI SYS.CBR 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-CBR采集）」(ID：`guance_huaweicloud_cbr`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 HUAWEI SYS.CBR ,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-cbr/cbr_03_0114.html){:target="_blank"}

| 指标ID                                | 指标名称             | 指标含义                                                     | 取值范围      | 测量对象（维度） | **监控周期（原始指标）** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| used_vault_size                       | 存储库使用量            | 该指标用于统计存储库使用容量。单位：GB。                       | >=0           | 存储库          | 15min                                           |
| vault_util                            | 存储库使用率         | 该指标用于统计存储库容量使用率。                                | 0~100%          | 存储库          | 15min                                            |

## 对象 {#object}

采集到的 HUAWEI SYS.CBR 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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


> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`、`fields.billing`、`fields.bind_rules`、`fields.message`、`fields.resources`、均为 JSON 序列化后字符串

