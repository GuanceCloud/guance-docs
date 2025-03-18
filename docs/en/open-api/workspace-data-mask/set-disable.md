# Enable/Disable

---

<br />**POST /api/v1/data_mask_rule/set_disable**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| isDisable            | boolean  | Y        | Set the enable status<br>Allow null: False <br> |
| dataMaskRuleUUIDs    | array    | Y        | List of sensitive data masking rule UUIDs<br>Allow null: False <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_mask_rule/set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"isDisable": false,"dataMaskRuleUUIDs": ["wdmk_xxx"]}'
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
    "traceId": "TRACE-953C271A-768B-4123-9B7C-3DC552B1B621"
} 
```