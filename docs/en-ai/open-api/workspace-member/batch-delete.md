# Delete One or Multiple Members

---

<br />**POST /api/v1/workspace/member/batch_delete**

## Overview
Delete one or multiple members


## Body Request Parameters

| Parameter Name    | Type   | Required | Description              |
|:-------------|:-----|:------|:----------------|
| accountUUIDs | array | Y | List of accounts<br>Example: ['xxx', 'xxx'] <br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member/batch_delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accountUUIDs": ["acnt_xxxx32"]}' \
--compressed 
```


## Response
```shell
{
    "code": 200,
    "content": null,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-598B9B3D-B612-49F2-B3A9-92013D91BB0D"
} 
```