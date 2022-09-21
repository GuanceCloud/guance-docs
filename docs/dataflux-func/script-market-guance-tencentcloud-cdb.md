# 采集器「腾讯云-CDB」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'ap-shanghai'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集上海、广州地域的数据

~~~python
collector_configs = {
    'regions': [ 'ap-shanghai', 'ap-guangzhou' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "tencentcloud_cdb",
  "tags": {
    "name"         : "cdb-xxxxxxx",
    "RegionId"     : "ap-shanghai",
    "Region"       : "ap-shanghai",
    "InstanceId"   : "cdb-imxxxx",
    "InstanceName" : "smart_check_test",
    "InstanceType" : "1",
    "Zone"         : "ap-shanghai-3",
    "ZoneName"     : "",
    "DeviceType"   : "UNIVERSAL",
    "EngineVersion": "8.0",
    "Vip"          : "172.xx.x.9",
    "Status"       : "1",
    "ProtectMode"  : "0",
    "ProjectId"    : "0",
    "PayType"      : "1",
    "WanStatus"    : "0"
  },
  "fields": {
    "WanPort"     : 0,
    "Memory"      : 1000,
    "Volume"      : 25,
    "DeadlineTime": "0000-00-00 00:00:00",
    "CreateTime"  : "2022-04-27 15:18:06",
    "message"     : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下

| 字段           | 类型 | 说明                                                                             |
| -------------- | ---- | -------------------------------------------------------------------------------- |
| `ProtectMode`  | str  | 数据复制方式。<br>0 - 异步复制<br>1 - 半同步复制<br>2 - 强同步复制               |
| `InstanceType` | str  | 实例类型，可能的返回值：<br>1 - 主实例<br>2 - 灾备实例<br>3 - 只读实例           |
| `PayType`      | str  | 付费类型，可能的返回值：<br>0 - 包年包月<br>1 - 按量计费                         |
| `ProjectId`    | str  | 项目 ID                                                                          |
| `Status`       | str  | 实例状态，可能的返回值：<br>0 - 创建中<br>1 - 运行中<br>4 - 隔离中<br>5 - 已隔离 |
| `WanStatus`    | str  | 外网状态，可能的返回值为：<br>0 - 未开通外网<br>1 - 已开通外网<br>2 - 已关闭外网 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串

## X. 附录

请参考腾讯云官方文档：

- [TencentCloud-CDB 地域 ID](https://cloud.tencent.com/document/product/236/8458)
- [TencentCloud-CDB 实例详细信息说明文档](https://cloud.tencent.com/document/api/236/15878#InstanceInfo)
