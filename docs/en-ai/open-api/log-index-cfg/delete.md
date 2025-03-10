# Delete an Index/Unbind Index Configuration

---

<br />**POST /api/v1/log_index_cfg/delete**

## Overview
Delete an index/unbind index configuration


## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| cfgUUID | string | Y | Configuration UUID<br>Allow empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_index_cfg/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"cfgUUID":"lgim_xxxx32"}' \
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
    "traceId": "TRACE-63EE56F5-8EFB-4FF9-994D-11868B6EFA80"
} 
```