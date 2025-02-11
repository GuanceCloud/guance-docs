# Delete SourceMap

---

<br />**POST /api/v1/rum_sourcemap/delete**

## Overview
Delete an existing sourcemap for a specified application



## Body Request Parameters

| Parameter Name | Type   | Required | Description                             |
|:--------------|:-------|:--------|:---------------------------------------|
| appId         | string | Y       | appId<br>Can be empty: False <br>      |
| version       | string |         | Version<br>Can be empty: False <br>Can be an empty string: True <br> |
| env           | string |         | Environment<br>Can be empty: False <br>Can be an empty string: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_sourcemap/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{\n "appId": "app_demo",\n "version": "1.0.2",\n "env": "daily"\n}' \
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
    "traceId": "TRACE-50B4B62F-9593-4C4D-9E8D-DBAB3FB31489"
} 
```