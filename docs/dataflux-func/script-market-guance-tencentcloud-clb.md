# 采集器「腾讯云-CLB」配置手册

阅读本文前，请先阅读：

- [观测云集成简介](https://func.guance.com/doc/func-script-market-guance-integration-intro)

提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域ID。如：`'ap-shanghai'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集上海、广州地域的数据

```python
collector_configs = {
    'regions': [ 'ap-shanghai', 'ap-guangzhou' ]
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_clb",
  "tags": {
    "name"			  : "lb-xxxx",
    "RegionId"		  : "ap-shanghai",
    "LoadBalancerId"  : "lb-xxxx",
    "LoadBalancerName": "lb-xxxx",
    "Address"		  : "81.xxxx",
    "LoadBalancerType": "Public",    // 负载均衡实例的网络类型：Public：公网属性， Private：内网属性。
    "Status"		  : "1",         // 负载均衡实例的状态，包括0：创建中，1：正常运行。
    "VpcId"			  : "vpc-xxxx",
	"Zone"			  : "ap-shanghai-3",
    "ChargeType"	  : "POSTPAID_BY_HOUR"
  },
  "fields": {
    "CreateTime"	  : "2022-04-27 15:19:49",
    "listeners" 	  : "{监听器JSON数据}",
    "message"		  : "{实例JSON数据}"
  }
}
```

*注意：*`*tags*`*、*`*fields*`*中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 值作为唯一识别

> 提示2：`fields.message` 为JSON序列化后字符串

## X. 附录

请参考腾讯云官方文档：

- [地域和可用区](https://cloud.tencent.com/document/api/214/30670#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)
- [负载均衡CLB](https://cloud.tencent.com/document/api/214/30685)