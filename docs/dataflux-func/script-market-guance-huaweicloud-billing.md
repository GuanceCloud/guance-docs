# 采集器「华为云-云账单」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

> 提示 2：为了保证数据的完整性，所采集的的账单日期为*当前日期 - 2 天*，即：**2022-07-03 00:00:00 ~ 23:59:59** 期间采集的都是 **2022-07-01** 的数据。

> 提示 3：程序已内置防重复采集处理，同一天内反复运行时，除当天第一次运行，后续执行都会自动跳过。

## 1. 配置结构

本采集器无需配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「指标」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "cloud_bill",
  "tags": {
    "product_code": "ec2",
    "product_name": "弹性云服务器"
  },
  "fields": {
    "amount"        : 0.39,
    "offical_amount": 0.39190277
  },
  "timestamp": 1657065600
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

## 3. 统计说明

|          | 上报字段          | API 返回字段              | API 字段含义                                                                                          | 说明                                                                    |
| -------- | ----------------- | ------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| 产品代码 | `product_code`    | `cloud_service_type`      | 云服务类型编码                                                                                        | `cloud_service_type`截取所得<br>如：`"hws.service.type.vpc"` —> `"vpc"` |
| 产品名称 | `product_name`    | `cloud_service_type_name` | 云服务类型名称                                                                                        |                                                                         |
| 原价     | `official_amount` | `official_amount`         | 官网价，华为云商品在官网上未叠加应用商务折扣、促销折扣等优惠的销售价格。                              | `official_amount`累加所得                                               |
| 实付金额 | `amount`          | `amount`                  | 用户使用云服务享受折扣优惠后需要支付的费用金额，包括现金券和储值卡和代金券金额，精确到小数点后 2 位。 | `amount`累加所得                                                        |
| 时间戳   | `timestamp`       | `bill_date`               | 资源消费记录的日期。格式：YYYY-MM-DD。按照东八区时间截取。                                            |                                                                         |

> 提示 ：数据统计颗粒度为 **云服务类型：cloud_service_type**；相同类型的账单消费金额会合并计算，具体可以查看下面**华为云 API 原始数据**和**脚本汇总后**的数据对比。

> 提示 2 ：华为云 API 接口指 华为云-账单管理「查询资源消费记录」接口地址可见附录。

### 华为云 API 接口原始数据

~~~json
[
  {
    "bill_date"              : "2022-xx-xx",
    "bill_type"              : 5,
    "region"                 : "cn-north-4",
    "region_name"            : "华北-北京四",
    "cloud_service_type"     : "hws.service.type.vpc",
    "cloud_service_type_name": "虚拟私有云",
    "official_amount"        : 0.02,
    "amount"                 : 0.02,
    "{其他字段}"             : "{略}"
  },
  {
    "bill_date"              : "2022-xx-xx",
    "bill_type"              : 5,
    "region"                 : "cn-north-4",
    "region_name"            : "华北-北京四",
    "cloud_service_type"     : "hws.service.type.vpc",
    "cloud_service_type_name": "虚拟私有云",
    "official_amount"        : 0.02,
    "amount"                 : 0.02,
    "{其他字段}"             : "{略}"
  },
  {
    "bill_date"              : "2022-xx-xx",
    "bill_type"              : 5,
    "region"                 : "cn-north-4",
    "region_name"            : "华北-北京四",
    "cloud_service_type"     : "hws.service.type.rds",
    "cloud_service_type_name": "云数据库",
    "official_amount"        : 0.18728888,
    "amount"                 : 0.18,
    "{其他字段}"             : "{略}"
  }
]
~~~

 ### 脚本汇总后

~~~json
[
  {
    "measurement": "cloud_bill",
    "tags": {
      "product_code": "rds",
      "product_name": "云数据库"
    },
    "fields": {
      "amount"        : 0.18,
      "offical_amount": 0.18728888
    },
    "timestamp": 1657507021
  },
  {
    "measurement": "cloud_bill",
    "tags": {
      "product_code": "vpc",
      "product_name": "虚拟私有云"
    },
    "fields": {
      "amount"        : 0.04,
      "offical_amount": 0.04
    },
    "timestamp": 1657507021
  }
]
~~~

## X. 附录

### 华为云-账单管理「查询资源消费记录」

请参考华为云官方文档：

- [华为云账单管理-查询资源消费记录](https://support.huaweicloud.com/api-oce/mbc_00004.html)
