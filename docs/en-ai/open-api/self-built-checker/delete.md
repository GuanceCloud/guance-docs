# Delete a Smart Security Check

---

<br />**POST /api/v1/self_built_checker/delete**

## Overview
Delete a user-defined security check based on `checker_uuid`



## Body Request Parameters

| Parameter Name | Type   | Required | Description                              |
|:--------------|:-------|:--------|:----------------------------------------|
| ruleUUID      | string |         | UUID of the user-defined security check<br>Example: rul_xxxxx <br>Allow empty: False <br> |
| refKey        | string |         | Associated key of the user-defined security check<br>Example: xxx <br>Allow empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUID":"rule_xxx"}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0ABCD3FC-9441-4617-9301-A95299460890"
} 
```