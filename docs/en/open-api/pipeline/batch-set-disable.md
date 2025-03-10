# Enable/Disable Pipeline Rules

---

<br />**POST /api/v1/pipeline/batch_set_disable**

## Overview
Enable/Disable Pipeline rules


## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | Set the enabled status<br>Nullable: False <br> |
| plUUIDs | array | Y | UUID of the pipeline<br>Nullable: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/pipeline/batch_set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"plUUIDs":["pl_xxxx32","pl_xxxx32"],"isDisable":false}' \
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
    "traceId": "TRACE-F15D7D75-6D0C-4EAF-A91D-3ECB12481AF8"
} 
```