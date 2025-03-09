# Enable/Disable Index Configuration

---

<br />**POST /api/v1/log_index_cfg/{cfg_uuid}/set_disable**

## Overview
Enable/disable the default storage index configuration


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Configuration UUID<br> |


## Body Request Parameters

| Parameter Name | Type      | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | Whether to disable<br>Allow null: True <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/lgim_xxxx32/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"isDisable":true}' \
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
    "traceId": "TRACE-E57E5209-594B-4AF4-BE7C-5C174B22FD82"
} 
```