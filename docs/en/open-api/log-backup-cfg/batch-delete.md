# Delete Data Forwarding Rules

---

<br />**POST /api/v1/log_backup_cfg/batch_delete**

## Overview
Delete data forwarding rules


## Body Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:---------|:-------------------------------------------------|
| cfgUUIDs      | array  | Y        | List of forwarding configuration UUIDs<br>Allow empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_backup_cfg/batch_delete' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"cfgUUIDs":["lgbp_xxxx32"]}' \
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
    "traceId": "15728475467540703196"
} 
```