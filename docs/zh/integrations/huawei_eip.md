---
title: '华为云 EIP'
tags:
  - 华为云
summary: '采集华为云 EIP 指标数据'
__int_icon: 'icon/huawei_eip'
dashboard:
  - desc: '华为云 EIP 内置视图'
    path: 'dashboard/zh/huawei_eip/'

monitor:
  - desc: '华为云 EIP 监控器'
    path: 'monitor/zh/huawei_eip/'
---

采集 华为云 EIP 指标数据。

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 EIP 监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（华为云-EIP采集）」(ID：`guance_huaweicloud_eip`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-EIP 采集）」，展开修改此脚本，找 `collector_configs` 和 `monitor_configs` 分别编辑下面 `region_projects` 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集华为云 EIP 指标, 可以通过配置的方式采集更多的指标 [华为云 EIP 指标详情](https://support.huaweicloud.com/usermanual-vpc/vpc010012.html){:target="_blank"}

|   **指标ID**  |   **指标名称**   |  **指标含义** |  **取值范围**  | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `upstream_bandwidth`            |   出网带宽    |该指标用于统计测试对象出云平台的网络速度（原指标为上行带宽）。单位：比特/秒   | ≥ 0 bit/s  | 带宽或弹性公网IP | 1分钟             |
| `downstream_bandwidth`            |   入网带宽    |该指标用于统计测试对象入云平台的网络速度（原指标为下行带宽）。单位：比特/秒   | ≥ 0 bit/s  | 带宽或弹性公网IP | 1分钟             |
| `upstream_bandwidth_usage`            |   出网带宽使用率    |该指标用于统计测量对象出云平台的带宽使用率，以百分比为单位。出网带宽使用率=出网带宽指标/购买的带宽大小   | 0-100%  | 带宽或弹性公网IP | 1分钟             |
| `downstream_bandwidth_usage`            |   入网带宽使用率   |该指标用于统计测量对象入云平台的带宽使用率，以百分比为单位。入网带宽使用率=入网带宽指标/购买的带宽大小   | 0-100%  | 带宽或弹性公网IP | 1分钟             |
| `up_stream`            |   出网流量    |该该指标用于统计测试对象出云平台一分钟内的网络流量累加值（原指标为上行流量）。单位：字节  | ≥ 0 bytes  | 带宽或弹性公网IP    | 1分钟        |
| `down_stream`          |   入网流量    |该指标用于统计测试对象入云平台一分钟内的网络流量累加值（原指标为下行流量）。单位：字节   | ≥ 0 bytes  | 带宽或弹性公网IP | 1分钟            |

## 对象 {#object}

数据正常同步后，可以在<<< custom_key.brand_name >>>的「基础设施 - 资源目录」中查看数据。

```json
{
  "measurement": "huaweicloud_eip",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17e4049b2a16ea41912e52d",
    "enterprise_project_id"   : "0824ss-xxxx-xxxx-xxxx-12334fedffg",
    "alias"                   : "xxxxxx",
    "eip_id"                  : "01fbb835-6b7f-41e9-842c-xxxxx0bc0s49e9",
    "eip_name"                : "xxxx",
    "public_ip_address"       : "123.xx.xx.210",
    "public_ipv6_address"     : "3773b058-5b4f-xxxx-9035-9bbd9964714a",
    "status"                  : "DOWN",
    "associate_instance_type" : "EVPN",
    "associate_instance_id"   : "053xxx-xxx-41xx-b24d-909ed9fcbfe1",
  },
  "fields": {
    "type"            : "EIP",
    "description"     : "VPN CREATE EIP",
    "created_at"      : "2024-11-09T15:28:46",
    "updated_at"      : "2024-11-11T08:15:58Z",
    "bandwidth"       : "{JSON 数据}",
    "tags"            : "[]"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.eip_id`值为EIP ID，作为唯一识别
>
> 提示 2：`status`为VPC对应的状态
>
