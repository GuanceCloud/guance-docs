# Get Current Account Balance

---

<br />**GET /api/v1/billing/balance/get**

## Overview




## Additional Parameter Description

Return parameter description:

**Key Fields**

| Parameter Name                | Description          |
|-----------------------|----------------|
|cashBalance            | Cash account balance |
|couponBalance          | Coupon balance |
|storedCardBalance      | Stored card balance |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/billing/balance/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
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