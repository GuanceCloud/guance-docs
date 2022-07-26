# 采集器「阿里云-账单」配置手册
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
    "product_code": "ecs",
    "product_name": "云服务器 ECS"
  },
  "fields": {
    "amount"        : 9419.23,
    "offical_amount": 18843.258604
  },
  "timestamp": 1657507021
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

## 3. 统计说明

| 字段     | 上报字段         | 阿里云 API 返回字段 | 说明                                       |
| -------- | ---------------- | ------------------- | ------------------------------------------ |
| 产品代码 | `product_code`   | `ProductCode`       |                                            |
| 产品名称 | `product_name`   | `ProductName`       |                                            |
| 原价     | `offical_amount` | `PretaxGrossAmount` | 相同产品代码的`PretaxGrossAmount` 累加所得 |
| 应付金额 | `amount`         | `PretaxAmount`      | 相同产品代码的 `PretaxAmount` 累加所得     |
| 账单日期 | `timestamp`      | `BillingDate`       |                                            |

> 提示 ：数据统计颗粒度为 **产品代码：ProductCode**；相同类型的账单消费金额会合并计算，具体可以参考**阿里云 API 原始数据**和**脚本汇总后**的数据对比。

> 提示 2 ：为了保证数据的完整上报，采集器采集的的日期为**两天前**，比如采集器运行日期为 **2022-07-03**，采集器采集 **2022-07-01** 的数据。

> 提示 3 ：阿里云 API 接口指 阿里云-账单管理「查询资源消费记录」接口地址可见附录。

### 阿里云账单原始数据

~~~json
[
  {
    "BillingDate"      : "2022-xx-xx",
    "ProductCode"      : "oss",
    "ProductName"      : "块存储",
    "PretaxAmount"     : 0.12,
    "PretaxGrossAmount": 0.22,
    "{其他字段}"       : "{略}"
  },
  {
    "BillingDate"      : "2022-xx-xx",
    "ProductCode"      : "oss",
    "ProductName"      : "块存储",
    "PretaxAmount"     : 0.22,
    "PretaxGrossAmount": 0.32,
    "{其他字段}"       : "{略}"
  },
  {
    "BillingDate"      : "2022-xx-xx",
    "ProductCode"      : "snapshot",
    "ProductName"      : "块存储",
    "PretaxAmount"     : 0.02,
    "PretaxGrossAmount": 0.02,
    "{其他字段}"       : "{略}"
  }
]
~~~

### 脚本汇总后

~~~json
[
  {
    "measurement": "cloud_bill",
    "tags": {
      "product_code": "oss",
      "product_name": "块存储"
    },
    "fields": {
      "amount"        : 0.34,
      "offical_amount": 0.54
    },
    "timestamp": 1657507021
  },
  {
    "measurement": "cloud_bill",
    "tags": {
      "product_code": "snapshot",
      "product_name": "块存储"
    },
    "fields": {
      "amount"        : 0.02,
      "offical_amount": 0.02
    },
    "timestamp": 1657507021
  }
]
~~~

## 附录

### 阿里云-账单管理「查询实例账单服务」

- [阿里云账单管理-查询实例账单服务](https://help.aliyun.com/document_detail/209402.html)