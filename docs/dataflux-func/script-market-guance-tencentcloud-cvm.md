# 采集器「腾讯云-CVM」配置手册

阅读本文前，请先阅读：

- [观测云集成简介](https://func.guance.com/doc/func-script-market-guance-integration-intro)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域ID。如：`'ap-shanghai'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集上海、广州地域的数据

~~~python
collector_configs = {
    'regions': [ 'ap-shanghai', 'ap-guangzhou' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
    "tags": {
      "RegionId"          : "ap-shanghai",
      "InstanceId"        : "ins-bahxxxx",
      "InstanceChargeType": "POSTPAID_BY_HOUR",
      "InstanceType"      : "SA2.MEDIUM2",
      "OsName"            : "TencentOS Server 3.1 (TK4)",
      "name"              : "ins-bahxxxx"
    },
    "fields": {
      "CPU"               : 2,
      "Memory"            : 2,
      "InstanceState"     : "RUNNING",
      "PublicIpAddresses" : "{公网IP数据}",
      "PrivateIpAddresses": "{私网IP数据}",
      "SystemDisk"        : "{系统盘JSON数据}",
      "DataDisks"         : "{数据盘JSON数据}",
      "Placement"         : "{地区JSON数据}",
      "ExpiredTime"       : "2022-05-07T01:51:38Z",
      "message"           : "{实例JSON数据}"
    },
    "measurement": "tencentcloud_cvm",
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例ID，作为唯一识别

> 提示2：`fields.message`、`fields.DataDisks`、`fields.Placement`、`fields.PrivateIpAddresses`、`fields.PublicIpAddresses`、`fields.SystemDisk`、均为JSON序列化后字符串

## X. 附录

请参考腾讯云官方文档：

- [腾讯云CVM地域ID](https://cloud.tencent.com/document/api/213/15692)