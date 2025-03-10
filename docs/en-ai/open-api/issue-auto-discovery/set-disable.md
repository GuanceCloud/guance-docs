# Disable/Enable Auto Discovery Configuration

---

<br />**POST /api/v1/issue_auto_discovery/\{cfg_uuid\}/set_disable**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description                         |
|:--------------|:-------|:--------|:------------------------------------|
| cfg_uuid      | string | Y       | UUID of the Issue auto discovery configuration<br> |


## Body Request Parameters

| Parameter Name | Type      | Required | Description                                      |
|:--------------|:---------|:--------|:-------------------------------------------------|
| isDisable     | boolean  | Y       | Set the enable status<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue_auto_discovery/iatdc_xxxxxx/set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"isDisable": false}' \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "17964357676421089303"
} 
```