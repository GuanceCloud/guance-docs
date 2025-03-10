# Delete

---

<br />**POST /api/v1/data_mask_rule/delete**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| dataMaskRuleUUIDs    | array    | Y          | List of sensitive data masking rule UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_mask_rule/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"dataMaskRuleUUIDs": ["wdmk_xxx"]}'
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
    "traceId": "TRACE-F1E87701-EE20-4064-8CA8-7B14D27C4DC6"
} 
```