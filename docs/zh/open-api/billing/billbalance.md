# 获取当前账户余额

---

<br />**GET /api/v1/billing/balance/get**

## 概述




## 参数补充说明

返回参数说明:

**关键字段**

|  参数名                |   参数说明  |
|-----------------------|----------|
|cashBalance            |现金账户余额 |
|couponBalance          |代金券余额 |
|storedCardBalance      |储值卡余额 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/billing/balance/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "cashBalance": 9997322516.42,
        "couponBalance": 0.0,
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        },
        "storedCardBalance": 0.0
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0F20FE10-7E05-4AFE-8B87-DCABF419362D"
} 
```




