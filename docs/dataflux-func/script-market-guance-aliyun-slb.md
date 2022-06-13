# 采集器「阿里云-SLB」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](https://docs.guance.com/dataflux-func/script-market-guance-integration-intro)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集杭州、上海地域的数据

~~~python
collector_configs = {
    'regions': [ 'cn-hangzhou', 'cn-shanghai' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_slb",
  "tags": {
    "name"              : "lb.xxxxxxxx",
    "LoadBalancerId"    : "lb.xxxxxxxxx",
    "RegionId"          : "cn-shanghai",
    "SlaveZoneId"       : "cn-shanghai-i",
    "MasterZoneId"      : "cn-shanghai",
    "Address"           : "172.xxx.xxx.xxx",
    "PayType"           : "PayOnDemand",
    "InternetChargeType": "paybytraffic",
    "LoadBalancerName"  : "业务系统"
  },
  "fields": {
    "CreateTime"              : "2020-11-18T08:47:11Z",
    "ListenerPortsAndProtocol": "{监听端口JSON数据}",
    "Bandwidth"               : "5120",
    "message"                 : "{实例JSON数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例ID，作为唯一识别

> 提示2：`fields.message`、`fields.ListenerPortsAndProtocol`均为JSON序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [云数据库SLB地域ID](https://help.aliyun.com/document_detail/85983.html?spm=5176.21213303.J_6704733920.12.bcab53c9JARbCy&scm=20140722.S_help%40%40%E6%96%87%E6%A1%A3%40%4085983.S_os%2Bhot.ID_85983-RL_%E5%9C%B0%E5%9F%9FID-LOC_helpmain-OR_ser-V_2-P0_1#section-pl6-nn0-clk)
