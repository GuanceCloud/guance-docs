# 获取空间账单对应周期账单信息

---

<br />**GET /api/v1/billing/detail/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| startDate | string |  | 账单开始日期 格式: 20230731<br>例子: 20230731 <br>允许为空: False <br> |
| endDate | string |  | 账单结束日期 格式：20230731<br>例子: 20230731 <br>允许为空: False <br> |

## 参数补充说明

返回参数说明:

**`content`主体结构说明**

|  参数名                |   参数说明  |
|-----------------------|----------|
|consumeTimeOfDay       |账单消费时间 |
|orgName                |费用中心组织名称  可忽略 |
|productName            |产品名称  固定dataFlux |
|productDetail          |产品明细 |
|billingCycle           |结算周期  按天、按月、按年、单次  Day、Month、Year、Single |
|billingResult          |应付 |
|deductionAmount        |扣款金额 |
|oweAmount              |欠费金额 |
|originAmount           |原价 |
|serviceBillingAmount   |服务费 可忽略 |
|couponAmount           |代金券扣款 |
|storedCardAmount       |储值卡扣款     |
|cashAmount             |现金扣款    |
|cashCouldAmount        |云市场扣款    |
|commodityCategory      |产品类型  包年包月、按量付费    |
|consumePlatform        |结算方式   |
|customerIdentifier     |云市场的账号   |
|consumption            |可忽略   |
|workspaceUuid          |工作空间uuid   |
|workspaceName          |工作空间名称   |
|consumeTime            |消费时间时间戳   |
|tag6                   |计量名称   |
|billingResultDetails   |可忽略   |
|count                  |使用量   |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/billing/detail/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "consumeTimeOfDay": "2023-07-31",
            "orgName": "None",
            "productName": "None",
            "productDetail": "会话重放",
            "billingCycle": "None",
            "billingResult": 0,
            "deductionAmount": "None",
            "oweAmount": "None",
            "originAmount": 0,
            "serviceBillingAmount": "None",
            "couponAmount": "None",
            "storedCardAmount": "None",
            "cashAmount": "None",
            "cashCouldAmount": "None",
            "commodityCategory": "None",
            "consumePlatform": "None",
            "customerIdentifier": "None",
            "consumption": "None",
            "workspaceUuid": "None",
            "workspaceName": "None",
            "consumeTime": "None",
            "tag6": "session_replay",
            "billingResultDetails": "None",
            "count": 0
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-192EB1B1-ACBA-4942-A4F1-34A1A9F93C0C"
} 
```




