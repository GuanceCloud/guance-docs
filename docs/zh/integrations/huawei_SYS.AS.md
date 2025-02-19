---
title: 'HUAWEI AS'
tags: 
  - 华为云
summary: '华为云 AS 的核心性能指标包括CPU利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。'
__int_icon: 'icon/huawei_sys_as'
dashboard:

  - desc: 'HUAWEI AS 内置视图'
    path: 'dashboard/zh/huawei_SYS.AS'

monitor:
  - desc: 'HUAWEI AS 监控器'
    path: 'monitor/zh/huawei_SYS.AS'

---

<!-- markdownlint-disable MD025 -->

# 华为云 AS
<!-- markdownlint-enable -->

华为云 AS（Auto Scaling） 的核心性能指标包括 CPU 利用率、内存使用率、磁盘I/O、网络吞吐量和系统负载等，这些都是评估和优化自动缩放系统性能的关键指标。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 HUAWEI SYS.AS 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（华为云-AS采集）」(ID：`guance_huaweicloud_as`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-cbr/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 HUAWEI SYS.AS ,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-as/as_06_0105.html){:target="_blank"}

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| cpu_util | 该指标用于统计弹性伸缩组的CPU使用率 | % | AutoScalingGroup |
| instance_num | 该指标用于统计弹性伸缩组中可用的云服务器云主机数量 | count | AutoScalingGroup |
| disk_read_bytes_rate | 该指标用于统计每秒从弹性伸缩组读出的数据量 | Byte/s | AutoScalingGroup |
| disk_write_bytes_rate | 该指标用于统计每秒写到弹性伸缩组的数据量 | Byte/s | AutoScalingGroup |
| mem_usedPercent | 该指标用于统计弹性伸缩组的（Agent）内存使用率 | % | AutoScalingGroup |
| cpu_usage | 该指标用于统计弹性伸缩组的（Agent）CPU使用率 | % | AutoScalingGroup |

## 对象 {#object}

采集到的 HUAWEI SYS.AS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
    "instance_config" : "{实例配置信息}",
    "message"         : "{实例 JSON 数据}"
  }
}

```


> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`、`fields.billing`、`fields.bind_rules`、`fields.message`、`fields.resources`、均为 JSON 序列化后字符串

