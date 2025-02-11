# Delete Auto Discovery Configuration

---

<br />**POST /api/v1/issue_auto_discovery/\{cfg_uuid\}/delete**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:---------|:--------------------------|
| cfg_uuid      | string | Y        | Issue auto discovery configuration UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/iatdc_xxxxxx/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "17964357676421089304"
} 
```