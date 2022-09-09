# 采集器「阿里云-ALB」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                   |
| ------------ | ---- | -------- | -------------------------------------- |
| `regions`    | list | 必须     | 所需采集的 alb 地域列表                |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-hangzhou'`总表见附录 |

## 2. 配置示例

```python
aliyun_alb_configs = {
    'regions': [ 'cn-hangzhou' ],
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
  {
    "measurement": "aliyun_alb",
    "tags": {
      "name"                       : "alb-xxxxxx",
      "AddressType"                : "Intranet",
      "DNSName"                    : "alb-xxxxxx.internal.cn-hangzhou.alb.aliyuncs.com",
      "LoadBalancerBussinessStatus": "Normal",
      "LoadBalancerEdition"        : "Standard",
      "LoadBalancerId"             : "alb-xxxxxx",
      "LoadBalancerName"           : "dataway-xxx",
      "LoadBalancerStatus"         : "Active",
      "PayType"                    : "PostPay",
      "VpcId"                      : "vpc-xxxxxx"
    },
    "fields": {
      "CreateTime": "2021-07-27T09:15:07Z",
      "message"   : "{实例 JSON 数据}",
    },
  }
```

部分字段说明如下，具体可看附录接口返回参数

| 字段                  | 类型   | 说明                                                                                                                            |
| --------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| `AddressType`         | String | 负载均衡的地址类型<br>Fixed：固定 IP 模式<br>Dynamic：动态 IP 模式                                                              |
| `PayType`             | String | 计费类型<br>PostPay：按量计费                                                                                                   |
| `LoadBalancerEdition` | String | 负载均衡的版本<br>Basic：基础班<br>Standard：标准版<br>StandardWithWaf：WAF 增强版                                              |
| `LoadBalancerStatus`  | String | 负载均衡实例状态<br>Inactive：已停止<br>Active：运行中<br>Provisioning：创建中<br>Configuring：变配中<br>CreateFailed：创建失败 |

*注意：*`*tags*`*、*`*fields*`*中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 值为实例 ID，作为唯一识别

> 提示 2：`fields.message` 为 JSON 序列化后字符；

## X. 附录

请参考阿里云官方文档：

- [阿里云 ALB](https://help.aliyun.com/document_detail/196881.html)
- [支持的地域列表](https://help.aliyun.com/document_detail/141033.html)