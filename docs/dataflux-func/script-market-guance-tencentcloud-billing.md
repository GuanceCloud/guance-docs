# 采集器「腾讯云-账单」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

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
    "product_code": "clb",
    "product_name": "负载均衡 CLB "
  },
  "fields": {
    "amount"        : 0.82733567,
    "offical_amount": 0.82733567
  },
  "timestamp": 1657507837
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

## 3. 统计说明

|          | 上报字段         | API 返回字段                            | 说明                                               |
| -------- | ---------------- | --------------------------------------- | -------------------------------------------------- |
| 产品代码 | `product_code`   | `BusinessCode`                          | `BusinessCode`截取所得<br>如：`"p_clb"` -> `"clb"` |
| 产品名称 | `product_name`   | `BusinessCodeName`                      |                                                    |
| 原价     | `offical_amount` | `ComponentSet.Cost`                     |                                                    |
| 实付金额 | `amount`         | `CashPayAmount`<br>+ `VoucherPayAmount` | 现金支付<br>+ 代金劵支付                           |
| 时间戳   | `timestamp`      | 账单日期                                |                                                    |

> 提示 ：数据统计颗粒度为 **产品名称代码：BusinessCode**；

> 提示 2 ：产品名称代码相同的消费金额会合并计算，一个产品可能对应多个组件 (**ComponentSet**)，所以需要把组件全部累加在一起在进行赋值，具体可以查看下面**腾讯云 API 原始数据**和**脚本汇总后**的数据对比。

> 提示 3 ：腾讯云 API 接口指 腾讯云-账单管理「查询账单明细数据 」接口地址可见附录。

### 腾讯云查询账单明细数据（DescribeBillDetail）接口返回数据

~~~json
[
  {
    "BusinessCodeName": "负载均衡 CLB",
    "BusinessCode"    : "p_clb",
    "ComponentSet": [
      {
        "Cost"            : "0.20000000",
        "VoucherPayAmount": "0",
        "CashPayAmount"   : "0.20000000",
        "{其他字段}"      : "{略}"
      },
      {
        "Cost"            : "0.10000000",
        "VoucherPayAmount": "0",
        "CashPayAmount"   : "0.10000000",
        "{其他字段}"      : "{略}"
      }
    ]
  },
  {
    "BusinessCodeName": "负载均衡 CLB",
    "BusinessCode"    : "p_clb",
    "ComponentSet": [
      {
        "Cost"            : "0.10000000",
        "VoucherPayAmount": "0",
        "CashPayAmount"   : "0.10000000",
        "{其他字段}"      : "{略}"
      },
      {
        "Cost"            : "0.30000000",
        "VoucherPayAmount": "0",
        "CashPayAmount"   : "0.30000000",
        "{其他字段}"      : "{略}"
      }
    ]
  }
]
~~~

### 脚本汇总后

~~~json
[
  {
    "measurement": "cloud_bill",
    "tags": {
      "product_code": "clb",
      "product_name": "负载均衡 CLB"
    },
    "fields": {
      "amount"        : 0.7,
      "offical_amount": 0.7
    },
    "timestamp": 1657507837
  }
]
~~~

## X. 附录

### 腾讯云-账单管理 「查询账单明细数据」

请参考腾讯云官方文档：

- [TencentCloud-billing 查询账单明细数据接口文档](https://cloud.tencent.com/document/product/555/19182)
