---
title: '华为云 ELB'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_elb'
dashboard:

  - desc: '华为云 ELB 内置视图'
    path: 'dashboard/zh/huawei_elb'

monitor:
  - desc: '华为云 ELB 监控器'
    path: 'monitor/zh/huawei_elb'

---

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（华为云-云监控采集）」(ID：`guance_huaweicloud_ces`)
- 「观测云集成（华为云-ELB采集）」(ID：`guance_huaweicloud_elb)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html){:target="_blank"}

## 对象 {#object}

采集到的华为云 ELB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "huaweicloud_elb",
  "tags": {
    "name"            : "e9cb54b0-63e0-46c5xxxxxxxx",
    "description"     : "",
    "id"              : "e9cb54b0-63e0-46c5xxxxxxxxxx",
    "RegionId"        : "cn-north-4",
    "instance_name"   : "elb-xxxx",
    "operating_status": "ONLINE",
    "project_id"      : "c631f046252d4ebdaxxxxxxxxxx"
  },
  "fields": {
    "created_at": "2022-06-22T02:41:57",
    "listeners" : "{实例 JSON 数据}",
    "updated_at": "2022-06-22T02:41:57",
    "message"   : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - fields.message`、`fields.listeners`为 JSON 序列化后字符串。
> - `tags.operating_status`为负载均衡器的操作状态。取值范围：可以为 ONLINE 和 FROZEN。

