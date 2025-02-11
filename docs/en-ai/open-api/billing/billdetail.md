# Get Workspace Billing Information for Specific Period

---

<br />**GET /api/v1/billing/detail/list**

## Overview



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:----------------|:-------|:-----|:----------------|
| startDate | string | Yes | Billing start date Format: 20230731<br>Example: 20230731 <br>Can be empty: False <br> |
| endDate | string | Yes | Billing end date Format: 20230731<br>Example: 20230731 <br>Can be empty: False <br> |

## Additional Parameter Explanation

Response parameter explanation:

**`content` main structure explanation**

| Parameter Name                | Parameter Description  |
|-----------------------|----------|
|consumeTimeOfDay       |Billing consumption time |
|orgName                |Organization name of the billing center (can be ignored)  |
|productName            |Product name Fixed as dataFlux |
|productDetail          |Product details |
|billingCycle           |Billing cycle Day, Month, Year, Single |
|billingResult          |Amount due |
|deductionAmount        |Deduction amount |
|oweAmount              |Unpaid amount |
|originAmount           |Original price |
|serviceBillingAmount   |Service Charges (can be ignored) |
|couponAmount           |Coupon deduction |
|storedCardAmount       |Stored card deduction     |
|cashAmount             |Cash deduction    |
|cashCouldAmount        |Cloud market deduction    |
|commodityCategory      |Product type Annual subscription, Pay-as-you-go    |
|consumePlatform        |Billing method   |
|customerIdentifier     |Cloud market account   |
|consumption            |Can be ignored   |
|workspaceUuid          |Workspace UUID   |
|workspaceName          |Workspace name   |
|consumeTime            |Consumption timestamp   |
|tag6                   |Measurement name   |
|billingResultDetails   |Can be ignored   |
|count                  |Usage   |


## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/billing/detail/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "consumeTimeOfDay": "2023-07-31",
            "orgName": "None",
            "productName": "None",
            "productDetail": "Session Replay",
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