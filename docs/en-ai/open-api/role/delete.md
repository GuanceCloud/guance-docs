# Delete Role

---

<br />**POST /api/v1/role/\{role_uuid\}/delete**

## Overview
Delete a role



## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| role_uuid | string | Y | Role UUID<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/role/role_xxxx32/delete' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-77A06A58-BAA1-4880-8005-9987B28B8A7E"
} 
```